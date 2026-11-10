/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local specialization of the credited derivative tests to the logarithmic
Dirichlet phase. The sum bounds concern actual complex powers.
-/
module
public import Legendre.Layer4.Exponential.SecondDerivativeTest
public import Legendre.DirichletMeanValue

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open Tools.ExponentialSum
open scoped BigOperators

noncomputable def logarithmicPhase (t x : ℝ) : ℝ := -t/(2*Real.pi)*Real.log x

theorem logarithmicPhase_eq_cpow (t x : ℝ) (hx : 0 < x) :
    phase (logarithmicPhase t x) = (x : ℂ)^(-(t : ℂ)*I) := by
  rw [Complex.cpow_def_of_ne_zero (Complex.ofReal_ne_zero.mpr hx.ne'),
    ← Complex.ofReal_log hx.le]
  unfold phase logarithmicPhase
  congr 1
  push_cast
  field_simp [Real.pi_ne_zero]

theorem logarithmicPhase_deriv (t x : ℝ) (hx : x ≠ 0) :
    HasDerivAt (logarithmicPhase t) (-t/(2*Real.pi)/x) x := by
  simpa only [logarithmicPhase,div_eq_mul_inv] using!
    (Real.hasDerivAt_log hx).const_mul (-t/(2*Real.pi))

theorem logarithmicPhase_second_deriv (t x : ℝ) (hx : x ≠ 0) :
    HasDerivAt (fun y : ℝ => -t/(2*Real.pi)/y) (t/(2*Real.pi)/x^2) x := by
  convert! (hasDerivAt_const x (-t/(2*Real.pi))).div (hasDerivAt_id x) hx using 1 <;>
    simp only [id_eq,zero_mul,mul_one,zero_sub] <;> ring

theorem logarithmicPhase_second_bounds (t U x : ℝ) (hU : 0 < U)
    (hx : U ≤ x) (hx3 : x ≤ 3*U) :
    |t|/(18*Real.pi*U^2) ≤ |t/(2*Real.pi)/x^2| ∧
      |t/(2*Real.pi)/x^2| ≤ 9*(|t|/(18*Real.pi*U^2)) := by
  have hxp : 0 < x := lt_of_lt_of_le hU hx
  rw [abs_div,abs_div,abs_of_pos (by positivity : 0 < 2*Real.pi),
    abs_of_pos (sq_pos_of_pos hxp)]
  constructor
  · apply (div_le_div_iff₀ (by positivity : 0 < 18*Real.pi*U^2)
      (by positivity : 0 < x^2)).mpr
    apply (mul_le_mul_of_nonneg_left (show x^2 ≤ 9*U^2 by nlinarith) (abs_nonneg t)).trans_eq
    field_simp [Real.pi_ne_zero]
    ring
  · have he : 9*(|t|/(18*Real.pi*U^2)) = (|t|/(2*Real.pi))/U^2 := by
      field_simp
      ring
    rw [he]
    exact div_le_div_of_nonneg_left (by positivity) (sq_pos_of_pos hU)
      (by nlinarith : U^2 ≤ x^2)

/-- Second derivative cancellation on any subinterval of a dyadic block. -/
theorem logarithmic_block_second (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V) (hV : V ≤ 2*U)
    (t : ℝ) (ht : t ≠ 0) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)‖ ≤
      69*((U : ℝ)*Real.sqrt (|t|/(18*Real.pi*(U : ℝ)^2))+
        1/Real.sqrt (|t|/(18*Real.pi*(U : ℝ)^2))) := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hLam : 0 < |t|/(18*Real.pi*(U : ℝ)^2) := by positivity
  have hh := second_derivative_test_Ico (logarithmicPhase t)
    (fun x : ℝ => -t/(2*Real.pi)/x) (fun x : ℝ => t/(2*Real.pi)/x^2)
    (U+1) (V+1) (|t|/(18*Real.pi*(U : ℝ)^2)) 9 (by omega) hLam (by norm_num)
    (by intro x hx; apply logarithmicPhase_deriv; have hh := hx.1; push_cast at hh; linarith)
    (by
      intro x hx
      apply logarithmicPhase_second_deriv
      have hxU : (U : ℝ) < x := by
        have hh := hx.1
        push_cast at hh
        linarith
      exact ne_of_gt (lt_trans hUp hxU))
    (by
      intro x hx
      apply logarithmicPhase_second_bounds t U x hUp
      · have := hx.1; push_cast at this; linarith
      · have := hx.2; push_cast at this
        have hVr : (V : ℝ) ≤ 2*(U : ℝ) := by exact_mod_cast hV
        have hU1 : (1 : ℝ) ≤ U := by exact_mod_cast hU
        linarith)
  have he : (∑ n ∈ Finset.Ico (U+1) (V+1), phase (logarithmicPhase t n)) =
      ∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I) := by
    rw [Finset.Ico_add_one_add_one_eq_Ioc]
    apply Finset.sum_congr rfl
    intro n hn
    simpa only [Complex.ofReal_natCast] using logarithmicPhase_eq_cpow t n
      (by exact_mod_cast (lt_of_le_of_lt (Nat.zero_le U) (Finset.mem_Ioc.mp hn).1))
  rw [he] at hh
  norm_num only [Nat.add_sub_add_right,show (6*9+15 : ℝ) = 69 by norm_num] at hh
  apply hh.trans
  gcongr
  exact_mod_cast (show V-U ≤ U by omega)

noncomputable def logarithmicSecondConstant : ℝ :=
  69*(Real.sqrt (18*Real.pi)+(Real.sqrt (18*Real.pi))⁻¹)

theorem logarithmicSecondConstant_pos : 0 < logarithmicSecondConstant := by
  unfold logarithmicSecondConstant
  positivity

theorem logarithmic_scale_sqrt (t U : ℝ) (hU : 0 < U) :
    Real.sqrt (|t|/(18*Real.pi*U^2)) = Real.sqrt |t|/(Real.sqrt (18*Real.pi)*U) := by
  rw [Real.sqrt_div (abs_nonneg t),Real.sqrt_mul (by positivity : 0 ≤ 18*Real.pi),
    Real.sqrt_sq hU.le]

/-- The actual block sum has square-root cancellation, with a numerical constant. -/
theorem logarithmic_block_sqrt (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V) (hV : V ≤ 2*U)
    (t : ℝ) (ht : t ≠ 0) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)‖ ≤
      logarithmicSecondConstant*(Real.sqrt |t|+(U : ℝ)/Real.sqrt |t|) := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have htp : 0 < Real.sqrt |t| := Real.sqrt_pos.mpr (abs_pos.mpr ht)
  have hp : 0 < Real.sqrt (18*Real.pi) := by positivity
  apply (logarithmic_block_second U V hU hUV hV t ht).trans
  rw [logarithmic_scale_sqrt t U hUp]
  have he : 69*((U : ℝ)*(Real.sqrt |t|/(Real.sqrt (18*Real.pi)*U))+
      1/(Real.sqrt |t|/(Real.sqrt (18*Real.pi)*U))) =
      69*((Real.sqrt (18*Real.pi))⁻¹*Real.sqrt |t|+
        Real.sqrt (18*Real.pi)*((U : ℝ)/Real.sqrt |t|)) := by
    field_simp
    <;> ring
  rw [he]
  unfold logarithmicSecondConstant
  have ha := mul_nonneg hp.le htp.le
  have hb := mul_nonneg (inv_nonneg.mpr hp.le) (div_nonneg hUp.le htp.le)
  nlinarith

end Legendre.Density.Oscillation
