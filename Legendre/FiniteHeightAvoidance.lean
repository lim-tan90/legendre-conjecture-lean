/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
public import Mathlib.MeasureTheory.Measure.Real
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.Positivity
public import Mathlib.Tactic.Push
public import Mathlib.Tactic.Ring

/-!
# Quantitative avoidance of finitely many real ordinates

Intervals of radius 1/(4(n+1)) around n points have total length less than one.
-/

@[expose] public section

namespace Legendre.Zeta

open Set MeasureTheory

/-- A unit interval contains a point quantitatively separated from any n specified ordinates. -/
theorem exists_height_avoiding_finset (S : Finset ℝ) (H : ℝ) :
    ∃ T ∈ Ioo H (H+1), ∀ y ∈ S, 1/(4*((S.card : ℝ)+1)) ≤ |T-y| := by
  classical
  let δ : ℝ := 1/(4*((S.card : ℝ)+1))
  have hδ : 0 < δ := by dsimp [δ]; positivity
  have hsmall : (S.card : ℝ)*(2*δ) < 1 := by
    dsimp [δ]
    have hden : 0 < 4*((S.card : ℝ)+1) := by positivity
    have hlt : (2*(S.card : ℝ))/(4*((S.card : ℝ)+1)) < 1 :=
      (div_lt_one hden).2 (by linarith [Nat.cast_nonneg (α := ℝ) S.card])
    convert hlt using 1
    ring
  by_contra hnone
  push Not at hnone
  have hsub : Ioo H (H+1) ⊆ ⋃ y ∈ S, Ioo (y-δ) (y+δ) := by
    intro T hT
    obtain ⟨y, hy, hnear⟩ := hnone T hT
    refine mem_iUnion.2 ⟨y, mem_iUnion.2 ⟨hy, ?_⟩⟩
    have hnear' : |T-y| < δ := hnear
    have h := abs_lt.1 hnear'
    constructor <;> linarith
  have hfinite : volume (⋃ y ∈ S, Ioo (y-δ) (y+δ)) ≠ ⊤ := by
    apply (measure_biUnion_lt_top (μ := volume) S.finite_toSet (fun y hy => ?_)).ne
    rw [Real.volume_Ioo]
    exact ENNReal.ofReal_lt_top
  have hmono := measureReal_mono (μ := volume) hsub hfinite
  rw [Real.volume_real_Ioo_of_le (by linarith : H ≤ H+1)] at hmono
  have hsum := measureReal_biUnion_finset_le (μ := volume) S (fun y => Ioo (y-δ) (y+δ))
  have hlen (y : ℝ) : volume.real (Ioo (y-δ) (y+δ)) = 2*δ := by
    rw [Real.volume_real_Ioo_of_le (by linarith : y-δ ≤ y+δ)]
    ring
  simp_rw [hlen] at hsum
  rw [Finset.sum_const, nsmul_eq_mul] at hsum
  linarith

end Legendre.Zeta
