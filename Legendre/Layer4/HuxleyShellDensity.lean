/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The finite branch assembly reuses SeparatedShellDensity.lean in this repository,
originally adapted from DensitySeparatedCount.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The local Halasz branch estimates now use the global 12/5 balance.
The actual high-ordinate shell retains all principal-pole constraints.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.HuxleyBalancedAlternatives

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem huxley_separated_high_shell_density :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 3/4 ≤ σ → σ ≤ 1 → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^huxleyBookExponent σ*(1+Real.log T)^36 := by
  classical
  obtain ⟨CP,hCP,hp⟩ := polynomial_alternative_huxley_balanced
  obtain ⟨CI,hCI,hi⟩ := integral_alternative_huxley_balanced
  refine ⟨CP+CI,by positivity,?_⟩
  intro T σ hT hσ hσ1 ι S t β ht hs hz
  obtain ⟨X,hX,hTX,hX2,hiX⟩ := hi T σ (by linarith) hσ hσ1
  let Y := T^huxleyDetectorExponent σ
  let p : ι → Prop := fun i => (1/16 : ℝ) ≤
    ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖
  let P := S.filter p
  let N := S.filter (fun i => ¬p i)
  have hY4 : 4 ≤ Y := (huxley_detector_scale T σ hT hσ hσ1).1
  have hY2 : Y ≤ (T/2)^2 := (huxley_detector_scale T σ hT hσ hσ1).2.1
  have hP := hp T σ (by linarith) hσ hσ1 X hX hTX P t β
    (fun i hi => (ht i (Finset.mem_filter.mp hi).1).2)
    (fun i hi j hj => hs i (Finset.mem_filter.mp hi).1 j (Finset.mem_filter.mp hj).1)
    (fun i hi => ⟨(hz i (Finset.mem_filter.mp hi).1).1,(hz i (Finset.mem_filter.mp hi).1).2.1⟩)
    (fun _ hi => (Finset.mem_filter.mp hi).2)
  have hNlarge (i : ι) (hiN : i ∈ N) :
      (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) Y‖ := by
    obtain ⟨hiS,hn⟩ := Finset.mem_filter.mp hiN
    have hzi := hz i hiS
    have hs1 : (β i : ℂ)+(t i : ℂ)*I ≠ 1 := by
      intro he
      have hh := congrArg Complex.im he
      simp at hh
      have hlower := (ht i hiS).1
      rw [hh,abs_zero] at hlower
      linarith
    have hd := Detector.Smooth.detector_high_zero_dichotomy X hX hs1 hzi.2.2
      (by simpa using lt_of_lt_of_le (show 1/2 < σ by linarith) hzi.1) (by simpa using hzi.2.1)
      (T := T/2) (by linarith) (by simpa using (ht i hiS).1)
      (by linarith : (X : ℝ) ≤ 4*(T/2)) hY4 hY2
    exact hd.resolve_left hn
  have hN := hiX N β t
    (fun i hi => (ht i (Finset.mem_filter.mp hi).1).2)
    (fun i hi j hj => hs i (Finset.mem_filter.mp hi).1 j (Finset.mem_filter.mp hj).1)
    (fun i hi => ⟨(hz i (Finset.mem_filter.mp hi).1).1,(hz i (Finset.mem_filter.mp hi).1).2.1⟩) hNlarge
  have hcard : (S.card : ℝ) = (P.card : ℝ)+(N.card : ℝ) := by
    exact_mod_cast (Finset.card_filter_add_card_filter_not (s := S) (p := p)).symm
  rw [hcard]
  have hh := add_le_add hP hN
  convert hh using 1
  ring

end Legendre.Density.Moment
