/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local assembly of the proved analytic large-value count for the actual compact
detector polynomial. The literal threshold is retained, with no density input.
-/
module
public import Legendre.Layer4.HalaszDivisorBlock
public import Legendre.Layer4.DetectorDyadicCover
public import Legendre.Layer4.DetectorPolynomial

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem exists_large_dyadic_piece (J : ℕ) (hJ : 1 ≤ J) (f : ℕ → ℂ) (W : ℝ)
    (hW : W ≤ ‖∑ j ∈ Finset.range J, f j‖) :
    ∃ j ∈ Finset.range J, W/(J : ℝ) ≤ ‖f j‖ := by
  classical
  by_contra hh
  have hl : ∀ j ∈ Finset.range J, ‖f j‖ < W/(J : ℝ) := by
    intro j hj
    exact lt_of_not_ge (fun he => hh ⟨j,hj,he⟩)
  have hs := Finset.sum_lt_sum_of_nonempty (s := Finset.range J)
    (Finset.nonempty_range_iff.mpr (by omega)) hl
  have hJp : (0 : ℝ) < J := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hJ)
  have he : (∑ _j ∈ Finset.range J, W/(J : ℝ)) = W := by
    simp only [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
    field_simp
  rw [he] at hs
  have hn := norm_sum_le (Finset.range J) f
  linarith

theorem halasz_reciprocal_threshold (v A B : ℝ) (hv : 1 ≤ v) (hA : 0 ≤ A) (hB : 0 ≤ B) :
    A/(1/v)^2+B/(1/v)^6 ≤ v^6*(A+B) := by
  have hh := pow_le_pow_right₀ hv (by norm_num : (2 : ℕ) ≤ 6)
  have hm := mul_le_mul_of_nonneg_left hh hA
  simp only [one_div,inv_pow,div_inv_eq_mul]
  nlinarith

theorem polynomial_halasz_actual_block {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (X U : ℕ) (hX : 1 ≤ X) (hXU : X ≤ U) (T Y σ W : ℝ)
    (hT : 1 ≤ T) (hY : 2 ≤ Y) (hσ : 2/3 ≤ σ) (hσ1 : σ ≤ 1) (hW : 0 < W)
    (ht : ∀ i ∈ S, |t i| ≤ T) (hβ : ∀ i ∈ S, β i ∈ Icc σ 1)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
      Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) :
    (S.card : ℝ) ≤ 8*Oscillation.halaszCountConstant*(1+Real.log (2*Y+1))^15*
      (1+Real.log (2*T))*(Y^(2-2*σ)/W^2+T*(X : ℝ)^(4-6*σ)/W^6) := by
  classical
  by_cases hUY : (U : ℝ) ≤ Y
  · exact halasz_divisor_block_count S t β X U hX hXU _ T Y σ W hT hY hUY hσ hσ1 hW ht hβ hs
      (fun n _ => Detector.Smooth.polynomialCoefficient_norm X Y (by linarith) n) hw
  · have hz (i : ι) : (∑ n ∈ Finset.Ioc U (2*U),
        Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))) = 0 := by
      apply Finset.sum_eq_zero
      intro n hn
      have hu : (U : ℝ) < n := by exact_mod_cast (Finset.mem_Ioc.mp hn).1
      rw [Detector.Smooth.polynomialCoefficient_above X n Y (by linarith) (by linarith),zero_mul]
    have he : S = ∅ := by
      apply Finset.eq_empty_iff_forall_notMem.mpr
      intro i hi
      have hh := hw i hi
      rw [hz i,norm_zero] at hh
      linarith
    rw [he,Finset.card_empty,Nat.cast_zero]
    have := Oscillation.halaszCountConstant_pos
    have := Real.log_nonneg (show 1 ≤ 2*T by linarith)
    have := Real.log_nonneg (show 1 ≤ 2*Y+1 by linarith)
    positivity

noncomputable def polynomialHalaszConstant : ℝ :=
  8*Oscillation.halaszCountConstant*16^6*(2/Real.log 2)^7

theorem polynomialHalaszConstant_pos : 0 < polynomialHalaszConstant := by
  have := Oscillation.halaszCountConstant_pos
  have : 0 < Real.log 2 := Real.log_pos (by norm_num)
  unfold polynomialHalaszConstant
  positivity

