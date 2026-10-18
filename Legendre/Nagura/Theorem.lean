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

public import Legendre.Nagura.FiniteCertificates
public import Legendre.Nagura.PsiBounds
public import Mathlib.Tactic

/-!
# Nagura's theorem: a prime in `(n, 6n/5]` for every `n ≥ 25`

This module assembles the full unconditional proof.  The finite range
`25 ≤ n < 16000000` is covered by the kernel-checked prime chains of
`Legendre.Nagura.FiniteCertificates`; the tail `n ≥ 16000000` is covered by
the explicit `ψ` bounds of `Legendre.Nagura.PsiBounds` and the Chebyshev
bridge `hasNaguraPrime_of_psi_gap`.
-/

@[expose] public section

namespace Legendre.Nagura

/-- Largest natural upper endpoint that is certainly strictly below `6n/5`. -/
def naguraStrictUpper (n : ℕ) : ℕ :=
  (6 * n - 1) / 5

theorem naguraStrictUpper_spec {n : ℕ} (hn : 25 ≤ n) :
    n < naguraStrictUpper n ∧ 5 * naguraStrictUpper n < 6 * n := by
  constructor
  · have hdiv : n + 1 ≤ (6 * n - 1) / 5 := by
      rw [Nat.le_div_iff_mul_le (by norm_num : 0 < 5)]
      omega
    simpa only [naguraStrictUpper, Nat.lt_iff_add_one_le] using hdiv
  · have hmul : 5 * ((6 * n - 1) / 5) ≤ 6 * n - 1 := by
      rw [mul_comm]
      exact Nat.div_mul_le_self (6 * n - 1) 5
    simpa only [naguraStrictUpper] using hmul.trans_lt (by omega)

/-- A strict increase of `theta` between natural endpoints detects an actual
prime in the corresponding half-open interval. -/
theorem exists_prime_Ioc_of_theta_lt {a b : ℕ}
    (hTheta : Chebyshev.theta (a : ℝ) < Chebyshev.theta (b : ℝ)) :
    ∃ p : ℕ, p.Prime ∧ a < p ∧ p ≤ b := by
  have hab : a ≤ b := by
    by_contra hba
    have hba' : b ≤ a := Nat.le_of_not_ge hba
    have hmono :
        Chebyshev.theta (b : ℝ) ≤ Chebyshev.theta (a : ℝ) :=
      Chebyshev.theta_mono (by exact_mod_cast hba')
    exact (not_lt_of_ge hmono) hTheta
  by_contra hNoPrime
  have hNoPrime' :
      ∀ p : ℕ, p.Prime → a < p → p ≤ b → False := by
    intro p hpPrime hap hpb
    exact hNoPrime ⟨p, hpPrime, hap, hpb⟩
  have hFinset :
      (Finset.Icc 0 a).filter Nat.Prime =
        (Finset.Icc 0 b).filter Nat.Prime := by
    ext p
    simp only [Finset.mem_filter, Finset.mem_Icc]
    constructor
    · rintro ⟨⟨hpZero, hpa⟩, hpPrime⟩
      exact ⟨⟨hpZero, hpa.trans hab⟩, hpPrime⟩
    · rintro ⟨⟨hpZero, hpb⟩, hpPrime⟩
      have hpa : p ≤ a := by
        by_contra hap
        exact hNoPrime' p hpPrime (Nat.lt_of_not_ge hap) hpb
      exact ⟨⟨hpZero, hpa⟩, hpPrime⟩
  have hThetaEq :
      Chebyshev.theta (a : ℝ) = Chebyshev.theta (b : ℝ) := by
    rw [Chebyshev.theta_eq_sum_Icc, Chebyshev.theta_eq_sum_Icc]
    simpa only [Nat.floor_natCast] using congrArg
      (fun s : Finset ℕ => ∑ p ∈ s, Real.log p) hFinset
  exact (ne_of_lt hTheta) hThetaEq

/-- A concrete Chebyshev `psi` gap implies the strict natural-number Nagura
conclusion.  The error term is the already-proved Mathlib comparison
`|psi y - theta y| ≤ 2 sqrt(y) log(y)`. -/
theorem hasNaguraPrime_of_psi_gap {n : ℕ} (hn : 25 ≤ n)
    (hPsiGap :
      Chebyshev.psi (n : ℝ) +
          2 * Real.sqrt (naguraStrictUpper n : ℝ) *
            Real.log (naguraStrictUpper n : ℝ) <
        Chebyshev.psi (naguraStrictUpper n : ℝ)) :
    HasNaguraPrime n := by
  have hUpperSpec := naguraStrictUpper_spec hn
  have hUpperOne : (1 : ℝ) ≤ naguraStrictUpper n := by
    exact_mod_cast (Nat.one_le_iff_ne_zero.mpr (by omega))
  have hPsiTheta :=
    Chebyshev.abs_psi_sub_theta_le_sqrt_mul_log hUpperOne
  have hErrorUpper :
      Chebyshev.psi (naguraStrictUpper n : ℝ) -
          Chebyshev.theta (naguraStrictUpper n : ℝ) ≤
        2 * Real.sqrt (naguraStrictUpper n : ℝ) *
          Real.log (naguraStrictUpper n : ℝ) :=
    (le_abs_self _).trans hPsiTheta
  have hThetaPsi :
      Chebyshev.theta (n : ℝ) ≤ Chebyshev.psi (n : ℝ) :=
    Chebyshev.theta_le_psi (n : ℝ)
  have hThetaGap :
      Chebyshev.theta (n : ℝ) <
        Chebyshev.theta (naguraStrictUpper n : ℝ) := by
    linarith
  obtain ⟨p, hpPrime, hnp, hpUpper⟩ :=
    exists_prime_Ioc_of_theta_lt hThetaGap
  refine ⟨p, hpPrime, hnp, ?_⟩
  exact lt_of_le_of_lt (Nat.mul_le_mul_left 5 hpUpper) hUpperSpec.2

/-- Beyond sixteen million, the square-root error dominates the logarithm
by the explicit factor needed below. -/
theorem log_lt_sqrt_div_two_hundred {x : ℝ} (hx : 16000000 ≤ x) :
    Real.log x < Real.sqrt x / 200 := by
  have hxPos : 0 < x := by linarith
  let t : ℝ := Real.sqrt x
  have htNonneg : 0 ≤ t := by
    dsimp only [t]
    positivity
  have htSq : t ^ 2 = x := by
    dsimp only [t]
    exact Real.sq_sqrt hxPos.le
  have htLower : 4000 ≤ t := by nlinarith
  have htPos : 0 < t := by linarith
  have hSmall := Real.log_le_sub_one_of_pos
    (show 0 < t / 1000 by positivity)
  have hLogThousand : Real.log 1000 < 7 := by
    have hMono : Real.log (1000 : ℝ) < Real.log ((2 : ℝ) ^ 10) :=
      Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)
    rw [Real.log_pow] at hMono
    norm_num at hMono
    linarith [Real.log_two_lt_d9]
  have hSplit :
      Real.log t = Real.log (t / 1000) + Real.log 1000 := by
    calc
      Real.log t = Real.log ((t / 1000) * 1000) := by
        congr 1
        field_simp
      _ = Real.log (t / 1000) + Real.log 1000 :=
        Real.log_mul (div_ne_zero (ne_of_gt htPos) (by norm_num))
          (by norm_num)
  have hLogT : Real.log t < t / 400 := by
    rw [hSplit]
    linarith
  have hLogX : Real.log x = 2 * Real.log t := by
    calc
      Real.log x = Real.log (t ^ 2) := by rw [htSq]
      _ = 2 * Real.log t := by rw [Real.log_pow]; norm_num
  rw [hLogX]
  linarith

