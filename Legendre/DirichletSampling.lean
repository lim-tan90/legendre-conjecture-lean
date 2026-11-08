/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.DirichletDerivative
public import Legendre.LargeSieve.SeparatedSampling

/-!
# Quantitative sampling of Dirichlet polynomials at separated times

A real Sobolev sampling bound and the proved mean square control the actual
sum of squared values at finitely many separated points. No count of point
samples is inferred from a continuous large-value measure bound.
-/

@[expose] public section

namespace Legendre.Density

open MeasureTheory Set

/-- Natural logarithms of natural numbers are nonnegative, including log 0=0. -/
theorem log_nat_nonneg (N : ℕ) : 0 ≤ Real.log (N : ℝ) := by
  by_cases hN : N = 0
  · simp [hN]
  · apply Real.log_nonneg
    exact_mod_cast Nat.one_le_iff_ne_zero.2 hN

/-- The finite mean-square coefficient is nonnegative on an ordered interval. -/
theorem dirichlet_mean_coefficient_nonneg (N : ℕ) {L U : ℝ} (hLU : L ≤ U) :
    0 ≤ U-L+4*(N : ℝ)*(1+Real.log N) := by
  have hlog := log_nat_nonneg N
  positivity

/-- Explicit energy bound for squared values at finitely many separated sampling times. -/
theorem sum_dirichletPolynomial_samples_le {ι : Type*} (s : Finset ι) (t : ι → ℝ)
    (N : ℕ) (a : ℕ → ℂ) {δ L U : ℝ} (hδ : 0 < δ) (hLU : L ≤ U)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|) :
    (∑ i ∈ s, ‖dirichletPolynomial N a (t i)‖^2) ≤
      (δ⁻¹+1+(Real.log N)^2)*(U-L+4*(N : ℝ)*(1+Real.log N))*
        coefficientEnergy (Finset.Icc 1 N) a := by
  let P := dirichletPolynomial N a
  let D := dirichletPolynomial N (dirichletDerivativeCoefficients a)
  let K := U-L+4*(N : ℝ)*(1+Real.log N)
  have hP : Continuous P := continuous_dirichletPolynomial _ _
  have hD : Continuous D := continuous_dirichletPolynomial _ _
  have hsample := LargeSieve.separated_sampling s t hδ hLU hinside hsep
    (hP.norm.pow 2) (continuous_const.mul (hP.inner hD))
    (fun u => dirichletPolynomial_norm_sq_hasDerivAt N a u) (fun u => sq_nonneg ‖P u‖)
  have hderiv := intervalIntegral.integral_mono_on hLU
    ((continuous_const.mul (hP.inner hD)).abs.intervalIntegrable (μ := volume) L U)
    (((hP.norm.pow 2).add (hD.norm.pow 2)).intervalIntegrable (μ := volume) L U)
    (fun u _hu => abs_norm_sq_derivative_le N a u)
  simp only [Pi.add_apply, Pi.mul_apply, Pi.pow_apply] at hderiv hsample
  have hiP0 : IntervalIntegrable (fun u : ℝ => ‖P u‖^2) volume L U :=
    (hP.norm.fun_pow 2).intervalIntegrable L U
  have hiD0 : IntervalIntegrable (fun u : ℝ => ‖D u‖^2) volume L U :=
    (hD.norm.fun_pow 2).intervalIntegrable L U
  rw [intervalIntegral.integral_add hiP0 hiD0] at hderiv
  have hiP := integral_dirichletPolynomial_norm_sq_le N a L U
  have hiD := integral_dirichletPolynomial_norm_sq_le N (dirichletDerivativeCoefficients a) L U
  have hE := derivative_coefficientEnergy_le N a
  have hK : 0 ≤ K := dirichlet_mean_coefficient_nonneg N hLU
  have hmul := mul_le_mul_of_nonneg_left hE hK
  change (∫ u : ℝ in L..U, ‖D u‖^2) ≤ K*coefficientEnergy _ _ at hiD
  change (∫ u : ℝ in L..U, ‖P u‖^2) ≤ K*coefficientEnergy _ _ at hiP
  have hupper : (∫ u : ℝ in L..U, ‖D u‖^2) ≤
      K*((Real.log N)^2*coefficientEnergy (Finset.Icc 1 N) a) := hiD.trans hmul
  have hδ0 : 0 ≤ δ⁻¹+1 := by positivity
  calc
    _ ≤ δ⁻¹*(∫ u : ℝ in L..U, ‖P u‖^2)+
        ((∫ u : ℝ in L..U, ‖P u‖^2)+(∫ u : ℝ in L..U, ‖D u‖^2)) := by
      exact hsample.trans (add_le_add (le_refl _) hderiv)
    _ = (δ⁻¹+1)*(∫ u : ℝ in L..U, ‖P u‖^2)+(∫ u : ℝ in L..U, ‖D u‖^2) := by ring
    _ ≤ (δ⁻¹+1)*(K*coefficientEnergy (Finset.Icc 1 N) a)+
        K*((Real.log N)^2*coefficientEnergy (Finset.Icc 1 N) a) :=
      add_le_add (mul_le_mul_of_nonneg_left hiP hδ0) hupper
    _ = _ := by dsimp [K]; ring

/-- Counting actual separated large values, rather than the measure of a set of times. -/
theorem dirichlet_large_sample_card_mul_le {ι : Type*} (s : Finset ι) (t : ι → ℝ)
    (N : ℕ) (a : ℕ → ℂ) {δ L U V : ℝ} (hδ : 0 < δ) (hLU : L ≤ U) (hV : 0 ≤ V)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|)
    (hlarge : ∀ i ∈ s, V ≤ ‖dirichletPolynomial N a (t i)‖) :
    (s.card : ℝ)*V^2 ≤
      (δ⁻¹+1+(Real.log N)^2)*(U-L+4*(N : ℝ)*(1+Real.log N))*
        coefficientEnergy (Finset.Icc 1 N) a := by
  have hsum : (s.card : ℝ)*V^2 ≤ ∑ i ∈ s, ‖dirichletPolynomial N a (t i)‖^2 := by
    have he : (s.card : ℝ)*V^2 = ∑ _i ∈ s, V^2 := by
      simp only [Finset.sum_const, nsmul_eq_mul]
    rw [he]
    apply Finset.sum_le_sum
    intro i hi
    exact pow_le_pow_left₀ hV (hlarge i hi) 2
  exact hsum.trans (sum_dirichletPolynomial_samples_le s t N a hδ hLU hinside hsep)

/-- The explicit V⁻² bound for the cardinality of separated large samples. -/
theorem dirichlet_large_sample_card_le {ι : Type*} (s : Finset ι) (t : ι → ℝ)
    (N : ℕ) (a : ℕ → ℂ) {δ L U V : ℝ} (hδ : 0 < δ) (hLU : L ≤ U) (hV : 0 < V)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|)
    (hlarge : ∀ i ∈ s, V ≤ ‖dirichletPolynomial N a (t i)‖) :
    (s.card : ℝ) ≤ ((δ⁻¹+1+(Real.log N)^2)*(U-L+4*(N : ℝ)*(1+Real.log N))*
        coefficientEnergy (Finset.Icc 1 N) a)/V^2 := by
  apply (le_div_iff₀ (sq_pos_of_pos hV)).2
  exact dirichlet_large_sample_card_mul_le s t N a hδ hLU hV.le hinside hsep hlarge

end Legendre.Density
