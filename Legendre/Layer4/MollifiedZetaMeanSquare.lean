/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.MollifiedZetaVertical
public import Legendre.ZeroDetector.DetectorSamples

@[expose] public section
namespace Legendre.Density.Detector
open Complex Set MeasureTheory
open scoped ArithmeticFunction.Moebius ArithmeticFunction.zeta

private theorem norm_finiteSeries_moebius_le_rpow_sum (X : ℕ) {α : ℝ} {s : ℂ}
    (hα : α ≤ s.re) :
    ‖finiteSeries (μ : ArithmeticFunction ℂ) X s‖ ≤
      ∑ n ∈ Finset.Icc 1 X, (n : ℝ)^(-α) := by
  unfold finiteSeries
  refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun n hn => ?_)
  have hn₁ := (Finset.mem_Icc.mp hn).1
  rw [norm_mul, norm_natCast_cpow_of_pos (zero_lt_one.trans_le hn₁), neg_re]
  have hμ : ‖(μ : ArithmeticFunction ℂ) n‖ ≤ 1 := by
    simpa only [ArithmeticFunction.intCoe_apply] using norm_moebius_le_one n
  calc
    _ ≤ 1*(n : ℝ)^(-α) :=
      mul_le_mul hμ (Real.rpow_le_rpow_of_exponent_le (by exact_mod_cast hn₁) (neg_le_neg hα))
        (by positivity) zero_le_one
    _ = _ := one_mul _

/-- Rectangular bound for the absolute mollified ζ truncation error. -/
noncomputable def mollifiedEulerErrorBound (X N : ℕ) (α β A B : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 X, (n : ℝ)^(-α)) *
    ((1/2+(β+B)/(2*α))*(N : ℝ)^(-α)+(N : ℝ)^(1-α)/A)

