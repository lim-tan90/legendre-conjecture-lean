/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local assembly of the powered short-block count for the actual compact detector.
Only the polynomial alternative is counted in this module.
-/
module
public import Legendre.Layer4.HuxleyShortBlock
public import Legendre.Layer4.SmallMollifierTypeII

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- The actual Type I detector branch has the curved exponent in the power-selection range. -/
theorem huxley_actual_tail_epsilon_count (δ ε : ℝ) (hδ : 0 < δ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 3/4 ≤ σ → σ ≤ 5/6 →
      ∀ X : ℕ, T^δ ≤ (X : ℝ) → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖) →
      (S.card : ℝ) ≤ C*T^(huxleyCurvedExponent σ+ε) := by
  let K := huxleyPowerBudget δ
  let p := 6*K+1
  let A := 2/Real.log 2
  have hA : 0 < A := by dsimp [A]; positivity
  obtain ⟨C,hC,hshort⟩ := huxley_short_block_epsilon_count 1 δ (ε/2) hδ (by linarith)
  obtain ⟨D,hD,hlogs⟩ := exists_one_add_log_pow_le_rpow p (ε/2) (by linarith)
  refine ⟨C*16^(6*K)*A^p*D,by positivity,?_⟩
  intro T σ hT hσ hσu X hXlo ι S t β ht hβ hs hw
  classical
  have hTp : 0 < T := by linarith
  have hX : 1 ≤ X := by
    exact_mod_cast (Real.one_le_rpow (show 1 ≤ T by linarith) hδ.le).trans hXlo
  let Y := T^(1/2 : ℝ)
  let L := 1+Real.log T
  let G := T^(huxleyCurvedExponent σ+ε/2)
  have hY : 2 ≤ Y := by have hh := (sqrt_detector_scale T hT).1; dsimp [Y]; linarith
  obtain ⟨J,hJ,hcover,hJlog⟩ := moment_detector_dyadic_cover X hX Y hY
  have hJp : (0 : ℝ) < J := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hJ)
  have hJ1 : (1 : ℝ) ≤ J := by exact_mod_cast hJ
  have hL : 1 ≤ L := (height_log_costs T (by linarith)).1
  have hlogY : Real.log Y ≤ L := by
    dsimp [Y,L]
    rw [Real.log_rpow hTp]
    linarith [(height_log_costs T (by linarith)).2.1]
  have hJL : (J : ℝ) ≤ A*L := hJlog.trans (mul_le_mul_of_nonneg_left hlogY hA.le)
  let f := fun j i => ∑ n ∈ Finset.Ioc (2^j*X) (2*(2^j*X)),
    Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))
  let Q := fun j => S.filter (fun i => 1/(16*(J : ℝ)) ≤ ‖f j i‖)
  have hsub : S ⊆ (Finset.range J).biUnion Q := by
    intro i hi
    have hh := hw i hi
    rw [Detector.Smooth.detectorTail_blocks X J hX Y (by linarith) hcover] at hh
    obtain ⟨j,hj,hlarge⟩ := exists_large_dyadic_piece J hJ (fun j => f j i) (1/16) hh
    refine Finset.mem_biUnion.mpr ⟨j,hj,Finset.mem_filter.mpr ⟨hi,?_⟩⟩
    convert hlarge using 1 <;> ring
  have hcard : (S.card : ℝ) ≤ ∑ j ∈ Finset.range J, ((Q j).card : ℝ) := by
    exact_mod_cast (Finset.card_le_card hsub).trans Finset.card_biUnion_le
  have hblock (j : ℕ) (_hj : j ∈ Finset.range J) :
      ((Q j).card : ℝ) ≤ C*(16*(J : ℝ))^(6*K)*G := by
    have hXU : X ≤ 2^j*X := Nat.le_mul_of_pos_left _ (by positivity)
    by_cases hUY : (2^j*X : ℕ) ≤ Y
    · have hh := hshort T σ (by linarith) hσ hσu (2^j*X)
        (hXlo.trans (by exact_mod_cast hXU)) hUY (Detector.Smooth.polynomialCoefficient X Y)
        (fun n _ => by simpa only [pow_one] using Detector.Smooth.polynomialCoefficient_norm X Y (by linarith) n)
        (1/(16*(J : ℝ))) (by positivity) (by
          apply (div_le_one (by positivity : 0 < 16*(J : ℝ))).mpr
          linarith)
        (Q j) t β (fun i hi => ht i (Finset.mem_filter.mp hi).1)
        (fun i hi => hβ i (Finset.mem_filter.mp hi).1)
        (fun i hi l hl hil => hs i (Finset.mem_filter.mp hi).1 l (Finset.mem_filter.mp hl).1 hil)
        (fun i hi => (Finset.mem_filter.mp hi).2)
      simpa only [one_div,inv_pow,div_inv_eq_mul] using hh
    · have hzero (i : ι) : f j i = 0 := by
        apply Finset.sum_eq_zero
        intro n hn
        have hu : (2^j*X : ℕ) < n := (Finset.mem_Ioc.mp hn).1
        have hyn : Y ≤ n := by exact_mod_cast (lt_of_not_ge hUY).le.trans (by exact_mod_cast hu.le)
        rw [Detector.Smooth.polynomialCoefficient_above X n Y (by linarith) hyn,zero_mul]
      have he : Q j = ∅ := by
        apply Finset.eq_empty_iff_forall_notMem.mpr
        intro i hi
        have hh := (Finset.mem_filter.mp hi).2
        rw [hzero i,norm_zero] at hh
        have hp : 0 < 1/(16*(J : ℝ)) := by positivity
        linarith
      rw [he,Finset.card_empty,Nat.cast_zero]
      positivity
  have hc := hcard.trans (Finset.sum_le_sum hblock)
  simp only [Finset.sum_const,Finset.card_range,nsmul_eq_mul,mul_pow] at hc
  have hJpow : (J : ℝ)^p ≤ A^p*L^p := by
    simpa only [mul_pow] using pow_le_pow_left₀ (Nat.cast_nonneg J : (0 : ℝ) ≤ J) hJL p
  have hpow := hJpow.trans (mul_le_mul_of_nonneg_left (hlogs T (by linarith)) (by positivity))
  have hp := mul_le_mul_of_nonneg_left hpow (show 0 ≤ C*16^(6*K)*G by positivity)
  have he : G*T^(ε/2) = T^(huxleyCurvedExponent σ+ε) := by
    dsimp [G]
    rw [←Real.rpow_add hTp]
    congr 1
    ring
  calc
    _ ≤ (J : ℝ)*(C*(16^(6*K)*(J : ℝ)^(6*K))*G) := hc
    _ = (C*16^(6*K)*G)*(J : ℝ)^p := by dsimp [p]; rw [pow_succ]; ring
    _ ≤ (C*16^(6*K)*G)*(A^p*(D*T^(ε/2))) := hp
    _ = (C*16^(6*K)*A^p*D)*(G*T^(ε/2)) := by ring
    _ = _ := by rw [he]

end Legendre.Density.Moment
