/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ComplexDirichlet

/-!
# Dirichlet-polynomial samples with varying real parts

Only ordinates are required to be separated. Real parts may vary independently
inside any interval of length at most one. This allows the mean-value estimates
to be used at actual zeros rather than assuming a common vertical line.
-/

@[expose] public section

namespace Legendre.Density

open Complex Set

/-- Sampling at arbitrary real parts in a unit-width strip. -/
theorem sum_complexDirichletPolynomial_samples_le {ι : Type*} (s : Finset ι)
    (t β : ι → ℝ) (N : ℕ) (a : ℕ → ℂ) (hN : 1 < N) {δ L U σ b : ℝ}
    (hδ : 0 < δ) (hLU : L ≤ U) (hσb : σ ≤ b) (hlen : b-σ ≤ 1)
    (hβ : ∀ i ∈ s, β i ∈ Icc σ b)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|) :
    (∑ i ∈ s, ‖complexDirichletPolynomial N a ((β i : ℂ)+(t i : ℂ)*I)‖^2) ≤
      (2+(Real.log N)^2)*(δ⁻¹+2*Real.log N)*(U-L+2*Real.pi*(N : ℝ))*
        coefficientEnergy (Finset.Icc 1 N) (verticalCoefficients a σ) := by
  let C := (δ⁻¹+2*Real.log N)*(U-L+2*Real.pi*(N : ℝ))
  let E := coefficientEnergy (Finset.Icc 1 N) (verticalCoefficients a σ)
  have hlog : 0 < Real.log N := Real.log_pos (by exact_mod_cast hN)
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hE : 0 ≤ E := coefficientEnergy_nonneg _ _
  have hfixed (c : ℕ → ℂ) (u : ℝ) (hu : σ ≤ u) :
      (∑ i ∈ s, ‖complexDirichletPolynomial N c ((u : ℂ)+(t i : ℂ)*I)‖^2) ≤
        C*coefficientEnergy (Finset.Icc 1 N) (verticalCoefficients c σ) := by
    simp_rw [complexDirichletPolynomial_vertical]
    exact (sum_dirichletPolynomial_samples_le_linear_log s t N (verticalCoefficients c u)
      hN hδ hLU hinside hsep).trans
      (mul_le_mul_of_nonneg_left (vertical_coefficientEnergy_mono N c hu) hC)
  have h0 : ∀ u ∈ Icc σ b,
      (∑ i ∈ s, ‖complexDirichletPolynomial N a ((u : ℂ)+(t i : ℂ)*I)‖^2) ≤ C*E :=
    fun u hu => hfixed a u hu.1
  have h1 : ∀ u ∈ Icc σ b,
      (∑ i ∈ s, ‖complexDirichletPolynomial N (logDerivativeCoefficients a)
        ((u : ℂ)+(t i : ℂ)*I)‖^2) ≤ C*((Real.log N)^2*E) := by
    intro u hu
    exact (hfixed (logDerivativeCoefficients a) u hu.1).trans
      (mul_le_mul_of_nonneg_left (logDerivative_vertical_energy_le N a σ) hC)
  have h := BetaVariation.sum_norm_sq_varying_parameter_le_of_uniform s
    (fun i u => complexDirichletPolynomial N a ((u : ℂ)+(t i : ℂ)*I))
    (fun i u => complexDirichletPolynomial N (logDerivativeCoefficients a) ((u : ℂ)+(t i : ℂ)*I))
    β hσb hlen (mul_nonneg hC hE) (by positivity : 0 ≤ C*((Real.log N)^2*E)) hβ
    (fun i _ => continuous_complexDirichletPolynomial_beta N a (t i))
    (fun i _ => continuous_complexDirichletPolynomial_beta N (logDerivativeCoefficients a) (t i))
    (fun i _ u => complexDirichletPolynomial_hasDerivAt_beta N a (t i) u) h0 h1
  convert! h using 1
  dsimp [C,E]
  ring

/-- Large values at genuinely varying real parts have an actual cardinality bound. -/
theorem complexDirichlet_large_sample_card_le {ι : Type*} (s : Finset ι)
    (t β : ι → ℝ) (N : ℕ) (a : ℕ → ℂ) (hN : 1 < N) {δ L U σ b V : ℝ}
    (hδ : 0 < δ) (hLU : L ≤ U) (hσb : σ ≤ b) (hlen : b-σ ≤ 1) (hV : 0 < V)
    (hβ : ∀ i ∈ s, β i ∈ Icc σ b)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|)
    (hlarge : ∀ i ∈ s, V ≤ ‖complexDirichletPolynomial N a ((β i : ℂ)+(t i : ℂ)*I)‖) :
    (s.card : ℝ) ≤ ((2+(Real.log N)^2)*(δ⁻¹+2*Real.log N)*(U-L+2*Real.pi*(N : ℝ))*
      coefficientEnergy (Finset.Icc 1 N) (verticalCoefficients a σ))/V^2 := by
  apply (le_div_iff₀ (sq_pos_of_pos hV)).2
  have he : (s.card : ℝ)*V^2 = ∑ _i ∈ s, V^2 := by simp
  rw [he]
  apply (Finset.sum_le_sum (fun i hi => pow_le_pow_left₀ hV.le (hlarge i hi) 2)).trans
  exact sum_complexDirichletPolynomial_samples_le s t β N a hN hδ hLU hσb hlen hβ hinside hsep

end Legendre.Density
