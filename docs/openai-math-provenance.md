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
prepared the fourth-moment contour; the moment was still open at that checkpoint.

[XiGaussianEnvelope.lean](../Legendre/XiGaussianEnvelope.lean) additionally
generalizes `DensityGaussianEnvelope.lean` to a sixth-degree polynomial
envelope for the entire xi square. The local polynomial strip bound is
derived from the proved Euler representation and Gamma integral bound.

Moment-kernel validation adds 123 audited public/private/generated declarations
after the actual-detector checkpoint: 4,131 build jobs, all 3,281 project
theorem declarations audited, 156 project Lean files without executable
placeholders, twenty-nine Layer 4 and nine Layer 3 consumer checks. The
standard three-axiom whitelist and dependency pins are unchanged.

## Entire xi-square contour addition

[XiSquareContour.lean](../Legendre/XiSquareContour.lean) adapts the vertical-line,
reflection and conjugation proof organization from these additional files in
`lean/OAI/NumberTheory/Ostmann/ZeroDensity/` at the same pinned commit
`4eaee87548250b2682affda7d05d947c05554bae`, under the retained Apache-2.0 license:

- `DensitySquareContour.lean`
- `DensitySquareEquation.lean`
- `DensitySquareConjugation.lean`

The source character completion is replaced by the locally proved entire
xi completion. The local rectangle calculation uses `dslope` to isolate the
central simple pole and reuses the already ported PNT+ rectangle residue API
([fixed source and license](pnt-provenance.md)); no additional PNT+ source is
copied. Conjugation gives the pointwise fourth-power reduction for zeta.
At that checkpoint the normalized contour mean was still open. The later
sixth-log moment proof is recorded below; Ingham/Huxley remain open.

Contour-addition local validation: 4,132 build jobs, all 3,311 project theorem
declarations audited (30 added after the moment-kernel checkpoint), 157 Lean
files without executable placeholders, thirty-three Layer 4 and nine Layer 3
consumer checks. Both independent theorem inventories match the audit targets.

## Sixth-log fourth-moment addition

The additional files below all come from
`lean/OAI/NumberTheory/Ostmann/ZeroDensity/` at the same pinned
`openai/math` commit `4eaee87548250b2682affda7d05d947c05554bae`, Apache-2.0.
The license remains in `licenses/openai-math-Apache-2.0.txt`. This table also
appears in both README translations. Destination paths below are relative to
`Legendre/Layer4/`.

