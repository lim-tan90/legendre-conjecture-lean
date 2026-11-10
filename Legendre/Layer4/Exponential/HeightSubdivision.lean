/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions. Finite ordinate subdivision with an explicit bin count.
-/
module
public import Legendre.Layer4.Exponential.HalaszComplex

@[expose] public section
namespace Legendre.Density.Oscillation
open scoped BigOperators

noncomputable def heightBin {ι : Type*} (S : Finset ι) (t : ι → ℝ) (T H : ℝ) (j : ℕ) : Finset ι :=
  S.filter (fun i => ⌊(t i+T)/H⌋₊ = j)

theorem heightBin_subset {ι : Type*} (S : Finset ι) (t : ι → ℝ) (T H : ℝ) (j : ℕ) :
    heightBin S t T H j ⊆ S := Finset.filter_subset _ _

theorem heightBin_centered {ι : Type*} (S : Finset ι) (t : ι → ℝ) (T H : ℝ)
    (hH : 0 < H) (ht : ∀ i ∈ S, |t i| ≤ T) (j : ℕ) (i : ι)
    (hi : i ∈ heightBin S t T H j) : |t i-((j : ℝ)*H-T)| ≤ H := by
  have hh := Finset.mem_filter.mp hi
  have hlo : 0 ≤ t i+T := by have := (abs_le.mp (ht i hh.1)).1; linarith
  have hf := Nat.floor_le (div_nonneg hlo hH.le)
  have hu := Nat.lt_floor_add_one ((t i+T)/H)
  rw [hh.2] at hf hu
  have hl' := (le_div_iff₀ hH).mp hf
  have hu' := (div_lt_iff₀ hH).mp hu
  rw [abs_of_nonneg (by linarith : 0 ≤ t i-((j : ℝ)*H-T))]
  nlinarith

theorem heightBin_cover {ι : Type*} [DecidableEq ι] (S : Finset ι) (t : ι → ℝ) (T H : ℝ)
    (hT : 0 ≤ T) (hH : 0 < H) (ht : ∀ i ∈ S, |t i| ≤ T) :
    S ⊆ (Finset.range (⌊2*T/H⌋₊+1)).biUnion (heightBin S t T H) := by
  classical
  intro i hi
  have hb : (t i+T)/H ≤ 2*T/H := div_le_div_of_nonneg_right
    (by have := (abs_le.mp (ht i hi)).2; linarith) hH.le
  have hf := Nat.floor_le_floor hb
  exact Finset.mem_biUnion.mpr ⟨⌊(t i+T)/H⌋₊,Finset.mem_range.mpr (by omega),
    Finset.mem_filter.mpr ⟨hi,rfl⟩⟩

/-- Summing a uniform per-bin count costs only 1+2T/H. -/
theorem height_subdivision_card {ι : Type*} (S : Finset ι) (t : ι → ℝ) (T H A : ℝ)
    (hT : 0 ≤ T) (hH : 0 < H) (hA : 0 ≤ A) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hcount : ∀ j ∈ Finset.range (⌊2*T/H⌋₊+1), ((heightBin S t T H j).card : ℝ) ≤ A) :
    (S.card : ℝ) ≤ (1+2*T/H)*A := by
  classical
  have hc : (S.card : ℝ) ≤ ∑ j ∈ Finset.range (⌊2*T/H⌋₊+1),
      ((heightBin S t T H j).card : ℝ) := by
    exact_mod_cast (Finset.card_le_card (heightBin_cover S t T H hT hH ht)).trans
      Finset.card_biUnion_le
  apply (hc.trans (Finset.sum_le_sum hcount)).trans
  simp only [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
  apply mul_le_mul_of_nonneg_right _ hA
  have hf := Nat.floor_le (div_nonneg (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hT) hH.le)
  push_cast
  linarith

end Legendre.Density.Oscillation