/-- On a positive-height rectangle, Euler summation controls the difference
between the genuine mollified error and the finite Möbius-cancelled polynomial. -/
theorem norm_mollifiedError_sub_detectorPolynomial_le {X N : ℕ}
    (hX : 1 ≤ X) (hXN : X ≤ N) {α β A B : ℝ} (hα : 0 < α) (hA : 0 < A)
    {s : ℂ} (hr : s.re ∈ Icc α β) (hi : s.im ∈ Icc A B) :
    ‖mollifiedError X s - detectorPolynomial X N s‖ ≤ mollifiedEulerErrorBound X N α β A B := by
  have hN := hX.trans hXN
  have hN₁ : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hr₀ := hα.trans_le hr.1
  have hi₀ := hA.trans_le hi.1
  have hs : s ≠ 1 := by
    intro he
    simp [he] at hi₀
  let M := finiteSeries (μ : ArithmeticFunction ℂ) X s
  let Z := finiteSeries (ζ : ArithmeticFunction ℂ) N s
  let P := (N : ℂ)^(1-s)/(s-1)
  have he : mollifiedError X s - detectorPolynomial X N s =
      M*(riemannZeta s-Z) := by
    unfold mollifiedError
    have h := finite_mollifier_identity hX hXN s
    change M*Z = 1+detectorPolynomial X N s at h
    change riemannZeta s*M-1-detectorPolynomial X N s = _
    linear_combination h
  have htail : ‖riemannZeta s-Z-P‖ ≤
      (1/2+‖s‖/(2*s.re))*(N : ℝ)^(-s.re) := by
    simpa only [Z, P, finiteSeries_zeta_eq] using Zeta.norm_riemannZeta_sub_finite_euler_le hN hr₀ hs
  have hnorm : ‖s‖ ≤ β+B := by
    have h := Complex.norm_le_abs_re_add_abs_im s
    rw [abs_of_pos hr₀, abs_of_pos hi₀] at h
    exact h.trans (add_le_add hr.2 hi.2)
  have htail' : ‖riemannZeta s-Z-P‖ ≤ (1/2+(β+B)/(2*α))*(N : ℝ)^(-α) := by
    apply htail.trans
    apply mul_le_mul _ (Real.rpow_le_rpow_of_exponent_le hN₁ (neg_le_neg hr.1)) (by positivity)
      (by have := (norm_nonneg s).trans hnorm; positivity)
    apply add_le_add_right _ _
    exact div_le_div₀ ((norm_nonneg s).trans hnorm) hnorm (by positivity) (by linarith [hr.1])
  have hpole : ‖P‖ ≤ (N : ℝ)^(1-α)/A := by
    have him : A ≤ ‖s-1‖ := by
      have h := Complex.abs_im_le_norm (s-1)
      simp [sub_im, abs_of_pos hi₀] at h
      exact hi.1.trans h
    dsimp [P]
    rw [norm_div, norm_natCast_cpow_of_pos (zero_lt_one.trans_le hN), sub_re, one_re]
    exact div_le_div₀ (by positivity) (Real.rpow_le_rpow_of_exponent_le hN₁
      (sub_le_sub_left hr.1 1)) hA him
  have hz : ‖riemannZeta s-Z‖ ≤ (1/2+(β+B)/(2*α))*(N : ℝ)^(-α)+(N : ℝ)^(1-α)/A := by
    rw [show riemannZeta s-Z = (riemannZeta s-Z-P)+P by ring]
    exact (norm_add_le _ _).trans (add_le_add htail' hpole)
  rw [he, norm_mul]
  exact mul_le_mul (norm_finiteSeries_moebius_le_rpow_sum X hr.1) hz (norm_nonneg _) (by positivity)

/-- Explicit upper bound from finite coefficient energy, the principal pole
term, and the Euler remainder. The same value applies throughout the rectangle. -/
noncomputable def mollifiedVerticalBound (X N : ℕ) (α β A B : ℝ) : ℝ :=
  2*(B-A+2*Real.pi*(X*N : ℕ))*
    coefficientEnergy (Finset.Icc 1 (X*N))
      (verticalCoefficients (detectorTailCoefficients X N) α) +
  2*(B-A)*(mollifiedEulerErrorBound X N α β A B)^2

/-- A bound by the finite detector's second moment and the Euler error. -/
theorem integral_mollifiedError_norm_sq_le_detector_and_remainder {X N : ℕ}
    (hX : 1 ≤ X) (hXN : X ≤ N) {α β A B : ℝ} (hα : 0 < α) (hA : 0 < A) (hAB : A ≤ B)
    {a : ℝ} (ha : a ∈ Icc α β) :
    (∫ t in Icc A B, ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
      2*(∫ t in Icc A B, ‖detectorPolynomial X N ((a : ℂ)+(t : ℂ)*I)‖^2) +
        2*(B-A)*(mollifiedEulerErrorBound X N α β A B)^2 := by
  let F := fun t : ℝ => ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2
  let c := detectorTailCoefficients X N
  let P := dirichletPolynomial (X*N) (verticalCoefficients c a)
  let K := mollifiedEulerErrorBound X N α β A B
  have hpoly (t : ℝ) : detectorPolynomial X N ((a : ℂ)+(t : ℂ)*I) = P t := by
    rw [detectorPolynomial_eq_complexDirichlet, complexDirichletPolynomial_vertical]
  have hF : IntegrableOn F (Icc A B) := Zeta.integrableOn_mollifiedError_vertical X a hA
  have hP : IntegrableOn (fun t => ‖P t‖^2) (Icc A B) :=
    ((continuous_dirichletPolynomial _ _).norm.pow 2).continuousOn.integrableOn_compact isCompact_Icc
  have hconst : Integrable (fun _ : ℝ => 2*K^2) (volume.restrict (Icc A B)) := integrable_const _
  have hpoint (t : ℝ) (ht : t ∈ Icc A B) : F t ≤ 2*‖P t‖^2+2*K^2 := by
    let s := (a : ℂ)+(t : ℂ)*I
    have hdiff : ‖mollifiedError X s-P t‖ ≤ K := by
      rw [← hpoly]
      exact norm_mollifiedError_sub_detectorPolynomial_le hX hXN hα hA
        (by simpa [s] using ha) (by simpa [s] using ht)
    have hnorm : ‖mollifiedError X s‖ ≤ ‖P t‖+K := by
      have hh := norm_add_le (P t) (mollifiedError X s-P t)
      rw [add_sub_cancel] at hh
      exact hh.trans (add_le_add_right hdiff _)
    have hsq := pow_le_pow_left₀ (norm_nonneg _) hnorm 2
    change ‖mollifiedError X s‖^2 ≤ _
    nlinarith [sq_nonneg (‖P t‖-K)]
  have hint : (∫ t in Icc A B, F t) ≤ ∫ t in Icc A B, 2*‖P t‖^2+2*K^2 :=
    setIntegral_mono_on hF ((hP.const_mul 2).add hconst) measurableSet_Icc hpoint
  rw [integral_add (hP.const_mul 2) hconst, integral_const_mul, setIntegral_const, measureReal_def,
    Real.volume_Icc, ENNReal.toReal_ofReal (sub_nonneg.mpr hAB), smul_eq_mul] at hint
  simp_rw [hpoly]
  convert hint using 1; ring

/-- An unconditional vertical second-moment estimate, expressed through the
Möbius-cancelled coefficient energy and the pole and Euler terms. -/
theorem integral_mollifiedError_norm_sq_le_finite_energy {X N : ℕ}
    (hX : 1 ≤ X) (hXN : X ≤ N) {α β A B : ℝ} (hα : 0 < α) (hA : 0 < A) (hAB : A ≤ B)
    {a : ℝ} (ha : a ∈ Icc α β) :
    (∫ t in Icc A B, ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
      mollifiedVerticalBound X N α β A B := by
  apply (integral_mollifiedError_norm_sq_le_detector_and_remainder hX hXN hα hA hAB ha).trans
  simp_rw [detectorPolynomial_eq_complexDirichlet, complexDirichletPolynomial_vertical]
  rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hAB]
  have hp := (integral_dirichletPolynomial_norm_sq_le_linear (X*N) (verticalCoefficients
    (detectorTailCoefficients X N) a) A B).trans
      (mul_le_mul_of_nonneg_left (vertical_coefficientEnergy_mono _ _ ha.1)
        (by have := sub_nonneg.mpr hAB; positivity))
  unfold mollifiedVerticalBound
  linarith only [hp]

end Legendre.Density.Detector

namespace Legendre.Zeta
open Density.Detector

/-- Finite-energy density bound with independent choices of the target gap
and the center offset, allowing the moment strip to approach the target line. -/
theorem zeroDensityCount_le_mollified_finite_energy_offset {X N : ℕ}
    (hX : 1 ≤ X) (hXN : X ≤ N) {δ η U V : ℝ} (hδ : 0 < δ) (hη : 0 < η)
    (hstrip : δ+2*η < 1) (hU : δ+5*η < U) (hUV : U ≤ V)
    (hscale : 2*(2+η⁻¹)^2 ≤ (X : ℝ)^η) :
    (zeroDensityCount (1-δ) V : ℝ) ≤ (zeroDensityCount (1-δ) U : ℝ) +
      (mollifiedVerticalBound X N (1-δ-2*η) (1+δ+6*η) (U-(δ+5*η)) (V+(δ+5*η)) +
        (4/3 : ℝ)*(V-U+2*η)*((X : ℝ)^(-η)*(2+η⁻¹)^2)^2) /
        (2*η*Real.log ((δ+4*η)/(δ+3*η))) := by
  apply zeroDensityCount_le_mollified_vertical_near_one_offset X hX hδ hη hU hUV hscale
  intro a ha
  exact integral_mollifiedError_norm_sq_le_finite_energy hX hXN
    (by linarith) (sub_pos.mpr hU) (by linarith) ha

/-- An effective bound for the near-one density increment in terms of finite
sums and the two truncation lengths. -/
theorem zeroDensityCount_le_mollified_finite_energy {X N : ℕ} (hX : 1 ≤ X) (hXN : X ≤ N)
    {δ U V : ℝ} (hδ : 0 < δ) (hδ₁ : δ < 1/3) (hU : 6*δ < U) (hUV : U ≤ V)
    (hscale : 2*(2+δ⁻¹)^2 ≤ (X : ℝ)^δ) :
    (zeroDensityCount (1-δ) V : ℝ) ≤ (zeroDensityCount (1-δ) U : ℝ) +
      (mollifiedVerticalBound X N (1-3*δ) (1+7*δ) (U-6*δ) (V+6*δ) +
        (4/3 : ℝ)*(V-U+2*δ)*((X : ℝ)^(-δ)*(2+δ⁻¹)^2)^2) / (2*δ*Real.log (5/4)) := by
  apply zeroDensityCount_le_mollified_vertical_near_one X hX hδ hU hUV hscale
  intro a ha
  exact integral_mollifiedError_norm_sq_le_finite_energy hX hXN
    (by linarith) (sub_pos.mpr hU) (by linarith) ha

end Legendre.Zeta
