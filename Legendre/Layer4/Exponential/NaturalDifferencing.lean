/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local natural-indexed interface for finite-interval differencing.
Zero extension preserves the overlap endpoints exactly.
-/
module
public import Legendre.Layer4.Exponential.VanDerCorput

@[expose] public section
namespace Legendre.Density.Oscillation.Tools
open Complex ComplexConjugate
open scoped BigOperators

theorem sum_int_Icc_nat {M : Type*} [AddCommMonoid M] (a b : ℕ) (f : ℤ → M) :
    (∑ n ∈ Finset.Icc (a : ℤ) b, f n) = ∑ n ∈ Finset.Icc a b, f n := by
  apply Finset.sum_bij (fun n _ => n.toNat)
  · intro n hn
    have hh := Finset.mem_Icc.mp hn
    have hn0 : 0 ≤ n := (Int.natCast_nonneg a).trans hh.1
    exact Finset.mem_Icc.mpr ⟨by omega,by omega⟩
  · intro n hn m hm he
    have hn0 : 0 ≤ n := (Int.natCast_nonneg a).trans (Finset.mem_Icc.mp hn).1
    have hm0 : 0 ≤ m := (Int.natCast_nonneg a).trans (Finset.mem_Icc.mp hm).1
    omega
  · intro n hn
    refine ⟨(n : ℤ),?_,by simp⟩
    exact Finset.mem_Icc.mpr ⟨by exact_mod_cast (Finset.mem_Icc.mp hn).1,
      by exact_mod_cast (Finset.mem_Icc.mp hn).2⟩
  · intro n hn
    have hn0 : 0 ≤ n := (Int.natCast_nonneg a).trans (Finset.mem_Icc.mp hn).1
    rw [Int.toNat_of_nonneg hn0]

noncomputable def intervalZeroExtension (a : ℕ → ℂ) (N : ℕ) (n : ℤ) : ℂ :=
  if n ∈ Finset.Icc (1 : ℤ) N then a n.toNat else 0

theorem intervalZeroExtension_sum (a : ℕ → ℂ) (N : ℕ) :
    (∑ n ∈ Finset.Icc (1 : ℤ) N, intervalZeroExtension a N n) =
      ∑ n ∈ Finset.Icc 1 N, a n := by
  have hsum := sum_int_Icc_nat 1 N (intervalZeroExtension a N)
  norm_num only [Nat.cast_one] at hsum
  rw [hsum]
  apply Finset.sum_congr rfl
  intro n hn
  have hm : (n : ℤ) ∈ Finset.Icc (1 : ℤ) N := by
    exact Finset.mem_Icc.mpr ⟨by exact_mod_cast (Finset.mem_Icc.mp hn).1,
      by exact_mod_cast (Finset.mem_Icc.mp hn).2⟩
  simp only [intervalZeroExtension,ite_eq_left hm,Int.toNat_natCast]

/-- Only the overlapping samples remain in a positive shifted correlation. -/
theorem intervalZeroExtension_correlation (a : ℕ → ℂ) (N h : ℕ) (hh : h ≤ N) :
    (∑ n ∈ Finset.Icc (1 : ℤ) N, intervalZeroExtension a N (n+h)*
      conj (intervalZeroExtension a N n)) =
      ∑ n ∈ Finset.Icc 1 (N-h), a (n+h)*conj (a n) := by
  have hsum := sum_int_Icc_nat 1 N (fun n => intervalZeroExtension a N (n+h)*
    conj (intervalZeroExtension a N n))
  norm_num only [Nat.cast_one] at hsum
  rw [hsum]
  have he (n : ℕ) (hn : n ∈ Finset.Icc 1 (N-h)) :
      intervalZeroExtension a N ((n : ℤ)+h)*conj (intervalZeroExtension a N n) =
        a (n+h)*conj (a n) := by
    have hm := Finset.mem_Icc.mp hn
    have hnN : n ≤ N := hm.2.trans (Nat.sub_le N h)
    have hnH : n+h ≤ N := by omega
    have h1 : (n : ℤ) ∈ Finset.Icc (1 : ℤ) N := Finset.mem_Icc.mpr
      ⟨by exact_mod_cast hm.1,by exact_mod_cast hnN⟩
    have h2 : (n : ℤ)+h ∈ Finset.Icc (1 : ℤ) N := Finset.mem_Icc.mpr
      ⟨by omega,by exact_mod_cast hnH⟩
    rw [←Nat.cast_add] at h2
    simp only [intervalZeroExtension,←Nat.cast_add,ite_eq_left h1,ite_eq_left h2,Int.toNat_natCast]
  calc
    _ = ∑ n ∈ Finset.Icc 1 (N-h), intervalZeroExtension a N ((n : ℤ)+h)*
        conj (intervalZeroExtension a N n) := by
      symm
      apply Finset.sum_subset (Finset.Icc_subset_Icc_right (Nat.sub_le N h))
      intro n hn hn'
      have h1 := Finset.mem_Icc.mp hn
      have h2 : ¬((n : ℤ)+h ∈ Finset.Icc (1 : ℤ) N) := by
        simp only [Finset.mem_Icc]
        have hnH : N < n+h := by
          have hnnot : ¬ n ≤ N-h := fun hle => hn' (Finset.mem_Icc.mpr ⟨h1.1,hle⟩)
          omega
        omega
      simp only [intervalZeroExtension,ite_eq_right h2,zero_mul]
    _ = _ := Finset.sum_congr rfl he

/-- Natural interval differencing with exact positive-shift overlaps. -/
theorem van_der_corput_nat_interval (a : ℕ → ℂ) (N H : ℕ) (hH : 1 ≤ H) (hHN : H ≤ N)
    (E : ℝ) (hE : 0 ≤ E) (hnorm : ∀ n ∈ Finset.Icc 1 N, ‖a n‖ ≤ 1)
    (hcorr : ∀ h : ℕ, 1 ≤ h → h < H →
      ‖∑ n ∈ Finset.Icc 1 (N-h), a (n+h)*conj (a n)‖ ≤ E) :
    ‖∑ n ∈ Finset.Icc 1 N, a n‖^2 ≤ 2*(N : ℝ)^2/H+2*(N : ℝ)*E := by
  have hh := van_der_corput_interval (intervalZeroExtension a N) N H hH hHN E hE
    (by intro n hn; simp only [intervalZeroExtension,ite_eq_right hn])
    (by
      intro n
      by_cases hn : n ∈ Finset.Icc (1 : ℤ) N
      · simp only [intervalZeroExtension,ite_eq_left hn]
        exact hnorm n.toNat (by have hh := Finset.mem_Icc.mp hn; exact Finset.mem_Icc.mpr ⟨by omega,by omega⟩)
      · simp only [intervalZeroExtension,ite_eq_right hn,norm_zero]; norm_num)
    (by
      intro h hh hhH
      have hne : 0 ≤ h := by omega
      have he : (h.toNat : ℤ) = h := Int.toNat_of_nonneg hne
      rw [←he,intervalZeroExtension_correlation a N h.toNat (by omega)]
      exact hcorr h.toNat (by omega) (by omega))
  rwa [intervalZeroExtension_sum] at hh

end Legendre.Density.Oscillation.Tools
