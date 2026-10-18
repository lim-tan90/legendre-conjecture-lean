/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

This file is adapted from the MIT-licensed Lean project
https://github.com/ShouqiaoW/erdos, commit d28713ac8245ca86a686b8c67370a8d19d81b242
(2026-08-02), files
`Erdos390/WholePaper/Nagura*.lean`, which formalizes J. Nagura's 1952 proof.
The original MIT license text is in `Legendre/Nagura/LICENSE`.
-/
module

public import Mathlib.NumberTheory.Chebyshev
public import Mathlib.NumberTheory.ArithmeticFunction.Misc
public import Mathlib.NumberTheory.ArithmeticFunction.VonMangoldt
public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
public import Mathlib.Analysis.SpecialFunctions.Stirling
public import Mathlib.Analysis.SumIntegralComparisons
public import Mathlib.Analysis.Complex.ExponentialBounds
public import Mathlib.Analysis.Real.Pi.Bounds
public import Mathlib.Tactic

/-!
# Explicit Chebyshev bounds `0.916 n < ψ(n) < 1.086 n`

This module formalizes Nagura's Lemmas 1 and 2: the summatory identity
`∑_{m ≤ n} ψ(n/m) = log(n!)`, explicit two-sided Stirling bounds for factorials,
the factorization identities of Ramanujan/Nagura, and the resulting explicit
bounds `0.916 n - 2.318 < ψ(n) < 1.086 n`, in the sharpened arbitrary-endpoint
form needed by the analytic tail.
-/

@[expose] public section

namespace Legendre.Nagura

open scoped ArithmeticFunction ArithmeticFunction.zeta

/-- Nagura's finite sum `T(n) = ∑_{m=1}^n psi(n/m)`. -/
noncomputable def naguraChebyshevSum (n : ℕ) : ℝ :=
  ∑ m ∈ Finset.Ioc 0 n, Chebyshev.psi ((n / m : ℕ) : ℝ)

/-- Dirichlet-convolution form of Nagura's fundamental finite identity. -/
theorem naguraChebyshevSum_eq_sum_log (n : ℕ) :
    naguraChebyshevSum n =
      ∑ k ∈ Finset.Icc 1 n, Real.log k := by
  have h := ArithmeticFunction.sum_Ioc_mul_eq_sum_sum
    (R := ℝ)
    (ArithmeticFunction.zeta : ArithmeticFunction ℝ)
    ArithmeticFunction.vonMangoldt n
  have hMain :
      (∑ m ∈ Finset.Ioc 0 n,
        ∑ d ∈ Finset.Ioc 0 (n / m),
          ArithmeticFunction.vonMangoldt d) =
        ∑ k ∈ Finset.Ioc 0 n, Real.log k := by
    calc
      _ = ∑ m ∈ Finset.Ioc 0 n,
          (if m = 0 then 0 else
            ∑ d ∈ Finset.Ioc 0 (n / m),
              ArithmeticFunction.vonMangoldt d) := by
        apply Finset.sum_congr rfl
        intro m hm
        have hm0 : m ≠ 0 := by
          have := (Finset.mem_Ioc.mp hm).1
          omega
        simp [hm0]
      _ = _ := by
        simpa [ArithmeticFunction.log_apply] using h.symm
  have hIntervals : Finset.Icc 1 n = Finset.Ioc 0 n := by
    ext k
    simp only [Finset.mem_Icc, Finset.mem_Ioc]
    omega
  rw [hIntervals]
  simpa [naguraChebyshevSum, Chebyshev.psi] using hMain

/-- The finite divisor sum occurring before Nagura reindexes by multiples. -/
noncomputable def naguraDivisorLogSum (n : ℕ) : ℝ :=
  ∑ k ∈ Finset.Icc 1 n,
    ∑ d ∈ k.divisors, ArithmeticFunction.vonMangoldt d

theorem naguraDivisorLogSum_eq_sum_log (n : ℕ) :
    naguraDivisorLogSum n = ∑ k ∈ Finset.Icc 1 n, Real.log k := by
  unfold naguraDivisorLogSum
  apply Finset.sum_congr rfl
  intro k _hk
  exact ArithmeticFunction.vonMangoldt_sum

/-- Exact factorial form of the finite divisor identity. -/
theorem naguraDivisorLogSum_eq_log_factorial (n : ℕ) :
    naguraDivisorLogSum n = Real.log (n.factorial : ℝ) := by
  rw [naguraDivisorLogSum_eq_sum_log]
  calc
    (∑ k ∈ Finset.Icc 1 n, Real.log k) =
        Real.log (∏ k ∈ Finset.Icc 1 n, (k : ℝ)) := by
      rw [Real.log_prod]
      intro k hk
      have hk0 : k ≠ 0 := by
        have := (Finset.mem_Icc.mp hk).1
        omega
      exact_mod_cast hk0
    _ = Real.log (n.factorial : ℝ) := by
      congr 1
      rw [← Nat.cast_prod]
      norm_cast
      rw [← Finset.Ico_add_one_right_eq_Icc,
        Finset.prod_Ico_id_eq_factorial]

/-- Exact natural-endpoint version of Nagura's fundamental formula. -/
theorem naguraChebyshevSum_eq_log_factorial (n : ℕ) :
    naguraChebyshevSum n = Real.log (n.factorial : ℝ) := by
  rw [naguraChebyshevSum_eq_sum_log]
  exact (naguraDivisorLogSum_eq_sum_log n).symm.trans
    (naguraDivisorLogSum_eq_log_factorial n)

/-- Elementary global upper bound for the factorial logarithm. -/
theorem log_factorial_le_integral_upper (n : ℕ) :
    Real.log (n.factorial : ℝ) ≤
      ((n + 1 : ℕ) : ℝ) * Real.log ((n + 1 : ℕ) : ℝ) -
        ((n + 1 : ℕ) : ℝ) + 1 := by
  have hIntegral := MonotoneOn.sum_le_integral_Ico
    (f := Real.log) (a := 1) (b := n + 1) (by omega) (by
      intro x hx y _ hxy
      exact Real.log_le_log (lt_of_lt_of_le (by norm_num) hx.1) hxy)
  have hSum :
      (∑ k ∈ Finset.Ico 1 (n + 1), Real.log k) =
        Real.log (n.factorial : ℝ) := by
    rw [Finset.Ico_add_one_right_eq_Icc]
    exact (naguraDivisorLogSum_eq_sum_log n).symm.trans
      (naguraDivisorLogSum_eq_log_factorial n)
  rw [hSum, integral_log] at hIntegral
  simpa using hIntegral

/-- The corresponding explicit upper bound for Nagura's finite `T` sum. -/
theorem naguraChebyshevSum_le_integral_upper (n : ℕ) :
    naguraChebyshevSum n ≤
      ((n + 1 : ℕ) : ℝ) * Real.log ((n + 1 : ℕ) : ℝ) -
        ((n + 1 : ℕ) : ℝ) + 1 := by
  rw [naguraChebyshevSum_eq_log_factorial]
  exact log_factorial_le_integral_upper n

/-- The same elementary estimate, written in the form used in Nagura's
linear combination of factorial logarithms. -/
theorem log_factorial_le_stirling_elementary {n : ℕ} (hn : n ≠ 0) :
    Real.log (n.factorial : ℝ) ≤
      (n : ℝ) * Real.log (n : ℝ) - (n : ℝ) +
        Real.log (n : ℝ) + 1 := by
  obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hn
  have h := log_factorial_le_integral_upper m
  rw [Nat.factorial_succ, Nat.cast_mul,
    Real.log_mul (by positivity) (by positivity)]
  linarith

/-- Elementary upper bound for Nagura's finite `T` sum in the form that
matches the Stirling lower bound term-by-term. -/
theorem naguraChebyshevSum_le_stirling_elementary {n : ℕ} (hn : n ≠ 0) :
    naguraChebyshevSum n ≤
      (n : ℝ) * Real.log (n : ℝ) - (n : ℝ) +
        Real.log (n : ℝ) + 1 := by
  rw [naguraChebyshevSum_eq_log_factorial]
  exact log_factorial_le_stirling_elementary hn

/-- The elementary upper model for `log (n!)`. -/
noncomputable def naguraFactorialLogUpper (n : ℕ) : ℝ :=
  (n : ℝ) * Real.log (n : ℝ) - (n : ℝ) + Real.log (n : ℝ) + 1

/-- The proved Stirling lower model for `log (n!)`. -/
noncomputable def naguraFactorialLogLower (n : ℕ) : ℝ :=
  (n : ℝ) * Real.log (n : ℝ) - (n : ℝ) +
    Real.log (n : ℝ) / 2 + Real.log (2 * Real.pi) / 2

/-- The coefficient of the main linear term after Nagura's reciprocal
identity cancels the `k * log k` terms. -/
noncomputable def naguraMainCoefficient : ℝ :=
  Real.log 2 / 2 + Real.log 3 / 3 + Real.log 7 / 7 +
    Real.log 43 / 43 + Real.log 1806 / 1806

/-- Nagura's six-term combination of finite Chebyshev sums, at the common
denominator `1806 = 2 * 3 * 7 * 43`. -/
noncomputable def naguraChebyshevCombination (k : ℕ) : ℝ :=
  naguraChebyshevSum (1806 * k) - naguraChebyshevSum (903 * k) -
    naguraChebyshevSum (602 * k) - naguraChebyshevSum (258 * k) -
      naguraChebyshevSum (42 * k) - naguraChebyshevSum k

/-- The completely explicit Stirling majorant for Nagura's six-term
Chebyshev combination. -/
noncomputable def naguraStirlingMajorant (k : ℕ) : ℝ :=
  naguraFactorialLogUpper (1806 * k) -
    naguraFactorialLogLower (903 * k) -
      naguraFactorialLogLower (602 * k) -
        naguraFactorialLogLower (258 * k) -
          naguraFactorialLogLower (42 * k) -
            naguraFactorialLogLower k

/-- The lower-order part left after extracting Nagura's main linear
coefficient from the Stirling majorant. -/
noncomputable def naguraStirlingRemainder (k : ℕ) : ℝ :=
  Real.log ((1806 * k : ℕ) : ℝ) + 1 -
    Real.log ((903 * k : ℕ) : ℝ) / 2 -
      Real.log ((602 * k : ℕ) : ℝ) / 2 -
        Real.log ((258 * k : ℕ) : ℝ) / 2 -
          Real.log ((42 * k : ℕ) : ℝ) / 2 -
            Real.log (k : ℝ) / 2 -
              5 * Real.log (2 * Real.pi) / 2

/-- The Egyptian-fraction identity responsible for cancellation of all
`k * log k` and linear terms in Nagura's combination. -/
theorem nagura_reciprocal_numerators :
    903 + 602 + 258 + 42 + 1 = 1806 := by
  norm_num

/-- Mathlib's Stirling theorem supplies the lower model for every positive
factorial argument. -/
theorem naguraFactorialLogLower_le_log_factorial {n : ℕ} (hn : n ≠ 0) :
    naguraFactorialLogLower n ≤ Real.log (n.factorial : ℝ) := by
  exact Stirling.le_log_factorial_stirling hn

/-- The elementary integral estimate supplies the upper model. -/
theorem log_factorial_le_naguraFactorialLogUpper {n : ℕ} (hn : n ≠ 0) :
    Real.log (n.factorial : ℝ) ≤ naguraFactorialLogUpper n := by
  exact log_factorial_le_stirling_elementary hn

