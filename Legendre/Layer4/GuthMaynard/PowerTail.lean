/-
Copyright (c) 2026 S. McColm.
Released under the MIT-0 license retained in licenses/smccolm-Lean-MIT-0.txt.
Adapted from smccolm/Lean commit 4c8fb7f7816508825089230e3730b69165e5e303,
GuthMaynard/TypeIIFourthMomentReduction.lean: only the two symmetric real-power
tail lemmas. Mapping: docs/smccolm-guth-provenance.md.
Lean 4.35.0: module visibility, local namespace and minimal mathlib dependency.
-/
module
public import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
@[expose] public section
open MeasureTheory Set
namespace Legendre.Density.GuthMaynard

set_option maxHeartbeats 800000 in
/-- Exact symmetric tail integral for a negative real power. -/
theorem integral_abs_rpow_compl_Icc {a H : ℝ} (ha : a < -1) (hH : 0 < H) :
    ∫ u : ℝ in (Set.Icc (-H) H)ᶜ, |u| ^ a =
      -2 * H ^ (a + 1) / (a + 1) := by
  have hPosInt : IntegrableOn (fun u : ℝ => u ^ a) (Set.Ioi H) :=
    integrableOn_Ioi_rpow_of_lt ha hH
  have hNegInt : IntegrableOn (fun u : ℝ => |u| ^ a) (Set.Iio (-H)) := by
    have hPosInt' : IntegrableOn (fun u : ℝ => u ^ a) (Set.Ioi (-(-H))) := by
      simpa only [neg_neg] using hPosInt
    have h : IntegrableOn (fun u : ℝ => (-u) ^ a) (Set.Iio (-H)) := by
      exact hPosInt'.comp_neg_Iio (c := -H)
    apply h.congr_fun
    intro u hu
    change (-u) ^ a = |u| ^ a
    rw [abs_of_neg (lt_trans hu (neg_neg_of_pos hH))]
    simp
  have hPosAbs : IntegrableOn (fun u : ℝ => |u| ^ a) (Set.Ioi H) := by
    apply hPosInt.congr_fun
    intro u hu
    change u ^ a = |u| ^ a
    rw [abs_of_pos (hH.trans hu)]
    exact measurableSet_Ioi
  have hDisjoint : Disjoint (Set.Iio (-H)) (Set.Ioi H) := by
    rw [Set.disjoint_left]
    intro u huNeg huPos
    change u < -H at huNeg
    change H < u at huPos
    linarith
  have hCompl : (Set.Icc (-H) H)ᶜ = Set.Iio (-H) ∪ Set.Ioi H := by
    ext u
    simp only [Set.mem_compl_iff, Set.mem_Icc, Set.mem_union, Set.mem_Iio, Set.mem_Ioi]
    constructor
    · intro h
      by_cases hu : u < -H
      · exact Or.inl hu
      · exact Or.inr (lt_of_not_ge fun huH => h ⟨le_of_not_gt hu, huH⟩)
    · intro h hu
      rcases h with h | h <;> linarith
  rw [hCompl, setIntegral_union hDisjoint measurableSet_Ioi hNegInt hPosAbs]
  have hNegEq :
      ∫ u : ℝ in Set.Iio (-H), |u| ^ a = ∫ u : ℝ in Set.Ioi H, u ^ a := by
    rw [← integral_Iic_eq_integral_Iio]
    rw [← integral_comp_neg_Ioi H (fun u : ℝ => |u| ^ a)]
    apply setIntegral_congr_fun measurableSet_Ioi
    intro u hu
    change |-u| ^ a = u ^ a
    rw [abs_neg, abs_of_pos (hH.trans hu)]
  have hPosEq :
      ∫ u : ℝ in Set.Ioi H, |u| ^ a = ∫ u : ℝ in Set.Ioi H, u ^ a := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro u hu
    change |u| ^ a = u ^ a
    rw [abs_of_pos (hH.trans hu)]
  rw [hNegEq, hPosEq, integral_Ioi_rpow_of_lt ha hH]
  ring

theorem integrableOn_abs_rpow_compl_Icc {a H : ℝ} (ha : a < -1) (hH : 0 < H) :
    IntegrableOn (fun u : ℝ => |u| ^ a) (Set.Icc (-H) H)ᶜ := by
  have hPosInt : IntegrableOn (fun u : ℝ => u ^ a) (Set.Ioi H) :=
    integrableOn_Ioi_rpow_of_lt ha hH
  have hPosAbs : IntegrableOn (fun u : ℝ => |u| ^ a) (Set.Ioi H) := by
    apply hPosInt.congr_fun
    · intro u hu
      change u ^ a = |u| ^ a
      rw [abs_of_pos (hH.trans hu)]
    · exact measurableSet_Ioi
  have hNegAbs : IntegrableOn (fun u : ℝ => |u| ^ a) (Set.Iio (-H)) := by
    have hPosInt' : IntegrableOn (fun u : ℝ => u ^ a) (Set.Ioi (-(-H))) := by
      simpa only [neg_neg] using hPosInt
    have h : IntegrableOn (fun u : ℝ => (-u) ^ a) (Set.Iio (-H)) :=
      hPosInt'.comp_neg_Iio (c := -H)
    apply h.congr_fun
    intro u hu
    change (-u) ^ a = |u| ^ a
    rw [abs_of_neg (lt_trans hu (neg_neg_of_pos hH))]
    simp
  have hCompl : (Set.Icc (-H) H)ᶜ = Set.Iio (-H) ∪ Set.Ioi H := by
    ext u
    simp only [Set.mem_compl_iff, Set.mem_Icc, Set.mem_union, Set.mem_Iio, Set.mem_Ioi]
    constructor
    · intro h
      by_cases hu : u < -H
      · exact Or.inl hu
      · exact Or.inr (lt_of_not_ge fun huH => h ⟨le_of_not_gt hu, huH⟩)
    · intro h hu
      rcases h with h | h <;> linarith
  rw [hCompl]
  exact hNegAbs.union hPosAbs


end Legendre.Density.GuthMaynard
