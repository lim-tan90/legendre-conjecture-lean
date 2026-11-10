/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions: the proved analytic Halasz energy permits independently
varying real parts, via the existing parameter-variation theorem.
-/
module
public import Legendre.Layer4.Exponential.HalaszEnergy
public import Legendre.Layer4.PolynomialBlockSampling

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

theorem block_complex_vertical (U : ℕ) (a : ℕ → ℂ) (u t : ℝ) :
    complexDirichletPolynomial (2*U) (Moment.polynomialBlockCoefficient U a)
      ((u : ℂ)+(t : ℂ)*I) = blockDirichletPolynomial U (2*U) (verticalCoefficients a u) t := by
  rw [←Moment.polynomialBlock_mask]
  unfold blockDirichletPolynomial
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : (n : ℂ) ≠ 0 := by
    exact_mod_cast (ne_of_gt (lt_of_le_of_lt (Nat.zero_le U) (Finset.mem_Ioc.mp hn).1))
  rw [show -((u : ℂ)+(t : ℂ)*I) = -(u : ℂ)+(-(t : ℂ)*I) by ring,
    Complex.cpow_add _ _ hn0]
  unfold verticalCoefficients
  ring

/-- Fixed real parts retain the actual cardinality-dependent Halasz coefficient. -/
theorem halasz_masked_fixed {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (c : ℕ → ℂ) (T σ u : ℝ) (hT : 1 ≤ T) (hu : σ ≤ u)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (∑ i ∈ S, ‖complexDirichletPolynomial (2*U) (Moment.polynomialBlockCoefficient U c)
      ((u : ℂ)+(t i : ℂ)*I)‖^2) ≤
      halaszBlockCoefficient U T S.card*
        coefficientEnergy (Finset.Icc 1 (2*U))
          (verticalCoefficients (Moment.polynomialBlockCoefficient U c) σ) := by
  classical
  have hh := halasz_block_energy (ι := S) (fun i => t i.val) U (2*U) hU (by omega) le_rfl
    (verticalCoefficients c u) T hT (fun i => ht i i.property)
    (fun i j hij => hs i i.property j j.property (fun he => hij (Subtype.ext he)))
  have hr : (∑ i ∈ S, ‖complexDirichletPolynomial (2*U) (Moment.polynomialBlockCoefficient U c)
      ((u : ℂ)+(t i : ℂ)*I)‖^2) ≤
      halaszBlockCoefficient U T S.card*
        coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients c u) := by
    have he : (∑ i : S, ‖blockDirichletPolynomial U (2*U) (verticalCoefficients c u) (t i.val)‖^2) =
        ∑ i ∈ S, ‖blockDirichletPolynomial U (2*U) (verticalCoefficients c u) (t i)‖^2 :=
      by simpa only using! (Finset.sum_coe_sort S
        (fun i : ι => ‖blockDirichletPolynomial U (2*U) (verticalCoefficients c u) (t i)‖^2))
    rw [he,Fintype.card_coe] at hh
    simpa only [block_complex_vertical] using hh
  rw [←Moment.polynomialBlock_energy U c u] at hr
  exact hr.trans (mul_le_mul_of_nonneg_left
    (vertical_coefficientEnergy_mono (2*U) (Moment.polynomialBlockCoefficient U c) hu)
    (halaszBlockCoefficient_nonneg U T _ hT (by positivity)))

theorem logDerivative_mask (U : ℕ) (a : ℕ → ℂ) :
    logDerivativeCoefficients (Moment.polynomialBlockCoefficient U a) =
      Moment.polynomialBlockCoefficient U (logDerivativeCoefficients a) := by
  funext n
  unfold logDerivativeCoefficients Moment.polynomialBlockCoefficient
  split_ifs <;> simp

/-- Actual Halasz energy at samples with independently varying real parts. -/
theorem halasz_block_complex_energy {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (T σ b : ℝ) (hT : 1 ≤ T)
    (hσb : σ ≤ b) (hlen : b-σ ≤ 1) (hβ : ∀ i ∈ S, β i ∈ Icc σ b)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
      (2+(Real.log (2*U))^2)*halaszBlockCoefficient U T S.card*
        coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) := by
  let C := halaszBlockCoefficient U T S.card
  let A := Moment.polynomialBlockCoefficient U a
  let E := coefficientEnergy (Finset.Icc 1 (2*U)) (verticalCoefficients A σ)
  have hC : 0 ≤ C := halaszBlockCoefficient_nonneg U T _ hT (by positivity)
  have hE : 0 ≤ E := coefficientEnergy_nonneg _ _
  have hfixed (c : ℕ → ℂ) (u : ℝ) (hu : σ ≤ u) :=
    halasz_masked_fixed S t U hU c T σ u hT hu ht hs
  have h0 : ∀ u ∈ Icc σ b, (∑ i ∈ S,
      ‖complexDirichletPolynomial (2*U) A ((u : ℂ)+(t i : ℂ)*I)‖^2) ≤ C*E := by
    intro u hu
    exact hfixed a u hu.1
  have h1 : ∀ u ∈ Icc σ b, (∑ i ∈ S,
      ‖complexDirichletPolynomial (2*U) (logDerivativeCoefficients A)
        ((u : ℂ)+(t i : ℂ)*I)‖^2) ≤ C*((Real.log (2*U))^2*E) := by
    intro u hu
    have hh := hfixed (logDerivativeCoefficients a) u hu.1
    rw [←logDerivative_mask] at hh
    have hlog : coefficientEnergy (Finset.Icc 1 (2*U))
        (verticalCoefficients (logDerivativeCoefficients A) σ) ≤ (Real.log (2*U))^2*E := by
      simpa only [Nat.cast_mul,Nat.cast_ofNat,E] using! logDerivative_vertical_energy_le (2*U) A σ
    exact hh.trans (mul_le_mul_of_nonneg_left hlog hC)
  have hh := BetaVariation.sum_norm_sq_varying_parameter_le_of_uniform S
    (fun i u => complexDirichletPolynomial (2*U) A ((u : ℂ)+(t i : ℂ)*I))
    (fun i u => complexDirichletPolynomial (2*U) (logDerivativeCoefficients A)
      ((u : ℂ)+(t i : ℂ)*I)) β hσb hlen (mul_nonneg hC hE)
    (by positivity : 0 ≤ C*((Real.log (2*U))^2*E)) hβ
    (fun i _ => continuous_complexDirichletPolynomial_beta (2*U) A (t i))
    (fun i _ => continuous_complexDirichletPolynomial_beta (2*U) (logDerivativeCoefficients A) (t i))
    (fun i _ u => complexDirichletPolynomial_hasDerivAt_beta (2*U) A (t i) u) h0 h1
  simp_rw [Moment.polynomialBlock_mask]
  apply hh.trans_eq
  dsimp [C,E,A]
  rw [Moment.polynomialBlock_energy]
  ring

end Legendre.Density.Oscillation
