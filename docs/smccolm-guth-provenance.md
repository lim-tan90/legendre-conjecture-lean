# McColm finite Guth--Maynard sampling ports

Upstream: https://github.com/smccolm/Lean

Fixed commit: `4c8fb7f7816508825089230e3730b69165e5e303`.
The original files are under
`Riemann Zeta/9. Zero Density, Large Values and Prime Transfer/71 Guth-Maynard, 2026/GuthMaynard/`.
The upstream MIT-0 license is retained verbatim in
[`licenses/smccolm-Lean-MIT-0.txt`](../licenses/smccolm-Lean-MIT-0.txt).
The original copyright is 2026 S. McColm. Each adapted module records the
source, commit, source filename, license and local changes in its header.

| Upstream file | Destination under `Legendre/Layer4/GuthMaynard/` | Scope |
|---|---|---|
| `DirichletPolynomial.lean` | `Polynomial.lean` | Actual dyadic polynomials, exact closed/half-open endpoint bridge, phase conjugation and normalized coefficients |
| `LargeValuesDefinitions.lean` | `Definitions.lean` | Nonempty smooth cutoff, actual sampling entries, exponential sum and closed-tolerance additive energy |
| `LargeValuesMatrix.lean` | `SamplingMatrix.lean` | Matrix action, coefficient/sample energies, L2 operator norm, actual Gram kernel and spectral trace identities |
| `TraceDispersion.lean` | `TraceDispersion.lean` | Finite Jensen inequality, sixth-moment alternatives and the sampling singular-value/operator-norm bounds |
| `LargeValuesPoisson.lean`: `gmMatrix_gram_trace_eq_cutoff_sum` | `SamplingDispersion.lean` | Selected finite first-trace identity only |
| `LargeValuesFinal.lean`: cutoff column mass, first spectral moment, dispersion nonnegativity and `gm_largeValues_raw_dispersion` | `SamplingDispersion.lean` | Selected finite count only; the Poisson/off-diagonal estimates and final Theorem 1.1 assembly are not imported |

## Lean 4.35.0 adaptation

Every destination is compiled from source with the repository's pinned
`leanprover/lean4:v4.35.0`, against its pinned mathlib. No upstream compiled
artifacts are used. Adaptations include modern `module` visibility with
public imports/sections; the namespace becomes `Legendre.Density.GuthMaynard`.
The existing attributed `Legendre.PNT.SmoothExistence` supplies the cutoff.
`Polynomial.lean` removes the unrelated PNat-polynomial compatibility theorem
and its standalone dependency, and updates deprecated basic imports and if lemmas.

Complex conjugation explicitly identifies `star` with `starRingEnd` before
using `cpow_conj`; spectral calculations explicitly identify the RCLike real
embedding with `Complex.ofReal`. The coefficient-energy cardinality proof
uses `Fintype.card_of_subtype` and the exact dyadic cardinality, rather than
relying on hidden unfolding of the finite-column instance. All these changes
preserve the statements. The full project checks also compile every private
and generated theorem used by the adapted files.

## Local additions and exact limits

The local coefficient-energy extension permits arbitrary coefficients and
retains their actual energy cubed. A proved equality rewrites spectral
centering as the literal real part of the cubic Gram trace minus the cube
of its first trace divided by the squared row count. The independently typed
`GuthMaynardSamplingTraceBenchmark` retains the actual finite polynomial,
coefficient energy and traces; `layer4_guth_sampling_trace_comparator` is closed.

The source cutoff equals one on [6/5,9/5] and has support in [1,2]. Matrix
columns are (N,2N]; the printed paper's closed sum has a separate exact
left-endpoint term. Approximate energy in `Definitions.lean` uses <= eta,
so it is not silently identified with the paper's strict <1 convention.
The finite matrix bounds need no ordinate separation; a future analytic
large-value estimate must retain its additional separation and height conditions.

Only these five destination modules are ported. The much larger candidate
analytic dependency chain was inspected outside the repository and is not
part of this port. The central Guth--Maynard density estimate, analytic
Poisson/off-diagonal trace estimates and prime-gap transmission remain open.

Sampling-trace validation (2026-11-15): all five ported modules and their
consumers compile from source under Lean 4.35.0 (commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc).
The full build passes 4,324 jobs. All 4,787 project theorem declarations,
including private/generated declarations from every port, match the two
independent inventories, audit targets and actual axiom output exactly.
Only propext, Classical.choice and Quot.sound occur. All 326 classified
Lean sources have no executable placeholders or prohibited shortcuts.
All 186 consumers pass (141 Layer 4, nine Layer 3, 36 literature). New
consumers cover a nonzero matrix plateau, the literal left endpoint, a flat
spectrum and negative reciprocal arguments. Lean rejects dropping the
average branch or using the finite count as the open central density input.
The retained MIT-0 license has the exact upstream Git blob hash
34f468585a9582c8a1d0f9440b6c0f8b5f98f2e8.
