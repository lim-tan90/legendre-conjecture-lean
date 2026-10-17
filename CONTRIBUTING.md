# Contributing

Thanks for helping with the formalization.

## Ground rules

1. **No `sorry`, `admit`, `axiom`, `constant`, `opaque`, or `unsafe`.**
   The audit in `scripts/audit.py` rejects them.
2. **No fake proofs by explosion.**  Do not introduce `False`, `False.elim`,
   `absurd`, or an inconsistent hypothesis to prove a theorem.  Conditional
   theorems are fine only when the hypothesis is a clearly documented open
   statement (as in `Legendre/Conditional.lean`).
3. **No PDFs and no long verbatim excerpts** of copyrighted papers.  Link to
   the publisher/arXiv instead.
4. **Update the progress table.**  Any new formalized step must be added to
   `docs/proof-map.md` and the table in `README.md`.
5. **Target the `review` branch**, never `master`.
6. **Record ported formalization code.**  If you port or adapt code from
   another project, add an entry to the "Reused and adapted formalizations"
   section of `README.md` (upstream URL, pinned commit, license, destination
   paths), retain the upstream license text, and keep the attribution in the
   adapted files.  This is required for every port, not only for Nagura.

## Local checks

```bash
lake exe cache get
lake build
python3 scripts/audit.py
```

On Windows:

```powershell
pwsh -File scripts/verify.ps1
```

## Adding a literature step

If you want to formalize a new paper's theorem:

1. Add the exact statement as a `Prop` — coarse conditional form in
   `Legendre/Conditional.lean`, and (for Layer 5 papers) the paper-exact
   constants, range and `+ε` convention in `Legendre/Layer5.lean`; see the
   `*Paper` definitions and their `*_iff` bridge theorems.
2. If you have a complete proof, put it in a new module and import it from
   `Legendre.lean`.
3. Add `#print axioms` for every new theorem in `Legendre/Audit.lean`.
4. Add the bibliographic row (with DOI/arXiv) to `docs/literature.md` and the
   proof map.
5. If the step ports or adapts external formalization code, record it in the
   "Reused and adapted formalizations" section of `README.md` (ground rule 6).
6. Open a PR to `review`.

## Style

* Follow mathlib naming and formatting conventions.
* Keep comments mathematically precise; do not describe an unproved statement
  as “proved”.
* Prefer small, composable lemmas over long tactic blocks.
