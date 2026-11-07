/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaGoodHeightBounds
public import Legendre.ZetaWideSeparated
public import Mathlib.Analysis.Complex.ExponentialBounds

/-!
# Log-squared bounds on quantitatively selected horizontal lines

In every unit interval above H≥7 there is a height T separated from all
critical-strip zero ordinates by c/log H. On both horizontal lines at ±T,
the logarithmic derivative is bounded by C(log H)^2 for Re(s)≥-(1/8).
The constants are explicit and independent of H. Both horizontal edges
are now controlled through the fixed negative real part -1/8.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Set

/-- A uniform coefficient for the horizontal logarithmic-derivative bound. -/
noncomputable def fullGoodHeightLogDerivativeConstant : ℝ :=
  1120*(1+Real.log 9/Real.log (10/9))*(2+Real.log 32/Real.log 2) +
    (2+Real.log 32/Real.log 2)/(Real.log (10/9)*goodHeightSeparationConstant) + 6

/-- The horizontal coefficient is strictly positive. -/
theorem fullGoodHeightLogDerivativeConstant_pos : 0 < fullGoodHeightLogDerivativeConstant := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h5 : 0 < Real.log 9 := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 32 := Real.log_pos (by norm_num)
  have hd : 0 < Real.log (10/9) := Real.log_pos (by norm_num)
  have hc := goodHeightSeparationConstant_pos
  unfold fullGoodHeightLogDerivativeConstant
  positivity