| Upstream / 上游 | Destination / 本地文件 |
|---|---|
| `DensityBlockCauchy.lean` | [BlockCauchy.lean](../Legendre/Layer4/BlockCauchy.lean) |
| `DensityBlockWeights.lean` | [BlockWeights.lean](../Legendre/Layer4/BlockWeights.lean) |
| `DensityCubicIntegrability.lean` | [CubicIntegrability.lean](../Legendre/Layer4/CubicIntegrability.lean) |
| `DensityDetectorDichotomy.lean` | [DetectorAlternative.lean](../Legendre/Layer4/DetectorAlternative.lean) |
| `DensityDetectorAnalytic.lean` | [DetectorAnalytic.lean](../Legendre/Layer4/DetectorAnalytic.lean) |
| `DensityDetectorCoefficients.lean` | [DetectorCoefficients.lean](../Legendre/Layer4/DetectorCoefficients.lean) |
| `DensityCriticalDetector.lean` | [DetectorCriticalMass.lean](../Legendre/Layer4/DetectorCriticalMass.lean) |
| `DensityMollifierBound.lean` | [DetectorGrowth.lean](../Legendre/Layer4/DetectorGrowth.lean) |
| `DensityDetectorHorizontal.lean` | [DetectorHorizontal.lean](../Legendre/Layer4/DetectorHorizontal.lean) |
| `DensityDetectorIntegral.lean` | [DetectorIntegral.lean](../Legendre/Layer4/DetectorIntegral.lean) |
| `DensityDetectorKernel.lean` | [DetectorKernel.lean](../Legendre/Layer4/DetectorKernel.lean) |
| `DensityDetectorKernelLeft.lean` | [DetectorKernelLeft.lean](../Legendre/Layer4/DetectorKernelLeft.lean) |
| `DensityMollifierProduct.lean` | [DetectorProduct.lean](../Legendre/Layer4/DetectorProduct.lean) |
| `DensityDetectorSeries.lean` | [DetectorSeries.lean](../Legendre/Layer4/DetectorSeries.lean) |
| `DensityDetectorShift.lean` | [DetectorShift.lean](../Legendre/Layer4/DetectorShift.lean) |
| `DensityDetectorVertical.lean`, `DensityDetectorShift.lean` | [DetectorVertical.lean](../Legendre/Layer4/DetectorVertical.lean) |
| `DensityDetectorWeight.lean` | [DetectorWeight.lean](../Legendre/Layer4/DetectorWeight.lean) |
| `DensityHarmonicDivisors.lean`, `DensityShiftedDivisorEnergy.lean` | [DivisorEnergy.lean](../Legendre/Layer4/DivisorEnergy.lean) |
| `DensityDyadicArithmetic.lean` | [DyadicArithmetic.lean](../Legendre/Layer4/DyadicArithmetic.lean) |
| `DensityDyadicShells.lean` | [DyadicHeightShells.lean](../Legendre/Layer4/DyadicHeightShells.lean) |
| `DensityDyadicPartition.lean` | [DyadicPartition.lean](../Legendre/Layer4/DyadicPartition.lean) |
| `GaussianContourShift.lean` | [GaussianContourShift.lean](../Legendre/Layer4/GaussianContourShift.lean) |
| `DensityGaussianFubini.lean` | [GaussianMean.lean](../Legendre/Layer4/GaussianMean.lean) |
| `DensityHeightWeight.lean` | [HeightWeight.lean](../Legendre/Layer4/HeightWeight.lean) |
| `DensityIntegralAlternative.lean` | [IntegralAlternative.lean](../Legendre/Layer4/IntegralAlternative.lean) |
| `DensityKernelHeightPacking.lean` | [KernelHeightPacking.lean](../Legendre/Layer4/KernelHeightPacking.lean) |
| `DensityKernelPacking.lean` | [KernelPacking.lean](../Legendre/Layer4/KernelPacking.lean) |
| `DensityMomentCutoff.lean` | [MomentCutoff.lean](../Legendre/Layer4/MomentCutoff.lean) |
| `DensityMomentDyadic.lean` | [MomentDyadic.lean](../Legendre/Layer4/MomentDyadic.lean) |
| `DensityGaussianCauchy.lean` | [MomentGaussian.lean](../Legendre/Layer4/MomentGaussian.lean) |
| `DensityCriticalMass.lean`, `DensityPackedProduct.lean` | [PackedCriticalMass.lean](../Legendre/Layer4/PackedCriticalMass.lean) |
| `DensityPackedMoment.lean` | [PackedMoment.lean](../Legendre/Layer4/PackedMoment.lean) |
| `DensityPackedMoment.lean`, `DensityPackedCharacterMoments.lean` | [PackedZetaMoment.lean](../Legendre/Layer4/PackedZetaMoment.lean) |
| `DensityFatou.lean` | [PositiveLimit.lean](../Legendre/Layer4/PositiveLimit.lean) |
| `DensityWeightedProductCauchy.lean` | [ProductCauchy.lean](../Legendre/Layer4/ProductCauchy.lean) |
| `DensityWeightedMoment.lean` | [WeightedHeightMoment.lean](../Legendre/Layer4/WeightedHeightMoment.lean) |
| `DensityWeightedCauchy.lean`, `DensityGaussianCauchy.lean` | [WeightedIntegral.lean](../Legendre/Layer4/WeightedIntegral.lean) |
| `DensityWeightedFourth.lean`, `DensityWeightedMollifier.lean` | [WeightedZetaMoment.lean](../Legendre/Layer4/WeightedZetaMoment.lean) |
| `DensityDyadicMean.lean` | [XiDyadicMean.lean](../Legendre/Layer4/XiDyadicMean.lean) |
| `DensityFiniteContinuity.lean` | [XiFiniteContinuity.lean](../Legendre/Layer4/XiFiniteContinuity.lean) |
| `DensityFiniteSquareMean.lean` | [XiFiniteMean.lean](../Legendre/Layer4/XiFiniteMean.lean) |
| `DensityFiniteContourShift.lean`, `DensityFiniteSeriesBridge.lean`, `DensityFiniteSquareEnergy.lean` | [XiFiniteMellin.lean](../Legendre/Layer4/XiFiniteMellin.lean) |
| `DensityHeadCutoff.lean` | [XiHeadMean.lean](../Legendre/Layer4/XiHeadMean.lean) |
| `DensitySmoothedKernel.lean`, `DensityKernelStrip.lean`, `DensityKernelLineBound.lean`, `DensityKernelCost.lean` | [XiMellinKernel.lean](../Legendre/Layer4/XiMellinKernel.lean) |
| `DensityPartialMean.lean` | [XiPartialMean.lean](../Legendre/Layer4/XiPartialMean.lean) |
| `DensitySmoothedMean.lean` | [XiSmoothedMean.lean](../Legendre/Layer4/XiSmoothedMean.lean) |
| `DensitySquareLimit.lean` | [XiSquareLimit.lean](../Legendre/Layer4/XiSquareLimit.lean) |
| `DensitySquareTerms.lean`, `DensitySquareSeriesIntegral.lean` | [XiSquareSeries.lean](../Legendre/Layer4/XiSquareSeries.lean) |
| `DensityTailAssembly.lean` | [XiTailAssembly.lean](../Legendre/Layer4/XiTailAssembly.lean) |
| `DensityTailBlock.lean` | [XiTailMean.lean](../Legendre/Layer4/XiTailMean.lean) |
| `DensityFourthMoment.lean` | [ZetaFourthMoment.lean](../Legendre/Layer4/ZetaFourthMoment.lean) |
| `DensitySquareSeries.lean` | [ZetaSquareSeries.lean](../Legendre/Layer4/ZetaSquareSeries.lean) |

