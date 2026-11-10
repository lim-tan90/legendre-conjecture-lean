/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local finite dyadic summation of a two-term distribution bound.
-/
module
public import Legendre.Layer4.FiniteSquareLayercake
public import Mathlib.Algebra.Order.Field.GeomSum

@[expose] public section
namespace Legendre.Density.Moment
open Set
open scoped BigOperators

theorem amplitude_dyadic_cover (J : ℕ) (V x : ℝ) (hx : V < x)
    (hu : x ≤ V*(2 : ℝ)^J) :
    ∃ j ∈ Finset.range J, V*(2 : ℝ)^j < x ∧ x ≤ 2*(V*(2 : ℝ)^j) := by
  induction J with
  | zero => simp only [pow_zero,mul_one] at hu; linarith
  | succ J ih =>
    by_cases hh : x ≤ V*(2 : ℝ)^J
    · obtain ⟨j,hj,hl,hu⟩ := ih hh
      exact ⟨j,Finset.mem_range.mpr (Nat.lt_succ_of_lt (Finset.mem_range.mp hj)),hl,hu⟩
    · refine ⟨J,Finset.mem_range.mpr (Nat.lt_succ_self J),lt_of_not_ge hh,?_⟩
      rw [pow_succ] at hu
      nlinarith

theorem amplitude_square_dyadic (J : ℕ) (V x : ℝ) (hV : 0 ≤ V) (hx : 0 ≤ x)
    (hu : x ≤ V*(2 : ℝ)^J) :
    x^2 ≤ V^2+∑ j ∈ Finset.range J,
      if V*(2 : ℝ)^j ≤ x then 4*(V*(2 : ℝ)^j)^2 else 0 := by
  classical
  have hn (j : ℕ) : 0 ≤ (if V*(2 : ℝ)^j ≤ x then 4*(V*(2 : ℝ)^j)^2 else 0) := by
    split_ifs <;> positivity
  by_cases hh : x ≤ V
  · exact (pow_le_pow_left₀ hx hh 2).trans (le_add_of_nonneg_right (Finset.sum_nonneg (fun j _ => hn j)))
  · obtain ⟨j,hj,hl,hu'⟩ := amplitude_dyadic_cover J V x (lt_of_not_ge hh) hu
    have hs := Finset.single_le_sum (fun k (_ : k ∈ Finset.range J) => hn k) hj
    rw [if_pos hl.le] at hs
    have hp := pow_le_pow_left₀ hx hu' 2
    nlinarith [sq_nonneg V]

/-- A finite second moment from the actual distribution estimate at dyadic amplitudes. -/
theorem finite_dyadic_second_moment {ι : Type*} (S : Finset ι) (x : ι → ℝ)
    (J : ℕ) (V A B : ℝ) (hV : 0 < V) (hA : 0 ≤ A) (hB : 0 ≤ B)
    (hx : ∀ i ∈ S, 0 ≤ x i ∧ x i ≤ V*(2 : ℝ)^J)
    (hcount : ∀ j ∈ Finset.range J,
      ((S.filter (fun i => V*(2 : ℝ)^j ≤ x i)).card : ℝ) ≤
        A/(V*(2 : ℝ)^j)^2+B/(V*(2 : ℝ)^j)^6) :
    (∑ i ∈ S, (x i)^2) ≤ (S.card : ℝ)*V^2+4*A*(J : ℝ)+8*B/V^4 := by
  classical
  have hs := Finset.sum_le_sum (fun i hi => amplitude_square_dyadic J V (x i) hV.le
    (hx i hi).1 (hx i hi).2)
  simp only [Finset.sum_add_distrib,Finset.sum_const,nsmul_eq_mul] at hs
  rw [Finset.sum_comm] at hs
  have hlevel (j : ℕ) (hj : j ∈ Finset.range J) :
      (∑ i ∈ S, if V*(2 : ℝ)^j ≤ x i then 4*(V*(2 : ℝ)^j)^2 else 0) ≤
        4*A+4*B/V^4*(1/16 : ℝ)^j := by
    rw [←Finset.sum_filter]
    simp only [Finset.sum_const,nsmul_eq_mul]
    have hh := mul_le_mul_of_nonneg_right (hcount j hj)
      (show 0 ≤ 4*(V*(2 : ℝ)^j)^2 by positivity)
    apply hh.trans_eq
    rw [show (16 : ℝ) = 2^4 by norm_num,div_pow,one_pow,←pow_mul,
      show 4*j=j*4 by omega,pow_mul]
    field_simp
    <;> ring
  have hsum := Finset.sum_le_sum hlevel
  rw [Finset.sum_add_distrib,Finset.sum_const,←Finset.mul_sum] at hsum
  simp only [Finset.card_range,nsmul_eq_mul] at hsum
  have hg : (∑ j ∈ Finset.range J, (1/16 : ℝ)^j) ≤ 2 := by
    rw [geom_sum_eq (by norm_num : (1/16 : ℝ) ≠ 1)]
    apply (div_le_iff_of_neg (by norm_num : (1/16-1 : ℝ) < 0)).mpr
    have hp := pow_nonneg (by norm_num : (0 : ℝ) ≤ 1/16) J
    nlinarith
  have hm := mul_le_mul_of_nonneg_left hg (show 0 ≤ 4*B/V^4 by positivity)
  calc
    _ ≤ (S.card : ℝ)*V^2+_ := hs
    _ ≤ (S.card : ℝ)*V^2+((J : ℝ)*(4*A)+4*B/V^4*∑ j ∈ Finset.range J, (1/16 : ℝ)^j) :=
      add_le_add le_rfl hsum
    _ ≤ (S.card : ℝ)*V^2+((J : ℝ)*(4*A)+4*B/V^4*2) :=
      add_le_add le_rfl (add_le_add le_rfl hm)
    _ = _ := by ring

end Legendre.Density.Moment
