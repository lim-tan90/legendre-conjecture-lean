/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaWideSeparated

/-!
# A uniform logarithmic bound on the fixed negative Perron line

High points have horizontal distance at least 1/8 from every nontrivial
zero, so no good-height selection is needed on this vertical line. A fixed
compact low-height interval supplies one absolute remaining coefficient.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric Filter Topology Set

/-- A full zero-separation radius on the fixed negative vertical line. -/
theorem perron_left_zero_separation (t : ℝ) {ρ : ℂ} (hρ : NontrivialZero ρ) :
    (1/8 : ℝ) ≤ ‖((-(1/8) : ℂ)+(t : ℂ)*I)-ρ‖ := by
  have hr := abs_re_le_norm (((-(1/8) : ℂ)+(t : ℂ)*I)-ρ)
  simp only [sub_re,add_re,neg_re,div_re,re_ofNat,one_re,ofReal_re,mul_re,
    ofReal_im,I_re,I_im,mul_zero,mul_one,sub_self,add_zero] at hr
  norm_num at hr
  rw [abs_of_neg (by linarith [hρ.2.1] : -(1/8 : ℝ)-ρ.re < 0)] at hr
  linarith [hρ.2.1]

/-- A logarithmic comparison valid at every height. -/
theorem wideZeta_log_le_left (t : ℝ) :
    Real.log (8*(|t|+5)^2) ≤ (2+Real.log 8/Real.log 5)*Real.log (|t|+5) := by
  have h5 : 0 < Real.log 5 := Real.log_pos (by norm_num)
  have h8 : 0 < Real.log 8 := Real.log_pos (by norm_num)
  have hy : 0 < |t|+5 := by positivity
  rw [Real.log_mul (by norm_num : (8 : ℝ) ≠ 0) (pow_ne_zero 2 hy.ne'),Real.log_pow]
  have hb := Real.log_le_log (by norm_num : (0 : ℝ) < 5) (by linarith [abs_nonneg t] : 5 ≤ |t|+5)
  have hm := mul_le_mul_of_nonneg_left hb (by positivity : 0 ≤ Real.log 8/Real.log 5)
  have he : (Real.log 8/Real.log 5)*Real.log 5 = Real.log 8 := by field_simp
  rw [he] at hm
  nlinarith

/-- Explicit coefficient for the high part of the negative vertical line. -/
noncomputable def perronLeftHighConstant : ℝ :=
  (1120*(1+Real.log 9/Real.log (10/9))+8/Real.log (10/9))*(2+Real.log 8/Real.log 5)

/-- Positivity of the high-height coefficient. -/
theorem perronLeftHighConstant_pos : 0 < perronLeftHighConstant := by
  have h5 : 0 < Real.log 5 := Real.log_pos (by norm_num)
  have h8 : 0 < Real.log 8 := Real.log_pos (by norm_num)
  have h9 : 0 < Real.log 9 := Real.log_pos (by norm_num)
  have hd : 0 < Real.log (10/9) := Real.log_pos (by norm_num)
  unfold perronLeftHighConstant
  positivity

/-- Logarithmic derivative bound at every high point on the fixed negative line. -/
theorem norm_logDeriv_perron_left_high {t : ℝ} (ht : 4 ≤ |t|) :
    ‖logDeriv riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*I)‖ ≤
      perronLeftHighConstant*Real.log (|t|+5) := by
  have hz : ‖((-(1/8) : ℂ)+(t : ℂ)*I)-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 17/8 := by
    rw [add_sub_add_right_eq_sub]
    norm_num
  have hb := norm_logDeriv_le_wide_separated ht (by norm_num : (0 : ℝ) < 1/8) hz
    (fun ρ hρ => perron_left_zero_separation t hρ)
  have hd : 0 < Real.log (10/9) := Real.log_pos (by norm_num)
  have h9 : 0 < Real.log 9 := Real.log_pos (by norm_num)
  have hk : 0 ≤ 1120*(1+Real.log 9/Real.log (10/9))+8/Real.log (10/9) := by positivity
  have hg := div_le_div_of_nonneg_right (wideZetaDegree_le ht) (by norm_num : (0 : ℝ) ≤ 1/8)
  calc
    _ ≤ 1120*wideZetaLogBound t+(Real.log (8*(|t|+5)^2)/Real.log (10/9))/(1/8) :=
      hb.trans (add_le_add le_rfl hg)
    _ = (1120*(1+Real.log 9/Real.log (10/9))+8/Real.log (10/9))*Real.log (8*(|t|+5)^2) := by
      unfold wideZetaLogBound
      ring
    _ ≤ _ := by
      have hh := mul_le_mul_of_nonneg_left (wideZeta_log_le_left t) hk
      simpa only [perronLeftHighConstant,mul_assoc] using hh

/-- The logarithmic derivative is continuous along the whole fixed negative line. -/
theorem continuous_logDeriv_perron_left :
    Continuous (fun t : ℝ => logDeriv riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*I)) := by
  apply continuous_iff_continuousAt.2
  intro t
  have hs1 : (-(1/8) : ℂ)+(t : ℂ)*I ≠ 1 := by
    intro he
    have hr := congrArg Complex.re he
    norm_num at hr
  have hA := analytic_off_pole ((-(1/8) : ℂ)+(t : ℂ)*I) hs1
  have hL : ContinuousAt (logDeriv riemannZeta) ((-(1/8) : ℂ)+(t : ℂ)*I) :=
    (hA.deriv.div hA (riemannZeta_ne_zero_perron_left t)).continuousAt
  have hc : ContinuousAt (fun u : ℝ => (-(1/8) : ℂ)+(u : ℂ)*I) t :=
    continuousAt_const.add (continuous_ofReal.continuousAt.mul_const I)
  exact hL.comp (f := fun u : ℝ => (-(1/8) : ℂ)+(u : ℂ)*I) hc

