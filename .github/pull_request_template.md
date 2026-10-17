# Pull request

## What does this change?

<!-- One paragraph.  Which literature step / Lean declaration does it touch? -->

## Checklist

- [ ] I targeted the `review` branch, not `master`.
- [ ] `lake build` succeeds locally.
- [ ] `python3 scripts/audit.py` succeeds.
- [ ] No `sorry`, `admit`, `axiom`, `constant`, `opaque`, `unsafe`, `False.elim`,
      `absurd`, or `nomatch` was added.
- [ ] If a new theorem was added, it has a `#print axioms` entry in
      `Legendre/Audit.lean`.
- [ ] I updated `docs/proof-map.md` and the progress table in `README.md`.
- [ ] I did not upload any PDF or long verbatim excerpt of a copyrighted paper.
- [ ] If this is a statement-only `Prop`, it is clearly marked as NOT proved.

## Evidence / references

<!-- DOI, arXiv, publisher page.  No PDFs. -->
