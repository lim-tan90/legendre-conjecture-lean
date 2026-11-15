# Guth--Maynard Poisson and cubic trace estimates (2026-11-15)

Write M for the actual cutoff sampling matrix, G=M M* for its Gram matrix,
R=card(W), and I=integral w(x)^2 dx for the real mass of the fixed smooth
cutoff. Every Fourier coefficient below is the transform of the actual smooth
kernel w(x)^2 exp(it log x), rather than an abstract function satisfying
assumed estimates.

## Completed estimates

* `TracePoisson.lean` proves the exact Poisson formula, absolute summability,
  finite primal-lattice restriction and the zero-frequency Mellin formula.
  For every fixed A and J>=1, one K>0 works for all N>0 and R<=N^A:
  `norm(trace(G)-N*R*I) <= K/N^J`. This includes Lemma 4.4's N^-100 error.
* `TraceReflection.lean` proves uniform two-parameter Fourier decay:
  `abs(xi)^q * norm(hhat_t(xi)) <= C_q*(1+abs(t))^q`, and arbitrary-order
  decay of the zero Fourier coefficient in t. It also proves exact signed
  finite-mode Mellin reflection and a cancellation-preserving dual-polynomial
  integral bound. The latter retains the norm of the sum over modes; no
  mode-count factor is inserted. The complete-mode bound is proved separately in `QuantitativeReflection.lean`.
* `CubicTrace.lean` proves the exact absolutely summable cubic Poisson
  expansion and the split into the all-zero mode and S1/S2/S3 (one, two and
  three nonzero frequencies). With T^epsilon-separated W in [0,T], epsilon>0,
  `N<=T<=N^2` and T>=1, Proposition 5.1's `norm(S1)<=K/T^10` is proved.
  The all-zero-mode contribution differs from `N^3*R*I^3` by at most
  `K/T^100` (without needing the upper restriction T<=N^2).
* `CubicRemainder.lean` is a local assembly of those estimates:
  `norm(trace(G^3)-N^3*R*I^3-S2-S3)<=K/T^10`
  throughout the same separation and scale window. Its constant is chosen
  before N, T and W. It covers the source scale T=N^(6/5).

* `PowerTail.lean` retains only two real-power integral lemmas from the
  source Type-II file. `QuantitativeReflection.lean` proves complete-frequency
  quantitative smooth reflection, including its use on the actual scaled tail.
  Put eta=min(epsilon/16,1/16), H=T^eta and
  M=ceil((1+abs(t))*H/N). For every A,epsilon>0, constants C>0,T_min>=1
  are chosen before all scales. If T>=T_min, 0<N<=T and
  T^epsilon<=T0<=abs(t)<=min(2T0,T), then
  `norm(tail_N(t)) <= N*C/sqrt(T0)*integral[-H,H] norm(sum[m=1..M] m^(-i(t+u))) du + C/T^A`.
  Both signs of t and the complete omitted-frequency and Mellin tails are
  controlled. This is a proved Lemma 6.2 input, not a moment estimate.
* `CubicTwoTail.lean` proves S2=3*first cyclic term and its exact
  diagonal/off-diagonal split. The off-diagonal term is O_epsilon(T^-10).
  The local assembly proves that the diagonal is exactly `N*I*Q`, where
  `Q=sum[t,u in W] norm(tail_N(t-u))^2`. Thus the actual cubic trace satisfies
  `norm(trace(G^3)-N^3*R*I^3-3*N*I*Q-S3)<=K/T^10`.

The independent closed comparisons are `GuthMaynardFirstTraceBenchmark`,
`GuthMaynardUniformFourierBenchmark` `GuthMaynardCubicRemainderBenchmark`, `GuthMaynardCompleteReflectionBenchmark`
and `GuthMaynardCubicMomentBenchmark`.
They retain the real cutoff integral, actual matrix, distance/interval
hypotheses, powers and quantifier order. They are included in the generated
Layer 4 literature consumer. Ordinary imports of `Legendre.Layer4` suffice.

## Remaining work and provenance

The Heath--Brown bound for Q, the resulting full S2 bound, the S3 bound and
central density input on (7/10,4/5) remain open. Complete smooth reflection
and the negligible S2 off-diagonal contribution do not supply those remaining
moment estimates. No new prime-gap
exponent is claimed.

Twelve modules in `Legendre/Layer4/GuthMaynard/` now adapt the pinned MIT-0
smccolm/Lean sources; `CubicRemainder.lean` is the local assembly. The new
source mapping is in [the provenance record](smccolm-guth-provenance.md) and
under source #5 in both READMEs. Every adapted module is built from source
with Lean/mathlib 4.35.0.

Poisson/reflection/cubic validation (2026-11-15): the complete build passes
4,332 jobs under Lean 4.35.0. All 5,180 project theorem declarations,
including every private/generated declaration, agree exactly between the
module-data inventory, independent environment ownership inventory, audit
targets and parsed axiom output. Only propext, Classical.choice and Quot.sound
occur. All 334 classified Lean files are free of executable placeholders and
prohibited shortcuts, including Layers 0--4. All 199 independent consumers pass
(154 Layer 4, nine Layer 3, 24 generated literature and 12 literature regressions).
Three additional negative contract checks reject confusing reflection with
central density, dropping the Fourier ordinate factor and removing the cubic
scale window. Both READMEs retain five numbered repository headings with
individually expandable default-open details. The exact upstream MIT-0 license
blob remains 34f468585a9582c8a1d0f9440b6c0f8b5f98f2e8.
