/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.DirichletMeanValueWeighted
public import Legendre.Layer4.MollifiedZetaMeanSquare

@[expose] public section
namespace Legendre.Density.Detector
open Complex MeasureTheory Set

/-- The coefficient at index n pays the window size plus n. -/
noncomputable def mollifiedWeightedEnergyBound (C : ℝ) (X N : ℕ) (α β A B : ℝ) : ℝ :=
  2*C*(∑ n ∈ Finset.Icc 1 (X*N), (max 1 ((B-A)/2)+(n : ℝ))*
      ‖verticalCoefficients (detectorTailCoefficients X N) α n‖^2) +
    2*(B-A)*(mollifiedEulerErrorBound X N α β A B)^2

/-- Uniform vertical moment bound using the local index in the coefficient
energy. It applies on every positive-height rectangle. -/
theorem integral_mollifiedError_norm_sq_le_weighted_energy :
    ∃ C : ℝ, 0 < C ∧ ∀ X N : ℕ, 1 ≤ X → X ≤ N →
      ∀ α β A B : ℝ, 0 < α → 0 < A → A ≤ B → ∀ a ∈ Icc α β,
      (∫ t in Icc A B, ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
        mollifiedWeightedEnergyBound C X N α β A B := by
  obtain ⟨C,hC,hCbound⟩ := Moment.integral_subsetPolynomial_norm_sq_weighted
  refine ⟨C,hC,?_⟩
  intro X N hX hXN α β A B hα hA hAB a ha
  let S := Finset.Icc 1 (X*N)
  let c := detectorTailCoefficients X N
  let P := fun z => Moment.subsetPolynomial S (verticalCoefficients c z)
  let T := max 1 ((B-A)/2)
  let u := (A+B)/2
  have hT : 1 ≤ T := le_max_left _ _
  have hI : Icc A B ⊆ Icc (u-T) (u+T) := by
    apply Icc_subset_Icc
    · have h := le_max_right (1 : ℝ) ((B-A)/2)
      change (A+B)/2-T ≤ A
      linarith
    · have h := le_max_right (1 : ℝ) ((B-A)/2)
      change B ≤ (A+B)/2+T
      linarith
  have hp (t : ℝ) : detectorPolynomial X N ((a : ℂ)+(t : ℂ)*I) = P a t := by
    rw [detectorPolynomial_eq_complexDirichlet, complexDirichletPolynomial_vertical]
    rfl
  have hi : IntegrableOn (fun t => ‖P a t‖^2) (Icc (u-T) (u+T)) :=
    ((Moment.subsetPolynomial_continuous S _).norm.pow 2).continuousOn.integrableOn_Icc
  have hP : (∫ t in Icc A B, ‖P a t‖^2) ≤
      C*∑ n ∈ S, (T+(n : ℝ))*‖verticalCoefficients c α n‖^2 := by
    calc
      _ ≤ ∫ t in Icc (u-T) (u+T), ‖P a t‖^2 :=
        setIntegral_mono_set hi (Filter.Eventually.of_forall fun _ => sq_nonneg _) hI.eventuallySubset
      _ ≤ C*∑ n ∈ S, (T+(n : ℝ))*‖verticalCoefficients c a n‖^2 :=
        hCbound T u hT S _ (fun n hn => (Finset.mem_Icc.mp hn).1)
      _ ≤ _ := by
        apply mul_le_mul_of_nonneg_left _ hC.le
        apply Finset.sum_le_sum
        intro n hn
        have hn₁ : 1 ≤ n := (Finset.mem_Icc.mp hn).1
        have hn₀ : 0 < n := zero_lt_one.trans_le hn₁
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        rw [norm_verticalCoefficients _ _ hn₀, norm_verticalCoefficients _ _ hn₀]
        apply pow_le_pow_left₀ (by positivity)
        apply mul_le_mul_of_nonneg_left _ (norm_nonneg _)
        exact Real.rpow_le_rpow_of_exponent_le (by exact_mod_cast hn₁) (neg_le_neg ha.1)
  have hv := integral_mollifiedError_norm_sq_le_detector_and_remainder hX hXN hα hA hAB ha
  simp_rw [hp] at hv
  change _ ≤ 2*C*(∑ n ∈ S, (T+(n : ℝ))*‖verticalCoefficients c α n‖^2) +
    2*(B-A)*(mollifiedEulerErrorBound X N α β A B)^2
  linarith only [hv, hP]

end Legendre.Density.Detector

namespace Legendre.Zeta
open Density.Detector

/-- The actual density increment from a weighted arithmetic sum, with the
center integral controlled by the smaller of two proved bounds. -/
theorem zeroDensityCount_le_mollified_weighted_energy :
    ∃ C : ℝ, 0 < C ∧ ∀ X N : ℕ, 1 ≤ X → X ≤ N →
      ∀ δ η U V : ℝ, 0 < δ → 0 < η → δ+2*η < 1 → δ+5*η < U → U ≤ V →
        2*(2+η⁻¹)^2 ≤ (X : ℝ)^η →
      let M := mollifiedWeightedEnergyBound C X N (1-δ-2*η) (1+δ+6*η) (U-(δ+5*η)) (V+(δ+5*η))
      let K := (V-U+2*η)*((X : ℝ)^(-η)*(2+η⁻¹)^2)^2
      (zeroDensityCount (1-δ) V : ℝ) ≤ (zeroDensityCount (1-δ) U : ℝ) +
        (M + (4/3 : ℝ)*min M K)/(2*η*Real.log ((δ+4*η)/(δ+3*η))) := by
  obtain ⟨C,hC,hbound⟩ := integral_mollifiedError_norm_sq_le_weighted_energy
  refine ⟨C,hC,?_⟩
  intro X N hX hXN δ η U V hδ hη hstrip hU hUV hscale
  dsimp only
  apply zeroDensityCount_le_mollified_vertical_min_center_offset X hX hδ hη hU hUV hscale
  exact hbound X N hX hXN _ _ _ _ (by linarith) (by linarith) (by linarith)

end Legendre.Zeta
