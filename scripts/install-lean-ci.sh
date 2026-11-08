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

curl --fail --silent --show-error --location --retry 3 \
  "https://api.github.com/repos/leanprover/lean4/releases/tags/v${version}" \
  --output "$RUNNER_TEMP/lean-release.json"
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
if ! curl --fail --silent --show-error --location --retry 3 \
  --header 'Accept: application/octet-stream' "${asset_urls[0]}" \
  --output "$RUNNER_TEMP/lean.tar.zst"; then
  curl --fail --silent --show-error --location --retry 3 \
    "${asset_urls[1]}?download=1" --output "$RUNNER_TEMP/lean.tar.zst"
fi
sha256sum --check "$RUNNER_TEMP/lean.sha256"
tar --zstd -xf "$RUNNER_TEMP/lean.tar.zst" -C "$RUNNER_TEMP"
echo "$RUNNER_TEMP/lean-${version}-linux/bin" >> "$GITHUB_PATH"
"$RUNNER_TEMP/lean-${version}-linux/bin/lean" --version
"$RUNNER_TEMP/lean-${version}-linux/bin/lake" --version
