/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityFiniteContinuity.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The zeta specialization retains the xi polynomial and the contour factor.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiFiniteMellin

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set
open Density Density.Moment
open scoped BigOperators

theorem xiMellinKernel_vertical_continuous (c : ℝ) (hc : 0 < c) :
    Continuous (fun z : ℝ × ℝ => xiMellinKernel
      ((1/2 : ℂ)+(z.1 : ℂ)*I) ((c : ℂ)+(z.2 : ℂ)*I)) := by
  let s := fun z : ℝ × ℝ => (1/2 : ℂ)+(z.1 : ℂ)*I
  let w := fun z : ℝ × ℝ => (c : ℂ)+(z.2 : ℂ)*I
  have hs : Continuous s := by dsimp [s]; fun_prop
  have hw : Continuous w := by dsimp [w]; fun_prop
  have hg : Continuous (fun z => Gammaℝ (s z+w z)) := by
    apply continuous_iff_continuousAt.mpr
    intro z
    exact (gammaReal_analytic_of_re_pos (by simp [s,w]; linarith)).continuousAt.comp
      (hs.add hw).continuousAt
  have hg0 : Continuous (fun z => Gammaℝ (s z)) := by
    apply continuous_iff_continuousAt.mpr
    intro z
    exact (gammaReal_analytic_of_re_pos (by norm_num [s])).continuousAt.comp hs.continuousAt
  have hs0 (z) : s z ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    norm_num [s] at this
  have hs1 (z) : s z-1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    norm_num [s] at this
  have hw0 (z) : w z ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp [w] at this
    exact hc.ne' this
  change Continuous (fun z =>
    (((s z+w z)*(s z+w z-1)/(s z*(s z-1)))^2*
      ((Gammaℝ (s z+w z)/Gammaℝ (s z))^2*Complex.exp ((w z)^2)))/(w z))
  exact (((((hs.add hw).mul ((hs.add hw).sub continuous_const)).div
    (hs.mul (hs.sub continuous_const)) (fun z => mul_ne_zero (hs0 z) (hs1 z))).pow 2).mul
      (((hg.div hg0 (fun z => Gammaℝ_ne_zero_of_re_pos (by norm_num [s]))).pow 2).mul
        ((hw.pow 2).cexp))).div hw hw0

theorem xiFiniteSquare_continuousOn (S : Finset ℕ) (hS : ∀ n ∈ S, 1 ≤ n)
    (T : ℝ) (hT : 1 ≤ T) :
    ContinuousOn (fun t : ℝ => ∑ n ∈ S,
      xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n) (Icc (-T) T) := by
  let a := verticalCoefficients zetaSquareCoefficient (1/2+(1 : ℝ))
  let K := xiMellinCost T 1*∑ n ∈ S, ‖a n‖
  let f : ℝ → ℝ → ℂ := fun t u => xiMellinKernel
    ((1/2 : ℂ)+(t : ℂ)*I) (1+(u : ℂ)*I)*subsetPolynomial S a (t+u)
  have hf : Continuous (Function.uncurry f) :=
    (xiMellinKernel_vertical_continuous 1 (by norm_num)).mul
      ((subsetPolynomial_continuous S a).comp (continuous_fst.add continuous_snd))
  have hI : ContinuousOn (fun t => ∫ u : ℝ, f t u) (Icc (-T) T) := by
    apply continuousOn_of_dominated (bound := fun u => K*momentGaussian u)
    · intro t _
      exact (hf.comp (continuous_const.prodMk continuous_id)).aestronglyMeasurable
    · intro t ht
      filter_upwards with u
      have hk := xiMellinKernel_common_bound T 1 t u hT (by norm_num) (by norm_num)
        (abs_le.mpr ht)
      have hp := subsetPolynomial_norm S a (t+u)
      dsimp [f,K]
      rw [norm_mul]
      calc
        _ ≤ (xiMellinCost T 1*momentGaussian u)*(∑ n ∈ S, ‖a n‖) :=
          mul_le_mul hk hp (norm_nonneg _)
            (mul_nonneg (xiMellinCost_pos hT (by norm_num : (0 : ℝ) < 1)).le (momentGaussian_pos u).le)
        _ = _ := by ring
    · exact momentGaussian_integrable.const_mul K
    · filter_upwards with u
      exact (hf.comp (continuous_id.prodMk continuous_const)).continuousOn
  have he (t : ℝ) : (∑ n ∈ S, xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n) =
      (2*(Real.pi : ℂ))⁻¹*∫ u : ℝ, f t u := by
    rw [xiSquareIntegralTerm_sum_shift (by simp) S hS 1 (by norm_num) (by norm_num)]
    congr 1
    apply integral_congr_ae
    filter_upwards with u
    rw [xiFiniteKernel,finiteMellin_original_polynomial S hS 1 t u]
    rfl
  simpa only [← he] using hI.const_mul ((2*(Real.pi : ℂ))⁻¹)

end Legendre.Zeta
