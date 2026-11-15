/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local normalization of the proved pointwise costs on a high ordinate shell.
All small negative exponents and reciprocal-height factors are retained.
-/
module
public import Legendre.Layer4.UpperHuxleyPowerBounds
public import Legendre.Layer4.DetectorMobiusPointwise

@[expose] public section
namespace Legendre.Density.Moment
open Legendre.Density.Oscillation

/-- Normalize all general Weyl costs in the medium-length part of the upper range. -/
theorem huxley_medium_cost_decay (T : ℝ) (U : ℕ) (η σ t : ℝ) (hT : 2 ≤ T)
    (hU : 1 ≤ U) (hη : 0 ≤ η) (hσ : 5/6+η ≤ σ) (hσ1 : σ ≤ 1)
    (hUlo : T^huxleyShortCutoff σ ≤ (U : ℝ)) (hUhi : (U : ℝ) ≤ T^(3/5 : ℝ))
    (ht : T/2 ≤ |t| ∧ |t| ≤ T) :
    (U : ℝ)^(-σ)*(generalWeylCost U t+1) ≤
      (5*logarithmicWeylConstant+1)*T^(-η/8) := by
  have hTp : 0 < T := by linarith
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hP := huxley_medium_power_bounds T U η σ hT hη hσ hσ1 hUlo hUhi
  have hC := logarithmicWeylConstant_pos
  have he1 : (U : ℝ)^(-σ)*Real.sqrt (U : ℝ) = (U : ℝ)^(1/2-σ) := by
    rw [Real.sqrt_eq_rpow,←Real.rpow_add hUp]
    congr 1
    ring
  have he2 : (U : ℝ)^(-σ)*(U : ℝ)*(U : ℝ)^(1/4 : ℝ) = (U : ℝ)^(5/4-σ) := by
    calc
      _ = (U : ℝ)^(-σ)*(U : ℝ)^(1 : ℝ)*(U : ℝ)^(1/4 : ℝ) := by rw [Real.rpow_one]
      _ = _ := by rw [←Real.rpow_add hUp,←Real.rpow_add hUp]; congr 1; ring
  have he3 : (U : ℝ)^(-σ)*(U : ℝ) = (U : ℝ)^(1-σ) := by
    calc
      _ = (U : ℝ)^(-σ)*(U : ℝ)^(1 : ℝ) := by rw [Real.rpow_one]
      _ = _ := by rw [←Real.rpow_add hUp]; congr 1; ring
  have hfirst : (U : ℝ)^(-σ)*(Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)) ≤ T^(-η/8) := by
    calc
      _ ≤ (U : ℝ)^(-σ)*(Real.sqrt (U : ℝ)*T^(1/6 : ℝ)) := by gcongr; exact ht.2
      _ = T^(1/6 : ℝ)*((U : ℝ)^(-σ)*Real.sqrt (U : ℝ)) := by ring
      _ = T^(1/6 : ℝ)*(U : ℝ)^(1/2-σ) := by rw [he1]
      _ ≤ _ := hP.1
  have hsecond : (U : ℝ)^(-σ)*((U : ℝ)*((U : ℝ)/|t|)^(1/4 : ℝ)) ≤ 2*T^(-η/8) := by
    have hratio := shell_ratio_power T |t| U (1/4) hTp ht.1 (Nat.cast_nonneg U) (by norm_num) (by norm_num)
    norm_num only [neg_div] at hratio
    calc
      _ ≤ (U : ℝ)^(-σ)*((U : ℝ)*(2*(U : ℝ)^(1/4 : ℝ)*T^(-1/4 : ℝ))) := by gcongr; convert hratio using 1; norm_num
      _ = 2*T^(-1/4 : ℝ)*((U : ℝ)^(-σ)*(U : ℝ)*(U : ℝ)^(1/4 : ℝ)) := by ring
      _ = 2*(T^(-1/4 : ℝ)*(U : ℝ)^(5/4-σ)) := by rw [he2]; ring
      _ ≤ _ := mul_le_mul_of_nonneg_left hP.2.1 (by norm_num)
  have hthird : (U : ℝ)^(-σ)*((U : ℝ)/|t|^(1/3 : ℝ)) ≤ 2*T^(-η/8) := by
    have hrec := shell_reciprocal_power T |t| (1/3) hTp ht.1 (by norm_num) (by norm_num)
    norm_num only [neg_div] at hrec
    calc
      _ = ((U : ℝ)^(-σ)*(U : ℝ))*(1/|t|^(1/3 : ℝ)) := by ring
      _ ≤ ((U : ℝ)^(-σ)*(U : ℝ))*(2*T^(-1/3 : ℝ)) :=
        by
          apply mul_le_mul_of_nonneg_left _ (by positivity)
          convert hrec using 1; norm_num
      _ = 2*(T^(-1/3 : ℝ)*(U : ℝ)^(1-σ)) := by rw [he3]; ring
      _ ≤ _ := mul_le_mul_of_nonneg_left hP.2.2.1 (by norm_num)
  have hc := mul_le_mul_of_nonneg_left (add_le_add (add_le_add hfirst hsecond) hthird) hC.le
  dsimp only [generalWeylCost]
  nlinarith [hP.2.2.2]

