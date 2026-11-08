/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityFiniteSquareMean.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Translated Dirichlet mean values replace the character-family large sieve.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiFiniteContinuity

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set
open Density Density.Moment
open scoped BigOperators

theorem xiFiniteSquare_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ N : ℕ, ∀ T c : ℝ, 1 ≤ T → 0 < c → c ≤ 1 →
      ∀ S : Finset ℕ, S ⊆ Finset.Icc 1 N →
      (∫ t in Icc (-T) T, ‖∑ n ∈ S, xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2) ≤
        C*(xiMellinCost T c)^2*((N : ℝ)+T)*
          ∑ n ∈ S, ‖verticalCoefficients zetaSquareCoefficient (1/2+c) n‖^2 := by
  let G := ∫ u : ℝ, momentGaussian u
  refine ⟨G^2*(2+2*Real.pi), mul_pos (sq_pos_of_pos momentGaussian_integral_pos)
    (by positivity), ?_⟩
  intro N T c hT hc hc1 S hS
  let a := verticalCoefficients zetaSquareCoefficient (1/2+c)
  let K := xiMellinCost T c
  have hG : 0 ≤ G := momentGaussian_integral_pos.le
  have hspos : ∀ n ∈ S, 1 ≤ n := fun n hn => (Finset.mem_Icc.mp (hS hn)).1
  have hp := (gaussian_subset_integrable S a T).integral_prod_left
  have hm : (∫ t in Icc (-T) T,
      ‖∑ n ∈ S, xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2) ≤
      K^2*G*(∫ t in Icc (-T) T, ∫ u : ℝ, momentGaussian u*‖subsetPolynomial S a (t+u)‖^2) := by
    rw [← integral_const_mul]
    apply integral_mono_ae
    · exact (((xiFiniteSquare_continuousOn S hspos T hT).norm).pow 2).integrableOn_Icc
    · exact hp.const_mul _
    · filter_upwards [ae_restrict_mem measurableSet_Icc] with t ht
      exact xiFiniteSquare_energy S hspos T c t hT hc hc1 (abs_le.mpr ht)
  have hb := mul_le_mul_of_nonneg_left (gaussian_subset_mean S a N hS T (by linarith))
    (mul_nonneg (sq_nonneg K) hG)
  apply hm.trans (hb.trans ?_)
  have hscale : 2*T+2*Real.pi*(N : ℝ) ≤ (2+2*Real.pi)*((N : ℝ)+T) := by
    nlinarith [Real.pi_pos, Nat.cast_nonneg (α := ℝ) N]
  have he : 0 ≤ coefficientEnergy S a := Finset.sum_nonneg (fun _ _ => sq_nonneg _)
  have hh := mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_left hscale (mul_nonneg (sq_nonneg K) (sq_nonneg G))) he
  convert hh using 1 <;> dsimp [coefficientEnergy,a,K] <;> ring

end Legendre.Zeta
