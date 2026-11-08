# Layer 4: initial mean-value and density infrastructure

The public interface is `import Legendre.Layer4`. This is **partial progress**
on Layer 4: an elementary quantitative mean-square theorem, a continuous
large-value measure estimate, a uniform density-exponent convention and a
near-one count are proved. The later [large-sieve and separated-sampling
slice](layer4-large-sieve.md) adds finite additive large sieve, actual separated
samples and weighted zero selection. Ingham's and Huxley's density theorems
remain open. The subsequent [linear mean-square theorem](layer4-linear-mean-value.md)
strengthens the error to O(N); this page retains the initial harmonic theorem.

## Dirichlet-polynomial mean square

For any natural N, any coefficients a:ℕ→ℂ and any real A,B, put

```text
P(t) = Σ_{1≤n≤N} a(n)n^(−it),
E = Σ_{1≤n≤N} |a(n)|²,       H_N = Σ_{1≤n≤N} 1/n.
```

`abs_integral_dirichletPolynomial_sub_diagonal_le` proves

```text
|∫_A^B |P(t)|² dt − (B−A)E| ≤ 4 N H_N E.
```

The constant is explicit and uniform in N, the coefficients and both
endpoints. Empty support N=0 and the frequency-zero n=1 term are included.
Since H_N≤1+log N, the error is at most `4N(1+log N)E`.
`integral_dirichletPolynomial_norm_sq_le` exposes the resulting upper bound
`(B−A+4N(1+log N))E`. For fixed N and a,
`tendsto_dirichletPolynomial_mean_square` proves

```text
(1/T) ∫_0^T |P(t)|² dt → E   as T→∞.
```

This elementary error is **O(N log N)**, rather than the sharper O(N)
Montgomery–Vaughan mean-value theorem. No such stronger estimate is used.
The coefficients can include fixed real-part weights for applications on a
vertical line; they remain arbitrary complex numbers in these theorems.

## Proof of cancellation and length dependence

For arbitrary finite real frequencies ν(n), the phase is
`realPhase ν t = exp(i t ν)`. The exact Gram-matrix identity integrates

```text
|Σ a(n)exp(i t ν(n))|²
  = Σ_m Σ_n a(m)conj(a(n)) exp(i t(ν(m)−ν(n))).
```

The zero-frequency integral is exactly B−A. For u≠0,

```text
∫_A^B exp(i t u) dt = [exp(i B u)−exp(i A u)]/(iu),
|∫_A^B exp(i t u) dt| ≤ 2/|u|.
```

All phase integrability hypotheses are proved by continuity. The exact
identity permits coincident frequencies, retaining their cross terms.
The cancellation inequality explicitly requires injectivity of ν on the
finite support. It does not discard coincident off-diagonal frequencies.

For ν(n)=−log n, positive integer indices give injective frequencies, and
for distinct m,n≤N:

```text
1/|log m−log n| ≤ N/|m−n|,
Σ_{n≤N,n≠m} 1/|m−n| ≤ 2H_N.
```

The second inequality injects the gaps on each side of m into {1,…,N}.
Consequently each reciprocal-frequency row is at most 2NH_N.
The elementary inequality `2|a(m)||a(n)|≤|a(m)|²+|a(n)|²`, symmetry and this
row bound yield the displayed `4NH_NE` error.

## Continuous large values

For A≤B and V>0, `dirichlet_large_values_measure_le` proves

```text
meas{t∈(A,B] : |P(t)|≥V}
  ≤ (B−A+4N(1+log N))E / V².
```

The formal statement uses `(volume.restrict (Ioc A B)).real` for this
Lebesgue measure. The set is measurable by continuity, and the restricted
measure is finite. Markov's inequality is applied to the genuinely
integrable nonnegative function |P|²; the threshold equality is included.
This is a continuous-time measure estimate. Counting large values at
separated sampling points needs additional control and is not inferred.

## Density-exponent convention

The existing `Legendre.Zeta.zeroDensityCount σ T` counts analytic
multiplicities with `0<Re(ρ)<1`, `0<Im(ρ)≤T`, `σ≤Re(ρ)`.
The new Prop `Legendre.Zeta.HasZeroDensityEstimate b` means

```text
∀ ε>0, ∃ C>0, ∀ σ∈[1/2,1], ∀ T≥2,
  N(σ,T) ≤ C T^(b(1−σ)+ε).
```

