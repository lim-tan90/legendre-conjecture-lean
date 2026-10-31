/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaCountingDisks
public import Legendre.ZetaReflection

/-!
# A finite multiplicity-preserving cover for all zeros through height T

Original deductions using mathlib v4.35.0 (Apache-2.0).
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric

/-- The fixed compact low-height zero set, allowing either sign of height. -/
def lowCountingSet : Set ℂ := {s | NontrivialZero s ∧ |s.im| ≤ 5}

/-- Low-height zeros form a finite set. -/
theorem lowCountingSet_finite : lowCountingSet.Finite := by
  have h := finite_zeros_on_compact
    (K := Set.Icc (0 : ℝ) 1 ×ℂ Set.Icc (-5 : ℝ) 5)
    (isCompact_Icc.reProdIm isCompact_Icc)
  apply h.subset
  intro s hs
  exact ⟨⟨⟨hs.1.2.1.le, hs.1.2.2.le⟩, (abs_le.mp hs.2)⟩, hs.1.1⟩

/-- The finite low-height support used in the global count. -/
noncomputable def lowCountingZeros : Finset ℂ := lowCountingSet_finite.toFinset

/-- Fixed finite low-height multiplicity contribution. -/
noncomputable def lowCountingDegree : ℕ := ∑ s ∈ lowCountingZeros, zeroMultiplicity s

/-- Heights of the disks in either half-plane; every such disk is above the analytic threshold. -/
noncomputable def countingHeight (k : ℕ) : ℝ := (k : ℝ) + 9 / 2

/-- Select the unit-height cell containing the absolute imaginary part. -/
noncomputable def countingHeightIndex (s : ℂ) : ℕ := ⌊|s.im|⌋₊ - 4

/-- Every selected positive or negative center is high enough for the Jensen bound. -/
theorem countingHeight_abs_ge (k : ℕ) : 4 ≤ |countingHeight k| ∧ 4 ≤ |-countingHeight k| := by
  have hp : 0 < countingHeight k := by unfold countingHeight; positivity
  rw [abs_neg, abs_of_pos hp]
  unfold countingHeight
  constructor <;> linarith [show (0 : ℝ) ≤ k from Nat.cast_nonneg k]

/-- The selected index lies in a finite range determined solely by the height cutoff. -/
theorem countingHeightIndex_lt {s : ℂ} {T : ℝ} (hs : |s.im| ≤ T) :
    countingHeightIndex s < ⌊T⌋₊ + 1 := by
  have h := Nat.floor_mono hs
  unfold countingHeightIndex
  omega

/-- The chosen positive center is the midpoint of the unit interval containing the height. -/
theorem countingHeight_index_eq {s : ℂ} (hs : 5 < |s.im|) :
    countingHeight (countingHeightIndex s) = (⌊|s.im|⌋₊ : ℝ) + 1 / 2 := by
  have hn : 4 ≤ ⌊|s.im|⌋₊ := (Nat.le_floor_iff (abs_nonneg s.im)).mpr (by norm_num; linarith)
  unfold countingHeight countingHeightIndex
  rw [Nat.cast_sub hn]
  norm_num
  ring

