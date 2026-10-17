#!/usr/bin/env python3
"""Audit the Legendre-Lean repository.

Checks:
  1. no `sorry` / `admit` / `axiom` / `constant` / `opaque` / `unsafe`
  2. no `False.elim` / `absurd` / `nomatch` shortcuts in project code
  3. every `#print axioms` theorem depends only on the three standard axioms
  4. no PDF files are present

Usage:
  python3 scripts/audit.py
  python3 scripts/audit.py --skip-build
  python3 scripts/audit.py --lakefile lakefile.local.toml --manifest .lake/local-manifest.json
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}

# Tokens that would let a "proof" be vacuous or trust the compiler blindly.
FORBIDDEN = [
    r"\bsorry\b",
    r"\badmit\b",
    r"\baxiom\b",
    r"\bconstant\b",
    r"\bopaque\b",
    r"\bunsafe\b",
    r"False\.elim",
    r"\babsurd\b",
    r"\bnomatch\b",
]
FORBIDDEN_RE = re.compile("|".join(f"(?:{p})" for p in FORBIDDEN))

SKIP_DIRS = {".lake", ".git", "node_modules", "__pycache__", ".dsh-acl-recovery"}


def strip_lean_comments_and_strings(text: str) -> str:
    """Replace comments and string contents with spaces, preserving newlines."""
    out: list[str] = []
    i = 0
    n = len(text)
    block_depth = 0
    in_line = False
    in_string = False
    escaped = False

    while i < n:
        c = text[i]
        nxt = text[i + 1] if i + 1 < n else ""

        if in_line:
            if c == "\n":
                in_line = False
                out.append("\n")
            else:
                out.append(" ")
            i += 1
            continue

        if in_string:
            if escaped:
                escaped = False
                out.append(" ")
            elif c == "\\":
                escaped = True
                out.append(" ")
            elif c == '"':
                in_string = False
                out.append('"')
            else:
                out.append(" ")
            i += 1
            continue

        if block_depth > 0:
            if c == "/" and nxt == "-":
                block_depth += 1
                out.append("  ")
                i += 2
                continue
            if c == "-" and nxt == "/":
                block_depth -= 1
                out.append("  ")
                i += 2
                continue
            out.append("\n" if c == "\n" else " ")
            i += 1
            continue

        if c == "/" and nxt == "-":
            block_depth = 1
            out.append("  ")
            i += 2
            continue
        if c == "-" and nxt == "-":
            in_line = True
            out.append("  ")
            i += 2
            continue
        if c == '"':
            in_string = True
            out.append('"')
            i += 1
            continue

        out.append(c)
        i += 1

    return "".join(out)


def run(cmd: list[str], *, check: bool = False) -> subprocess.CompletedProcess[str]:
    print("+", " ".join(cmd))
    return subprocess.run(
        cmd,
        cwd=ROOT,
        text=True,
        encoding="utf-8",
        errors="replace",
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=check,
    )


def check_sources() -> list[str]:
    errors: list[str] = []
    lean_files = [
        p
        for p in ROOT.rglob("*.lean")
        if not any(part in SKIP_DIRS for part in p.relative_to(ROOT).parts)
    ]
    if not lean_files:
        errors.append("no .lean files found")
    for path in sorted(lean_files):
        raw = path.read_text(encoding="utf-8", errors="replace")
        code = strip_lean_comments_and_strings(raw)
        for match in FORBIDDEN_RE.finditer(code):
            line = code.count("\n", 0, match.start()) + 1
            token = match.group(0)
            errors.append(f"{path.relative_to(ROOT)}:{line}: forbidden token `{token}`")
    return errors


def check_pdfs() -> list[str]:
    errors: list[str] = []
    for path in ROOT.rglob("*.pdf"):
        rel = path.relative_to(ROOT)
        if any(part in SKIP_DIRS for part in rel.parts):
            continue
        errors.append(f"PDF file present (must not be uploaded): {rel}")
    return errors


def expected_axiom_targets() -> list[str]:
    audit = ROOT / "Legendre" / "Audit.lean"
    text = audit.read_text(encoding="utf-8", errors="replace")
    return re.findall(r"#print axioms\s+([A-Za-z0-9_.]+)", text)


def parse_axiom_output(output: str) -> dict[str, set[str]]:
    # `info: file:line: 'Legendre.foo' depends on axioms: [propext, ...]`
    pattern = re.compile(
        r"'([^']+)'\s+depends on axioms:\s*\[(.*?)\]", re.DOTALL
    )
    found: dict[str, set[str]] = {}
    for name, body in pattern.findall(output):
        axioms = {piece.strip() for piece in body.split(",") if piece.strip()}
        found[name] = axioms
    return found


def check_axioms(lakefile: str, skip_build: bool) -> list[str]:
    errors: list[str] = []

    if not skip_build:
        build = run(["lake", "-f", lakefile, "build"])
        if build.returncode != 0:
            errors.append(f"`lake build` failed with exit code {build.returncode}")
            return errors
        if "declaration uses 'sorry'" in build.stdout:
            errors.append("build output reports a `sorry`")

    audit = run(["lake", "-f", lakefile, "env", "lean", "Legendre/Audit.lean"])
    if audit.returncode != 0:
        errors.append(
            f"`lake env lean Legendre/Audit.lean` failed with exit code "
            f"{audit.returncode}"
        )
        return errors

    output = audit.stdout
    if "sorryAx" in output:
        errors.append("axiom output mentions `sorryAx`")

    found = parse_axiom_output(output)
    expected = expected_axiom_targets()
    if not expected:
        errors.append("no `#print axioms` targets found in Legendre/Audit.lean")
        return errors

    for short_name in expected:
        matches = [
            name
            for name in found
            if name == short_name or name.endswith("." + short_name)
        ]
        if not matches:
            errors.append(f"missing `#print axioms` output for `{short_name}`")
            continue
        for name in matches:
            extra = found[name] - ALLOWED_AXIOMS
            if extra:
                errors.append(
                    f"`{name}` depends on non-whitelisted axioms: "
                    f"{sorted(extra)}"
                )

    # Guard against a parser change silently producing zero checks.
    if len(found) < len(expected) // 2:
        errors.append(
            f"parsed only {len(found)} axiom lines for {len(expected)} targets; "
            "refusing to trust the audit output"
        )

    print(f"\nParsed {len(found)} #print axioms entries, {len(expected)} expected.")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--lakefile", default="lakefile.toml")
    parser.add_argument(
        "--manifest",
        default=None,
        help="optional local manifest to swap in during the audit",
    )
    parser.add_argument("--skip-build", action="store_true")
    args = parser.parse_args()

    manifest_path = ROOT / "lake-manifest.json"
    backup: bytes | None = None
    if args.manifest:
        replacement = ROOT / args.manifest
        if not replacement.exists():
            print(f"error: manifest `{replacement}` does not exist", file=sys.stderr)
            return 2
        if manifest_path.exists():
            backup = manifest_path.read_bytes()
        shutil.copy2(replacement, manifest_path)

    try:
        errors: list[str] = []
        errors.extend(check_sources())
        errors.extend(check_pdfs())
        errors.extend(check_axioms(args.lakefile, args.skip_build))
    finally:
        if args.manifest:
            if backup is None:
                manifest_path.unlink(missing_ok=True)
            else:
                manifest_path.write_bytes(backup)

    if errors:
        print("\nAUDIT FAILED", file=sys.stderr)
        for err in errors:
            print(f"  - {err}", file=sys.stderr)
        return 1

    print("\nAUDIT OK: no sorry/admit/axiom/unsafe, no explosion shortcuts,")
    print("          only {propext, Classical.choice, Quot.sound}, no PDFs.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
