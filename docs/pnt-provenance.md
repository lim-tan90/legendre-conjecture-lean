# Layer 3: PNT provenance and limits

The source is [AlexKontorovich/PrimeNumberTheoremAnd (PNT+)](https://github.com/AlexKontorovich/PrimeNumberTheoremAnd),
by Alex Kontorovich and contributors, pinned at
[`127b50e33f6033e2147921167a117af96d9ba4ea`](https://github.com/AlexKontorovich/PrimeNumberTheoremAnd/tree/127b50e33f6033e2147921167a117af96d9ba4ea).
Both projects use Lean and mathlib v4.35.0. The local mathlib commit remains
`56a005855ea17e0b0958f73ec801ae140b0a1679`; dependency pins and the lockfile
are unchanged. No Architect, leancert, PrimeCert, or checkdecls dependency
was added.

## Selected source slice

The original Layer 3 slice adapts the following 14 modules. Paths below are relative to
upstream `PrimeNumberTheoremAnd/` and local `Legendre/PNT/`, respectively.
Original contributor/copyright comments, where present, are retained.

| Upstream and local relative path | Role |
|---|---|
| `Auxiliary.lean` | complex holomorphy notation |
| `Sobolev.lean` | derivative and integrability estimates |
| `Fourier.lean` | Fourier bounds used by smoothing |
| `Mathlib/Algebra/Notation/Support.lean` | support notation compatibility |
| `SmoothExistence.lean` | existence of a nonnegative smooth averaging function |
| `MellinCalculus.lean` | smoothing and Mellin-transform bounds |
| `Rectangle.lean` | rectangular contour geometry |
| `ResidueCalcOnRectangles.lean` | Cauchy/residue calculations on rectangles |
| `EulerMaclaurin.lean` | Euler summation |
| `Mathlib/Analysis/SpecialFunctions/Log/Basic.lean` | elementary logarithm extension |
| `ZetaBounds.lean` | analytic and zero-free-region inputs |
| `ZetaConj.lean` | conjugation symmetry |
| `MediumPNT.lean` | finite-height smoothed contours and general-strength PNT |
| `StrongPNT.lean` | logarithmic zero-free region and classical ψ error |

The Apache-2.0 license is retained verbatim at
[`licenses/PNTplus-Apache-2.0.txt`](../licenses/PNTplus-Apache-2.0.txt).
Each adapted source identifies the upstream path and revision. `NOTICE`
and both README reuse sections also record the port.

Changes to this slice:

- replace upstream imports by `Legendre.PNT.*`;
- add `module`, public imports and exposed public declarations;
- import the complex p-series API explicitly, rather than relying on private imports;
- remove Architect imports and blueprint-only attributes/commands; retain mathematical comments;
- express six valid nonzero contradictions without the downstream forbidden `absurd` token;
- replace two elaboration-sensitive interval rewrites by direct equivalent arguments.

The mathematical ψ proof is upstream's. In particular, the new implementation
is not claimed to deduce PNT from just the earlier local Layer 2 bounds.
The selected slice proves its own required analytic estimates.
No unproved declaration from `Wiener.lean`, `Consequences.lean`,
`IwaniecKowalskiCh1.lean` or IEANTN numerical tables is imported.

## New local error bridge

[`Legendre/PrimeNumberTheorem.lean`](../Legendre/PrimeNumberTheorem.lean)
defines

- `primeCount x = Nat.primeCounting floor(x)`;
- `logarithmicIntegral x = ∫₂ˣ dt/log t`;
- `classicalError c x = x exp(-c sqrt(log x))`.

`psi_classical_error` exposes PNT+'s `StrongPNT` in these conventions.
Mathlib's proved `ψ-θ=O(sqrt x)` and the eventual bound
`sqrt x ≤ classicalError c x` transfer it to θ without any assumption
of the Riemann hypothesis or simplicity of zeros.

The local theorem `primeCount_error_of_theta` proves the remaining transfer.
Abel summation gives the exact identity

`π(x)-Li₂(x) = (θ(x)-x)/log x + 2/log 2 + ∫₂ˣ (θ(t)-t)/(t log²t) dt`.

Choose a fixed a large enough that the θ error bound holds, log a≥1,
and sqrt(log a)≥2c. For f(x)=x exp(-c sqrt(log x)),

`f'(x)=exp(-c sqrt(log x))(1-c/(2sqrt(log x)))`

is at least half the exponential on [a,∞). Comparison with 2C f' bounds
the tail integral; the fixed integral from 2 to a is absorbed using f(x)≥1.
Every integral used in subtraction, splitting or comparison is first shown
integrable. The same c works for ψ, θ and π.

`pnt_classical_error` packages the three estimates, and
`pnt_eventual_bound` supplies one positive coefficient and a common threshold
for the ψ and π inequalities. These constants are existential: this is not
a numerical Dusart estimate. The logarithmic integral is the offset integral
from 2; no principal-value normalization at 1 is silently assumed.

## Contours and remaining scope

`exists_smoothed_truncated_formula` specializes the proved logarithmic
zero-free strip to the exact finite-height contour decomposition
`SmoothedChebyshev = main Mellin term + I₁-I₂+I₃₇+I₈+I₉`.
These include the tail terms, which are not silently discarded.
PNT+'s `SmoothedChebyshevPull2` further separates the central term into five
pieces, and `ZetaBoxEval` bounds the difference between the Mellin main term
and x. The original fixed-x Perron inversion and truncation-error results
in `Legendre/Perron*.lean` remain available.

The finite multiplicity-weighted zero-sum specialization is now proved in
`PerronResidues.lean`, `PerronRectangle.lean`, `PerronExplicit.lean`, and
`PerronExplicitBounds.lean`. These are new local proofs using the already
ported generic rectangle theorem. See [the exact formula and error bound](perron-explicit-formula.md).
That original interface retains contour-dependent a and M. The later
[`exists_full_truncated_explicit_formula`](perron-uniform-explicit-formula.md)
proves a uniform full-contour bound with fixed Re(s)=−1/8 and the evaluated
origin term −log(2π). Numerical error thresholds remain unclaimed.

## Comparison with the classical error

The proved rate is exactly the de la Vallée Poussin scale
`x exp(-c sqrt(log x))`, for some c>0, for both ψ and π.
`classicalError_isLittleO` proves this is o(x).
`rpow_isLittleO_classicalError` and `classicalError_not_isBigO_rpow` now formally
prove the comparison with every fixed sublinear power;
`pnt_hasPrimeIn_classical_interval` supplies the corresponding sublinear
prime-interval theorem.
For each fixed a<1, the logarithm of its ratio to x^a is
`(1-a)log x-c sqrt(log x)`, which tends to +∞.
Consequently the bound alone does not prove prime existence in intervals
of length x^a for fixed a<1, and does not supply an Ingham/Huxley/BHP exponent
or prove Legendre's conjecture.

## Validation and upstream communication

Initial zero-sum validation on 2026-11-01: full `lake build` passed **4,030 jobs**;
`python3 scripts/audit.py --skip-build` then passed all **1,918** expected
axiom targets (347 existing + 1,492 selected PNT/bridge declarations + 79 declarations
from the four zero-sum modules, including generated/private lemmas).
The skip-build flag reuses the immediately preceding successful full build.
Source-token and no-PDF checks also passed.
All selected theorem declarations, including private and generated lemmas, are listed in
`Legendre/Audit.lean`. The audit parser supports apostrophes and Unicode in
names so upstream primed/Greek names cannot fall outside the checks.

The repository owner is handling upstream communication separately. This
implementation task has not published an upstream issue or PR. Source commits,
modules, licenses and the local proof/port distinction above can be used in
that notification. No access token is stored in this repository.

The quantitative good-height extension consists of original local deductions,
with no further PNT+ modules or dependencies ported. See
[the precise horizontal estimates and remaining limits](zeta-good-heights.md).

Initial validation including that extension: full build passed 4,036 jobs and
the audit passed 1,970 targets (the previous 1,918 plus all 52 declarations
from the six good-height modules).

## Layer 3 completion (2026-11-07)

`PrimeIntervals.lean` and `Layer3.lean` add original downstream proofs of
classical-rate prime intervals, prime gaps, and formal scale comparisons.
No additional PNT+ files or dependencies were ported. The completed scope and
the subsequent uniform full-contour refinement are recorded in
[the acceptance report](layer3-completion.md).

Initial completion validation: full build passed 4,038 jobs and the audit passed all
1,983 targets (the prior 1,970 plus all 13 completion declarations).

The full-contour extension adds fifteen local proof modules, from
`ZetaEulerPrimitive.lean` through `PerronFullExplicit.lean`. These reuse the
existing local regularization and generic rectangle-residue infrastructure;
no further PNT+ code or dependency was ported. The previous left-contour gap
is closed, including the independently evaluated origin residue. See the
[module-by-module proof chain and exact bound](perron-uniform-explicit-formula.md).

Latest verification: full build passed 4,054 jobs; all nine standalone
consumer checks passed. An exhaustive Lean-environment enumeration and the
parsed audit output match exactly on all 2,756 project theorem declarations,
including private/generated helpers. All 85 project Lean files have zero
executable `sorry`, `admit` or `sorryAx`. Only the three standard axioms occur.

## Layer 4 addition: positive-half-plane digamma series

At the same fixed commit, the additional upstream
[`Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean`](https://github.com/AlexKontorovich/PrimeNumberTheoremAnd/blob/127b50e33f6033e2147921167a117af96d9ba4ea/PrimeNumberTheoremAnd/Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean)
is adapted to
[the corresponding local module](../Legendre/PNT/Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean).
The original copyright and author credit to Robby Sneiderman are retained.
The selected slice ends after `Complex.hasSum_digamma_of_re_pos` and includes
its Euler-logarithm convergence proof and inverse-square tail helpers. The
remaining continuation and growth theorems in that upstream file are omitted.
The retained license is still [PNTplus-Apache-2.0.txt](../licenses/PNTplus-Apache-2.0.txt);
both READMEs record the additional source. No dependency pin changes are required.

This extends the source inventory to fifteen PNT+ modules overall. The earlier
Layer 3 validation records above refer to its original fourteen-module slice.
This inventory is prepared for upstream communication by the agent selected
by the user; no additional upstream issue or PR has been posted by this work.