Character families and conductor-dependent estimates are specialized to zeta.
The local sharp translated Dirichlet mean replaces a hybrid large sieve.
The entire xi polynomial is retained and absorbed in exp(-u^2/4); no additional
height power is lost. Finite contours move only within positive real part;
the full zeta series is expanded on Re(s+w)=3/2. Absolute integral norms
justify series exchange; dyadic bounds and nonnegative Fatou justify the limit.
The external (2*pi)^(-1) contour normalization is retained. No new PNT+ code
is copied; the already credited rectangle API is reused.

The proved result is O(T log^6 T), with a proved 1+epsilon height exponent.
It does not establish the sharp log^4 comparator or Ingham/Huxley density.

Fourth-moment validation (2026-11-08): 4,164 full-build jobs, all 3,561 project
theorem declarations audited, 189 Lean sources without executable
placeholders, and 84 independent consumers (39 Layer 4, 9 Layer 3, 36
literature). Both complete declaration inventories match the audit.

## Initial compact-detector addition

The seven additional `Detector*.lean` destinations in the inventory above
adapt the compact weight, Mellin inversion, full Mobius convolution and
initial right-contour series exchange at the same openai/math pin and under
the retained Apache-2.0 license. The character twist is removed. Zeta's
principal pole is explicitly retained as a remaining contour-shift obligation;
no zero-detection alternative or density exponent is claimed for this slice.
See [the exact initial identity and limits](layer4-compact-detector.md).

Compact-detector validation: 4,171 full-build jobs, all 3,615 project theorem
declarations audited, 196 Lean sources without executable placeholders and
89 independent consumers (44 Layer 4, 9 Layer 3, 36 literature). Both complete
declaration inventories agree with the audit and parsed axiom output.

