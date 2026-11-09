/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDyadicShells.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Mathlib.Analysis.SpecificLimits.Basic
public import Legendre.Layer4.PositiveLimit

@[expose] public section
namespace Legendre.Density.Moment

open Set Filter
open scoped Topology

noncomputable def momentHeightBall (T : ℝ) (j : ℕ) : Set ℝ :=
  Icc (-((2 : ℝ) ^ j * T)) ((2 : ℝ) ^ j * T)

noncomputable def momentHeightShell (T : ℝ) : ℕ → Set ℝ
  | 0 => momentHeightBall T 0
  | j + 1 => momentHeightBall T (j + 1) \ momentHeightBall T j

 theorem momentHeightBall_mem (T : ℝ) (j : ℕ) (x : ℝ) :
    x ∈ momentHeightBall T j ↔ |x| ≤ (2 : ℝ) ^ j * T := by
  exact abs_le.symm

 theorem momentHeightBall_mono (T : ℝ) (hT : 0 ≤ T) {i j : ℕ} (hij : i ≤ j) :
    momentHeightBall T i ⊆ momentHeightBall T j := by
  intro x hx
  rw [momentHeightBall_mem] at hx ⊢
  exact hx.trans (mul_le_mul_of_nonneg_right (pow_le_pow_right₀ (by norm_num) hij) hT)

 theorem momentHeightShell_measurable (T : ℝ) (j : ℕ) : MeasurableSet (momentHeightShell T j) := by
  cases j with
  | zero => exact measurableSet_Icc
  | succ j => exact measurableSet_Icc.diff measurableSet_Icc

 theorem momentHeightShell_subset (T : ℝ) (j : ℕ) :
    momentHeightShell T j ⊆ momentHeightBall T j := by
  cases j with
  | zero => exact Set.Subset.rfl
  | succ j => exact Set.sdiff_subset

 theorem momentHeightShell_disjoint (T : ℝ) (hT : 0 ≤ T) :
    Pairwise (fun i j => Disjoint (momentHeightShell T i) (momentHeightShell T j)) := by
  have hd (i j : ℕ) (hij : i < j) : Disjoint (momentHeightShell T i) (momentHeightShell T j) := by
    obtain ⟨k, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : j ≠ 0)
    apply Set.disjoint_left.mpr
    intro x hx hy
    exact hy.2 (momentHeightBall_mono T hT (by omega) (momentHeightShell_subset T i hx))
  intro i j hij
  rcases lt_or_gt_of_ne hij with h | h
  · exact hd i j h
  · exact (hd j i h).symm

 theorem momentHeightShell_cover (T : ℝ) (hT : 0 < T) :
    (⋃ j : ℕ, momentHeightShell T j) = Set.univ := by
  apply Set.eq_univ_of_forall
  intro x
  have hex : ∃ j : ℕ, |x| ≤ (2 : ℝ) ^ j * T := by
    have ht : Tendsto (fun j : ℕ => (2 : ℝ) ^ j * T) atTop atTop :=
      (tendsto_pow_atTop_atTop_of_one_lt (by norm_num : (1 : ℝ) < 2)).atTop_mul_const hT
    obtain ⟨j, hj⟩ := (ht.eventually (eventually_ge_atTop |x|)).exists
    exact ⟨j, hj⟩
  let j := Nat.find hex
  have hj : |x| ≤ (2 : ℝ) ^ j * T := Nat.find_spec hex
  apply Set.mem_iUnion.mpr
  refine ⟨j, ?_⟩
  cases he : j with
  | zero => exact (momentHeightBall_mem T 0 x).mpr (by simpa only [he] using hj)
  | succ k =>
    change x ∈ momentHeightBall T (k + 1) \ momentHeightBall T k
    refine ⟨(momentHeightBall_mem T (k + 1) x).mpr (by simpa only [he] using hj), ?_⟩
    rw [momentHeightBall_mem]
    exact Nat.find_min hex (by omega : k < Nat.find hex)

end Legendre.Density.Moment
