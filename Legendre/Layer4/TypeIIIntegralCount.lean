/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local actual Type II detector estimates. Individual fourth powers are summed
before applying the packed zeta moment; no zero-density estimate is assumed.
-/
module
public import Legendre.Layer4.IndividualCriticalFourth
public import Legendre.Layer4.HalaszIntegralAlternative
public import Legendre.Layer4.HalaszUniformCosts
public import Legendre.ZeroDensity

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- The literal critical-integral alternative has a linear sample-cardinality bound. -/
theorem integral_alternative_individual_fourth_count :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, ∀ T σ Y : ℝ, 2 ≤ T → 1/2 < σ → 1 ≤ Y →
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ) ≤ C*(256*Y^(1/2-σ)/(σ-1/2))^4*(X : ℝ)^4*T*(Real.log T)^6 := by
  obtain ⟨C,hC,hfourth⟩ := sum_critical_mass_fourth
  refine ⟨C,hC,?_⟩
  intro X T σ Y hT hσ hY ι S β t ht hs hβ hw
  let K := 256*Y^(1/2-σ)/(σ-1/2)
  have hlower (i : ι) (hi : i ∈ S) : 1 ≤ K*Detector.Smooth.criticalMass X (t i) := by
    have hh := Detector.Smooth.detectorCriticalIntegral_uniform_bound X ((β i : ℂ)+(t i : ℂ)*I)
      hσ (by simpa using (hβ i hi).1) (by simpa using (hβ i hi).2) hY
    have hm := mul_le_mul_of_nonneg_left ((hw i hi).trans (by simpa using hh))
      (by norm_num : (0 : ℝ) ≤ 16)
    convert hm using 1 <;> (try dsimp [K]) <;> ring
  have hpow (i : ι) (hi : i ∈ S) : (1 : ℝ) ≤ K^4*(Detector.Smooth.criticalMass X (t i))^4 := by
    have hh := pow_le_pow_left₀ zero_le_one (hlower i hi) 4
    simpa only [one_pow,mul_pow] using hh
  have hsum := Finset.sum_le_sum hpow
  simp only [Finset.sum_const,nsmul_eq_mul,mul_one,←Finset.mul_sum] at hsum
  have hup := mul_le_mul_of_nonneg_left (hfourth X T hT S t ht hs)
    (show 0 ≤ K^4 by positivity)
  apply hsum.trans
  convert hup using 1 <;> dsimp [K] <;> ring

/-- At detector scale sqrt(T), a small mollifier produces the classical Type II exponent. -/
theorem integral_alternative_sqrt_height_count :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, ∀ T σ : ℝ, 2 ≤ T → 3/4 ≤ σ →
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖) →
      (S.card : ℝ) ≤ C*(X : ℝ)^4*T^(2-2*σ)*(Real.log T)^6 := by
  obtain ⟨C,hC,hcount⟩ := integral_alternative_individual_fourth_count
  refine ⟨C*1024^4,by positivity,?_⟩
  intro X T σ hT hσ ι S β t ht hs hβ hw
  have hTp : 0 < T := by linarith
  have hY : 1 ≤ T^(1/2 : ℝ) := Real.one_le_rpow (by linarith) (by norm_num)
  have hk := halasz_uniform_kernel_cost σ (T^(1/2 : ℝ)) hσ hY
  have hc := hcount X T σ (T^(1/2 : ℝ)) hT (by linarith) hY S β t ht hs hβ hw
  have he : T*(T^(1/2 : ℝ))^(2-4*σ) = T^(2-2*σ) := by
    rw [←Real.rpow_mul hTp.le]
    conv_lhs => lhs; rw [←Real.rpow_one T]
    rw [←Real.rpow_add hTp]
    congr 1; ring
  apply hc.trans
  calc
    _ ≤ C*((1024 : ℝ)^4*(T^(1/2 : ℝ))^(2-4*σ))*(X : ℝ)^4*T*(Real.log T)^6 := by gcongr
    _ = (C*1024^4)*(X : ℝ)^4*(T*(T^(1/2 : ℝ))^(2-4*σ))*(Real.log T)^6 := by ring
    _ = _ := by rw [he]

/-- All constants are uniform in sigma and in the small-cutoff exponent delta. -/
theorem integral_alternative_small_cutoff_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ δ T σ : ℝ,
      0 ≤ δ → 2 ≤ T → 3/4 ≤ σ → ∀ X : ℕ, (X : ℝ) ≤ 2*T^δ →
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖) →
      (S.card : ℝ) ≤ C*T^(2-2*σ+4*δ+ε) := by
  intro ε hε
  obtain ⟨C,hC,hcount⟩ := integral_alternative_sqrt_height_count
  obtain ⟨D,hD,hlog⟩ := Zeta.exists_log_pow_le_rpow 6 hε
  refine ⟨16*C*D,by positivity,?_⟩
  intro δ T σ hδ hT hσ X hX ι S β t ht hs hβ hw
  have hTp : 0 < T := by linarith
  have hx4 : (X : ℝ)^4 ≤ 16*T^(4*δ) := by
    have hh := pow_le_pow_left₀ (Nat.cast_nonneg X : (0 : ℝ) ≤ X) hX 4
    have he : (T^δ)^4 = T^(4*δ) := by
      rw [←Real.rpow_natCast,←Real.rpow_mul hTp.le]
      congr 1
      ring
    simpa only [mul_pow,he,show (2 : ℝ)^4 = 16 by norm_num] using hh
  have hc := hcount X T σ hT hσ S β t ht hs hβ hw
  calc
    _ ≤ C*(X : ℝ)^4*T^(2-2*σ)*(Real.log T)^6 := hc
    _ ≤ C*(16*T^(4*δ))*T^(2-2*σ)*(D*T^ε) := by
      exact mul_le_mul (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hx4 hC.le)
        (by positivity)) (hlog T hT) (by positivity) (by positivity)
    _ = _ := by rw [Real.rpow_add hTp,Real.rpow_add hTp]; ring

end Legendre.Density.Moment
