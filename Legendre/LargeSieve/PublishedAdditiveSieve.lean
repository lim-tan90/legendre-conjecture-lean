/-
Adapted from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae.
Original source: lean/OAI/NumberTheory/Ostmann/ (Apache-2.0).
Changes: imports and namespaces adapted to this project; Lean/mathlib v4.35.0.
The original Apache-2.0 license is retained in licenses/openai-math-Apache-2.0.txt.
-/
module

public import Mathlib.Analysis.Complex.Exponential
public import Mathlib.Data.Finset.Interval
public import Mathlib.Tactic

@[expose] public section

namespace Legendre

/-! # The classical additive large-sieve input

H. L. Montgomery and R. C. Vaughan, *The large sieve*, Mathematika 20 (1973),
119–134, Theorem 1. The separated-frequency inequality gives the constant
`M - 1 + Q^2` on reduced fractions of denominator at most `Q`; below it is
weakened to `M + Q^2`. This is exactly the finite-interval specialization (2.1)
stated in the assigned manuscript, and applies to arbitrary complex coefficients.
-/

namespace LargeSieve
open scoped Classical BigOperators

noncomputable def sieveAdditivePhase (q h : ℕ) (n : ℤ) : ℂ :=
  Complex.exp (2 * (Real.pi : ℂ) * Complex.I * ((n : ℂ) * h / q))

def reducedNumerators (q : ℕ) : Finset ℕ :=
  (Finset.range q).filter (fun h => h.Coprime q)

noncomputable def additiveSieveSum {M : ℕ} (c : Fin M → ℂ) (J : ℤ) (q h : ℕ) : ℂ :=
  ∑ n, c n * sieveAdditivePhase q h (J + (n.val : ℤ))

/-- The additive large sieve for separated frequencies and arbitrary complex
coefficients. -/
def PublishedAdditiveLargeSieve : Prop :=
  ∀ M Q : ℕ, 1 ≤ M → 1 ≤ Q → ∀ J : ℤ, ∀ c : Fin M → ℂ,
    (∑ q ∈ Finset.Icc 1 Q, ∑ h ∈ reducedNumerators q, ‖additiveSieveSum c J q h‖ ^ 2) ≤
      ((M : ℝ) + (Q : ℝ) ^ 2) * ∑ n, ‖c n‖ ^ 2

end LargeSieve

end Legendre

