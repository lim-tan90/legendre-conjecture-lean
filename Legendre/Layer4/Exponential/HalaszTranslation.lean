/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions. Translation preserves the actual complex-block energy bound.
-/
module
public import Legendre.Layer4.Exponential.HalaszComplex

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def ordinateTwist (a : ℕ → ℂ) (c : ℝ) (n : ℕ) : ℂ :=
  a n*realPhase (-Real.log (n : ℝ)) c

theorem ordinateTwist_energy (S : Finset ℕ) (a : ℕ → ℂ) (c σ : ℝ) :
    coefficientEnergy S (verticalCoefficients (ordinateTwist a c) σ) =
      coefficientEnergy S (verticalCoefficients a σ) := by
  apply Finset.sum_congr rfl
  intro n hn
  simp only [verticalCoefficients,ordinateTwist,norm_mul,norm_realPhase,mul_one]

theorem complex_block_time_shift (U : ℕ) (a : ℕ → ℂ) (c β t : ℝ) :
    (∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))) =
      ∑ n ∈ Finset.Ioc U (2*U), ordinateTwist a c n*
        (n : ℂ)^(-((β : ℂ)+((t-c : ℝ) : ℂ)*I)) := by
  apply Finset.sum_congr rfl
  intro n hn
  have hnp : (0 : ℝ) < n := by
    exact_mod_cast (lt_of_le_of_lt (Nat.zero_le U) (Finset.mem_Ioc.mp hn).1)
  have hn0 : (n : ℂ) ≠ 0 := by exact_mod_cast hnp.ne'
  rw [ordinateTwist,realPhase_neg_log_eq_cpow hnp c,Complex.ofReal_natCast,mul_assoc,
    ←Complex.cpow_add _ _ hn0]
  congr 2
  push_cast
  ring

/-- Translation of the ordinate window preserves every coefficient energy. -/
theorem halasz_block_complex_centered {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (center H σ b : ℝ) (hH : 1 ≤ H)
    (hσb : σ ≤ b) (hlen : b-σ ≤ 1) (hβ : ∀ i ∈ S, β i ∈ Icc σ b)
    (ht : ∀ i ∈ S, |t i-center| ≤ H)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
      (2+(Real.log (2*U))^2)*halaszBlockCoefficient U H S.card*
        coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) := by
  have hh := halasz_block_complex_energy S (fun i => t i-center) β U hU
    (ordinateTwist a center) H σ b hH hσb hlen hβ ht
    (by intro i hi j hj hij
        convert hs i hi j hj hij using 1
        congr 1
        ring)
  simpa only [ordinateTwist_energy,←complex_block_time_shift] using hh

end Legendre.Density.Oscillation
