/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorPolynomial.lean and DensityDetectorBlocks.lean
in openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The zeta polynomial uses one common, untwisted coefficient sequence.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorAlternative
public import Legendre.Layer4.DyadicPartition

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex
open scoped BigOperators Classical

theorem detectorWeight_norm_le_one (x : ℝ) (hx : 0 ≤ x) : ‖detectorWeight x‖ ≤ 1 := by
  by_cases h1 : 1 ≤ x
  · rw [detectorWeight_zero x h1,norm_zero]
    norm_num
  · have hle : x ≤ 1 := le_of_not_ge h1
    rw [detectorWeight_eq x hle,Complex.norm_real,Real.norm_eq_abs,
      abs_of_nonneg (by positivity : 0 ≤ (1-x)^2/2)]
    nlinarith

noncomputable def polynomialCoefficient (X : ℕ) (Y : ℝ) (n : ℕ) : ℂ :=
  if X < n then detectorCoefficient X n*detectorWeight (n/Y) else 0

theorem polynomialCoefficient_norm (X : ℕ) (Y : ℝ) (hY : 0 < Y) (n : ℕ) :
    ‖polynomialCoefficient X Y n‖ ≤ n.divisors.card := by
  unfold polynomialCoefficient
  split_ifs
  · rw [norm_mul]
    exact (mul_le_mul (detectorCoefficient_norm X n)
      (detectorWeight_norm_le_one (n/Y) (by positivity)) (norm_nonneg _) (by positivity)).trans_eq (mul_one _)
  · simp

theorem polynomialCoefficient_below (X n : ℕ) (Y : ℝ) (hn : n ≤ X) :
    polynomialCoefficient X Y n = 0 := by
  simp [polynomialCoefficient,Nat.not_lt.mpr hn]

theorem polynomialCoefficient_above (X n : ℕ) (Y : ℝ) (hY : 0 < Y) (hn : Y ≤ n) :
    polynomialCoefficient X Y n = 0 := by
  simp [polynomialCoefficient,detectorWeight_zero (n/Y)
    ((le_div_iff₀ hY).mpr (by simpa using hn))]

theorem detectorTail_polynomial (X : ℕ) (s : ℂ) (Y : ℝ) :
    detectorTail X s Y = complexDirichletPolynomial ⌊Y⌋₊ (polynomialCoefficient X Y) s := by
  unfold detectorTail complexDirichletPolynomial
  rw [Finset.sum_filter]
  apply Finset.sum_congr rfl
  intro n hn
  have hnp : 0 < n := (Finset.mem_Icc.mp hn).1
  by_cases hX : X < n
  · rw [ite_eq_left hX,LSeries.term_of_ne_zero hnp.ne',polynomialCoefficient,ite_eq_left hX,
      Complex.cpow_neg]
    ring
  · simp [hX,polynomialCoefficient]

theorem detectorTail_extended (X N : ℕ) (Y : ℝ) (hY : 0 < Y) (hN : ⌊Y⌋₊ ≤ N) (s : ℂ) :
    detectorTail X s Y = complexDirichletPolynomial N (polynomialCoefficient X Y) s := by
  rw [detectorTail_polynomial]
  unfold complexDirichletPolynomial
  apply Finset.sum_subset
  · exact Finset.Icc_subset_Icc_right hN
  · intro n hn hn'
    have hn1 := (Finset.mem_Icc.mp hn).1
    have hfloor : ⌊Y⌋₊ < n := by
      have hnnot : ¬n ≤ ⌊Y⌋₊ := fun h => hn' (Finset.mem_Icc.mpr ⟨hn1,h⟩)
      omega
    have hyn : Y < n := (Nat.floor_lt hY.le).mp hfloor
    rw [polynomialCoefficient_above X n Y hY hyn.le,zero_mul]

theorem detectorTail_blocks (X J : ℕ) (hX : 1 ≤ X) (Y : ℝ) (hY : 0 < Y)
    (hcover : ⌊Y⌋₊ ≤ 2^J*X) (s : ℂ) :
    detectorTail X s Y = ∑ j ∈ Finset.range J,
      ∑ n ∈ Finset.Ioc (2^j*X) (2*(2^j*X)), polynomialCoefficient X Y n*(n : ℂ)^(-s) := by
  rw [detectorTail_extended X (2^J*X) Y hY hcover]
  unfold complexDirichletPolynomial
  rw [Moment.moment_dyadic_partition X J hX]
  have hhead : (∑ n ∈ Finset.Icc 1 X,polynomialCoefficient X Y n*(n : ℂ)^(-s)) = 0 := by
    apply Finset.sum_eq_zero
    intro n hn
    rw [polynomialCoefficient_below X n Y (Finset.mem_Icc.mp hn).2,zero_mul]
  rw [hhead,zero_add]
  apply Finset.sum_congr rfl
  intro j _
  congr 2
  rw [pow_succ]
  ring

end Legendre.Density.Detector.Smooth