/-- Cell geometry: a unit-height right-half-strip cell lies in its selected counting disk. -/
theorem rightHalf_mem_counting_disk {s : ℂ} (hre : 1 / 2 ≤ s.re) (hre1 : s.re < 1)
    (hs : 5 < |s.im|) :
    s ∈ closedBall ((2 : ℂ) + ((if 0 ≤ s.im then countingHeight (countingHeightIndex s)
      else -countingHeight (countingHeightIndex s)) : ℝ) * I) (13 / 8) := by
  have hfloor := Nat.floor_le (abs_nonneg s.im)
  have hceil := Nat.lt_floor_add_one |s.im|
  have hcenter := countingHeight_index_eq hs
  have hRe : (s.re - 2) ^ 2 ≤ 9 / 4 := by
    nlinarith [mul_nonneg (show 0 ≤ s.re - 1 / 2 by linarith)
      (show 0 ≤ 1 - s.re by linarith)]
  let h := if 0 ≤ s.im then countingHeight (countingHeightIndex s)
      else -countingHeight (countingHeightIndex s)
  have hIm : (s.im - h) ^ 2 ≤ 1 / 4 := by
    dsimp [h]
    split_ifs with hi
    · rw [abs_of_nonneg hi] at hfloor hceil hcenter
      rw [hcenter]
      nlinarith [mul_nonneg (sub_nonneg.mpr hfloor) (sub_nonneg.mpr hceil.le)]
    · rw [abs_of_neg (lt_of_not_ge hi)] at hfloor hceil hcenter
      rw [hcenter]
      nlinarith [mul_nonneg (sub_nonneg.mpr hfloor) (sub_nonneg.mpr hceil.le)]
  rw [mem_closedBall, dist_eq_norm]
  apply (sq_le_sq₀ (norm_nonneg _) (by norm_num : (0 : ℝ) ≤ 13 / 8)).mp
  rw [Complex.sq_norm]
  change Complex.normSq (s - ((2 : ℂ) + (h : ℂ) * I)) ≤ (13 / 8 : ℝ) ^ 2
  simp only [Complex.normSq_apply, sub_re, add_re, re_ofNat, ofReal_re, mul_re,
    ofReal_im, I_re, I_im, mul_zero, sub_self, add_zero, sub_im, add_im, im_ofNat,
    mul_im, mul_one, zero_add]
  nlinarith

/-- High right-half-strip zeros occur in one of the two signed families of counting disks. -/
theorem rightHalf_mem_countingZeros {s : ℂ} (hszero : NontrivialZero s)
    (hre : 1 / 2 ≤ s.re) (hs : 5 < |s.im|) :
    s ∈ countingZeros (countingHeight (countingHeightIndex s)) ∪
      countingZeros (-countingHeight (countingHeightIndex s)) := by
  have hmem := rightHalf_mem_counting_disk hre hszero.2.2 hs
  by_cases hi : 0 ≤ s.im
  · rw [ite_eq_left hi] at hmem
    exact Finset.mem_union_left _ (mem_countingZeros
      (countingHeight_abs_ge _).1 hszero.1 hmem)
  · rw [ite_eq_right hi] at hmem
    exact Finset.mem_union_right _ (mem_countingZeros
      (countingHeight_abs_ge _).2 hszero.1 hmem)

/-- A finite target containing every reflected zero through height T. -/
noncomputable def globalCountingCover (T : ℝ) : Finset ℂ :=
  lowCountingZeros ∪ (Finset.range (⌊T⌋₊ + 1)).biUnion
    (fun k ↦ countingZeros (countingHeight k) ∪ countingZeros (-countingHeight k))

/-- The entire original upper-half-plane count injects into the finite cover after reflection. -/
theorem rightHalfZero_mem_cover {T : ℝ} {s : ℂ} (hs : s ∈ zerosUpTo T) :
    rightHalfZero s ∈ globalCountingCover T := by
  obtain ⟨hzero, hre, him, hmult⟩ := rightHalfZero_properties hs.1
  by_cases hlow : |(rightHalfZero s).im| ≤ 5
  · apply Finset.mem_union_left
    exact lowCountingSet_finite.mem_toFinset.mpr ⟨hzero, hlow⟩
  · apply Finset.mem_union_right
    apply Finset.mem_biUnion.mpr
    refine ⟨countingHeightIndex (rightHalfZero s), ?_, ?_⟩
    · apply Finset.mem_range.mpr
      apply countingHeightIndex_lt
      rw [him, abs_of_pos hs.2.1]
      exact hs.2.2
    · exact rightHalf_mem_countingZeros hzero hre (lt_of_not_ge hlow)

end Legendre.Zeta
