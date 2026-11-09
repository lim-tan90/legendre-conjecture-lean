/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityMomentDyadic.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The zeta specialization uses the local sharp Dirichlet mean directly.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.WeightedHeightMoment
public import Legendre.Layer4.ZetaFourthMoment

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set
open scoped ArithmeticFunction.Moebius

theorem dyadic_height_log (T : ℝ) (hT : 2 ≤ T) (j : ℕ) :
    Real.log ((2 : ℝ)^j*T) ≤ (j+1 : ℝ)*Real.log T := by
  have ht : 0 < T := by linarith
  have hl : Real.log 2 ≤ Real.log T := Real.log_le_log (by norm_num) hT
  rw [Real.log_mul (by positivity) ht.ne',Real.log_pow]
  have h := mul_le_mul_of_nonneg_left hl (Nat.cast_nonneg j : (0 : ℝ) ≤ j)
  nlinarith

theorem zeta_critical_continuous :
    Continuous (fun t : ℝ => riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)) := by
  apply continuous_iff_continuousAt.mpr
  intro t
  exact (differentiableAt_riemannZeta (by
    intro he
    have := congrArg Complex.re he
    norm_num at this)).continuousAt.comp (by fun_prop)

theorem mollifier_critical_continuous (X : ℕ) :
    Continuous (fun t : ℝ => Detector.finiteSeries (μ : ArithmeticFunction ℂ) X
      ((1/2 : ℂ)+(t : ℂ)*I)) := by
  have hM : Continuous (fun z : ℂ => Detector.finiteSeries (μ : ArithmeticFunction ℂ) X z) := by
    apply continuous_iff_continuousAt.mpr
    intro z
    simpa only [zero_add] using (Detector.Smooth.mollifier_shift_analytic X 0 z).continuousAt
  exact hM.comp (by fun_prop)

theorem critical_mollifier_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 1 ≤ T →
      (∫ t in Icc (-T) T, ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X
        ((1/2 : ℂ)+(t : ℂ)*I)‖^2) ≤ C*((X : ℝ)+T)*(1+Real.log X) := by
  refine ⟨2+2*Real.pi, by positivity, ?_⟩
  intro X hX T hT
  let a : ℕ → ℂ := verticalCoefficients (μ : ArithmeticFunction ℂ) (1/2)
  have he (t : ℝ) : Detector.finiteSeries (μ : ArithmeticFunction ℂ) X
      ((1/2 : ℂ)+(t : ℂ)*I) = dirichletPolynomial X a t := by
    change complexDirichletPolynomial X (μ : ArithmeticFunction ℂ)
      ((1/2 : ℂ)+(t : ℂ)*I) = _
    simpa only [a,Complex.ofReal_div,Complex.ofReal_one,Complex.ofReal_ofNat] using!
      complexDirichletPolynomial_vertical X ((μ : ArithmeticFunction ℂ) : ℕ → ℂ) (1/2) t
  simp_rw [he]
  have h := integral_dirichletPolynomial_norm_sq_le_linear X a (-T) T
  rw [intervalIntegral.integral_of_le (by linarith : -T ≤ T),← integral_Icc_eq_integral_Ioc] at h
  have hE := Detector.mollifier_vertical_energy_le X (σ := 1/2) le_rfl
  have hlog : 0 ≤ Real.log X := Real.log_nonneg (by exact_mod_cast hX)
  have hscale : T-(-T)+2*Real.pi*(X : ℝ) ≤ (2+2*Real.pi)*((X : ℝ)+T) := by
    nlinarith [Real.pi_pos,Nat.cast_nonneg (α := ℝ) X]
  exact h.trans (mul_le_mul hscale hE (by
    unfold coefficientEnergy
    exact Finset.sum_nonneg (fun _ _ => sq_nonneg _)) (by positivity))

end Legendre.Density.Moment
