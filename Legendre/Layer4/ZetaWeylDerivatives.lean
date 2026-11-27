/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.ZetaWeylReflection
public import Mathlib.Analysis.Complex.Liouville

@[expose] public section
namespace Legendre.Zeta
open Complex Set Metric

/-- One Weyl constant bounds derivatives of every order on the critical line.
Each derivative costs a factor of order k factorial and one logarithm. -/
theorem riemannZeta_critical_iteratedDeriv_weyl :
    ∃ C : ℝ, 0 < C ∧ ∀ t : ℝ, 3 ≤ |t| → ∀ k : ℕ,
      ‖iteratedDeriv k riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖ ≤
        C*(k.factorial : ℝ)*|t|^(1/6 : ℝ)*(1+Real.log |t|)*(8*(1+Real.log |t|))^k := by
  obtain ⟨P,hP,hweyl⟩ := riemannZeta_weyl_full_strip
  let C := 4*Real.exp (1/12)*P
  have hC : 0 < C := by dsimp [C]; positivity
  refine ⟨C,hC,?_⟩
  intro t ht k
  let T := |t|
  let L := 1+Real.log T
  let R := 1/(8*L)
  let c := (1/2 : ℂ)+(t : ℂ)*I
  let M := C*T^(1/6 : ℝ)*L
  have hT : 3 ≤ T := ht
  have hTp : 0 < T := by linarith only [hT]
  have hT₁ : 1 ≤ T := by linarith only [hT]
  have hLog : 0 ≤ Real.log T := Real.log_nonneg hT₁
  have hL : 1 ≤ L := by dsimp only [L]; linarith only [hLog]
  have hLp : 0 < L := by linarith only [hL]
  have hR : 0 < R := by dsimp only [R]; positivity
  have hR₁ : R ≤ 1/8 := by
    dsimp only [R]
    exact div_le_div_of_nonneg_left (by norm_num) (by norm_num) (by linarith only [hL])
  have hRL : R*Real.log T ≤ 1/8 := by
    dsimp only [R]
    rw [div_mul_eq_mul_div,one_mul]
    apply (div_le_iff₀ (by positivity : 0 < 8*L)).2
    dsimp only [L]
    linarith
  have hcRe : c.re = 1/2 := by norm_num [c]
  have hcIm : c.im = t := by norm_num [c]
  have hbranch (z : ℂ) (h : ‖z-c‖ ≤ R) :
      |z.re-1/2| ≤ R ∧ |z.im-t| ≤ R := by
    exact ⟨by simpa only [sub_re,hcRe] using (Complex.abs_re_le_norm (z-c)).trans h,
      by simpa only [sub_im,hcIm] using (Complex.abs_im_le_norm (z-c)).trans h⟩
  have hnp (z : ℂ) (hz : z ∈ closedBall c R) : z ≠ 1 := by
    intro h
    have h1 := (hbranch z (mem_closedBall_iff_norm.mp hz)).1
    rw [h, one_re,show (1 : ℝ)-1/2 = 1/2 by norm_num,abs_of_nonneg (by norm_num)] at h1
    linarith only [h1,hR₁]
  have hdd : DiffContOnCl ℂ riemannZeta (ball c R) := by
    constructor
    · exact fun z hz => (differentiableAt_riemannZeta
        (hnp z (ball_subset_closedBall hz))).differentiableWithinAt
    · rw [closure_ball c hR.ne']
      exact fun z hz => (differentiableAt_riemannZeta (hnp z hz)).continuousAt.continuousWithinAt
  have hcircle (z : ℂ) (hz : z ∈ sphere c R) : ‖riemannZeta z‖ ≤ M := by
    obtain ⟨hσ,hy⟩ := hbranch z (mem_sphere_iff_norm.mp hz).le
    have hσ₀ : z.re ∈ Icc (0 : ℝ) 1 := by
      constructor <;> linarith only [(abs_le.mp hσ).1,(abs_le.mp hσ).2,hR₁]
    have hY₁ : 2 ≤ |z.im| := by
      have h := abs_add_le (t-z.im) z.im
      rw [sub_add_cancel,abs_sub_comm t z.im] at h
      change T ≤ _ at h
      linarith only [h,hy,hR₁,hT]
    have hY₂ : |z.im| ≤ 2*T := by
      have h := abs_add_le (z.im-t) t
      rw [sub_add_cancel] at h
      change _ ≤ _+T at h
      linarith only [h,hy,hR₁,hT]
    let e := max ((1-z.re)/3) (1/2-2*z.re/3)
    have he₀ : 0 ≤ e := le_trans (by linarith only [hσ₀.2] : 0 ≤ (1-z.re)/3) (le_max_left _ _)
    have he₁ : e ≤ 1 := max_le (by linarith only [hσ₀.1]) (by linarith only [hσ₀.1])
    have heR : e-1/6 ≤ (2/3)*R := by
      have hh : e ≤ 1/6+(2/3)*R := max_le
        (by linarith only [(abs_le.mp hσ).1,hR])
        (by linarith only [(abs_le.mp hσ).1])
      linarith only [hh]
    have hsmall : T^(e-1/6) ≤ Real.exp (1/12) := by
      rw [Real.rpow_def_of_pos hTp,Real.exp_le_exp]
      have h := mul_le_mul_of_nonneg_right heR hLog
      nlinarith only [h,hRL]
    have hpow : |z.im|^e ≤ 2*(T^(1/6 : ℝ)*Real.exp (1/12)) := by
      apply (Real.rpow_le_rpow (abs_nonneg _) hY₂ he₀).trans
      rw [Real.mul_rpow (by norm_num) hTp.le,
        show e = (1/6 : ℝ)+(e-1/6) by ring, Real.rpow_add hTp]
      have hh : (2 : ℝ)^e ≤ 2 := by
        simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2) he₁
      rw [show (1/6 : ℝ)+(e-1/6) = e by ring]
      exact mul_le_mul hh (mul_le_mul_of_nonneg_left hsmall (by positivity)) (by positivity) (by norm_num)
    have hlog : 1+Real.log |z.im| ≤ 2*L := by
      have h := Real.log_le_log (show 0 < |z.im| by linarith only [hY₁]) hY₂
      rw [Real.log_mul (by norm_num) hTp.ne'] at h
      dsimp only [L]
      linarith only [h,hLog,Real.log_le_sub_one_of_pos (by norm_num : 0 < (2 : ℝ))]
    have hzeta := hweyl z.re hσ₀ z.im hY₁
    rw [Complex.re_add_im z] at hzeta
    apply hzeta.trans
    change P*|z.im|^e*(1+Real.log |z.im|) ≤ _
    have h := mul_le_mul (mul_le_mul_of_nonneg_left hpow hP.le) hlog
      (by linarith only [Real.log_nonneg (show 1 ≤ |z.im| by linarith only [hY₁])]) (by positivity)
    exact h.trans_eq (by dsimp only [C,M]; ring)
  have h := norm_iteratedDeriv_le_of_forall_mem_sphere_norm_le k hR hdd hcircle
  apply h.trans_eq
  change (k.factorial : ℝ)*M/R^k = C*(k.factorial : ℝ)*T^(1/6 : ℝ)*L*(8*L)^k
  dsimp only [R,M]
  rw [div_pow,one_pow,div_div_eq_mul_div,div_one]
  ring

end Legendre.Zeta
