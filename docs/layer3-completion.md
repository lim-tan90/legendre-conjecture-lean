# Layer 3 completion and downstream interface

Layer 3 meets the acceptance criteria in
[the formalization roadmap](formalization-roadmap.md#layer-3--prime-counting-and-pnt-with-error-term).
Its scope is the classical PNT error, partial summation, Perron inversion and
a finite multiplicity-weighted explicit formula with a proved remainder.
The original four acceptance criteria have not been broadened or weakened.
The 2026-11-07 completion adds a downstream prime-interval theorem and formal
asymptotic comparisons, exposed by `import Legendre.Layer3`.

## Acceptance evidence

| Requirement | Checked interface |
|---|---|
| ψ(x)=x+O(x exp(−c√log x)), c>0 | `Legendre.PNT.psi_classical_error` |
| π(x)=Li₂(x)+O(x exp(−c√log x)), Li₂ starts at 2 | `Legendre.PNT.pnt_classical_error` |
| Classical de la Vallée Poussin scale and its limitations | `classicalError_isLittleO`, `rpow_isLittleO_classicalError`, `classicalError_not_isBigO_rpow` |
| Audited analytic dependencies and bridges | `Legendre/Audit.lean`; exhaustive checks for selected PNT+, downstream and generated theorem declarations |

The broader documented scope is also implemented: `primeCount`, mathlib ψ/θ,
`primeCount_sub_logarithmicIntegral`, `primeCount_error_of_theta`, Perron
inversion/error, the smoothed contour decomposition, and
`Legendre.Zeta.exists_truncated_explicit_formula`. The latter includes every
critical-strip zero through the selected absolute height, with analytic
multiplicity, and retains the proved contour-dependent remainder described
[in its exact statement](perron-explicit-formula.md).

## Prime intervals and gaps

`Legendre.PNT.pnt_hasPrimeIn_classical_interval` proves

`∃ c>0, ∃ X≥1, ∀ x≥X, ∃ p prime, x<p≤x+x exp(−c√log x)`.

The coefficient of the interval length is one. The positive decay constant
and threshold remain existential. `pnt_prime_gap_classical` supplies the
natural-number interface: above a natural threshold P, every prime p has a
larger prime q with `q−p≤p exp(−c√log p)`.

`layer3_pnt_package` chooses **one common c>0** for the ψ, θ and π−Li₂ error
bounds and the coefficient-one interval theorem. It also packages

`classicalError c = o(x)`,

`∀ a<1, x^a = o(classicalError c)`.

`classicalError_not_isBigO_rpow` proves that the error scale is not O(x^a)
for any a<1. This is a statement about the bound, not a statement denying
stronger prime-interval theorems.

## Proof of the interval transfer

Suppose both theta errors are bounded by C times E_c, where
`E_c(x)=x exp(−c√log x)`. For c≥0, x>0 and x≤y≤2x,

`E_c(y) ≤ 2 E_c(x)`.

Choose `y=x+(3C+1)E_c(x)`. Since E_c=o(x), eventually y≤2x and both
endpoints exceed the theta error threshold. Subtracting the two errors gives

`θ(y)−θ(x) ≥ (3C+1)E_c(x)−3C E_c(x) = E_c(x)>0`.

The proved Chebyshev bridge produces a prime in (x,y]. Decreasing c to c/2
absorbs the coefficient 3C+1 because `exp((c/2)√log x)` tends to infinity.
The same weakening of c preserves all three classical PNT error bounds.
No new analytic or external-code assumption is introduced.

For any ε>0, `eventually_hasPrimeIn_relative` also proves that every
sufficiently large (x,x+εx] contains a prime. The prime-gap interface asserts
existence of a larger prime; it does not introduce a separate next-prime
function or depend on an unproved prime-gap hypothesis.

## Scope beyond completion

The full-boundary uniform logarithmic remainder remains an **optional
strengthening** of the finite explicit formula. The good-height estimate
currently covers the horizontal parts with Re(s)≥7/8; it does not bound the
entire left portion of the rectangle. See
[the quantitative good-height limits](zeta-good-heights.md).

Layer 4 zero-density estimates, Layer 5 fixed polynomial short-interval
exponents, numerical Dusart constants, and Legendre's conjecture remain
outside the completed Layer 3 scope. The new sublinear intervals do not
prove those results. Work on the remaining left contour may continue as an
explicit-formula refinement without keeping the original Layer 3 acceptance
status open.

## Provenance

`PrimeIntervals.lean` and `Layer3.lean` contain original downstream deductions
using the already attributed PNT+ slice and mathlib v4.35.0. No additional
third-party code, package dependency, or lockfile change is introduced.
Upstream issue/PR communication remains assigned separately by the repository
owner.

## Completion validation (2026-11-07)

Full `lake build` passed **4,039 jobs**. The immediately following
`python3 scripts/audit.py --skip-build` passed **all 2,552 expected targets**.
Enumerating the full theorem declarations of `PrimeIntervals.lean` and
`Layer3.lean` yielded 13 new targets, all included in the audit.
A second, exhaustive enumeration covered all 2,552 project theorem declarations.
It added 619 previously unlisted declarations and removed 55 duplicate
short-name checks. The final parsed axiom output matches all 2,552 declarations
exactly, including private/generated helpers and the five consumer checks.
Only `propext`, `Classical.choice`, and `Quot.sound` occur. Source-token and
no-PDF checks passed; the Lean/mathlib pins and dependency lockfile are
unchanged. The completion uses the existing `review → master` workflow.

Verified proof commit: [`1ecc73ba2191`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/1ecc73ba2191cfda7f997b27a12a2046b28e3cbc).

## Additional verification

The standalone consumer module `Legendre/Tests/Layer3.lean` imports only
`Legendre.Layer3` with a normal import and checks five downstream uses:

1. The same decay constant is available for theta error and prime intervals.
2. A concrete one-percent relative interval has the correct strict lower and
   closed upper endpoints.
3. Natural-number prime ordering and real-valued gap bounds work together.
4. The exponent 9999/10000 satisfies both little-o and non-big-O comparisons.
5. The finite explicit formula is re-exported independently of the PNT package.

It is checked both as a compiled module and by the standalone command
`lake env lean Legendre/Tests/Layer3.lean`. The latter is an explicit CI step.
The test declarations are included in the main axiom audit.

The placeholder scan covers all 70 project Lean files, including Layer 0–3
and the adapted PNT+ sources. After removing comments and strings it finds
**zero** occurrences of `sorry`, `admit`, or `sorryAx`. The five raw-text
matches occur in explanatory comments. The general forbidden-source scan also
passes. For imported mathlib dependencies, the audited theorem dependency
closures contain only the three standard axioms, excluding `sorryAx` there
as well.
