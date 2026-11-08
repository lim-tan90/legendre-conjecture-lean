/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorSeries.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The compact support cutoff is independent of the height parameter.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorProduct
public import Legendre.Layer4.DetectorKernel

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory Set
open scoped BigOperators Classical

noncomputable def detectorMean (X : ℕ) (s : ℂ) (Y : ℝ) : ℂ :=
  ∑ n ∈ Finset.Icc 1 ⌊Y⌋₊, LSeries.term (detectorCoefficient X) s n*detectorWeight (n/Y)

 theorem detectorMean_split (X : ℕ) (hX : 1 ≤ X)
    (s : ℂ) (Y : ℝ) (hY : 1 ≤ Y) :
    detectorMean X s Y = detectorWeight (1 / Y) +
      ∑ n ∈ (Finset.Icc 1 ⌊Y⌋₊).filter (fun n => X < n),
        LSeries.term (detectorCoefficient X) s n * detectorWeight (n / Y) := by
  let U := Finset.Icc 1 ⌊Y⌋₊
  have h1 : 1 ∈ U := Finset.mem_Icc.mpr ⟨le_rfl, (Nat.le_floor_iff (by linarith : 0 ≤ Y)).mpr (by simpa using hY)⟩
  have hf : ∑ n ∈ U, LSeries.term (detectorCoefficient X) s n * detectorWeight (n / Y) =
      ∑ n ∈ U, ((if n = 1 then detectorWeight (1 / Y) else 0) +
        (if X < n then LSeries.term (detectorCoefficient X) s n *
          detectorWeight (n / Y) else 0)) := by
    apply Finset.sum_congr rfl
    intro n hn
    by_cases hn1 : n = 1
    · subst n
      simp [detectorCoefficient_one hX,
        LSeries.term_of_ne_zero, show ¬ X < 1 by omega]
    · by_cases hnX : X < n
      · simp [hn1, hnX]
      · have hn2 : 2 ≤ n := by have := (Finset.mem_Icc.mp hn).1; omega
        have hz := detectorCoefficient_small hn2 (by omega : n ≤ X)
        simp [hn1, hnX, LSeries.term_of_ne_zero (show n ≠ 0 by omega),
          hz]
  unfold detectorMean
  rw [hf, Finset.sum_add_distrib]
  simp only [Finset.sum_ite_eq', h1, ↓reduceIte, Finset.sum_filter]
  rfl

 theorem detectorMean_tsum (X : ℕ) (s : ℂ)
    (Y : ℝ) (hY : 0 < Y) :
    detectorMean X s Y = ∑' n : ℕ,
      LSeries.term (detectorCoefficient X) s n * detectorWeight (n / Y) := by
  symm
  apply tsum_eq_sum
  intro n hn
  by_cases hn0 : n = 0
  · simp [hn0]
  · have hnY : Y < n := by
      have hnN : ⌊Y⌋₊ < n := by
        by_contra h
        exact hn (Finset.mem_Icc.mpr ⟨by omega, by omega⟩)
      exact (Nat.floor_lt (by positivity : 0 ≤ Y)).mp hnN
    rw [detectorWeight_zero _ ((le_div_iff₀ hY).mpr (by simpa using hnY.le)), mul_zero]
end Legendre.Density.Detector.Smooth