theorem two_sqrt_mul_log_lt_div_one_hundred {x : ℝ}
    (hx : 16000000 ≤ x) :
    2 * Real.sqrt x * Real.log x < x / 100 := by
  have hxPos : 0 < x := by linarith
  have hLog := log_lt_sqrt_div_two_hundred hx
  have hSqrtPos : 0 < Real.sqrt x := Real.sqrt_pos.2 hxPos
  have hMul := mul_lt_mul_of_pos_left hLog
    (show 0 < 2 * Real.sqrt x by positivity)
  have hSq := Real.sq_sqrt hxPos.le
  calc
    2 * Real.sqrt x * Real.log x <
        2 * Real.sqrt x * (Real.sqrt x / 200) := by
      simpa only [mul_assoc] using hMul
    _ = (Real.sqrt x) ^ 2 / 100 := by ring
    _ = x / 100 := by rw [hSq]

/-- The fully explicit analytic tail of Nagura's theorem. -/
theorem exists_prime_nagura_analytic_tail {n : ℕ}
    (hn : 16000000 ≤ n) : HasNaguraPrime n := by
  let u := naguraStrictUpper n
  have hnUpper : 1000000 ≤ n := by omega
  have huThreshold : 16000000 ≤ u := by
    dsimp only [u, naguraStrictUpper]
    rw [Nat.le_div_iff_mul_le (by norm_num : 0 < 5)]
    omega
  have huLower : 20000 ≤ u := by omega
  have hPsiUpper := psi_nat_lt_1_086_mul hnUpper
  have hPsiLower := psi_nat_gt_0_916_mul huLower
  have hError := two_sqrt_mul_log_lt_div_one_hundred
    (show (16000000 : ℝ) ≤ (u : ℝ) by exact_mod_cast huThreshold)
  have hFloorLower : 6 * n ≤ 5 * u + 5 := by
    dsimp only [u, naguraStrictUpper]
    have hDiv := Nat.lt_mul_div_succ (6 * n - 1)
      (by norm_num : 0 < 5)
    omega
  have hFloorLowerR :
      (6 : ℝ) * (n : ℝ) ≤ 5 * (u : ℝ) + 5 := by
    exact_mod_cast hFloorLower
  have hnR : (16000000 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hNumeric :
      (543 : ℝ) / 500 * (n : ℝ) + (u : ℝ) / 100 <
        (229 : ℝ) / 250 * (u : ℝ) := by
    linarith
  have hGap :
      Chebyshev.psi (n : ℝ) +
          2 * Real.sqrt (u : ℝ) * Real.log (u : ℝ) <
        Chebyshev.psi (u : ℝ) := by
    calc
      Chebyshev.psi (n : ℝ) +
            2 * Real.sqrt (u : ℝ) * Real.log (u : ℝ) <
          (543 : ℝ) / 500 * (n : ℝ) + (u : ℝ) / 100 :=
        add_lt_add hPsiUpper hError
      _ < (229 : ℝ) / 250 * (u : ℝ) := hNumeric
      _ < Chebyshev.psi (u : ℝ) := hPsiLower
  exact hasNaguraPrime_of_psi_gap (by omega) hGap

/-- For every `n ≥ 25`, there is a prime strictly between `n` and `6n/5`.
This is the public universal Nagura API used by the allocation argument. -/
theorem exists_prime_nagura {n : ℕ} (hn : 25 ≤ n) :
    HasNaguraPrime n := by
  by_cases hSmall : n < 91639
  · exact exists_prime_nagura_below_91639 hn hSmall
  by_cases hFinite : n < 16000000
  · exact exists_prime_nagura_91639_to_16000000 (by omega) hFinite
  · exact exists_prime_nagura_analytic_tail (by omega)


end Legendre.Nagura

end
