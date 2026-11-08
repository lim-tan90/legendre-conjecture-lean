# openai/math source provenance: finite large sieve and separated sampling

The pinned upstream is [openai/math](https://github.com/openai/math), commit
[`4eaee87548250b2682affda7d05d947c05554bae`](https://github.com/openai/math/commit/4eaee87548250b2682affda7d05d947c05554bae).
It is licensed under Apache-2.0; the original text is retained in
[licenses/openai-math-Apache-2.0.txt](../licenses/openai-math-Apache-2.0.txt).
Both README translations contain the source, commit, license and destinations.
Every adapted Lean file contains a source/changes notice.

## Exact port inventory

Twenty-three modules are selected: nineteen Ostmann `Preliminaries` modules,
one Ostmann `Quadratic` module, one Ostmann `Characters` module, one Ostmann
`ZeroDensity` selection module, and one Jacobsthal sampling module.

| Pinned upstream path | Destination |
|---|---|
| [`lean/OAI/NumberTheory/Jacobsthal/Estimates/SeparatedSampling.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Jacobsthal/Estimates/SeparatedSampling.lean) | [Legendre/LargeSieve/SeparatedSampling.lean](../Legendre/LargeSieve/SeparatedSampling.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Characters/SkewKernelSquare.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Characters/SkewKernelSquare.lean) | [Legendre/LargeSieve/SkewKernelSquare.lean](../Legendre/LargeSieve/SkewKernelSquare.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/AdditiveSieveProof.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/AdditiveSieveProof.lean) | [Legendre/LargeSieve/AdditiveSieveProof.lean](../Legendre/LargeSieve/AdditiveSieveProof.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/CircleSeparatedPoints.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/CircleSeparatedPoints.lean) | [Legendre/LargeSieve/CircleSeparatedPoints.lean](../Legendre/LargeSieve/CircleSeparatedPoints.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantDistanceBound.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantDistanceBound.lean) | [Legendre/LargeSieve/CosecantDistanceBound.lean](../Legendre/LargeSieve/CosecantDistanceBound.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantHilbertBound.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantHilbertBound.lean) | [Legendre/LargeSieve/CosecantHilbertBound.lean](../Legendre/LargeSieve/CosecantHilbertBound.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantKernel.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantKernel.lean) | [Legendre/LargeSieve/CosecantKernel.lean](../Legendre/LargeSieve/CosecantKernel.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantMatrix.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantMatrix.lean) | [Legendre/LargeSieve/CosecantMatrix.lean](../Legendre/LargeSieve/CosecantMatrix.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantRowSum.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/CosecantRowSum.lean) | [Legendre/LargeSieve/CosecantRowSum.lean](../Legendre/LargeSieve/CosecantRowSum.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/FiniteMatrixDuality.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/FiniteMatrixDuality.lean) | [Legendre/LargeSieve/FiniteMatrixDuality.lean](../Legendre/LargeSieve/FiniteMatrixDuality.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/HermitianEigenvector.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/HermitianEigenvector.lean) | [Legendre/LargeSieve/HermitianEigenvector.lean](../Legendre/LargeSieve/HermitianEigenvector.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/HermitianNormBound.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/HermitianNormBound.lean) | [Legendre/LargeSieve/HermitianNormBound.lean](../Legendre/LargeSieve/HermitianNormBound.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/PublishedAdditiveSieve.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/PublishedAdditiveSieve.lean) | [Legendre/LargeSieve/PublishedAdditiveSieve.lean](../Legendre/LargeSieve/PublishedAdditiveSieve.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/ReducedFractionSeparation.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/ReducedFractionSeparation.lean) | [Legendre/LargeSieve/ReducedFractionSeparation.lean](../Legendre/LargeSieve/ReducedFractionSeparation.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/SeparatedAdditiveSieve.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/SeparatedAdditiveSieve.lean) | [Legendre/LargeSieve/SeparatedAdditiveSieve.lean](../Legendre/LargeSieve/SeparatedAdditiveSieve.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/SeparatedInverseSquares.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/SeparatedInverseSquares.lean) | [Legendre/LargeSieve/SeparatedInverseSquares.lean](../Legendre/LargeSieve/SeparatedInverseSquares.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/SeparatedSetSquares.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/SeparatedSetSquares.lean) | [Legendre/LargeSieve/SeparatedSetSquares.lean](../Legendre/LargeSieve/SeparatedSetSquares.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/SieveDualEnergy.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/SieveDualEnergy.lean) | [Legendre/LargeSieve/SieveDualEnergy.lean](../Legendre/LargeSieve/SieveDualEnergy.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/SieveGeometricKernel.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/SieveGeometricKernel.lean) | [Legendre/LargeSieve/SieveGeometricKernel.lean](../Legendre/LargeSieve/SieveGeometricKernel.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/SievePhaseGram.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/SievePhaseGram.lean) | [Legendre/LargeSieve/SievePhaseGram.lean](../Legendre/LargeSieve/SievePhaseGram.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Preliminaries/SymmetricQuadraticBound.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Preliminaries/SymmetricQuadraticBound.lean) | [Legendre/LargeSieve/SymmetricQuadraticBound.lean](../Legendre/LargeSieve/SymmetricQuadraticBound.lean) |
| [`lean/OAI/NumberTheory/Ostmann/Quadratic/KernelEigenvalueBound.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Quadratic/KernelEigenvalueBound.lean) | [Legendre/LargeSieve/KernelEigenvalueBound.lean](../Legendre/LargeSieve/KernelEigenvalueBound.lean) |
| [`lean/OAI/NumberTheory/Ostmann/ZeroDensity/SeparatedSelection.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SeparatedSelection.lean) | [Legendre/LargeSieve/SeparatedSelection.lean](../Legendre/LargeSieve/SeparatedSelection.lean) |

## Additional zero-detector source slice

The following six additional adapted modules use the same source pin and
retained license. The original large-sieve inventory above remains 23 files.
Paths in the left column are under `lean/OAI/NumberTheory/Ostmann/`.

| Pinned upstream path | Destination |
|---|---|
| `ZeroDensity/Mollifier.lean` | [ZeroDetector/Mollifier.lean](../Legendre/ZeroDetector/Mollifier.lean) |
| `ZeroDensity/FiniteDetector.lean` and the finite product lemma in `Mollifier.lean` | [ZeroDetector/FiniteMollifier.lean](../Legendre/ZeroDetector/FiniteMollifier.lean) |
| `ZeroDensity/BetaVariation.lean` | [ZeroDetector/BetaVariation.lean](../Legendre/ZeroDetector/BetaVariation.lean) |
| `Arithmetic/FrequencyLCM.lean` | [ZeroDetector/FrequencyLCM.lean](../Legendre/ZeroDetector/FrequencyLCM.lean) |
| `Arithmetic/DivisorSquareMean.lean` | [ZeroDetector/DivisorSquareMean.lean](../Legendre/ZeroDetector/DivisorSquareMean.lean) |
| First two lemmas of `ZeroDensity/CoefficientEnergy.lean` | [ZeroDetector/CoefficientEnergy.lean](../Legendre/ZeroDetector/CoefficientEnergy.lean) |

Two additional generalizations are attributed:

- [ComplexDirichlet.lean](../Legendre/ComplexDirichlet.lean) removes the character
  twist from `ZeroDensity/BetaDerivative.lean` and connects complex arguments
  to the local mean-square interface.
- [ActualZetaDetector.lean](../Legendre/ZeroDetector/ActualZetaDetector.lean)
  adapts the squared-length choice from `ZeroDensity/DetectorLength.lean` and
  the small-product organization of `ZeroDensity/ActualDetector.lean`.
  The source's nonprincipal-character tail theorem is **not** used for zeta.
  A locally proved finite Euler formula retains the principal pole term,
  giving a two-branch detector rather than the source's single-branch result.

[ZetaFiniteEuler.lean](../Legendre/ZetaFiniteEuler.lean),
[ComplexDirichletSampling.lean](../Legendre/ComplexDirichletSampling.lean), and
[DetectorSamples.lean](../Legendre/ZeroDetector/DetectorSamples.lean) are local
applications and deductions. The Euler formula invokes the existing attributed
PNT+ first-order Euler--Maclaurin theorem; it introduces no additional PNT+ port.

## Adaptation

Upstream pins Lean v4.34.1. This project retains its existing Lean/mathlib
v4.35.0 pins and lockfile. Imports point to the local slice, namespaces are
`Legendre.LargeSieve`, and module/public visibility is made explicit.
`CosecantKernel.lean` adds explicit derivative-power and derivative-mean-value
imports required by the newer public-import boundary. `SeparatedSelection.lean`
replaces the whole `Mathlib` import with selected finite-set and tactic imports.
The mathematical statements and proof hypotheses of the selected upstream
lemmas are retained, subject to namespace changes.

Four local generalizations are also attributed:

- [GramLargeValues.lean](../Legendre/GramLargeValues.lean) generalizes the
  `Preliminaries/SymmetricQuadraticBound.lean` quadratic row-sum argument to
  arbitrary complex kernels with symmetric norms, and connects it to sample Grams.
- [WeightedSeparation.lean](../Legendre/WeightedSeparation.lean) generalizes
  `ZeroDensity/SeparatedSelection.lean` from cardinality to natural-valued weights.

- [ReciprocalHilbert.lean](../Legendre/ReciprocalHilbert.lean) generalizes the
  finite-kernel eigenvalue and Hermitian spectral arguments of
  `CosecantHilbertBound.lean` and `CircleSeparatedPoints.lean` to (x−y)⁻¹
  on the real line.
- [SeparatedMeanValue.lean](../Legendre/SeparatedMeanValue.lean) generalizes
  the `SievePhaseGram.lean` coefficient-twisting argument to endpoint
  reciprocal Hilbert forms.

[DirichletMeanValueSharp.lean](../Legendre/DirichletMeanValueSharp.lean),
[DirichletSamplingSharp.lean](../Legendre/DirichletSamplingSharp.lean), and
[ZeroDetectionSharp.lean](../Legendre/ZeroDetectionSharp.lean) are local
applications; see [the new estimates](layer4-linear-mean-value.md).

[LargeSieve.lean](../Legendre/LargeSieve.lean),
[SobolevSampling.lean](../Legendre/SobolevSampling.lean),
[DirichletDerivative.lean](../Legendre/DirichletDerivative.lean),
[DirichletSampling.lean](../Legendre/DirichletSampling.lean),
[HalaszMontgomery.lean](../Legendre/HalaszMontgomery.lean),
[ZetaDensitySelection.lean](../Legendre/ZetaDensitySelection.lean), and
[ZeroDetectionReduction.lean](../Legendre/ZeroDetectionReduction.lean) provide
the local interfaces and deductions around the selected slice. The independent
local Sobolev lemma allows arbitrary sample locations in its interval; the
ported sampling lemma supplies the separated finite-sum specialization.

## Scope and verification

Verified source checkpoint: [`897139fbb45d`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/897139fbb45d96b98270f24bf5b196c411df1c19).

This slice proves the finite additive large sieve with coefficient `M+Q²`,
a separated-sample bound, finite Gram/Halasz--Montgomery inequalities, and a
multiplicity-preserving reduction from a hypothesized Dirichlet-polynomial
detector to N(σ,T). No upstream analytic Ingham or Huxley theorem is imported.
The zero-detection **property** remains an explicit hypothesis until its
analytic proof is supplied. Layer 4 is still in progress.

Previous large-sieve checkpoint validation: full build **4,097 jobs**; **3,022 distinct project
theorem declarations** audited, including all 176 public/private/generated
declarations added in this slice. Both project-theorem enumeration methods
match the parsed axiom output. The only axioms are `propext`, `Classical.choice`
and `Quot.sound`. All **125 Lean files** have zero executable `sorry`, `admit`
or `sorryAx`. Sixteen Layer 4 consumers and nine Layer 3 regression consumers
pass both compiled and standalone checks. No dependency pin or lockfile changed.

The subsequent reciprocal-kernel and endpoint-form generalizations are verified
with the [linear mean-square slice](layer4-linear-mean-value.md): 4,102 build
jobs, 3,052 distinct theorem declarations audited, 130 Lean files free of
executable placeholders, nineteen Layer 4 and nine Layer 3 consumers. Only the
three standard axioms are used. Dependency pins remain unchanged.

The actual-detector slice adds 106 audited public/private/generated declarations:
4,113 full-build jobs, all 3,158 project theorem declarations audited, 141 Lean
files without executable placeholders, twenty-three Layer 4 and nine Layer 3
consumers. See [the precise detector and its limits](layer4-zero-detector.md).

The source inventory above is available for the repository owner's upstream
communication; this work has not posted an upstream issue or PR.

## Gamma and Gaussian moment-kernel slice

The same pinned openai/math commit supplies the following additional files
from `lean/OAI/NumberTheory/Ostmann/ZeroDensity/`, adapted to
[`Legendre/GammaBounds/`](../Legendre/GammaBounds/):

- `LogNormDerivative.lean`
- `DigammaTailEstimate.lean`
- `SharpDigammaStrip.lean`
- `GammaNormDerivative.lean`
- `SharpGammaHorizontal.lean`
- `SharpGammaVertical.lean`
- `SharpGammaRealShift.lean`
- `GammaStripBound.lean`

The destination filenames match. `DigammaTailEstimate.lean` replaces the broad
`LogarithmicGammaBound.lean` dependency with the selected
[PNT+ positive-half-plane digamma-series proof](pnt-provenance.md#layer-4-addition-positive-half-plane-digamma-series).
`SharpDigammaStrip.lean` adds an explicit harmonic-bounds import required by
that smaller public dependency boundary. No character-dependent Gamma or
zero-free-region theorem is imported.

[GammaBounds/GaussianWeight.lean](../Legendre/GammaBounds/GaussianWeight.lean)
adapts the scalar Gaussian estimate and specializes the square-weight proof
from `CharacterGammaShift.lean` to the real Gamma factor.
[XiSquareKernel.lean](../Legendre/XiSquareKernel.lean) generalizes the
organization of `DensityCompletedSquare.lean` and `DensitySquareGaussian.lean`.
[ZetaXi.lean](../Legendre/ZetaXi.lean) is a local deduction from mathlib's
completed zeta function: multiplying by s(s−1) removes both completed poles.
This retains the reflection equation and introduces only a polynomial in the
contour shift, without an additional height power. These kernel estimates
prepare the fourth-moment contour; the fourth-moment theorem remains open.

[XiGaussianEnvelope.lean](../Legendre/XiGaussianEnvelope.lean) additionally
generalizes `DensityGaussianEnvelope.lean` to a sixth-degree polynomial
envelope for the entire xi square. The local polynomial strip bound is
derived from the proved Euler representation and Gamma integral bound.

Moment-kernel validation adds 123 audited public/private/generated declarations
after the actual-detector checkpoint: 4,131 build jobs, all 3,281 project
theorem declarations audited, 156 project Lean files without executable
placeholders, twenty-nine Layer 4 and nine Layer 3 consumer checks. The
standard three-axiom whitelist and dependency pins are unchanged.
