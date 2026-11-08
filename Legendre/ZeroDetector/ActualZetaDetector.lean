/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The explicit squared-length choice adapts DetectorLength.lean and the
small-product organization of ActualDetector.lean from openai/math,
commit 4eaee87548250b2682affda7d05d947c05554bae, under Apache-2.0.
Unlike the nonprincipal-character source, this zeta proof retains a separate
principal pole contribution. See docs/openai-math-provenance.md.
-/
module

public import Legendre.ZeroDetector.FiniteMollifier
public import Legendre.ZetaFiniteEuler
public import Legendre.ZetaCounting

/-!
# An actual two-branch detector at Riemann-zeta zeros

The vanishing of zeta is an actual hypothesis. Euler summation proves the
small remainder; no unproved detector property or density estimate is assumed.
The principal pole compensation is kept as a second detection branch.
-/

@[expose] public section

namespace Legendre.Density.Detector

open Complex
open scoped ArithmeticFunction.Moebius ArithmeticFunction.zeta

/-- An explicit length making the Euler remainder small after mollification. -/
def zetaDetectorLength (H X : ℕ) : ℕ := (32*H*X)^2

theorem zetaDetectorLength_ge {H X : ℕ} (hH : 1 ≤ H) (hX : 1 ≤ X) :
    X ≤ zetaDetectorLength H X := by
  have hbase : 1 ≤ 32*H := by omega
  have hXB : X ≤ 32*H*X := by simpa using Nat.mul_le_mul_right X hbase
  unfold zetaDetectorLength
  nlinarith

theorem zetaDetectorLength_rpow_le {H X : ℕ} (hH : 1 ≤ H) (hX : 1 ≤ X)
    {β : ℝ} (hβ : 1/2 ≤ β) :
    (zetaDetectorLength H X : ℝ)^(-β) ≤ (32*(H : ℝ)*(X : ℝ))⁻¹ := by
  have hN : (1 : ℝ) ≤ zetaDetectorLength H X := by
    exact_mod_cast hX.trans (zetaDetectorLength_ge hH hX)
  calc
    _ ≤ (zetaDetectorLength H X : ℝ)^(-((1 : ℝ)/2)) :=
      Real.rpow_le_rpow_of_exponent_le hN (by linarith)
    _ = (Real.sqrt (zetaDetectorLength H X : ℝ))⁻¹ := by
      rw [Real.rpow_neg (by positivity : (0 : ℝ) ≤ zetaDetectorLength H X),Real.sqrt_eq_rpow]
    _ = _ := by simp [zetaDetectorLength,Real.sqrt_sq_eq_abs,abs_of_nonneg]

/-- The principal-pole contribution after multiplying by the Möbius polynomial. -/
noncomputable def poleCompensation (X N : ℕ) (s : ℂ) : ℂ :=
  finiteSeries (μ : ArithmeticFunction ℂ) X s*((N : ℂ)^(1-s)/(s-1))

