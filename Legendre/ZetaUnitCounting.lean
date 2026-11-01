/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaGlobalCounting

/-!
# Multiplicity-weighted zero counts in unit-height intervals

Two signed Jensen disks cover the reflection of an entire unit-height cell.
The resulting bound is logarithmic in height, not the global O(T log T) bound.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric

/-- A closed upper-half-plane unit-height cell in the critical strip. -/
def unitZeros (H : ℝ) : Set ℂ :=
  {s | NontrivialZero s ∧ H ≤ s.im ∧ s.im ≤ H+1}

/-- The cell contains finitely many zero locations. -/
theorem unitZeros_finite (H : ℝ) : (unitZeros H).Finite := by
  apply (finite_zeros_on_compact (K := Set.Icc (0 : ℝ) 1 ×ℂ Set.Icc H (H+1))
    (isCompact_Icc.reProdIm isCompact_Icc)).subset
  intro s hs
  exact ⟨⟨⟨hs.1.2.1.le, hs.1.2.2.le⟩, hs.2⟩, hs.1.1⟩

/-- Total analytic multiplicity in the cell, including its two height endpoints. -/
noncomputable def unitZeroCount (H : ℝ) : ℕ :=
  ∑ s ∈ (unitZeros_finite H).toFinset, zeroMultiplicity s

/-- The right half of a unit cell fits in a single inner Jensen disk. -/
theorem unitCell_mem_counting_disk {s : ℂ} {t : ℝ} (hre : 1/2 ≤ s.re)
    (hre1 : s.re < 1) (him : |s.im-t| ≤ 1/2) :
    s ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (13/8) := by
  have hr : (s.re-2)^2 ≤ 9/4 := by
    nlinarith [mul_nonneg (show 0 ≤ s.re-1/2 by linarith) (show 0 ≤ 1-s.re by linarith)]
  have hi : (s.im-t)^2 ≤ 1/4 := by
    have h := abs_le.1 him
    nlinarith [mul_nonneg (by linarith : 0 ≤ s.im-t+1/2) (by linarith : 0 ≤ 1/2-(s.im-t))]
  rw [mem_closedBall, dist_eq_norm]
  apply (sq_le_sq₀ (norm_nonneg _) (by norm_num : (0 : ℝ) ≤ 13/8)).1
  rw [Complex.sq_norm]
  simp only [Complex.normSq_apply, sub_re, add_re, re_ofNat, ofReal_re, mul_re,
    ofReal_im, I_re, I_im, mul_zero, sub_self, add_zero, sub_im, add_im, im_ofNat,
    mul_im, mul_one, zero_add]
  nlinarith

/-- Reflection sends every unit-cell zero into one of two signed counting disks. -/
theorem rightHalfZero_mem_unit_cover {H : ℝ} (hH : 4 ≤ H) {s : ℂ} (hs : s ∈ unitZeros H) :
    rightHalfZero s ∈ countingZeros (H+1/2) ∪ countingZeros (-(H+1/2)) := by
  have hp : 0 < H+1/2 := by linarith
  have ht : 4 ≤ |H+1/2| := by rw [abs_of_pos hp]; linarith
  have htn : 4 ≤ |-(H+1/2)| := by rw [abs_neg]; exact ht
  unfold rightHalfZero
  split_ifs with hre
  · apply Finset.mem_union_left
    apply mem_countingZeros ht hs.1.1
    apply unitCell_mem_counting_disk hre hs.1.2.2
    rw [abs_le]
    constructor <;> linarith [hs.2.1, hs.2.2]
  · apply Finset.mem_union_right
    apply mem_countingZeros htn hs.1.one_sub.1
    apply unitCell_mem_counting_disk
      (by simp only [sub_re, one_re]; linarith) hs.1.one_sub.2.2
    simp only [sub_im, one_im, zero_sub]
    rw [abs_le]
    constructor <;> linarith [hs.2.1, hs.2.2]

