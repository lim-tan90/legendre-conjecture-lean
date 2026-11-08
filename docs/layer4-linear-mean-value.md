# Layer 4: linear mean-square error and optimized sampling

This extends the [finite large-sieve checkpoint](layer4-large-sieve.md).
All estimates below are proved in Lean. Ingham's and Huxley's zero-density
estimates remain open; the detector property below is an explicit hypothesis.

## Real-line Hilbert inequality

For a finite family of real frequencies xᵢ with |xᵢ−xⱼ|≥δ>0 for i≠j,
[ReciprocalHilbert.lean](../Legendre/ReciprocalHilbert.lean) proves

```
|Σᵢ Σⱼ conjugate(uᵢ) (xᵢ−xⱼ)⁻¹ uⱼ| ≤ (π/δ) Σᵢ |uᵢ|².
```

Lean uses inverse zero equal to zero, so the diagonal summands vanish.
The proof derives the reciprocal kernel's triple identity, the inverse-square
row bound π²/(3δ²), a bound for every Hermitian eigenvalue, and the resulting
operator-norm bound. It uses the attributed finite spectral arguments from
[openai/math](openai-math-provenance.md), generalized to the real line.
It does not assume Hilbert's inequality as an axiom or hypothesis.

## Mean-square cancellation

[SeparatedMeanValue.lean](../Legendre/SeparatedMeanValue.lean) rewrites the
integral exactly as its energy diagonal plus the difference of two twisted
Hilbert forms. For P(t)=Σ aᵢ exp(itxᵢ), the consequence is

```
|∫[A,B] |P(t)|² dt − (B−A) Σᵢ |aᵢ|²| ≤ (2π/δ) Σᵢ |aᵢ|².
```

There is no ordering assumption on A,B. Logarithmic frequencies −log n for
1≤n≤N are 1/N-separated. Consequently
[DirichletMeanValueSharp.lean](../Legendre/DirichletMeanValueSharp.lean) proves,
for P_N(t)=Σ[1≤n≤N] a(n)n^(−it) and E=Σ[1≤n≤N]|a(n)|²,

```
|∫[A,B] |P_N(t)|² dt − (B−A) E| ≤ 2πN E,
∫[A,B] |P_N(t)|² dt ≤ (B−A+2πN) E.
```

These hold for every natural N, including N=0. The previous harmonic bound
remains available under its original name. The new bound removes its
asymptotic log N loss, though it need not be numerically smaller at small N.

## Optimized discrete samples

[DirichletSamplingSharp.lean](../Legendre/DirichletSamplingSharp.lean) proves
weighted Young's inequality for the actual derivative of |P_N|², and applies
the proved Sobolev sampling lemma. Suppose sample times tᵢ are δ-separated,
L≤U and [tᵢ,tᵢ+δ]⊆[L,U]. For every w>0,

```
Σᵢ |P_N(tᵢ)|² ≤ (δ⁻¹+w+w⁻¹ log²N)(U−L+2πN) E.
```

For N>1 choose w=log N. The estimate becomes

```
Σᵢ |P_N(tᵢ)|² ≤ (δ⁻¹+2 log N)(U−L+2πN) E.
```

If each |P_N(tᵢ)|≥V>0, the number of samples is at most this expression
divided by V². This is a count of actual separated samples. The proof permits
touching endpoints of the half-open sampling intervals.

## Conditional zero detection

[ZeroDetectionSharp.lean](../Legendre/ZeroDetectionSharp.lean) combines this
with the already proved multiplicity-preserving representative selection.
For T≥7, N>1 and V>0, assume every counted zero ρ with Re ρ≥σ and
0<Im ρ≤T satisfies |P_N(Im ρ)|≥V. Then

```
N(σ,T) ≤ 2 C_sel log T · (1+2 log N)(T+1+2πN) E / V².
```

The absolute positive C_sel is the explicit `densitySelectionConstant` from
[ZetaDensitySelection.lean](../Legendre/ZetaDensitySelection.lean). Analytic
multiplicities are retained. Constructing a suitable analytic detector with
the coefficient/length bounds required for Ingham and Huxley is still open.
No particular density exponent is asserted by this conditional theorem.

## Verification and sources

The public interface is `import Legendre.Layer4`. All five modules are included
in the full build and axiom audit. Additional independent consumers check a
reversed interval with the explicit constant, optimized sampling at touching
intervals, and the zero-energy detector boundary case. The nine Layer 3
regressions remain in the validation suite.

Full validation: 4,102 build jobs; all 3,052 distinct project theorem
declarations audited against the standard three axioms; 130 project Lean
files free of executable `sorry`, `admit` and `sorryAx`; nineteen Layer 4
and nine Layer 3 consumers passing compiled and standalone checks. The complete
module-data theorem inventory agrees exactly with the audit target set.

The exact source pin, license and adaptation destinations are recorded in
both READMEs and [the source inventory](openai-math-provenance.md).
