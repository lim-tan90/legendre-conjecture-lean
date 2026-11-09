/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityIntegralAlternative.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The compensated zeta detector has threshold 1/16, giving the factor 256.
The analytic hypotheses describe literal integral values, not a density axiom.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.PackedCriticalMass

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory
open scoped BigOperators

theorem count_cube (R I K D : ℝ) (hR : 0 ≤ R) (hD : 0 ≤ D)
    (hlower : R ≤ K*I) (hfourth : I^4 ≤ R*D) : R^3 ≤ K^4*D := by
  by_cases hzero : R = 0
  · simpa only [hzero,zero_pow (by decide : (3 : ℕ) ≠ 0)] using
      mul_nonneg (by positivity : 0 ≤ K^4) hD
  · have hpos : 0 < R := lt_of_le_of_ne hR (Ne.symm hzero)
    have hp := pow_le_pow_left₀ hR hlower 4
    rw [mul_pow] at hp
    have hu := mul_le_mul_of_nonneg_left hfourth (by positivity : 0 ≤ K^4)
    have hh : R*R^3 ≤ R*(K^4*D) := by nlinarith
    exact (mul_le_mul_iff_right₀ hpos).mp (by simpa only [mul_comm R] using hh)

theorem integral_alternative_count :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T σ Y : ℝ,
      2 ≤ T → 1/2 < σ → 1 ≤ Y → ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ)^3 ≤ C*(256*Y^(1/2-σ)/(σ-1/2))^4*T*((X : ℝ)+T)^2*
        (Real.log T)^6*(1+Real.log X)^2 := by
  obtain ⟨C,hC,hb⟩ := packed_critical_mass_fourth
  refine ⟨C,hC,?_⟩
  intro X hX T σ Y hT hσ hY ι S β t ht hsep hβ hlarge
  let I0 := ∑ i ∈ S, Detector.Smooth.criticalMass X (t i)
  let K := 256*Y^(1/2-σ)/(σ-1/2)
  let D := C*T*((X : ℝ)+T)^2*(Real.log T)^6*(1+Real.log X)^2
  have hlower : (S.card : ℝ) ≤ K*I0 := by
    have hsum : (∑ _i ∈ S, (1/16 : ℝ)) ≤
        ∑ i ∈ S, (16*Y^(1/2-σ)/(σ-1/2))*Detector.Smooth.criticalMass X (t i) := by
      apply Finset.sum_le_sum
      intro i hi
      have hm := Detector.Smooth.detectorCriticalIntegral_uniform_bound X
        ((β i : ℂ)+(t i : ℂ)*I) hσ (by simpa using (hβ i hi).1)
        (by simpa using (hβ i hi).2) hY
      exact (hlarge i hi).trans (by simpa using hm)
    simp only [Finset.sum_const,nsmul_eq_mul,← Finset.mul_sum] at hsum
    have hh := mul_le_mul_of_nonneg_left hsum (by norm_num : (0 : ℝ) ≤ 16)
    convert hh using 1
    · ring
    · dsimp [K,I0]
      ring
  have hfourth : I0^4 ≤ (S.card : ℝ)*D := by
    have h := hb X hX T hT S t ht hsep
    change I0^4 ≤ _ at h
    convert h using 1
    dsimp [D]
    ring
  have hm := count_cube (S.card : ℝ) I0 K D (Nat.cast_nonneg _) (by dsimp [D]; positivity)
    hlower hfourth
  convert hm using 1
  dsimp [K,D]
  ring

end Legendre.Density.Moment
