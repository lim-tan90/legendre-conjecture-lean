/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local numerical deductions from the proved block-length sampling estimate.
Both endpoint powers are retained: Y^(2-2*sigma) and T*X^(1-2*sigma).
-/
module
public import Legendre.Layer4.PolynomialBlockSampling

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

noncomputable def polynomialBlockConstant : ℝ := 18*(3+4*Real.pi)

theorem polynomialBlockConstant_pos : 0 < polynomialBlockConstant := by
  unfold polynomialBlockConstant
  positivity

theorem polynomialBlock_cost_log (U : ℕ) (hU : 1 ≤ U) (T Y : ℝ) (hT : 1 ≤ T)
    (hUY : (U : ℝ) ≤ Y) :
    polynomialBlockSamplingCost U T ≤
      9*(3+4*Real.pi)*(1+Real.log (2*Y+1))^3*((U : ℝ)+T) := by
  let L := 1+Real.log (2*Y+1)
  have hUR : (1 : ℝ) ≤ U := by exact_mod_cast hU
  have hY : 1 ≤ Y := hUR.trans hUY
  have hLN : 0 ≤ Real.log (2*U) := Real.log_nonneg (by linarith)
  have hL : 1 ≤ L := by
    have := Real.log_nonneg (by linarith : 1 ≤ 2*Y+1)
    dsimp [L]
    linarith
  have hlog : Real.log (2*U) ≤ Real.log (2*Y+1) :=
    Real.log_le_log (by positivity) (by linarith)
  have ha : 2+(Real.log (2*U))^2 ≤ 3*L^2 := by
    have hh := pow_le_pow_left₀ hLN (by dsimp [L]; linarith : Real.log (2*U) ≤ L) 2
    nlinarith [sq_nonneg (L-1)]
  have hb : 1+2*Real.log (2*U) ≤ 3*L := by dsimp [L] at *; linarith
  have hc : 2*T+1+4*Real.pi*(U : ℝ) ≤ (3+4*Real.pi)*((U : ℝ)+T) := by
    nlinarith [Real.pi_pos]
  have hh := mul_le_mul (mul_le_mul ha hb (by positivity) (by positivity)) hc
    (by positivity) (by positivity)
  unfold polynomialBlockSamplingCost
  convert hh using 1
  dsimp [L]
  ring

theorem block_endpoint_powers (X U : ℕ) (hX : 1 ≤ X) (hXU : X ≤ U)
    (T Y σ : ℝ) (hT : 0 ≤ T) (hUY : (U : ℝ) ≤ Y) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    ((U : ℝ)+T)*(U : ℝ)^(1-2*σ) ≤ Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ) := by
  have hXp : (0 : ℝ) < X := by exact_mod_cast (show 0 < X by omega)
  have hXR : (X : ℝ) ≤ U := by exact_mod_cast hXU
  have hUp : (0 : ℝ) < U := hXp.trans_le hXR
  have hm := Real.rpow_le_rpow_of_nonpos hXp hXR (by linarith : 1-2*σ ≤ 0)
  have hy := Real.rpow_le_rpow hUp.le hUY (by linarith : 0 ≤ 2-2*σ)
  have he : (U : ℝ)*(U : ℝ)^(1-2*σ) = (U : ℝ)^(2-2*σ) := by
    rw [show 2-2*σ = 1+(1-2*σ) by ring,Real.rpow_add hUp,Real.rpow_one]
  rw [add_mul,he]
  exact add_le_add hy (mul_le_mul_of_nonneg_left hm hT)

theorem polynomialBlock_uniform {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (X U : ℕ) (hX : 1 ≤ X) (hXU : X ≤ U) (a : ℕ → ℂ) (T Y σ : ℝ)
    (hT : 1 ≤ T) (hUY : (U : ℝ) ≤ Y) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1)
    (ht : ∀ i ∈ S, |t i| ≤ T) (hβ : ∀ i ∈ S, β i ∈ Icc σ 1)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (ha : ∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ n.divisors.card) :
    (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
      polynomialBlockConstant*(1+Real.log (2*Y+1))^6*
        (Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ)) := by
  have hU : 1 ≤ U := hX.trans hXU
  have hUR : (1 : ℝ) ≤ U := by exact_mod_cast hU
  have hUp : (0 : ℝ) < U := by linarith
  let L := 1+Real.log (2*Y+1)
  have hlN : 0 ≤ 1+Real.log (2*U) := by
    have := Real.log_nonneg (by linarith : 1 ≤ (2 : ℝ)*U)
    linarith
  have hlog : 1+Real.log (2*U) ≤ L := by
    have hh := Real.log_le_log (by positivity : 0 < (2 : ℝ)*U) (by linarith : (2 : ℝ)*U ≤ 2*Y+1)
    dsimp [L]
    linarith
  have hL : 0 ≤ L := hlN.trans hlog
  have he : (U : ℝ)*(U : ℝ)^(-2*σ) = (U : ℝ)^(1-2*σ) := by
    rw [show 1-2*σ = 1+(-2*σ) by ring,Real.rpow_add hUp,Real.rpow_one]
  have hb := polynomialBlock_samples S t β U hU a T σ hT (by linarith) hσ1 ht hβ hsep ha
  have hcost := polynomialBlock_cost_log U hU T Y hT hUY
  have henergy : 2*(U : ℝ)*(1+Real.log (2*U))^3*(U : ℝ)^(-2*σ) ≤
      2*(U : ℝ)*L^3*(U : ℝ)^(-2*σ) := by
    gcongr
  have hh := mul_le_mul hcost henergy (by positivity) (by positivity)
  have hpow := block_endpoint_powers X U hX hXU T Y σ (by linarith) hUY hσ hσ1
  have hm := mul_le_mul_of_nonneg_left hpow
    (show 0 ≤ polynomialBlockConstant*L^6 by have := polynomialBlockConstant_pos; positivity)
  apply hb.trans (hh.trans ?_)
  calc
    _ = polynomialBlockConstant*L^6*(((U : ℝ)+T)*(U : ℝ)^(1-2*σ)) := by
      unfold polynomialBlockConstant
      rw [← he]
      ring
    _ ≤ _ := hm

end Legendre.Density.Moment
