/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Zeta
public import Mathlib.Analysis.Analytic.Order
public import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
# Layer 2: multiplicity-weighted counting in the critical strip

Original counting interfaces and proofs, using mathlib v4.35.0
(56a005855ea17e0b0958f73ec801ae140b0a1679, Apache-2.0).
Analytic orders come from `Analysis/Analytic/Order.lean` (Vincent Beffara,
Stefan Kebekus); compact finiteness comes from `LSeries/ZetaZeros.lean`
(Huanyu Zheng), via `Legendre.Zeta`.

Our convention is 0 < Re(s) < 1 and 0 < Im(s) ≤ T; the density count also
requires σ ≤ Re(s). These definitions do not assert a classification of
all zeros outside the critical strip. Counts include analytic multiplicities,
not just distinct zeros. No asymptotic estimate or density theorem is claimed.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex

/-- A nontrivial zero in the open critical strip, without a height restriction. -/
def NontrivialZero (s : ℂ) : Prop :=
  riemannZeta s = 0 ∧ 0 < s.re ∧ s.re < 1

/-- Upper-half-plane zeros through height T, including the top boundary. -/
def zerosUpTo (T : ℝ) : Set ℂ :=
  {s | NontrivialZero s ∧ 0 < s.im ∧ s.im ≤ T}

/-- The subset used in N(σ,T), with the real boundary included. -/
def zerosRightOf (σ T : ℝ) : Set ℂ :=
  {s ∈ zerosUpTo T | σ ≤ s.re}

/-- Orders are finite away from the pole: the analytic continuation is not
identically zero on the connected punctured plane. -/
theorem analytic_order_finite {s : ℂ} (hs : s ≠ 1) :
    analyticOrderAt riemannZeta s ≠ ⊤ := by
  apply AnalyticOnNhd.analyticOrderAt_ne_top_of_isPreconnected analytic_off_pole
    (isConnected_compl_singleton_of_one_lt_rank (by simp) (1 : ℂ)).isPreconnected
    (x := (2 : ℂ)) (by simp) (by simpa using hs)
  have h : analyticOrderAt riemannZeta (2 : ℂ) = 0 :=
    analyticOrderAt_eq_zero.mpr (.inr (riemannZeta_ne_zero_of_one_le_re (by norm_num)))
  simp [h]

/-- Natural-valued analytic order. Finiteness is proved before using this
as a zero multiplicity, so conversion from ENat does not discard infinity. -/
noncomputable def zeroMultiplicity (s : ℂ) : ℕ :=
  analyticOrderNatAt riemannZeta s

/-- The natural multiplicity exactly recovers the extended analytic order
away from the pole; no infinite order is silently converted to zero. -/
theorem zeroMultiplicity_cast {s : ℂ} (hs : s ≠ 1) :
    (zeroMultiplicity s : ℕ∞) = analyticOrderAt riemannZeta s :=
  Nat.cast_analyticOrderNatAt (analytic_order_finite hs)

/-- Every critical-strip zero has strictly positive, finite multiplicity. -/
theorem zeroMultiplicity_pos {s : ℂ} (hs : NontrivialZero s) :
    0 < zeroMultiplicity s := by
  have hpole : s ≠ 1 := by
    intro h
    have := hs.2.2
    simp [h] at this
  apply ENat.toNat_pos _ (analytic_order_finite hpole)
  exact analyticOrderAt_ne_zero.mpr
    ⟨(analytic_off_pole s (by simpa using hpole)), hs.1⟩

/-- Nonzeros contribute no multiplicity. -/
theorem zeroMultiplicity_eq_zero {s : ℂ} (hs : riemannZeta s ≠ 0) :
    zeroMultiplicity s = 0 := by
  simp [zeroMultiplicity, analyticOrderNatAt, analyticOrderAt_eq_zero.mpr (.inr hs)]

/-- The height-restricted critical-strip zero set is finite. -/
theorem zerosUpTo_finite (T : ℝ) : (zerosUpTo T).Finite := by
  have h := finite_zeros_on_compact
    (K := Set.Icc (0 : ℝ) 1 ×ℂ Set.Icc (0 : ℝ) T)
    (isCompact_Icc.reProdIm isCompact_Icc)
  apply h.subset
  intro s hs
  exact ⟨⟨⟨hs.1.2.1.le, hs.1.2.2.le⟩, ⟨hs.2.1.le, hs.2.2⟩⟩, hs.1.1⟩

/-- The density-count zero set is finite. -/
theorem zerosRightOf_finite (σ T : ℝ) : (zerosRightOf σ T).Finite :=
  (zerosUpTo_finite T).subset (fun _ hs ↦ hs.1)

/-- N(T): zeros with 0 < Re(s) < 1 and 0 < Im(s) ≤ T, counted with multiplicity. -/
noncomputable def zeroCount (T : ℝ) : ℕ :=
  ∑ s ∈ (zerosUpTo_finite T).toFinset, zeroMultiplicity s