/-- One absolute coefficient controls the fixed left line at every height. -/
theorem exists_uniform_perron_left_bound : ∃ C > 0, ∀ t : ℝ,
    ‖logDeriv riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*I)‖ ≤ C*Real.log (|t|+5) := by
  obtain ⟨B,hB⟩ := (isCompact_Icc : IsCompact (Icc (-4 : ℝ) 4)).bddAbove_image
    continuous_logDeriv_perron_left.norm.continuousOn
  let M := max B 0
  have hM : 0 ≤ M := le_max_right _ _
  have h5 : 0 < Real.log 5 := Real.log_pos (by norm_num)
  have hhi := perronLeftHighConstant_pos
  refine ⟨perronLeftHighConstant+M/Real.log 5+1,by positivity,fun t => ?_⟩
  have hlog : Real.log 5 ≤ Real.log (|t|+5) :=
    Real.log_le_log (by norm_num) (by linarith [abs_nonneg t])
  have hlog0 : 0 ≤ Real.log (|t|+5) := h5.le.trans hlog
  by_cases ht : 4 ≤ |t|
  · have hb := norm_logDeriv_perron_left_high ht
    have hh := mul_le_mul_of_nonneg_right (by linarith [div_nonneg hM h5.le] :
      perronLeftHighConstant ≤ perronLeftHighConstant+M/Real.log 5+1) hlog0
    exact hb.trans hh
  · have hmem : t ∈ Icc (-4 : ℝ) 4 := by
      have hh := abs_lt.1 (lt_of_not_ge ht)
      exact ⟨hh.1.le,hh.2.le⟩
    have hb : ‖logDeriv riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*I)‖ ≤ M :=
      (hB (mem_image_of_mem _ hmem)).trans (le_max_left _ _)
    have hm := mul_le_mul_of_nonneg_left hlog (div_nonneg hM h5.le)
    have he : (M/Real.log 5)*Real.log 5 = M := by field_simp
    rw [he] at hm
    nlinarith

end Legendre.Zeta
