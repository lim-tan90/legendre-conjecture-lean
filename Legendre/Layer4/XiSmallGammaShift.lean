/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.XiMellinKernel
public import Legendre.GammaBounds.SharpGammaRealShift
public import Mathlib.Analysis.Complex.Schwarz

/-! Signed local Gamma shifts on the critical line. -/

@[expose] public section
open Complex Metric
namespace Legendre.Density.GammaBounds

/-- The exact horizontal logarithm of a Gamma quotient also works for
negative horizontal shifts. -/
theorem sharp_gamma_log_horizontal_signed (a b t : ℝ)
    (ha : 1/8 ≤ a) (ha3 : a ≤ 3) (hb : 1/8 ≤ b) (hb3 : b ≤ 3) :
    |Real.log ‖Complex.Gamma ((b : ℂ)+t*I)‖ -
       Real.log ‖Complex.Gamma ((a : ℂ)+t*I)‖ -
       (b-a)*Real.log (|t|+2)| ≤
      (59+|Real.eulerMascheroniConstant|)*|b-a| := by
  rcases le_total a b with h | h
  · simpa only [abs_of_nonneg (sub_nonneg.mpr h)] using
      sharp_gamma_log_horizontal_ordered a b t ha h hb3
  · have hh := sharp_gamma_log_horizontal_ordered b a t hb h ha3
    rw [abs_of_nonpos (sub_nonpos.mpr h)]
    convert hh using 1
    · rw [← abs_neg]
      congr 1
      ring
    · ring

/-- For a small complex shift the Gamma quotient keeps its signed height
power, with a constant uniform on the critical line. -/
theorem gammaReal_small_shift_signed {s w : ℂ} (hs : s.re = 1/2)
    (hw : ‖w‖ < 1/4) :
    ‖Gammaℝ (s+w)/Gammaℝ s‖^2 ≤
      (Real.pi*Real.exp (59+|Real.eulerMascheroniConstant|)) *
        (|s.im|/2+2)^w.re := by
  let a := s.re/2
  let b := (s.re+w.re)/2
  let t := s.im/2
  let v := (s.im+w.im)/2
  let K := 59+|Real.eulerMascheroniConstant|
  have hK : 0 ≤ K := by dsimp [K]; positivity
  have hwr := (abs_re_le_norm w).trans_lt hw
  have hwi := (abs_im_le_norm w).trans_lt hw
  obtain ⟨hw₁,hw₂⟩ := abs_lt.mp hwr
  have ha : 1/8 ≤ a := by dsimp [a]; linarith
  have ha3 : a ≤ 3 := by dsimp [a]; linarith
  have hb : 1/8 ≤ b := by dsimp [b]; linarith
  have hb3 : b ≤ 3 := by dsimp [b]; linarith
  let G (x y : ℝ) := ‖Complex.Gamma ((x : ℂ)+(y : ℂ)*I)‖
  have hpos (x y : ℝ) (hx : 1/8 ≤ x) : 0 < G x y := by
    dsimp [G]
    apply norm_pos_iff.mpr (Gamma_ne_zero_of_re_pos _)
    simp
    linarith
  have hl := le_abs_self (Real.log (G b t)-Real.log (G a t)-(b-a)*Real.log (|t|+2))
  have hh := hl.trans (sharp_gamma_log_horizontal_signed a b t ha ha3 hb hb3)
  have hv := (le_abs_self (Real.log (G b v)-Real.log (G b t))).trans
    (sharp_gamma_log_vertical b t v hb hb3)
  have hsum : Real.log (G b v/G a t) ≤ K/2+(w.re/2)*Real.log (|t|+2) := by
    rw [Real.log_div (hpos b v hb).ne' (hpos a t ha).ne']
    have he₁ : b-a = w.re/2 := by dsimp [b,a]; ring
    have he₂ : v-t = w.im/2 := by dsimp [v,t]; ring
    rw [he₁, abs_div w.re 2, abs_of_pos (by norm_num : (0 : ℝ) < 2)] at hh
    rw [he₂, abs_div w.im 2, abs_of_pos (by norm_num : (0 : ℝ) < 2)] at hv
    have hcr : K*(|w.re|/2) ≤ K/4 := by
      nlinarith [mul_nonneg hK (show 0 ≤ 1/4-|w.re| by linarith)]
    have hci : K*(|w.im|/2) ≤ K/4 := by
      nlinarith [mul_nonneg hK (show 0 ≤ 1/4-|w.im| by linarith)]
    linarith only [hh,hv,hcr,hci]
  have hquot := Real.exp_le_exp.mpr hsum
  rw [Real.exp_log (div_pos (hpos b v hb) (hpos a t ha)), Real.exp_add,
    mul_comm (w.re/2), ← Real.rpow_def_of_pos (by positivity : 0 < |t|+2)] at hquot
  have hcastA : ((a : ℂ)+(t : ℂ)*I) = s/2 := by
    apply Complex.ext <;> simp [a,t]
  have hcastB : ((b : ℂ)+(v : ℂ)*I) = (s+w)/2 := by
    apply Complex.ext <;> simp [b,v]
  have hPi : ‖((Real.pi : ℂ)^(-w/2))‖^2 ≤ Real.pi := by
    rw [norm_cpow_eq_rpow_re_of_pos Real.pi_pos, ← Real.rpow_natCast, ← Real.rpow_mul Real.pi_pos.le]
    refine (Real.rpow_le_rpow_of_exponent_le (by linarith [Real.pi_gt_three] : 1 ≤ Real.pi)
      (show (-w / 2).re * ((2 : ℕ) : ℝ) ≤ (1 : ℝ) by simp; linarith)).trans_eq (Real.rpow_one _)
  have hΘ := pow_le_pow_left₀ (div_nonneg (hpos b v hb).le (hpos a t ha).le) hquot 2
  have hΘ' : (G b v/G a t)^2 ≤ Real.exp K*(|t|+2)^w.re := by
    refine hΘ.trans_eq ?_
    rw [mul_pow, ← Real.exp_nat_mul, ← Real.rpow_natCast ((|t|+2)^(w.re/2)) 2,
      ← Real.rpow_mul (by positivity : 0 ≤ |t|+2)]
    rw [show ((2 : ℕ) : ℝ)*(K/2) = K by push_cast; ring,
      show (w.re/2)*((2 : ℕ) : ℝ) = w.re by push_cast; ring]
  rw [gammaReal_shift_quotient,norm_mul,mul_pow,norm_div,
    ← hcastA, ← hcastB]
  change ‖((Real.pi : ℂ)^(-w/2))‖^2*(G b v/G a t)^2 ≤ _
  calc
    _ ≤ Real.pi*(Real.exp K*(|t|+2)^w.re) := mul_le_mul hPi hΘ' (by positivity) Real.pi_pos.le
    _ = _ := by dsimp [K,t]; rw [abs_div, abs_of_pos (by norm_num : (0 : ℝ) < 2)]; ring

end Legendre.Density.GammaBounds
