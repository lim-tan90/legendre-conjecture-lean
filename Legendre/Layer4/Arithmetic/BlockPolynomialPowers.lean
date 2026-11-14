/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local block-polynomial powering: exact finite series, retained support bounds,
and subpower coefficients uniform over a bounded set of integer powers.
-/
module
public import Legendre.Layer4.Arithmetic.PolynomialPowers

@[expose] public section
namespace Legendre.Density.Moment.Powers
open Complex
open scoped BigOperators

/-- The subpower coefficient cost is uniform in the polynomial and all powers k<=K. -/
theorem bounded_powers_coefficients_subpower (r K : ℕ) (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ f : ArithmeticFunction ℂ,
      (∀ n, ‖f n‖ ≤ (n.divisors.card : ℝ)^r) →
      ∀ k : ℕ, k ≤ K → ∀ n : ℕ, 0 < n → ‖(f^k) n‖ ≤ C*(n : ℝ)^ε := by
  obtain ⟨C,hC,hb⟩ := DivisorGrowth.divisors_card_pow_le_rpow ((r+1)*K) ε hε
  refine ⟨C,hC,?_⟩
  intro f hf k hk n hn
  have hd : (1 : ℝ) ≤ n.divisors.card := by
    exact_mod_cast Finset.card_pos.mpr ⟨1,Nat.one_mem_divisors.mpr hn.ne'⟩
  exact (power_divisor_norm f r k hf n).trans
    ((pow_le_pow_right₀ hd (Nat.mul_le_mul_left (r+1) hk)).trans (hb n hn))

noncomputable def blockArithmeticCoefficient (a : ℕ → ℂ) (U V : ℕ) : ArithmeticFunction ℂ :=
  ⟨fun n => if n ∈ Finset.Ioc U V then a n else 0,by simp⟩

@[simp] theorem blockArithmeticCoefficient_apply (a : ℕ → ℂ) (U V n : ℕ) :
    blockArithmeticCoefficient a U V n = if n ∈ Finset.Ioc U V then a n else 0 := rfl

theorem blockArithmeticCoefficient_norm (a : ℕ → ℂ) (U V r : ℕ)
    (ha : ∀ n ∈ Finset.Ioc U V, ‖a n‖ ≤ (n.divisors.card : ℝ)^r) :
    ∀ n, ‖blockArithmeticCoefficient a U V n‖ ≤ (n.divisors.card : ℝ)^r := by
  intro n
  by_cases hn : n ∈ Finset.Ioc U V
  · simpa only [blockArithmeticCoefficient_apply,if_pos hn] using ha n hn
  · simp only [blockArithmeticCoefficient_apply,if_neg hn,norm_zero]
    positivity

theorem blockArithmeticCoefficient_support (a : ℕ → ℂ) (U V : ℕ) :
    ∀ n, V < n → blockArithmeticCoefficient a U V n = 0 := by
  intro n hn
  simp [blockArithmeticCoefficient,Finset.mem_Ioc,show ¬n ≤ V by omega]

theorem blockArithmeticCoefficient_below (a : ℕ → ℂ) (U V : ℕ) :
    ∀ n, n ≤ U → blockArithmeticCoefficient a U V n = 0 := by
  intro n hn
  simp [blockArithmeticCoefficient,Finset.mem_Ioc,show ¬U < n by omega]

/-- Vanishing at the lower edge survives Dirichlet convolution. -/
theorem convolution_vanish_below (f g : ArithmeticFunction ℂ) (M N : ℕ)
    (hf : ∀ n, n ≤ M → f n = 0) (hg : ∀ n, n ≤ N → g n = 0) :
    ∀ n, n ≤ M*N → (f*g) n = 0 := by
  intro n hn
  rw [ArithmeticFunction.mul_apply]
  apply Finset.sum_eq_zero
  intro p hp
  have hprod := (Nat.mem_divisorsAntidiagonal.mp hp).1
  by_cases hpm : p.1 ≤ M
  · rw [hf p.1 hpm,zero_mul]
  · have hpn : p.2 ≤ N := by
      by_contra hh
      have hu := Nat.mul_le_mul (show M+1 ≤ p.1 by omega) (show N+1 ≤ p.2 by omega)
      have he : (M+1)*(N+1) = M*N+(M+N+1) := by ring
      rw [he] at hu
      omega
    rw [hg p.2 hpn,mul_zero]

theorem positive_power_vanish_below (f : ArithmeticFunction ℂ) (U : ℕ)
    (hf : ∀ n, n ≤ U → f n = 0) :
    ∀ k : ℕ, ∀ n, n ≤ U^(k+1) → (f^(k+1)) n = 0 := by
  intro k
  induction k with
  | zero => simpa only [zero_add,pow_one] using hf
  | succ k ih =>
    simpa only [pow_succ] using convolution_vanish_below (f^(k+1)) f (U^(k+1)) U ih hf

/-- The arithmetic mask is exactly the original complex block polynomial. -/
theorem block_finiteSeries (a : ℕ → ℂ) (U V : ℕ) (s : ℂ) :
    Detector.finiteSeries (blockArithmeticCoefficient a U V) V s =
      ∑ n ∈ Finset.Ioc U V, a n*(n : ℂ)^(-s) := by
  unfold Detector.finiteSeries
  symm
  calc
    _ = ∑ n ∈ Finset.Ioc U V, blockArithmeticCoefficient a U V n*(n : ℂ)^(-s) := by
      apply Finset.sum_congr rfl
      intro n hn
      simp only [blockArithmeticCoefficient_apply,if_pos hn]
    _ = _ := Finset.sum_subset (by
      intro n hn
      have hh := Finset.mem_Ioc.mp hn
      exact Finset.mem_Icc.mpr ⟨by omega,hh.2⟩) (by
        intro n hn hn'
        rw [blockArithmeticCoefficient_apply,if_neg hn',zero_mul])

/-- Integer powering produces the actual finite convolution polynomial at every s. -/
theorem block_polynomial_power (a : ℕ → ℂ) (U V k : ℕ) (s : ℂ) :
    (∑ n ∈ Finset.Ioc U V, a n*(n : ℂ)^(-s))^k =
      Detector.finiteSeries ((blockArithmeticCoefficient a U V)^k) (V^k) s := by
  rw [finiteSeries_power _ V k (blockArithmeticCoefficient_support a U V) s,
    block_finiteSeries]

end Legendre.Density.Moment.Powers
