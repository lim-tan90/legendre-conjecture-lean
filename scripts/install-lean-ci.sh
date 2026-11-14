#!/usr/bin/env bash
# Install exactly lean-toolchain from official release assets, checking GitHub's digest.
set -euo pipefail

: "${RUNNER_TEMP:?CI temporary directory is required}"
: "${GITHUB_PATH:?CI path file is required}"
toolchain="$(cat lean-toolchain)"
case "$toolchain" in
  leanprover/lean4:v*) version="${toolchain#leanprover/lean4:v}" ;;
  *) echo "Unsupported toolchain: $toolchain" >&2; exit 1 ;;
esac

# GitHub's release API is rate limited per source IP when unauthenticated. CI
# passes the workflow token so the limit is per token instead; otherwise a
# shared runner IP can intermittently receive HTTP 403 (curl exit code 22).
auth_args=()
if [[ -n "${LEAN_CI_GITHUB_TOKEN:-}" ]]; then
  auth_args=(--header "Authorization: Bearer ${LEAN_CI_GITHUB_TOKEN}")
fi

fetch_release() {
  curl --fail --silent --show-error --location --connect-timeout 30 \
    --retry 3 --retry-all-errors --retry-delay 5 \
    ${auth_args[@]+"${auth_args[@]}"} \
    "https://api.github.com/repos/leanprover/lean4/releases/tags/v${version}" \
    --output "$RUNNER_TEMP/lean-release.json"
}

fetched=false
for attempt in 1 2 3; do
  if fetch_release; then
    fetched=true
    break
  fi
  echo "::warning::Could not fetch Lean release metadata (attempt ${attempt}/3)"
  sleep $((attempt * 10))
done
if [[ "$fetched" != true ]]; then
  echo "::error::Failed to fetch Lean release metadata for v${version}"
  exit 1
fi

python3 - "$version" "$RUNNER_TEMP" <<'PY'
import json
import re
import sys
from pathlib import Path

version, temp = sys.argv[1], Path(sys.argv[2])
release = json.loads((temp / "lean-release.json").read_text())
assert release["tag_name"] == f"v{version}"
asset, = [a for a in release["assets"] if a["name"] == f"lean-{version}-linux.tar.zst"]
assert re.fullmatch(r"https://api.github.com/repos/leanprover/lean4/releases/assets/[0-9]+", asset["url"])
assert asset["browser_download_url"] == f"https://github.com/leanprover/lean4/releases/download/v{version}/lean-{version}-linux.tar.zst"
assert re.fullmatch(r"sha256:[0-9a-f]{64}", asset["digest"])
(temp / "lean-asset.txt").write_text(asset["url"] + "\n" + asset["browser_download_url"] + "\n")
(temp / "lean.sha256").write_text(asset["digest"].split(":", 1)[1] + "  " + str(temp / "lean.tar.zst") + "\n")
PY

mapfile -t asset_urls < "$RUNNER_TEMP/lean-asset.txt"
# The asset API avoids the intermittent 504 from the releases.lean-lang.org redirect.
fetch_asset() {
  rm -f "$RUNNER_TEMP/lean.tar.zst"
  if curl --fail --silent --show-error --location --connect-timeout 30 \
    --retry 3 --retry-all-errors --retry-delay 5 \
    ${auth_args[@]+"${auth_args[@]}"} \
    --header 'Accept: application/octet-stream' "${asset_urls[0]}" \
    --output "$RUNNER_TEMP/lean.tar.zst"; then
    return 0
  fi
  curl --fail --silent --show-error --location --connect-timeout 30 \
    --retry 3 --retry-all-errors --retry-delay 5 \
    ${auth_args[@]+"${auth_args[@]}"} \
    "${asset_urls[1]}?download=1" --output "$RUNNER_TEMP/lean.tar.zst"
}

downloaded=false
for attempt in 1 2 3; do
  if fetch_asset; then
    downloaded=true
    break
  fi
  echo "::warning::Could not download Lean archive (attempt ${attempt}/3)"
  sleep $((attempt * 10))
done
if [[ "$downloaded" != true ]]; then
  echo "::error::Failed to download Lean v${version} archive"
  exit 1
fi

sha256sum --check "$RUNNER_TEMP/lean.sha256"
tar --zstd -xf "$RUNNER_TEMP/lean.tar.zst" -C "$RUNNER_TEMP"
echo "$RUNNER_TEMP/lean-${version}-linux/bin" >> "$GITHUB_PATH"
"$RUNNER_TEMP/lean-${version}-linux/bin/lean" --version
"$RUNNER_TEMP/lean-${version}-linux/bin/lake" --version
