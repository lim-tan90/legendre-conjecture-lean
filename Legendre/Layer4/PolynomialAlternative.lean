/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The block assembly adapts DensityPolynomialAlternative.lean in openai/math,
commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Local sharp variable-real-part sampling gives eight logarithms for zeta.
The literal compensated detector threshold is 1/16.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.PolynomialBlockCost
public import Legendre.Layer4.DetectorDyadicCover
public import Legendre.Layer4.FiniteBlockSquare

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem polynomial_actual_block {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (X U : ℕ) (hX : 1 ≤ X) (hXU : X ≤ U) (T Y σ : ℝ)
    (hT : 1 ≤ T) (hY : 2 ≤ Y) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1)
    (ht : ∀ i ∈ S, |t i| ≤ T) (hβ : ∀ i ∈ S, β i ∈ Icc σ 1)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), Detector.Smooth.polynomialCoefficient X Y n*
      (n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
      polynomialBlockConstant*(1+Real.log (2*Y+1))^6*
        (Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ)) := by
  by_cases hUY : (U : ℝ) ≤ Y
  · exact polynomialBlock_uniform S t β X U hX hXU _ T Y σ hT hUY hσ hσ1 ht hβ hsep
      (fun n _ => Detector.Smooth.polynomialCoefficient_norm X Y (by linarith) n)
  · have hzero (i : ι) : (∑ n ∈ Finset.Ioc U (2*U), Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))) = 0 := by
      apply Finset.sum_eq_zero
      intro n hn
      have hUn : (U : ℝ) < n := by exact_mod_cast (Finset.mem_Ioc.mp hn).1
      have hYn : Y ≤ (n : ℝ) := by linarith
      rw [Detector.Smooth.polynomialCoefficient_above X n Y (by linarith) hYn,zero_mul]
    simp_rw [hzero,norm_zero,zero_pow (by decide : (2 : ℕ) ≠ 0),Finset.sum_const_zero]
    have := polynomialBlockConstant_pos
    positivity

theorem polynomial_alternative_count :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ Y T σ : ℝ,
      2 ≤ Y → 1 ≤ T → 1/2 ≤ σ → σ ≤ 1 → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ) ≤ C*(1+Real.log (2*Y+1))^8*
        (Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ)) := by
  let A := 2/Real.log 2
  have hA : 0 < A := by dsimp [A]; positivity
  refine ⟨256*polynomialBlockConstant*A^2,by have := polynomialBlockConstant_pos; positivity,?_⟩
  intro X hX Y T σ hY hT hσ hσ1 ι S t β ht hs hβ hlarge
  obtain ⟨J,_hJ,hcover,hJbound⟩ := moment_detector_dyadic_cover X hX Y hY
  let L := 1+Real.log (2*Y+1)
  let G := Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ)
  let f := fun i j => ∑ n ∈ Finset.Ioc (2^j*X) (2*(2^j*X)),
    Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))
  have hL : 0 ≤ L := by
    have := Real.log_nonneg (by linarith : 1 ≤ 2*Y+1)
    dsimp [L]
    linarith
  have hG : 0 ≤ G := by dsimp [G]; positivity
  have hblock (j : ℕ) : (∑ i ∈ S, ‖f i j‖^2) ≤ polynomialBlockConstant*L^6*G := by
    apply polynomial_actual_block S t β X (2^j*X) hX _ T Y σ hT hY hσ hσ1 ht hβ hs
    exact Nat.le_mul_of_pos_left X (by positivity)
  have hlower : (S.card : ℝ)/256 ≤ ∑ i ∈ S, ‖∑ j ∈ Finset.range J, f i j‖^2 := by
    have h := Finset.sum_le_sum (s := S) (fun i hi =>
      show (1/256 : ℝ) ≤ ‖∑ j ∈ Finset.range J, f i j‖^2 from by
        have hh := hlarge i hi
        rw [Detector.Smooth.detectorTail_blocks X J hX Y (by linarith) hcover] at hh
        change (1/16 : ℝ) ≤ ‖∑ j ∈ Finset.range J, f i j‖ at hh
        nlinarith [norm_nonneg (∑ j ∈ Finset.range J, f i j)])
    simpa only [Finset.sum_const,nsmul_eq_mul,div_eq_mul_inv,one_mul] using h
  have hupper : (∑ i ∈ S, ‖∑ j ∈ Finset.range J, f i j‖^2) ≤
      (J : ℝ)^2*(polynomialBlockConstant*L^6*G) := by
    apply (moment_finite_block_square S J f).trans
    have h := mul_le_mul_of_nonneg_left (Finset.sum_le_sum (s := Finset.range J) (fun j _ => hblock j))
      (Nat.cast_nonneg J : (0 : ℝ) ≤ J)
    simpa only [Finset.sum_const,Finset.card_range,nsmul_eq_mul,pow_two,mul_assoc] using h
  have hlog : Real.log Y ≤ L := by
    have h := Real.log_le_log (by linarith : 0 < Y) (by linarith : Y ≤ 2*Y+1)
    dsimp [L]
    linarith
  have hJ : (J : ℝ) ≤ A*L := hJbound.trans (mul_le_mul_of_nonneg_left hlog hA.le)
  have hJ2 := pow_le_pow_left₀ (Nat.cast_nonneg J : (0 : ℝ) ≤ J) hJ 2
  have hfinal := hlower.trans (hupper.trans (mul_le_mul_of_nonneg_right hJ2 (by
    have := polynomialBlockConstant_pos
    positivity)))
  have hh := mul_le_mul_of_nonneg_left hfinal (by norm_num : (0 : ℝ) ≤ 256)
  convert hh using 1
  · ring
  · dsimp [L,G]
    ring

end Legendre.Density.Moment
