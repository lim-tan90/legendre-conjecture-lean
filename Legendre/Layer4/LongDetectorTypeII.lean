/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local actual Type II count at the longer detector scale Y=T.
All principal-pole constraints and the literal polynomial threshold are retained.
-/
module
public import Legendre.Layer4.SmallMollifierTypeII

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem linear_detector_scale (T : ℝ) (hT : 128 ≤ T) : 4 ≤ T ∧ T ≤ (T/2)^2 := by
  constructor
  · linarith
  · nlinarith

/-- The general individual-fourth estimate at Y=T has height exponent 3-4 sigma. -/
theorem integral_alternative_linear_height_count :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, ∀ T σ : ℝ, 2 ≤ T → 3/4 ≤ σ →
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) T‖) →
      (S.card : ℝ) ≤ C*(X : ℝ)^4*T^(3-4*σ)*(Real.log T)^6 := by
  obtain ⟨C,hC,hcount⟩ := integral_alternative_individual_fourth_count
  refine ⟨C*1024^4,by positivity,?_⟩
  intro X T σ hT hσ ι S β t ht hs hβ hw
  have hTp : 0 < T := by linarith
  have hk := halasz_uniform_kernel_cost σ T hσ (by linarith)
  have hc := hcount X T σ T hT (by linarith) (by linarith) S β t ht hs hβ hw
  have he : T*T^(2-4*σ) = T^(3-4*σ) := by
    conv_lhs => lhs; rw [←Real.rpow_one T]
    rw [←Real.rpow_add hTp]
    congr 1
    ring
  apply hc.trans
  calc
    _ ≤ C*((1024 : ℝ)^4*T^(2-4*σ))*(X : ℝ)^4*T*(Real.log T)^6 := by gcongr
    _ = (C*1024^4)*(X : ℝ)^4*(T*T^(2-4*σ))*(Real.log T)^6 := by ring
    _ = _ := by rw [he]

/-- The small-cutoff cost is explicit, with one constant uniform in sigma and delta. -/
theorem integral_alternative_linear_cutoff_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ δ T σ : ℝ,
      0 ≤ δ → 2 ≤ T → 3/4 ≤ σ → ∀ X : ℕ, (X : ℝ) ≤ 2*T^δ →
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) T‖) →
      (S.card : ℝ) ≤ C*T^(3-4*σ+4*δ+ε) := by
  intro ε hε
  obtain ⟨C,hC,hcount⟩ := integral_alternative_linear_height_count
  obtain ⟨D,hD,hlog⟩ := Zeta.exists_log_pow_le_rpow 6 hε
  refine ⟨16*C*D,by positivity,?_⟩
  intro δ T σ hδ hT hσ X hX ι S β t ht hs hβ hw
  have hTp : 0 < T := by linarith
  have hx4 : (X : ℝ)^4 ≤ 16*T^(4*δ) := by
    have hh := pow_le_pow_left₀ (Nat.cast_nonneg X : (0 : ℝ) ≤ X) hX 4
    have he : (T^δ)^4 = T^(4*δ) := by
      rw [←Real.rpow_natCast (T^δ) 4,←Real.rpow_mul hTp.le]
      congr 1
      ring
    simpa only [mul_pow,he,show (2 : ℝ)^4 = 16 by norm_num] using hh
  have hc := hcount X T σ hT hσ S β t ht hs hβ hw
  calc
    _ ≤ C*(X : ℝ)^4*T^(3-4*σ)*(Real.log T)^6 := hc
    _ ≤ C*(16*T^(4*δ))*T^(3-4*σ)*(D*T^ε) := by
      exact mul_le_mul (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hx4 hC.le)
        (by positivity)) (hlog T hT) (by positivity) (by positivity)
    _ = _ := by rw [Real.rpow_add hTp,Real.rpow_add hTp]; ring

/-- Actual high zeros outside the polynomial branch satisfy the longer-scale bound. -/
theorem actual_typeII_linear_cutoff_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ δ T σ : ℝ,
      0 ≤ δ → 128 ≤ T → 3/4 ≤ σ → ∀ X : ℕ, 1 ≤ X →
      (X : ℝ) ≤ 2*T → (X : ℝ) ≤ 2*T^δ →
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (∀ i ∈ S, ¬(1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) T‖) →
      (S.card : ℝ) ≤ C*T^(3-4*σ+4*δ+ε) := by
  intro ε hε
  obtain ⟨C,hC,hcount⟩ := integral_alternative_linear_cutoff_epsilon ε hε
  refine ⟨C,hC,?_⟩
  intro δ T σ hδ hT hσ X hX hX2 hxu ι S β t ht hs hz hnot
  have hscale := linear_detector_scale T hT
  have hlarge (i : ι) (hi : i ∈ S) :
      (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) T‖ := by
    have hzi := hz i hi
    have hs1 : (β i : ℂ)+(t i : ℂ)*I ≠ 1 := by
      intro he
      have hh := congrArg Complex.im he
      simp at hh
      have hlow := (ht i hi).1
      rw [hh,abs_zero] at hlow
      linarith
    have hd := Detector.Smooth.detector_high_zero_dichotomy X hX hs1 hzi.2.2
      (by simpa using lt_of_lt_of_le (show 1/2 < σ by linarith) hzi.1)
      (by simpa using hzi.2.1) (T := T/2) (by linarith) (by simpa using (ht i hi).1)
      (by linarith : (X : ℝ) ≤ 4*(T/2)) hscale.1 hscale.2
    exact hd.resolve_left (hnot i hi)
  exact hcount δ T σ hδ (by linarith) hσ X hxu S β t
    (fun i hi => (ht i hi).2) hs
    (fun i hi => ⟨(hz i hi).1,(hz i hi).2.1⟩) hlarge

end Legendre.Density.Moment
