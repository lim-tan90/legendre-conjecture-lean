/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The block assembly adapts DensityPolynomialAlternative.lean in openai/math,
commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Dyadic variable-real-part sampling reduces the source bound to five logarithms.
The literal compensated detector threshold is 1/16.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.PolynomialBlockCost
public import Legendre.Layer4.DetectorDyadicCover
public import Legendre.Layer4.FiniteBlockSquare
public import Legendre.Layer4.DyadicVariableSampling

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

universe u

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

/-- Keep the dyadic length in both power terms of the polynomial branch. -/
theorem polynomial_actual_block_length :
    ∃ C : ℝ, 0 < C ∧ ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
      (X U : ℕ), 1 ≤ U → ∀ T Y σ : ℝ,
      1 ≤ T → 2 ≤ Y → (U : ℝ) ≤ Y → 1/2 ≤ σ →
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
        C*(1+Real.log (2*Y+1))^3*((U : ℝ)+T)*(U : ℝ)^(1-2*σ) := by
  obtain ⟨C,hC,hb⟩ := dyadic_variable_line_samples
  refine ⟨2*C,by positivity,?_⟩
  intro ι S t β X U hU T Y σ hT hY hUY hσ ht hβ hs
  let a := Detector.Smooth.polynomialCoefficient X Y
  have hUp : (0 : ℝ) < U := by exact_mod_cast hU
  have hU₁ : (1 : ℝ) ≤ U := by exact_mod_cast hU
  have hE := polynomialBlock_divisor_energy U hU a σ (by linarith)
    (fun n _ => Detector.Smooth.polynomialCoefficient_norm X Y (by linarith) n)
  rw [polynomialBlock_energy] at hE
  have h := hb S t β U a T σ hU hT (by linarith) ht hβ hs
  have hlog : 1+Real.log (2*(U : ℝ)) ≤ 1+Real.log (2*Y+1) :=
    add_le_add_right (Real.log_le_log (by positivity) (by linarith)) _
  have hlog0 : 0 ≤ 1+Real.log (2*(U : ℝ)) :=
    le_trans (by norm_num) (add_le_add_right
      (Real.log_nonneg (show 1 ≤ 2*(U : ℝ) by linarith)) 1)
  have hp : (U : ℝ)*(U : ℝ)^(-2*σ) = (U : ℝ)^(1-2*σ) := by
    rw [show 1-2*σ = 1+(-2*σ) by ring, Real.rpow_add hUp, Real.rpow_one]
  calc
    _ ≤ C*(T+(U : ℝ))*(2*(U : ℝ)*(1+Real.log (2*U))^3*(U : ℝ)^(-2*σ)) :=
      h.trans (mul_le_mul_of_nonneg_left hE (by positivity))
    _ = 2*C*(1+Real.log (2*U))^3*((U : ℝ)+T)*(U : ℝ)^(1-2*σ) := by rw [← hp]; ring
    _ ≤ _ := by
      have hlogR : 0 ≤ 1+Real.log (2*Y+1) := hlog0.trans hlog
      gcongr

