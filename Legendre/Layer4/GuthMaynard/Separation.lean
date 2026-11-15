/-
Copyright (c) 2026 S. McColm.
Released under the MIT-0 license retained in licenses/smccolm-Lean-MIT-0.txt.
Adapted from smccolm/Lean commit 4c8fb7f7816508825089230e3730b69165e5e303:
GuthMaynard/Separated.lean (IsSeparated, InBaseInterval) and
GuthMaynard/LargeValuesLanguage.lean (floorImage, floor injectivity), and
GuthMaynard/HeathBrown.lean (elementary interval-difference bound only).
Source mapping: docs/smccolm-guth-provenance.md.
Lean 4.35.0: modern module visibility and local namespace; selected definitions
only, avoiding unrelated selection and additive-energy dependencies.
-/
module
public import Legendre.Layer4.GuthMaynard.Definitions
public import Mathlib.Data.Int.Interval
@[expose] public section
namespace Legendre.Density.GuthMaynard

/-- Distinct ordinates are at least δ apart; δ is a real distance. -/
def IsSeparated (δ : ℝ) (W : Finset ℝ) : Prop :=
  ∀ x ∈ W, ∀ y ∈ W, x ≠ y → δ ≤ dist x y

/-- The source large-values interval, with both endpoints included. -/
def InBaseInterval (T : ℝ) (W : Finset ℝ) : Prop :=
  ∀ x ∈ W, x ∈ Set.Icc 0 T

/-- Integer floor bins for finite ordinate packing. -/
noncomputable def floorImage (W : Finset ℝ) : Finset ℤ :=
  W.image Int.floor

theorem floor_injective_on_of_separated (W : Finset ℝ)
    (hW : IsSeparated 1 W) :
    ∀ x ∈ W, ∀ y ∈ W, ⌊x⌋ = ⌊y⌋ → x = y := by
  intro x hx y hy hfloor
  by_contra hxy
  have hsep : 1 ≤ |x - y| := by
    simpa [Real.dist_eq] using hW x hx y hy hxy
  have hxfloor := Int.floor_le x
  have hyfloor := Int.floor_le y
  have hxupper := Int.lt_floor_add_one x
  have hyupper := Int.lt_floor_add_one y
  have hxylt : x - y < 1 := by
    rw [hfloor] at hxupper
    linarith
  have hyxlt : -(1 : ℝ) < x - y := by
    rw [← hfloor] at hyupper
    linarith
  exact (not_lt_of_ge hsep) (abs_lt.mpr ⟨hyxlt, hxylt⟩)


/-- Ordinates in `[0,T]` have pairwise difference at most `T`. -/
theorem abs_sub_le_height_of_mem_baseInterval
    {T : ℝ} {W : Finset ℝ} (hInterval : InBaseInterval T W)
    {t u : ℝ} (ht : t ∈ W) (hu : u ∈ W) :
    |t - u| ≤ T := by
  have htBounds := hInterval t ht
  have huBounds := hInterval u hu
  rw [Set.mem_Icc] at htBounds huBounds
  rw [abs_le]
  constructor <;> linarith

end Legendre.Density.GuthMaynard
