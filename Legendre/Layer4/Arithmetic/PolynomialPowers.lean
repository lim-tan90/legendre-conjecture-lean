/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local finite Dirichlet-polynomial powering and subpower coefficient bounds.
Only actual convolution coefficients and finite supports occur.
-/
module
public import Legendre.Layer4.Arithmetic.DivisorGrowth
public import Legendre.ZeroDetector.FiniteMollifier

@[expose] public section
namespace Legendre.Density.Moment.Powers
open Complex
open scoped BigOperators

theorem divisors_card_mono_of_dvd {d n : ℕ} (hn : n ≠ 0) (hd : d ∣ n) :
    (d.divisors.card : ℝ) ≤ n.divisors.card := by
  exact_mod_cast Finset.card_le_card (Nat.divisors_subset_of_dvd hn hd)

/-- Dirichlet convolution costs at most one additional divisor-count factor. -/
theorem convolution_divisor_norm (f g : ArithmeticFunction ℂ) (r s : ℕ)
    (hf : ∀ n, ‖f n‖ ≤ (n.divisors.card : ℝ)^r)
    (hg : ∀ n, ‖g n‖ ≤ (n.divisors.card : ℝ)^s) (n : ℕ) :
    ‖(f*g) n‖ ≤ (n.divisors.card : ℝ)^(r+s+1) := by
  by_cases hn : n = 0
  · simp [hn]
  rw [ArithmeticFunction.mul_apply]
  calc
    _ ≤ ∑ p ∈ n.divisorsAntidiagonal, ‖f p.1‖*‖g p.2‖ := by
      simpa only [norm_mul] using norm_sum_le n.divisorsAntidiagonal (fun p => f p.1*g p.2)
    _ ≤ ∑ _p ∈ n.divisorsAntidiagonal,
        (n.divisors.card : ℝ)^r*(n.divisors.card : ℝ)^s := by
      apply Finset.sum_le_sum
      intro p hp
      have hd1 := Nat.dvd_of_mem_divisors (Nat.fst_mem_divisors_of_mem_antidiagonal hp)
      have hd2 := Nat.dvd_of_mem_divisors (Nat.snd_mem_divisors_of_mem_antidiagonal hp)
      exact mul_le_mul ((hf p.1).trans (pow_le_pow_left₀ (Nat.cast_nonneg _) (divisors_card_mono_of_dvd hn hd1) r))
        ((hg p.2).trans (pow_le_pow_left₀ (Nat.cast_nonneg _) (divisors_card_mono_of_dvd hn hd2) s))
        (norm_nonneg _) (by positivity)
    _ = _ := by
      have hcard : (n.divisorsAntidiagonal.card : ℝ) = n.divisors.card := by
        rw [←Nat.map_div_right_divisors]
        simp
      rw [Finset.sum_const,nsmul_eq_mul,hcard]
      ring

theorem power_divisor_norm (f : ArithmeticFunction ℂ) (r k : ℕ)
    (hf : ∀ n, ‖f n‖ ≤ (n.divisors.card : ℝ)^r) :
    ∀ n, ‖(f^k) n‖ ≤ (n.divisors.card : ℝ)^((r+1)*k) := by
  induction k with
  | zero =>
    intro n
    simp only [pow_zero,ArithmeticFunction.one_apply]
    split_ifs <;> norm_num
  | succ k ih =>
    intro n
    have hh := convolution_divisor_norm (f^k) f ((r+1)*k) r ih hf n
    rw [show (r+1)*k+r+1 = (r+1)*(k+1) by ring] at hh
    rw [pow_succ]
    exact hh

/-- A fixed integer power retains coefficients of arbitrarily small polynomial growth. -/
theorem power_coefficients_subpower (f : ArithmeticFunction ℂ) (r k : ℕ)
    (hf : ∀ n, ‖f n‖ ≤ (n.divisors.card : ℝ)^r) (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ n : ℕ, 0 < n → ‖(f^k) n‖ ≤ C*(n : ℝ)^ε := by
  obtain ⟨C,hC,hb⟩ := DivisorGrowth.divisors_card_pow_le_rpow ((r+1)*k) ε hε
  exact ⟨C,hC,fun n hn => (power_divisor_norm f r k hf n).trans (hb n hn)⟩

theorem convolution_support (f g : ArithmeticFunction ℂ) (M N : ℕ)
    (hf : ∀ n, M < n → f n = 0) (hg : ∀ n, N < n → g n = 0) :
    ∀ n, M*N < n → (f*g) n = 0 := by
  intro n hn
  rw [ArithmeticFunction.mul_apply]
  apply Finset.sum_eq_zero
  intro p hp
  have hprod := (Nat.mem_divisorsAntidiagonal.mp hp).1
  by_cases hpm : p.1 ≤ M
  · have hpn : N < p.2 := by
      by_contra hh
      have hu := Nat.mul_le_mul hpm (le_of_not_gt hh)
      omega
    rw [hg p.2 hpn,mul_zero]
  · rw [hf p.1 (lt_of_not_ge hpm),zero_mul]

theorem power_support (f : ArithmeticFunction ℂ) (N k : ℕ)
    (hf : ∀ n, N < n → f n = 0) : ∀ n, N^k < n → (f^k) n = 0 := by
  induction k with
  | zero =>
    intro n hn
    simp only [pow_zero] at hn ⊢
    exact ArithmeticFunction.one_apply_ne (by omega)
  | succ k ih =>
    simpa only [pow_succ] using convolution_support (f^k) f (N^k) N ih hf

theorem finite_support_summable (f : ArithmeticFunction ℂ) (N : ℕ)
    (hf : ∀ n, N < n → f n = 0) (s : ℂ) : LSeriesSummable f s := by
  apply summable_of_ne_finset_zero (s := Finset.range (N+1))
  intro n hn
  have hnN : N < n := by
    have hh : N+1 ≤ n := by simpa only [Finset.mem_range,not_lt] using hn
    omega
  simp [LSeries.term,hf n hnN]

/-- Finite support makes convolution powering valid on every complex vertical line. -/
theorem LSeries_power (f : ArithmeticFunction ℂ) (N k : ℕ)
    (hf : ∀ n, N < n → f n = 0) (s : ℂ) :
    LSeries ((f^k : ArithmeticFunction ℂ) : ℕ → ℂ) s = (LSeries f s)^k := by
  induction k with
  | zero =>
    rw [pow_zero,pow_zero,Detector.LSeries_eq_finiteSeries_of_support (1 : ArithmeticFunction ℂ) 1 s
      (fun n hn => ArithmeticFunction.one_apply_ne (by omega))]
    simp [Detector.finiteSeries,ArithmeticFunction.one_apply]
  | succ k ih =>
    rw [pow_succ,ArithmeticFunction.LSeries_mul'
      (finite_support_summable (f^k) (N^k) (power_support f N k hf) s)
      (finite_support_summable f N hf s),ih,pow_succ]

theorem finiteSeries_power (f : ArithmeticFunction ℂ) (N k : ℕ)
    (hf : ∀ n, N < n → f n = 0) (s : ℂ) :
    Detector.finiteSeries (f^k) (N^k) s = (Detector.finiteSeries f N s)^k := by
  rw [←Detector.LSeries_eq_finiteSeries_of_support (f^k) (N^k) s (power_support f N k hf),
    LSeries_power f N k hf s,Detector.LSeries_eq_finiteSeries_of_support f N s hf]

end Legendre.Density.Moment.Powers