## Compensated detector addition (2026-11-09)

The additional detector files in the inventory above retain the same
openai/math pin `4eaee87548250b2682affda7d05d947c05554bae`, ZeroDensity
source directory and Apache-2.0 license. The character source's entire
L-function is replaced by the local pole-removed zeta numerator. Its zero
is canceled by a divided difference; the principal pole at w=1-s remains
and contributes exactly M_X(1) Y^(1-s) k(1-s). Horizontal bounds now require
|Im(w)|>=|Im(s)|+1 to avoid that pole. Raw ordinates replace Fourier scaling.
`DetectorRectangle.lean` and `DetectorPoleBound.lean` are local deductions,
using the already credited PNT+ rectangle API and cubic kernel decay. No
additional PNT+ source is copied. Both READMEs list each adapted filename
and destination inside their default-open provenance sections.

The high-zero alternative is proved with T>=64, 1<=X<=4T, 4<=Y<=T^2 and
|Im(s)|>=T. The critical integral has an integrable cubic-weight mass bound.
Sharp packing and counting, Ingham/Huxley density, and Layer 4 completion
are still open; no detection estimate is assumed as an axiom.

Compensated-detector validation (2026-11-09): 4,180 full-build jobs; all 3,701
project theorem declarations audited; 205 Lean sources without executable
placeholders. Both independent declaration inventories match the audit and
its actual axiom output. All 95 independent consumers pass: 50 Layer 4,
9 Layer 3 and 36 literature checks. Ingham/Huxley remain open.

## Weighted moments and the integral branch (2026-11-09)

The additional sources in the table above supply disjoint height shells,
whole-line moment summation, separated cubic-kernel packing, weighted product
Cauchy inequalities and the integral-alternative count. The zeta specialization
uses raw ordinates and the already proved sixth-log fourth moment. The Mobius
second moment follows directly from the local sharp Dirichlet mean, avoiding
character families. The detection threshold is 1/16, hence the factor 256 in
the integral-branch count. The upstream pin, source directory and retained
Apache-2.0 license are unchanged. No additional PNT+ source is copied.

Weighted-moment and integral-branch validation (2026-11-09): full build 4,193
jobs, all 3,788 project theorem declarations audited, 218 Lean sources without
executable placeholders. Both independent inventories match the axiom audit.
All 101 standalone consumers pass: 56 Layer 4, 9 Layer 3 and 36 literature.
The tests include zero height in the dyadic cover, adjacent separated samples,
T=2 weighted moments, X=1 and the singleton packed critical mass.

## Compact polynomial branch and Ingham closure (2026-11-09)

Same upstream openai/math pin `4eaee87548250b2682affda7d05d947c05554bae`,
Apache-2.0, source prefix `lean/OAI/NumberTheory/Ostmann/ZeroDensity/`.
The license remains in `licenses/openai-math-Apache-2.0.txt`.

| `DensityDetectorDyadicCover.lean` | [DetectorDyadicCover.lean](../Legendre/Layer4/DetectorDyadicCover.lean) |
| `DensityDetectorPolynomial.lean`, `DensityDetectorBlocks.lean` | [DetectorPolynomial.lean](../Legendre/Layer4/DetectorPolynomial.lean) |
| `DensityFiniteBlockSquare.lean` | [FiniteBlockSquare.lean](../Legendre/Layer4/FiniteBlockSquare.lean) |
| `DensityPolynomialAlternative.lean` | [PolynomialAlternative.lean](../Legendre/Layer4/PolynomialAlternative.lean) |
| `DensityBalanceParameters.lean`, `DensityPolynomialBalance.lean` | [DensityBalance.lean](../Legendre/Layer4/DensityBalance.lean) |
| `DensityPolynomialBalanced.lean`, `DensityIntegralBalanced.lean` | [BalancedAlternatives.lean](../Legendre/Layer4/BalancedAlternatives.lean) |
| `DensitySeparatedCount.lean` | [SeparatedShellDensity.lean](../Legendre/Layer4/SeparatedShellDensity.lean); its already credited finite branch assembly is reused internally in [HuxleyShellDensity.lean](../Legendre/Layer4/HuxleyShellDensity.lean), under the same pinned source and Apache-2.0 license |

