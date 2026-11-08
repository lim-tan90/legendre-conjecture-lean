/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.WeightedSeparation
public import Legendre.ZetaUnitCounting

/-!
# Multiplicity-preserving selection of separated zeta zeros

The local logarithmic zero count turns the entire density count into a
logarithmic multiple of a set of distinct, one-separated zero ordinates.
The fixed compact contribution below height five is retained explicitly.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Set

/-- The multiplicity in a half-unit window of any density subset is bounded by its full unit cell. -/
theorem density_window_le_unit_count (σ T t : ℝ) :
    (∑ ρ ∈ (zerosRightOf_finite σ T).toFinset.filter (fun ρ => |ρ.im-t| ≤ 1/2),
      zeroMultiplicity ρ) ≤ unitZeroCount (t-1/2) := by
  classical
  unfold unitZeroCount
  apply Finset.sum_le_sum_of_subset
  intro ρ hρ
  have hh := Finset.mem_filter.1 hρ
  have hz := (zerosRightOf_finite σ T).mem_toFinset.1 hh.1
  have hi := abs_le.1 hh.2
  apply (unitZeros_finite (t-1/2)).mem_toFinset.2
  exact ⟨hz.1.1,by linarith,by linarith⟩

/-- A fixed low-height count plus a logarithmic unit-height upper bound. -/
noncomputable def densityLocalMassBound (T : ℝ) : ℝ :=
  (zeroCount 5 : ℝ)+2*Real.log (40*(T+7))/Real.log (14/13)

/-- Every half-unit window in a density zero set has this uniform weighted mass bound. -/
theorem density_window_mass_le (σ : ℝ) {T : ℝ} (hT : 7 ≤ T) (t : ℝ) :
    ((∑ ρ ∈ (zerosRightOf_finite σ T).toFinset.filter (fun ρ => |ρ.im-t| ≤ 1/2),
      zeroMultiplicity ρ : ℕ) : ℝ) ≤ densityLocalMassBound T := by
  classical
  have hd : 0 < Real.log (14/13) := Real.log_pos (by norm_num)
  have hhigh : 0 ≤ 2*Real.log (40*(T+7))/Real.log (14/13) := by
    apply div_nonneg _ hd.le
    apply mul_nonneg (by norm_num)
    apply Real.log_nonneg
    linarith
  by_cases ht : t < 9/2
  · have hnat : (∑ ρ ∈ (zerosRightOf_finite σ T).toFinset.filter (fun ρ => |ρ.im-t| ≤ 1/2),
        zeroMultiplicity ρ) ≤ zeroCount 5 := by
      unfold zeroCount
      apply Finset.sum_le_sum_of_subset
      intro ρ hρ
      have hh := Finset.mem_filter.1 hρ
      have hz := (zerosRightOf_finite σ T).mem_toFinset.1 hh.1
      have hi := abs_le.1 hh.2
      apply (zerosUpTo_finite 5).mem_toFinset.2
      exact ⟨hz.1.1,hz.1.2.1,by linarith⟩
    have hr : ((∑ ρ ∈ (zerosRightOf_finite σ T).toFinset.filter (fun ρ => |ρ.im-t| ≤ 1/2),
        zeroMultiplicity ρ : ℕ) : ℝ) ≤ (zeroCount 5 : ℝ) := by exact_mod_cast hnat
    unfold densityLocalMassBound
    linarith
  by_cases htop : t ≤ T+1/2
  · have hunit := unitZeroCount_le_log (show 4 ≤ t-1/2 by linarith)
    have hlog : Real.log (40*(t-1/2+3)) ≤ Real.log (40*(T+7)) :=
      Real.log_le_log (by linarith [not_lt.1 ht]) (by linarith)
    have hfrac := div_le_div_of_nonneg_right
      (mul_le_mul_of_nonneg_left hlog (by norm_num : (0 : ℝ) ≤ 2)) hd.le
    have hw : ((∑ ρ ∈ (zerosRightOf_finite σ T).toFinset.filter (fun ρ => |ρ.im-t| ≤ 1/2),
        zeroMultiplicity ρ : ℕ) : ℝ) ≤ (unitZeroCount (t-1/2) : ℝ) := by
      exact_mod_cast density_window_le_unit_count σ T t
    unfold densityLocalMassBound
    have hlow : (0 : ℝ) ≤ (zeroCount 5 : ℝ) := Nat.cast_nonneg _
    linarith
  · have hempty : (zerosRightOf_finite σ T).toFinset.filter (fun ρ => |ρ.im-t| ≤ 1/2) = ∅ := by
      apply Finset.eq_empty_iff_forall_notMem.2
      intro ρ hρ
      have hh := Finset.mem_filter.1 hρ
      have hz := (zerosRightOf_finite σ T).mem_toFinset.1 hh.1
      have hi := abs_le.1 hh.2
      have htop' : T+1/2 < t := not_le.1 htop
      linarith [hz.1.2.2]
    rw [hempty,Finset.sum_empty,Nat.cast_zero]
    unfold densityLocalMassBound
    positivity

