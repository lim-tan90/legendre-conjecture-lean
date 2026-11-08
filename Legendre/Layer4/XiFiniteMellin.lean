/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityFiniteContourShift.lean, DensityFiniteSeriesBridge.lean
and DensityFiniteSquareEnergy.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Finite zeta terms use the local phase convention without a Fourier rescaling.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiSquareSeries
public import Legendre.Layer4.GaussianContourShift
public import Legendre.Layer4.GaussianMean
public import Legendre.ComplexDirichlet

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set
open Density Density.Moment
open scoped BigOperators

noncomputable def finiteMellin (S : Finset ℕ) (a : ℕ → ℂ) (w : ℂ) : ℂ :=
  ∑ n ∈ S, a n/(n : ℂ)^w

theorem finiteMellin_analytic (S : Finset ℕ) (a : ℕ → ℂ)
    (hS : ∀ n ∈ S, 1 ≤ n) (w : ℂ) : AnalyticAt ℂ (finiteMellin S a) w := by
  apply Finset.analyticAt_fun_sum
  intro n hn
  have hn0 : (n : ℂ) ≠ 0 := by exact_mod_cast (by have := hS n hn; omega : n ≠ 0)
  exact analyticAt_const.div ((differentiable_id.const_cpow (Or.inl hn0)).analyticAt w)
    (Complex.cpow_ne_zero_iff.2 (Or.inl hn0))

theorem finiteMellin_norm (S : Finset ℕ) (a : ℕ → ℂ)
    (hS : ∀ n ∈ S, 1 ≤ n) (w : ℂ) (hw : 0 ≤ w.re) :
    ‖finiteMellin S a w‖ ≤ ∑ n ∈ S, ‖a n‖ := by
  apply (norm_sum_le _ _).trans
  apply Finset.sum_le_sum
  intro n hn
  rw [norm_div,norm_natCast_cpow_of_pos (Nat.zero_lt_one.trans_le (hS n hn))]
  exact div_le_self (norm_nonneg _) (Real.one_le_rpow (by exact_mod_cast hS n hn) hw)

noncomputable def xiFiniteKernel (s : ℂ) (S : Finset ℕ) (a : ℕ → ℂ) (w : ℂ) : ℂ :=
  xiMellinKernel s w*finiteMellin S a w

theorem xiFiniteKernel_shift {s : ℂ} (hs : s.re = 1/2) (S : Finset ℕ) (a : ℕ → ℂ)
    (hS : ∀ n ∈ S, 1 ≤ n) (c : ℝ) (hc : 0 < c) (hc1 : c ≤ 1) :
    (∫ u : ℝ, xiFiniteKernel s S a ((c : ℂ)+(u : ℂ)*I)) =
      ∫ u : ℝ, xiFiniteKernel s S a (1+(u : ℂ)*I) := by
  let K := 10816*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)/c
  have hK : 0 ≤ K := by
    dsimp [K]
    unfold Density.GammaBounds.gammaGaussianConstant
    positivity
  apply gaussian_strip_vertical_eq (xiFiniteKernel s S a) c 1 (K*∑ n ∈ S, ‖a n‖) hc1
  · intro w hw _hw1
    exact (xiMellinKernel_analytic hs (hc.trans_le hw)).mul (finiteMellin_analytic S a hS w)
  · intro x hx u
    have hk := xiMellinKernel_strip_bound hs c x u hc hx.1 hx.2
    have hm := finiteMellin_norm S a hS ((x : ℂ)+(u : ℂ)*I) (by simp; linarith [hx.1])
    rw [xiFiniteKernel,norm_mul]
    have hh := mul_le_mul hk hm (norm_nonneg _) (mul_nonneg hK (momentGaussian_pos u).le)
    convert hh using 1
    unfold momentGaussian
    ring

theorem LSeries_term_add (a : ℕ → ℂ) (s w : ℂ) (n : ℕ) :
    LSeries.term a (s+w) n = LSeries.term a s n/(n : ℂ)^w := by
  by_cases hn : n = 0
  · subst n; simp
  · have hnC : (n : ℂ) ≠ 0 := by exact_mod_cast hn
    rw [LSeries.term_of_ne_zero hn,LSeries.term_of_ne_zero hn,Complex.cpow_add _ _ hnC]
    ring

theorem xiFiniteKernel_original_terms (s w : ℂ) (S : Finset ℕ) :
    xiFiniteKernel s S (LSeries.term zetaSquareCoefficient s) w =
      ∑ n ∈ S, xiMellinKernel s w*LSeries.term zetaSquareCoefficient (s+w) n := by
  unfold xiFiniteKernel finiteMellin
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro n _
  rw [LSeries_term_add]

theorem xiSquareIntegralTerm_sum {s : ℂ} (hs : s.re = 1/2) (S : Finset ℕ) :
    (∑ n ∈ S, xiSquareIntegralTerm s n) = (2*(Real.pi : ℂ))⁻¹*
      ∫ u : ℝ, xiFiniteKernel s S (LSeries.term zetaSquareCoefficient s) (1+(u : ℂ)*I) := by
  unfold xiSquareIntegralTerm
  rw [← Finset.mul_sum,← integral_finsetSum S (fun n _ => xiSquareSeriesTerm_integrable hs n)]
  congr 1
  apply integral_congr_ae
  filter_upwards with u
  exact (xiFiniteKernel_original_terms s (1+(u : ℂ)*I) S).symm

