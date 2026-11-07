/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaSecondEuler
public import Legendre.ZetaNegativeStrip
public import Legendre.ZetaLocalBound

/-!
# Polynomial bounds and Jensen counting across the entire critical strip

The outer radius 5/2 reaches Re(s)=-1/2; second Euler summation gives a
polynomial bound there. The inner radius 9/4 leaves room for a Cauchy
estimate on the fixed negative Perron edge Re(s)=-1/8.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric MeromorphicOn

/-- Geometry of the wide high disks, which remain away from s=1. -/
theorem wide_zeta_disk_coordinates {t : ℝ} (ht : 4 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (5/2)) :
    -(1/2) ≤ s.re ∧ 1 ≤ |s.im| := by
  have hn : ‖s-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 5/2 := by
    simpa only [mem_closedBall,dist_eq_norm] using hs
  have hr := (abs_re_le_norm (s-((2 : ℂ)+(t : ℂ)*I))).trans hn
  have hi := (abs_im_le_norm (s-((2 : ℂ)+(t : ℂ)*I))).trans hn
  simp only [sub_re,add_re,re_ofNat,ofReal_re,mul_re,ofReal_im,I_re,I_im,
    mul_zero,sub_self,add_zero,sub_im,add_im,im_ofNat,mul_im,mul_one,zero_add] at hr hi
  constructor
  · linarith [(abs_le.1 hr).1]
  · have htri := abs_sub_abs_le_abs_sub t s.im
    rw [abs_sub_comm t s.im] at htri
    linarith

/-- The large disk avoids the zeta pole. -/
theorem wide_zeta_disk_ne_one {t : ℝ} (ht : 4 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (5/2)) : s ≠ 1 := by
  intro he
  have h := (wide_zeta_disk_coordinates ht hs).2
  simp only [he,one_im,abs_zero] at h
  norm_num at h

/-- Analyticity on the whole enlarged disk. -/
theorem riemannZeta_analyticOnNhd_wide_disk {t : ℝ} (ht : 4 ≤ |t|) :
    AnalyticOnNhd ℂ riemannZeta (closedBall ((2 : ℂ)+(t : ℂ)*I) (5/2)) :=
  fun s hs => analyticOn_riemannZeta s (wide_zeta_disk_ne_one ht hs)

/-- Polynomial growth, uniform in the height, on the enlarged disk. -/
theorem norm_riemannZeta_wide_disk_le {t : ℝ} (ht : 4 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (5/2)) :
    ‖riemannZeta s‖ ≤ 4*(|t|+5)^2 := by
  obtain ⟨hre,him⟩ := wide_zeta_disk_coordinates ht hs
  have hg := norm_riemannZeta_le_second_euler hre (wide_zeta_disk_ne_one ht hs)
  have hn : 1 ≤ ‖s-1‖ := him.trans (by simpa using abs_im_le_norm (s-1))
  have hi : 1/‖s-1‖ ≤ 1 := (div_le_one (by linarith : 0 < ‖s-1‖)).2 hn
  have hdist : ‖s-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 5/2 := by
    simpa only [mem_closedBall,dist_eq_norm] using hs
  have hc : ‖(2 : ℂ)+(t : ℂ)*I‖ ≤ 2+|t| := by
    simpa only [norm_ofNat,norm_mul,norm_real,Real.norm_eq_abs,norm_I,mul_one] using
      norm_add_le (2 : ℂ) ((t : ℂ)*I)
  have htri := norm_le_norm_sub_add s ((2 : ℂ)+(t : ℂ)*I)
  have hb : ‖s‖ ≤ |t|+5 := by linarith
  have hq := mul_le_mul_of_nonneg_left hb (norm_nonneg s)
  nlinarith [abs_nonneg t,norm_nonneg s,sq_nonneg (|t|+5-‖s‖)]

/-- Jensen bound on the total zero multiplicity in the wide inner disk. -/
theorem zeta_wide_divisor_sum_le {t : ℝ} (ht : 4 ≤ |t|) :
    ((∑ᶠ u : ℂ,divisor riemannZeta
      (closedBall ((2 : ℂ)+(t : ℂ)*I) (9/4)) u : ℤ) : ℝ) ≤
      Real.log (8*(|t|+5)^2)/Real.log (10/9) := by
  let c := (2 : ℂ)+(t : ℂ)*I
  let M := 4*(|t|+5)^2
  have hM : 1 ≤ M := by dsimp [M]; nlinarith [abs_nonneg t]
  have hc := one_half_le_norm_riemannZeta_disk_center t
  have hnorm : 0 < ‖riemannZeta c‖ := by dsimp [c]; linarith
  have hJ := AnalyticOnNhd.sum_divisor_le (f := riemannZeta) (c := c)
    (r := 9/4) (R := 5/2) (M := M) (by norm_num) (by norm_num) hM
    (by simpa only [abs_of_pos (by norm_num : (0 : ℝ) < 5/2)] using
      riemannZeta_analyticOnNhd_wide_disk ht) (norm_pos_iff.mp hnorm)
    (fun z hz => norm_riemannZeta_wide_disk_le ht (sphere_subset_closedBall (by
      simpa only [abs_of_pos (by norm_num : (0 : ℝ) < 5/2)] using hz)))
  norm_num at hJ
  have hJ' : ((∑ᶠ u : ℂ,divisor riemannZeta (closedBall c (9/4)) u : ℤ) : ℝ) ≤
      Real.log (M/‖riemannZeta c‖)/Real.log (10/9) := by
    convert! hJ using 1
    apply congrArg (fun n : ℤ => (n : ℝ))
    apply finsum_congr
    intro u
    congr 2 <;> congr 1 <;> norm_num
  apply hJ'.trans
  apply div_le_div_of_nonneg_right _ (Real.log_nonneg (by norm_num : (1 : ℝ) ≤ 10/9))
  apply Real.log_le_log (div_pos (by linarith : 0 < M) hnorm)
  have hfrac : M/‖riemannZeta c‖ ≤ 2*M := by
    apply (div_le_iff₀ hnorm).2
    dsimp [c] at hc ⊢
    nlinarith
  exact hfrac.trans_eq (by dsimp [M]; ring)

end Legendre.Zeta