/-- Local logarithmic bounds at a height in (H,H+1) are uniform in H. -/
theorem wideZeta_log_le_at_good_height {H t : ℝ} (hH : 7 ≤ H) (ht : |t| < H+1) :
    Real.log (8*(|t|+5)^2) ≤ (2+Real.log 32/Real.log 2)*Real.log H := by
  have hp : 0 < H := by linarith
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h32 : 0 < Real.log 32 := Real.log_pos (by norm_num)
  have harg : 8*(|t|+5)^2 ≤ 32*H^2 := by
    have hb : |t|+5 ≤ 2*H := by linarith
    nlinarith [abs_nonneg t,mul_nonneg (by linarith : 0 ≤ 2*H-(|t|+5))
      (by positivity : 0 ≤ 2*H+(|t|+5))]
  have hl := Real.log_le_log (by positivity : 0 < 8*(|t|+5)^2) harg
  rw [Real.log_mul (by norm_num : (32 : ℝ) ≠ 0) (pow_ne_zero 2 hp.ne'),Real.log_pow] at hl
  have hlog2 : Real.log 2 ≤ Real.log H := Real.log_le_log (by norm_num) (by linarith)
  have hc := mul_le_mul_of_nonneg_left hlog2 (by positivity : 0 ≤ Real.log 32/Real.log 2)
  have he : (Real.log 32/Real.log 2)*Real.log 2 = Real.log 32 := by field_simp
  rw [he] at hc
  calc
    _ ≤ Real.log 32+2*Real.log H := by simpa using hl
    _ ≤ (Real.log 32/Real.log 2)*Real.log H+2*Real.log H := add_le_add hc le_rfl
    _ = _ := by ring

/-- The logarithmic derivative on a separated horizontal line, for every Re(s)≥-(1/8). -/
theorem norm_logDeriv_le_at_full_good_height {H T t u : ℝ} (hH : 7 ≤ H)
    (hT : T ∈ Ioo H (H+1)) (ht : |t| = T) (hu : -(1/8) ≤ u)
    (hgood : ∀ ρ : ℂ, NontrivialZero ρ →
      goodHeightSeparationConstant/Real.log H ≤ abs (T - |ρ.im|)) :
    ‖logDeriv riemannZeta ((u : ℂ)+(t : ℂ)*I)‖ ≤
      fullGoodHeightLogDerivativeConstant*(Real.log H)^2 := by
  let A := 2+Real.log 32/Real.log 2
  let K := 1+Real.log 9/Real.log (10/9)
  let d := Real.log (10/9)
  let c := goodHeightSeparationConstant
  let L := Real.log H
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 32 := Real.log_pos (by norm_num)
  have h5 : 0 < Real.log 9 := Real.log_pos (by norm_num)
  have hd : 0 < d := Real.log_pos (by norm_num)
  have hc : 0 < c := goodHeightSeparationConstant_pos
  have hA : 0 < A := by dsimp [A]; positivity
  have hK : 0 < K := by dsimp [K]; positivity
  have hL : 1 ≤ L := (Real.le_log_iff_exp_le (by linarith : 0 < H)).2
    (Real.exp_one_lt_d9.le.trans (by linarith))
  have hLpos : 0 < L := by linarith
  have hLsq : L ≤ L^2 := by nlinarith
  have hC : fullGoodHeightLogDerivativeConstant = 1120*K*A+A/(d*c)+6 := rfl
  by_cases hu2 : u ≤ 2
  · have ht3 : 4 ≤ |t| := by rw [ht]; linarith [hT.1]
    have hz : ‖((u : ℂ)+(t : ℂ)*I)-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 17/8 := by
      have he : (u : ℂ)-(2 : ℂ) = ((u-2 : ℝ) : ℂ) := by push_cast; rfl
      rw [add_sub_add_right_eq_sub,he,norm_real,Real.norm_eq_abs,abs_of_nonpos (by linarith : u-2 ≤ 0)]
      linarith
    have hzim : |((u : ℂ)+(t : ℂ)*I).im| = T := by simpa using ht
    have hb := norm_logDeriv_le_wide_separated ht3 (div_pos hc hLpos) hz
      (zero_distance_of_height_separation hgood hzim)
    have hlog := wideZeta_log_le_at_good_height hH (by rw [ht]; exact hT.2)
    have hreg : wideZetaLogBound t ≤ K*A*L := by
      change K*Real.log (8*(|t|+5)^2) ≤ K*A*L
      simpa only [mul_assoc] using mul_le_mul_of_nonneg_left hlog hK.le
    have hdeg : (wideZetaDegree t : ℝ) ≤ A*L/d :=
      (wideZetaDegree_le ht3).trans (div_le_div_of_nonneg_right hlog hd.le)
    have heq : (A*L/d)/(c/L) = A/(d*c)*L^2 := by field_simp
    calc
      _ ≤ 1120*(K*A*L)+(A*L/d)/(c/L) :=
        hb.trans (add_le_add (by linarith [hreg])
          (div_le_div_of_nonneg_right hdeg (div_pos hc hLpos).le))
      _ = 1120*K*A*L+A/(d*c)*L^2 := by rw [heq]; ring
      _ ≤ (1120*K*A+A/(d*c)+6)*L^2 := by
        nlinarith [mul_le_mul_of_nonneg_left hLsq (by positivity : 0 ≤ 1120*K*A), sq_nonneg L]
      _ = _ := by rw [hC]
  · have hre : 1+(1 : ℝ) ≤ ((u : ℂ)+(t : ℂ)*I).re := by
      simp only [add_re,ofReal_re,mul_re,ofReal_im,I_re,I_im,mul_zero,mul_one,sub_self,add_zero]
      linarith
    have hb := norm_logDeriv_le_six_div_sq (by norm_num : (0 : ℝ) < 1) le_rfl hre
    norm_num at hb
    rw [hC]
    calc
      _ ≤ 6 := hb
      _ ≤ (1120*K*A+A/(d*c)+6)*L^2 := by
        nlinarith [mul_nonneg (by positivity : 0 ≤ 1120*K*A+A/(d*c)) (sq_nonneg L)]

/-- Selected horizontal lines contain no zeros in Re(s)≥-(1/8). -/
theorem zeta_ne_zero_at_full_good_height {H T t u : ℝ} (hH : 7 ≤ H) (ht : |t| = T) (hu : -(1/8) ≤ u)
    (hgood : ∀ ρ : ℂ, NontrivialZero ρ →
      goodHeightSeparationConstant/Real.log H ≤ abs (T - |ρ.im|)) :
    riemannZeta ((u : ℂ)+(t : ℂ)*I) ≠ 0 := by
  by_cases hu1 : 1 ≤ u
  · apply riemannZeta_ne_zero_of_one_le_re
    simpa using hu1
  · by_cases hu0 : 0 < u
    · intro hz
      have hρ : NontrivialZero ((u : ℂ)+(t : ℂ)*I) :=
        ⟨hz,by simpa using hu0,by simpa using lt_of_not_ge hu1⟩
      have he := hgood _ hρ
      have htim : |((u : ℂ)+(t : ℂ)*I).im| = T := by simpa using ht
      rw [htim,sub_self,abs_zero] at he
      have hc := div_pos goodHeightSeparationConstant_pos (Real.log_pos (by linarith : 1 < H))
      linarith
    · apply riemannZeta_ne_zero_negative_strip
      · simp only [add_re,ofReal_re,mul_re,ofReal_im,I_re,I_im,mul_zero,mul_one,sub_self,add_zero]
        linarith
      · simpa using le_of_not_gt hu0

/-- Arbitrarily high paired horizontal lines with a uniform log-squared bound. -/
theorem exists_full_good_height_logDeriv_bound {H : ℝ} (hH : 7 ≤ H) :
    ∃ T ∈ Ioo H (H+1), ∀ t : ℝ, (t = T ∨ t = -T) → ∀ u : ℝ, -(1/8) ≤ u →
      riemannZeta ((u : ℂ)+(t : ℂ)*I) ≠ 0 ∧
      ‖logDeriv riemannZeta ((u : ℂ)+(t : ℂ)*I)‖ ≤
        fullGoodHeightLogDerivativeConstant*(Real.log H)^2 := by
  obtain ⟨T,hT,hgood⟩ := exists_good_height_log_separation hH
  refine ⟨T,hT,fun t ht u hu => ?_⟩
  have htabs : |t| = T := by
    have hp : 0 < T := by linarith [hT.1]
    rcases ht with rfl|rfl <;> simp [abs_of_pos hp]
  exact ⟨zeta_ne_zero_at_full_good_height hH htabs hu hgood,
    norm_logDeriv_le_at_full_good_height hH hT htabs hu hgood⟩

end Legendre.Zeta
