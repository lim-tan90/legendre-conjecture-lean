/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaGoodHeight
public import Legendre.ZetaLogDerivativeSeparated
public import Mathlib.Analysis.Complex.ExponentialBounds

/-!
# Log-squared bounds on quantitatively selected horizontal lines

In every unit interval above H≥7 there is a height T separated from all
critical-strip zero ordinates by c/log H. On both horizontal lines at ±T,
the logarithmic derivative is bounded by C(log H)^2 for Re(s)≥7/8.
The constants are explicit and independent of H. No estimate on the
remaining left part of a Perron rectangle is asserted here.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Set

/-- A uniform coefficient for the horizontal logarithmic-derivative bound. -/
noncomputable def goodHeightLogDerivativeConstant : ℝ :=
  608*(1+Real.log 5/Real.log (6/5))*(1+Real.log 80/Real.log 2) +
    (1+Real.log 80/Real.log 2)/(Real.log (6/5)*goodHeightSeparationConstant) + 6

/-- The horizontal coefficient is strictly positive. -/
theorem goodHeightLogDerivativeConstant_pos : 0 < goodHeightLogDerivativeConstant := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h5 : 0 < Real.log 5 := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 80 := Real.log_pos (by norm_num)
  have hd : 0 < Real.log (6/5) := Real.log_pos (by norm_num)
  have hc := goodHeightSeparationConstant_pos
  unfold goodHeightLogDerivativeConstant
  positivity

/-- Absolute ordinate separation controls complex distance on either horizontal line. -/
theorem zero_distance_of_height_separation {H T : ℝ}
    (hgood : ∀ ρ : ℂ, NontrivialZero ρ →
      goodHeightSeparationConstant/Real.log H ≤ abs (T - |ρ.im|))
    {z : ℂ} (hz : |z.im| = T) (ρ : ℂ) (hρ : NontrivialZero ρ) :
    goodHeightSeparationConstant/Real.log H ≤ ‖z-ρ‖ := by
  calc
    _ ≤ abs (T - |ρ.im|) := hgood ρ hρ
    _ = abs (|z.im| - |ρ.im|) := by rw [hz]
    _ ≤ abs (z.im-ρ.im) := abs_abs_sub_abs_le_abs_sub _ _
    _ ≤ ‖z-ρ‖ := by simpa only [sub_im] using abs_im_le_norm (z-ρ)

/-- Local logarithmic bounds at a height in (H,H+1) are uniform in H. -/
theorem localZeta_log_le_at_good_height {H t : ℝ} (hH : 7 ≤ H) (ht : |t| < H+1) :
    Real.log (24*(|t|+2)) ≤ (1+Real.log 80/Real.log 2)*Real.log H := by
  apply (Real.log_le_log (by positivity : 0 < 24*(|t|+2))
    (by linarith : 24*(|t|+2) ≤ 40*(H+7))).trans
  exact global_counting_log_le hH

