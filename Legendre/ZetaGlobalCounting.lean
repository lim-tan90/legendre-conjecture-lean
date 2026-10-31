/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaCountingCover

/-!
# A global multiplicity-weighted O(T log T) zero-counting bound

Original deductions using mathlib v4.35.0 (Apache-2.0). Reflection and a
finite cover turn the proved local Jensen bounds into a bound for N(T).
The fixed compact low-height contribution is kept explicitly. No
Riemann-von Mangoldt asymptotic or zero-density estimate is asserted.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology

/-- Overlapping finite covers give an upper bound, retaining zero multiplicity. -/
theorem sum_zeroMultiplicity_union_le (A B : Finset ℂ) :
    (∑ z ∈ A ∪ B, zeroMultiplicity z) ≤
      (∑ z ∈ A, zeroMultiplicity z) + ∑ z ∈ B, zeroMultiplicity z := by
  classical
  have h := Finset.sum_union_inter (s₁ := A) (s₂ := B) (f := zeroMultiplicity)
  omega

/-- The sum over a finite union of counting sets is bounded by the sum of their weighted counts. -/
theorem sum_zeroMultiplicity_biUnion_le (S : Finset ℕ) (F : ℕ → Finset ℂ) :
    (∑ z ∈ S.biUnion F, zeroMultiplicity z) ≤ ∑ k ∈ S, ∑ z ∈ F k, zeroMultiplicity z := by
  classical
  induction S using Finset.induction with
  | empty => simp
  | @insert k S hk ih =>
    rw [Finset.biUnion_insert, Finset.sum_insert hk]
    exact (sum_zeroMultiplicity_union_le _ _).trans (add_le_add le_rfl ih)

/-- The multiplicity-preserving injection bounds N(T) by the total weight of the finite cover. -/
theorem zeroCount_le_cover (T : ℝ) :
    zeroCount T ≤ ∑ z ∈ globalCountingCover T, zeroMultiplicity z := by
  classical
  unfold zeroCount
  apply Finset.sum_le_sum_of_injOn rightHalfZero
  · intro s hs z hz he
    have hs' : s ∈ zerosUpTo T := by simpa using hs
    have hz' : z ∈ zerosUpTo T := by simpa using hz
    exact rightHalfZero_injOn hs'.2.1 hz'.2.1 he
  · intro z hz
    obtain ⟨s, hs, rfl⟩ := Finset.mem_image.mp hz
    exact rightHalfZero_mem_cover (by simpa using hs)
  · intro s hs
    exact (rightHalfZero_properties (show s ∈ zerosUpTo T from by simpa using hs).1).2.2.2.ge
  · intro z hz hnot
    exact Nat.zero_le _

/-- A global finite sum bound for the original N(T), including both sides of the critical line. -/
theorem zeroCount_le_sum_countingDegree (T : ℝ) :
    zeroCount T ≤ lowCountingDegree + ∑ k ∈ Finset.range (⌊T⌋₊ + 1),
      (countingDegree (countingHeight k) + countingDegree (-countingHeight k)) := by
  apply (zeroCount_le_cover T).trans
  unfold globalCountingCover
  apply (sum_zeroMultiplicity_union_le _ _).trans
  apply add_le_add le_rfl
  apply (sum_zeroMultiplicity_biUnion_le _ _).trans
  apply Finset.sum_le_sum
  intro k hk
  exact sum_zeroMultiplicity_union_le _ _

/-- Finite explicit-in-T global bound; the first term is a fixed finite low-height count. -/
theorem zeroCount_le_global_bound {T : ℝ} (hT : 0 ≤ T) :
    (zeroCount T : ℝ) ≤ (lowCountingDegree : ℝ) +
      2 * (⌊T⌋₊ + 1 : ℕ) * (Real.log (40 * (T + 7)) / Real.log (14 / 13)) := by
  have hnat := zeroCount_le_sum_countingDegree T
  have hreal : (zeroCount T : ℝ) ≤ (lowCountingDegree : ℝ) +
      ∑ k ∈ Finset.range (⌊T⌋₊ + 1),
        ((countingDegree (countingHeight k) : ℝ) + (countingDegree (-countingHeight k) : ℝ)) := by
    exact_mod_cast hnat
  apply hreal.trans
  apply add_le_add le_rfl
  calc
    _ ≤ ∑ k ∈ Finset.range (⌊T⌋₊ + 1),
        2 * (Real.log (40 * (T + 7)) / Real.log (14 / 13)) := by
      apply Finset.sum_le_sum
      intro k hk
      have hkfloor : k ≤ ⌊T⌋₊ := Nat.le_of_lt_succ (Finset.mem_range.mp hk)
      have hkT : (k : ℝ) ≤ T := (Nat.cast_le.mpr hkfloor).trans (Nat.floor_le hT)
      have hheight : 0 < countingHeight k := by unfold countingHeight; positivity
      have hh : |countingHeight k| + 2 ≤ T + 7 := by
        rw [abs_of_pos hheight]
        unfold countingHeight
        linarith
      have hlog := Real.log_le_log (by positivity : (0 : ℝ) < 40 * (|countingHeight k| + 2))
        (show 40 * (|countingHeight k| + 2) ≤ 40 * (T + 7) by linarith)
      have hb := div_le_div_of_nonneg_right hlog (Real.log_nonneg (by norm_num : (1 : ℝ) ≤ 14 / 13))
      have hp := (countingDegree_le (countingHeight_abs_ge k).1).trans hb
      have hn := countingDegree_le (countingHeight_abs_ge k).2
      rw [abs_neg] at hn
      have hn' := hn.trans hb
      linarith
    _ = _ := by simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul]; ring