/-- An absolute logarithmic mass coefficient, including the fixed low-height contribution. -/
noncomputable def densitySelectionConstant : ℝ :=
  (zeroCount 5 : ℝ)/Real.log 2+
    2*(1+Real.log 80/Real.log 2)/Real.log (14/13)+1

/-- The selection coefficient is strictly positive. -/
theorem densitySelectionConstant_pos : 0 < densitySelectionConstant := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 80 := Real.log_pos (by norm_num)
  have hd : 0 < Real.log (14/13) := Real.log_pos (by norm_num)
  unfold densitySelectionConstant
  positivity

/-- The local weighted mass is O(log T), uniformly in the real cutoff and the window center. -/
theorem densityLocalMassBound_le_log {T : ℝ} (hT : 7 ≤ T) :
    densityLocalMassBound T ≤ densitySelectionConstant*Real.log T := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hd : 0 < Real.log (14/13) := Real.log_pos (by norm_num)
  have hlog2 := Real.log_le_log (by norm_num : (0 : ℝ) < 2) (show 2 ≤ T by linarith)
  have hbase := mul_le_mul_of_nonneg_left hlog2
    (div_nonneg (Nat.cast_nonneg (zeroCount 5) : (0 : ℝ) ≤ zeroCount 5) h2.le)
  have he : ((zeroCount 5 : ℝ)/Real.log 2)*Real.log 2 = (zeroCount 5 : ℝ) := by field_simp
  rw [he] at hbase
  have hh := div_le_div_of_nonneg_right
    (mul_le_mul_of_nonneg_left (global_counting_log_le hT) (by norm_num : (0 : ℝ) ≤ 2)) hd.le
  unfold densityLocalMassBound densitySelectionConstant
  have hlog : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have heq : 2*((1+Real.log 80/Real.log 2)*Real.log T)/Real.log (14/13) =
      (2*(1+Real.log 80/Real.log 2)/Real.log (14/13))*Real.log T := by ring
  rw [heq] at hh
  nlinarith

/-- One-separated distinct zero representatives control the complete multiplicity-weighted count. -/
theorem exists_density_separated_representatives (σ : ℝ) {T : ℝ} (hT : 7 ≤ T) :
    ∃ r : Finset ℂ, r ⊆ (zerosRightOf_finite σ T).toFinset ∧
      (∀ ρ ∈ r, ∀ z ∈ r, ρ ≠ z → 1 ≤ |ρ.im-z.im|) ∧
      (zeroDensityCount σ T : ℝ) ≤ 2*densitySelectionConstant*Real.log T*r.card := by
  classical
  obtain ⟨r,hrs,hsep,hcount⟩ := Density.exists_weighted_separated_representatives
    (zerosRightOf_finite σ T).toFinset Complex.im zeroMultiplicity
    (fun t => (density_window_mass_le σ hT t).trans (densityLocalMassBound_le_log hT))
  refine ⟨r,hrs,hsep,?_⟩
  simpa only [zeroDensityCount,mul_assoc] using hcount

end Legendre.Zeta
