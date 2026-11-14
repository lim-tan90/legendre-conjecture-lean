/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local exact dyadic decomposition of a powered short Dirichlet block.
The power is Dirichlet convolution, not pointwise coefficient powering.
-/
module
public import Legendre.Layer4.Arithmetic.BlockPolynomialPowers
public import Legendre.Layer4.HalaszPolynomialAlternative

@[expose] public section
namespace Legendre.Density.Moment.Powers
open Complex
open scoped BigOperators

/-- A positive integer power of a block needs precisely k dyadic output blocks. -/
theorem powered_block_dyadic_decomposition (a : ℕ → ℂ) (U k : ℕ) (hU : 1 ≤ U)
    (hk : 1 ≤ k) (s : ℂ) :
    (∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-s))^k =
      ∑ j ∈ Finset.range k, ∑ n ∈ Finset.Ioc (2^j*U^k) (2*(2^j*U^k)),
        ((blockArithmeticCoefficient a U (2*U))^k) n*(n : ℂ)^(-s) := by
  rw [block_polynomial_power]
  unfold Detector.finiteSeries
  rw [mul_pow,moment_dyadic_partition (U^k) k (one_le_pow₀ hU)]
  have hhead : (∑ n ∈ Finset.Icc 1 (U^k),
      ((blockArithmeticCoefficient a U (2*U))^k) n*(n : ℂ)^(-s)) = 0 := by
    apply Finset.sum_eq_zero
    intro n hn
    obtain ⟨l,hl⟩ := Nat.exists_eq_succ_of_ne_zero (show k ≠ 0 by omega)
    rw [hl,positive_power_vanish_below _ U (blockArithmeticCoefficient_below a U (2*U)) l n
      (by simpa only [hl] using (Finset.mem_Icc.mp hn).2),zero_mul]
  rw [hhead,zero_add]
  apply Finset.sum_congr rfl
  intro j _
  congr 2
  rw [pow_succ]
  ring

/-- An actual large short block yields a large dyadic piece of its convolution power. -/
theorem exists_large_powered_block (a : ℕ → ℂ) (U k : ℕ) (hU : 1 ≤ U)
    (hk : 1 ≤ k) (s : ℂ) (W : ℝ) (hW : 0 ≤ W)
    (hw : W ≤ ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-s)‖) :
    ∃ j ∈ Finset.range k, W^k/(k : ℝ) ≤
      ‖∑ n ∈ Finset.Ioc (2^j*U^k) (2*(2^j*U^k)),
        ((blockArithmeticCoefficient a U (2*U))^k) n*(n : ℂ)^(-s)‖ := by
  have hp := pow_le_pow_left₀ hW hw k
  rw [←norm_pow,powered_block_dyadic_decomposition a U k hU hk s] at hp
  exact exists_large_dyadic_piece k hk _ (W^k) hp

end Legendre.Density.Moment.Powers