/-- A fixed positive global coefficient, with the compact low-height contribution displayed. -/
noncomputable def globalZeroCountConstant : ℝ :=
  (lowCountingDegree : ℝ) / Real.log 2 +
    4 * (1 + Real.log 80 / Real.log 2) / Real.log (14 / 13) + 1

/-- The global coefficient is finite and strictly positive. -/
theorem globalZeroCountConstant_pos : 0 < globalZeroCountConstant := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 80 := Real.log_pos (by norm_num)
  have h1413 : 0 < Real.log (14 / 13) := Real.log_pos (by norm_num)
  unfold globalZeroCountConstant
  positivity

/-- The elementary logarithm in the finite cover bound has order log T. -/
theorem global_counting_log_le {T : ℝ} (hT : 7 ≤ T) :
    Real.log (40 * (T + 7)) ≤ (1 + Real.log 80 / Real.log 2) * Real.log T := by
  have hpos : 0 < T := by linarith
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 80 := Real.log_pos (by norm_num)
  have hlog2 : Real.log 2 ≤ Real.log T := Real.log_le_log (by norm_num) (by linarith)
  have hlog := Real.log_le_log (show 0 < 40 * (T + 7) by positivity)
    (show 40 * (T + 7) ≤ 80 * T by linarith)
  rw [Real.log_mul (by norm_num) hpos.ne'] at hlog
  have hratio := mul_le_mul_of_nonneg_left hlog2 (show 0 ≤ Real.log 80 / Real.log 2 by positivity)
  have he : (Real.log 80 / Real.log 2) * Real.log 2 = Real.log 80 := by field_simp
  rw [he] at hratio
  nlinarith

/-- Global N(T)≤C T log T for every T≥7, with analytic multiplicities retained. -/
theorem zeroCount_le_mul_log {T : ℝ} (hT : 7 ≤ T) :
    (zeroCount T : ℝ) ≤ globalZeroCountConstant * T * Real.log T := by
  let A := 1 + Real.log 80 / Real.log 2
  let B : ℝ := lowCountingDegree
  let d := Real.log (14 / 13)
  have hTpos : 0 < T := by linarith
  have hlogpos : 0 < Real.log T := Real.log_pos (by linarith)
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hd : 0 < d := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 80 := Real.log_pos (by norm_num)
  have hA : 0 ≤ A := by dsimp [A]; positivity
  have hB : 0 ≤ B := Nat.cast_nonneg _
  have hfloor : (⌊T⌋₊ + 1 : ℕ) ≤ (2 * T : ℝ) := by
    push_cast
    have hf := Nat.floor_le hTpos.le
    linarith
  have hlog := global_counting_log_le hT
  have hq : Real.log (40 * (T + 7)) / d ≤ A * Real.log T / d :=
    div_le_div_of_nonneg_right hlog hd.le
  have hqpos : 0 ≤ Real.log (40 * (T + 7)) / d := by
    apply div_nonneg _ hd.le
    apply Real.log_nonneg
    linarith
  have hmain := zeroCount_le_global_bound hTpos.le
  have hhigh : 2 * (⌊T⌋₊ + 1 : ℕ) * (Real.log (40 * (T + 7)) / d) ≤
      (4 * A / d) * T * Real.log T := by
    calc
      _ ≤ (2 * (2 * T)) * (A * Real.log T / d) :=
        mul_le_mul (by linarith) hq hqpos (by positivity)
      _ = _ := by ring
  have hbase : B ≤ (B / Real.log 2) * T * Real.log T := by
    have hlog2 := Real.log_le_log (by norm_num : (0 : ℝ) < 2) (show 2 ≤ T by linarith)
    have hx : Real.log 2 ≤ T * Real.log T := by
      nlinarith [mul_nonneg (show 0 ≤ T - 1 by linarith) hlogpos.le]
    have hb := mul_le_mul_of_nonneg_left hx (show 0 ≤ B / Real.log 2 by positivity)
    have he : (B / Real.log 2) * Real.log 2 = B := by field_simp
    rw [he] at hb
    nlinarith
  have hdef : globalZeroCountConstant = B / Real.log 2 + 4 * A / d + 1 := rfl
  rw [hdef]
  change (zeroCount T : ℝ) ≤ B + 2 * (⌊T⌋₊ + 1 : ℕ) *
    (Real.log (40 * (T + 7)) / d) at hmain
  nlinarith

/-- The classical global upper-bound order N(T)=O(T log T), without an asymptotic leading term. -/
theorem zeroCount_isBigO :
    (fun T : ℝ ↦ (zeroCount T : ℝ)) =O[atTop] (fun T ↦ T * Real.log T) := by
  apply Asymptotics.IsBigO.of_bound globalZeroCountConstant
  filter_upwards [eventually_ge_atTop (7 : ℝ)] with T hT
  have hTpos : 0 ≤ T := by linarith
  have hlog : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  simpa only [Real.norm_eq_abs, abs_of_nonneg (show (0 : ℝ) ≤ (zeroCount T : ℝ) from Nat.cast_nonneg _),
    abs_of_nonneg (mul_nonneg hTpos hlog), mul_assoc] using zeroCount_le_mul_log hT

/-- The crude global density-count upper bound follows uniformly in the real cutoff σ. -/
theorem zeroDensityCount_le_mul_log (σ : ℝ) {T : ℝ} (hT : 7 ≤ T) :
    (zeroDensityCount σ T : ℝ) ≤ globalZeroCountConstant * T * Real.log T :=
  (Nat.cast_le.mpr (zeroDensityCount_le σ T)).trans (zeroCount_le_mul_log hT)

end Legendre.Zeta
