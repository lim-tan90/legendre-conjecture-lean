/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local finite Abel summation for nonnegative decreasing real weights.
The input is a bound for actual prefixes, with no coefficient or phase assumption.
-/
module
public import Legendre.Layer4.Exponential.LogWeyl
public import Mathlib.Algebra.BigOperators.Module

@[expose] public section
namespace Legendre.Density.Oscillation
open scoped BigOperators

/-- Reindex a translated natural prefix as its exact half-open block. -/
theorem sum_range_offset_eq_Ioc {M : Type*} [AddCommMonoid M]
    (U N : ℕ) (f : ℕ → M) :
    (∑ j ∈ Finset.range N, f (U+1+j)) = ∑ n ∈ Finset.Ioc U (U+N), f n := by
  apply Finset.sum_bij (fun j _ => U+1+j)
  · intro j hj
    have hh := Finset.mem_range.mp hj
    exact Finset.mem_Ioc.mpr ⟨by omega,by omega⟩
  · intro j hj k hk he
    omega
  · intro n hn
    have hh := Finset.mem_Ioc.mp hn
    refine ⟨n-U-1,Finset.mem_range.mpr (by omega),by omega⟩
  · intros
    rfl

theorem sum_range_weight_drop (w : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Finset.range N, (w n-w (n+1))) = w 0-w N := by
  induction N with
  | zero => simp
  | succ N ih => rw [Finset.sum_range_succ,ih]; ring

/-- Decreasing positive weights preserve prefix cancellation at the first weight's cost. -/
theorem norm_sum_range_smul_antitone (w : ℕ → ℝ) (z : ℕ → ℂ) (N : ℕ) (B : ℝ)
    (hB : 0 ≤ B) (hw : ∀ n, 0 ≤ w n) (hanti : Antitone w)
    (hb : ∀ m : ℕ, m ≤ N → ‖∑ n ∈ Finset.range m, z n‖ ≤ B) :
    ‖∑ n ∈ Finset.range N, w n • z n‖ ≤ B*w 0 := by
  by_cases hN : N = 0
  · subst N
    simp only [Finset.range_zero,Finset.sum_empty,norm_zero]
    exact mul_nonneg hB (hw 0)
  have hNp : 0 < N := Nat.pos_of_ne_zero hN
  have hend : ‖w (N-1) • ∑ n ∈ Finset.range N, z n‖ ≤ w (N-1)*B := by
    rw [norm_smul,Real.norm_eq_abs,abs_of_nonneg (hw _)]
    exact mul_le_mul_of_nonneg_left (hb N le_rfl) (hw _)
  have hterm (i : ℕ) (hi : i ∈ Finset.range (N-1)) :
      ‖(w (i+1)-w i) • ∑ n ∈ Finset.range (i+1), z n‖ ≤ (w i-w (i+1))*B := by
    have hd : w (i+1) ≤ w i := hanti (Nat.le_succ i)
    rw [norm_smul,Real.norm_eq_abs,abs_of_nonpos (by linarith : w (i+1)-w i ≤ 0)]
    have hh := mul_le_mul_of_nonneg_left (hb (i+1) (by have hh := Finset.mem_range.mp hi; omega))
      (show 0 ≤ w i-w (i+1) by linarith)
    convert hh using 1 <;> ring
  rw [Finset.sum_range_by_parts w z N]
  calc
    _ ≤ ‖w (N-1) • ∑ n ∈ Finset.range N, z n‖+
        ‖∑ i ∈ Finset.range (N-1), (w (i+1)-w i) • ∑ n ∈ Finset.range (i+1), z n‖ := norm_sub_le _ _
    _ ≤ w (N-1)*B+∑ i ∈ Finset.range (N-1), (w i-w (i+1))*B :=
      add_le_add hend ((norm_sum_le _ _).trans (Finset.sum_le_sum hterm))
    _ = B*w 0 := by rw [←Finset.sum_mul,sum_range_weight_drop]; ring

end Legendre.Density.Oscillation