/-- Normalize the second-derivative costs beyond T^(3/5). -/
theorem huxley_long_cost_decay (T : ℝ) (U : ℕ) (η σ t : ℝ) (hT : 2 ≤ T)
    (hU : 1 ≤ U) (hη : 0 ≤ η) (hσ : 5/6+η ≤ σ) (hσ1 : σ ≤ 1)
    (hUlo : T^(3/5 : ℝ) ≤ (U : ℝ)) (hUhi : (U : ℝ) ≤ T)
    (ht : T/2 ≤ |t| ∧ |t| ≤ T) :
    (U : ℝ)^(-σ)*(secondDerivativeCost U t+1) ≤
      (3*logarithmicSecondConstant+1)*T^(-η/8) := by
  have hTp : 0 < T := by linarith
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hP := huxley_long_power_bounds T U η σ hT hη hσ hσ1 hUlo hUhi
  have hC := logarithmicSecondConstant_pos
  have he : (U : ℝ)^(-σ)*(U : ℝ) = (U : ℝ)^(1-σ) := by
    calc
      _ = (U : ℝ)^(-σ)*(U : ℝ)^(1 : ℝ) := by rw [Real.rpow_one]
      _ = _ := by rw [←Real.rpow_add hUp]; congr 1; ring
  have hfirst : (U : ℝ)^(-σ)*Real.sqrt |t| ≤ T^(-η/8) := by
    calc
      _ ≤ (U : ℝ)^(-σ)*Real.sqrt T := by gcongr; exact ht.2
      _ = T^(1/2 : ℝ)*(U : ℝ)^(-σ) := by rw [Real.sqrt_eq_rpow]; ring
      _ ≤ _ := hP.1
  have hsecond : (U : ℝ)^(-σ)*((U : ℝ)/Real.sqrt |t|) ≤ 2*T^(-η/8) := by
    have hrec := shell_reciprocal_power T |t| (1/2) hTp ht.1 (by norm_num) (by norm_num)
    norm_num only [neg_div] at hrec
    calc
      _ = ((U : ℝ)^(-σ)*(U : ℝ))*(1/|t|^(1/2 : ℝ)) := by rw [Real.sqrt_eq_rpow]; ring
      _ ≤ ((U : ℝ)^(-σ)*(U : ℝ))*(2*T^(-1/2 : ℝ)) :=
        by
          apply mul_le_mul_of_nonneg_left _ (by positivity)
          convert hrec using 1; norm_num
      _ = 2*(T^(-1/2 : ℝ)*(U : ℝ)^(1-σ)) := by rw [he]; ring
      _ ≤ _ := mul_le_mul_of_nonneg_left hP.2.1 (by norm_num)
  have hc := mul_le_mul_of_nonneg_left (add_le_add hfirst hsecond) hC.le
  dsimp only [secondDerivativeCost]
  nlinarith [hP.2.2]

end Legendre.Density.Moment
