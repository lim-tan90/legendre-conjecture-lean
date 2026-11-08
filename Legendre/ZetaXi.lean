/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaGrowth

/-!
# An entire self-dual completion for zeta square contours

The two completed-zeta poles are removed by s(s-1), retaining the functional
equation. The normalized polynomial shift costs no power of the base height.
-/

@[expose] public section

namespace Legendre.Zeta
open Complex

/-- Twice the classical xi function, normalized to take value one at zero and one. -/
noncomputable def zetaXi (s : ℂ) : ℂ := 1+s*(s-1)*completedRiemannZeta₀ s

theorem zetaXi_differentiable : Differentiable ℂ zetaXi := by
  unfold zetaXi
  exact (differentiable_const (1 : ℂ)).add
    ((differentiable_id.mul (differentiable_id.sub_const 1)).mul differentiable_completedZeta₀)

@[simp] theorem zetaXi_zero : zetaXi 0 = 1 := by simp [zetaXi]
@[simp] theorem zetaXi_one : zetaXi 1 = 1 := by simp [zetaXi]

theorem zetaXi_one_sub (s : ℂ) : zetaXi (1-s) = zetaXi s := by
  rw [zetaXi,zetaXi,completedRiemannZeta₀_one_sub]
  ring

theorem zetaXi_eq_completed {s : ℂ} (hs0 : s ≠ 0) (hs1 : s ≠ 1) :
    zetaXi s = s*(s-1)*completedRiemannZeta s := by
  rw [zetaXi,completedRiemannZeta_eq]
  field_simp
  ring

theorem zetaXi_eq_gamma_poleRemoved {s : ℂ} (hs : 0 < s.re) :
    zetaXi s = s*Gammaℝ s*poleRemovedZeta s := by
  by_cases hs1 : s = 1
  · subst s
    simp [Gammaℝ_one,poleRemovedZeta_one]
  have hs0 : s ≠ 0 := by intro he; simp only [he,zero_re,lt_self_iff_false] at hs
  have hΓ := Gammaℝ_ne_zero_of_re_pos hs
  rw [zetaXi_eq_completed hs0 hs1,poleRemovedZeta_eq hs1,riemannZeta_def_of_ne_zero hs0]
  field_simp

theorem zetaXi_eq_gamma_zeta {s : ℂ} (hs : 0 < s.re) (hs1 : s ≠ 1) :
    zetaXi s = s*(s-1)*Gammaℝ s*riemannZeta s := by
  rw [zetaXi_eq_gamma_poleRemoved hs,poleRemovedZeta_eq hs1]
  ring

theorem zetaXi_zero_iff {s : ℂ} (hs : 0 < s.re) (hs1 : s ≠ 1) :
    zetaXi s = 0 ↔ riemannZeta s = 0 := by
  have hs0 : s ≠ 0 := by intro he; simp only [he,zero_re,lt_self_iff_false] at hs
  rw [zetaXi_eq_gamma_zeta hs hs1]
  simp only [mul_eq_zero,hs0,sub_ne_zero.2 hs1,Gammaℝ_ne_zero_of_re_pos hs,
    false_or]

/-- The extra polynomial factor in a normalized shifted xi kernel costs no height power. -/
theorem xi_polynomial_shift_ratio_le {s : ℂ} (hs : s.re = 1/2) (w : ℂ) :
    ‖(s+w)*(s+w-1)/(s*(s-1))‖ ≤ (1+2*‖w‖)^2 := by
  have hsn : (1/2 : ℝ) ≤ ‖s‖ := by rw [← hs]; exact re_le_norm s
  have hs1n : (1/2 : ℝ) ≤ ‖s-1‖ := by
    have h := abs_re_le_norm (s-1)
    norm_num [sub_re,hs] at h
    exact h
  have hsp : 0 < ‖s‖ := by linarith
  have hs1p : 0 < ‖s-1‖ := by linarith
  have hfirst : ‖s+w‖/‖s‖ ≤ 1+2*‖w‖ := by
    apply (div_le_iff₀ hsp).2
    have hn := norm_add_le s w
    nlinarith [norm_nonneg w]
  have hsecond : ‖s+w-1‖/‖s-1‖ ≤ 1+2*‖w‖ := by
    rw [show s+w-1 = (s-1)+w by ring]
    apply (div_le_iff₀ hs1p).2
    have hn := norm_add_le (s-1) w
    nlinarith [norm_nonneg w]
  rw [norm_div,norm_mul,norm_mul,← div_mul_div_comm]
  simpa only [pow_two] using mul_le_mul hfirst hsecond (by positivity) (by positivity)

end Legendre.Zeta
