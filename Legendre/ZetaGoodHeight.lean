/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaUnitCounting
public import Legendre.FiniteHeightAvoidance

/-!
# Quantitative good heights for zeta contours

Three adjacent unit cells contain every ordinate which can approach (H,H+1).
Their logarithmic multiplicity bound gives separation c/log H from all
critical-strip zero ordinates, including both signs of height.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Set

/-- Three upper-height cells surrounding the interval of candidate heights. -/
noncomputable def nearbyHeightZeros (H : ℝ) : Finset ℂ :=
  (unitZeros_finite (H-1)).toFinset ∪ (unitZeros_finite H).toFinset ∪
    (unitZeros_finite (H+1)).toFinset

/-- Distinct ordinates of the nearby zeros; repeated ordinates are removed. -/
noncomputable def nearbyZeroOrdinates (H : ℝ) : Finset ℝ :=
  (nearbyHeightZeros H).image Complex.im

/-- Distinct nearby ordinates are bounded by three multiplicity-weighted cell counts. -/
theorem nearbyZeroOrdinates_card_le_counts (H : ℝ) :
    (nearbyZeroOrdinates H).card ≤ unitZeroCount (H-1)+unitZeroCount H+unitZeroCount (H+1) := by
  classical
  apply (Finset.card_image_le : (nearbyZeroOrdinates H).card ≤ (nearbyHeightZeros H).card).trans
  have hu := Finset.card_union_le (s := (unitZeros_finite (H-1)).toFinset)
    (t := (unitZeros_finite H).toFinset)
  have hv := Finset.card_union_le
    (s := (unitZeros_finite (H-1)).toFinset ∪ (unitZeros_finite H).toFinset)
    (t := (unitZeros_finite (H+1)).toFinset)
  have h1 := unitZeros_card_le_count (H-1)
  have h2 := unitZeros_card_le_count H
  have h3 := unitZeros_card_le_count (H+1)
  unfold nearbyHeightZeros
  omega

/-- Explicit logarithmic bound for all forbidden ordinates near a candidate unit interval. -/
theorem nearbyZeroOrdinates_card_le_log {H : ℝ} (hH : 5 ≤ H) :
    ((nearbyZeroOrdinates H).card : ℝ) ≤ 6*Real.log (40*(H+4))/Real.log (14/13) := by
  have hbound {u : ℝ} (hu : 4 ≤ u) (huH : u ≤ H+1) :
      (unitZeroCount u : ℝ) ≤ 2*Real.log (40*(H+4))/Real.log (14/13) := by
    apply (unitZeroCount_le_log hu).trans
    apply div_le_div_of_nonneg_right _ (Real.log_nonneg (by norm_num : (1 : ℝ) ≤ 14/13))
    apply mul_le_mul_of_nonneg_left _ (by norm_num : (0 : ℝ) ≤ 2)
    apply Real.log_le_log (by positivity)
    linarith
  have h1 := hbound (u := H-1) (by linarith) (by linarith)
  have h2 := hbound (u := H) (by linarith) (by linarith)
  have h3 := hbound (u := H+1) (by linarith) le_rfl
  have hc : ((nearbyZeroOrdinates H).card : ℝ) ≤
      (unitZeroCount (H-1) : ℝ)+(unitZeroCount H : ℝ)+(unitZeroCount (H+1) : ℝ) := by
    exact_mod_cast nearbyZeroOrdinates_card_le_counts H
  calc
    _ ≤ (2*Real.log (40*(H+4))/Real.log (14/13))+
        (2*Real.log (40*(H+4))/Real.log (14/13))+
        (2*Real.log (40*(H+4))/Real.log (14/13)) := hc.trans (add_le_add (add_le_add h1 h2) h3)
    _ = _ := by ring

/-- Reflection supplies a positive-height zero with the same absolute ordinate. -/
theorem nontrivialZero_exists_positive_ordinate {s : ℂ} (hs : NontrivialZero s) :
    ∃ z : ℂ, NontrivialZero z ∧ z.im = |s.im| := by
  by_cases hi : 0 ≤ s.im
  · exact ⟨s,hs,(abs_of_nonneg hi).symm⟩
  · exact ⟨1-s,hs.one_sub,by simp [abs_of_neg (lt_of_not_ge hi)]⟩

/-- Every zero whose absolute ordinate is close enough to the interval appears in the forbidden set. -/
theorem mem_nearbyZeroOrdinates {H : ℝ} {s : ℂ} (hs : NontrivialZero s)
    (hnear : H-1 ≤ |s.im| ∧ |s.im| ≤ H+2) : |s.im| ∈ nearbyZeroOrdinates H := by
  classical
  obtain ⟨z,hz,hzi⟩ := nontrivialZero_exists_positive_ordinate hs
  apply Finset.mem_image.2
  refine ⟨z,?_,hzi⟩
  unfold nearbyHeightZeros
  have hzlo : H-1 ≤ z.im := by rw [hzi]; exact hnear.1
  have hzhi : z.im ≤ H+2 := by rw [hzi]; exact hnear.2
  by_cases h1 : z.im ≤ H
  · apply Finset.mem_union_left
    apply Finset.mem_union_left
    exact (unitZeros_finite (H-1)).mem_toFinset.2 ⟨hz,hzlo,by linarith⟩
  · by_cases h2 : z.im ≤ H+1
    · apply Finset.mem_union_left
      apply Finset.mem_union_right
      exact (unitZeros_finite H).mem_toFinset.2 ⟨hz,(not_le.1 h1).le,h2⟩
    · apply Finset.mem_union_right
      exact (unitZeros_finite (H+1)).mem_toFinset.2 ⟨hz,(not_le.1 h2).le,by linarith⟩

