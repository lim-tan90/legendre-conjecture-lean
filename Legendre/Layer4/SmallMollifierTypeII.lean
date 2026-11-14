/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local actual Type II zero-family count, with a chosen small integer mollifier.
The compact detector's principal pole and literal tail threshold are retained.
-/
module
public import Legendre.Layer4.TypeIIIntegralCount
public import Legendre.Layer4.DetectorAlternative

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem sqrt_detector_scale (T : ℝ) (hT : 128 ≤ T) :
    4 ≤ T^(1/2 : ℝ) ∧ T^(1/2 : ℝ) ≤ (T/2)^2 := by
  have hTp : 0 < T := by linarith
  constructor
  · have hh : 4 ≤ Real.sqrt T := Real.le_sqrt_of_sq_le (by linarith)
    simpa only [Real.sqrt_eq_rpow] using hh
  · have hh := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith)
      (by norm_num : (1/2 : ℝ) ≤ 1)
    rw [Real.rpow_one] at hh
    have hmax : T ≤ (T/2)^2 := by nlinarith
    exact hh.trans hmax

theorem small_integer_mollifier (T δ : ℝ) (hT : 2 ≤ T) (hδ : 0 ≤ δ) (hδ1 : δ ≤ 1) :
    ∃ X : ℕ, 1 ≤ X ∧ T^δ ≤ X ∧ (X : ℝ) ≤ 2*T^δ ∧ (X : ℝ) ≤ 2*T := by
  let X := ⌈T^δ⌉₊
  have hp : 1 ≤ T^δ := Real.one_le_rpow (by linarith) hδ
  have hxl : T^δ ≤ X := Nat.le_ceil _
  have hX : 1 ≤ X := by exact_mod_cast hp.trans hxl
  have hxu : (X : ℝ) ≤ 2*T^δ := by
    have hh := Nat.ceil_lt_add_one (show 0 ≤ T^δ by positivity)
    change (X : ℝ) < T^δ+1 at hh
    linarith
  have hupper := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith) hδ1
  rw [Real.rpow_one] at hupper
  exact ⟨X,hX,hxl,hxu,by linarith⟩

/-- Actual zeros outside the polynomial branch satisfy the improved integral count. -/
theorem actual_typeII_given_cutoff_count :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ δ T σ : ℝ,
      0 ≤ δ → 128 ≤ T → 3/4 ≤ σ → ∀ X : ℕ, 1 ≤ X →
      (X : ℝ) ≤ 2*T → (X : ℝ) ≤ 2*T^δ →
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (∀ i ∈ S, ¬(1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖) →
      (S.card : ℝ) ≤ C*T^(2-2*σ+4*δ+ε) := by
  intro ε hε
  obtain ⟨C,hC,hcount⟩ := integral_alternative_small_cutoff_epsilon ε hε
  refine ⟨C,hC,?_⟩
  intro δ T σ hδ hT hσ X hX hX2 hxu ι S β t ht hs hz hnot
  have hscale := sqrt_detector_scale T hT
  have hlarge (i : ι) (hi : i ∈ S) :
      (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X
        ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖ := by
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

/-- The chosen cutoff works uniformly for every sigma and actual high zero family. -/
theorem actual_typeII_small_mollifier_count :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 128 ≤ T →
      ∃ X : ℕ, 1 ≤ X ∧ (X : ℝ) ≤ 2*T ∧ ∀ σ : ℝ, 3/4 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (∀ i ∈ S, ¬(1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖) →
      (S.card : ℝ) ≤ C*T^(2-2*σ+ε) := by
  intro ε hε
  obtain ⟨C,hC,hcount⟩ := actual_typeII_given_cutoff_count (ε/2) (by linarith)
  let δ := min (ε/8) (1/2)
  have hδ : 0 < δ := lt_min (by linarith) (by norm_num)
  have hδ1 : δ ≤ 1 := (min_le_right _ _).trans (by norm_num)
  have hδε : 4*δ+ε/2 ≤ ε := by
    have hh : δ ≤ ε/8 := min_le_left _ _
    linarith
  refine ⟨C,hC,?_⟩
  intro T hT
  obtain ⟨X,hX,hxl,hxu,hX2⟩ := small_integer_mollifier T δ (by linarith) hδ.le hδ1
  refine ⟨X,hX,hX2,?_⟩
  intro σ hσ hσ1 ι S β t ht hs hz hnot
  have hc := hcount δ T σ hδ.le hT hσ X hX hX2 hxu S β t ht hs hz hnot
  apply hc.trans
  apply mul_le_mul_of_nonneg_left _ hC.le
  exact Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T) (by linarith)

end Legendre.Density.Moment
