/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaZeroRemoval

/-!
# Wider Jensen disks for covering the whole right half of the critical strip

Original deductions using mathlib v4.35.0 (Apache-2.0). The inner radius
13/8 covers a unit-height strip cell with 1/2≤Re(s)≤1; the outer radius
7/4 stays in Re(s)≥1/4. This supplies the local input to the global count.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric MeromorphicOn

/-- The larger counting disks stay in a positive half-plane and away from the pole. -/
theorem counting_disk_coordinates {t : ℝ} (ht : 4 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (7 / 4)) :
    1 / 4 ≤ s.re ∧ 1 ≤ |s.im| := by
  have hn : ‖s - ((2 : ℂ) + (t : ℂ) * I)‖ ≤ 7 / 4 := by
    simpa only [mem_closedBall, dist_eq_norm] using hs
  have hr := (abs_re_le_norm (s - ((2 : ℂ) + (t : ℂ) * I))).trans hn
  have hi := (abs_im_le_norm (s - ((2 : ℂ) + (t : ℂ) * I))).trans hn
  simp only [sub_re, add_re, re_ofNat, ofReal_re, mul_re, ofReal_im, I_re, I_im,
    mul_zero, sub_self, add_zero, sub_im, add_im, im_ofNat, mul_im, mul_one, zero_add] at hr hi
  constructor
  · linarith [(abs_le.mp hr).1]
  · have htri := abs_sub_abs_le_abs_sub t s.im
    rw [abs_sub_comm t s.im] at htri
    linarith

/-- The counting disks exclude s=1. -/
theorem counting_disk_ne_one {t : ℝ} (ht : 4 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (7 / 4)) : s ≠ 1 := by
  intro he
  have h := (counting_disk_coordinates ht hs).2
  simp only [he, one_im, abs_zero] at h
  norm_num at h

/-- Analyticity on the outer counting disk. -/
theorem riemannZeta_analyticOnNhd_counting_disk {t : ℝ} (ht : 4 ≤ |t|) :
    AnalyticOnNhd ℂ riemannZeta (closedBall ((2 : ℂ) + (t : ℂ) * I) (7 / 4)) :=
  fun s hs ↦ analyticOn_riemannZeta s (counting_disk_ne_one ht hs)

/-- Polynomial bound on the larger counting disk. -/
theorem norm_riemannZeta_counting_disk_le {t : ℝ} (ht : 4 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (7 / 4)) :
    ‖riemannZeta s‖ ≤ 20 * (|t| + 2) := by
  obtain ⟨hre, him⟩ := counting_disk_coordinates ht hs
  have hn : 1 ≤ ‖s - 1‖ := him.trans (by simpa using abs_im_le_norm (s - 1))
  have hdiv : ‖s‖ / s.re ≤ 4 * ‖s‖ := by
    have h := div_le_div_of_nonneg_left (norm_nonneg s) (by norm_num : (0 : ℝ) < 1 / 4) hre
    linarith
  have hg := norm_riemannZeta_le_positive_re (by linarith : 0 < s.re) (counting_disk_ne_one ht hs)
  have hsmall := div_le_self (norm_nonneg s) hn
  have hdist : ‖s - ((2 : ℂ) + (t : ℂ) * I)‖ ≤ 7 / 4 := by
    simpa only [mem_closedBall, dist_eq_norm] using hs
  have hc : ‖(2 : ℂ) + (t : ℂ) * I‖ ≤ 2 + |t| := by
    simpa only [norm_ofNat, norm_mul, norm_real, Real.norm_eq_abs, norm_I, mul_one] using
      norm_add_le (2 : ℂ) ((t : ℂ) * I)
  have htri := norm_le_norm_sub_add s ((2 : ℂ) + (t : ℂ) * I)
  linarith [abs_nonneg t]

/-- Divisor on the inner counting disk. -/
noncomputable def countingDivisor (t : ℝ) :=
  divisor riemannZeta (closedBall ((2 : ℂ) + (t : ℂ) * I) (13 / 8))

/-- The support is finite, even before any summation convention is used. -/
theorem countingDivisor_finite (t : ℝ) : (countingDivisor t).support.Finite :=
  (countingDivisor t).finiteSupport (isCompact_closedBall _ _)

/-- Finite set of the selected zero locations. -/
noncomputable def countingZeros (t : ℝ) : Finset ℂ := (countingDivisor_finite t).toFinset

/-- Total multiplicity in an inner counting disk. -/
noncomputable def countingDegree (t : ℝ) : ℕ := ∑ s ∈ countingZeros t, zeroMultiplicity s