/-- The logarithmic derivative on a separated horizontal line, for every Re(s)≥7/8. -/
theorem norm_logDeriv_le_at_good_height {H T t u : ℝ} (hH : 7 ≤ H)
    (hT : T ∈ Ioo H (H+1)) (ht : |t| = T) (hu : 7/8 ≤ u)
    (hgood : ∀ ρ : ℂ, NontrivialZero ρ →
      goodHeightSeparationConstant/Real.log H ≤ abs (T - |ρ.im|)) :
    ‖logDeriv riemannZeta ((u : ℂ)+(t : ℂ)*I)‖ ≤
      goodHeightLogDerivativeConstant*(Real.log H)^2 := by
  let A := 1+Real.log 80/Real.log 2
  let K := 1+Real.log 5/Real.log (6/5)
  let d := Real.log (6/5)
  let c := goodHeightSeparationConstant
  let L := Real.log H
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 80 := Real.log_pos (by norm_num)
  have h5 : 0 < Real.log 5 := Real.log_pos (by norm_num)
  have hd : 0 < d := Real.log_pos (by norm_num)
  have hc : 0 < c := goodHeightSeparationConstant_pos
  have hA : 0 < A := by dsimp [A]; positivity
  have hK : 0 < K := by dsimp [K]; positivity
  have hL : 1 ≤ L := (Real.le_log_iff_exp_le (by linarith : 0 < H)).2
    (Real.exp_one_lt_d9.le.trans (by linarith))
  have hLpos : 0 < L := by linarith
  have hLsq : L ≤ L^2 := by nlinarith
  have hC : goodHeightLogDerivativeConstant = 608*K*A+A/(d*c)+6 := rfl
  by_cases hu2 : u ≤ 2
  · have ht3 : 3 ≤ |t| := by rw [ht]; linarith [hT.1]
    have hz : ‖((u : ℂ)+(t : ℂ)*I)-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 9/8 := by
      have he : (u : ℂ)-(2 : ℂ) = ((u-2 : ℝ) : ℂ) := by push_cast; rfl
      rw [add_sub_add_right_eq_sub,he,norm_real,Real.norm_eq_abs,abs_of_nonpos (by linarith : u-2 ≤ 0)]
      linarith
    have hzim : |((u : ℂ)+(t : ℂ)*I).im| = T := by simpa using ht
    have hb := norm_logDeriv_le_local_separated ht3 (div_pos hc hLpos) hz
      (zero_distance_of_height_separation hgood hzim)
    have hlog := localZeta_log_le_at_good_height hH (by rw [ht]; exact hT.2)
    have hreg : localZetaLogBound t ≤ K*A*L := by
      change K*Real.log (24*(|t|+2)) ≤ K*A*L
      simpa only [mul_assoc] using mul_le_mul_of_nonneg_left hlog hK.le
    have hdeg : (localZetaDegree t : ℝ) ≤ A*L/d :=
      (localZetaDegree_le ht3).trans (div_le_div_of_nonneg_right hlog hd.le)
    have heq : (A*L/d)/(c/L) = A/(d*c)*L^2 := by field_simp
    calc
      _ ≤ 608*(K*A*L)+(A*L/d)/(c/L) :=
        hb.trans (add_le_add (by linarith [hreg])
          (div_le_div_of_nonneg_right hdeg (div_pos hc hLpos).le))
      _ = 608*K*A*L+A/(d*c)*L^2 := by rw [heq]; ring
      _ ≤ (608*K*A+A/(d*c)+6)*L^2 := by
        nlinarith [mul_le_mul_of_nonneg_left hLsq (by positivity : 0 ≤ 608*K*A), sq_nonneg L]
      _ = _ := by rw [hC]
  · have hre : 1+(1 : ℝ) ≤ ((u : ℂ)+(t : ℂ)*I).re := by
      simp only [add_re,ofReal_re,mul_re,ofReal_im,I_re,I_im,mul_zero,mul_one,sub_self,add_zero]
      linarith
    have hb := norm_logDeriv_le_six_div_sq (by norm_num : (0 : ℝ) < 1) le_rfl hre
    norm_num at hb
    rw [hC]
    calc
      _ ≤ 6 := hb
      _ ≤ (608*K*A+A/(d*c)+6)*L^2 := by
        nlinarith [mul_nonneg (by positivity : 0 ≤ 608*K*A+A/(d*c)) (sq_nonneg L)]

/-- Selected horizontal lines contain no zeros in Re(s)≥7/8. -/
theorem zeta_ne_zero_at_good_height {H T t u : ℝ} (hH : 7 ≤ H) (ht : |t| = T) (hu : 7/8 ≤ u)
    (hgood : ∀ ρ : ℂ, NontrivialZero ρ →
      goodHeightSeparationConstant/Real.log H ≤ abs (T - |ρ.im|)) :
    riemannZeta ((u : ℂ)+(t : ℂ)*I) ≠ 0 := by
  by_cases hu1 : 1 ≤ u
  · apply riemannZeta_ne_zero_of_one_le_re
    simpa using hu1
  · intro hz
    have hρ : NontrivialZero ((u : ℂ)+(t : ℂ)*I) :=
      ⟨hz,by simpa using (show 0 < u by linarith),by simpa using lt_of_not_ge hu1⟩
    have he := hgood _ hρ
    have htim : |((u : ℂ)+(t : ℂ)*I).im| = T := by simpa using ht
    rw [htim,sub_self,abs_zero] at he
    have hc := div_pos goodHeightSeparationConstant_pos (Real.log_pos (by linarith : 1 < H))
    linarith

/-- Arbitrarily high paired horizontal lines with a uniform log-squared bound. -/
theorem exists_good_height_logDeriv_bound {H : ℝ} (hH : 7 ≤ H) :
    ∃ T ∈ Ioo H (H+1), ∀ t : ℝ, (t = T ∨ t = -T) → ∀ u : ℝ, 7/8 ≤ u →
      riemannZeta ((u : ℂ)+(t : ℂ)*I) ≠ 0 ∧
      ‖logDeriv riemannZeta ((u : ℂ)+(t : ℂ)*I)‖ ≤
        goodHeightLogDerivativeConstant*(Real.log H)^2 := by
  obtain ⟨T,hT,hgood⟩ := exists_good_height_log_separation hH
  refine ⟨T,hT,fun t ht u hu => ?_⟩
  have htabs : |t| = T := by
    have hp : 0 < T := by linarith [hT.1]
    rcases ht with rfl|rfl <;> simp [abs_of_pos hp]
  exact ⟨zeta_ne_zero_at_good_height hH htabs hu hgood,
    norm_logDeriv_le_at_good_height hH hT htabs hu hgood⟩

end Legendre.Zeta