/-- The actual polynomial alternative with improved cutoff exponent 4-6 sigma. -/
theorem polynomial_alternative_halasz_count :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ Y T σ : ℝ,
      2 ≤ Y → 1 ≤ T → 2/3 ≤ σ → σ ≤ 1 → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ) ≤ C*(1+Real.log (2*Y+1))^22*(1+Real.log (2*T))*
        (Y^(2-2*σ)+T*(X : ℝ)^(4-6*σ)) := by
  refine ⟨polynomialHalaszConstant,polynomialHalaszConstant_pos,?_⟩
  intro X hX Y T σ hY hT hσ hσ1 ι S t β ht hs hβ hw
  classical
  obtain ⟨J,hJ,hcover,hJlog⟩ := moment_detector_dyadic_cover X hX Y hY
  let L := 1+Real.log (2*Y+1)
  let A := 2/Real.log 2
  let G := Y^(2-2*σ)+T*(X : ℝ)^(4-6*σ)
  let f := fun j i => ∑ n ∈ Finset.Ioc (2^j*X) (2*(2^j*X)),
    Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))
  let Q := fun j => S.filter (fun i => 1/(16*(J : ℝ)) ≤ ‖f j i‖)
  have hJp : (0 : ℝ) < J := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hJ)
  have hA : 0 < A := by dsimp [A]; positivity
  have hL : 1 ≤ L := by dsimp [L]; linarith [Real.log_nonneg (show 1 ≤ 2*Y+1 by linarith)]
  have hlog : Real.log Y ≤ L := by
    have := Real.log_le_log (show 0 < Y by linarith) (show Y ≤ 2*Y+1 by linarith)
    dsimp [L]; linarith
  have hJL : (J : ℝ) ≤ A*L := hJlog.trans (mul_le_mul_of_nonneg_left hlog hA.le)
  have hG : 0 ≤ G := by dsimp [G]; positivity
  have hsub : S ⊆ (Finset.range J).biUnion Q := by
    intro i hi
    have hh := hw i hi
    rw [Detector.Smooth.detectorTail_blocks X J hX Y (by linarith) hcover] at hh
    obtain ⟨j,hj,hlarge⟩ := exists_large_dyadic_piece J hJ (fun j => f j i) (1/16) hh
    refine Finset.mem_biUnion.mpr ⟨j,hj,Finset.mem_filter.mpr ⟨hi,?_⟩⟩
    convert hlarge using 1 <;> ring
  have hcard : (S.card : ℝ) ≤ ∑ j ∈ Finset.range J, ((Q j).card : ℝ) := by
    exact_mod_cast (Finset.card_le_card hsub).trans Finset.card_biUnion_le
  have hK := Oscillation.halaszCountConstant_pos
  have hlogT : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
  have hblock (j : ℕ) (hj : j ∈ Finset.range J) :
      ((Q j).card : ℝ) ≤ 8*Oscillation.halaszCountConstant*L^15*(1+Real.log (2*T))*(16*(J : ℝ))^6*G := by
    have hh := polynomial_halasz_actual_block (Q j) t β X (2^j*X) hX
      (Nat.le_mul_of_pos_left X (by positivity)) T Y σ (1/(16*(J : ℝ))) hT hY hσ hσ1 (by positivity)
      (fun i hi => ht i (Finset.mem_filter.mp hi).1)
      (fun i hi => hβ i (Finset.mem_filter.mp hi).1)
      (fun i hi k hk hik => hs i (Finset.mem_filter.mp hi).1 k (Finset.mem_filter.mp hk).1 hik)
      (fun i hi => (Finset.mem_filter.mp hi).2)
    have hc := halasz_reciprocal_threshold (16*(J : ℝ)) (Y^(2-2*σ)) (T*(X : ℝ)^(4-6*σ))
      (by
        have hh : (1 : ℝ) ≤ J := by exact_mod_cast hJ
        linarith) (by positivity) (by positivity)
    have hp := mul_le_mul_of_nonneg_left hc
      (show 0 ≤ 8*Oscillation.halaszCountConstant*L^15*(1+Real.log (2*T)) by positivity)
    exact hh.trans (by convert hp using 1 <;> dsimp [L,G] <;> ring)
  have hh := hcard.trans (Finset.sum_le_sum hblock)
  simp only [Finset.sum_const,Finset.card_range,nsmul_eq_mul] at hh
  have hpow := pow_le_pow_left₀ (Nat.cast_nonneg J : (0 : ℝ) ≤ J) hJL 7
  have hp := mul_le_mul_of_nonneg_right hpow
    (show 0 ≤ 8*Oscillation.halaszCountConstant*L^15*(1+Real.log (2*T))*16^6*G by positivity)
  apply hh.trans
  convert hp using 1 <;> dsimp [polynomialHalaszConstant,A,L,G] <;> ring

end Legendre.Density.Moment
