/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Mathlib.Analysis.SpecialFunctions.Complex.Analytic

@[expose] public section
namespace Legendre.Zeta
open Complex Metric Set

/-- The disk parametrization of the half-plane to the right of (a),
with (0) sent to the point (a+b). -/
noncomputable def halfPlaneDiskMap (a b : ℝ) (w : ℂ) : ℂ :=
  (a : ℂ)+(b : ℂ)*(1+w)/(1-w)

/-- Inverse of the half-plane disk parametrization away from its pole. -/
noncomputable def halfPlaneDiskInverse (a b : ℝ) (z : ℂ) : ℂ :=
  (z-((a+b : ℝ) : ℂ))/(z-((a-b : ℝ) : ℂ))

@[simp] theorem halfPlaneDiskMap_zero (a b : ℝ) :
    halfPlaneDiskMap a b 0 = ((a+b : ℝ) : ℂ) := by simp [halfPlaneDiskMap]

theorem halfPlaneDiskMap_analyticAt (a b : ℝ) {w : ℂ} (hw : w ≠ 1) :
    AnalyticAt ℂ (halfPlaneDiskMap a b) w := by
  unfold halfPlaneDiskMap
  exact analyticAt_const.add ((analyticAt_const.mul (analyticAt_const.add analyticAt_id)).div
    (analyticAt_const.sub analyticAt_id) (sub_ne_zero.mpr hw.symm))

theorem halfPlaneDiskMap_hasDerivAt (a b : ℝ) {w : ℂ} (hw : w ≠ 1) :
    HasDerivAt (halfPlaneDiskMap a b) (2*(b : ℂ)/(1-w)^2) w := by
  have h := (((hasDerivAt_id w).const_add (1 : ℂ)).const_mul (b : ℂ)).div
    ((hasDerivAt_id w).const_sub (1 : ℂ)) (sub_ne_zero.mpr hw.symm)
  have hh := h.const_add (a : ℂ)
  have he : (b : ℂ)*1*(1-w)-(b : ℂ)*(1+w)*(-1) = 2*(b : ℂ) := by ring
  change HasDerivAt (fun x : ℂ => (a : ℂ)+(b : ℂ)*(1+x)/(1-x)) (2*(b : ℂ)/(1-w)^2) w
  simpa only [Pi.div_apply, id_eq, he] using hh

theorem halfPlaneDiskMap_deriv_ne_zero (a : ℝ) {b : ℝ} (hb : b ≠ 0) {w : ℂ} (hw : w ≠ 1) :
    deriv (halfPlaneDiskMap a b) w ≠ 0 := by
  rw [(halfPlaneDiskMap_hasDerivAt a b hw).deriv]
  exact div_ne_zero (mul_ne_zero (by norm_num)
    (Complex.ofReal_ne_zero.mpr hb)) (pow_ne_zero _ (sub_ne_zero.mpr hw.symm))

