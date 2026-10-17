# Two-branch pull-request workflow

The repository uses two long-lived branches:

* `master` — verified and stable.  Only fast-forward/merge from `review` after a
  green audit.
* `review` — staging branch.  **All pull requests target `review`.**

## For contributors

1. Fork the repository and create a topic branch from `review`.
2. Make the change.  If you add a formalization step:
   * add the Lean declaration and a complete proof (no `sorry`);
   * add a row to `docs/proof-map.md`;
   * update the progress table in `README.md`;
   * do **not** add PDFs or long verbatim excerpts of copyrighted papers.
3. Run locally:

   ```bash
   lake exe cache get
   lake build
   python3 scripts/audit.py
   ```

4. Open a pull request **against `review`**, not `master`.

## For the maintainer / agent

When the repository owner sends an explicit instruction to merge a pull request:

1. Merge the pull request into `review` (merge commit or squash; do not touch
   `master` yet).
2. CI `.github/workflows/verify.yml` runs on `review` and must be green:
   * `lake build` succeeds;
   * `scripts/audit.py` reports no forbidden constructs and only the three
     standard axioms;
   * no PDFs are present.
3. If green, merge `review` into `master` and push.  Record the verified commit
   in `README.md` if the progress table changed.
4. If red, keep the change on `review`; fix or ask the contributor for a
   follow-up.  Never merge a red `review` into `master`.

## Why this order

The secondary branch is the quarantine area: a pull request may contain a
plausible-looking Lean file with `sorry`, a hidden `axiom`, or an inconsistent
hypothesis that makes everything provable.  The audit runs **before** anything
reaches `master`, so `master` always has a machine-checked clean history.

## Branch protection (recommended settings)

On GitHub:

* protect `master`: require pull request, require status check `verify`,
  disallow force pushes;
* protect `review`: require status check `verify`;
* set `review` as the default branch for pull requests (optional).

## Emergency fixes

If a red commit accidentally reaches `master`, revert it on `master` and open a
new PR to `review` with the fix; do not rewrite public history.
