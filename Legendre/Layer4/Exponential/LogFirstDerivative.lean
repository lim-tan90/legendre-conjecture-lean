/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local logarithmic-phase specialization of the credited Kusmin--Landau test.
In a long block, the phase increments remain in a single nonintegral strip.
-/
module
public import Legendre.Layer4.Exponential.LogPhase
public import Mathlib.Analysis.Real.Pi.Bounds

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open Tools.ExponentialSum
open scoped BigOperators

theorem logarithmic_increment_bounds (x : ℝ) (hx : 0 < x) :
    1/(x+1) ≤ Real.log (x+1)-Real.log x ∧
      Real.log (x+1)-Real.log x ≤ 1/x := by
  have hx1 : 0 < x+1 := by linarith
  have hp : 0 < (x+1)/x := div_pos hx1 hx
  have hu := Real.log_le_sub_one_of_pos hp
  have hl := Real.one_sub_inv_le_log_of_pos hp
  rw [Real.log_div hx1.ne' hx.ne'] at hu hl
  have he : (x+1)/x-1 = 1/x := by field_simp; ring
  have hf : 1-((x+1)/x)⁻¹ = 1/(x+1) := by field_simp; ring
  rw [he] at hu
  rw [hf] at hl
  exact ⟨hl,hu⟩

theorem logarithmic_increment_antitone (x y : ℝ) (hx : 0 < x) (hxy : x ≤ y) :
    Real.log (y+1)-Real.log y ≤ Real.log (x+1)-Real.log x := by
  have hy : 0 < y := lt_of_lt_of_le hx hxy
  rw [←Real.log_div (by linarith : x+1 ≠ 0) hx.ne',
    ←Real.log_div (by linarith : y+1 ≠ 0) hy.ne']
  apply Real.log_le_log (by positivity)
  have hi := one_div_le_one_div_of_le hx hxy
  have hxe : (x+1)/x = 1+1/x := by field_simp
  have hye : (y+1)/y = 1+1/y := by field_simp
  rw [hxe,hye]
  linarith

theorem logarithmicPhase_increment (t : ℝ) (n : ℕ) :
    logarithmicPhase t (n+1)-logarithmicPhase t n =
      -(t/(2*Real.pi))*(Real.log ((n : ℝ)+1)-Real.log n) := by
  unfold logarithmicPhase
  ring

/-- Long blocks have the stronger first-derivative cancellation U/t. -/
theorem logarithmic_block_first (U V : ℕ) (hU : 1 ≤ U) (hV : V ≤ 2*U)
    (t : ℝ) (ht : 0 < t) (htU : t ≤ U) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)‖ ≤ 12*Real.pi*(U : ℝ)/t := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  let β := t/(6*Real.pi*(U : ℝ))
  have hβ : 0 < β := by dsimp [β]; positivity
  have hpi : 1 ≤ Real.pi := (by linarith [Real.pi_gt_three] : (1 : ℝ) ≤ Real.pi)
  have hβ2 : β ≤ 1/2 := by
    dsimp [β]
    apply (div_le_iff₀ (by positivity : 0 < 6*Real.pi*(U : ℝ))).mpr
    nlinarith [mul_nonneg (sub_nonneg.mpr hpi) hUp.le]
  have hbound (n : ℕ) (hn : U+1 ≤ n) (hnV : n ≤ V) :
      β ≤ (t/(2*Real.pi))*(Real.log ((n : ℝ)+1)-Real.log n) ∧
        (t/(2*Real.pi))*(Real.log ((n : ℝ)+1)-Real.log n) ≤ 1/2 := by
    have hnU : (U : ℝ) ≤ n := by exact_mod_cast (show U ≤ n by omega)
    have hnp : (0 : ℝ) < n := lt_of_lt_of_le hUp hnU
    have hn2 : (n : ℝ) ≤ 2*U := by exact_mod_cast (le_trans hnV hV)
    have hu1 : (1 : ℝ) ≤ U := by exact_mod_cast hU
    have hb := logarithmic_increment_bounds n hnp
    constructor
    · apply le_trans _ (mul_le_mul_of_nonneg_left hb.1 (by positivity : 0 ≤ t/(2*Real.pi)))
      dsimp [β]
      apply (div_le_iff₀ (by positivity : 0 < 6*Real.pi*(U : ℝ))).mpr
      have he : (t/(2*Real.pi)*(1/((n : ℝ)+1)))*(6*Real.pi*U) =
          t*(3*(U : ℝ)/((n : ℝ)+1)) := by field_simp; ring
      rw [he]
      have hh : 1 ≤ 3*(U : ℝ)/((n : ℝ)+1) := (le_div_iff₀ (by linarith)).mpr (by linarith)
      nlinarith
    · apply (mul_le_mul_of_nonneg_left hb.2 (by positivity : 0 ≤ t/(2*Real.pi))).trans
      have he : (t/(2*Real.pi))*(1/(n : ℝ)) = (t/(2*Real.pi))/(n : ℝ) := by ring
      rw [he]
      apply (div_le_iff₀ hnp).mpr
      apply (div_le_iff₀ (by positivity : 0 < 2*Real.pi)).mpr
      have hh : (U : ℝ) ≤ (n : ℝ)*Real.pi := by nlinarith [mul_nonneg hnp.le (sub_nonneg.mpr hpi)]
      nlinarith
  have hh := first_derivative_sum_bound_Icc (fun n => logarithmicPhase t n) (U+1) V β (-1)
    hβ
    (by intro n hn hnV; rw [Nat.cast_add,Nat.cast_one,logarithmicPhase_increment]; norm_num; have hb := (hbound n hn hnV).2; linarith)
    (by intro n hn hnV; rw [Nat.cast_add,Nat.cast_one,logarithmicPhase_increment]; norm_num; have hb := (hbound n hn hnV).1; linarith)
    (by
      left
      intro i hi j hj hij
      dsimp only
      rw [Nat.cast_add,Nat.cast_one,logarithmicPhase_increment,
        Nat.cast_add,Nat.cast_one,logarithmicPhase_increment]
      have hip : (0 : ℝ) < i := by exact_mod_cast (show 0 < i by have := hi.1; omega)
      have hdiff := logarithmic_increment_antitone i j hip (by exact_mod_cast hij)
      exact mul_le_mul_of_nonpos_left hdiff (neg_nonpos.mpr (by positivity)))
  have he : (∑ n ∈ Finset.Icc (U+1) V, phase (logarithmicPhase t n)) =
      ∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I) := by
    rw [Finset.Icc_add_one_left_eq_Ioc]
    apply Finset.sum_congr rfl
    intro n hn
    simpa only [Complex.ofReal_natCast] using logarithmicPhase_eq_cpow t n
      (by exact_mod_cast (lt_of_le_of_lt (Nat.zero_le U) (Finset.mem_Ioc.mp hn).1))
  rw [he] at hh
  apply hh.trans_eq
  dsimp [β]
  field_simp
  ring

end Legendre.Density.Oscillation
