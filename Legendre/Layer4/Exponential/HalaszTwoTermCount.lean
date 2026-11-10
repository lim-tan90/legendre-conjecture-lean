/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local logarithmic simplification of the proved large-value count.
-/
module
public import Legendre.Layer4.Exponential.HalaszLargeValues

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def halaszCountConstant : ℝ :=
  (18+864*logarithmicKernelConstant^2)*(1+2*logarithmicKernelConstant)

theorem halaszCountConstant_pos : 0 < halaszCountConstant := by
  have hc := logarithmicKernelConstant_pos
  unfold halaszCountConstant
  positivity

theorem halaszLargeValueBound_two_term (U : ℕ) (T E W : ℝ) (hU : 1 ≤ U) (hT : 1 ≤ T)
    (hE : 0 ≤ E) (hW : 0 < W) :
    halaszLargeValueBound U T E W ≤
      halaszCountConstant*(1+Real.log (2*U))^6*(1+Real.log (2*T))*
        ((U : ℝ)*E/W^2+(U : ℝ)*T*E^3/W^6) := by
  let L := 1+Real.log (2*U)
  let H := 1+Real.log (2*T)
  let B := halaszRealPartCost U
  let C := logarithmicKernelConstant
  have hC : 0 < C := logarithmicKernelConstant_pos
  have hB : 0 < B := halaszRealPartCost_pos U
  have hlogU : 0 ≤ Real.log (2*U) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ 2*U by omega))
  have hlogT : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
  have hL : 1 ≤ L := by dsimp [L]; linarith
  have hH : 1 ≤ H := by dsimp [H]; linarith
  have hBL : B ≤ 3*L^2 := by dsimp [B,L,halaszRealPartCost]; nlinarith
  have hB6 : B ≤ 3*L^6 := hBL.trans (mul_le_mul_of_nonneg_left
    (pow_le_pow_right₀ hL (by norm_num : (2 : ℕ) ≤ 6)) (by norm_num : (0 : ℝ) ≤ 3))
  have hB3 : B^3 ≤ 27*L^6 := by
    have hh := pow_le_pow_left₀ hB.le hBL 3
    convert hh using 1 <;> ring
  have hHcost : 1+2*C*H ≤ (1+2*C)*H := by nlinarith
  have hHcost0 : 0 ≤ 1+2*C*H := by positivity
  have hfirst : 6*B*(1+2*C*H) ≤ 18*(1+2*C)*L^6*H := by
    have hh := mul_le_mul hB6 hHcost hHcost0 (by positivity : 0 ≤ 3*L^6)
    nlinarith
  have hsecond : 32*B^3*C^2*(1+2*C*H) ≤ 864*C^2*(1+2*C)*L^6*H := by
    have hh := mul_le_mul hB3 hHcost hHcost0 (by positivity : 0 ≤ 27*L^6)
    have hm := mul_le_mul_of_nonneg_left hh (show 0 ≤ 32*C^2 by positivity)
    nlinarith
  have hk1 : 18*(1+2*C) ≤ halaszCountConstant := by
    unfold halaszCountConstant
    change 18*(1+2*C) ≤ (18+864*C^2)*(1+2*C)
    gcongr
    nlinarith [sq_nonneg C]
  have hk2 : 864*C^2*(1+2*C) ≤ halaszCountConstant := by
    unfold halaszCountConstant
    change 864*C^2*(1+2*C) ≤ (18+864*C^2)*(1+2*C)
    gcongr
    linarith
  have hk1' : 18*(1+2*C)*L^6*H ≤ halaszCountConstant*L^6*H := by
    have hh := mul_le_mul_of_nonneg_right hk1 (show 0 ≤ L^6*H by positivity)
    nlinarith
  have hk2' : 864*C^2*(1+2*C)*L^6*H ≤ halaszCountConstant*L^6*H := by
    have hh := mul_le_mul_of_nonneg_right hk2 (show 0 ≤ L^6*H by positivity)
    nlinarith
  have hf := hfirst.trans hk1'
  have hg := hsecond.trans hk2' 
  have hp := mul_le_mul_of_nonneg_right hf (show 0 ≤ (U : ℝ)*E/W^2 by positivity)
  have hq := mul_le_mul_of_nonneg_right hg (show 0 ≤ (U : ℝ)*T*E^3/W^6 by positivity)
  have he : halaszLargeValueBound U T E W =
      (6*B*(1+2*C*H))*((U : ℝ)*E/W^2)+
        (32*B^3*C^2*(1+2*C*H))*((U : ℝ)*T*E^3/W^6) := by
    unfold halaszLargeValueBound
    dsimp [B,C,H]
    field_simp
    ring
  rw [he]
  have hh := add_le_add hp hq
  dsimp [L,H] at hh
  convert hh using 1 <;> ring

/-- The classical two-term large-value shape, with a uniform numerical constant. -/
theorem halasz_complex_large_values_two_term {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (T σ b W : ℝ) (hT : 1 ≤ T) (hW : 0 < W)
    (hσb : σ ≤ b) (hlen : b-σ ≤ 1) (hβ : ∀ i ∈ S, β i ∈ Icc σ b)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) :
    (S.card : ℝ) ≤ halaszCountConstant*(1+Real.log (2*U))^6*(1+Real.log (2*T))*
      ((U : ℝ)*coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ)/W^2+
        (U : ℝ)*T*(coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ))^3/W^6) :=
  (halasz_complex_large_values S t β U hU a T σ b W hT hW hσb hlen hβ ht hs hw).trans
    (halaszLargeValueBound_two_term U T _ W hU hT (coefficientEnergy_nonneg _ _) hW)

end Legendre.Density.Oscillation