/-- Mollifying the Euler error leaves a small, quantitatively bounded remainder. -/
theorem actual_zero_compensated_product_le {H X : ℕ} (hH : 1 ≤ H) (hX : 1 ≤ X)
    {ρ : ℂ} (hzero : riemannZeta ρ = 0) (hρ1 : ρ ≠ 1)
    (hβ : 1/2 ≤ ρ.re) (hβ1 : ρ.re ≤ 1) (hheight : |ρ.im| ≤ H) :
    ‖finiteSeries (μ : ArithmeticFunction ℂ) X ρ *
        finiteSeries (ζ : ArithmeticFunction ℂ) (zetaDetectorLength H X) ρ +
      poleCompensation X (zetaDetectorLength H X) ρ‖ ≤ 9/64 := by
  have hβpos : 0 < ρ.re := by linarith
  have hHR : (1 : ℝ) ≤ H := by exact_mod_cast hH
  have hXR : (1 : ℝ) ≤ X := by exact_mod_cast hX
  have hN := hX.trans (zetaDetectorLength_ge hH hX)
  have hnorm : ‖ρ‖ ≤ 2*(H : ℝ) := by
    have hn := Complex.norm_le_abs_re_add_abs_im ρ
    rw [abs_of_pos hβpos] at hn
    linarith
  have hpref : 1/2+‖ρ‖/(2*ρ.re) ≤ (9/2 : ℝ)*H := by
    have hden : 1 ≤ 2*ρ.re := by linarith
    have hq := div_le_self (norm_nonneg ρ) hden
    linarith
  have htail := Zeta.norm_riemannZeta_sub_finite_euler_le hN hβpos hρ1
  rw [hzero,zero_sub] at htail
  have he : finiteSeries (μ : ArithmeticFunction ℂ) X ρ *
        finiteSeries (ζ : ArithmeticFunction ℂ) (zetaDetectorLength H X) ρ +
      poleCompensation X (zetaDetectorLength H X) ρ =
      -(finiteSeries (μ : ArithmeticFunction ℂ) X ρ *
        (-(∑ n ∈ Finset.Icc 1 (zetaDetectorLength H X), (n : ℂ)^(-ρ))-
          (zetaDetectorLength H X : ℂ)^(1-ρ)/(ρ-1))) := by
    rw [finiteSeries_zeta_eq]
    unfold poleCompensation
    ring
  rw [he,norm_neg,norm_mul]
  calc
    _ ≤ (X : ℝ)*((1/2+‖ρ‖/(2*ρ.re))*(zetaDetectorLength H X : ℝ)^(-ρ.re)) :=
      mul_le_mul (norm_mollifier_finiteSeries_le X hβpos.le) htail (norm_nonneg _) (by positivity)
    _ ≤ (X : ℝ)*(((9/2 : ℝ)*H)*(32*(H : ℝ)*(X : ℝ))⁻¹) := by
      apply mul_le_mul_of_nonneg_left _ (Nat.cast_nonneg X)
      exact mul_le_mul hpref (zetaDetectorLength_rpow_le hH hX hβ)
        (Real.rpow_nonneg (Nat.cast_nonneg _) _) (by positivity)
    _ = 9/64 := by field_simp; ring

/-- Every zero in the range triggers at least one of the two genuine detector terms. -/
theorem actual_zero_detector_alternative {H X : ℕ} (hH : 1 ≤ H) (hX : 1 ≤ X)
    {ρ : ℂ} (hzero : riemannZeta ρ = 0) (hρ1 : ρ ≠ 1)
    (hβ : 1/2 ≤ ρ.re) (hβ1 : ρ.re ≤ 1) (hheight : |ρ.im| ≤ H) :
    3/8 ≤ ‖detectorPolynomial X (zetaDetectorLength H X) ρ‖ ∨
      3/8 ≤ ‖poleCompensation X (zetaDetectorLength H X) ρ‖ := by
  have hsmall := actual_zero_compensated_product_le hH hX hzero hρ1 hβ hβ1 hheight
  rw [finite_mollifier_identity hX (zetaDetectorLength_ge hH hX) ρ] at hsmall
  have ht := norm_sub_le
    (1+detectorPolynomial X (zetaDetectorLength H X) ρ+
      poleCompensation X (zetaDetectorLength H X) ρ)
    (detectorPolynomial X (zetaDetectorLength H X) ρ+
      poleCompensation X (zetaDetectorLength H X) ρ)
  have he : (1+detectorPolynomial X (zetaDetectorLength H X) ρ+
      poleCompensation X (zetaDetectorLength H X) ρ)-
      (detectorPolynomial X (zetaDetectorLength H X) ρ+
        poleCompensation X (zetaDetectorLength H X) ρ) = 1 := by ring
  rw [he,norm_one] at ht
  have hsum := norm_add_le (detectorPolynomial X (zetaDetectorLength H X) ρ)
    (poleCompensation X (zetaDetectorLength H X) ρ)
  by_cases h : 3/8 ≤ ‖detectorPolynomial X (zetaDetectorLength H X) ρ‖
  · exact Or.inl h
  · exact Or.inr (by linarith)

end Legendre.Density.Detector
