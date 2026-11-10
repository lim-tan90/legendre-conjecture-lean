/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions: the proved analytic large-value count improves the actual
Mobius polynomial moment, uniformly under common vertical translation.
-/
module
public import Legendre.Layer4.Exponential.CriticalPolynomialOptimizedMoment
public import Legendre.Layer4.PackedCriticalMass

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory
open scoped BigOperators ArithmeticFunction.Moebius

noncomputable def halaszMollifierMomentBound (X J : ℕ) (T R : ℝ) : ℝ :=
  4*Oscillation.criticalPolynomialMomentCost X T*(J : ℝ)+
    5*R^(2/3 : ℝ)*(Oscillation.criticalPolynomialMomentCost X T*T)^(1/3 : ℝ)

theorem halaszMollifierMomentBound_nonneg (X J : ℕ) (hX : 1 ≤ X)
    (T R : ℝ) (hT : 1 ≤ T) (hR : 0 ≤ R) :
    0 ≤ halaszMollifierMomentBound X J T R := by
  have hA := Oscillation.criticalPolynomialMomentCost_ge_four X hX T hT
  unfold halaszMollifierMomentBound
  positivity

/-- A common translation does not change the large-value distribution estimate. -/
theorem mollifier_sampled_halasz {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (X J : ℕ) (hX : 1 ≤ X) (hcover : X ≤ 2^J) (T c : ℝ) (hT : 1 ≤ T)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (∑ i ∈ S, ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X
      ((1/2 : ℂ)+((t i+c : ℝ) : ℂ)*I)‖^2) ≤ halaszMollifierMomentBound X J T S.card := by
  have ha (n : ℕ) : ‖(μ : ArithmeticFunction ℂ) n‖ ≤ 1 := by
    simpa only [ArithmeticFunction.intCoe_apply] using Detector.norm_moebius_le_one n
  exact Oscillation.critical_polynomial_optimized_second_moment S t X J hX hcover
    (μ : ArithmeticFunction ℂ) ha T c hT ht hs

/-- Integrating the common translate preserves the improved sampled moment. -/
theorem packed_mollifier_halasz {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (X J : ℕ) (hX : 1 ≤ X) (hcover : X ≤ 2^J) (T : ℝ) (hT : 2 ≤ T)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (∀ i ∈ S, Integrable (fun v => Detector.Smooth.criticalWeight (v-t i)*
      ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖^2)) ∧
    (∑ i ∈ S, ∫ v, Detector.Smooth.criticalWeight (v-t i)*
      ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖^2) ≤
      (∫ u : ℝ, Detector.Smooth.criticalWeight u)*halaszMollifierMomentBound X J T S.card := by
  classical
  obtain ⟨C,hC,hpacked⟩ := packed_mollifier_mean
  obtain ⟨hi,hb⟩ := hpacked X hX T hT S t ht hs
  refine ⟨hi,?_⟩
  let g := fun (i : ι) (u : ℝ) => Detector.Smooth.criticalWeight u*
    ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X
      ((1/2 : ℂ)+((t i+u : ℝ) : ℂ)*I)‖^2
  have hgi (i : ι) (hiS : i ∈ S) : Integrable (g i) := by
    have hh := (hi i hiS).comp_add_right (t i)
    simpa only [g,add_sub_cancel_right,add_comm] using hh
  have he (i : ι) :
      (∫ v, Detector.Smooth.criticalWeight (v-t i)*
        ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖^2) = ∫ u, g i u := by
    have hh := integral_add_right_eq_self («μ» := volume)
      (fun v => Detector.Smooth.criticalWeight (v-t i)*
        ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖^2) (t i)
    simpa only [g,add_sub_cancel_right,add_comm] using hh.symm
  simp_rw [he]
  rw [←integral_finsetSum S hgi,←integral_mul_const]
  apply integral_mono (integrable_finsetSum S hgi)
    (criticalWeight_integrable.mul_const (halaszMollifierMomentBound X J T S.card))
  intro u
  have hh := mollifier_sampled_halasz S t X J hX hcover T u (by linarith) ht hs
  have hm := mul_le_mul_of_nonneg_left hh (Detector.Smooth.criticalWeight_nonneg u)
  simpa only [g,Finset.mul_sum] using hm

end Legendre.Density.Moment
