/-
Copyright (c) 2026 S. McColm and the Legendre formalization contributors.
Released under MIT-0; retained license: licenses/smccolm-Lean-MIT-0.txt.
The floor-correlation proof adapts LargeValuesS3.lean from smccolm/Lean commit
4c8fb7f7816508825089230e3730b69165e5e303. Strict/closed energy comparison and
the paper-convention S3 consequence are local extensions.
Source directory and mapping: docs/smccolm-guth-provenance.md.
-/
module
public import Legendre.Layer4.GuthMaynard.CubicThreeTail

@[expose] public section
namespace Legendre.Density.GuthMaynard
open Finset

/-- The paper's strict tolerance-one additive energy. -/
noncomputable def strictAddEnergy (W : Finset ℝ) : ℕ :=
  (((W ×ˢ W) ×ˢ (W ×ˢ W)).filter fun q =>
    |q.1.1+q.1.2-q.2.1-q.2.2| < 1).card

/-- Equal pair-sum floor bins already lie in the strict energy. -/
theorem pairSumFloor_square_le_strict_energy (W : Finset ℝ) :
    ∑ j ∈ gmPairSumFloorSupport W, gmPairSumFloorCount W j^2 ≤ strictAddEnergy W := by
  rw [sum_pairSumFloorCount_sq]
  unfold gmFloorMatchedPairSums strictAddEnergy
  apply Finset.card_le_card
  intro q hq
  simp only [Finset.mem_filter,Finset.mem_product,gmOrdinatePairs] at hq ⊢
  exact ⟨hq.1,abs_pairSum_defect_lt_one_of_floor_eq hq.2⟩

/-- Every shifted floor correlation has the same strict-energy majorant. -/
theorem gmPairSumFloorCorrelation_le_strict_energy (W : Finset ℝ) (k : ℤ) :
    gmPairSumFloorCorrelation W k ≤ strictAddEnergy W := by
  let S := gmPairSumFloorCorrelationSupport W k
  let E := ∑ j ∈ gmPairSumFloorSupport W, gmPairSumFloorCount W j^2
  have hcs : (gmPairSumFloorCorrelation W k)^2 ≤ E*E := by
    unfold gmPairSumFloorCorrelation
    simpa [S,E,sum_pairSumFloorCount_sq_correlationSupport,
      sum_shifted_pairSumFloorCount_sq_correlationSupport] using
      (sum_mul_sq_le_sq_mul_sq (R := ℕ) S
        (fun j => gmPairSumFloorCount W (j+k)) (fun j => gmPairSumFloorCount W j))
  have hc : gmPairSumFloorCorrelation W k ≤ E := by nlinarith
  exact hc.trans (pairSumFloor_square_le_strict_energy W)

/-- A closed unit defect crosses at most one integer floor-bin boundary. -/
theorem abs_pairSumFloorDefect_le_one_of_closed
    (q : (ℝ × ℝ) × (ℝ × ℝ))
    (hq : |q.1.1+q.1.2-q.2.1-q.2.2| ≤ 1) :
    gmPairSumFloorDefect q ∈ Finset.Icc (-1 : ℤ) 1 := by
  have h := abs_sub_pairSumFloorDefect_cast_lt_one q
  have hk : |(gmPairSumFloorDefect q : ℝ)| < 2 := by
    have htri : |(gmPairSumFloorDefect q : ℝ)| ≤
        |(q.1.1+q.1.2-q.2.1-q.2.2)-(gmPairSumFloorDefect q : ℝ)|+
          |q.1.1+q.1.2-q.2.1-q.2.2| := by
      calc
        _ = |(q.1.1+q.1.2-q.2.1-q.2.2)-
            ((q.1.1+q.1.2-q.2.1-q.2.2)-(gmPairSumFloorDefect q : ℝ))| := by
          congr 1
          ring
        _ ≤ _ := by
          simpa only [add_comm] using (abs_sub
            (q.1.1+q.1.2-q.2.1-q.2.2)
            ((q.1.1+q.1.2-q.2.1-q.2.2)-(gmPairSumFloorDefect q : ℝ)))
    linarith
  have hlo : (-2 : ℤ) < gmPairSumFloorDefect q := by
    exact_mod_cast (abs_lt.mp hk).1
  have hhi : gmPairSumFloorDefect q < (2 : ℤ) := by
    exact_mod_cast (abs_lt.mp hk).2
  rw [Finset.mem_Icc]
  constructor <;> omega

