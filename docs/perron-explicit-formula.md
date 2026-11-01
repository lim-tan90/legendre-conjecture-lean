# Truncated explicit formula with multiplicity

The four modules `PerronResidues.lean`, `PerronRectangle.lean`,
`PerronExplicit.lean`, and `PerronExplicitBounds.lean` supply the remaining
Layer 3 zero-sum interface. They contain new local proofs against the existing
mathlib v4.35.0 and selected PNT+ modules; no further dependency is added.

## Exact theorem

For every H≥0 and σ>1, `Legendre.Zeta.exists_truncated_explicit_formula` proves
there exist T∈(H,H+1), a∈(0,1), and M≥0, chosen before x, such that for every
x>0 there is E∈ℂ satisfying

`ψ₀(x) = x − ∑_{ρ∈Z(T)} m(ρ) x^ρ/ρ + E`,

`|E| ≤ U(x,σ)/T + [MT/(πa)] x^a + [M(σ−a)/(πT)] max(x^a,x^σ)`.

Here:

- `Z(T) = {ρ : ζ(ρ)=0, 0<Re ρ<1, |Im ρ|≤T}` is the finite set
  `symmetricZeros T`, containing both signs of height;
- `m(ρ)=zeroMultiplicity ρ` is the finite analytic multiplicity;
- `ψ₀(x)=ψ(x)−Λ(x)/2` at positive integer x and ψ(x) elsewhere;
- `U(x,σ)=perronErrorUpper x σ` is the proved finite coefficient sum plus
  closed Dirichlet-tail majorant from `PerronError.lean`;
- M bounds `|ζ′/ζ|` on the boundary of the rectangle from a−iT to σ+iT.

T avoids every zero ordinate in absolute value. The strict cutoff a lies
below the real part of every zero in Z(T); hence the formula includes every
critical-strip zero of the selected height, including those left of 1/2.
M is proved finite by continuity on the compact zero-free boundary.
There is no Riemann-hypothesis assumption or simple-zero assumption.

## Proof interfaces

| Mathematical step | Theorem |
|---|---|
| General finite-order logarithmic residue equals analytic multiplicity | `tendsto_mul_logDeriv_of_analytic` |
| Kernel residue at a zero is −m(ρ)x^ρ/ρ | `residue_perronIntegrand_at_zero` |
| Main pole residue is x | `residue_perronIntegrand_one` |
| Logarithmic-derivative poles are simple even at multiple zeta zeros | `perronIntegrand_order_at_zero`, `perronIntegrand_simple_poles` |
| Finite two-sided zero set and strict positive real cutoff | `symmetricZeros_finite`, `exists_symmetricZeroCutoff` |
| Good height in every unit interval above H≥0 | `exists_good_zero_height` |
| Exactly the main pole and Z(T) lie in the rectangle | `perronRectangle_poles` |
| Residue theorem specialized to the weighted kernel | `perronRectangle_integral_eq` |
| Finite Perron integral equals main term minus zero sum plus three sides | `truncatedPerron_explicit` |
| Half-weighted ψ formula | `halfWeightedPsi_explicit` |
| Kernel integrability on all four sides | `perron_rectangleBorderIntegrable` |
| Quantitative bounds on the three retained sides | `norm_perron_left_le`, `norm_perron_horizontal_le` |
| Final error bound and unconditional existence package | `norm_truncatedExplicitError_le_boundary_bound`, `exists_truncated_explicit_formula` |

All names in the table belong to `Legendre.Zeta`.

The rectangle identity uses the proved PNT+ simple-pole residue theorem already
ported in `Legendre/PNT/ResidueCalcOnRectangles.lean`. Every hypothesis required
by its simple-pole limit definition is verified: the Perron kernel is
meromorphic, its actual poles in the rectangle form the finite set
`{1} ∪ Z(T)`, their orders are −1, and none is on the boundary.
The finite sum is established before replacing any residue sum.

The independently proved Perron error gives `|P(x,σ,T)−ψ₀(x)|≤U/T`.
The left side is bounded using `|s|≥a`, its length 2T and `|x^s|=x^a`.
Each horizontal side uses `|s|≥T`, length σ−a, and
`x^Re(s)≤max(x^a,x^σ)`. Normalization by 2πi gives the displayed factors.

## Quantitative good-height refinement

`PerronGoodHeight.lean` now proves `exists_truncated_explicit_formula_good_height`,
selecting T with a proved c/log H separation from every nontrivial zero ordinate
for H≥7. At such heights, the paired horizontal lines satisfy an explicit
C(log H)² logarithmic-derivative bound for Re(s)≥7/8, and their Perron pieces
have corresponding integral bounds with proved integrability. This does not
control the remaining left portion of the full zero-sum contour or replace M
in the displayed theorem. See [constants, proof and scope](zeta-good-heights.md).

## Quantitative limits

This is a finite zero-sum formula with a proved, explicitly displayed
contour-dependent remainder. The choices a and M depend on T (and M also on σ).
They are existential and not numerically certified. No assertion that
`M=O(log²T)`, no universal good-height error of the usual
`O(x log²(xT)/T + …)` shape, and no evaluated contribution from shifting past
0 or the trivial zeros is made. Those stronger refinements remain possible
follow-up work. The left edge here stays strictly to the right of 0.

The separate `Legendre.PNT.pnt_classical_error` theorem already proves the
classical de la Vallée Poussin rate for ψ, θ and π. It uses the PNT+ smoothing
proof, rather than deriving that rate from the coarse contour remainder above.
Neither result alone proves the polynomial short-interval exponent theorems
or Legendre's conjecture.

## Initial validation

On 2026-11-01 the full `lake build` passed 4,030 jobs, followed by
`python3 scripts/audit.py --skip-build` passing all 1,918 expected targets.
All 79 theorem declarations in these four modules, including private/generated
proof helpers, were added to the audit. Only the three standard axioms
`propext`, `Classical.choice`, and `Quot.sound` occur. Dependency pins and
the lockfile remain unchanged.
