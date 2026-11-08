/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The large-sieve proof dependencies are adapted from openai/math; see
Legendre/LargeSieve/ and licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.LargeSieve.AdditiveSieveProof
public import Legendre.ExponentialKernel

/-!
# Public additive large-sieve interfaces

Circle-separated real frequencies give the finite energy inequality with
coefficient M+δ⁻¹. Reduced fractions give M+Q². The empty-length and
empty-denominator cases are included without artificial positivity assumptions.
-/

@[expose] public section

namespace Legendre.LargeSieve

/-- The additive large sieve, including zero length and an empty denominator range. -/
theorem additive_large_sieve (M Q : ℕ) (J : ℤ) (c : Fin M → ℂ) :
    (∑ q ∈ Finset.Icc 1 Q, ∑ h ∈ reducedNumerators q, ‖additiveSieveSum c J q h‖^2) ≤
      ((M : ℝ)+(Q : ℝ)^2)*(∑ n, ‖c n‖^2) := by
  by_cases hM : M = 0
  · subst M
    simp [additiveSieveSum]
  by_cases hQ : Q = 0
  · subst Q
    simp only [Finset.Icc_eq_empty_of_lt (by norm_num : (0 : ℕ) < 1),
      Finset.sum_empty, Nat.cast_zero, zero_pow (by norm_num : (2 : ℕ) ≠ 0), add_zero]
    positivity
  exact publishedAdditiveLargeSieve M Q (Nat.one_le_iff_ne_zero.2 hM)
    (Nat.one_le_iff_ne_zero.2 hQ) J c

/-- The project's unit-phase convention agrees with the source half-phase convention. -/
theorem realPhase_eq_sieveHalfPhase (x t : ℝ) :
    Density.realPhase (2*Real.pi*x) t = sieveHalfPhase (2*t*x) := by
  unfold Density.realPhase sieveHalfPhase
  congr 1
  push_cast
  ring

/-- Finite additive large sieve stated with the same phase as the Dirichlet-polynomial library. -/
theorem separated_realPhase_large_sieve {ι : Type*} [Fintype ι] [DecidableEq ι]
    (x : ι → ℝ) {δ : ℝ} (hδ : 0 < δ) (hx : CircleSeparated x δ)
    (M : ℕ) (J : ℝ) (c : Fin M → ℂ) :
    (∑ s, ‖∑ n, c n*Density.realPhase (2*Real.pi*x s) (J+(n.val : ℝ))‖^2) ≤
      ((M : ℝ)+δ⁻¹)*(∑ n, ‖c n‖^2) := by
  simpa only [realPhase_eq_sieveHalfPhase, one_div] using
    separated_additive_sieve x δ hδ hx M J c

end Legendre.LargeSieve
