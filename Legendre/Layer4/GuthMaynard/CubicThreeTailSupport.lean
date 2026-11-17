/-
Copyright (c) 2026 S. McColm.
Released under MIT-0; retained license: licenses/smccolm-Lean-MIT-0.txt.
Adapted from smccolm/Lean commit
4c8fb7f7816508825089230e3730b69165e5e303:
DFIDivisorEpsilon.lean (harmonic_le_epsilon_rpow only),
DFISourceCutoffs.lean (dfiUnitRedundantBump only), and
ClassicalLargeValues.lean (sum_inv_distance_near_le_harmonic only).
Lean 4.35.0 minimal module/import/namespace adaptation. No DFI or zeta inputs.
Exact pinned source directory and mapping: docs/smccolm-guth-provenance.md.
-/
module
public import Mathlib.Analysis.Calculus.BumpFunction.FiniteDimension
public import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
public import Mathlib.NumberTheory.Harmonic.Bounds
public import Legendre.Layer4.GuthMaynard.HeathBrownReflection
@[expose] public section
namespace Legendre.Density.GuthMaynard
open Finset Real
open scoped BigOperators

noncomputable def dfiUnitRedundantBump : ContDiffBump (0 : ℝ) :=
  ⟨1/2,1,by norm_num,by norm_num⟩

theorem harmonic_le_epsilon_rpow
    {ε : ℝ} (hε : 0 < ε) (L : ℕ) :
    ((harmonic L : ℚ) : ℝ) ≤
      (1 + ε⁻¹) * max 1 ((L : ℝ) ^ ε) := by
  by_cases hL : L = 0
  · simp [hL, add_nonneg zero_le_one (inv_nonneg.mpr hε.le)]
  have hLPos : (0 : ℝ) < L := by exact_mod_cast Nat.pos_of_ne_zero hL
  have hLone : (1 : ℝ) ≤ L := by exact_mod_cast Nat.one_le_iff_ne_zero.mpr hL
  have hpowOne : (1 : ℝ) ≤ (L : ℝ) ^ ε := by
    simpa using Real.rpow_le_rpow (by norm_num : (0 : ℝ) ≤ 1) hLone hε.le
  have hlogPower := Real.log_le_sub_one_of_pos
    (Real.rpow_pos_of_pos hLPos ε)
  rw [Real.log_rpow hLPos] at hlogPower
  have hlog : Real.log L ≤ ε⁻¹ * ((L : ℝ) ^ ε - 1) := by
    rw [inv_mul_eq_div]
    exact (le_div_iff₀ hε).2 (by simpa [mul_comm] using hlogPower)
  calc
    ((harmonic L : ℚ) : ℝ) ≤ 1 + Real.log L := harmonic_le_one_add_log L
    _ ≤ 1 + ε⁻¹ * ((L : ℝ) ^ ε - 1) := by linarith
    _ ≤ (1 + ε⁻¹) * ((L : ℝ) ^ ε) := by
      have hinv : 0 ≤ ε⁻¹ := inv_nonneg.mpr hε.le
      nlinarith
    _ ≤ (1 + ε⁻¹) * max 1 ((L : ℝ) ^ ε) := by
      exact mul_le_mul_of_nonneg_left (le_max_right _ _) (by positivity)


/-- The reciprocal distances from one point to the other separated points in
its `N`-neighborhood have harmonic, rather than linear, total mass. -/
theorem sum_inv_distance_near_le_harmonic
    (N : ℕ) (W : Finset ℝ) (t : ℝ) (hSep : IsSeparated 1 W) (ht : t ∈ W) :
    (∑ u ∈ {u ∈ W | u ≠ t ∧ |u - t| ≤ (N : ℝ)}, 1 / |u - t|) ≤
      2 * (((harmonic N : ℚ) : ℝ)) := by
  let S := {u ∈ W | u ≠ t ∧ |u - t| ≤ (N : ℝ)}
  let shell : ℝ → ℕ := fun u => Nat.floor |u - t|
  have hmaps : ∀ u ∈ S, shell u ∈ Finset.Icc 1 N := by
    intro u hu
    have huData := Finset.mem_filter.mp hu
    have hu := huData.1
    have hne := huData.2.1
    have hsep := hSep t ht u hu (Ne.symm hne)
    have hqOne : 1 ≤ |u - t| := by simpa only [Real.dist_eq, abs_sub_comm] using hsep
    have hqNonneg : 0 ≤ |u - t| := abs_nonneg _
    have hfloorPos : 0 < shell u := by
      exact Nat.floor_pos.mpr hqOne
    have hfloorLeReal : ((shell u : ℕ) : ℝ) ≤ (N : ℝ) := by
      exact (Nat.floor_le hqNonneg).trans huData.2.2
    have hfloorLe : shell u ≤ N := by exact_mod_cast hfloorLeReal
    exact Finset.mem_Icc.mpr ⟨hfloorPos, hfloorLe⟩
  rw [← Finset.sum_fiberwise_of_maps_to hmaps (fun u => 1 / |u - t|)]
  calc
    (∑ k ∈ Finset.Icc 1 N, ∑ u ∈ S with shell u = k, 1 / |u - t|) ≤
        ∑ k ∈ Finset.Icc 1 N, 2 * (1 / (k : ℝ)) := by
      apply Finset.sum_le_sum
      intro k hk
      have hkPos : 0 < k := (Finset.mem_Icc.mp hk).1
      have hfiberCard : ({u ∈ S | shell u = k}).card ≤ 2 := by
        calc
          ({u ∈ S | shell u = k}).card ≤
              ({u ∈ W | u ≠ t ∧ (k : ℝ) ≤ |u - t| ∧
                |u - t| < (k : ℝ) + 1}).card := by
            apply Finset.card_le_card
            intro u hu
            have huData := Finset.mem_filter.mp hu
            have huS := Finset.mem_filter.mp huData.1
            have hfloor := huData.2
            have hqNonneg : 0 ≤ |u - t| := abs_nonneg _
            have hlow : (k : ℝ) ≤ |u - t| := by
              rw [← hfloor]
              exact Nat.floor_le hqNonneg
            have hhigh : |u - t| < (k : ℝ) + 1 := by
              rw [← hfloor]
              exact Nat.lt_floor_add_one _
            exact Finset.mem_filter.mpr ⟨huS.1, huS.2.1, hlow, hhigh⟩
          _ ≤ 2 := separated_annulus_card_le_two W t k hSep
      calc
        (∑ u ∈ S with shell u = k, 1 / |u - t|) ≤
            ∑ u ∈ S with shell u = k, 1 / (k : ℝ) := by
          apply Finset.sum_le_sum
          intro u hu
          have huData := Finset.mem_filter.mp hu
          have huS := Finset.mem_filter.mp huData.1
          have hfloor := huData.2
          have hqNonneg : 0 ≤ |u - t| := abs_nonneg _
          have hkq : (k : ℝ) ≤ |u - t| := by
            rw [← hfloor]
            exact Nat.floor_le hqNonneg
          exact one_div_le_one_div_of_le (by exact_mod_cast hkPos) hkq
        _ = (({u ∈ S | shell u = k}).card : ℝ) * (1 / (k : ℝ)) := by simp
        _ ≤ 2 * (1 / (k : ℝ)) := by
          gcongr
          exact_mod_cast hfiberCard
    _ = 2 * (((harmonic N : ℚ) : ℝ)) := by
      rw [harmonic_eq_sum_Icc]
      push_cast
      simp only [inv_eq_one_div]
      rw [Finset.mul_sum]


end Legendre.Density.GuthMaynard