/-- The tolerance convention changes energy by at most an absolute factor three. -/
theorem closed_energy_le_three_strict (W : Finset ℝ) :
    ApproxAddEnergy 1 W ≤ 3*strictAddEnergy W := by
  let P := (gmOrdinatePairs W) ×ˢ (gmOrdinatePairs W)
  let K := Finset.Icc (-1 : ℤ) 1
  have hsub : approximateAdditiveQuadruples 1 W ⊆
      P.filter (fun q => gmPairSumFloorDefect q ∈ K) := by
    intro q hq
    have hd := (Finset.mem_filter.mp hq).2
    exact Finset.mem_filter.mpr
      ⟨(Finset.mem_filter.mp hq).1,abs_pairSumFloorDefect_le_one_of_closed q hd⟩
  calc
    ApproxAddEnergy 1 W ≤ (P.filter fun q => gmPairSumFloorDefect q ∈ K).card :=
      Finset.card_le_card hsub
    _ = ∑ k ∈ K, (P.filter fun q => gmPairSumFloorDefect q = k).card :=
      (Finset.sum_card_fiberwise_eq_card_filter P K gmPairSumFloorDefect).symm
    _ = ∑ k ∈ K, gmPairSumFloorDefectCount W k := rfl
    _ ≤ ∑ _k ∈ K, strictAddEnergy W := by
      apply Finset.sum_le_sum
      intro k hk
      rw [gmPairSumFloorDefectCount_eq_correlation]
      exact gmPairSumFloorCorrelation_le_strict_energy W k
    _ = 3*strictAddEnergy W := by simp [K,Int.card_Icc]

/-- Strict energy embeds in the source's closed energy. -/
theorem strict_energy_le_closed (W : Finset ℝ) :
    strictAddEnergy W ≤ ApproxAddEnergy 1 W := by
  apply Finset.card_le_card
  intro q hq
  exact Finset.mem_filter.mpr ⟨(Finset.mem_filter.mp hq).1,(Finset.mem_filter.mp hq).2.le⟩

/-- The paper's strict energy convention costs only an absolute constant,
with the same scale, separation, epsilon exponent and inverse-power remainder. -/
theorem gmCubicS3_prop8_1_strict_energy (cutoff : GMSmoothCutoff)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ C T₀ : ℝ, 0 < C ∧ 1 ≤ T₀ ∧ ∀ {T : ℝ} {N : ℕ} {W : Finset ℝ},
      T₀ ≤ T → 0 < N → (N : ℝ) ≤ T → T^(2/3 : ℝ) ≤ (N : ℝ) →
      IsSeparated 1 W → InBaseInterval T W →
      ‖gmCubicS3 cutoff N W‖ ≤
        C*T^(2+ε)*Real.sqrt (W.card : ℝ)*Real.sqrt (strictAddEnergy W : ℝ)+C/T^90 := by
  obtain ⟨C,T₀,hC,hT₀,h⟩ := gmCubicS3_prop8_1_native cutoff ε hε
  refine ⟨2*C,T₀,by positivity,hT₀,?_⟩
  intro T N W hT hN hNT hlo hs hi
  have hTpos : 0 < T := by linarith [hT₀]
  have he : (ApproxAddEnergy 1 W : ℝ) ≤ 3*(strictAddEnergy W : ℝ) := by
    exact_mod_cast closed_energy_le_three_strict W
  have hroot3 : Real.sqrt 3 ≤ 2 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3),Real.sqrt_nonneg (3 : ℝ)]
  have hr : Real.sqrt (ApproxAddEnergy 1 W : ℝ) ≤ 2*Real.sqrt (strictAddEnergy W : ℝ) := by
    calc
      _ ≤ Real.sqrt (3*(strictAddEnergy W : ℝ)) := Real.sqrt_le_sqrt he
      _ = Real.sqrt 3*Real.sqrt (strictAddEnergy W : ℝ) := Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 3) _
      _ ≤ _ := mul_le_mul_of_nonneg_right hroot3 (Real.sqrt_nonneg _)
  calc
    _ ≤ C*T^(2+ε)*Real.sqrt (W.card : ℝ)*Real.sqrt (ApproxAddEnergy 1 W : ℝ)+C/T^90 :=
      h hT hN hNT hlo hs hi
    _ ≤ C*T^(2+ε)*Real.sqrt (W.card : ℝ)*(2*Real.sqrt (strictAddEnergy W : ℝ))+(2*C)/T^90 :=
      add_le_add (mul_le_mul_of_nonneg_left hr (by positivity))
        (div_le_div_of_nonneg_right (by linarith) (by positivity))
    _ = _ := by ring

end Legendre.Density.GuthMaynard
