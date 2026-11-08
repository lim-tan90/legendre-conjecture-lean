/-
Adapted from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae.
Original source: lean/OAI/NumberTheory/Ostmann/ (Apache-2.0).
Changes: imports and namespaces adapted to this project; Lean/mathlib v4.35.0.
The original Apache-2.0 license is retained in licenses/openai-math-Apache-2.0.txt.
-/
module

public import Mathlib.Analysis.Matrix.Spectrum
public import Mathlib.Analysis.Complex.Basic

@[expose] public section

namespace Legendre

/-! # Finite Hermitian eigenvector cancellation -/

namespace LargeSieve

open Matrix
open scoped BigOperators

variable {ι : Type*} [Fintype ι]

theorem hermitian_eigenvector_left {A : Matrix ι ι ℂ} (hA : A.IsHermitian)
    (u : ι → ℂ) (μ : ℝ) (heig : A *ᵥ u = (μ : ℂ) • u) (v : ι → ℂ) :
    star u ⬝ᵥ (A *ᵥ v) = (μ : ℂ) * (star u ⬝ᵥ v) := by
  have h := hA.star_dotProduct_mulVec_comm u v
  rw [heig, dotProduct_smul] at h
  apply star_injective
  rw [h]
  simp [dotProduct, mul_comm]

theorem hermitian_eigenvector_commutator {A : Matrix ι ι ℂ} (hA : A.IsHermitian)
    (D : Matrix ι ι ℂ) (u : ι → ℂ) (μ : ℝ) (heig : A *ᵥ u = (μ : ℂ) • u) :
    star u ⬝ᵥ ((D * A - A * D) *ᵥ u) = 0 := by
  rw [sub_mulVec, dotProduct_sub, ← mulVec_mulVec, ← mulVec_mulVec,
    heig, mulVec_smul, dotProduct_smul, hermitian_eigenvector_left hA u μ heig]
  simp only [smul_eq_mul, sub_self]

end LargeSieve

end Legendre

