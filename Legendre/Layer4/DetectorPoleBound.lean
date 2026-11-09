/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions: the principal zeta residue is small for explicit high
ordinates and independent Mobius/smoothing cutoffs. No density bound is assumed.
-/
module
public import Legendre.Layer4.DetectorAnalytic

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex

theorem detectorPrincipalPole_high_bound (X : ℕ) (s : ℂ) (hσ : 1/2 ≤ s.re)
    {T Y : ℝ} (hT : 0 < T) (ht : T ≤ |s.im|) (hX : (X : ℝ) ≤ 4*T)
    (hY : 1 ≤ Y) (hY2 : Y ≤ T^2) : ‖detectorPrincipalPole X s Y‖ ≤ 4/T := by
  have hYpow : Y^(1-s.re) ≤ T := by
    calc
      _ ≤ Y^(1/2 : ℝ) := Real.rpow_le_rpow_of_exponent_le hY (by linarith)
      _ = Real.sqrt Y := (Real.sqrt_eq_rpow Y).symm
      _ ≤ Real.sqrt (T^2) := Real.sqrt_le_sqrt hY2
      _ = T := by rw [Real.sqrt_sq_eq_abs,abs_of_pos hT]
  have htt : 0 < |s.im| := hT.trans_le ht
  have hinv : (|s.im|^3)⁻¹ ≤ (T^3)⁻¹ := by
    apply (inv_le_inv₀ (pow_pos htt 3) (pow_pos hT 3)).mpr
    exact pow_le_pow_left₀ hT.le ht 3
  calc
    _ ≤ (X : ℝ)*Y^(1-s.re)*(|s.im|^3)⁻¹ := norm_detectorPrincipalPole_le X s (by linarith) htt
    _ ≤ (4*T)*T*(T^3)⁻¹ :=
      mul_le_mul (mul_le_mul hX hYpow (Real.rpow_nonneg (by linarith) _) (by positivity)) hinv
        (by positivity) (by positivity)
    _ = _ := by field_simp

theorem detectorPrincipalPole_small (X : ℕ) (s : ℂ) (hσ : 1/2 ≤ s.re)
    {T Y : ℝ} (hT : 64 ≤ T) (ht : T ≤ |s.im|) (hX : (X : ℝ) ≤ 4*T)
    (hY : 1 ≤ Y) (hY2 : Y ≤ T^2) : ‖detectorPrincipalPole X s Y‖ ≤ 1/16 := by
  apply (detectorPrincipalPole_high_bound X s hσ (by linarith) ht hX hY hY2).trans
  exact (div_le_iff₀ (by linarith : 0 < T)).mpr (by linarith)

end Legendre.Density.Detector.Smooth
