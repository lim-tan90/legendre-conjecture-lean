/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensitySquareTerms.lean and DensitySquareSeriesIntegral.lean in
openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Uses the actual zeta divisor series and the entire xi polynomial Gaussian.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiMellinKernel
public import Legendre.Layer4.ZetaSquareSeries
public import Mathlib.MeasureTheory.Integral.DominatedConvergence

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory
open Density.Moment

noncomputable def xiSquareSeriesTerm (s : ℂ) (n : ℕ) (u : ℝ) : ℂ :=
  xiMellinKernel s (1+(u : ℂ)*I)*LSeries.term zetaSquareCoefficient (s+(1+(u : ℂ)*I)) n

theorem xiSquareSeriesTerm_bound {s : ℂ} (hs : s.re = 1/2) (n : ℕ) (u : ℝ) :
    ‖xiSquareSeriesTerm s n u‖ ≤
      ((10816*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2))*
        ‖LSeries.term zetaSquareCoefficient (3/2 : ℂ) n‖)*momentGaussian u := by
  have he : ‖LSeries.term zetaSquareCoefficient (s+(1+(u : ℂ)*I)) n‖ =
      ‖LSeries.term zetaSquareCoefficient (3/2 : ℂ) n‖ := by
    simp only [LSeries.norm_term_eq]
    norm_num [hs]
  rw [xiSquareSeriesTerm,norm_mul,he]
  have h := mul_le_mul_of_nonneg_right
    (xiMellinKernel_short_line hs 1 u (by norm_num) (by norm_num))
    (norm_nonneg (LSeries.term zetaSquareCoefficient (3/2 : ℂ) n))
  norm_num only [one_div,Real.rpow_one,div_one,Complex.ofReal_one] at h
  convert h using 1
  ring

theorem xiMellinKernel_line_continuous {s : ℂ} (hs : s.re = 1/2) :
    Continuous (fun u : ℝ => xiMellinKernel s (1+(u : ℂ)*I)) := by
  apply continuous_iff_continuousAt.2
  intro u
  exact (xiMellinKernel_analytic hs (w := 1+(u : ℂ)*I) (by simp)).continuousAt.comp (f := fun v : ℝ => 1+(v : ℂ)*I) (by fun_prop)

theorem xiSquareSeriesTerm_continuous {s : ℂ} (hs : s.re = 1/2) (n : ℕ) :
    Continuous (xiSquareSeriesTerm s n) := by
  apply (xiMellinKernel_line_continuous hs).mul
  by_cases hn : n = 0
  · subst n
    simp only [LSeries.term_zero]
    exact continuous_const
  · simp only [LSeries.term_of_ne_zero hn]
    have hnC : (n : ℂ) ≠ 0 := by exact_mod_cast hn
    have hp : Continuous (fun u : ℝ => (n : ℂ)^(s+(1+(u : ℂ)*I))) :=
      (differentiable_id.const_cpow (Or.inl hnC)).continuous.comp (by fun_prop)
    exact continuous_const.div hp (fun u => Complex.cpow_ne_zero_iff.2 (Or.inl hnC))

theorem xiSquareSeriesTerm_integrable {s : ℂ} (hs : s.re = 1/2) (n : ℕ) :
    Integrable (xiSquareSeriesTerm s n) := by
  apply (momentGaussian_integrable.const_mul
    ((10816*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2))*
      ‖LSeries.term zetaSquareCoefficient (3/2 : ℂ) n‖)).mono'
    (xiSquareSeriesTerm_continuous hs n).aestronglyMeasurable
  filter_upwards with u
  exact xiSquareSeriesTerm_bound hs n u

theorem xiSquareSeriesTerm_integral_summable {s : ℂ} (hs : s.re = 1/2) :
    Summable (fun n : ℕ => ∫ u : ℝ, ‖xiSquareSeriesTerm s n u‖) := by
  let K := 10816*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)
  have hb (n : ℕ) : (∫ u : ℝ, ‖xiSquareSeriesTerm s n u‖) ≤
      (K*‖LSeries.term zetaSquareCoefficient (3/2 : ℂ) n‖)*∫ u : ℝ, momentGaussian u := by
    rw [← integral_const_mul]
    apply integral_mono_ae (xiSquareSeriesTerm_integrable hs n).norm
      (momentGaussian_integrable.const_mul _)
    filter_upwards with u
    exact xiSquareSeriesTerm_bound hs n u
  have hsum := ((zetaSquareCoefficient_summable (s := (3/2 : ℂ)) (by norm_num)).norm.mul_left K).mul_right
    (∫ u : ℝ, momentGaussian u)
  exact hsum.of_nonneg_of_le (fun n => integral_nonneg (fun u => norm_nonneg _)) hb

noncomputable def xiSquareIntegralTerm (s : ℂ) (n : ℕ) : ℂ :=
  (2*(Real.pi : ℂ))⁻¹*∫ u : ℝ, xiSquareSeriesTerm s n u

theorem xiSmoothedZetaSquare_series {s : ℂ} (hs : s.re = 1/2) :
    xiSmoothedZetaSquare s = ∑' n : ℕ, xiSquareIntegralTerm s n := by
  have he (u : ℝ) : xiMellinKernel s (1+(u : ℂ)*I)*riemannZeta (s+(1+(u : ℂ)*I))^2 =
      ∑' n : ℕ, xiSquareSeriesTerm s n u := by
    have hp : 1 < (s+(1+(u : ℂ)*I)).re := by simp [hs]
    rw [← zeta_square_LSeries hp,LSeries,← tsum_mul_left]
    rfl
  rw [xiSmoothedZetaSquare_integral hs]
  simp_rw [he]
  rw [← integral_tsum_of_summable_integral_norm (fun n => xiSquareSeriesTerm_integrable hs n)
    (xiSquareSeriesTerm_integral_summable hs)]
  exact tsum_mul_left.symm

end Legendre.Zeta
