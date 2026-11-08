/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityMollifierProduct.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The principal zeta product replaces the nonprincipal character product.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorCoefficients
public import Mathlib.NumberTheory.LSeries.Dirichlet

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex
open scoped ArithmeticFunction.Moebius BigOperators

theorem detector_convolution (X : ℕ) :
    LSeries.convolution (1 : ℕ → ℂ) (mobiusCutoff X) = detectorCoefficient X := by
  funext n
  rw [LSeries.convolution_def]
  simp only [Pi.one_apply,one_mul]
  exact Nat.sum_divisorsAntidiagonal' (fun _ d => mobiusCutoff X d)

theorem mobiusCutoff_eq_truncate (X : ℕ) :
    mobiusCutoff X = (truncate X (μ : ArithmeticFunction ℂ) : ℕ → ℂ) := rfl

theorem mollifier_eq_LSeries (X : ℕ) (s : ℂ) :
    finiteSeries (μ : ArithmeticFunction ℂ) X s = LSeries (mobiusCutoff X) s := by
  rw [mobiusCutoff_eq_truncate,LSeries_truncate_eq_finiteSeries]

theorem detectorCoefficient_summable (X : ℕ) {s : ℂ} (hs : 1 < s.re) :
    LSeriesSummable (detectorCoefficient X) s := by
  rw [← detector_convolution]
  exact ((LSeriesSummable_one_iff.mpr hs).convolution
    (by rw [mobiusCutoff_eq_truncate]; exact truncated_summable X _ s))

theorem mollifier_zeta_product (X : ℕ) {s : ℂ} (hs : 1 < s.re) :
    LSeries (detectorCoefficient X) s = riemannZeta s*finiteSeries (μ : ArithmeticFunction ℂ) X s := by
  rw [← detector_convolution,LSeries_convolution' (LSeriesSummable_one_iff.mpr hs)
    (by rw [mobiusCutoff_eq_truncate]; exact truncated_summable X _ s),
    LSeries_one_eq_riemannZeta hs,← mollifier_eq_LSeries]

end Legendre.Density.Detector.Smooth
