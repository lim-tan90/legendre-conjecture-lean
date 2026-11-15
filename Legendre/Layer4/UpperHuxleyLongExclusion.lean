/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local exclusion of long actual detector blocks at the dyadic threshold.
The height threshold is uniform in sigma, the ordinates and block lengths.
-/
module
public import Legendre.Layer4.UpperHuxleyLongBlocks
public import Legendre.Layer4.HuxleyShortBlock

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set Filter
open scoped BigOperators Topology

/-- A small mollifier makes every long block smaller than the actual dyadic threshold. -/
theorem huxley_long_blocks_below_threshold (η δ : ℝ) (hη : 0 < η) (hδ : δ ≤ η/16) :
    ∃ T₀ : ℝ, 2 ≤ T₀ ∧ ∀ T : ℝ, T₀ ≤ T → ∀ σ β t Y : ℝ,
      5/6+η ≤ σ → σ ≤ β → β ≤ 1 → T/2 ≤ |t| → |t| ≤ T → 0 < Y →
      ∀ J : ℕ, 1 ≤ J → (J : ℝ) ≤ (2/Real.log 2)*Real.log T →
      ∀ X U V : ℕ, (X : ℝ) ≤ 2*T^δ → 1 ≤ U → X ≤ U → U ≤ V → V ≤ 2*U →
      T^huxleyShortCutoff σ ≤ (U : ℝ) → (U : ℝ) ≤ T →
      ‖∑ n ∈ Finset.Ioc U V, Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ < 1/(16*(J : ℝ)) := by
  obtain ⟨D,hD,hd⟩ := huxley_actual_long_block_decay
  obtain ⟨E,hE,he⟩ := Zeta.exists_log_pow_le_rpow 1 (show 0 < η/32 by linarith)
  let A := 2/Real.log 2
  have hA : 0 < A := by dsimp [A]; positivity
  have hlim : Tendsto (fun T : ℝ => 32*D*A*E*T^(-(η/32))) atTop (nhds 0) := by
    simpa using (tendsto_const_nhds.mul (tendsto_rpow_neg_atTop (show 0 < η/32 by linarith)) : Tendsto (fun T : ℝ => (32*D*A*E)*T^(-(η/32))) atTop (nhds ((32*D*A*E)*0)))
  obtain ⟨M,hM⟩ := eventually_atTop.mp (hlim.eventually_lt_const (show (0 : ℝ) < 1 by norm_num))
  refine ⟨max 2 M,le_max_left _ _,?_⟩
  intro T hT σ β t Y hσ hβ hβ1 htlo hthi hY J hJ hJL X U V hX hU hXU hUV hV hUlo hUhi
  have hT2 : 2 ≤ T := (le_max_left _ _).trans hT
  have hTp : 0 < T := by linarith
  have hJp : (0 : ℝ) < J := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hJ)
  have hb := hd T η σ β t Y hT2 hη.le hσ hβ hβ1 htlo hthi hY X U V hU hXU hUV hV hUlo hUhi
  have hdecay : (X : ℝ)*T^(-η/8) ≤ 2*T^(-η/16) := by
    calc
      _ ≤ (2*T^δ)*T^(-η/8) := mul_le_mul_of_nonneg_right hX (by positivity)
      _ = 2*(T^δ*T^(-η/8)) := by ring
      _ = 2*T^(δ-η/8) := by simp only [←Real.rpow_add hTp,sub_eq_add_neg,neg_div]
      _ ≤ _ := mul_le_mul_of_nonneg_left
        (Real.rpow_le_rpow_of_exponent_le (by linarith) (by linarith)) (by norm_num)
  have hblock : ‖∑ n ∈ Finset.Ioc U V, Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤ 2*D*T^(-η/16) := by
    have hh := mul_le_mul_of_nonneg_left hdecay hD.le
    nlinarith only [hb,hh]
  have hJbound : (J : ℝ) ≤ A*E*T^(η/32) := by
    have hh := he T hT2
    simp only [pow_one] at hh
    exact hJL.trans (by have hx := mul_le_mul_of_nonneg_left hh hA.le; nlinarith only [hx])
  apply (lt_div_iff₀ (by positivity : 0 < 16*(J : ℝ))).mpr
  calc
    _ ≤ (2*D*T^(-η/16))*(16*(A*E*T^(η/32))) :=
      mul_le_mul hblock (mul_le_mul_of_nonneg_left hJbound (by norm_num)) (by positivity) (by positivity)
    _ = 32*D*A*E*T^(-(η/32)) := by
      have hp : T^(-η/16)*T^(η/32) = T^(-(η/32)) := by
        rw [←Real.rpow_add hTp]
        congr 1
        ring
      calc
        _ = (32*D*A*E)*(T^(-η/16)*T^(η/32)) := by ring
        _ = _ := by rw [hp]
    _ < 1 := hM T ((le_max_right _ _).trans hT)

end Legendre.Density.Moment
