/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local arithmetic assembly of actual compact-detector pointwise bounds.
Mobius coefficients, smoothing and the divided-endpoint loss are explicit.
-/
module
public import Legendre.Layer4.DetectorDividedPrefixes

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex Set
open scoped BigOperators

/-- A proved divided-prefix bound controls the actual Mobius detector with loss at most 2X. -/
theorem polynomial_block_of_prefix_bound (X U V : ℕ) (hU : 1 ≤ U) (hXU : X ≤ U)
    (hUV : U ≤ V) (hV : V ≤ 2*U) (β t Y : ℝ) (hβ : 0 ≤ β) (hβ1 : β ≤ 1)
    (hY : 0 < Y) (B : ℕ → ℝ) (hB : ∀ m, 0 ≤ B m)
    (hmono : ∀ m : ℕ, m ≤ U → B m ≤ B U)
    (hb : ∀ m : ℕ, 1 ≤ m → m ≤ U → ∀ W : ℕ, m ≤ W → W ≤ 2*m →
      ‖∑ n ∈ Finset.Ioc m W, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤ B m*(m : ℝ)^(-β)) :
    ‖∑ n ∈ Finset.Ioc U V, polynomialCoefficient X Y n*(n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤
      2*(X : ℝ)*(U : ℝ)^(-β)*(B U+1) := by
  classical
  rw [polynomial_block_divisor_expansion X U V hXU Y]
  have hterm (d : ℕ) (hd : d ∈ Finset.Icc 1 X) :
      ‖mobiusCutoff X d*(d : ℂ)^(-((β : ℂ)+(t : ℂ)*I))*
        ∑ k ∈ Finset.Ioc (U/d) (V/d), detectorWeight (((d*k : ℕ) : ℝ)/Y)*
          (k : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤
      2*(U : ℝ)^(-β)*(B U+1) := by
    have hd1 := (Finset.mem_Icc.mp hd).1
    have hdp : 0 < d := by omega
    have hdU : d ≤ U := (Finset.mem_Icc.mp hd).2.trans hXU
    have he := divided_block_endpoints d U V hdp hdU hV
    have hmU : U/d ≤ U := Nat.div_le_self U d
    have hprefix (W : ℕ) (hmW : U/d ≤ W) (hWV : W ≤ V/d) :
        ‖∑ n ∈ Finset.Ioc (U/d) W, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤
          (B (U/d)+1)*((U/d : ℕ) : ℝ)^(-β) := by
      exact complex_prefix_extra_endpoint (U/d) W he.1 hmW (hWV.trans he.2.1)
        β t (B (U/d)) hβ (hB _) (hb (U/d) he.1 hmU)
    have hsm := norm_dilated_smoothed_block d (U/d) (V/d) hdp
      (Nat.div_le_div_right hUV) Y ((B (U/d)+1)*((U/d : ℕ) : ℝ)^(-β)) hY
      (by have hh := hB (U/d); positivity)
      (fun n => (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))) hprefix
    have hBm := hB (U/d)
    have hBU := hB U
    rw [norm_mul,norm_mul,complex_block_norm_term d hdp]
    calc
      _ ≤ (1*(d : ℝ)^(-β))*((B (U/d)+1)*((U/d : ℕ) : ℝ)^(-β)) := by
        exact mul_le_mul (mul_le_mul_of_nonneg_right (mobiusCutoff_norm X d) (by positivity))
          hsm (norm_nonneg _) (by positivity)
      _ = ((d : ℝ)^(-β)*((U/d : ℕ) : ℝ)^(-β))*(B (U/d)+1) := by ring
      _ ≤ (2*(U : ℝ)^(-β))*(B U+1) := by
        exact mul_le_mul (divided_real_part_weight d U hdp hdU β hβ hβ1)
          (add_le_add (hmono (U/d) hmU) (le_rfl : (1 : ℝ) ≤ 1)) (by positivity) (by positivity)
      _ = _ := by ring
  have hh := (norm_sum_le _ _).trans (Finset.sum_le_sum hterm)
  simp only [Finset.sum_const,nsmul_eq_mul,Nat.card_Icc,show X+1-1 = X by omega] at hh
  convert hh using 1 <;> ring

end Legendre.Density.Detector.Smooth

namespace Legendre.Density.Oscillation

noncomputable def generalWeylCost (U : ℕ) (t : ℝ) : ℝ :=
  logarithmicWeylConstant*(Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)+
    (U : ℝ)*((U : ℝ)/|t|)^(1/4 : ℝ)+(U : ℝ)/|t|^(1/3 : ℝ))