/-- Exact simplification of the explicit Stirling majorant.  In particular,
the cancellation of the `k * log k` and linear terms is checked by the
kernel, rather than used as an informal asymptotic calculation. -/
theorem naguraStirlingMajorant_eq_main_add_remainder
    {k : ℕ} (hk : 0 < k) :
    naguraStirlingMajorant k =
      (1806 : ℝ) * (k : ℝ) * naguraMainCoefficient +
        naguraStirlingRemainder k := by
  have hkR : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  have h903 : Real.log (903 : ℝ) = Real.log 1806 - Real.log 2 := by
    calc
      Real.log (903 : ℝ) = Real.log ((1806 : ℝ) / 2) := by norm_num
      _ = Real.log 1806 - Real.log 2 :=
        Real.log_div (by norm_num) (by norm_num)
  have h602 : Real.log (602 : ℝ) = Real.log 1806 - Real.log 3 := by
    calc
      Real.log (602 : ℝ) = Real.log ((1806 : ℝ) / 3) := by norm_num
      _ = Real.log 1806 - Real.log 3 :=
        Real.log_div (by norm_num) (by norm_num)
  have h258 : Real.log (258 : ℝ) = Real.log 1806 - Real.log 7 := by
    calc
      Real.log (258 : ℝ) = Real.log ((1806 : ℝ) / 7) := by norm_num
      _ = Real.log 1806 - Real.log 7 :=
        Real.log_div (by norm_num) (by norm_num)
  have h42 : Real.log (42 : ℝ) = Real.log 1806 - Real.log 43 := by
    calc
      Real.log (42 : ℝ) = Real.log ((1806 : ℝ) / 43) := by norm_num
      _ = Real.log 1806 - Real.log 43 :=
        Real.log_div (by norm_num) (by norm_num)
  simp only [naguraStirlingMajorant, naguraFactorialLogUpper,
    naguraFactorialLogLower, naguraMainCoefficient, naguraStirlingRemainder,
    Nat.cast_mul, Nat.cast_ofNat]
  rw [Real.log_mul (by norm_num : (1806 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (903 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (602 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (258 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (42 : ℝ) ≠ 0) hkR,
    h903, h602, h258, h42]
  ring

/-- Nagura's Chebyshev combination is bounded above by the fully explicit
Stirling expression. -/
theorem naguraChebyshevCombination_le_stirlingMajorant
    {k : ℕ} (hk : 0 < k) :
    naguraChebyshevCombination k ≤ naguraStirlingMajorant k := by
  have hk0 : k ≠ 0 := Nat.ne_of_gt hk
  have h1806 : (1806 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have h903 : (903 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have h602 : (602 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have h258 : (258 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have h42 : (42 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have hUpper := log_factorial_le_naguraFactorialLogUpper h1806
  have h903Lower := naguraFactorialLogLower_le_log_factorial h903
  have h602Lower := naguraFactorialLogLower_le_log_factorial h602
  have h258Lower := naguraFactorialLogLower_le_log_factorial h258
  have h42Lower := naguraFactorialLogLower_le_log_factorial h42
  have hkLower := naguraFactorialLogLower_le_log_factorial hk0
  simp only [naguraChebyshevCombination, naguraChebyshevSum_eq_log_factorial]
  unfold naguraStirlingMajorant
  linarith

/-- A convenient one-sided form of Mathlib's finite Taylor remainder bound
for `log (1 - x)`. -/
theorem log_one_sub_le_neg_sum_add_remainder {x : ℝ} (hx : |x| < 1) (n : ℕ) :
    Real.log (1 - x) ≤
      -(∑ i ∈ Finset.range n, x ^ (i + 1) / (i + 1)) +
        |x| ^ (n + 1) / (1 - |x|) := by
  have h := Real.abs_log_sub_add_sum_range_le hx n
  have hUpper := (abs_le.mp h).2
  linarith

theorem log_three_lt_1_099 :
    Real.log 3 < (1099 : ℝ) / 1000 := by
  have hResidual :
      Real.log (1 - (1 : ℝ) / 4) ≤ -(2873 : ℝ) / 10000 := by
    calc
      Real.log (1 - (1 : ℝ) / 4) ≤
          -(∑ i ∈ Finset.range 5,
              ((1 : ℝ) / 4) ^ (i + 1) / (i + 1)) +
            |(1 : ℝ) / 4| ^ (5 + 1) / (1 - |(1 : ℝ) / 4|) :=
        log_one_sub_le_neg_sum_add_remainder (by norm_num) 5
      _ ≤ -(2873 : ℝ) / 10000 := by
        norm_num [Finset.sum_range_succ]
  have hSplit :
      Real.log 3 = 2 * Real.log 2 + Real.log (1 - (1 : ℝ) / 4) := by
    calc
      Real.log 3 = Real.log ((2 : ℝ) ^ 2 * (1 - (1 : ℝ) / 4)) := by norm_num
      _ = Real.log ((2 : ℝ) ^ 2) + Real.log (1 - (1 : ℝ) / 4) := by
        rw [Real.log_mul] <;> norm_num
      _ = 2 * Real.log 2 + Real.log (1 - (1 : ℝ) / 4) := by
        rw [Real.log_pow]
        norm_num
  rw [hSplit]
  nlinarith [Real.log_two_lt_d9]

theorem log_three_lt_eleven_tenths :
    Real.log 3 < (11 : ℝ) / 10 :=
  log_three_lt_1_099.trans (by norm_num)

theorem log_seven_lt_1_949 :
    Real.log 7 < (1949 : ℝ) / 1000 := by
  have hResidual :
      Real.log (1 - (1 : ℝ) / 8) ≤ -(1305 : ℝ) / 10000 := by
    calc
      Real.log (1 - (1 : ℝ) / 8) ≤
          -(∑ i ∈ Finset.range 2,
              ((1 : ℝ) / 8) ^ (i + 1) / (i + 1)) +
            |(1 : ℝ) / 8| ^ (2 + 1) / (1 - |(1 : ℝ) / 8|) :=
        log_one_sub_le_neg_sum_add_remainder (by norm_num) 2
      _ ≤ -(1305 : ℝ) / 10000 := by
        norm_num [Finset.sum_range_succ]
  have hSplit :
      Real.log 7 = 3 * Real.log 2 + Real.log (1 - (1 : ℝ) / 8) := by
    calc
      Real.log 7 = Real.log ((2 : ℝ) ^ 3 * (1 - (1 : ℝ) / 8)) := by norm_num
      _ = Real.log ((2 : ℝ) ^ 3) + Real.log (1 - (1 : ℝ) / 8) := by
        rw [Real.log_mul] <;> norm_num
      _ = 3 * Real.log 2 + Real.log (1 - (1 : ℝ) / 8) := by
        rw [Real.log_pow]
        norm_num
  rw [hSplit]
  nlinarith [Real.log_two_lt_d9]

theorem log_seven_lt_one_point_nine_five :
    Real.log 7 < (195 : ℝ) / 100 :=
  log_seven_lt_1_949.trans (by norm_num)

theorem log_forty_three_lt_3_762 :
    Real.log 43 < (1881 : ℝ) / 500 := by
  have hResidual :
      Real.log (1 - (21 : ℝ) / 64) ≤ -(3969 : ℝ) / 10000 := by
    calc
      Real.log (1 - (21 : ℝ) / 64) ≤
          -(∑ i ∈ Finset.range 6,
              ((21 : ℝ) / 64) ^ (i + 1) / (i + 1)) +
            |(21 : ℝ) / 64| ^ (6 + 1) / (1 - |(21 : ℝ) / 64|) :=
        log_one_sub_le_neg_sum_add_remainder (by norm_num) 6
      _ ≤ -(3969 : ℝ) / 10000 := by
        norm_num [Finset.sum_range_succ]
  have hSplit :
      Real.log 43 = 6 * Real.log 2 + Real.log (1 - (21 : ℝ) / 64) := by
    calc
      Real.log 43 = Real.log ((2 : ℝ) ^ 6 * (1 - (21 : ℝ) / 64)) := by norm_num
      _ = Real.log ((2 : ℝ) ^ 6) + Real.log (1 - (21 : ℝ) / 64) := by
        rw [Real.log_mul] <;> norm_num
      _ = 6 * Real.log 2 + Real.log (1 - (21 : ℝ) / 64) := by
        rw [Real.log_pow]
        norm_num
  rw [hSplit]
  nlinarith [Real.log_two_lt_d9]

theorem log_forty_three_lt_three_point_seven_seven :
    Real.log 43 < (377 : ℝ) / 100 :=
  log_forty_three_lt_3_762.trans (by norm_num)

theorem log_one_thousand_eight_hundred_six_lt_seven_point_five :
    Real.log 1806 < (15 : ℝ) / 2 := by
  have hResidual :
      Real.log (1 - (121 : ℝ) / 1024) ≤ -(1254 : ℝ) / 10000 := by
    calc
      Real.log (1 - (121 : ℝ) / 1024) ≤
          -(∑ i ∈ Finset.range 3,
              ((121 : ℝ) / 1024) ^ (i + 1) / (i + 1)) +
            |(121 : ℝ) / 1024| ^ (3 + 1) /
              (1 - |(121 : ℝ) / 1024|) :=
        log_one_sub_le_neg_sum_add_remainder (by norm_num) 3
      _ ≤ -(1254 : ℝ) / 10000 := by
        norm_num [Finset.sum_range_succ]
  have hSplit :
      Real.log 1806 =
        11 * Real.log 2 + Real.log (1 - (121 : ℝ) / 1024) := by
    calc
      Real.log 1806 =
          Real.log ((2 : ℝ) ^ 11 * (1 - (121 : ℝ) / 1024)) := by norm_num
      _ = Real.log ((2 : ℝ) ^ 11) +
          Real.log (1 - (121 : ℝ) / 1024) := by
        rw [Real.log_mul] <;> norm_num
      _ = 11 * Real.log 2 + Real.log (1 - (121 : ℝ) / 1024) := by
        rw [Real.log_pow]
        norm_num
  rw [hSplit]
  nlinarith [Real.log_two_lt_d9]

/-- Nagura's main logarithmic coefficient is strictly below `1.086`, using
only the certified rational bounds above. -/
theorem naguraMainCoefficient_lt_1_086 :
    naguraMainCoefficient < (543 : ℝ) / 500 := by
  unfold naguraMainCoefficient
  nlinarith [Real.log_two_lt_d9, log_three_lt_eleven_tenths,
    log_seven_lt_one_point_nine_five,
    log_forty_three_lt_three_point_seven_seven,
    log_one_thousand_eight_hundred_six_lt_seven_point_five]

/-- The same certified component bounds in fact give the slightly sharper
constant `1.085`, leaving room for Nagura's recursion by `1806`. -/
theorem naguraMainCoefficient_lt_1_085 :
    naguraMainCoefficient < (217 : ℝ) / 200 := by
  unfold naguraMainCoefficient
  nlinarith [Real.log_two_lt_d9, log_three_lt_eleven_tenths,
    log_seven_lt_one_point_nine_five,
    log_forty_three_lt_three_point_seven_seven,
    log_one_thousand_eight_hundred_six_lt_seven_point_five]

/-- A sharper certified coefficient, still using short rational Taylor
calculations only. -/
theorem naguraMainCoefficient_lt_1_083 :
    naguraMainCoefficient < (1083 : ℝ) / 1000 := by
  unfold naguraMainCoefficient
  nlinarith [Real.log_two_lt_d9, log_three_lt_1_099,
    log_seven_lt_1_949, log_forty_three_lt_3_762,
    log_one_thousand_eight_hundred_six_lt_seven_point_five]

/-- The lower-order Stirling remainder is already negative for every positive
`k`.  Powers of two give ample certified lower bounds for the four large
subtracted logarithms. -/
theorem naguraStirlingRemainder_lt_zero {k : ℕ} (hk : 0 < k) :
    naguraStirlingRemainder k < 0 := by
  have hkR : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  have hkLog : 0 ≤ Real.log (k : ℝ) := by
    apply Real.log_nonneg
    exact_mod_cast hk
  have h903 : 9 * Real.log 2 ≤ Real.log 903 := by
    calc
      9 * Real.log 2 = Real.log ((2 : ℝ) ^ 9) := by
        rw [Real.log_pow]
        norm_num
      _ ≤ Real.log 903 := Real.log_le_log (by positivity) (by norm_num)
  have h602 : 9 * Real.log 2 ≤ Real.log 602 := by
    calc
      9 * Real.log 2 = Real.log ((2 : ℝ) ^ 9) := by
        rw [Real.log_pow]
        norm_num
      _ ≤ Real.log 602 := Real.log_le_log (by positivity) (by norm_num)
  have h258 : 8 * Real.log 2 ≤ Real.log 258 := by
    calc
      8 * Real.log 2 = Real.log ((2 : ℝ) ^ 8) := by
        rw [Real.log_pow]
        norm_num
      _ ≤ Real.log 258 := Real.log_le_log (by positivity) (by norm_num)
  have h42 : 5 * Real.log 2 ≤ Real.log 42 := by
    calc
      5 * Real.log 2 = Real.log ((2 : ℝ) ^ 5) := by
        rw [Real.log_pow]
        norm_num
      _ ≤ Real.log 42 := Real.log_le_log (by positivity) (by norm_num)
  have hPi : 0 ≤ Real.log (2 * Real.pi) := by
    apply Real.log_nonneg
    nlinarith [Real.pi_gt_three]
  simp only [naguraStirlingRemainder, Nat.cast_mul, Nat.cast_ofNat]
  rw [Real.log_mul (by norm_num : (1806 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (903 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (602 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (258 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (42 : ℝ) ≠ 0) hkR]
  nlinarith [Real.log_two_gt_d9,
    log_one_thousand_eight_hundred_six_lt_seven_point_five]

/-- Fully certified analytic estimate for Nagura's `1806`-scale Chebyshev
combination. -/
theorem naguraChebyshevCombination_lt_1_086_mul
    {k : ℕ} (hk : 0 < k) :
    naguraChebyshevCombination k <
      (543 : ℝ) / 500 * ((1806 * k : ℕ) : ℝ) := by
  have hCombination := naguraChebyshevCombination_le_stirlingMajorant hk
  have hMajorant := naguraStirlingMajorant_eq_main_add_remainder hk
  have hCoefficient := naguraMainCoefficient_lt_1_086
  have hRemainder := naguraStirlingRemainder_lt_zero hk
  have hScale : 0 < (1806 : ℝ) * (k : ℝ) := by positivity
  have hMain := mul_lt_mul_of_pos_left hCoefficient hScale
  rw [hMajorant] at hCombination
  calc
    naguraChebyshevCombination k ≤
        (1806 : ℝ) * (k : ℝ) * naguraMainCoefficient +
          naguraStirlingRemainder k := hCombination
    _ < (1806 : ℝ) * (k : ℝ) * ((543 : ℝ) / 500) := by
      linarith
    _ = (543 : ℝ) / 500 * ((1806 * k : ℕ) : ℝ) := by
      norm_num [Nat.cast_mul]
      ring

/-- Sharper form of the combination estimate, used to absorb the recursive
`ψ(k)` term. -/
theorem naguraChebyshevCombination_lt_1_085_mul
    {k : ℕ} (hk : 0 < k) :
    naguraChebyshevCombination k <
      (217 : ℝ) / 200 * ((1806 * k : ℕ) : ℝ) := by
  have hCombination := naguraChebyshevCombination_le_stirlingMajorant hk
  have hMajorant := naguraStirlingMajorant_eq_main_add_remainder hk
  have hCoefficient := naguraMainCoefficient_lt_1_085
  have hRemainder := naguraStirlingRemainder_lt_zero hk
  have hScale : 0 < (1806 : ℝ) * (k : ℝ) := by positivity
  have hMain := mul_lt_mul_of_pos_left hCoefficient hScale
  rw [hMajorant] at hCombination
  calc
    naguraChebyshevCombination k ≤
        (1806 : ℝ) * (k : ℝ) * naguraMainCoefficient +
          naguraStirlingRemainder k := hCombination
    _ < (1806 : ℝ) * (k : ℝ) * ((217 : ℝ) / 200) := by
      linarith
    _ = (217 : ℝ) / 200 * ((1806 * k : ℕ) : ℝ) := by
      norm_num [Nat.cast_mul]
      ring

/-- The sharpened combination estimate used in the final explicit
`ψ(1806 k)` upper bound. -/
theorem naguraChebyshevCombination_lt_1_083_mul
    {k : ℕ} (hk : 0 < k) :
    naguraChebyshevCombination k <
      (1083 : ℝ) / 1000 * ((1806 * k : ℕ) : ℝ) := by
  have hCombination := naguraChebyshevCombination_le_stirlingMajorant hk
  have hMajorant := naguraStirlingMajorant_eq_main_add_remainder hk
  have hCoefficient := naguraMainCoefficient_lt_1_083
  have hRemainder := naguraStirlingRemainder_lt_zero hk
  have hScale : 0 < (1806 : ℝ) * (k : ℝ) := by positivity
  have hMain := mul_lt_mul_of_pos_left hCoefficient hScale
  rw [hMajorant] at hCombination
  calc
    naguraChebyshevCombination k ≤
        (1806 : ℝ) * (k : ℝ) * naguraMainCoefficient +
          naguraStirlingRemainder k := hCombination
    _ < (1806 : ℝ) * (k : ℝ) * ((1083 : ℝ) / 1000) := by
      linarith
    _ = (1083 : ℝ) / 1000 * ((1806 * k : ℕ) : ℝ) := by
      norm_num [Nat.cast_mul]
      ring

/-- Shift a sum over the positive natural interval `1, ..., n` to a zero-based
range. -/
theorem sum_Ioc_zero_eq_sum_range_succ {R : Type*} [AddCommMonoid R]
    (f : ℕ → R) (n : ℕ) :
    (∑ m ∈ Finset.Ioc 0 n, f m) = ∑ i ∈ Finset.range n, f (i + 1) := by
  rw [show Finset.Ioc 0 n = Finset.Ico 1 (n + 1) by ext m; simp; omega,
    Finset.sum_Ico_eq_sum_range]
  apply Finset.sum_congr rfl
  intro i _
  congr 1
  omega

/-- There are exactly `n / d` positive multiples of a positive `d` among
`1, ..., n`, expressed as a sum of indicators. -/
theorem sum_dvd_indicator_eq_div (d : ℕ) (n : ℕ) :
    (∑ i ∈ Finset.range n, if d ∣ i + 1 then (1 : ℝ) else 0) = (n / d : ℕ) := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Finset.sum_range_succ, ih]
      by_cases h : d ∣ n + 1
      · rw [ite_eq_left h, Nat.succ_div_of_dvd h]
        norm_num
      · rw [ite_eq_right h, Nat.succ_div_of_not_dvd h]
        norm_num

/-- Indicator selection of the positive multiples of `d`. -/
theorem sum_dvd_indicator_apply_eq (d : ℕ)
    (f : ℕ → ℝ) (n : ℕ) :
    (∑ i ∈ Finset.range n, if d ∣ i + 1 then f (i + 1) else 0) =
      ∑ j ∈ Finset.range (n / d), f (d * (j + 1)) := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Finset.sum_range_succ, ih]
      by_cases h : d ∣ n + 1
      · rw [ite_eq_left h, Nat.succ_div_of_dvd h, Finset.sum_range_succ]
        congr 1
        apply congrArg f
        have hCancel : (n + 1) / d * d = n + 1 := Nat.div_mul_cancel h
        have hQuot : (n + 1) / d = n / d + 1 := Nat.succ_div_of_dvd h
        calc
          n + 1 = (n + 1) / d * d := hCancel.symm
          _ = d * ((n + 1) / d) := Nat.mul_comm _ _
          _ = d * (n / d + 1) := by rw [hQuot]
      · rw [ite_eq_right h, Nat.succ_div_of_not_dvd h]
        simp

/-- A finite summation-by-parts identity, written in terms of inclusive
partial sums. -/
theorem sum_range_mul_eq_partial_sum
    (c a : ℕ → ℝ) (n : ℕ) :
    (∑ i ∈ Finset.range (n + 1), c i * a i) =
      (∑ j ∈ Finset.range (n + 1), c j) * a n +
        ∑ i ∈ Finset.range n,
          (∑ j ∈ Finset.range (i + 1), c j) * (a i - a (i + 1)) := by
  induction n with
  | zero => simp
  | succ n ih =>
      have hPrefix :
          (∑ j ∈ Finset.range (n + 1 + 1), c j) =
            (∑ j ∈ Finset.range (n + 1), c j) + c (n + 1) :=
        Finset.sum_range_succ c (n + 1)
      have hDiff :
          (∑ i ∈ Finset.range (n + 1),
              (∑ j ∈ Finset.range (i + 1), c j) * (a i - a (i + 1))) =
            (∑ i ∈ Finset.range n,
              (∑ j ∈ Finset.range (i + 1), c j) * (a i - a (i + 1))) +
              (∑ j ∈ Finset.range (n + 1), c j) *
                (a n - a (n + 1)) :=
        Finset.sum_range_succ _ n
      calc
        (∑ i ∈ Finset.range (n + 1 + 1), c i * a i) =
            (∑ i ∈ Finset.range (n + 1), c i * a i) +
              c (n + 1) * a (n + 1) := Finset.sum_range_succ _ (n + 1)
        _ = ((∑ j ∈ Finset.range (n + 1), c j) * a n +
              ∑ i ∈ Finset.range n,
                (∑ j ∈ Finset.range (i + 1), c j) * (a i - a (i + 1))) +
              c (n + 1) * a (n + 1) := by rw [ih]
        _ = (∑ j ∈ Finset.range (n + 1 + 1), c j) * a (n + 1) +
              ∑ i ∈ Finset.range (n + 1),
                (∑ j ∈ Finset.range (i + 1), c j) * (a i - a (i + 1)) := by
          rw [hPrefix, hDiff]
          ring

/-- Nagura's coefficient attached to the `m`th term of the decreasing
Chebyshev sequence. -/
def naguraWeight (m : ℕ) : ℝ :=
  1 - (if 2 ∣ m then 1 else 0) - (if 3 ∣ m then 1 else 0) -
    (if 7 ∣ m then 1 else 0) - (if 43 ∣ m then 1 else 0) -
      (if 1806 ∣ m then 1 else 0)

/-- The exact prefix sum of Nagura's weights. -/
def naguraWeightPrefix (m : ℕ) : ℝ :=
  (m : ℝ) - (m / 2 : ℕ) - (m / 3 : ℕ) - (m / 7 : ℕ) -
    (m / 43 : ℕ) - (m / 1806 : ℕ)

theorem sum_naguraWeight_eq_prefix (m : ℕ) :
    (∑ i ∈ Finset.range m, naguraWeight (i + 1)) = naguraWeightPrefix m := by
  simp only [naguraWeight, Finset.sum_sub_distrib, Finset.sum_const,
    Finset.card_range, nsmul_eq_mul, mul_one]
  rw [sum_dvd_indicator_eq_div 2,
    sum_dvd_indicator_eq_div 3,
    sum_dvd_indicator_eq_div 7,
    sum_dvd_indicator_eq_div 43,
    sum_dvd_indicator_eq_div 1806]
  rfl

/-- Every prefix sum of Nagura's weights is nonnegative.  This is the exact
integer content of the reciprocal identity. -/
theorem naguraWeightPrefix_nonneg (m : ℕ) :
    0 ≤ naguraWeightPrefix m := by
  let q := m / 2 + m / 3 + m / 7 + m / 43 + m / 1806
  have h2 := Nat.div_mul_le_self m 2
  have h3 := Nat.div_mul_le_self m 3
  have h7 := Nat.div_mul_le_self m 7
  have h43 := Nat.div_mul_le_self m 43
  have h1806 := Nat.div_mul_le_self m 1806
  have hq : q ≤ m := by
    dsimp only [q]
    omega
  have hqR : (q : ℝ) ≤ (m : ℝ) := by exact_mod_cast hq
  dsimp only [q] at hqR
  push_cast at hqR
  unfold naguraWeightPrefix
  linarith

/-- Before the first complete `1806`-block, every nonempty prefix sum is at
least one. -/
theorem one_le_naguraWeightPrefix {m : ℕ} (hm : 0 < m) (hm1806 : m < 1806) :
    1 ≤ naguraWeightPrefix m := by
  let q := m / 2 + m / 3 + m / 7 + m / 43
  have h2 := Nat.div_mul_le_self m 2
  have h3 := Nat.div_mul_le_self m 3
  have h7 := Nat.div_mul_le_self m 7
  have h43 := Nat.div_mul_le_self m 43
  have hq : q < m := by
    dsimp only [q]
    omega
  have hqR : (q : ℝ) + 1 ≤ (m : ℝ) := by exact_mod_cast hq
  dsimp only [q] at hqR
  push_cast at hqR
  unfold naguraWeightPrefix
  rw [Nat.div_eq_of_lt hm1806]
  norm_num
  linarith

/-- The abstract decreasing-sequence inequality behind Nagura's choice of
denominators.  The right side uses at least one full `1806`-block. -/
theorem first_sub_1806_le_nagura_weighted_sum
    (a : ℕ → ℝ) (ha : Antitone a) (ha0 : ∀ i, 0 ≤ a i)
    {N : ℕ} (hN : 1806 ≤ N) :
    a 0 - a 1805 ≤
      ∑ i ∈ Finset.range N, naguraWeight (i + 1) * a i := by
  obtain ⟨M, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : N ≠ 0)
  have hM : 1805 ≤ M := by omega
  let c : ℕ → ℝ := fun i ↦ naguraWeight (i + 1)
  let P : ℕ → ℝ := fun i ↦ ∑ j ∈ Finset.range (i + 1), c j
  have hP (i : ℕ) : P i = naguraWeightPrefix (i + 1) := by
    exact sum_naguraWeight_eq_prefix (i + 1)
  have hP0 (i : ℕ) : 0 ≤ P i := by
    rw [hP]
    exact naguraWeightPrefix_nonneg (i + 1)
  have hDiff (i : ℕ) : 0 ≤ a i - a (i + 1) := by
    exact sub_nonneg.mpr (ha (Nat.le_succ i))
  have hInitial :
      (∑ i ∈ Finset.range 1805, (a i - a (i + 1))) ≤
        ∑ i ∈ Finset.range 1805, P i * (a i - a (i + 1)) := by
    apply Finset.sum_le_sum
    intro i hi
    have hi1805 : i < 1805 := Finset.mem_range.mp hi
    have hP1 : 1 ≤ P i := by
      rw [hP]
      exact one_le_naguraWeightPrefix (by omega) (by omega)
    nlinarith [mul_le_mul_of_nonneg_right hP1 (hDiff i)]
  have hExtend :
      (∑ i ∈ Finset.range 1805, P i * (a i - a (i + 1))) ≤
        ∑ i ∈ Finset.range M, P i * (a i - a (i + 1)) := by
    apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.range_mono hM)
    intro i _ _
    exact mul_nonneg (hP0 i) (hDiff i)
  have hEndpoint : 0 ≤ P M * a M := mul_nonneg (hP0 M) (ha0 M)
  have hAbel := sum_range_mul_eq_partial_sum c a M
  change
    (∑ i ∈ Finset.range (M + 1), naguraWeight (i + 1) * a i) =
      P M * a M +
        ∑ i ∈ Finset.range M, P i * (a i - a (i + 1)) at hAbel
  rw [Finset.sum_range_sub'] at hInitial
  linarith

/-- Zero-based form of Nagura's finite Chebyshev sum. -/
theorem naguraChebyshevSum_eq_sum_range (n : ℕ) :
    naguraChebyshevSum n =
      ∑ i ∈ Finset.range n, Chebyshev.psi ((n / (i + 1) : ℕ) : ℝ) := by
  unfold naguraChebyshevSum
  exact sum_Ioc_zero_eq_sum_range_succ (R := ℝ) _ n

/-- The indicator for multiples of `d` selects exactly the Chebyshev sum at
the divided endpoint. -/
theorem sum_dvd_indicator_psi_eq_chebyshevSum
    (d : ℕ) (n : ℕ) :
    (∑ i ∈ Finset.range n,
      if d ∣ i + 1 then Chebyshev.psi ((n / (i + 1) : ℕ) : ℝ) else 0) =
        naguraChebyshevSum (n / d) := by
  rw [naguraChebyshevSum_eq_sum_range]
  calc
    (∑ i ∈ Finset.range n,
        if d ∣ i + 1 then Chebyshev.psi ((n / (i + 1) : ℕ) : ℝ) else 0) =
      ∑ j ∈ Finset.range (n / d),
        Chebyshev.psi ((n / (d * (j + 1)) : ℕ) : ℝ) :=
      sum_dvd_indicator_apply_eq d
        (fun m ↦ Chebyshev.psi ((n / m : ℕ) : ℝ)) n
    _ = ∑ j ∈ Finset.range (n / d),
        Chebyshev.psi (((n / d) / (j + 1) : ℕ) : ℝ) := by
      apply Finset.sum_congr rfl
      intro j _
      rw [Nat.div_div_eq_div_mul]

/-- Exact expansion of Nagura's weighted decreasing sequence as his six-term
Chebyshev combination, before specializing to a multiple of `1806`. -/
theorem sum_naguraWeight_mul_psi_eq (n : ℕ) :
    (∑ i ∈ Finset.range n,
      naguraWeight (i + 1) * Chebyshev.psi ((n / (i + 1) : ℕ) : ℝ)) =
      naguraChebyshevSum n - naguraChebyshevSum (n / 2) -
        naguraChebyshevSum (n / 3) - naguraChebyshevSum (n / 7) -
          naguraChebyshevSum (n / 43) - naguraChebyshevSum (n / 1806) := by
  simp only [naguraWeight, sub_mul, one_mul, Finset.sum_sub_distrib]
  simp only [ite_mul, one_mul, zero_mul]
  rw [← naguraChebyshevSum_eq_sum_range n,
    sum_dvd_indicator_psi_eq_chebyshevSum 2 n,
    sum_dvd_indicator_psi_eq_chebyshevSum 3 n,
    sum_dvd_indicator_psi_eq_chebyshevSum 7 n,
    sum_dvd_indicator_psi_eq_chebyshevSum 43 n,
    sum_dvd_indicator_psi_eq_chebyshevSum 1806 n]

/-- At an `1806`-multiple, the exact weighted expansion is the named Nagura
combination. -/
theorem sum_naguraWeight_mul_psi_eq_combination (k : ℕ) :
    (∑ i ∈ Finset.range (1806 * k),
      naguraWeight (i + 1) *
        Chebyshev.psi (((1806 * k) / (i + 1) : ℕ) : ℝ)) =
      naguraChebyshevCombination k := by
  rw [sum_naguraWeight_mul_psi_eq]
  have h2 : 1806 * k / 2 = 903 * k := by omega
  have h3 : 1806 * k / 3 = 602 * k := by omega
  have h7 : 1806 * k / 7 = 258 * k := by omega
  have h43 : 1806 * k / 43 = 42 * k := by omega
  have h1806 : 1806 * k / 1806 = k := by omega
  rw [h2, h3, h7, h43, h1806]
  rfl

/-- The exact combinatorial bridge: Nagura's six-term combination controls
the increase of `ψ` across one factor of `1806`. -/
theorem psi_sub_psi_le_naguraChebyshevCombination
    {k : ℕ} (hk : 0 < k) :
    Chebyshev.psi ((1806 * k : ℕ) : ℝ) - Chebyshev.psi (k : ℝ) ≤
      naguraChebyshevCombination k := by
  let a : ℕ → ℝ := fun i ↦
    Chebyshev.psi (((1806 * k) / (i + 1) : ℕ) : ℝ)
  have ha : Antitone a := by
    intro i j hij
    apply Chebyshev.psi_mono
    norm_cast
    apply (Nat.le_div_iff_mul_le (by omega : 0 < i + 1)).2
    calc
      (1806 * k / (j + 1)) * (i + 1) ≤
          (1806 * k / (j + 1)) * (j + 1) := by
        exact Nat.mul_le_mul_left _ (Nat.succ_le_succ hij)
      _ ≤ 1806 * k := Nat.div_mul_le_self _ _
  have ha0 (i : ℕ) : 0 ≤ a i := Chebyshev.psi_nonneg _
  have h := first_sub_1806_le_nagura_weighted_sum a ha ha0
    (by omega : 1806 ≤ 1806 * k)
  dsimp only [a] at h
  rw [sum_naguraWeight_mul_psi_eq_combination] at h
  have hDiv : 1806 * k / 1806 = k := by omega
  simpa [hDiv] using h

/-- Nagura's explicit global upper constant at every positive multiple of
`1806`.  The small recursive `ψ(k)` term is absorbed using Mathlib's coarse
global Chebyshev bound and the gap between `1.083` and `1.086`. -/
theorem psi_mul_1806_lt_1_086 {k : ℕ} (hk : 0 < k) :
    Chebyshev.psi ((1806 * k : ℕ) : ℝ) <
      (543 : ℝ) / 500 * ((1806 * k : ℕ) : ℝ) := by
  have hBridge := psi_sub_psi_le_naguraChebyshevCombination hk
  have hCombination := naguraChebyshevCombination_lt_1_083_mul hk
  have hPsiK := Chebyshev.psi_le_const_mul_self (x := (k : ℝ)) (by positivity)
  have hLogFour : Real.log 4 = 2 * Real.log 2 := by
    calc
      Real.log 4 = Real.log ((2 : ℝ) ^ 2) := by norm_num
      _ = 2 * Real.log 2 := by rw [Real.log_pow]; norm_num
  have hCoarseConstant : Real.log 4 + 4 < (2709 : ℝ) / 500 := by
    rw [hLogFour]
    nlinarith [Real.log_two_lt_d9]
  have hkR : 0 < (k : ℝ) := by exact_mod_cast hk
  have hCoarseTerm := mul_lt_mul_of_pos_right hCoarseConstant hkR
  norm_num only [Nat.cast_mul, Nat.cast_ofNat] at hBridge hCombination ⊢
  nlinarith

def naguraLowerWeight (m : ℕ) : ℝ :=
  1 - (if 2 ∣ m then 1 else 0) - (if 3 ∣ m then 1 else 0) -
    (if 5 ∣ m then 1 else 0) + (if 30 ∣ m then 1 else 0)

def naguraLowerWeightPrefix (m : ℕ) : ℝ :=
  (m : ℝ) - (m / 2 : ℕ) - (m / 3 : ℕ) - (m / 5 : ℕ) + (m / 30 : ℕ)

theorem sum_naguraLowerWeight_eq_prefix (m : ℕ) :
    (∑ i ∈ Finset.range m, naguraLowerWeight (i + 1)) =
      naguraLowerWeightPrefix m := by
  simp only [naguraLowerWeight, Finset.sum_add_distrib, Finset.sum_sub_distrib,
    Finset.sum_const, Finset.card_range, nsmul_eq_mul, mul_one]
  rw [sum_dvd_indicator_eq_div 2,
    sum_dvd_indicator_eq_div 3,
    sum_dvd_indicator_eq_div 5,
    sum_dvd_indicator_eq_div 30]
  rfl

/-- The lower-combination prefix is exactly a zero-one valued function. -/
theorem naguraLowerWeightPrefix_mem_unitInterval (m : ℕ) :
    0 ≤ naguraLowerWeightPrefix m ∧ naguraLowerWeightPrefix m ≤ 1 := by
  let z : ℤ :=
    (m : ℤ) - ((m / 2 : ℕ) : ℤ) - ((m / 3 : ℕ) : ℤ) -
      ((m / 5 : ℕ) : ℤ) + ((m / 30 : ℕ) : ℤ)
  have hmem : z = 0 ∨ z = 1 := by
    dsimp only [z]
    omega
  have heq : (z : ℝ) = naguraLowerWeightPrefix m := by
    dsimp only [z]
    unfold naguraLowerWeightPrefix
    norm_cast
    try simp only [Int.cast_sub, Int.cast_add, Int.cast_natCast]
  rcases hmem with h | h <;> rw [← heq, h] <;> norm_num

/-- The lower weight, packaged as an arithmetic function so the finite
Dirichlet-convolution reindexing can be reused directly. -/
noncomputable def naguraLowerWeightArithmetic : ArithmeticFunction ℝ :=
  ⟨fun m ↦ if m = 0 then 0 else naguraLowerWeight m, by simp⟩

theorem naguraLowerWeightArithmetic_apply {m : ℕ} (hm : m ≠ 0) :
    naguraLowerWeightArithmetic m = naguraLowerWeight m := by
  simp [naguraLowerWeightArithmetic, hm]

/-- Swap the finite `m,q` divisor region after expanding `ψ` into the von
Mangoldt function. -/
theorem sum_lowerWeight_mul_psi_eq_sum_vonMangoldt_mul_prefix (n : ℕ) :
    (∑ m ∈ Finset.Ioc 0 n,
      naguraLowerWeight m * Chebyshev.psi ((n / m : ℕ) : ℝ)) =
      ∑ q ∈ Finset.Ioc 0 n,
        ArithmeticFunction.vonMangoldt q * naguraLowerWeightPrefix (n / q) := by
  let w := naguraLowerWeightArithmetic
  have h₁ := ArithmeticFunction.sum_Ioc_mul_eq_sum_sum
    (R := ℝ) w ArithmeticFunction.vonMangoldt n
  have h₂ := ArithmeticFunction.sum_Ioc_mul_eq_sum_sum
    (R := ℝ) ArithmeticFunction.vonMangoldt w n
  have hConv :
      (∑ r ∈ Finset.Ioc 0 n, (w * ArithmeticFunction.vonMangoldt) r) =
        ∑ r ∈ Finset.Ioc 0 n, (ArithmeticFunction.vonMangoldt * w) r := by
    simp only [mul_comm]
  rw [h₁] at hConv
  rw [h₂] at hConv
  calc
    (∑ m ∈ Finset.Ioc 0 n,
        naguraLowerWeight m * Chebyshev.psi ((n / m : ℕ) : ℝ)) =
      ∑ m ∈ Finset.Ioc 0 n,
        w m *
          (∑ q ∈ Finset.Ioc 0 (n / m),
            ArithmeticFunction.vonMangoldt q) := by
      apply Finset.sum_congr rfl
      intro m hm
      have hm0 : m ≠ 0 := Nat.ne_of_gt (Finset.mem_Ioc.mp hm).1
      rw [naguraLowerWeightArithmetic_apply hm0]
      simp [Chebyshev.psi]
    _ = ∑ q ∈ Finset.Ioc 0 n,
        ArithmeticFunction.vonMangoldt q *
          (∑ m ∈ Finset.Ioc 0 (n / q), w m) := hConv
    _ = ∑ q ∈ Finset.Ioc 0 n,
        ArithmeticFunction.vonMangoldt q * naguraLowerWeightPrefix (n / q) := by
      apply Finset.sum_congr rfl
      intro q _
      congr 1
      rw [sum_Ioc_zero_eq_sum_range_succ]
      calc
        (∑ i ∈ Finset.range (n / q), w (i + 1)) =
            ∑ i ∈ Finset.range (n / q), naguraLowerWeight (i + 1) := by
          apply Finset.sum_congr rfl
          intro i _
          exact naguraLowerWeightArithmetic_apply (by omega)
        _ = naguraLowerWeightPrefix (n / q) :=
          sum_naguraLowerWeight_eq_prefix (n / q)

/-- Nagura's factorial-log combination used for the lower bound on `ψ`. -/
noncomputable def naguraLowerChebyshevCombination (n : ℕ) : ℝ :=
  naguraChebyshevSum n - naguraChebyshevSum (n / 2) -
    naguraChebyshevSum (n / 3) - naguraChebyshevSum (n / 5) +
      naguraChebyshevSum (n / 30)

theorem sum_naguraLowerWeight_mul_psi_eq_combination (n : ℕ) :
    (∑ i ∈ Finset.range n,
      naguraLowerWeight (i + 1) *
        Chebyshev.psi ((n / (i + 1) : ℕ) : ℝ)) =
      naguraLowerChebyshevCombination n := by
  simp only [naguraLowerWeight, sub_mul, add_mul, one_mul,
    Finset.sum_sub_distrib, Finset.sum_add_distrib]
  simp only [ite_mul, one_mul, zero_mul]
  rw [← naguraChebyshevSum_eq_sum_range n,
    sum_dvd_indicator_psi_eq_chebyshevSum 2 n,
    sum_dvd_indicator_psi_eq_chebyshevSum 3 n,
    sum_dvd_indicator_psi_eq_chebyshevSum 5 n,
    sum_dvd_indicator_psi_eq_chebyshevSum 30 n]
  rfl

/-- The combinatorial lower bridge: the `2,3,5,30` factorial combination is
bounded above by `ψ(n)`. -/
theorem naguraLowerChebyshevCombination_le_psi (n : ℕ) :
    naguraLowerChebyshevCombination n ≤ Chebyshev.psi (n : ℝ) := by
  rw [← sum_naguraLowerWeight_mul_psi_eq_combination]
  calc
    (∑ i ∈ Finset.range n,
        naguraLowerWeight (i + 1) *
          Chebyshev.psi ((n / (i + 1) : ℕ) : ℝ)) =
      ∑ m ∈ Finset.Ioc 0 n,
        naguraLowerWeight m * Chebyshev.psi ((n / m : ℕ) : ℝ) := by
      exact (sum_Ioc_zero_eq_sum_range_succ
        (fun m ↦ naguraLowerWeight m *
          Chebyshev.psi ((n / m : ℕ) : ℝ)) n).symm
    _ = ∑ q ∈ Finset.Ioc 0 n,
        ArithmeticFunction.vonMangoldt q * naguraLowerWeightPrefix (n / q) :=
      sum_lowerWeight_mul_psi_eq_sum_vonMangoldt_mul_prefix n
    _ ≤ ∑ q ∈ Finset.Ioc 0 n, ArithmeticFunction.vonMangoldt q := by
      apply Finset.sum_le_sum
      intro q _
      have hΛ := ArithmeticFunction.vonMangoldt_nonneg (n := q)
      have hPrefix := (naguraLowerWeightPrefix_mem_unitInterval (n / q)).2
      nlinarith [mul_le_mul_of_nonneg_left hPrefix hΛ]
    _ = Chebyshev.psi (n : ℝ) := by
      simp [Chebyshev.psi]

/-- One-sided lower form of the finite Taylor remainder for `log (1 - x)`. -/
theorem neg_sum_sub_remainder_le_log_one_sub {x : ℝ} (hx : |x| < 1) (n : ℕ) :
    -(∑ i ∈ Finset.range n, x ^ (i + 1) / (i + 1)) -
        |x| ^ (n + 1) / (1 - |x|) ≤ Real.log (1 - x) := by
  have h := Real.abs_log_sub_add_sum_range_le hx n
  have hLower := (abs_le.mp h).1
  linarith

theorem log_three_gt_1_098 :
    (549 : ℝ) / 500 < Real.log 3 := by
  have hResidual :
      -(288 : ℝ) / 1000 ≤ Real.log (1 - (1 : ℝ) / 4) := by
    calc
      -(288 : ℝ) / 1000 ≤
          -(∑ i ∈ Finset.range 5,
              ((1 : ℝ) / 4) ^ (i + 1) / (i + 1)) -
            |(1 : ℝ) / 4| ^ (5 + 1) / (1 - |(1 : ℝ) / 4|) := by
        norm_num [Finset.sum_range_succ]
      _ ≤ Real.log (1 - (1 : ℝ) / 4) :=
        neg_sum_sub_remainder_le_log_one_sub (by norm_num) 5
  have hSplit :
      Real.log 3 = 2 * Real.log 2 + Real.log (1 - (1 : ℝ) / 4) := by
    calc
      Real.log 3 = Real.log ((2 : ℝ) ^ 2 * (1 - (1 : ℝ) / 4)) := by norm_num
      _ = Real.log ((2 : ℝ) ^ 2) + Real.log (1 - (1 : ℝ) / 4) := by
        rw [Real.log_mul] <;> norm_num
      _ = 2 * Real.log 2 + Real.log (1 - (1 : ℝ) / 4) := by
        rw [Real.log_pow]
        norm_num
  rw [hSplit]
  nlinarith [Real.log_two_gt_d9]

theorem log_five_gt_1_609 :
    (1609 : ℝ) / 1000 < Real.log 5 := by
  have hResidual :
      -(4703 : ℝ) / 10000 ≤ Real.log (1 - (3 : ℝ) / 8) := by
    calc
      -(4703 : ℝ) / 10000 ≤
          -(∑ i ∈ Finset.range 8,
              ((3 : ℝ) / 8) ^ (i + 1) / (i + 1)) -
            |(3 : ℝ) / 8| ^ (8 + 1) / (1 - |(3 : ℝ) / 8|) := by
        norm_num [Finset.sum_range_succ]
      _ ≤ Real.log (1 - (3 : ℝ) / 8) :=
        neg_sum_sub_remainder_le_log_one_sub (by norm_num) 8
  have hSplit :
      Real.log 5 = 3 * Real.log 2 + Real.log (1 - (3 : ℝ) / 8) := by
    calc
      Real.log 5 = Real.log ((2 : ℝ) ^ 3 * (1 - (3 : ℝ) / 8)) := by norm_num
      _ = Real.log ((2 : ℝ) ^ 3) + Real.log (1 - (3 : ℝ) / 8) := by
        rw [Real.log_mul] <;> norm_num
      _ = 3 * Real.log 2 + Real.log (1 - (3 : ℝ) / 8) := by
        rw [Real.log_pow]
        norm_num
  rw [hSplit]
  nlinarith [Real.log_two_gt_d9]

theorem log_thirty_lt_3_402 :
    Real.log 30 < (1701 : ℝ) / 500 := by
  have hResidual :
      Real.log (1 - (1 : ℝ) / 16) ≤ -(641 : ℝ) / 10000 := by
    calc
      Real.log (1 - (1 : ℝ) / 16) ≤
          -(∑ i ∈ Finset.range 2,
              ((1 : ℝ) / 16) ^ (i + 1) / (i + 1)) +
            |(1 : ℝ) / 16| ^ (2 + 1) / (1 - |(1 : ℝ) / 16|) :=
        log_one_sub_le_neg_sum_add_remainder (by norm_num) 2
      _ ≤ -(641 : ℝ) / 10000 := by
        norm_num [Finset.sum_range_succ]
  have hSplit :
      Real.log 30 = 5 * Real.log 2 + Real.log (1 - (1 : ℝ) / 16) := by
    calc
      Real.log 30 = Real.log ((2 : ℝ) ^ 5 * (1 - (1 : ℝ) / 16)) := by norm_num
      _ = Real.log ((2 : ℝ) ^ 5) + Real.log (1 - (1 : ℝ) / 16) := by
        rw [Real.log_mul] <;> norm_num
      _ = 5 * Real.log 2 + Real.log (1 - (1 : ℝ) / 16) := by
        rw [Real.log_pow]
        norm_num
  rw [hSplit]
  nlinarith [Real.log_two_lt_d9]

/-- The main coefficient of Nagura's lower factorial combination. -/
noncomputable def naguraLowerMainCoefficient : ℝ :=
  Real.log 2 / 2 + Real.log 3 / 3 + Real.log 5 / 5 -
    Real.log 30 / 30

theorem naguraLowerMainCoefficient_gt_0_9209 :
    (9209 : ℝ) / 10000 < naguraLowerMainCoefficient := by
  unfold naguraLowerMainCoefficient
  nlinarith [Real.log_two_gt_d9, log_three_gt_1_098,
    log_five_gt_1_609, log_thirty_lt_3_402]

/-- The Stirling minorant for the lower `2,3,5,30` combination at `30k`. -/
noncomputable def naguraLowerStirlingMinorant (k : ℕ) : ℝ :=
  naguraFactorialLogLower (30 * k) - naguraFactorialLogUpper (15 * k) -
    naguraFactorialLogUpper (10 * k) - naguraFactorialLogUpper (6 * k) +
      naguraFactorialLogLower k

/-- Its lower-order remainder after exact cancellation of the linear and
`k log k` main terms. -/
noncomputable def naguraLowerStirlingRemainder (k : ℕ) : ℝ :=
  Real.log ((30 * k : ℕ) : ℝ) / 2 - Real.log ((15 * k : ℕ) : ℝ) -
    Real.log ((10 * k : ℕ) : ℝ) - Real.log ((6 * k : ℕ) : ℝ) +
      Real.log (k : ℝ) / 2 + Real.log (2 * Real.pi) - 3

theorem naguraLowerStirlingMinorant_eq_main_add_remainder
    {k : ℕ} (hk : 0 < k) :
    naguraLowerStirlingMinorant k =
      (30 : ℝ) * (k : ℝ) * naguraLowerMainCoefficient +
        naguraLowerStirlingRemainder k := by
  have hkR : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  have h15 : Real.log (15 : ℝ) = Real.log 30 - Real.log 2 := by
    calc
      Real.log (15 : ℝ) = Real.log ((30 : ℝ) / 2) := by norm_num
      _ = Real.log 30 - Real.log 2 := Real.log_div (by norm_num) (by norm_num)
  have h10 : Real.log (10 : ℝ) = Real.log 30 - Real.log 3 := by
    calc
      Real.log (10 : ℝ) = Real.log ((30 : ℝ) / 3) := by norm_num
      _ = Real.log 30 - Real.log 3 := Real.log_div (by norm_num) (by norm_num)
  have h6 : Real.log (6 : ℝ) = Real.log 30 - Real.log 5 := by
    calc
      Real.log (6 : ℝ) = Real.log ((30 : ℝ) / 5) := by norm_num
      _ = Real.log 30 - Real.log 5 := Real.log_div (by norm_num) (by norm_num)
  simp only [naguraLowerStirlingMinorant, naguraFactorialLogLower,
    naguraFactorialLogUpper, naguraLowerMainCoefficient,
    naguraLowerStirlingRemainder, Nat.cast_mul, Nat.cast_ofNat]
  rw [Real.log_mul (by norm_num : (30 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (15 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (10 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (6 : ℝ) ≠ 0) hkR,
    h15, h10, h6]
  ring

/-- Stirling bounds sandwich the factorial combination from below. -/
theorem naguraLowerStirlingMinorant_le_combination
    {k : ℕ} (hk : 0 < k) :
    naguraLowerStirlingMinorant k ≤
      naguraLowerChebyshevCombination (30 * k) := by
  have hk0 : k ≠ 0 := Nat.ne_of_gt hk
  have h30 : (30 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have h15 : (15 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have h10 : (10 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have h6 : (6 * k : ℕ) ≠ 0 := Nat.mul_ne_zero (by norm_num) hk0
  have h30Lower := naguraFactorialLogLower_le_log_factorial h30
  have hkLower := naguraFactorialLogLower_le_log_factorial hk0
  have h15Upper := log_factorial_le_naguraFactorialLogUpper h15
  have h10Upper := log_factorial_le_naguraFactorialLogUpper h10
  have h6Upper := log_factorial_le_naguraFactorialLogUpper h6
  simp only [naguraLowerChebyshevCombination,
    naguraChebyshevSum_eq_log_factorial]
  have h2 : 30 * k / 2 = 15 * k := by omega
  have h3 : 30 * k / 3 = 10 * k := by omega
  have h5 : 30 * k / 5 = 6 * k := by omega
  have h30div : 30 * k / 30 = k := by omega
  rw [h2, h3, h5, h30div]
  unfold naguraLowerStirlingMinorant
  linarith

/-- A deliberately simple explicit logarithm bound, sufficient to control
the lower-order Stirling remainder. -/
theorem log_nat_lt_div_one_hundred_add_four {k : ℕ} (hk : 0 < k) :
    Real.log (k : ℝ) < (k : ℝ) / 100 + 4 := by
  have hkR : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  have hkPos : 0 < (k : ℝ) := by exact_mod_cast hk
  have hSmall := Real.log_le_sub_one_of_pos
    (show 0 < (k : ℝ) / 100 by positivity)
  have hLogHundred : Real.log 100 < 5 := by
    have hMono : Real.log (100 : ℝ) < Real.log ((2 : ℝ) ^ 7) :=
      Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)
    rw [Real.log_pow] at hMono
    norm_num at hMono
    nlinarith [Real.log_two_lt_d9]
  have hSplit :
      Real.log (k : ℝ) = Real.log ((k : ℝ) / 100) + Real.log 100 := by
    calc
      Real.log (k : ℝ) = Real.log (((k : ℝ) / 100) * 100) := by
        congr 1
        field_simp
      _ = Real.log ((k : ℝ) / 100) + Real.log 100 :=
        Real.log_mul (div_ne_zero hkR (by norm_num)) (by norm_num)
  rw [hSplit]
  linarith

/-- A coarse but fully explicit lower estimate for the lower-order
Stirling remainder. -/
theorem neg_eleven_sub_two_log_lt_naguraLowerStirlingRemainder
    {k : ℕ} (hk : 0 < k) :
    -11 - 2 * Real.log (k : ℝ) < naguraLowerStirlingRemainder k := by
  have hkR : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  have h15 : Real.log 15 < 4 * Real.log 2 := by
    calc
      Real.log 15 < Real.log ((2 : ℝ) ^ 4) :=
        Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)
      _ = 4 * Real.log 2 := by rw [Real.log_pow]; norm_num
  have h10 : Real.log 10 < 4 * Real.log 2 := by
    calc
      Real.log 10 < Real.log ((2 : ℝ) ^ 4) :=
        Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)
      _ = 4 * Real.log 2 := by rw [Real.log_pow]; norm_num
  have h6 : Real.log 6 < 3 * Real.log 2 := by
    calc
      Real.log 6 < Real.log ((2 : ℝ) ^ 3) :=
        Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)
      _ = 3 * Real.log 2 := by rw [Real.log_pow]; norm_num
  have h30 : 0 ≤ Real.log 30 := Real.log_nonneg (by norm_num)
  have hPi : 0 ≤ Real.log (2 * Real.pi) := by
    apply Real.log_nonneg
    nlinarith [Real.pi_gt_three]
  simp only [naguraLowerStirlingRemainder, Nat.cast_mul, Nat.cast_ofNat]
  rw [Real.log_mul (by norm_num : (30 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (15 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (10 : ℝ) ≠ 0) hkR,
    Real.log_mul (by norm_num : (6 : ℝ) ≠ 0) hkR]
  nlinarith [Real.log_two_lt_d9]

/-- Explicit analytic lower bound for the factorial combination once
`30k ≥ 4500`. -/
theorem naguraLowerChebyshevCombination_gt_0_916_mul
    {k : ℕ} (hk : 150 ≤ k) :
    (229 : ℝ) / 250 * ((30 * k : ℕ) : ℝ) <
      naguraLowerChebyshevCombination (30 * k) := by
  have hkPos : 0 < k := by omega
  have hMinorant := naguraLowerStirlingMinorant_le_combination hkPos
  have hIdentity := naguraLowerStirlingMinorant_eq_main_add_remainder hkPos
  have hCoefficient := naguraLowerMainCoefficient_gt_0_9209
  have hRemainder :=
    neg_eleven_sub_two_log_lt_naguraLowerStirlingRemainder hkPos
  have hLog := log_nat_lt_div_one_hundred_add_four hkPos
  have hScale : 0 < (30 : ℝ) * (k : ℝ) := by positivity
  have hMain := mul_lt_mul_of_pos_left hCoefficient hScale
  have hkR : (150 : ℝ) ≤ (k : ℝ) := by exact_mod_cast hk
  rw [hIdentity] at hMinorant
  norm_num only [Nat.cast_mul, Nat.cast_ofNat] at hMinorant ⊢
  nlinarith

/-- Fully unconditional Nagura-style lower bound on `ψ` at positive
multiples of `30` beyond the explicit threshold `3900`. -/
theorem psi_mul_30_gt_0_916 {k : ℕ} (hk : 150 ≤ k) :
    (229 : ℝ) / 250 * ((30 * k : ℕ) : ℝ) <
      Chebyshev.psi ((30 * k : ℕ) : ℝ) := by
  exact (naguraLowerChebyshevCombination_gt_0_916_mul hk).trans_le
    (naguraLowerChebyshevCombination_le_psi (30 * k))

/-- Rounding down to a multiple of `30` gives an unconditional global lower
bound.  The additive loss `27.48 = 0.916 * 30` is exactly the cost of this
safe rounding step. -/
theorem psi_gt_0_916_mul_sub_27_48 {n : ℕ} (hn : 4500 ≤ n) :
    (229 : ℝ) / 250 * (n : ℝ) - (687 : ℝ) / 25 <
      Chebyshev.psi (n : ℝ) := by
  let k := n / 30
  have hk : 150 ≤ k := by
    dsimp only [k]
    omega
  have hLower := psi_mul_30_gt_0_916 hk
  have hMulLe : 30 * k ≤ n := by
    dsimp only [k]
    omega
  have hClose : n < 30 * k + 30 := by
    dsimp only [k]
    omega
  have hMono :
      Chebyshev.psi ((30 * k : ℕ) : ℝ) ≤ Chebyshev.psi (n : ℝ) :=
    Chebyshev.psi_mono (by exact_mod_cast hMulLe)
  have hCloseR : (n : ℝ) < (30 * k : ℕ) + 30 := by exact_mod_cast hClose
  norm_num only [Nat.cast_mul, Nat.cast_add, Nat.cast_ofNat] at hLower hMono hCloseR ⊢
  nlinarith

/-- Rounding up to a multiple of `1806` gives an unconditional global upper
bound.  This isolates the additive loss caused by restricting the fully
proved sharp estimate to that arithmetic progression. -/
theorem psi_lt_1_086_mul_add_1961_316 {n : ℕ} (hn : 0 < n) :
    Chebyshev.psi (n : ℝ) <
      (543 : ℝ) / 500 * (n : ℝ) + (490329 : ℝ) / 250 := by
  let k := (n + 1805) / 1806
  have hk : 0 < k := by
    dsimp only [k]
    omega
  have hnLe : n ≤ 1806 * k := by
    dsimp only [k]
    omega
  have hClose : 1806 * k < n + 1806 := by
    dsimp only [k]
    omega
  have hUpper := psi_mul_1806_lt_1_086 hk
  have hMono :
      Chebyshev.psi (n : ℝ) ≤ Chebyshev.psi ((1806 * k : ℕ) : ℝ) :=
    Chebyshev.psi_mono (by exact_mod_cast hnLe)
  have hCloseR : ((1806 * k : ℕ) : ℝ) < (n : ℝ) + 1806 := by
    exact_mod_cast hClose
  norm_num only [Nat.cast_mul, Nat.cast_add, Nat.cast_ofNat] at hUpper hMono hCloseR ⊢
  nlinarith

/-- Nagura's first combination at an arbitrary natural endpoint. -/
noncomputable def naguraGeneralUpperCombination (n : ℕ) : ℝ :=
  naguraChebyshevSum n - naguraChebyshevSum (n / 2) -
    naguraChebyshevSum (n / 3) - naguraChebyshevSum (n / 7) -
      naguraChebyshevSum (n / 43) - naguraChebyshevSum (n / 1806)

/-- A real lower model for the Stirling expression at `floor (n / d)`.
The quantity `(n - d + 1) / d` is a lower bound for that floor. -/
noncomputable def naguraFloorFactorialLowerModel (n d : ℕ) : ℝ :=
  let x := (n : ℝ)
  let y := (x - (d : ℝ) + 1) / (d : ℝ)
  y * Real.log y - x / (d : ℝ) + Real.log y / 2 +
    Real.log (2 * Real.pi) / 2

/-- The real lower model lies below the proved Stirling model at the natural
floor. -/
theorem naguraFloorFactorialLowerModel_le
    {n d : ℕ} (hd : 0 < d) (hnd : 2 * d ≤ n + 1) :
    naguraFloorFactorialLowerModel n d ≤
      naguraFactorialLogLower (n / d) := by
  let x : ℝ := n
  let q : ℝ := (n / d : ℕ)
  let y : ℝ := (x - d + 1) / d
  have hdR : 0 < (d : ℝ) := by exact_mod_cast hd
  have hMulLe : n / d * d ≤ n := Nat.div_mul_le_self n d
  have hLt : n < d * (n / d + 1) := Nat.lt_mul_div_succ n hd
  have hLowerNat : n + 1 ≤ d * (n / d + 1) := by omega
  have hMulLeR : q * (d : ℝ) ≤ x := by
    dsimp only [q, x]
    exact_mod_cast hMulLe
  have hLowerR : (n : ℝ) + 1 ≤ (d : ℝ) * ((n / d : ℕ) + 1) := by
    exact_mod_cast hLowerNat
  have hqy : y ≤ q := by
    dsimp only [y, q, x]
    apply (div_le_iff₀ hdR).2
    nlinarith
  have hqUpper : q ≤ x / d := by
    apply (le_div_iff₀ hdR).2
    exact hMulLeR
  have hyOne : 1 ≤ y := by
    have hndR : 2 * (d : ℝ) ≤ (n : ℝ) + 1 := by exact_mod_cast hnd
    dsimp only [y, x]
    apply (le_div_iff₀ hdR).2
    nlinarith
  have hyPos : 0 < y := zero_lt_one.trans_le hyOne
  have hLog : Real.log y ≤ Real.log q :=
    Real.log_le_log hyPos hqy
  have hLogNonneg : 0 ≤ Real.log y := Real.log_nonneg hyOne
  have hqNonneg : 0 ≤ q := by positivity
  have hMulLog : y * Real.log y ≤ q * Real.log q :=
    mul_le_mul hqy hLog hLogNonneg hqNonneg
  simp only [naguraFloorFactorialLowerModel, naguraFactorialLogLower]
  change
    y * Real.log y - x / d + Real.log y / 2 +
        Real.log (2 * Real.pi) / 2 ≤
      q * Real.log q - q + Real.log q / 2 +
        Real.log (2 * Real.pi) / 2
  linarith

/-- Stirling upper model for the arbitrary-endpoint combination. -/
noncomputable def naguraGeneralUpperModel (n : ℕ) : ℝ :=
  naguraFactorialLogUpper n - naguraFloorFactorialLowerModel n 2 -
    naguraFloorFactorialLowerModel n 3 - naguraFloorFactorialLowerModel n 7 -
      naguraFloorFactorialLowerModel n 43 -
        naguraFloorFactorialLowerModel n 1806

theorem naguraGeneralUpperCombination_le_model
    {n : ℕ} (hn : 20000 ≤ n) :
    naguraGeneralUpperCombination n ≤ naguraGeneralUpperModel n := by
  have hn0 : n ≠ 0 := by omega
  have h2 : n / 2 ≠ 0 := by omega
  have h3 : n / 3 ≠ 0 := by omega
  have h7 : n / 7 ≠ 0 := by omega
  have h43 : n / 43 ≠ 0 := by omega
  have h1806 : n / 1806 ≠ 0 := by omega
  have hUpper := log_factorial_le_naguraFactorialLogUpper hn0
  have h2Stirling := naguraFactorialLogLower_le_log_factorial h2
  have h3Stirling := naguraFactorialLogLower_le_log_factorial h3
  have h7Stirling := naguraFactorialLogLower_le_log_factorial h7
  have h43Stirling := naguraFactorialLogLower_le_log_factorial h43
  have h1806Stirling := naguraFactorialLogLower_le_log_factorial h1806
  have h2Floor := naguraFloorFactorialLowerModel_le
    (n := n) (d := 2) (by norm_num) (by omega)
  have h3Floor := naguraFloorFactorialLowerModel_le
    (n := n) (d := 3) (by norm_num) (by omega)
  have h7Floor := naguraFloorFactorialLowerModel_le
    (n := n) (d := 7) (by norm_num) (by omega)
  have h43Floor := naguraFloorFactorialLowerModel_le
    (n := n) (d := 43) (by norm_num) (by omega)
  have h1806Floor := naguraFloorFactorialLowerModel_le
    (n := n) (d := 1806) (by norm_num) (by omega)
  simp only [naguraGeneralUpperCombination, naguraChebyshevSum_eq_log_factorial]
  unfold naguraGeneralUpperModel
  linarith

/-- Elementary lower bound for the logarithm of Nagura's shifted quotient. -/
theorem log_shifted_div_lower {x d : ℝ} (hd : 1 ≤ d) (hxd : d < x) :
    Real.log ((x - d + 1) / d) ≥
      Real.log x - Real.log d - (d - 1) / (x - d + 1) := by
  have hdPos : 0 < d := zero_lt_one.trans_le hd
  have hxPos : 0 < x := hdPos.trans hxd
  have hDenomPos : 0 < x - d + 1 := by linarith
  let z : ℝ := (x - d + 1) / x
  have hz : 0 < z := by
    dsimp only [z]
    positivity
  have hResidual := Real.one_sub_inv_le_log_of_pos hz
  have hResidual' :
      -(d - 1) / (x - d + 1) ≤ Real.log z := by
    calc
      -(d - 1) / (x - d + 1) = 1 - z⁻¹ := by
        dsimp only [z]
        field_simp
        ring
      _ ≤ Real.log z := hResidual
  have hFactor : (x - d + 1) / d = (x / d) * z := by
    dsimp only [z]
    field_simp
  have hSplit :
      Real.log ((x - d + 1) / d) =
        Real.log x - Real.log d + Real.log z := by
    rw [hFactor, Real.log_mul (div_ne_zero (ne_of_gt hxPos) (ne_of_gt hdPos))
      (ne_of_gt hz), Real.log_div (ne_of_gt hxPos) (ne_of_gt hdPos)]
  rw [hSplit]
  calc
    Real.log x - Real.log d - (d - 1) / (x - d + 1) =
        (Real.log x - Real.log d) + (-(d - 1) / (x - d + 1)) := by ring
    _ ≤ (Real.log x - Real.log d) + Real.log z :=
      by linarith
    _ = Real.log x - Real.log d + Real.log z := by ring

/-- The preceding logarithm estimate inserted into the real factorial lower
model. -/
noncomputable def naguraFloorFactorialCoarseModel (n d : ℕ) : ℝ :=
  let x := (n : ℝ)
  let δ := (d : ℝ)
  let y := (x - δ + 1) / δ
  let L := Real.log x - Real.log δ - (δ - 1) / (x - δ + 1)
  y * L - x / δ + L / 2 + Real.log (2 * Real.pi) / 2

theorem naguraFloorFactorialCoarseModel_le
    {n d : ℕ} (hd : 0 < d) (hnd : 2 * d ≤ n) :
    naguraFloorFactorialCoarseModel n d ≤
      naguraFloorFactorialLowerModel n d := by
  let x : ℝ := n
  let δ : ℝ := d
  let y : ℝ := (x - δ + 1) / δ
  let L : ℝ := Real.log x - Real.log δ - (δ - 1) / (x - δ + 1)
  have hdR : 1 ≤ δ := by
    dsimp only [δ]
    exact_mod_cast hd
  have hxd : δ < x := by
    dsimp only [δ, x]
    exact_mod_cast (by omega : d < n)
  have hLog : L ≤ Real.log y := by
    exact log_shifted_div_lower hdR hxd
  have hyOne : 1 ≤ y := by
    have hdPos : 0 < δ := zero_lt_one.trans_le hdR
    have hndR : 2 * δ ≤ x := by
      dsimp only [δ, x]
      exact_mod_cast hnd
    dsimp only [y]
    apply (le_div_iff₀ hdPos).2
    linarith
  have hCoeff : 0 ≤ y + 1 / 2 := by linarith
  have hMul := mul_le_mul_of_nonneg_left hLog hCoeff
  simp only [naguraFloorFactorialCoarseModel,
    naguraFloorFactorialLowerModel]
  change
    y * L - x / δ + L / 2 + Real.log (2 * Real.pi) / 2 ≤
      y * Real.log y - x / δ + Real.log y / 2 +
        Real.log (2 * Real.pi) / 2
  nlinarith

/-- The arbitrary-endpoint model after replacing each logarithm by its
explicit rational-error lower bound. -/
noncomputable def naguraGeneralUpperCoarseModel (n : ℕ) : ℝ :=
  naguraFactorialLogUpper n - naguraFloorFactorialCoarseModel n 2 -
    naguraFloorFactorialCoarseModel n 3 -
      naguraFloorFactorialCoarseModel n 7 -
        naguraFloorFactorialCoarseModel n 43 -
          naguraFloorFactorialCoarseModel n 1806

theorem naguraGeneralUpperModel_le_coarse
    {n : ℕ} (hn : 20000 ≤ n) :
    naguraGeneralUpperModel n ≤ naguraGeneralUpperCoarseModel n := by
  have h2 := naguraFloorFactorialCoarseModel_le
    (n := n) (d := 2) (by norm_num) (by omega)
  have h3 := naguraFloorFactorialCoarseModel_le
    (n := n) (d := 3) (by norm_num) (by omega)
  have h7 := naguraFloorFactorialCoarseModel_le
    (n := n) (d := 7) (by norm_num) (by omega)
  have h43 := naguraFloorFactorialCoarseModel_le
    (n := n) (d := 43) (by norm_num) (by omega)
  have h1806 := naguraFloorFactorialCoarseModel_le
    (n := n) (d := 1806) (by norm_num) (by omega)
  unfold naguraGeneralUpperModel naguraGeneralUpperCoarseModel
  linarith

/-- The residual rational loss from the five floor operations. -/
noncomputable def naguraUpperRoundingError (x : ℝ) : ℝ :=
  (1 / (x - 1) + 2 / (x - 2) + 6 / (x - 6) +
    42 / (x - 42) + 1805 / (x - 1805)) / 2

/-- A small algebra lemma, kept separate so clearing a shifted denominator
never creates the enormous common-denominator expression for all five
floors at once. -/
theorem nagura_floor_coarse_algebra
    {x δ A P : ℝ} (hδ : δ ≠ 0) (hshift : x - δ + 1 ≠ 0) :
    ((x - δ + 1) / δ) * (A - (δ - 1) / (x - δ + 1)) - x / δ +
        (A - (δ - 1) / (x - δ + 1)) / 2 + P / 2 =
      x / δ * A - (δ - 1) / δ * A - (δ - 1) / δ - x / δ +
        A / 2 - ((δ - 1) / (x - δ + 1)) / 2 + P / 2 := by
  field_simp [hδ, hshift]
  ring

/-- Exact algebraic expansion of the coarse model. -/
theorem naguraGeneralUpperCoarseModel_eq {n : ℕ} (hn : 20000 ≤ n) :
    naguraGeneralUpperCoarseModel n =
      (n : ℝ) * naguraMainCoefficient + (5 : ℝ) / 2 * Real.log (n : ℝ) +
        naguraMainCoefficient -
          (Real.log 2 + Real.log 3 + Real.log 7 + Real.log 43 +
            Real.log 1806) / 2 +
        5 - 5 * Real.log (2 * Real.pi) / 2 +
          naguraUpperRoundingError n := by
  simp only [naguraGeneralUpperCoarseModel, naguraFactorialLogUpper,
    naguraFloorFactorialCoarseModel, naguraMainCoefficient,
    naguraUpperRoundingError, Nat.cast_ofNat]
  have hnR : (20000 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have h1 : (n : ℝ) - 2 + 1 ≠ 0 := by nlinarith
  have h2 : (n : ℝ) - 3 + 1 ≠ 0 := by nlinarith
  have h6 : (n : ℝ) - 7 + 1 ≠ 0 := by nlinarith
  have h42 : (n : ℝ) - 43 + 1 ≠ 0 := by nlinarith
  have h1805 : (n : ℝ) - 1806 + 1 ≠ 0 := by nlinarith
  rw [nagura_floor_coarse_algebra (by norm_num) h1,
    nagura_floor_coarse_algebra (by norm_num) h2,
    nagura_floor_coarse_algebra (by norm_num) h6,
    nagura_floor_coarse_algebra (by norm_num) h42,
    nagura_floor_coarse_algebra (by norm_num) h1805]
  ring

theorem naguraUpperRoundingError_le_two_point_five
    {x : ℝ} (hx : 20000 ≤ x) :
    naguraUpperRoundingError x ≤ (5 : ℝ) / 2 := by
  have h1 : 1 / (x - 1) ≤ 1 := by
    apply (div_le_one (by linarith)).2
    linarith
  have h2 : 2 / (x - 2) ≤ 1 := by
    apply (div_le_one (by linarith)).2
    linarith
  have h6 : 6 / (x - 6) ≤ 1 := by
    apply (div_le_one (by linarith)).2
    linarith
  have h42 : 42 / (x - 42) ≤ 1 := by
    apply (div_le_one (by linarith)).2
    linarith
  have h1805 : 1805 / (x - 1805) ≤ 1 := by
    apply (div_le_one (by linarith)).2
    linarith
  unfold naguraUpperRoundingError
  linarith

theorem log_nat_lt_div_ten_thousand_add_nine
    {n : ℕ} (hn : 0 < n) :
    Real.log (n : ℝ) < (n : ℝ) / 10000 + 9 := by
  have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hn)
  have hSmall := Real.log_le_sub_one_of_pos
    (show 0 < (n : ℝ) / 10000 by positivity)
  have hLogTenThousand : Real.log 10000 < 10 := by
    have hMono : Real.log (10000 : ℝ) < Real.log ((2 : ℝ) ^ 14) :=
      Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)
    rw [Real.log_pow] at hMono
    norm_num at hMono
    nlinarith [Real.log_two_lt_d9]
  have hSplit :
      Real.log (n : ℝ) =
        Real.log ((n : ℝ) / 10000) + Real.log 10000 := by
    calc
      Real.log (n : ℝ) = Real.log (((n : ℝ) / 10000) * 10000) := by
        congr 1
        field_simp
      _ = Real.log ((n : ℝ) / 10000) + Real.log 10000 :=
        Real.log_mul (div_ne_zero hnR (by norm_num)) (by norm_num)
  rw [hSplit]
  linarith

/-- One extra Taylor term at `7 / 8` gives enough coefficient room to
absorb the recursive `ψ(n / 1806)` term in the far tail. -/
theorem log_seven_lt_1_9465 :
    Real.log 7 < (3893 : ℝ) / 2000 := by
  have hResidual :
      Real.log (1 - (1 : ℝ) / 8) ≤ -(1331 : ℝ) / 10000 := by
    calc
      Real.log (1 - (1 : ℝ) / 8) ≤
          -(∑ i ∈ Finset.range 3,
              ((1 : ℝ) / 8) ^ (i + 1) / (i + 1)) +
            |(1 : ℝ) / 8| ^ (3 + 1) / (1 - |(1 : ℝ) / 8|) :=
        log_one_sub_le_neg_sum_add_remainder (by norm_num) 3
      _ ≤ -(1331 : ℝ) / 10000 := by
        norm_num [Finset.sum_range_succ]
  have hSplit :
      Real.log 7 = 3 * Real.log 2 + Real.log (1 - (1 : ℝ) / 8) := by
    calc
      Real.log 7 = Real.log ((2 : ℝ) ^ 3 * (1 - (1 : ℝ) / 8)) := by
        norm_num
      _ = Real.log ((2 : ℝ) ^ 3) + Real.log (1 - (1 : ℝ) / 8) := by
        rw [Real.log_mul] <;> norm_num
      _ = 3 * Real.log 2 + Real.log (1 - (1 : ℝ) / 8) := by
        rw [Real.log_pow]
        norm_num
  rw [hSplit]
  nlinarith [Real.log_two_lt_d9]

theorem naguraMainCoefficient_lt_1_0827 :
    naguraMainCoefficient < (10827 : ℝ) / 10000 := by
  unfold naguraMainCoefficient
  nlinarith [Real.log_two_lt_d9, log_three_lt_1_099,
    log_seven_lt_1_9465, log_forty_three_lt_3_762,
    log_one_thousand_eight_hundred_six_lt_seven_point_five]

/-- The general-integer form of Nagura's first analytic estimate. -/
theorem naguraGeneralUpperCombination_lt_1_0851_mul
    {n : ℕ} (hn : 20000 ≤ n) :
    naguraGeneralUpperCombination n <
      (10851 : ℝ) / 10000 * (n : ℝ) := by
  have hModel := naguraGeneralUpperCombination_le_model hn
  have hCoarse := naguraGeneralUpperModel_le_coarse hn
  have hIdentity := naguraGeneralUpperCoarseModel_eq hn
  have hnPos : 0 < n := by omega
  have hnR : (20000 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hCoefficient := naguraMainCoefficient_lt_1_083
  have hMain := mul_lt_mul_of_pos_left hCoefficient
    (show 0 < (n : ℝ) by exact_mod_cast hnPos)
  have hLog := log_nat_lt_div_ten_thousand_add_nine hnPos
  have hError := naguraUpperRoundingError_le_two_point_five hnR
  have hLogSum :
      0 ≤ Real.log 2 + Real.log 3 + Real.log 7 + Real.log 43 + Real.log 1806 := by
    positivity
  have hPi : 0 ≤ Real.log (2 * Real.pi) := by
    apply Real.log_nonneg
    nlinarith [Real.pi_gt_three]
  rw [hIdentity] at hCoarse
  nlinarith

/-- A sharper far-tail version of the first combination estimate. -/
theorem naguraGeneralUpperCombination_lt_1_083_mul
    {n : ℕ} (hn : 1000000 ≤ n) :
    naguraGeneralUpperCombination n <
      (1083 : ℝ) / 1000 * (n : ℝ) := by
  have hnSmall : 20000 ≤ n := by omega
  have hModel := naguraGeneralUpperCombination_le_model hnSmall
  have hCoarse := naguraGeneralUpperModel_le_coarse hnSmall
  have hIdentity := naguraGeneralUpperCoarseModel_eq hnSmall
  have hnPos : 0 < n := by omega
  have hnR : (1000000 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hCoefficient := naguraMainCoefficient_lt_1_0827
  have hMain := mul_lt_mul_of_pos_left hCoefficient
    (show 0 < (n : ℝ) by exact_mod_cast hnPos)
  have hLog := log_nat_lt_div_ten_thousand_add_nine hnPos
  have hError := naguraUpperRoundingError_le_two_point_five
    (show (20000 : ℝ) ≤ (n : ℝ) by exact_mod_cast hnSmall)
  have hLogSum :
      0 ≤ Real.log 2 + Real.log 3 + Real.log 7 + Real.log 43 +
        Real.log 1806 := by
    positivity
  have hPi : 0 ≤ Real.log (2 * Real.pi) := by
    apply Real.log_nonneg
    nlinarith [Real.pi_gt_three]
  rw [hIdentity] at hCoarse
  nlinarith

/-- General-endpoint combinatorial bridge for the first Nagura weight. -/
theorem psi_sub_psi_div_1806_le_generalUpperCombination
    {n : ℕ} (hn : 1806 ≤ n) :
    Chebyshev.psi (n : ℝ) - Chebyshev.psi ((n / 1806 : ℕ) : ℝ) ≤
      naguraGeneralUpperCombination n := by
  let a : ℕ → ℝ := fun i ↦
    Chebyshev.psi (((n / (i + 1) : ℕ) : ℝ))
  have ha : Antitone a := by
    intro i j hij
    apply Chebyshev.psi_mono
    norm_cast
    apply (Nat.le_div_iff_mul_le (by omega : 0 < i + 1)).2
    calc
      (n / (j + 1)) * (i + 1) ≤ (n / (j + 1)) * (j + 1) := by
        exact Nat.mul_le_mul_left _ (Nat.succ_le_succ hij)
      _ ≤ n := Nat.div_mul_le_self _ _
  have ha0 (i : ℕ) : 0 ≤ a i := Chebyshev.psi_nonneg _
  have h := first_sub_1806_le_nagura_weighted_sum a ha ha0 hn
  dsimp only [a] at h
  rw [sum_naguraWeight_mul_psi_eq] at h
  simpa only [Nat.zero_add, Nat.div_one, Nat.reduceAdd,
    naguraGeneralUpperCombination] using h

/-- The sharp upper bound for `ψ` at every natural endpoint in the analytic
tail. -/
theorem psi_nat_lt_1_086_mul {n : ℕ} (hn : 1000000 ≤ n) :
    Chebyshev.psi (n : ℝ) < (543 : ℝ) / 500 * (n : ℝ) := by
  have hnBridge : 1806 ≤ n := by omega
  have hBridge := psi_sub_psi_div_1806_le_generalUpperCombination hnBridge
  have hCombination := naguraGeneralUpperCombination_lt_1_083_mul hn
  have hqPosNat : 0 < n / 1806 := Nat.div_pos (by omega) (by norm_num)
  have hqPos : 0 < ((n / 1806 : ℕ) : ℝ) := by exact_mod_cast hqPosNat
  have hPsi := Chebyshev.psi_le_const_mul_self
    (x := ((n / 1806 : ℕ) : ℝ)) hqPos.le
  have hLogFour : Real.log 4 = 2 * Real.log 2 := by
    calc
      Real.log 4 = Real.log ((2 : ℝ) ^ 2) := by norm_num
      _ = 2 * Real.log 2 := by rw [Real.log_pow]; norm_num
  have hCoarseConstant : Real.log 4 + 4 < (2709 : ℝ) / 500 := by
    rw [hLogFour]
    nlinarith [Real.log_two_lt_d9]
  have hCoarseTerm := mul_lt_mul_of_pos_right hCoarseConstant hqPos
  have hMulLe : (n / 1806) * 1806 ≤ n := Nat.div_mul_le_self n 1806
  have hMulLeR : ((n / 1806 : ℕ) : ℝ) * 1806 ≤ (n : ℝ) := by
    exact_mod_cast hMulLe
  nlinarith

/-- A floor-uniform upper model for `log ((n / d)!)`. -/
noncomputable def naguraFactorialUpperDivCoarseModel (n d : ℕ) : ℝ :=
  let x := (n : ℝ)
  let δ := (d : ℝ)
  x / δ * (Real.log x - Real.log δ) - x / δ +
    (Real.log x - Real.log δ) + 2

theorem naguraFactorialLogUpper_div_le_coarse
    {n d : ℕ} (hd : 0 < d) (hdn : d ≤ n) :
    naguraFactorialLogUpper (n / d) ≤
      naguraFactorialUpperDivCoarseModel n d := by
  let x : ℝ := n
  let δ : ℝ := d
  let q : ℝ := (n / d : ℕ)
  let t : ℝ := x / δ
  have hdR : 0 < δ := by
    dsimp only [δ]
    exact_mod_cast hd
  have hxR : 0 < x := by
    dsimp only [x]
    exact_mod_cast (lt_of_lt_of_le hd hdn)
  have hqPosNat : 0 < n / d := Nat.div_pos hdn hd
  have hqPos : 0 < q := by
    dsimp only [q]
    exact_mod_cast hqPosNat
  have hqOneNat : 1 ≤ n / d := by omega
  have hqOne : 1 ≤ q := by
    dsimp only [q]
    exact_mod_cast hqOneNat
  have hMulLe : n / d * d ≤ n := Nat.div_mul_le_self n d
  have hMulLeR : q * δ ≤ x := by
    dsimp only [q, δ, x]
    exact_mod_cast hMulLe
  have hqt : q ≤ t := by
    dsimp only [t]
    exact (le_div_iff₀ hdR).2 hMulLeR
  have hLt : n < d * (n / d + 1) := Nat.lt_mul_div_succ n hd
  have hLtR : x < δ * (q + 1) := by
    dsimp only [x, δ, q]
    exact_mod_cast hLt
  have htq : t < q + 1 := by
    dsimp only [t]
    exact (div_lt_iff₀ hdR).2 (by nlinarith)
  have htOne : 1 ≤ t := hqOne.trans hqt
  have htPos : 0 < t := zero_lt_one.trans_le htOne
  have hLog : Real.log q ≤ Real.log t := Real.log_le_log hqPos hqt
  have hLogQNonneg : 0 ≤ Real.log q := Real.log_nonneg hqOne
  have hMulLog : q * Real.log q ≤ t * Real.log t :=
    mul_le_mul hqt hLog hLogQNonneg htPos.le
  have hLogSplit : Real.log t = Real.log x - Real.log δ := by
    dsimp only [t]
    exact Real.log_div (ne_of_gt hxR) (ne_of_gt hdR)
  simp only [naguraFactorialLogUpper,
    naguraFactorialUpperDivCoarseModel]
  change
    q * Real.log q - q + Real.log q + 1 ≤
      t * (Real.log x - Real.log δ) - t +
        (Real.log x - Real.log δ) + 2
  rw [← hLogSplit]
  linarith

/-- A lower model for the arbitrary-endpoint `2,3,5,30` combination. -/
noncomputable def naguraGeneralLowerModel (n : ℕ) : ℝ :=
  naguraFactorialLogLower n - naguraFactorialUpperDivCoarseModel n 2 -
    naguraFactorialUpperDivCoarseModel n 3 -
      naguraFactorialUpperDivCoarseModel n 5 +
        naguraFloorFactorialCoarseModel n 30

theorem naguraGeneralLowerModel_le_combination
    {n : ℕ} (hn : 20000 ≤ n) :
    naguraGeneralLowerModel n ≤ naguraLowerChebyshevCombination n := by
  have hn0 : n ≠ 0 := by omega
  have h30 : n / 30 ≠ 0 := by omega
  have hLower := naguraFactorialLogLower_le_log_factorial hn0
  have h2Upper := log_factorial_le_naguraFactorialLogUpper
    (show n / 2 ≠ 0 by omega)
  have h3Upper := log_factorial_le_naguraFactorialLogUpper
    (show n / 3 ≠ 0 by omega)
  have h5Upper := log_factorial_le_naguraFactorialLogUpper
    (show n / 5 ≠ 0 by omega)
  have h30Lower := naguraFactorialLogLower_le_log_factorial h30
  have h2Coarse := naguraFactorialLogUpper_div_le_coarse
    (n := n) (d := 2) (by norm_num) (by omega)
  have h3Coarse := naguraFactorialLogUpper_div_le_coarse
    (n := n) (d := 3) (by norm_num) (by omega)
  have h5Coarse := naguraFactorialLogUpper_div_le_coarse
    (n := n) (d := 5) (by norm_num) (by omega)
  have h30Floor := naguraFloorFactorialCoarseModel_le
    (n := n) (d := 30) (by norm_num) (by omega)
  have h30Model := naguraFloorFactorialLowerModel_le
    (n := n) (d := 30) (by norm_num) (by omega)
  simp only [naguraLowerChebyshevCombination,
    naguraChebyshevSum_eq_log_factorial]
  unfold naguraGeneralLowerModel
  linarith

/-- The sole rational loss left by the positive `n / 30` floor. -/
noncomputable def naguraLowerRoundingError (x : ℝ) : ℝ :=
  29 / (x - 30 + 1) / 2

/-- Exact expansion of the lower coarse model. -/
theorem naguraGeneralLowerModel_eq {n : ℕ} (hn : 20000 ≤ n) :
    naguraGeneralLowerModel n =
      (n : ℝ) * naguraLowerMainCoefficient -
        (89 : ℝ) / 30 * Real.log (n : ℝ) +
        Real.log 2 + Real.log 3 + Real.log 5 +
        (7 : ℝ) / 15 * Real.log 30 + Real.log (2 * Real.pi) -
        (209 : ℝ) / 30 - naguraLowerRoundingError n := by
  simp only [naguraGeneralLowerModel, naguraFactorialLogLower,
    naguraFactorialUpperDivCoarseModel,
    naguraFloorFactorialCoarseModel, naguraLowerMainCoefficient,
    naguraLowerRoundingError, Nat.cast_ofNat]
  have hnR : (20000 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have h29 : (n : ℝ) - 30 + 1 ≠ 0 := by nlinarith
  rw [nagura_floor_coarse_algebra (by norm_num) h29]
  ring

theorem naguraLowerRoundingError_le_half
    {x : ℝ} (hx : 20000 ≤ x) :
    naguraLowerRoundingError x ≤ (1 : ℝ) / 2 := by
  have h : 29 / (x - 30 + 1) ≤ 1 := by
    apply (div_le_one (by linarith)).2
    linarith
  unfold naguraLowerRoundingError
  linarith

/-- The general-integer form of Nagura's second analytic estimate. -/
theorem naguraGeneralLowerCombination_gt_0_916_mul
    {n : ℕ} (hn : 20000 ≤ n) :
    (229 : ℝ) / 250 * (n : ℝ) <
      naguraLowerChebyshevCombination n := by
  have hModel := naguraGeneralLowerModel_le_combination hn
  have hIdentity := naguraGeneralLowerModel_eq hn
  have hnPos : 0 < n := by omega
  have hnR : (20000 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hCoefficient := naguraLowerMainCoefficient_gt_0_9209
  have hMain := mul_lt_mul_of_pos_left hCoefficient
    (show 0 < (n : ℝ) by exact_mod_cast hnPos)
  have hLog := log_nat_lt_div_ten_thousand_add_nine hnPos
  have hError := naguraLowerRoundingError_le_half hnR
  have hPositiveLogs :
      0 ≤ Real.log 2 + Real.log 3 + Real.log 5 +
        (7 : ℝ) / 15 * Real.log 30 + Real.log (2 * Real.pi) := by
    have hPi : 0 ≤ Real.log (2 * Real.pi) := by
      apply Real.log_nonneg
      nlinarith [Real.pi_gt_three]
    positivity
  rw [hIdentity] at hModel
  nlinarith

/-- Consequently `ψ(n) > 0.916 n` throughout the analytic tail. -/
theorem psi_nat_gt_0_916_mul {n : ℕ} (hn : 20000 ≤ n) :
    (229 : ℝ) / 250 * (n : ℝ) < Chebyshev.psi (n : ℝ) := by
  exact (naguraGeneralLowerCombination_gt_0_916_mul hn).trans_le
    (naguraLowerChebyshevCombination_le_psi n)


end Legendre.Nagura

end