theorem halfPlaneDiskMap_of_inverse {a b : ℝ} (hb : b ≠ 0) {z : ℂ}
    (hz : z ≠ ((a-b : ℝ) : ℂ)) :
    halfPlaneDiskMap a b (halfPlaneDiskInverse a b z) = z := by
  have hb' : (b : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hb
  have hd := sub_ne_zero.mpr hz
  unfold halfPlaneDiskMap halfPlaneDiskInverse
  push_cast at hd ⊢
  have h : 1-(z-((a : ℂ)+(b : ℂ)))/(z-((a : ℂ)-(b : ℂ))) =
      (2*(b : ℂ))/(z-((a : ℂ)-(b : ℂ))) := by
    field_simp [hd]
    ring
  rw [h]
  field_simp [hd,hb']
  ring

theorem halfPlaneDiskMap_inverse_ne_one {a b : ℝ} (hb : b ≠ 0) {z : ℂ}
    (hz : z ≠ ((a-b : ℝ) : ℂ)) :
    halfPlaneDiskInverse a b z ≠ 1 := by
  intro hh
  have hd := sub_ne_zero.mpr hz
  have e := (div_eq_iff hd).mp hh
  have hb' : (b : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hb
  push_cast at e
  apply hb'
  linear_combination (-1/2 : ℂ)*e

theorem halfPlaneDiskMap_re_gt {a b : ℝ} (hb : 0 < b) {w : ℂ} (hw : ‖w‖ < 1) :
    a < (halfPlaneDiskMap a b w).re := by
  have hw₁ : w ≠ 1 := by intro he; simp [he] at hw
  have hd : 0 < normSq (1-w) := normSq_pos.mpr (sub_ne_zero.mpr hw₁.symm)
  have hr : (((1+w)/(1-w) : ℂ)).re = (1-‖w‖^2)/normSq (1-w) := by
    rw [div_re, Complex.sq_norm, normSq_apply w]
    simp only [add_re, one_re, sub_re, add_im, one_im, zero_add, sub_im, zero_sub]
    ring
  unfold halfPlaneDiskMap
  rw [add_re, ofReal_re, mul_div_assoc, mul_re, ofReal_re, ofReal_im, zero_mul, sub_zero, hr]
  have hh : ‖w‖^2 < 1 := by
    simpa only [one_pow] using pow_lt_pow_left₀ hw (norm_nonneg w) (by norm_num : (2 : ℕ) ≠ 0)
  linarith [mul_pos hb (div_pos (sub_pos.mpr hh) hd)]

/-- A circle of radius (R<1) in the parameter disk moves each image
by at most (2b/(1-R)) from the center. -/
theorem norm_halfPlaneDiskMap_sub_center_le {a b R : ℝ} (hb : 0 < b) (hR : R < 1)
    {w : ℂ} (hw : ‖w‖ ≤ R) :
    ‖halfPlaneDiskMap a b w-((a+b : ℝ) : ℂ)‖ ≤ 2*b/(1-R) := by
  have hw₁ : w ≠ 1 := by intro e; rw [e,norm_one] at hw; linarith
  have hd := sub_ne_zero.mpr hw₁.symm
  have he : halfPlaneDiskMap a b w-((a+b : ℝ) : ℂ) = 2*(b : ℂ)*w/(1-w) := by
    unfold halfPlaneDiskMap
    push_cast
    field_simp [hd]
    ring
  have hden : 1-R ≤ ‖(1 : ℂ)-w‖ := by
    have h := norm_sub_norm_le (1 : ℂ) w
    rw [norm_one] at h
    linarith
  rw [he, norm_div, norm_mul, norm_mul, norm_ofNat, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hb]
  exact div_le_div₀ (by positivity) (by nlinarith [mul_nonneg hb.le (show 0 ≤ 1-‖w‖ by linarith)])
    (by linarith) hden

/-- A zero at least (epsilon) to the right of the boundary and within one
unit of the center height lies in the inner parameter disk. -/
theorem norm_halfPlaneDiskInverse_le {a ε : ℝ} (ha : 3/4 ≤ a)
    (hε : 0 < ε) {z : ℂ} (hz : a+ε ≤ z.re) (hz₁ : z.re ≤ 1) (hi : |z.im| ≤ 1) :
    ‖halfPlaneDiskInverse a (4-a) z‖ ≤ 1-ε/4 := by
  let b := 4-a
  let D := z-((a-b : ℝ) : ℂ)
  let N := z-((a+b : ℝ) : ℂ)
  have hb : 0 < b := by dsimp [b]; linarith
  have hDr : D.re = z.re-(a-b) := by simp [D]
  have hDi : D.im = z.im := by simp [D]
  have hNr : N.re = z.re-(a+b) := by simp [N]
  have hNi : N.im = z.im := by simp [N]
  have hD0 : D ≠ 0 := by
    intro he
    rw [he, zero_re] at hDr
    linarith
  have hDsq : ‖D‖^2 ≤ 16 := by
    have hNr₀ : 0 ≤ z.re-(a-b) := by linarith
    have hNr₁ : z.re-(a-b) ≤ 7/2 := by dsimp [b]; linarith
    have hre := pow_le_pow_left₀ hNr₀ hNr₁ 2
    have him := pow_le_pow_left₀ (abs_nonneg _) hi 2
    rw [sq_abs] at him
    rw [Complex.sq_norm, normSq_apply, hDr, hDi]
    nlinarith
  have hdif : ‖D‖^2-‖N‖^2 = 4*b*(z.re-a) := by
    rw [Complex.sq_norm, Complex.sq_norm, normSq_apply, normSq_apply, hDr, hDi, hNr, hNi]
    ring
  have hbd : 3 ≤ b := by dsimp [b]; linarith
  have hgap : 12*ε ≤ ‖D‖^2-‖N‖^2 := by
    rw [hdif]
    have h := mul_le_mul (show 3 ≤ b from hbd) (show ε ≤ z.re-a by linarith) hε.le hb.le
    nlinarith
  have hr₀ : 0 ≤ 1-ε/4 := by linarith
  have ht : 1-(1-ε/4)^2 ≤ ε/2 := by nlinarith [sq_nonneg ε]
  have ht₀ : 0 ≤ 1-(1-ε/4)^2 := by nlinarith [pow_le_pow_left₀ hr₀ (show 1-ε/4 ≤ 1 by linarith) 2]
  have htD : (1-(1-ε/4)^2)*‖D‖^2 ≤ 8*ε := by
    have h := mul_le_mul ht hDsq (sq_nonneg _) (by positivity : 0 ≤ ε/2)
    linarith
  change ‖N/D‖ ≤ 1-ε/4
  rw [norm_div]
  apply le_of_pow_le_pow_left₀ (by norm_num : (2 : ℕ) ≠ 0) hr₀
  rw [div_pow]
  exact (div_le_iff₀ (sq_pos_of_pos (norm_pos_iff.mpr hD0))).2 (by nlinarith)

end Legendre.Zeta
