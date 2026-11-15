/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local uniform cancellation for actual compact-detector blocks above the
varying short cutoff. Both oscillatory estimates are proved imports.
-/
module
public import Legendre.Layer4.UpperHuxleyCosts

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set Legendre.Density.Oscillation
open scoped BigOperators

/-- One absolute constant controls all long actual detector blocks in the upper range. -/
theorem huxley_actual_long_block_decay :
    ∃ D : ℝ, 0 < D ∧ ∀ T η σ β t Y : ℝ, 2 ≤ T → 0 ≤ η →
      5/6+η ≤ σ → σ ≤ β → β ≤ 1 → T/2 ≤ |t| → |t| ≤ T → 0 < Y →
      ∀ X U V : ℕ, 1 ≤ U → X ≤ U → U ≤ V → V ≤ 2*U →
      T^huxleyShortCutoff σ ≤ (U : ℝ) → (U : ℝ) ≤ T →
      ‖∑ n ∈ Finset.Ioc U V, Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤ D*(X : ℝ)*T^(-η/8) := by
  let D := 2*(5*logarithmicWeylConstant+3*logarithmicSecondConstant+2)
  have hw := logarithmicWeylConstant_pos
  have hs := logarithmicSecondConstant_pos
  have hD : 0 < D := by dsimp [D]; positivity
  refine ⟨D,hD,?_⟩
  intro T η σ β t Y hT hη hσ hβ hβ1 htlo hthi hY X U V hU hXU hUV hV hUlo hUhi
  have hσ1 : σ ≤ 1 := hβ.trans hβ1
  have hβ0 : 0 ≤ β := by linarith
  have hUr : (1 : ℝ) ≤ U := by exact_mod_cast hU
  have hweight : (U : ℝ)^(-β) ≤ (U : ℝ)^(-σ) :=
    Real.rpow_le_rpow_of_exponent_le hUr (by linarith)
  by_cases hmid : (U : ℝ) ≤ T^(3/5 : ℝ)
  · have hb := Detector.Smooth.polynomial_block_general_weyl X U V hU hXU hUV hV β t Y hβ0 hβ1
      (by linarith) hY
    have hd := huxley_medium_cost_decay T U η σ t hT hU hη hσ hσ1 hUlo hmid ⟨htlo,hthi⟩
    have hn := generalWeylCost_nonneg U t
    calc
      _ ≤ 2*(X : ℝ)*((U : ℝ)^(-β)*(generalWeylCost U t+1)) := by convert hb using 1; ring
      _ ≤ 2*(X : ℝ)*((U : ℝ)^(-σ)*(generalWeylCost U t+1)) := by gcongr
      _ ≤ 2*(X : ℝ)*((5*logarithmicWeylConstant+1)*T^(-η/8)) :=
        mul_le_mul_of_nonneg_left hd (by positivity)
      _ ≤ D*(X : ℝ)*T^(-η/8) := by
        have hh : 2*(5*logarithmicWeylConstant+1) ≤ D := by dsimp [D]; linarith
        have he := mul_le_mul_of_nonneg_right hh (show 0 ≤ (X : ℝ)*T^(-η/8) by positivity)
        nlinarith only [he]
  · have ht : t ≠ 0 := by intro he; subst t; norm_num at htlo; linarith
    have hb := Detector.Smooth.polynomial_block_second_derivative X U V hU hXU hUV hV β t Y hβ0 hβ1 ht hY
    have hd := huxley_long_cost_decay T U η σ t hT hU hη hσ hσ1 (le_of_not_ge hmid) hUhi ⟨htlo,hthi⟩
    have hn := secondDerivativeCost_nonneg U t
    calc
      _ ≤ 2*(X : ℝ)*((U : ℝ)^(-β)*(secondDerivativeCost U t+1)) := by convert hb using 1; ring
      _ ≤ 2*(X : ℝ)*((U : ℝ)^(-σ)*(secondDerivativeCost U t+1)) := by gcongr
      _ ≤ 2*(X : ℝ)*((3*logarithmicSecondConstant+1)*T^(-η/8)) :=
        mul_le_mul_of_nonneg_left hd (by positivity)
      _ ≤ D*(X : ℝ)*T^(-η/8) := by
        have hh : 2*(3*logarithmicSecondConstant+1) ≤ D := by dsimp [D]; linarith
        have he := mul_le_mul_of_nonneg_right hh (show 0 ≤ (X : ℝ)*T^(-η/8) by positivity)
        nlinarith only [he]

end Legendre.Density.Moment
