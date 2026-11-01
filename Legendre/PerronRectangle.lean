/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronResidues
public import Mathlib.Order.Interval.Set.Infinite
public import Mathlib.Order.Filter.Finite

/-!
# Finite-height zero sets and admissible Perron rectangles

Both signs of height are included. No zero simplicity assumption is made.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology Set

/-- All critical-strip zeros through absolute height T, including both boundary heights. -/
def symmetricZeros (T : ℝ) : Set ℂ :=
  {s | NontrivialZero s ∧ |s.im| ≤ T}

/-- Compact zero finiteness applies to both signs of height. -/
theorem symmetricZeros_finite (T : ℝ) : (symmetricZeros T).Finite := by
  apply (finite_zeros_on_compact (K := Icc (0 : ℝ) 1 ×ℂ Icc (-T) T)
    (isCompact_Icc.reProdIm isCompact_Icc)).subset
  intro s hs
  exact ⟨⟨⟨hs.1.2.1.le, hs.1.2.2.le⟩, abs_le.1 hs.2⟩, hs.1.1⟩

/-- A positive real cutoff lies strictly to the left of every zero at a fixed height. -/
theorem exists_symmetricZeroCutoff (T : ℝ) : ∃ a ∈ Ioo (0 : ℝ) 1,
    ∀ s ∈ symmetricZeros T, a < s.re := by
  have hall : ∀ᶠ a : ℝ in 𝓝[>] 0, ∀ s ∈ symmetricZeros T, a < s.re := by
    apply ((symmetricZeros_finite T).eventually_all).2
    intro s hs
    exact (eventually_lt_nhds hs.1.2.1).filter_mono nhdsWithin_le_nhds
  obtain ⟨a, ha, hlt, hmem⟩ := (hall.and
    (((eventually_lt_nhds (show (0 : ℝ) < 1 by norm_num)).filter_mono nhdsWithin_le_nhds).and
      self_mem_nhdsWithin)).exists
  exact ⟨a, ⟨hmem, hlt⟩, ha⟩

/-- Arbitrarily large positive heights avoid all critical-strip zero ordinates. -/
theorem exists_good_zero_height {H : ℝ} (_hH : 0 ≤ H) : ∃ T ∈ Ioo H (H+1),
    ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T := by
  have hfinite := (symmetricZeros_finite (H+1)).image (fun s : ℂ => |s.im|)
  obtain ⟨T, hT, hnot⟩ := (Ioo_infinite (show H < H+1 by linarith)).exists_notMem_finite hfinite
  refine ⟨T, hT, fun s hs heq => ?_⟩
  apply hnot
  exact ⟨s, ⟨hs, by rw [heq]; exact hT.2.le⟩, heq⟩

/-- A rectangle from a−iT to σ+iT, oriented counterclockwise. -/
def perronRectangle (a σ T : ℝ) : Set ℂ :=
  Rectangle ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I)

/-- Coordinate description with the expected closed boundary convention. -/
theorem mem_perronRectangle {a σ T : ℝ} (haσ : a ≤ σ) (hT : 0 ≤ T) (s : ℂ) :
    s ∈ perronRectangle a σ T ↔ a ≤ s.re ∧ s.re ≤ σ ∧ -T ≤ s.im ∧ s.im ≤ T := by
  simp only [perronRectangle, Rectangle, sub_re, ofReal_re, mul_re, ofReal_im,
    I_re, mul_zero, I_im, mul_one, sub_self, sub_zero, add_re, add_zero,
    sub_im, mul_im, zero_add, zero_sub, add_im]
  rw [uIcc_of_le haσ, uIcc_of_le (by linarith : -T ≤ T)]
  simp only [mem_reProdIm, mem_Icc, and_assoc]

/-- 1 is strictly inside an admissible rectangle. -/
theorem one_mem_perronRectangle {a σ T : ℝ} (ha : a < 1) (hσ : 1 < σ) (hT : 0 < T) :
    (1 : ℂ) ∈ perronRectangle a σ T := by
  rw [mem_perronRectangle (by linarith) hT.le]
  norm_num
  exact ⟨ha.le, hσ.le, hT.le⟩