`PolynomialBlockSampling.lean`, `PolynomialBlockCost.lean`,
`NearCriticalDensity.lean`, `DyadicHeightDensity.lean`,
`InghamMultiplicity.lean` and `InghamDensity.lean` are local deductions.
They specialize existing varying-real-part sampling, retain the real upper
height endpoint, restore analytic multiplicities and absorb a log^10 loss.
Unlike the nonprincipal character source, the zeta balance is checked against
the explicit principal-pole constraints. No new PNT+ source is copied.
Both default-open README provenance sections list the exact new adaptations.
Ingham's curved exponent is now proved; Huxley/Guth–Maynard and the sharp
fourth-moment log^4 remain open. No 1937 prime-gap theorem is asserted.

Ingham density validation (2026-11-10): full build 4,206 jobs. All 3,874
project theorem declarations, including private/generated helpers, are audited
against propext, Classical.choice and Quot.sound. Both independent declaration
inventories match the audit targets and actual axiom output exactly. All 231
Lean sources have zero executable sorry, admit or sorryAx. All 107 standalone
consumers pass: 62 Layer 4, 9 Layer 3 and 36 literature. The added consumers
cover the real-height top boundary, the balanced sigma=3/4 powers, density
exponents at sigma=1/2 and 3/4, T=2 uniformly in sigma, and linear exponent
three. An intentional Ingham-as-Huxley consumer is rejected by Lean.

## Exponential derivative tests (2026-11-10)

Source directory `lean/OAI/NumberTheory/EgyptianFractions/`, same pinned
openai/math commit `4eaee87548250b2682affda7d05d947c05554bae`, Apache-2.0.
Retained license: `licenses/openai-math-Apache-2.0.txt`.
Namespace and public module visibility are adapted.

| Upstream | Destination |
|---|---|
| `DiscreteFirstDerivative.lean` | [DiscreteFirstDerivative.lean](../Legendre/Layer4/Exponential/DiscreteFirstDerivative.lean) |
| `DiscreteSecondDerivative.lean` | [DiscreteSecondDerivative.lean](../Legendre/Layer4/Exponential/DiscreteSecondDerivative.lean) |
| `MonotoneBlocks.lean` | [MonotoneBlocks.lean](../Legendre/Layer4/Exponential/MonotoneBlocks.lean) |
| `PhaseExtension.lean` | [PhaseExtension.lean](../Legendre/Layer4/Exponential/PhaseExtension.lean) |
| `SecondDerivativeBudget.lean` | [SecondDerivativeBudget.lean](../Legendre/Layer4/Exponential/SecondDerivativeBudget.lean) |
| `SecondDerivativeTest.lean` | [SecondDerivativeTest.lean](../Legendre/Layer4/Exponential/SecondDerivativeTest.lean) |
| `SecondDifference.lean` | [SecondDifference.lean](../Legendre/Layer4/Exponential/SecondDifference.lean) |
| `SeparatedIntervalCount.lean` | [SeparatedIntervalCount.lean](../Legendre/Layer4/Exponential/SeparatedIntervalCount.lean) |

Actual Halasz input validation (2026-11-10): full build 4,242 jobs; all 4,070
project theorem declarations, including private/generated helpers, audited
against exactly propext, Classical.choice and Quot.sound. Both independent
declaration inventories match the audit targets and actual axiom output.
All 246 project Lean files have zero executable placeholders. All 113
standalone consumers pass: 68 Layer 4, 9 Layer 3 and 36 literature checks.
An intentional use of the nonzero-ordinate kernel at t=0 is rejected.