theorem xiSquareIntegralTerm_sum_shift {s : ℂ} (hs : s.re = 1/2) (S : Finset ℕ)
    (hS : ∀ n ∈ S, 1 ≤ n) (c : ℝ) (hc : 0 < c) (hc1 : c ≤ 1) :
    (∑ n ∈ S, xiSquareIntegralTerm s n) = (2*(Real.pi : ℂ))⁻¹*
      ∫ u : ℝ, xiFiniteKernel s S (LSeries.term zetaSquareCoefficient s) ((c : ℂ)+(u : ℂ)*I) := by
  rw [xiSquareIntegralTerm_sum hs S,xiFiniteKernel_shift hs S _ hS c hc hc1]

theorem LSeries_term_vertical (a : ℕ → ℂ) (σ t : ℝ) {n : ℕ} (hn : 0 < n) :
    LSeries.term a ((σ : ℂ)+(t : ℂ)*I) n = verticalCoefficients a σ n*realPhase (-Real.log n) t := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hnC : (n : ℂ) ≠ 0 := by exact_mod_cast hn.ne'
  rw [LSeries.term_of_ne_zero hn.ne',verticalCoefficients,realPhase_neg_log_eq_cpow hnR t,
    Complex.ofReal_natCast,mul_assoc,← Complex.cpow_add _ _ hnC]
  have he : -(σ : ℂ)+(-(t : ℂ)*I) = -((σ : ℂ)+(t : ℂ)*I) := by ring
  rw [he,Complex.cpow_neg,div_eq_mul_inv]

theorem finiteMellin_original_polynomial (S : Finset ℕ) (hS : ∀ n ∈ S, 1 ≤ n) (c t u : ℝ) :
    finiteMellin S (LSeries.term zetaSquareCoefficient ((1/2 : ℂ)+(t : ℂ)*I)) ((c : ℂ)+(u : ℂ)*I) =
      subsetPolynomial S (verticalCoefficients zetaSquareCoefficient (1/2+c)) (t+u) := by
  unfold finiteMellin subsetPolynomial exponentialSum
  apply Finset.sum_congr rfl
  intro n hn
  rw [← LSeries_term_add]
  have he : (1/2 : ℂ)+(t : ℂ)*I+((c : ℂ)+(u : ℂ)*I) =
      ((1/2+c : ℝ) : ℂ)+(t+u : ℝ)*I := by push_cast; ring
  rw [he,LSeries_term_vertical _ _ _ (Nat.zero_lt_one.trans_le (hS n hn))]

theorem norm_two_pi_inv_le_one : ‖(2*(Real.pi : ℂ))⁻¹‖ ≤ 1 := by
  rw [norm_inv,norm_mul,Complex.norm_ofNat,Complex.norm_real,Real.norm_eq_abs,abs_of_pos Real.pi_pos]
  exact (inv_le_one₀ (by positivity)).2 (by nlinarith [Real.pi_gt_three])

theorem xiFiniteSquare_energy (S : Finset ℕ) (hS : ∀ n ∈ S, 1 ≤ n)
    (T c t : ℝ) (hT : 1 ≤ T) (hc : 0 < c) (hc1 : c ≤ 1) (ht : |t| ≤ T) :
    ‖∑ n ∈ S, xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2 ≤
      (xiMellinCost T c)^2*(∫ u : ℝ, momentGaussian u)*
        ∫ u : ℝ, momentGaussian u*
          ‖subsetPolynomial S (verticalCoefficients zetaSquareCoefficient (1/2+c)) (t+u)‖^2 := by
  let s : ℂ := (1/2 : ℂ)+(t : ℂ)*I
  let a := verticalCoefficients zetaSquareCoefficient (1/2+c)
  let f := fun u : ℝ => xiFiniteKernel s S (LSeries.term zetaSquareCoefficient s) ((c : ℂ)+(u : ℂ)*I)
  have hs : s.re = 1/2 := by simp [s]
  rw [xiSquareIntegralTerm_sum_shift hs S hS c hc hc1,norm_mul]
  apply (pow_le_pow_left₀ (by positivity) (mul_le_of_le_one_left (norm_nonneg _) norm_two_pi_inv_le_one) 2).trans
  apply gaussian_integral_cauchy f (fun u => ‖subsetPolynomial S a (t+u)‖) (xiMellinCost T c)
    (∑ n ∈ S, ‖a n‖)
  · exact (((subsetPolynomial_continuous S a).comp (continuous_const.add continuous_id)).norm)
  · intro u; exact norm_nonneg _
  · intro u; exact subsetPolynomial_norm S a (t+u)
  · intro u
    dsimp [f,s,a]
    rw [xiFiniteKernel,norm_mul,finiteMellin_original_polynomial S hS c t u]
    exact mul_le_mul_of_nonneg_right (xiMellinKernel_common_bound T c t u hT hc hc1 ht) (norm_nonneg _)

end Legendre.Zeta
