/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local balance of the two actual compact-detector alternatives. A generous fixed
logarithmic loss keeps all constants uniform on the closed strip [3/4,1].
-/
module
public import Legendre.Layer4.HuxleyParameters

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem polynomial_alternative_huxley_balanced :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 3/4 ≤ σ → σ ≤ 1 →
      ∀ X : ℕ, 1 ≤ X → T^huxleyMollifierExponent σ ≤ X →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X
        ((β i : ℂ)+(t i : ℂ)*I) (T^huxleyDetectorExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^huxleyBookExponent σ*(1+Real.log T)^36 := by
  obtain ⟨C,hC,hcount⟩ := polynomial_alternative_halasz_count
  refine ⟨8*C*8^22,by positivity,?_⟩
  intro T σ hT hσ hσ1 X hX hxl ι S t β ht hs hβ hw
  have hscale := huxley_detector_scale T σ hT hσ hσ1
  have hL := (height_log_costs T (by linarith)).1
  have hLT := (height_log_costs T (by linarith)).2.2
  have hpoly := huxley_polynomial_powers T X σ (by linarith) hxl hσ hσ1
  have hh := hcount X hX (T^huxleyDetectorExponent σ) T σ (by linarith [hscale.1])
    (by linarith) (by linarith) hσ1 S t β ht hs hβ hw
  have hu : (S.card : ℝ) ≤ (8*C*8^22)*T^huxleyBookExponent σ*(1+Real.log T)^23 := by
    apply hh.trans
    calc
      _ ≤ C*(8*(1+Real.log T))^22*(4*(1+Real.log T))*(2*T^huxleyBookExponent σ) := by
        have hl0 : 0 ≤ 1+Real.log (2*T^huxleyDetectorExponent σ+1) := by
          have := Real.log_nonneg (show 1 ≤ 2*T^huxleyDetectorExponent σ+1 by linarith [hscale.1])
          linarith
        have hLT0 : 0 ≤ 1+Real.log (2*T) := by
          have := Real.log_nonneg (show 1 ≤ 2*T by linarith)
          linarith
        have hp := pow_le_pow_left₀ hl0 hscale.2.2 22
        have hcost := mul_le_mul (mul_le_mul_of_nonneg_left hp hC.le) hLT hLT0 (by positivity)
        exact mul_le_mul hcost hpoly (by positivity) (by positivity)
      _ = _ := by ring
  exact hu.trans (mul_le_mul_of_nonneg_left (pow_le_pow_right₀ hL (by norm_num : (23 : ℕ) ≤ 36))
    (by positivity))

theorem integral_alternative_huxley_balanced :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 3/4 ≤ σ → σ ≤ 1 →
      ∃ X : ℕ, 1 ≤ X ∧ T^huxleyMollifierExponent σ ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X
        ((β i : ℂ)+(t i : ℂ)*I) (T^huxleyDetectorExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^huxleyBookExponent σ*(1+Real.log T)^36 := by
  obtain ⟨C,hC,hcount⟩ := integral_alternative_halasz_dichotomy
  let K := halaszUniformMomentConstant
  let J0 := halaszUniformCoverConstant
  let C3 := 4*C*1024^4*(K*J0)^2
  let C5 := 2*C*1024^4*K
  have hK : 0 < K := by have := halaszUniformMomentConstant_ge_four; dsimp [K]; linarith
  have hJ0 : 0 < J0 := halaszUniformCoverConstant_pos
  have hC3 : 0 < C3 := by dsimp [C3]; positivity
  have hC5 : 0 < C5 := by dsimp [C5]; positivity
  refine ⟨C3+C5+2,by positivity,?_⟩
  intro T σ hT hσ hσ1
  obtain ⟨X,J,hX,hxl,hxu,hX2,hcover,hJ⟩ := huxley_integer_cutoffs T σ (by linarith) hσ hσ1
  refine ⟨X,hX,hxl,hX2,?_⟩
  intro ι S β t ht hs hβ hw
  let L := 1+Real.log T
  let Y := T^huxleyDetectorExponent σ
  let A := Oscillation.criticalPolynomialMomentCost X T
  let R := (S.card : ℝ)
  let M := T^huxleyBookExponent σ
  have hTp : 0 < T := by linarith
  have hL : 1 ≤ L := (height_log_costs T (by linarith)).1
  have hlT : 0 ≤ Real.log T := (height_log_costs T (by linarith)).2.1
  have hlog : Real.log T ≤ L := by dsimp [L]; linarith
  have hY : 1 ≤ Y := by have hh := (huxley_detector_scale T σ hT hσ hσ1).1; dsimp [Y]; linarith
  have hcost : A ≤ K*(X : ℝ)*L^14 := halasz_uniform_moment_cost X hX T (by linarith) hX2
  have hA : 0 ≤ A := by have := Oscillation.criticalPolynomialMomentCost_ge_four X hX T (by linarith); dsimp [A]; linarith
  have hAJ : A*(J : ℝ) ≤ K*J0*(X : ℝ)*L^15 := by
    have hh := mul_le_mul hcost hJ (Nat.cast_nonneg J) (show 0 ≤ K*(X : ℝ)*L^14 by positivity)
    convert hh using 1 <;> dsimp [L,J0] <;> ring
  have hkernel := halasz_uniform_kernel_cost σ Y hσ hY
  have hpower := huxley_integral_power_bounds T X σ (by linarith) (Nat.cast_nonneg X) hxu hσ hσ1
  have hfrac := halasz_uniform_fractional_cost X hX T (by linarith) hX2
  have hc := hcount X J hX hcover T σ Y (by linarith) (by linarith) hY S β t ht hs hβ hw
  have hR : 0 ≤ R := Nat.cast_nonneg _
  have hM : 0 ≤ M := by dsimp [M]; positivity
  have finish (D : ℝ) (hD : 0 ≤ D) (hp : 1 ≤ (5/3 : ℝ))
      (h : R^(5/3 : ℝ) ≤ D*M^(5/3 : ℝ)*L^36) : R ≤ (D+1)*M*L^36 :=
    count_le_of_rpow_log_bound R D M L (5/3) 36 hR hD hM hL hp h
  rcases hc with hc | hc
  · have hcube : R^3 ≤ C3*M^3*L^36 := by
      apply hc.trans
      calc
        _ ≤ C*((1024 : ℝ)^4*Y^(2-4*σ))*T*L^6*(K*J0*(X : ℝ)*L^15)^2 := by
          gcongr
        _ = C*1024^4*(K*J0)^2*(T*(X : ℝ)^2*Y^(2-4*σ))*L^36 := by ring
        _ ≤ C*1024^4*(K*J0)^2*(4*M^3)*L^36 := by
          exact mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hpower.1 (by positivity)) (by positivity)
        _ = _ := by dsimp [C3]; ring
    have hh : R^(3 : ℝ) ≤ C3*M^(3 : ℝ)*L^36 := by simpa only [Real.rpow_ofNat] using hcube
    have hb := count_le_of_rpow_log_bound R C3 M L 3 36 hR hC3.le hM hL (by norm_num) hh
    have hCbound : C3+1 ≤ C3+C5+2 := by linarith
    exact hb.trans (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hCbound hM) (by positivity))
  · have hfive : R^(5/3 : ℝ) ≤ C5*M^(5/3 : ℝ)*L^16 := by
      apply hc.trans
      calc
        _ ≤ C*((1024 : ℝ)^4*Y^(2-4*σ))*T*L^6*
            (K*(X : ℝ)^(2/3 : ℝ)*T^(2/3 : ℝ)*L^10) := by
          gcongr
        _ = C*1024^4*K*(T*(X : ℝ)^(2/3 : ℝ)*T^(2/3 : ℝ)*Y^(2-4*σ))*L^16 := by ring
        _ ≤ C*1024^4*K*(2*M^(5/3 : ℝ))*L^16 := by
          exact mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hpower.2 (by positivity)) (by positivity)
        _ = _ := by dsimp [C5]; ring
    have hLpow := pow_le_pow_right₀ hL (by norm_num : (16 : ℕ) ≤ 36)
    have hu := hfive.trans (mul_le_mul_of_nonneg_left hLpow (by positivity))
    have hb := finish C5 hC5.le (by norm_num) hu
    have hCbound : C5+1 ≤ C3+C5+2 := by linarith
    exact hb.trans (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hCbound hM) (by positivity))

end Legendre.Density.Moment
