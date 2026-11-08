# Layer 4: detector-tail energy and the critical-line moment kernel

This continues the [actual zero-detector development](layer4-zero-detector.md).
The estimates and entire Gaussian kernel below are proved. The critical-line
fourth-moment theorem, the required sharper density exponents, and completion
of Layer 4 remain open.

## Tail energy and multiplicity-weighted density

[TailEnergy.lean](../Legendre/ZeroDetector/TailEnergy.lean) sums the dyadic
coefficient bounds. If |a(n)|≤C d(n), X,M≥1 and σ>1/2, then

```
Σ[X<n≤M] |a(n)|² n^(−2σ)
 ≤ 2 C² X^(1−2σ) (1+log(2XM))³ / (1−2^(1−2σ)).
```

The geometric denominator is proved positive. The finite dyadic version also
holds on the critical line before replacing its geometric sum by a constant.
The Möbius polynomial has the separate energy estimate E_σ(μ)≤1+log X for
σ≥1/2, including empty support. Consequently both energies in the actual
separated-zero sample bound now have explicit majorants.

[ZetaDetectedDensity.lean](../Legendre/ZetaDetectedDensity.lean) restores all
analytic multiplicities. For natural H≥7, X≥2 and 1/2<σ≤1 it proves

```
N(σ,H) ≤ N(1) + 2 C_sel log H · actualDetectorSampleBound(H,X,σ).
```

Here N(1) is the full fixed low-height count, and `actualDetectorSampleBound`
is the explicitly defined two-branch expression from the sample theorem after
substituting the energy bounds. This conclusion has no detector hypothesis.
The current length (32HX)² still prevents the required Ingham/Huxley powers
of H. The low-height term is retained when sampling ordinates at least one.

## Entire completion of the zeta square

Let Λ₀ be mathlib's pole-removed completed zeta function. Define

```
Xi(s) = 1+s(s−1)Λ₀(s).
```

[ZetaXi.lean](../Legendre/ZetaXi.lean) proves that Xi is entire,
Xi(1−s)=Xi(s), Xi(0)=Xi(1)=1, and
Xi(s)=s(s−1)Λ(s) away from the two completed poles. This is twice the
usual classical xi normalization. For Re(s)>0,

```
Xi(s) = s Γ_R(s) poleRemovedZeta(s).
```

The formula includes s=1 with its inserted residue value. On the critical
line, the polynomial shift ratio satisfies

```
|(s+w)(s+w−1)/(s(s−1))| ≤ (1+2|w|)².
```

It therefore costs no power of the base height in a normalized square kernel.

## Sharp Gamma shift

The selected PNT+ positive-half-plane digamma series, plus the adapted
[GammaBounds](../Legendre/GammaBounds/) slice, proves

```
|Γ_R(s+w)/Γ_R(s)|
 ≤ exp(A(1+|Im w|)) (|Im s|+2)^(Re w/2),
A = 59+|EulerMascheroniConstant|,
```

for Re(s)∈[1/4,3/2], Re(w)∈[0,2]. The leading horizontal exponent is retained
exactly. The Gaussian square weight consequently has constant
C_G=exp(2A+4+2A²) and bound

```
|(Γ_R(s+w)/Γ_R(s))² exp(w²)|
 ≤ C_G (|Im s|+2)^(Re w) exp(−(Im w)²/2)
```

when Re(s)=1/2. The original source and the selected PNT+ addition are recorded
in both READMEs and the [source inventories](openai-math-provenance.md).

## Normalized entire Gaussian kernel

[XiSquareKernel.lean](../Legendre/XiSquareKernel.lean) defines

```
G_s(w) = Xi(s+w)² exp(w²),
Q(s) = (s(s−1)Γ_R(s))²,
W_s(w) = [(s+w)(s+w−1)/(s(s−1))]²
         (Γ_R(s+w)/Γ_R(s))² exp(w²).
```

G_s is entire and G_s(−w)=G_(1−s)(w). The normalizer Q is nonzero on the
critical line. On the right integration line Re(w)=1,

```
G_s(w)/Q(s) = W_s(w) ζ(s+w)².
```

For Re(w)∈[0,2],

```
|W_s(w)| ≤ (1+2|w|)^4 C_G (|Im s|+2)^(Re w) exp(−(Im w)²/2).
```

## Integrable envelope for contour movement

[XiGaussianEnvelope.lean](../Legendre/XiGaussianEnvelope.lean) proves an
absolute cubic bound |Xi(s)|≤C(1+|Im s|)³ on Re(s)∈[−1/2,3/2]. The positive
half follows from Euler summation and the elementary Gamma integral bound;
reflection handles the other half, including the removed poles.

For each critical-line s there is K_s>0 such that, uniformly for |x|≤1,

```
|G_s(x+iu)| ≤ K_s (1+u²)³ exp(−u²).
```

The envelope is proved integrable and tends to zero as u→+∞. It is the input
for convergent vertical integrals and vanishing horizontal edges.

## Exact contour identity and pointwise fourth-power reduction

[XiSquareContour.lean](../Legendre/XiSquareContour.lean) defines

```
C_s(w) = G_s(w)/w,
I(s) = (2π)⁻¹ ∫[u∈ℝ] C_s(1+iu) du,
Φ(s) = I(s)/Q(s).
```

On Re(s)=1/2, both vertical lines are integrable and the horizontal rectangle
edges tend to zero. The rectangle residue is exactly 2πi Xi(s)²; its proof
also holds at s=0 and s=1 because the numerator is entire. Reflection gives
the correct orientation sign on the left vertical line. Thus

```
Xi(s)² = I(s)+I(1−s).
```

The entire completion and I commute with conjugation, including the removed
completed poles for Xi. On the critical line 1−s=conj(s), so the triangle
inequality and the nonzero normalizer give the unconditional pointwise bound

```
|ζ(s)|⁴ ≤ 4|Φ(s)|².
```

No contour mean estimate is assumed here. Proving its height-uniform integral
bound is the next analytic obligation for the fourth-moment theorem; the
Ingham/Huxley estimates and completion of Layer 4 remain open.

The new consumers check the residue at the removed pole s=0, equality of the
two smoothed terms at s=1/2, the fourth-power reduction at every real ordinate,
and conjugation at both removed poles. Both READMEs and the source inventory
credit all three adapted contour files.

## CI toolchain installation

The official release redirect repeatedly returned HTTP 504 before compilation.
`scripts/install-lean-ci.sh` resolves the exact pinned release through GitHub's
release API, downloads the official Linux asset with a second official route
as fallback, and verifies its published SHA-256 before extraction. The Lean
and mathlib pins are unchanged.

Validation of this slice: 4,132 full-build jobs; all 3,311 distinct project
theorem declarations audited against the three standard axioms; 157 Lean
files without executable `sorry`, `admit` or `sorryAx`; thirty-three Layer 4
and nine Layer 3 consumers pass compiled and standalone checks. The full
module-data theorem inventory matches the parsed axiom output exactly.
