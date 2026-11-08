/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityHeadCutoff.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiFiniteMean
public import Legendre.Layer4.DivisorEnergy

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set
open Density Density.Moment
open scoped BigOperators

theorem xiMellinCost_log (N : ℕ) (T : ℝ) (hT : 1 ≤ T)
    (hN : 1 ≤ Real.log N) (hscale : 10*T ≤ N) :
    xiMellinCost T (1/Real.log N) ≤ xiMellinConstant*Real.exp 1*Real.log N := by
  have hNp : (0 : ℝ) < N := lt_of_lt_of_le (by linarith : 0 < 10*T) hscale
  have hc : 0 < 1/Real.log N := div_pos zero_lt_one (by linarith)
  have hpow : (N : ℝ)^(1/Real.log N) = Real.exp 1 := by
    rw [Real.rpow_def_of_pos hNp]
    congr 1
    field_simp
  unfold xiMellinCost
  calc
    _ ≤ xiMellinConstant*(N : ℝ)^(1/Real.log N)/(1/Real.log N) := by
      apply div_le_div_of_nonneg_right _ hc.le
      exact mul_le_mul_of_nonneg_left (Real.rpow_le_rpow (by positivity) hscale hc.le)
        xiMellinConstant_pos.le
    _ = _ := by rw [hpow]; field_simp

theorem xiFiniteSquare_head_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ N : ℕ, ∀ T : ℝ, 1 ≤ T →
      1 ≤ Real.log N → 10*T ≤ N →
      (∫ t in Icc (-T) T, ‖∑ n ∈ Finset.Icc 1 N,
        xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2) ≤
          C*((N : ℝ)+T)*(Real.log N)^6 := by
  obtain ⟨C,hC,hb⟩ := xiFiniteSquare_mean
  refine ⟨16*C*(xiMellinConstant*Real.exp 1)^2, by have := xiMellinConstant_pos; positivity, ?_⟩
  intro N T hT hN hscale
  let c := 1/Real.log N
  have hc : 0 < c := div_pos zero_lt_one (by linarith)
  have hc1 : c ≤ 1 := (div_le_one (by linarith)).mpr hN
  have h := hb N T c hT hc hc1 (Finset.Icc 1 N) (fun _ hn => hn)
  have he := divisor_shifted_head N c hc.le
  have hk := xiMellinCost_log N T hT hN hscale
  have hlog : (1+Real.log N)^4 ≤ 16*(Real.log N)^4 := by
    have hh := pow_le_pow_left₀ (by linarith : 0 ≤ 1+Real.log N)
      (by linarith : 1+Real.log N ≤ 2*Real.log N) 4
    nlinarith
  calc
    _ ≤ C*(xiMellinCost T c)^2*((N : ℝ)+T)*(1+Real.log N)^4 :=
      h.trans (mul_le_mul_of_nonneg_left he (by positivity))
    _ ≤ C*(xiMellinConstant*Real.exp 1*Real.log N)^2*((N : ℝ)+T)*
        (16*(Real.log N)^4) := by
      apply mul_le_mul _ hlog (by positivity) (by positivity)
      apply mul_le_mul_of_nonneg_right _ (by positivity)
      exact mul_le_mul_of_nonneg_left
        (pow_le_pow_left₀ (xiMellinCost_pos hT hc).le hk 2) hC.le
    _ = _ := by ring

end Legendre.Zeta