/-- The reflection preserves multiplicity and injects the upper cell into its two-disk cover. -/
theorem unitZeroCount_le_countingDegrees {H : ℝ} (hH : 4 ≤ H) :
    unitZeroCount H ≤ countingDegree (H+1/2)+countingDegree (-(H+1/2)) := by
  classical
  have hinj : unitZeroCount H ≤
      ∑ z ∈ countingZeros (H+1/2) ∪ countingZeros (-(H+1/2)), zeroMultiplicity z := by
    unfold unitZeroCount
    apply Finset.sum_le_sum_of_injOn rightHalfZero
    · intro s hs z hz he
      have hs' := (unitZeros_finite H).mem_toFinset.1 hs
      have hz' := (unitZeros_finite H).mem_toFinset.1 hz
      exact rightHalfZero_injOn (by change 0 < s.im; linarith [hs'.2.1])
        (by change 0 < z.im; linarith [hz'.2.1]) he
    · intro z hz
      obtain ⟨s, hs, rfl⟩ := Finset.mem_image.1 hz
      exact rightHalfZero_mem_unit_cover hH ((unitZeros_finite H).mem_toFinset.1 hs)
    · intro s hs
      exact (rightHalfZero_properties ((unitZeros_finite H).mem_toFinset.1 hs).1).2.2.2.ge
    · intro z hz hnot
      exact Nat.zero_le _
  exact hinj.trans (sum_zeroMultiplicity_union_le _ _)

/-- Explicit logarithmic unit-height count, with analytic multiplicity. -/
theorem unitZeroCount_le_log {H : ℝ} (hH : 4 ≤ H) :
    (unitZeroCount H : ℝ) ≤ 2*Real.log (40*(H+3))/Real.log (14/13) := by
  have hp : 0 < H+1/2 := by linarith
  have ht : 4 ≤ |H+1/2| := by rw [abs_of_pos hp]; linarith
  have htn : 4 ≤ |-(H+1/2)| := by rw [abs_neg]; exact ht
  have hb := countingDegree_le ht
  have hn := countingDegree_le htn
  rw [abs_of_pos hp] at hb
  rw [abs_neg, abs_of_pos hp] at hn
  have hlog : Real.log (40*(H+1/2+2)) ≤ Real.log (40*(H+3)) :=
    Real.log_le_log (by positivity) (by linarith)
  have hdiv := div_le_div_of_nonneg_right hlog
    (Real.log_nonneg (by norm_num : (1 : ℝ) ≤ 14/13))
  have hc : (unitZeroCount H : ℝ) ≤
      (countingDegree (H+1/2) : ℝ)+(countingDegree (-(H+1/2)) : ℝ) := by
    exact_mod_cast unitZeroCount_le_countingDegrees hH
  calc
    _ ≤ Real.log (40*(H+3))/Real.log (14/13) +
        Real.log (40*(H+3))/Real.log (14/13) :=
      hc.trans (add_le_add (hb.trans hdiv) (hn.trans hdiv))
    _ = _ := by ring

/-- Distinct locations are dominated by the multiplicity-weighted cell count. -/
theorem unitZeros_card_le_count (H : ℝ) :
    (unitZeros_finite H).toFinset.card ≤ unitZeroCount H := by
  rw [Finset.card_eq_sum_ones, unitZeroCount]
  apply Finset.sum_le_sum
  intro s hs
  exact zeroMultiplicity_pos ((unitZeros_finite H).mem_toFinset.1 hs).1

/-- Every increment N(H+1)−N(H) is bounded by its unit-cell count. -/
theorem zeroCount_increment_le_unitZeroCount (H : ℝ) :
    zeroCount (H+1)-zeroCount H ≤ unitZeroCount H := by
  classical
  have hsub : (zerosUpTo_finite (H+1)).toFinset ⊆
      (zerosUpTo_finite H).toFinset ∪ (unitZeros_finite H).toFinset := by
    intro s hs
    have hs' := (zerosUpTo_finite (H+1)).mem_toFinset.1 hs
    by_cases h : s.im ≤ H
    · exact Finset.mem_union_left _ ((zerosUpTo_finite H).mem_toFinset.2 ⟨hs'.1, hs'.2.1,h⟩)
    · exact Finset.mem_union_right _ ((unitZeros_finite H).mem_toFinset.2
        ⟨hs'.1,(not_le.1 h).le,hs'.2.2⟩)
  have hcount := (Finset.sum_le_sum_of_subset hsub (f := zeroMultiplicity)).trans
    (sum_zeroMultiplicity_union_le _ _)
  change zeroCount (H+1) ≤ zeroCount H+unitZeroCount H at hcount
  omega

end Legendre.Zeta
