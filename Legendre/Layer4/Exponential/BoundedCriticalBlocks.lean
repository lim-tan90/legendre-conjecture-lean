/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local dyadic reduction for critical-line polynomials with bounded coefficients.
-/
module
public import Legendre.Layer4.Exponential.HalaszTwoTermCount
public import Legendre.Layer4.DyadicHeightDensity

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def criticalCutoff (X : ℕ) (a : ℕ → ℂ) (n : ℕ) : ℂ := if n ≤ X then a n else 0

theorem criticalCutoff_norm (X : ℕ) (a : ℕ → ℂ) (ha : ∀ n, ‖a n‖ ≤ 1) (n : ℕ) :
    ‖criticalCutoff X a n‖ ≤ 1 := by
  unfold criticalCutoff
  split_ifs <;> simp_all

theorem critical_polynomial_extended (X N : ℕ) (a : ℕ → ℂ) (s : ℂ) (hXN : X ≤ N) :
    complexDirichletPolynomial X a s = complexDirichletPolynomial N (criticalCutoff X a) s := by
  unfold complexDirichletPolynomial
  calc
    _ = ∑ n ∈ Finset.Icc 1 X, criticalCutoff X a n*(n : ℂ)^(-s) := by
      apply Finset.sum_congr rfl
      intro n hn
      simp only [criticalCutoff,if_pos (Finset.mem_Icc.mp hn).2]
    _ = _ := Finset.sum_subset (Finset.Icc_subset_Icc_right hXN) (by
      intro n hn hn'
      have hh : ¬n ≤ X := fun hx => hn' (Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hn).1,hx⟩)
      simp [criticalCutoff,hh])

theorem critical_polynomial_blocks (X J : ℕ) (hX : 1 ≤ X) (a : ℕ → ℂ) (s : ℂ)
    (hcover : X ≤ 2^J) :
    complexDirichletPolynomial X a s = a 1+∑ j ∈ Finset.range J,
      ∑ n ∈ Finset.Ioc (2^j) (2*(2^j)), criticalCutoff X a n*(n : ℂ)^(-s) := by
  rw [critical_polynomial_extended X (2^J) a s hcover]
  unfold complexDirichletPolynomial
  have hh := Moment.moment_dyadic_partition 1 J le_rfl
    (fun n => criticalCutoff X a n*(n : ℂ)^(-s))
  simp only [mul_one] at hh
  rw [hh]
  simp only [Finset.Icc_self,Finset.sum_singleton,Nat.cast_one,Complex.one_cpow,mul_one,
    criticalCutoff,if_pos hX]
  congr 1
  apply Finset.sum_congr rfl
  intro j hj
  congr 2
  rw [pow_succ]
  omega

theorem critical_block_energy_le_one (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ)
    (ha : ∀ n, ‖a n‖ ≤ 1) :
    coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a (1/2)) ≤ 1 := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hpoint (n : ℕ) (hn : n ∈ Finset.Ioc U (2*U)) :
      ‖verticalCoefficients a (1/2) n‖^2 ≤ 1/(U : ℝ) := by
    have hnU : (U : ℝ) ≤ n := by exact_mod_cast (Finset.mem_Ioc.mp hn).1.le
    have hnp : 0 < n := by have := (Finset.mem_Ioc.mp hn).1; omega
    rw [Detector.norm_verticalCoefficients_sq a (1/2) hnp]
    norm_num only [show (-2*(1/2) : ℝ) = -1 by norm_num,Real.rpow_neg_one]
    have hc := pow_le_pow_left₀ (norm_nonneg (a n)) (ha n) 2
    have hi := one_div_le_one_div_of_le hUp hnU
    norm_num only [one_pow] at hc
    simpa only [one_div] using
      (mul_le_of_le_one_left (inv_nonneg.mpr (by positivity)) hc).trans (by simpa only [one_div] using hi)
  have hh := Finset.sum_le_sum hpoint
  have he : (∑ _n ∈ Finset.Ioc U (2*U), 1/(U : ℝ)) = 1 := by
    simp only [Finset.sum_const,Nat.card_Ioc,nsmul_eq_mul,show 2*U-U=U by omega]
    field_simp
  exact hh.trans_eq he

/-- A large polynomial with a bounded head has a genuinely large dyadic block. -/
theorem exists_large_block (J : ℕ) (hJ : 1 ≤ J) (c : ℂ) (f : ℕ → ℂ) (W : ℝ)
    (hW : 2 ≤ W) (hc : ‖c‖ ≤ 1) (hlarge : W ≤ ‖c+∑ j ∈ Finset.range J, f j‖) :
    ∃ j ∈ Finset.range J, W/(2*(J : ℝ)) ≤ ‖f j‖ := by
  classical
  by_contra hh
  have hsmall : ∀ j ∈ Finset.range J, ‖f j‖ < W/(2*(J : ℝ)) := by
    intro j hj
    exact lt_of_not_ge (fun he => hh ⟨j,hj,he⟩)
  have hs := Finset.sum_lt_sum_of_nonempty (s := Finset.range J)
    (Finset.nonempty_range_iff.mpr (by omega)) hsmall
  have hJp : (0 : ℝ) < J := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hJ)
  have he : (∑ _j ∈ Finset.range J, W/(2*(J : ℝ))) = W/2 := by
    simp only [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
    field_simp
  rw [he] at hs
  have hb := (norm_add_le c (∑ j ∈ Finset.range J,f j)).trans
    (add_le_add le_rfl (norm_sum_le _ _))
  linarith

end Legendre.Density.Oscillation
