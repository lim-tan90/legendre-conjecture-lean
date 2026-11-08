/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.DirichletMeanValueSharp
public import Legendre.DirichletSampling

/-!
# Separated Dirichlet samples with a linear mean-square error

A free positive derivative weight allows the logarithmic sampling cost to be
optimized. Both the continuous estimate and its discrete application are proved.
-/

@[expose] public section

namespace Legendre.Density

open MeasureTheory Set

/-- Weighted Young majorant for the derivative of the squared modulus. -/
theorem abs_norm_sq_derivative_le_weighted (N : ℕ) (a : ℕ → ℂ) (t : ℝ)
    {w : ℝ} (hw : 0 < w) :
    |2*inner ℝ (dirichletPolynomial N a t)
      (dirichletPolynomial N (dirichletDerivativeCoefficients a) t)| ≤
      w*‖dirichletPolynomial N a t‖^2+
        w⁻¹*‖dirichletPolynomial N (dirichletDerivativeCoefficients a) t‖^2 := by
  let p := ‖dirichletPolynomial N a t‖
  let d := ‖dirichletPolynomial N (dirichletDerivativeCoefficients a) t‖
  rw [abs_mul,abs_of_pos (by norm_num : (0 : ℝ) < 2)]
  have hinner := abs_real_inner_le_norm (dirichletPolynomial N a t)
    (dirichletPolynomial N (dirichletDerivativeCoefficients a) t)
  calc
    _ ≤ 2*p*d := by
      simpa only [mul_assoc] using! mul_le_mul_of_nonneg_left hinner (by norm_num : (0 : ℝ) ≤ 2)
    _ ≤ w*p^2+w⁻¹*d^2 := by
      apply (mul_le_mul_iff_right₀ hw).1
      have hinv : w*w⁻¹ = 1 := mul_inv_cancel₀ hw.ne'
      nlinarith [sq_nonneg (w*p-d)]

/-- Sampling bound with an arbitrary positive derivative weight. -/
theorem sum_dirichletPolynomial_samples_le_linear_weighted {ι : Type*}
    (s : Finset ι) (t : ι → ℝ) (N : ℕ) (a : ℕ → ℂ) {δ L U w : ℝ}
    (hδ : 0 < δ) (hLU : L ≤ U) (hw : 0 < w)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|) :
    (∑ i ∈ s, ‖dirichletPolynomial N a (t i)‖^2) ≤
      (δ⁻¹+w+w⁻¹*(Real.log N)^2)*(U-L+2*Real.pi*(N : ℝ))*
        coefficientEnergy (Finset.Icc 1 N) a := by
  let P := dirichletPolynomial N a
  let D := dirichletPolynomial N (dirichletDerivativeCoefficients a)
  let K := U-L+2*Real.pi*(N : ℝ)
  have hP : Continuous P := continuous_dirichletPolynomial _ _
  have hD : Continuous D := continuous_dirichletPolynomial _ _
  have hsample := LargeSieve.separated_sampling s t hδ hLU hinside hsep
    (hP.norm.pow 2) (continuous_const.mul (hP.inner hD))
    (fun u => dirichletPolynomial_norm_sq_hasDerivAt N a u) (fun u => sq_nonneg ‖P u‖)
  have hderiv := intervalIntegral.integral_mono_on hLU
    ((continuous_const.mul (hP.inner hD)).abs.intervalIntegrable (μ := volume) L U)
    (((continuous_const.mul (hP.norm.pow 2)).add
      (continuous_const.mul (hD.norm.pow 2))).intervalIntegrable (μ := volume) L U)
    (fun u _hu => abs_norm_sq_derivative_le_weighted N a u hw)
  simp only [Pi.add_apply,Pi.mul_apply,Pi.pow_apply] at hderiv hsample
  have hiP0 : IntervalIntegrable (fun u : ℝ => ‖P u‖^2) volume L U :=
    (hP.norm.fun_pow 2).intervalIntegrable L U
  have hiD0 : IntervalIntegrable (fun u : ℝ => ‖D u‖^2) volume L U :=
    (hD.norm.fun_pow 2).intervalIntegrable L U
  rw [intervalIntegral.integral_add (hiP0.const_mul w) (hiD0.const_mul w⁻¹),
    intervalIntegral.integral_const_mul,intervalIntegral.integral_const_mul] at hderiv
  have hiP := integral_dirichletPolynomial_norm_sq_le_linear N a L U
  have hiD := integral_dirichletPolynomial_norm_sq_le_linear N (dirichletDerivativeCoefficients a) L U
  have hK : 0 ≤ K := by dsimp [K]; positivity
  have hupper := hiD.trans (mul_le_mul_of_nonneg_left (derivative_coefficientEnergy_le N a) hK)
  change (∫ u : ℝ in L..U, ‖D u‖^2) ≤ K*((Real.log N)^2*coefficientEnergy _ a) at hupper
  change (∫ u : ℝ in L..U, ‖P u‖^2) ≤ K*coefficientEnergy _ a at hiP
  calc
    _ ≤ δ⁻¹*(∫ u : ℝ in L..U, ‖P u‖^2)+
        (w*(∫ u : ℝ in L..U, ‖P u‖^2)+w⁻¹*(∫ u : ℝ in L..U, ‖D u‖^2)) :=
      hsample.trans (add_le_add (le_refl _) hderiv)
    _ = (δ⁻¹+w)*(∫ u : ℝ in L..U, ‖P u‖^2)+w⁻¹*(∫ u : ℝ in L..U, ‖D u‖^2) := by ring
    _ ≤ (δ⁻¹+w)*(K*coefficientEnergy (Finset.Icc 1 N) a)+
        w⁻¹*(K*((Real.log N)^2*coefficientEnergy (Finset.Icc 1 N) a)) :=
      add_le_add (mul_le_mul_of_nonneg_left hiP (by positivity))
        (mul_le_mul_of_nonneg_left hupper (inv_nonneg.2 hw.le))
    _ = _ := by dsimp [K]; ring

