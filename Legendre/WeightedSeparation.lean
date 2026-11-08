/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

This weighted cover argument generalizes openai/math at commit
4eaee87548250b2682affda7d05d947c05554bae,
lean/OAI/NumberTheory/Ostmann/ZeroDensity/SeparatedSelection.lean.
Its original license is retained in licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.LargeSieve.SeparatedSelection

/-!
# Weighted separated representatives

A maximal separated cover controls total natural weight by local weighted
unit-window bounds. In the zeta application these natural weights are analytic
zero multiplicities, which are retained instead of being replaced by one.
-/

@[expose] public section

open scoped Classical

namespace Legendre.Density

/-- A finite union does not exceed the sum of the natural weights of its two parts. -/
theorem sum_nat_weight_union_le {ι : Type*} (A B : Finset ι) (w : ι → ℕ) :
    (∑ i ∈ A ∪ B, w i) ≤ (∑ i ∈ A, w i)+(∑ i ∈ B, w i) := by
  classical
  have h := Finset.sum_union_inter (s₁ := A) (s₂ := B) (f := w)
  omega

/-- Weighted finite covers may overlap; their total weight is still an upper bound. -/
theorem sum_nat_weight_biUnion_le {ι κ : Type*} (S : Finset κ) (F : κ → Finset ι) (w : ι → ℕ) :
    (∑ i ∈ S.biUnion F, w i) ≤ ∑ j ∈ S, ∑ i ∈ F j, w i := by
  classical
  induction S using Finset.induction with
  | empty => simp
  | @insert j S hj ih =>
    rw [Finset.biUnion_insert, Finset.sum_insert hj]
    exact (sum_nat_weight_union_le _ _ w).trans (add_le_add le_rfl ih)

/-- Two half-unit windows bound the entire open radius-one neighborhood, retaining all weights. -/
theorem weighted_neighbor_le {ι : Type*} (s : Finset ι) (γ : ι → ℝ) (w : ι → ℕ)
    {B : ℝ}
    (hlocal : ∀ t : ℝ, ((∑ i ∈ s.filter (fun i => |γ i-t| ≤ 1/2), w i : ℕ) : ℝ) ≤ B)
    (j : ι) :
    ((∑ i ∈ s.filter (fun i => |γ i-γ j| < 1), w i : ℕ) : ℝ) ≤ 2*B := by
  classical
  let L := s.filter (fun i => |γ i-(γ j-1/2)| ≤ 1/2)
  let R := s.filter (fun i => |γ i-(γ j+1/2)| ≤ 1/2)
  have hsub : s.filter (fun i => |γ i-γ j| < 1) ⊆ L ∪ R := by
    intro i hi
    have hs := Finset.mem_filter.1 hi
    have hd := abs_lt.1 hs.2
    by_cases hleft : γ i ≤ γ j
    · exact Finset.mem_union_left _ (Finset.mem_filter.2 ⟨hs.1,abs_le.2 ⟨by linarith,by linarith⟩⟩)
    · exact Finset.mem_union_right _ (Finset.mem_filter.2 ⟨hs.1,abs_le.2 ⟨by linarith,by linarith⟩⟩)
  have hnat := (Finset.sum_le_sum_of_subset hsub (f := w)).trans (sum_nat_weight_union_le L R w)
  have hreal : ((∑ i ∈ s.filter (fun i => |γ i-γ j| < 1), w i : ℕ) : ℝ) ≤
      (∑ i ∈ L, w i : ℕ)+(∑ i ∈ R, w i : ℕ) := by exact_mod_cast hnat
  have hL := hlocal (γ j-1/2)
  have hR := hlocal (γ j+1/2)
  linarith

/-- Every finite naturally weighted set admits separated representatives with a local-mass bound. -/
theorem exists_weighted_separated_representatives {ι : Type*}
    (s : Finset ι) (γ : ι → ℝ) (w : ι → ℕ) {B : ℝ}
    (hlocal : ∀ t : ℝ, ((∑ i ∈ s.filter (fun i => |γ i-t| ≤ 1/2), w i : ℕ) : ℝ) ≤ B) :
    ∃ r : Finset ι, r ⊆ s ∧
      (∀ i ∈ r, ∀ j ∈ r, i ≠ j → 1 ≤ |γ i-γ j|) ∧
      ((∑ i ∈ s, w i : ℕ) : ℝ) ≤ 2*B*r.card := by
  classical
  obtain ⟨r,hrs,hsep,hcover⟩ := LargeSieve.exists_separated_cover s (fun _ => (():Unit)) γ
  refine ⟨r,hrs,fun i hi j hj hij => hsep i hi j hj hij rfl,?_⟩
  let U := fun j => s.filter (fun i => |γ i-γ j| < 1)
  have hsub : s ⊆ r.biUnion U := by
    intro i hi
    obtain ⟨j,hj,_hc,hd⟩ := hcover i hi
    exact Finset.mem_biUnion.2 ⟨j,hj,Finset.mem_filter.2 ⟨hi,hd⟩⟩
  have hn := (Finset.sum_le_sum_of_subset hsub (f := w)).trans (sum_nat_weight_biUnion_le r U w)
  have hr : ((∑ i ∈ s, w i : ℕ) : ℝ) ≤ ∑ j ∈ r, ((∑ i ∈ U j, w i : ℕ) : ℝ) := by
    exact_mod_cast hn
  calc
    _ ≤ ∑ j ∈ r, ((∑ i ∈ U j, w i : ℕ) : ℝ) := hr
    _ ≤ ∑ _j ∈ r, 2*B := Finset.sum_le_sum (fun j _hj => weighted_neighbor_le s γ w hlocal j)
    _ = _ := by simp only [Finset.sum_const,nsmul_eq_mul]; ring

end Legendre.Density
