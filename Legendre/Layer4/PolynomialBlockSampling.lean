/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions from the already credited variable-real-part sampling and
divisor block energy. Masking uses the individual block length, rather than
the complete detector length, preserving the useful powers of the cutoffs.
-/
module
public import Legendre.Layer4.DetectorPolynomial
public import Legendre.ComplexDirichletSampling
public import Legendre.ZeroDetector.CoefficientEnergy

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators Classical

noncomputable def polynomialBlockCoefficient (U : ℕ) (a : ℕ → ℂ) (n : ℕ) : ℂ :=
  if n ∈ Finset.Ioc U (2*U) then a n else 0

theorem block_subset_initial (U : ℕ) : Finset.Ioc U (2*U) ⊆ Finset.Icc 1 (2*U) := by
  intro n hn
  have hh := Finset.mem_Ioc.mp hn
  exact Finset.mem_Icc.mpr ⟨by omega,hh.2⟩

theorem polynomialBlock_mask (U : ℕ) (a : ℕ → ℂ) (s : ℂ) :
    (∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-s)) =
      complexDirichletPolynomial (2*U) (polynomialBlockCoefficient U a) s := by
  calc
    _ = ∑ n ∈ Finset.Ioc U (2*U), polynomialBlockCoefficient U a n*(n : ℂ)^(-s) := by
      apply Finset.sum_congr rfl
      intro n hn
      simp [polynomialBlockCoefficient,hn]
    _ = _ := Finset.sum_subset (block_subset_initial U) (fun n _ hn => by
      simp [polynomialBlockCoefficient,hn])

theorem polynomialBlock_energy (U : ℕ) (a : ℕ → ℂ) (σ : ℝ) :
    coefficientEnergy (Finset.Icc 1 (2*U))
      (verticalCoefficients (polynomialBlockCoefficient U a) σ) =
        coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) := by
  have he (n : ℕ) : verticalCoefficients (polynomialBlockCoefficient U a) σ n =
      if n ∈ Finset.Ioc U (2*U) then verticalCoefficients a σ n else 0 := by
    unfold verticalCoefficients polynomialBlockCoefficient
    split_ifs <;> simp
  have hf : verticalCoefficients (polynomialBlockCoefficient U a) σ =
      (fun n => if n ∈ Finset.Ioc U (2*U) then verticalCoefficients a σ n else 0) := funext he
  rw [hf]
  exact coefficientEnergy_mask _ _ _ (block_subset_initial U)

theorem polynomialBlock_divisor_energy (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ)
    (σ : ℝ) (hσ : 0 ≤ σ) (ha : ∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ n.divisors.card) :
    coefficientEnergy (Finset.Icc 1 (2*U))
      (verticalCoefficients (polynomialBlockCoefficient U a) σ) ≤
        2*(U : ℝ)*(1+Real.log (2*U))^3*(U : ℝ)^(-2*σ) := by
  rw [polynomialBlock_energy]
  have he : coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) =
      ∑ n ∈ Finset.Ioc U (2*U), ‖a n‖^2*(n : ℝ)^(-2*σ) := by
    apply Finset.sum_congr rfl
    intro n hn
    apply Detector.norm_verticalCoefficients_sq
    exact Nat.zero_lt_one.trans_le ((Finset.mem_Icc.mp (block_subset_initial U hn)).1)
  rw [he]
  simpa only [one_pow,one_mul] using Detector.dyadic_coefficient_energy_le a
    (C := 1) zero_le_one hσ hU (fun n hn => by simpa using ha n hn)

noncomputable def polynomialBlockSamplingCost (U : ℕ) (T : ℝ) : ℝ :=
  (2+(Real.log (2*U))^2)*(1+2*Real.log (2*U))*(2*T+1+4*Real.pi*(U : ℝ))

theorem polynomialBlockSamplingCost_nonneg (U : ℕ) (hU : 1 ≤ U) (T : ℝ) (hT : 1 ≤ T) :
    0 ≤ polynomialBlockSamplingCost U T := by
  have hl : 0 ≤ Real.log (2*U) := Real.log_nonneg (by exact_mod_cast (by omega : 1 ≤ 2*U))
  unfold polynomialBlockSamplingCost
  positivity

theorem polynomialBlock_samples {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (T σ : ℝ) (hT : 1 ≤ T)
    (hσ : 0 ≤ σ) (hσ1 : σ ≤ 1) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hβ : ∀ i ∈ S, β i ∈ Icc σ 1)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (ha : ∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ n.divisors.card) :
    (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
      polynomialBlockSamplingCost U T*
        (2*(U : ℝ)*(1+Real.log (2*U))^3*(U : ℝ)^(-2*σ)) := by
  simp_rw [polynomialBlock_mask]
  have h := sum_complexDirichletPolynomial_samples_le S t β (2*U) (polynomialBlockCoefficient U a)
    (by omega) (δ := 1) (L := -T) (U := T+1) (σ := σ) (b := 1)
    (by norm_num) (by linarith) hσ1 (by linarith) hβ
    (fun i hi => ⟨(abs_le.mp (ht i hi)).1,by linarith [(abs_le.mp (ht i hi)).2]⟩) hsep
  have hh : (∑ i ∈ S, ‖complexDirichletPolynomial (2*U) (polynomialBlockCoefficient U a)
      ((β i : ℂ)+(t i : ℂ)*I)‖^2) ≤
      polynomialBlockSamplingCost U T*coefficientEnergy (Finset.Icc 1 (2*U))
        (verticalCoefficients (polynomialBlockCoefficient U a) σ) := by
    convert! h using 1
    unfold polynomialBlockSamplingCost
    push_cast
    ring
  exact hh.trans (mul_le_mul_of_nonneg_left (polynomialBlock_divisor_energy U hU a σ hσ ha)
    (polynomialBlockSamplingCost_nonneg U hU T hT))

end Legendre.Density.Moment