/-- For N>1 the derivative weight log N gives a single logarithmic sampling cost. -/
theorem sum_dirichletPolynomial_samples_le_linear_log {ι : Type*}
    (s : Finset ι) (t : ι → ℝ) (N : ℕ) (a : ℕ → ℂ) (hN : 1 < N) {δ L U : ℝ}
    (hδ : 0 < δ) (hLU : L ≤ U)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|) :
    (∑ i ∈ s, ‖dirichletPolynomial N a (t i)‖^2) ≤
      (δ⁻¹+2*Real.log N)*(U-L+2*Real.pi*(N : ℝ))*
        coefficientEnergy (Finset.Icc 1 N) a := by
  have hlog : 0 < Real.log N := Real.log_pos (by exact_mod_cast hN)
  have he : Real.log N+(Real.log N)⁻¹*(Real.log N)^2 = 2*Real.log N := by
    field_simp
    ring
  have h := sum_dirichletPolynomial_samples_le_linear_weighted s t N a hδ hLU hlog hinside hsep
  simpa only [add_assoc,he] using h

/-- Positive large values at separated times obey the optimized cardinality bound. -/
theorem dirichlet_large_sample_card_le_linear_log {ι : Type*}
    (s : Finset ι) (t : ι → ℝ) (N : ℕ) (a : ℕ → ℂ) (hN : 1 < N) {δ L U V : ℝ}
    (hδ : 0 < δ) (hLU : L ≤ U) (hV : 0 < V)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|)
    (hlarge : ∀ i ∈ s, V ≤ ‖dirichletPolynomial N a (t i)‖) :
    (s.card : ℝ) ≤ ((δ⁻¹+2*Real.log N)*(U-L+2*Real.pi*(N : ℝ))*
      coefficientEnergy (Finset.Icc 1 N) a)/V^2 := by
  apply (le_div_iff₀ (sq_pos_of_pos hV)).2
  have he : (s.card : ℝ)*V^2 = ∑ _i ∈ s, V^2 := by
    simp only [Finset.sum_const,nsmul_eq_mul]
  rw [he]
  apply (Finset.sum_le_sum (fun i hi => pow_le_pow_left₀ hV.le (hlarge i hi) 2)).trans
  exact sum_dirichletPolynomial_samples_le_linear_log s t N a hN hδ hLU hinside hsep

end Legendre.Density