noncomputable def secondDerivativeCost (U : ℕ) (t : ℝ) : ℝ :=
  logarithmicSecondConstant*(Real.sqrt |t|+(U : ℝ)/Real.sqrt |t|)

theorem generalWeylCost_nonneg (U : ℕ) (t : ℝ) : 0 ≤ generalWeylCost U t := by
  have hh := logarithmicWeylConstant_pos
  dsimp only [generalWeylCost]
  positivity

theorem secondDerivativeCost_nonneg (U : ℕ) (t : ℝ) : 0 ≤ secondDerivativeCost U t := by
  have hh := logarithmicSecondConstant_pos
  dsimp only [secondDerivativeCost]
  positivity

theorem generalWeylCost_mono (t : ℝ) : Monotone (fun U : ℕ => generalWeylCost U t) := by
  intro U V hUV
  have hUr : (U : ℝ) ≤ V := by exact_mod_cast hUV
  have hh := logarithmicWeylConstant_pos
  dsimp only [generalWeylCost]
  gcongr

theorem secondDerivativeCost_mono (t : ℝ) : Monotone (fun U : ℕ => secondDerivativeCost U t) := by
  intro U V hUV
  have hUr : (U : ℝ) ≤ V := by exact_mod_cast hUV
  have hh := logarithmicSecondConstant_pos
  dsimp only [secondDerivativeCost]
  gcongr

end Legendre.Density.Oscillation

namespace Legendre.Density.Detector.Smooth
open Complex Set
open scoped BigOperators

/-- General Weyl cancellation now controls the actual Mobius-smoothed polynomial. -/
theorem polynomial_block_general_weyl (X U V : ℕ) (hU : 1 ≤ U) (hXU : X ≤ U)
    (hUV : U ≤ V) (hV : V ≤ 2*U) (β t Y : ℝ) (hβ : 0 ≤ β) (hβ1 : β ≤ 1)
    (ht : 1 ≤ |t|) (hY : 0 < Y) :
    ‖∑ n ∈ Finset.Ioc U V, polynomialCoefficient X Y n*(n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤
      2*(X : ℝ)*(U : ℝ)^(-β)*(Oscillation.generalWeylCost U t+1) := by
  exact polynomial_block_of_prefix_bound X U V hU hXU hUV hV β t Y hβ hβ1 hY
    (fun m => Oscillation.generalWeylCost m t) (fun m => Oscillation.generalWeylCost_nonneg m t)
    (fun m hm => Oscillation.generalWeylCost_mono t hm)
    (fun m hm hmU W hmW hW => Oscillation.logarithmic_block_general_weighted m W hm hmW hW β t hβ ht)

/-- Second-derivative cancellation controls the same actual coefficient sequence. -/
theorem polynomial_block_second_derivative (X U V : ℕ) (hU : 1 ≤ U) (hXU : X ≤ U)
    (hUV : U ≤ V) (hV : V ≤ 2*U) (β t Y : ℝ) (hβ : 0 ≤ β) (hβ1 : β ≤ 1)
    (ht : t ≠ 0) (hY : 0 < Y) :
    ‖∑ n ∈ Finset.Ioc U V, polynomialCoefficient X Y n*(n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤
      2*(X : ℝ)*(U : ℝ)^(-β)*(Oscillation.secondDerivativeCost U t+1) := by
  exact polynomial_block_of_prefix_bound X U V hU hXU hUV hV β t Y hβ hβ1 hY
    (fun m => Oscillation.secondDerivativeCost m t) (fun m => Oscillation.secondDerivativeCost_nonneg m t)
    (fun m hm => Oscillation.secondDerivativeCost_mono t hm)
    (fun m hm hmU W hmW hW => Oscillation.logarithmic_block_second_weighted m W hm hmW hW β t hβ ht)

end Legendre.Density.Detector.Smooth
