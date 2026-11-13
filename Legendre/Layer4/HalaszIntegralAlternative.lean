/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deduction of the improved integral alternative from actual critical
integrals and the proved cardinality-sensitive critical-mass moment.
-/
module
public import Legendre.Layer4.HalaszCriticalMass
public import Legendre.Layer4.IntegralAlternative

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem real_rpow_square (x a : ℝ) (hx : 0 ≤ x) : (x^a)^2 = x^(2*a) := by
  rw [←Real.rpow_natCast,←Real.rpow_mul hx]
  congr 1
  ring

theorem halasz_moment_square (A R Q : ℝ) (hR : 0 ≤ R) (hQ : 0 ≤ Q) :
    (4*A+5*R^(2/3 : ℝ)*Q^(1/3 : ℝ))^2 ≤
      32*A^2+50*R^(4/3 : ℝ)*Q^(2/3 : ℝ) := by
  have hRpow : (R^(2/3 : ℝ))^2 = R^(4/3 : ℝ) := by rw [real_rpow_square R _ hR]; norm_num
  have hQpow : (Q^(1/3 : ℝ))^2 = Q^(2/3 : ℝ) := by rw [real_rpow_square Q _ hQ]; norm_num
  have hh := sq_nonneg (4*A-5*R^(2/3 : ℝ)*Q^(1/3 : ℝ))
  nlinarith [sq_nonneg A]

theorem mixed_power_count_dichotomy (R D0 D1 : ℝ) (hR : 0 ≤ R) (hD0 : 0 ≤ D0)
    (h : R^3 ≤ D0+D1*R^(4/3 : ℝ)) :
    R^3 ≤ 2*D0 ∨ R^(5/3 : ℝ) ≤ 2*D1 := by
  by_cases hh : R^3 ≤ 2*D0
  · exact Or.inl hh
  · right
    have hRp : 0 < R := by
      by_contra hz
      have he : R = 0 := le_antisymm (le_of_not_gt hz) hR
      rw [he] at hh
      norm_num at hh
      linarith
    have hp : 0 < R^(4/3 : ℝ) := Real.rpow_pos_of_pos hRp _
    have he : R^3 = R^(4/3 : ℝ)*R^(5/3 : ℝ) := by
      rw [←Real.rpow_add hRp]
      norm_num
    have hc : R^3 ≤ 2*D1*R^(4/3 : ℝ) := by linarith
    rw [he] at hc
    exact (mul_le_mul_iff_right₀ hp).mp (by simpa only [mul_comm] using hc)

theorem critical_integral_count_lower {ι : Type*} (S : Finset ι) (β t : ι → ℝ)
    (X : ℕ) (σ Y : ℝ) (hσ : 1/2 < σ) (hY : 1 ≤ Y)
    (hβ : ∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1)
    (hw : ∀ i ∈ S, (1/16 : ℝ) ≤
      ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) Y‖) :
    (S.card : ℝ) ≤ (256*Y^(1/2-σ)/(σ-1/2))*∑ i ∈ S, Detector.Smooth.criticalMass X (t i) := by
  have hh : (∑ _i ∈ S, (1/16 : ℝ)) ≤
      ∑ i ∈ S, (16*Y^(1/2-σ)/(σ-1/2))*Detector.Smooth.criticalMass X (t i) := by
    apply Finset.sum_le_sum
    intro i hi
    have hp := Detector.Smooth.detectorCriticalIntegral_uniform_bound X ((β i : ℂ)+(t i : ℂ)*I)
      hσ (by simpa using (hβ i hi).1) (by simpa using (hβ i hi).2) hY
    exact (hw i hi).trans (by simpa using hp)
  simp only [Finset.sum_const,nsmul_eq_mul,←Finset.mul_sum] at hh
  have hm := mul_le_mul_of_nonneg_left hh (by norm_num : (0 : ℝ) ≤ 16)
  convert hm using 1 <;> ring

/-- Actual critical integrals give the two cardinality powers needed by Huxley balance. -/
theorem integral_alternative_halasz_dichotomy :
    ∃ C : ℝ, 0 < C ∧ ∀ X J : ℕ, 1 ≤ X → X ≤ 2^J → ∀ T σ Y : ℝ,
      2 ≤ T → 1/2 < σ → 1 ≤ Y → ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ)^3 ≤ C*(256*Y^(1/2-σ)/(σ-1/2))^4*T*(Real.log T)^6*
          (Oscillation.criticalPolynomialMomentCost X T*(J : ℝ))^2 ∨
      (S.card : ℝ)^(5/3 : ℝ) ≤ C*(256*Y^(1/2-σ)/(σ-1/2))^4*T*(Real.log T)^6*
          (Oscillation.criticalPolynomialMomentCost X T*T)^(2/3 : ℝ) := by
  obtain ⟨C,hC,hpacked⟩ := packed_critical_mass_halasz
  refine ⟨100*C,by positivity,?_⟩
  intro X J hX hcover T σ Y hT hσ hY ι S β t ht hs hβ hw
  let R := (S.card : ℝ)
  let A := Oscillation.criticalPolynomialMomentCost X T
  let K := 256*Y^(1/2-σ)/(σ-1/2)
  let D := C*K^4*T*(Real.log T)^6
  have hA : 0 ≤ A := by have := Oscillation.criticalPolynomialMomentCost_ge_four X hX T (by linarith); dsimp [A]; linarith
  have hR : 0 ≤ R := Nat.cast_nonneg _
  have hD : 0 ≤ D := by dsimp [D]; positivity
  have hlower := critical_integral_count_lower S β t X σ Y hσ hY hβ hw
  have hfourth := hpacked X J hX hcover T hT S t ht hs
  have hc : R^3 ≤ D*(halaszMollifierMomentBound X J T R)^2 := by
    have hh := count_cube R (∑ i ∈ S, Detector.Smooth.criticalMass X (t i)) K
      (C*T*(Real.log T)^6*(halaszMollifierMomentBound X J T R)^2) hR (by positivity) hlower
      (by convert hfourth using 1 <;> dsimp [R] <;> ring)
    convert hh using 1 <;> dsimp [D] <;> ring
  have hm := halasz_moment_square (A*(J : ℝ)) R (A*T) hR (by positivity)
  have hm' : (halaszMollifierMomentBound X J T R)^2 ≤
      32*(A*(J : ℝ))^2+50*R^(4/3 : ℝ)*(A*T)^(2/3 : ℝ) := by
    convert hm using 1 <;> dsimp [halaszMollifierMomentBound,A] <;> ring
  have hu : R^3 ≤ 32*D*(A*(J : ℝ))^2+(50*D*(A*T)^(2/3 : ℝ))*R^(4/3 : ℝ) := by
    have hh := hc.trans (mul_le_mul_of_nonneg_left hm' hD)
    convert hh using 1 <;> dsimp [halaszMollifierMomentBound,A] <;> ring
  rcases mixed_power_count_dichotomy R (32*D*(A*(J : ℝ))^2)
    (50*D*(A*T)^(2/3 : ℝ)) hR (by positivity) hu with hfirst | hsecond
  · left
    have hh : 2*(32*D*(A*(J : ℝ))^2) ≤ 100*D*(A*(J : ℝ))^2 := by
      nlinarith [mul_nonneg hD (sq_nonneg (A*(J : ℝ)))]
    convert hfirst.trans hh using 1 <;> dsimp [D,K,A,R] <;> ring
  · right
    convert hsecond using 1 <;> dsimp [D,K,A,R] <;> ring

end Legendre.Density.Moment