/-- Fully explicit separation radius obtained from the local Jensen counts. -/
noncomputable def goodHeightGap (H : ℝ) : ℝ :=
  1/(4*(6*Real.log (40*(H+4))/Real.log (14/13)+1))

/-- The explicit gap is positive and at most one quarter. -/
theorem goodHeightGap_bounds {H : ℝ} (hH : 5 ≤ H) : 0 < goodHeightGap H ∧ goodHeightGap H ≤ 1/4 := by
  have hd : 0 < Real.log (14/13) := Real.log_pos (by norm_num)
  have hl : 0 ≤ Real.log (40*(H+4)) := Real.log_nonneg (by linarith)
  have hb : 0 ≤ 6*Real.log (40*(H+4))/Real.log (14/13) := by positivity
  constructor
  · unfold goodHeightGap
    positivity
  · unfold goodHeightGap
    exact one_div_le_one_div_of_le (by norm_num) (by linarith)

/-- A quantitative good height avoids every critical-strip zero, without a simplicity assumption. -/
theorem exists_good_height_quantitative {H : ℝ} (hH : 5 ≤ H) :
    ∃ T ∈ Ioo H (H+1), ∀ s : ℂ, NontrivialZero s → goodHeightGap H ≤ abs (T - |s.im|) := by
  obtain ⟨T,hT,havoid⟩ := exists_height_avoiding_finset (nearbyZeroOrdinates H) H
  have hgap : goodHeightGap H ≤ 1/(4*(((nearbyZeroOrdinates H).card : ℝ)+1)) := by
    unfold goodHeightGap
    exact one_div_le_one_div_of_le (by positivity)
      (by linarith [nearbyZeroOrdinates_card_le_log hH])
  refine ⟨T,hT,fun s hs => ?_⟩
  by_cases hnear : H-1 ≤ |s.im| ∧ |s.im| ≤ H+2
  · exact hgap.trans (havoid _ (mem_nearbyZeroOrdinates hs hnear))
  · have hdist : 1 ≤ abs (T - |s.im|) := by
      by_cases hlow : |s.im| < H-1
      · linarith [le_abs_self (T-|s.im|),hT.1]
      · have hhigh : H+2 < |s.im| := by
          by_contra hh
          exact hnear ⟨le_of_not_gt hlow,le_of_not_gt hh⟩
        linarith [neg_le_abs (T-|s.im|),hT.2]
    exact (goodHeightGap_bounds hH).2.trans ((by norm_num : (1/4 : ℝ) ≤ 1).trans hdist)

/-- A fixed positive coefficient for the c/log H separation statement. -/
noncomputable def goodHeightSeparationConstant : ℝ :=
  1/(4*(6*(1+Real.log 80/Real.log 2)/Real.log (14/13)+1/Real.log 2))

/-- No numerical approximation is used in positivity of the coefficient. -/
theorem goodHeightSeparationConstant_pos : 0 < goodHeightSeparationConstant := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h80 : 0 < Real.log 80 := Real.log_pos (by norm_num)
  have hd : 0 < Real.log (14/13) := Real.log_pos (by norm_num)
  unfold goodHeightSeparationConstant
  positivity

/-- The explicit gap has at least c/log H size, for H≥7. -/
theorem goodHeightGap_ge_inv_log {H : ℝ} (hH : 7 ≤ H) :
    goodHeightSeparationConstant/Real.log H ≤ goodHeightGap H := by
  have hlog : 0 < Real.log H := Real.log_pos (by linarith)
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hd : 0 < Real.log (14/13) := Real.log_pos (by norm_num)
  have hl : Real.log (40*(H+4)) ≤ (1+Real.log 80/Real.log 2)*Real.log H :=
    (Real.log_le_log (by positivity) (by linarith : 40*(H+4) ≤ 40*(H+7))).trans
      (global_counting_log_le hH)
  have hlog2 : Real.log 2 ≤ Real.log H := Real.log_le_log (by norm_num) (by linarith)
  have hone : 1 ≤ Real.log H/Real.log 2 := (le_div_iff₀ h2).2 (by simpa using hlog2)
  have hb := div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hl (by norm_num : (0 : ℝ) ≤ 6)) hd.le
  have h80 : 0 < Real.log 80 := Real.log_pos (by norm_num)
  have hbd : 6*Real.log (40*(H+4))/Real.log (14/13)+1 ≤
      (6*(1+Real.log 80/Real.log 2)/Real.log (14/13)+1/Real.log 2)*Real.log H := by
    calc
      _ ≤ 6*((1+Real.log 80/Real.log 2)*Real.log H)/Real.log (14/13)+Real.log H/Real.log 2 :=
        add_le_add hb hone
      _ = _ := by ring
  have hL : 0 ≤ Real.log (40*(H+4)) := Real.log_nonneg (by linarith)
  unfold goodHeightSeparationConstant goodHeightGap
  rw [div_div]
  apply one_div_le_one_div_of_le (by positivity)
  exact (mul_le_mul_of_nonneg_left hbd (by norm_num : (0 : ℝ) ≤ 4)).trans_eq (by ring)

/-- Uniform inverse-log separation from all zero ordinates at some height in every high unit interval. -/
theorem exists_good_height_log_separation {H : ℝ} (hH : 7 ≤ H) :
    ∃ T ∈ Ioo H (H+1), ∀ s : ℂ, NontrivialZero s →
      goodHeightSeparationConstant/Real.log H ≤ abs (T - |s.im|) := by
  obtain ⟨T,hT,hs⟩ := exists_good_height_quantitative (by linarith : 5 ≤ H)
  exact ⟨T,hT,fun s hsz => (goodHeightGap_ge_inv_log hH).trans (hs s hsz)⟩

end Legendre.Zeta