theorem polynomial_actual_block_log_three :
    ∃ C : ℝ, 0 < C ∧ ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
      (X U : ℕ), 1 ≤ X → X ≤ U → ∀ T Y σ : ℝ,
      1 ≤ T → 2 ≤ Y → 1/2 ≤ σ → σ ≤ 1 →
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
        C*(1+Real.log (2*Y+1))^3*(Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ)) := by
  obtain ⟨C,hC,hb⟩ := polynomial_actual_block_length
  refine ⟨C,hC,?_⟩
  intro ι S t β X U hX hXU T Y σ hT hY hσ hσ1 ht hβ hs
  have hU : 1 ≤ U := hX.trans hXU
  let a := Detector.Smooth.polynomialCoefficient X Y
  by_cases hUY : (U : ℝ) ≤ Y
  · have h := hb S t β X U hU T Y σ hT hY hUY hσ ht hβ hs
    have hS := block_endpoint_powers X U hX hXU T Y σ (by linarith) hUY hσ hσ1
    have hL : 0 ≤ 1+Real.log (2*Y+1) := by
      linarith [Real.log_nonneg (show 1 ≤ 2*Y+1 by linarith)]
    exact h.trans (by
      rw [mul_assoc]
      exact mul_le_mul_of_nonneg_left hS (by positivity))
  · have hzero (i : ι) :
        (∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))) = 0 := by
      apply Finset.sum_eq_zero
      intro n hn
      have hnU : (U : ℝ) < n := by exact_mod_cast (Finset.mem_Ioc.mp hn).1
      exact mul_eq_zero.mpr (Or.inl (Detector.Smooth.polynomialCoefficient_above X n Y
        (by linarith) (by linarith)))
    change (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤ _
    simp_rw [hzero,norm_zero,zero_pow (by norm_num : 2 ≠ 0),Finset.sum_const_zero]
    have hlog := Real.log_nonneg (show 1 ≤ 2*Y+1 by linarith)
    positivity

theorem detectorTail_dyadic_count_lower {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (X J : ℕ) (hX : 1 ≤ X) (Y : ℝ) (hY : 2 ≤ Y) (hYJ : ⌊Y⌋₊ ≤ 2^J*X)
    (hlarge : ∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖) :
    (S.card : ℝ)/256 ≤ ∑ i ∈ S,
      ‖∑ j ∈ Finset.range J, ∑ n ∈ Finset.Ioc (2^j*X) (2*(2^j*X)),
        Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2 := by
  have h := Finset.sum_le_sum (s := S) (fun i hi =>
    show (1/256 : ℝ) ≤ ‖∑ j ∈ Finset.range J, ∑ n ∈ Finset.Ioc (2^j*X) (2*(2^j*X)),
        Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2 from by
      have hh := hlarge i hi
      rw [Detector.Smooth.detectorTail_blocks X J hX Y (by linarith) hYJ] at hh
      nlinarith [norm_nonneg (∑ j ∈ Finset.range J, ∑ n ∈ Finset.Ioc (2^j*X) (2*(2^j*X)),
        Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I)))])
  simpa only [Finset.sum_const,nsmul_eq_mul,div_eq_mul_inv,one_mul] using h

theorem polynomial_alternative_count_of_block (k : ℕ) (K : ℝ) (hK : 0 < K)
    (hb : ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ)
      (X U : ℕ), 1 ≤ X → X ≤ U → ∀ T Y σ : ℝ,
      1 ≤ T → 2 ≤ Y → 1/2 ≤ σ → σ ≤ 1 →
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
        K*(1+Real.log (2*Y+1))^k*(Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ))) :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ Y T σ : ℝ,
      2 ≤ Y → 1 ≤ T → 1/2 ≤ σ → σ ≤ 1 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ) ≤ C*(1+Real.log (2*Y+1))^(k+2)*
        (Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ)) := by
  let A := 2/Real.log 2
  have hA : 0 < A := by dsimp [A]; positivity
  refine ⟨256*K*A^2,by positivity,?_⟩
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
  have hblock (j : ℕ) : (∑ i ∈ S, ‖f i j‖^2) ≤ K*L^k*G := by
    apply hb S t β X (2^j*X) hX _ T Y σ hT hY hσ hσ1 ht hβ hs
    exact Nat.le_mul_of_pos_left X (by positivity)
  have hlower := detectorTail_dyadic_count_lower S t β X J hX Y hY hcover hlarge
  have hupper : (∑ i ∈ S, ‖∑ j ∈ Finset.range J, f i j‖^2) ≤
      (J : ℝ)^2*(K*L^k*G) := by
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
  have hfinal := hlower.trans (hupper.trans (mul_le_mul_of_nonneg_right hJ2 (by positivity)))
  have hh := mul_le_mul_of_nonneg_left hfinal (by norm_num : (0 : ℝ) ≤ 256)
  convert hh using 1
  · ring
  · dsimp [L,G]
    rw [pow_add]
    ring

theorem polynomial_alternative_count :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ Y T σ : ℝ,
      2 ≤ Y → 1 ≤ T → 1/2 ≤ σ → σ ≤ 1 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ) ≤ C*(1+Real.log (2*Y+1))^8*
        (Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ)) :=
  polynomial_alternative_count_of_block 6 polynomialBlockConstant polynomialBlockConstant_pos
    (fun S t β X U hX hXU T Y σ hT hY hσ hσ1 ht hβ hs =>
      polynomial_actual_block S t β X U hX hXU T Y σ hT hY hσ hσ1 ht hβ hs)

theorem polynomial_alternative_count_log_five :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ Y T σ : ℝ,
      2 ≤ Y → 1 ≤ T → 1/2 ≤ σ → σ ≤ 1 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ) ≤ C*(1+Real.log (2*Y+1))^5*
        (Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ)) := by
  obtain ⟨C,hC,hb⟩ := polynomial_actual_block_log_three
  exact polynomial_alternative_count_of_block 3 C hC hb

end Legendre.Density.Moment