The subsequent height subdivision, absorption-scale optimization, unconditional
two-term count, bounded critical-polynomial distributions, finite dyadic moments
and actual mollifier/critical-mass improvements are local deductions under
`Legendre/Layer4/` and `Legendre/Layer4/Exponential/`. They use the already
credited kernel and moment APIs and add no external code port.


Actual large-value and moment validation (2026-11-11): full build 4,262 jobs;
all 4,176 project theorem declarations (including 106 added public/private/
generated declarations) have identical module-data inventory, independent
full-environment inventory, audit-target set and parsed actual axiom output.
Only propext, Classical.choice and Quot.sound occur. All 264 Lean files are
free of executable sorry/admit/sorryAx and forbidden proof shortcuts.
All 119 standalone consumers pass: 74 Layer 4, 9 Layer 3 and 36 literature.
Intentional uses of the nonzero-ordinate kernel at t=0 and the critical
polynomial count below its W>=2 threshold are rejected.
The final Huxley density estimate remains open.

The global 12/5 density proof adds local divisor-block counts, literal integral
counts, uniform costs, exact parameter balance, integer cutoffs and analytic
multiplicity restoration. `HuxleyShellDensity.lean` retains attribution for
the finite branch assembly reused from the already adapted
`SeparatedShellDensity.lean` (source `DensitySeparatedCount.lean`,
openai/math `4eaee87548250b2682affda7d05d947c05554bae`, Apache-2.0).
Both READMEs list this additional destination; the upstream license is retained.
No new upstream source file was downloaded or copied.


Global 12/5 density validation (2026-11-13): full build 4,272 jobs. All
4,264 project theorem declarations, including 88 added declarations (52 public
and 36 private/generated), have identical module-data inventory, independent
full-environment inventory, audit-target set and actual parsed axiom output.
Only propext, Classical.choice and Quot.sound occur. All 274 project Lean files
have zero executable sorry/admit/sorryAx and no forbidden proof shortcuts.
All 127 independent consumers pass: 82 Layer 4, 9 Layer 3 and 36 literature.
Lean rejects treating the new global proof as the stronger curved Huxley target,
using the nonzero-ordinate kernel at t=0, and using the critical polynomial
count below W=2. The roadmap acceptance criteria are fulfilled; the stronger
curved Huxley/Guth--Maynard and sharp log^4 targets remain explicitly open.

## Divisor growth for polynomial powers (2026-11-14)

Source: openai/math `4eaee87548250b2682affda7d05d947c05554bae`, directory
`lean/OAI/NumberTheory/Ostmann/Arithmetic/`, Apache-2.0.
`DivisorGrowthLocal.lean` and `DivisorGrowth.lean` are adapted under
`Legendre/Layer4/Arithmetic/` with narrowed imports, the project namespace
and public module visibility. Both READMEs list the exact upstream files and
destinations; the license remains `licenses/openai-math-Apache-2.0.txt`.
These subpower divisor bounds support controlling coefficients after integer
powering. No stronger zero-density theorem is asserted by this port alone.

The new `HuxleyCurvedShell.lean` also reuses the finite branch-splitting
structure from this repository's `HuxleyShellDensity.lean`, originally adapted
from `DensitySeparatedCount.lean` at the same pinned openai/math commit and
under the same retained Apache-2.0 license. The powered-block analytic counts,
small-cutoff choices and restricted curved-density proof are local deductions.

## Finite differencing for logarithmic phases (2026-11-14)

`FourierSecondMoment.lean` and `VanDerCorput.lean` from
`lean/OAI/NumberTheory/EgyptianFractions/` in openai/math at
`4eaee87548250b2682affda7d05d947c05554bae` (Apache-2.0) are adapted to
`Legendre/Layer4/Exponential/` with the same basenames. Only imports,
namespace and module visibility are changed. The retained license is
`licenses/openai-math-Apache-2.0.txt`; both READMEs list the exact source URLs.
Natural-index overlap and shifted logarithmic-derivative estimates are local
code. This port alone asserts no new density or zeta subconvexity theorem.
