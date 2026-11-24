/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityWeightedFourth.lean and DensityWeightedMollifier.lean
in openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
These are actual zeta and Mobius moments, with original vertical ordinates.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.MomentDyadic
public import Legendre.Layer4.ZetaFourthMomentSharp

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set
open scoped ArithmeticFunction.Moebius

theorem weighted_zeta_fourth_moment_of_input (k : ℕ)
    (hinput : ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (∫ t in Icc (-T) T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^k) :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      Integrable (fun t : ℝ => momentHeightWeight T t*
        ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ∧
      (∫ t : ℝ, momentHeightWeight T t*‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^k := by
  obtain ⟨C,hC,hb⟩ := hinput
  refine ⟨C*momentHeightEnergyConstant k,mul_pos hC (momentHeightEnergyConstant_pos k),?_⟩
  intro T hT
  let A := C*T*(Real.log T)^k
  have hlogT : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have hball (j : ℕ) : (∫ t in momentHeightBall T j,
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤ A*(2 : ℝ)^j*(j+1 : ℝ)^k := by
    have hp : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
    have hH : 2 ≤ (2 : ℝ)^j*T := by nlinarith
    have hh := hb ((2 : ℝ)^j*T) hH
    change (∫ t in Icc (-((2 : ℝ)^j*T)) ((2 : ℝ)^j*T), _) ≤ _
    apply hh.trans
    have hlog := dyadic_height_log T hT j
    have hlog0 : 0 ≤ Real.log ((2 : ℝ)^j*T) := Real.log_nonneg (by linarith)
    calc
      _ ≤ C*((2 : ℝ)^j*T)*((j+1 : ℝ)*Real.log T)^k :=
        mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hlog0 hlog k) (by positivity)
      _ = _ := by rw [mul_pow]; dsimp [A]; ring
  obtain ⟨hi,hm⟩ := moment_weighted_moment
    (fun t : ℝ => ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4)
    (zeta_critical_continuous.norm.pow 4) (fun _ => by positivity)
    T (by linarith) A (by dsimp [A]; positivity) k hball
  refine ⟨hi,hm.trans_eq ?_⟩
  dsimp [A]
  ring

theorem weighted_zeta_fourth_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      Integrable (fun t : ℝ => momentHeightWeight T t*
        ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ∧
      (∫ t : ℝ, momentHeightWeight T t*‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^6 :=
  weighted_zeta_fourth_moment_of_input 6 Zeta.zeta_fourth_moment_log_six

theorem weighted_zeta_fourth_moment_log_four :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      Integrable (fun t : ℝ => momentHeightWeight T t*
        ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ∧
      (∫ t : ℝ, momentHeightWeight T t*‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^4 :=
  weighted_zeta_fourth_moment_of_input 4 Zeta.zeta_fourth_moment_symmetric_log_four

theorem weighted_mollifier_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 2 ≤ T →
      Integrable (fun t : ℝ => momentHeightWeight T t*
        ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^2) ∧
      (∫ t : ℝ, momentHeightWeight T t*
        ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^2) ≤
          C*((X : ℝ)+T)*(1+Real.log X) := by
  obtain ⟨C,hC,hb⟩ := critical_mollifier_mean
  refine ⟨C*momentHeightEnergyConstant 0,mul_pos hC (momentHeightEnergyConstant_pos 0),?_⟩
  intro X hX T hT
  have hl0 : 0 ≤ Real.log X := Real.log_nonneg (by exact_mod_cast hX)
  let A := C*((X : ℝ)+T)*(1+Real.log X)
  have hball (j : ℕ) : (∫ t in momentHeightBall T j,
      ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^2) ≤
        A*(2 : ℝ)^j*(j+1 : ℝ)^0 := by
    have hp : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
    have hH : 1 ≤ (2 : ℝ)^j*T := by nlinarith
    have hh := hb X hX ((2 : ℝ)^j*T) hH
    change (∫ t in Icc (-((2 : ℝ)^j*T)) ((2 : ℝ)^j*T), _) ≤ _
    apply hh.trans
    have hsize : (X : ℝ)+(2 : ℝ)^j*T ≤ ((X : ℝ)+T)*(2 : ℝ)^j := by
      have h := mul_le_mul_of_nonneg_left hp (Nat.cast_nonneg X : (0 : ℝ) ≤ X)
      nlinarith
    calc
      _ ≤ C*(((X : ℝ)+T)*(2 : ℝ)^j)*(1+Real.log X) :=
        mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hsize hC.le) (by positivity)
      _ = _ := by dsimp [A]; ring
  obtain ⟨hi,hm⟩ := moment_weighted_moment
    (fun t : ℝ => ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^2)
    ((mollifier_critical_continuous X).norm.pow 2) (fun _ => sq_nonneg _)
    T (by linarith) A (by dsimp [A]; positivity) 0 hball
  refine ⟨hi,hm.trans_eq ?_⟩
  dsimp [A]
  ring

end Legendre.Density.Moment