/-- Positive real cutoff excludes the weight's pole at 0. -/
theorem ne_zero_of_mem_perronRectangle {a σ T : ℝ} (ha : 0 < a) (haσ : a ≤ σ)
    (hT : 0 ≤ T) {s : ℂ} (hs : s ∈ perronRectangle a σ T) : s ≠ 0 := by
  have hre := (mem_perronRectangle haσ hT s).1 hs
  intro he
  simp [he] at hre
  linarith [hre.1]

/-- Rectangle zeros are precisely the absolute-height critical-strip zeros,
provided the left edge is below all of them. -/
theorem perronRectangle_zeros {a σ T : ℝ} (ha : 0 < a) (ha1 : a < 1)
    (hσ : 1 < σ) (hT : 0 ≤ T)
    (hcut : ∀ s ∈ symmetricZeros T, a < s.re) :
    perronRectangle a σ T ∩ {s : ℂ | riemannZeta s = 0} = symmetricZeros T := by
  ext s
  constructor
  · rintro ⟨hs, hz⟩
    have h := (mem_perronRectangle (by linarith) hT s).1 hs
    have hre : s.re < 1 := by
      by_contra hh
      exact (riemannZeta_ne_zero_of_one_le_re (le_of_not_gt hh)) hz
    exact ⟨⟨hz, by linarith [h.1], hre⟩, abs_le.2 h.2.2⟩
  · intro hs
    refine ⟨?_, hs.1.1⟩
    rw [mem_perronRectangle (by linarith) hT]
    exact ⟨(hcut s hs).le, by linarith [hs.1.2.2], (abs_le.1 hs.2).1, (abs_le.1 hs.2).2⟩

/-- The main pole cannot lie on the boundary of an admissible rectangle. -/
theorem one_not_mem_perronRectangleBorder {a σ T : ℝ} (ha : a < 1) (hσ : 1 < σ)
    (hT : 0 < T) :
    (1 : ℂ) ∉ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) := by
  simp [RectangleBorder, mem_reProdIm, ha.ne', hσ.ne, hT.ne', hT.ne]

/-- A good height and strict left cutoff make every point of the rectangle boundary zero-free. -/
theorem perronRectangleBorder_nonvanishing {a σ T : ℝ} (ha : 0 < a) (ha1 : a < 1)
    (hσ : 1 < σ) (hT : 0 < T)
    (hcut : ∀ s ∈ symmetricZeros T, a < s.re)
    (hgood : ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T) :
    ∀ s ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I), riemannZeta s ≠ 0 := by
  intro s hs hz
  have hR : s ∈ perronRectangle a σ T := rectangleBorder_subset_rectangle _ _ hs
  have hmem : s ∈ symmetricZeros T := perronRectangle_zeros ha ha1 hσ hT.le hcut ▸ ⟨hR, hz⟩
  have hcoords := (mem_perronRectangle (by linarith) hT.le s).1 hR
  have hleft : s.re ≠ a := (hcut s hmem).ne'
  have hright : s.re ≠ σ := by linarith [hmem.1.2.2]
  have htop : s.im ≠ T := by intro he; exact hgood s hmem.1 (by rw [he, abs_of_pos hT])
  have hbottom : s.im ≠ -T := by intro he; exact hgood s hmem.1 (by rw [he, abs_neg, abs_of_pos hT])
  simp only [RectangleBorder, mem_union, mem_reProdIm, mem_singleton_iff,
    sub_re, mul_re, ofReal_re, ofReal_im, I_re, I_im, mul_zero, mul_one, sub_self,
    sub_zero, add_re, add_zero, sub_im, mul_im, zero_add, zero_sub, add_im] at hs
  rcases hs with ((h|h)|h)|h
  · exact hbottom h.2
  · exact hleft h.1
  · exact htop h.2
  · exact hright h.1

end Legendre.Zeta
