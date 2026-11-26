/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.DetectorPolynomial
public import Legendre.Layer4.MollifiedZetaJensen
public import Legendre.Layer4.DirichletMeanValueWeighted

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory Set
open scoped ArithmeticFunction.Moebius

/-- The genuine mollified error is represented by the smoothed tail,
the shifted integral, and the two explicit corrections. -/
theorem mollifiedError_eq_smoothed_terms (X : ℕ) (hX : 1 ≤ X) {s : ℂ} (hs : s ≠ 1)
    (hσ : 1/2 < s.re) (hσ₁ : s.re ≤ 1) {Y : ℝ} (hY : 1 ≤ Y) :
    mollifiedError X s =
      2*(detectorTail X s Y-detectorCriticalIntegral X s Y-detectorPrincipalPole X s Y+
        (detectorWeight (1/Y)-1/2)) := by
  have hsplit := detectorMean_split X hX s Y (by linarith)
  change detectorMean X s Y = detectorWeight (1/Y)+detectorTail X s Y at hsplit
  have h := detectorMean_eq_both_residues X hs hσ hσ₁ hY
  change detectorMean X s Y =
    (detectorPrincipalPole X s Y+riemannZeta s*finiteSeries (μ : ArithmeticFunction ℂ) X s/2)+
      detectorCriticalIntegral X s Y at h
  unfold mollifiedError
  linear_combination 2*(hsplit-h)

/-- The smoothed tail has a weighted mean bound with support only through
the smoothing scale. The coefficient before index (X+1) vanishes. -/
theorem integral_detectorTail_norm_sq_le_weighted :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, ∀ Y : ℝ, 0 < Y → ∀ a T u : ℝ, 1 ≤ T →
      (∫ t in Icc (u-T) (u+T), ‖detectorTail X ((a : ℂ)+(t : ℂ)*I) Y‖^2) ≤
        C*∑ n ∈ Finset.Ioc X ⌊Y⌋₊, (T+(n : ℝ))*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a) := by
  obtain ⟨C,hC,hb⟩ := Moment.integral_subsetPolynomial_norm_sq_weighted
  refine ⟨C,hC,?_⟩
  intro X Y hY a T u hT
  let N := ⌊Y⌋₊
  let f := polynomialCoefficient X Y
  have hp (t : ℝ) : detectorTail X ((a : ℂ)+(t : ℂ)*I) Y =
      Moment.subsetPolynomial (Finset.Icc 1 N) (verticalCoefficients f a) t := by
    rw [detectorTail_polynomial, complexDirichletPolynomial_vertical]
    rfl
  simp_rw [hp]
  apply (hb T u hT _ _ (fun n hn => (Finset.mem_Icc.mp hn).1)).trans
  apply mul_le_mul_of_nonneg_left _ hC.le
  have hn (n : ℕ) (hnN : n ∈ Finset.Icc 1 N) :
      (T+(n : ℝ))*‖verticalCoefficients f a n‖^2 ≤
        if X < n then (T+(n : ℝ))*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a) else 0 := by
    have hn₀ : 0 < n := (Finset.mem_Icc.mp hnN).1
    by_cases hnX : X < n
    · rw [ite_eq_left hnX, norm_verticalCoefficients _ _ hn₀, mul_pow,
        ← Real.rpow_mul_natCast (Nat.cast_nonneg n), Nat.cast_ofNat,
        show (-a)*2 = -2*a by ring, mul_assoc]
      have h := pow_le_pow_left₀ (norm_nonneg _) (polynomialCoefficient_norm X Y hY n) 2
      exact mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_right h (by positivity)) (by positivity)
    · rw [ite_eq_right hnX, verticalCoefficients,
        show f n = 0 from polynomialCoefficient_below X n Y (le_of_not_gt hnX)]
      simp
  apply (Finset.sum_le_sum hn).trans
  rw [← Finset.sum_filter]
  apply le_of_eq
  congr 1
  ext n
  simp only [Finset.mem_filter, Finset.mem_Icc, Finset.mem_Ioc]
  omega

end Legendre.Density.Detector.Smooth
