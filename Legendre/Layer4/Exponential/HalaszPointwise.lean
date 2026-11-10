/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local finite Cauchy bound for the dense large-value regime.
-/
module
public import Legendre.Layer4.Exponential.HalaszComplex
public import Mathlib.Algebra.Order.Chebyshev

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

theorem norm_nat_imaginary_cpow (n : ℕ) (hn : 0 < n) (t : ℝ) :
    ‖(n : ℂ)^(-(t : ℂ)*I)‖ = 1 := by
  have he : realPhase (-Real.log (n : ℝ)) t = (n : ℂ)^(-(t : ℂ)*I) := by
    simpa only [Complex.ofReal_natCast] using realPhase_neg_log_eq_cpow
      (by exact_mod_cast hn : (0 : ℝ) < n) t
  rw [←he,norm_realPhase]

theorem block_vertical_energy_mono (U : ℕ) (a : ℕ → ℂ) {σ β : ℝ} (hσβ : σ ≤ β) :
    coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a β) ≤
      coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) := by
  rw [←Moment.polynomialBlock_energy U a β,←Moment.polynomialBlock_energy U a σ]
  exact vertical_coefficientEnergy_mono (2*U) (Moment.polynomialBlockCoefficient U a) hσβ

/-- Every actual large value is bounded by its block length times coefficient energy. -/
theorem complex_block_pointwise_sq (U : ℕ) (a : ℕ → ℂ) (σ β t : ℝ) (hσβ : σ ≤ β) :
    ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖^2 ≤
      (U : ℝ)*coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) := by
  rw [Moment.polynomialBlock_mask,block_complex_vertical]
  unfold blockDirichletPolynomial
  have he : (∑ n ∈ Finset.Ioc U (2*U), ‖verticalCoefficients a β n*(n : ℂ)^(-(t : ℂ)*I)‖^2) =
      coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a β) := by
    apply Finset.sum_congr rfl
    intro n hn
    rw [norm_mul,norm_nat_imaginary_cpow n (by have := (Finset.mem_Ioc.mp hn).1; omega) t,mul_one]
  calc
    _ ≤ (∑ n ∈ Finset.Ioc U (2*U), ‖verticalCoefficients a β n*(n : ℂ)^(-(t : ℂ)*I)‖)^2 :=
      pow_le_pow_left₀ (norm_nonneg _) (norm_sum_le _ _) 2
    _ ≤ ((Finset.Ioc U (2*U)).card : ℝ)*
        (∑ n ∈ Finset.Ioc U (2*U), ‖verticalCoefficients a β n*(n : ℂ)^(-(t : ℂ)*I)‖^2) :=
      sq_sum_le_card_mul_sum_sq
    _ = (U : ℝ)*coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a β) := by
      rw [he,Nat.card_Ioc,show 2*U-U = U by omega]
    _ ≤ _ := mul_le_mul_of_nonneg_left (block_vertical_energy_mono U a hσβ) (Nat.cast_nonneg U)

end Legendre.Density.Oscillation
