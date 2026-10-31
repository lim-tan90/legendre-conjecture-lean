/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaGrowth
public import Mathlib.Analysis.Complex.JensenFormula

/-!
# Explicit local zeta bounds and Jensen zero counting

Original deductions using mathlib v4.35.0 (Apache-2.0). Disks centered at
2+it, with |t|≥3, have a polynomial upper bound and a uniform nonzero
center value. Jensen's inequality bounds their zeros with multiplicity.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric MeromorphicOn

/-- Geometry of the disks used for local zero estimates; they stay clear of the pole. -/
theorem zeta_disk_coordinates {t : ℝ} (ht : 3 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) :
    1 / 2 ≤ s.re ∧ 1 ≤ |s.im| := by
  have hn : ‖s - ((2 : ℂ) + (t : ℂ) * I)‖ ≤ 3 / 2 := by
    simpa only [mem_closedBall, dist_eq_norm] using hs
  have hr := (abs_re_le_norm (s - ((2 : ℂ) + (t : ℂ) * I))).trans hn
  have hi := (abs_im_le_norm (s - ((2 : ℂ) + (t : ℂ) * I))).trans hn
  simp only [sub_re, add_re, re_ofNat, ofReal_re, mul_re, ofReal_im, I_re, I_im,
    mul_zero, sub_self, add_zero, sub_im, add_im, im_ofNat, mul_im,
    mul_one, zero_add] at hr hi
  constructor
  · linarith [(abs_le.mp hr).1]
  · have htri := abs_sub_abs_le_abs_sub t s.im
    rw [abs_sub_comm t s.im] at htri
    linarith

/-- Holomorphy on the entire larger disk used in Jensen's inequality. -/
theorem riemannZeta_analyticOnNhd_disk {t : ℝ} (ht : 3 ≤ |t|) :
    AnalyticOnNhd ℂ riemannZeta (closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) := by
  intro s hs
  apply analyticOn_riemannZeta s
  change s ≠ 1
  intro heq
  have h := (zeta_disk_coordinates ht hs).2
  simp only [heq, one_im, abs_zero] at h
  norm_num at h

/-- An explicit polynomial upper bound on the larger disk. -/
theorem norm_riemannZeta_disk_le {t : ℝ} (ht : 3 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) :
    ‖riemannZeta s‖ ≤ 12 * (|t| + 2) := by
  obtain ⟨hre, him⟩ := zeta_disk_coordinates ht hs
  have hn : ‖s - ((2 : ℂ) + (t : ℂ) * I)‖ ≤ 3 / 2 := by
    simpa only [mem_closedBall, dist_eq_norm] using hs
  have hc : ‖(2 : ℂ) + (t : ℂ) * I‖ ≤ 2 + |t| := by
    simpa only [norm_ofNat, norm_mul, norm_real, Real.norm_eq_abs, norm_I, mul_one] using
      norm_add_le (2 : ℂ) ((t : ℂ) * I)
  have hnorm := norm_le_norm_sub_add s ((2 : ℂ) + (t : ℂ) * I)
  have hg := norm_riemannZeta_le_three_mul_norm hre him
  linarith [abs_nonneg t]

/-- The center value has a uniform lower bound, independent of height. -/
theorem one_half_le_norm_riemannZeta_disk_center (t : ℝ) :
    1 / 2 ≤ ‖riemannZeta ((2 : ℂ) + (t : ℂ) * I)‖ :=
  one_half_le_norm_riemannZeta (by simp)

/-- Explicit logarithmic upper bound for the local number of zeros, with analytic multiplicity.
The divisor is supported in the closed disk of radius 5/4, and the larger disk has radius 3/2. -/
theorem zeta_local_divisor_sum_le {t : ℝ} (ht : 3 ≤ |t|) :
    ((∑ᶠ u : ℂ, divisor riemannZeta
      (closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)) u : ℤ) : ℝ) ≤
        Real.log (24 * (|t| + 2)) / Real.log (6 / 5) := by
  let c := (2 : ℂ) + (t : ℂ) * I
  let M := 12 * (|t| + 2)
  have hM : 1 ≤ M := by dsimp [M]; linarith [abs_nonneg t]
  have hc := one_half_le_norm_riemannZeta_disk_center t
  have hnorm : 0 < ‖riemannZeta c‖ := by dsimp [c]; linarith
  have hJ := AnalyticOnNhd.sum_divisor_le (f := riemannZeta) (c := c)
    (r := 5 / 4) (R := 3 / 2) (M := M) (by norm_num) (by norm_num) hM
    (by simpa only [abs_of_pos (by norm_num : (0 : ℝ) < 3 / 2)] using
      riemannZeta_analyticOnNhd_disk ht) (norm_pos_iff.mp hnorm)
    (fun z hz ↦ norm_riemannZeta_disk_le ht (sphere_subset_closedBall (by
      simpa only [abs_of_pos (by norm_num : (0 : ℝ) < 3 / 2)] using hz)))
  norm_num at hJ
  have hJ' : ((∑ᶠ u : ℂ, divisor riemannZeta (closedBall c (5 / 4)) u : ℤ) : ℝ) ≤
      Real.log (M / ‖riemannZeta c‖) / Real.log (6 / 5) := by
    convert! hJ using 1
    apply congrArg (fun n : ℤ ↦ (n : ℝ))
    apply finsum_congr
    intro u
    congr 2 <;> congr 1 <;> norm_num
  apply hJ'.trans
  apply div_le_div_of_nonneg_right _ (Real.log_nonneg (by norm_num : (1 : ℝ) ≤ 6 / 5))
  apply Real.log_le_log (div_pos (by linarith : 0 < M) hnorm)
  have hfrac : M / ‖riemannZeta c‖ ≤ 2 * M := by
    apply (div_le_iff₀ hnorm).mpr
    dsimp [c] at hc ⊢
    nlinarith
  exact hfrac.trans_eq (by dsimp [M]; ring)

end Legendre.Zeta
