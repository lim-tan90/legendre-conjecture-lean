/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The detection-alternative organization adapts DensityDetectorDichotomy.lean
from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The principal zeta pole is controlled explicitly rather than omitted.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorShift
public import Legendre.Layer4.DetectorPoleBound

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory
open scoped BigOperators

noncomputable def detectorTail (X : ℕ) (s : ℂ) (Y : ℝ) : ℂ :=
  ∑ n ∈ (Finset.Icc 1 ⌊Y⌋₊).filter (fun n => X < n),
    LSeries.term (detectorCoefficient X) s n*detectorWeight (n/Y)

noncomputable def detectorCriticalIntegral (X : ℕ) (s : ℂ) (Y : ℝ) : ℂ :=
  (2*(Real.pi : ℂ))⁻¹*∫ u : ℝ,
    detectorIntegrand X s Y (((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I)

theorem detector_zero_dichotomy (X : ℕ) (hX : 1 ≤ X) {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s = 0) (hσ : 1/2 < s.re) (hσ1 : s.re ≤ 1)
    {Y : ℝ} (hY : 4 ≤ Y) (hpole : ‖detectorPrincipalPole X s Y‖ ≤ 1/16) :
    (1/16 : ℝ) ≤ ‖detectorTail X s Y‖ ∨ (1/16 : ℝ) ≤ ‖detectorCriticalIntegral X s Y‖ := by
  have he : detectorWeight (1/Y) =
      detectorPrincipalPole X s Y+detectorCriticalIntegral X s Y-detectorTail X s Y := by
    have hsplit := detectorMean_split X hX s Y (by linarith)
    have hshift := detectorMean_at_zero X hs hz hσ hσ1 (by linarith : 1 ≤ Y)
    change detectorMean X s Y = detectorWeight (1/Y)+detectorTail X s Y at hsplit
    change detectorMean X s Y = detectorPrincipalPole X s Y+detectorCriticalIntegral X s Y at hshift
    linear_combination hshift-hsplit
  have hw : (1/4 : ℝ) ≤ ‖detectorWeight (1/Y)‖ :=
    (detectorWeight_at_one_div Y hY).trans (Complex.re_le_norm _)
  have hb := norm_sub_le (detectorPrincipalPole X s Y+detectorCriticalIntegral X s Y)
    (detectorTail X s Y)
  rw [← he] at hb
  have hsum := norm_add_le (detectorPrincipalPole X s Y) (detectorCriticalIntegral X s Y)
  by_cases hp : (1/16 : ℝ) ≤ ‖detectorTail X s Y‖
  · exact Or.inl hp
  · right
    have hpt : ‖detectorTail X s Y‖ < 1/16 := lt_of_not_ge hp
    linarith

theorem detector_high_zero_dichotomy (X : ℕ) (hX : 1 ≤ X) {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s = 0) (hσ : 1/2 < s.re) (hσ1 : s.re ≤ 1)
    {T Y : ℝ} (hT : 64 ≤ T) (ht : T ≤ |s.im|) (hXT : (X : ℝ) ≤ 4*T)
    (hY : 4 ≤ Y) (hY2 : Y ≤ T^2) :
    (1/16 : ℝ) ≤ ‖detectorTail X s Y‖ ∨ (1/16 : ℝ) ≤ ‖detectorCriticalIntegral X s Y‖ :=
  detector_zero_dichotomy X hX hs hz hσ hσ1 hY
    (detectorPrincipalPole_small X s hσ.le hT ht hXT (by linarith) hY2)

end Legendre.Density.Detector.Smooth