/-- The divisor recovers the natural zero multiplicity on the inner counting disk. -/
theorem countingDivisor_eq_multiplicity {t : ℝ} (ht : 4 ≤ |t|) {s : ℂ}
    (hs : s ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (13 / 8)) :
    countingDivisor t s = (zeroMultiplicity s : ℤ) := by
  have hsbig := (closedBall_subset_closedBall (by norm_num : (13 / 8 : ℝ) ≤ 7 / 4)) hs
  have hA := riemannZeta_analyticOnNhd_counting_disk ht
  rw [countingDivisor, (hA.meromorphicOn.mono_set
    (closedBall_subset_closedBall (by norm_num : (13 / 8 : ℝ) ≤ 7 / 4))).divisor_apply hs,
    riemannZeta_meromorphicOrderAt_eq (counting_disk_ne_one ht hsbig)]
  simp

/-- The finite natural count agrees with the integer divisor sum. -/
theorem countingDegree_cast {t : ℝ} (ht : 4 ≤ |t|) :
    (countingDegree t : ℤ) = ∑ᶠ u : ℂ, countingDivisor t u := by
  rw [finsum_eq_sum_of_support_subset _ (by
    intro u hu
    exact (countingDivisor_finite t).mem_toFinset.mpr hu)]
  simp only [countingDegree, Nat.cast_sum]
  apply Finset.sum_congr rfl
  intro u hu
  exact (countingDivisor_eq_multiplicity ht ((countingDivisor t).supportWithinDomain
    ((countingDivisor_finite t).mem_toFinset.mp hu))).symm

/-- A zero in the inner disk belongs to the finite counting support. -/
theorem mem_countingZeros {t : ℝ} (ht : 4 ≤ |t|) {s : ℂ} (hzero : riemannZeta s = 0)
    (hs : s ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (13 / 8)) : s ∈ countingZeros t := by
  apply (countingDivisor_finite t).mem_toFinset.mpr
  change countingDivisor t s ≠ 0
  rw [countingDivisor_eq_multiplicity ht hs]
  have hsbig := (closedBall_subset_closedBall (by norm_num : (13 / 8 : ℝ) ≤ 7 / 4)) hs
  have hpos : 0 < s.re := by have h := (counting_disk_coordinates ht hsbig).1; linarith
  have hlt : s.re < 1 := by
    by_contra h
    exact riemannZeta_ne_zero_of_one_le_re (not_lt.mp h) hzero
  exact_mod_cast (zeroMultiplicity_pos ⟨hzero, hpos, hlt⟩).ne'

/-- Uniform logarithmic multiplicity bound for every counting disk. -/
theorem countingDegree_le {t : ℝ} (ht : 4 ≤ |t|) :
    (countingDegree t : ℝ) ≤ Real.log (40 * (|t| + 2)) / Real.log (14 / 13) := by
  let c := (2 : ℂ) + (t : ℂ) * I
  let M := 20 * (|t| + 2)
  have hM : 1 ≤ M := by dsimp [M]; linarith [abs_nonneg t]
  have hc := one_half_le_norm_riemannZeta_disk_center t
  have hnorm : 0 < ‖riemannZeta c‖ := by dsimp [c]; linarith
  have hJ := AnalyticOnNhd.sum_divisor_le (f := riemannZeta) (c := c)
    (r := 13 / 8) (R := 7 / 4) (M := M) (by norm_num) (by norm_num) hM
    (by simpa only [abs_of_pos (by norm_num : (0 : ℝ) < 7 / 4)] using
      riemannZeta_analyticOnNhd_counting_disk ht) (norm_pos_iff.mp hnorm)
    (fun z hz ↦ norm_riemannZeta_counting_disk_le ht (sphere_subset_closedBall (by
      simpa only [abs_of_pos (by norm_num : (0 : ℝ) < 7 / 4)] using hz)))
  norm_num at hJ
  have hJ' : ((∑ᶠ u : ℂ, countingDivisor t u : ℤ) : ℝ) ≤
      Real.log (M / ‖riemannZeta c‖) / Real.log (14 / 13) := by
    dsimp only [countingDivisor]
    convert! hJ using 1
    apply congrArg (fun n : ℤ ↦ (n : ℝ))
    apply finsum_congr
    intro u
    congr 2 <;> congr 1 <;> norm_num
  have hdeg : (countingDegree t : ℝ) = ((∑ᶠ u : ℂ, countingDivisor t u : ℤ) : ℝ) := by
    exact_mod_cast countingDegree_cast ht
  rw [hdeg]
  apply hJ'.trans
  apply div_le_div_of_nonneg_right _ (Real.log_nonneg (by norm_num : (1 : ℝ) ≤ 14 / 13))
  apply Real.log_le_log (div_pos (by linarith : 0 < M) hnorm)
  have hfrac : M / ‖riemannZeta c‖ ≤ 2 * M := by
    apply (div_le_iff₀ hnorm).mpr
    dsimp [c] at hc ⊢
    nlinarith
  exact hfrac.trans_eq (by dsimp [M]; ring)

end Legendre.Zeta
