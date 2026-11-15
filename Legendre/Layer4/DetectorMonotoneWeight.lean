/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local finite Abel transfer for the actual compact detector smoothing weight.
-/
module
public import Legendre.Layer4.Exponential.WeightedLogBlocks
public import Legendre.Layer4.DetectorPolynomial

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex Set
open scoped BigOperators

noncomputable def realDetectorWeight (x : ℝ) : ℝ := (max (1-x) 0)^2/2

theorem detectorWeight_eq_real (x : ℝ) : detectorWeight x = (realDetectorWeight x : ℂ) := by
  simp only [detectorWeight,realDetectorWeight,Complex.ofReal_div,Complex.ofReal_pow,Complex.ofReal_ofNat]

theorem realDetectorWeight_nonneg (x : ℝ) : 0 ≤ realDetectorWeight x := by
  unfold realDetectorWeight
  positivity

theorem realDetectorWeight_antitone : Antitone realDetectorWeight := by
  intro x y hxy
  have hm : max (1-y) 0 ≤ max (1-x) 0 := max_le_max (by linarith) le_rfl
  exact div_le_div_of_nonneg_right (pow_le_pow_left₀ (le_max_right _ _) hm 2) (by norm_num)

theorem realDetectorWeight_le_one (x : ℝ) (hx : 0 ≤ x) : realDetectorWeight x ≤ 1 := by
  have hm : max (1-x) 0 ≤ (1 : ℝ) := max_le (by linarith) (by norm_num)
  have hs := pow_le_pow_left₀ (le_max_right _ _) hm 2
  unfold realDetectorWeight
  nlinarith

/-- Actual compact smoothing preserves a uniform bound for block prefixes. -/
theorem norm_smoothed_block_of_prefix (U V : ℕ) (hUV : U ≤ V) (Y B : ℝ) (hY : 0 < Y)
    (hB : 0 ≤ B) (a : ℕ → ℂ)
    (hb : ∀ W : ℕ, U ≤ W → W ≤ V → ‖∑ n ∈ Finset.Ioc U W, a n‖ ≤ B) :
    ‖∑ n ∈ Finset.Ioc U V, detectorWeight ((n : ℝ)/Y)*a n‖ ≤ B := by
  have hanti : AntitoneOn (fun n : ℕ => realDetectorWeight ((n : ℝ)/Y)) (Ici (U+1)) := by
    intro i hi j hj hij
    apply realDetectorWeight_antitone
    exact div_le_div_of_nonneg_right (by exact_mod_cast hij) hY.le
  have hh := Oscillation.norm_sum_Ioc_smul_antitone U V hUV
    (fun n => realDetectorWeight ((n : ℝ)/Y)) a B hB (fun n => realDetectorWeight_nonneg _) hanti hb
  have hnorm : ‖∑ n ∈ Finset.Ioc U V, detectorWeight ((n : ℝ)/Y)*a n‖ ≤
      B*realDetectorWeight (((U+1 : ℕ) : ℝ)/Y) := by
    simpa only [detectorWeight_eq_real,Complex.real_smul] using hh
  apply hnorm.trans
  have hw := realDetectorWeight_le_one (((U+1 : ℕ) : ℝ)/Y) (by positivity)
  nlinarith

end Legendre.Density.Detector.Smooth