/-- N(σ,T): the same count restricted to Re(s) ≥ σ. -/
noncomputable def zeroDensityCount (σ T : ℝ) : ℕ :=
  ∑ s ∈ (zerosRightOf_finite σ T).toFinset, zeroMultiplicity s

/-- The multiplicity-weighted count is positive exactly when its zero set
is nonempty, because every counted zero has positive multiplicity. -/
theorem zeroCount_pos_iff (T : ℝ) : 0 < zeroCount T ↔ (zerosUpTo T).Nonempty := by
  unfold zeroCount
  rw [Finset.sum_pos_iff]
  constructor
  · rintro ⟨s, hs, _⟩
    exact ⟨s, by simpa using hs⟩
  · rintro ⟨s, hs⟩
    exact ⟨s, by simpa using hs, zeroMultiplicity_pos hs.1⟩

/-- Likewise for the real-part-restricted density count. -/
theorem zeroDensityCount_pos_iff (σ T : ℝ) :
    0 < zeroDensityCount σ T ↔ (zerosRightOf σ T).Nonempty := by
  unfold zeroDensityCount
  rw [Finset.sum_pos_iff]
  constructor
  · rintro ⟨s, hs, _⟩
    exact ⟨s, by simpa using hs⟩
  · rintro ⟨s, hs⟩
    exact ⟨s, by simpa using hs, zeroMultiplicity_pos hs.1.1⟩

/-- Increasing height enlarges the zero set. -/
theorem zerosUpTo_mono {S T : ℝ} (h : S ≤ T) : zerosUpTo S ⊆ zerosUpTo T :=
  fun _ hs ↦ ⟨hs.1, hs.2.1, hs.2.2.trans h⟩

/-- N(T) is monotone, with multiplicities retained. -/
theorem zeroCount_mono : Monotone zeroCount := by
  intro S T h
  apply Finset.sum_le_sum_of_subset
  intro s hs
  simpa using zerosUpTo_mono h (by simpa using hs)

/-- A density count is bounded by the total count at the same height. -/
theorem zeroDensityCount_le (σ T : ℝ) : zeroDensityCount σ T ≤ zeroCount T := by
  apply Finset.sum_le_sum_of_subset
  intro s hs
  simpa using (show s ∈ zerosUpTo T from (by simpa using hs : s ∈ zerosRightOf σ T).1)

/-- For fixed σ, N(σ,T) increases with height. -/
theorem zeroDensityCount_mono_height (σ : ℝ) : Monotone (zeroDensityCount σ) := by
  intro S T h
  apply Finset.sum_le_sum_of_subset
  intro s hs
  have hs' : s ∈ zerosRightOf σ S := by simpa using hs
  simpa using (show s ∈ zerosRightOf σ T from ⟨zerosUpTo_mono h hs'.1, hs'.2⟩)

/-- Increasing σ decreases N(σ,T). -/
theorem zeroDensityCount_antitone (T : ℝ) : Antitone (fun σ ↦ zeroDensityCount σ T) := by
  intro σ τ h
  apply Finset.sum_le_sum_of_subset
  intro s hs
  have hs' : s ∈ zerosRightOf τ T := by simpa using hs
  simpa using (show s ∈ zerosRightOf σ T from ⟨hs'.1, h.trans hs'.2⟩)

/-- There are no counted zeros at nonpositive height. -/
theorem zeroCount_eq_zero_of_nonpos {T : ℝ} (hT : T ≤ 0) : zeroCount T = 0 := by
  have h : zerosUpTo T = ∅ := by
    ext s
    simp only [zerosUpTo, Set.mem_ofPred_eq, Set.mem_empty_iff_false, iff_false]
    intro hs
    linarith [hs.2.1, hs.2.2]
  simp [zeroCount, h]

/-- A cutoff at or to the right of 1 excludes the open critical strip. -/
theorem zeroDensityCount_eq_zero_of_one_le {σ : ℝ} (hσ : 1 ≤ σ) (T : ℝ) :
    zeroDensityCount σ T = 0 := by
  have h : zerosRightOf σ T = ∅ := by
    ext s
    simp only [zerosRightOf, Set.mem_ofPred_eq, Set.mem_empty_iff_false, iff_false]
    intro hs
    linarith [hs.1.1.2.2, hs.2]
  simp [zeroDensityCount, h]

/-- A nonpositive real cutoff includes every critical-strip zero. -/
theorem zeroDensityCount_eq_count_of_nonpos {σ : ℝ} (hσ : σ ≤ 0) (T : ℝ) :
    zeroDensityCount σ T = zeroCount T := by
  have h : zerosRightOf σ T = zerosUpTo T := by
    ext s
    exact ⟨fun hs ↦ hs.1, fun hs ↦ ⟨hs, hσ.trans hs.1.2.1.le⟩⟩
  simp only [zeroDensityCount, zeroCount, h]

end Legendre.Zeta