C is chosen before σ and T, and ε is **additive in the power of T**.
The definition does not assert any particular density exponent.
`HasZeroDensityEstimate.mono` permits weakening a proved b to a larger d.

`exists_log_pow_le_rpow` proves, for every natural k and ε>0, a single
D>0 works for all T≥2 in `(log T)^k≤D T^ε`. For k>0 the proof uses
δ=ε/k and D=δ^(−k); k=0 uses D=1.
`hasZeroDensityEstimate_of_log_bound` then transfers a **hypothesized**
uniform bound `N(σ,T)≤C T^(b(1−σ))(log T)^k` to the exponent interface.
The analytic bound is an explicit theorem hypothesis, not an axiom or an
asserted Ingham/Huxley result.

## Unconditional near-one count

The already proved logarithmic zero-free region gives, for T≥3,

```text
σ > 1−c/log T  ⇒  N(σ,T)≤N(σ,3),
c = zetaZeroFreeConstant > 0.
```

Indeed, any counted zero with Im(ρ)≥3 would violate the effective region
at its own ordinate. The rational-constant corollary is

```text
N(1−1/(4000000 log T),T) ≤ N(3).
```

N(3) is the fixed finite low-height multiplicity count; its numerical value
is not evaluated here. This near-one consequence of the zero-free region
is not an Ingham or Huxley power-saving density estimate on a fixed strip.

## Source map and provenance

| Module | Verified content |
|---|---|
| [ExponentialKernel](../Legendre/ExponentialKernel.lean) | Unit phases, exact diagonal and endpoint-independent off-diagonal integral bound |
| [ExponentialMeanValue](../Legendre/ExponentialMeanValue.lean) | Exact double-sum identity, diagonal separation, explicit error, Schur energy bound and limiting mean |
| [DirichletSpacing](../Legendre/DirichletSpacing.lean) | Reciprocal logarithmic gaps, two gap injections and harmonic row bounds |
| [DirichletMeanValue](../Legendre/DirichletMeanValue.lean) | Usual complex-power convention, arbitrary complex coefficients, explicit 4NH_N error and average limit |
| [DirichletLargeValues](../Legendre/DirichletLargeValues.lean) | Positive-threshold continuous large-value measure bounds |
| [ZeroDensity](../Legendre/ZeroDensity.lean) | Uniform exponent Prop, weakening/log-loss transfer and proved near-one bound |
| [Layer4](../Legendre/Layer4.lean) | Public import interface with partial-progress scope |
| [Tests/Layer4](../Legendre/Tests/Layer4.lean) | Nine independent consumers of the ordinary public import |

These are local deductions using the pinned mathlib v4.35.0 and existing
project interfaces. No additional PNT+ code, external proof port, package
or dependency-lock change is introduced. Mathlib's existing harmonic-sum
bound and exponential integral are invoked as library theorems.

## Initial validation (2026-11-08)

Verified proof commit: [`4f31d764b243`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/4f31d764b243f6a093dc9cbf34a677a5ad3bc17c).

Full `lake build`: **4,062 jobs**. The exhaustive audit covers **2,846 project
theorem declarations**, including all 90 public/private/generated targets
added in this slice. Independent module-data and full-environment enumerations
match the parsed audit output exactly. Only `propext`, `Classical.choice` and
`Quot.sound` occur.

All **93 project Lean files**, including Layer 0–4 and the existing PNT+
slice, have zero executable `sorry`, `admit` or `sorryAx`. The general
forbidden-source and no-PDF checks pass. Both consumer modules compile and
pass standalone source checks: nine Layer 4 cases and all nine Layer 3
regression cases. Both standalone checks are explicit CI steps.

The Layer 4 cases cover empty and singleton polynomials, a concrete two-term
error of 24, coincident frequencies, a translated interval containing
negative times with V=2, arbitrary complex-coefficient limiting means,
the rational near-one cutoff, absorption of log^44 into T^(1/100), and
conditional weakening from exponent 2 to 12/5.

## Next proof obligations

Separated-point sampling, the finite additive large sieve and a
multiplicity-preserving detector-to-density reduction are proved in the
[subsequent slice](layer4-large-sieve.md). The analytic detector estimates
needed for Ingham and Huxley remain open. The roadmap's Layer 4 acceptance
criteria are unchanged.
