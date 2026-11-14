/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local real-part weights for the actual logarithmic Weyl bound.
The estimate is uniform in every nonnegative real part.
-/
module
public import Legendre.Layer4.Exponential.MonotoneWeights

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

theorem real_weight_cpow (n : ℕ) (hn : 0 < n) (β t : ℝ) :
    (n : ℝ)^(-β) • (n : ℂ)^(-(t : ℂ)*I) =
      (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I)) := by
  rw [Complex.real_smul,Complex.ofReal_cpow (Nat.cast_nonneg n)]
  simp only [Complex.ofReal_natCast,Complex.ofReal_neg]
  rw [←Complex.cpow_add _ _ (by exact_mod_cast hn.ne' : (n : ℂ) ≠ 0)]
  congr 1
  ring

/-- Monotone real powers preserve Weyl cancellation for every nonnegative real part. -/
theorem logarithmic_block_weighted_weyl (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V)
    (hV : V ≤ 2*U) (β t : ℝ) (hβ : 0 ≤ β) (ht : 1 ≤ |t|)
    (hU2 : (U : ℝ)^2 ≤ 4*|t|) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤
      logarithmicWeylConstant*(U : ℝ)^(1/2-β)*|t|^(1/6 : ℝ) := by
  let w : ℕ → ℝ := fun i => ((U+1+i : ℕ) : ℝ)^(-β)
  let z : ℕ → ℂ := fun i => ((U+1+i : ℕ) : ℂ)^(-(t : ℂ)*I)
  let B := logarithmicWeylConstant*Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hC := logarithmicWeylConstant_pos
  have hB : 0 ≤ B := by dsimp [B]; positivity
  have hw : ∀ n, 0 ≤ w n := fun n => by dsimp [w]; positivity
  have hanti : Antitone w := by
    intro i j hij
    apply Real.rpow_le_rpow_of_nonpos (by positivity)
      (by exact_mod_cast (show U+1+i ≤ U+1+j by omega)) (by linarith)
  have hb (m : ℕ) (hm : m ≤ V-U) : ‖∑ n ∈ Finset.range m, z n‖ ≤ B := by
    dsimp [z]
    rw [sum_range_offset_eq_Ioc U m (fun n => (n : ℂ)^(-(t : ℂ)*I))]
    exact logarithmic_block_weyl U (U+m) hU (by omega) (by omega) t ht hU2
  have hbound := norm_sum_range_smul_antitone w z (V-U) B hB hw hanti hb
  have he : (∑ n ∈ Finset.range (V-U), w n • z n) =
      ∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I)) := by
    dsimp [w,z]
    rw [sum_range_offset_eq_Ioc U (V-U) (fun n => (((n : ℝ)^(-β) : ℝ) : ℂ)*(n : ℂ)^(-(t : ℂ)*I)),
      Nat.add_sub_of_le hUV]
    apply Finset.sum_congr rfl
    intro n hn
    simpa only [Complex.real_smul] using real_weight_cpow n
      (lt_of_le_of_lt (Nat.zero_le U) (Finset.mem_Ioc.mp hn).1) β t
  rw [he] at hbound
  have hw0 : w 0 ≤ (U : ℝ)^(-β) := by
    dsimp [w]
    exact Real.rpow_le_rpow_of_nonpos hUp (by norm_cast; omega) (by linarith)
  have hp := hbound.trans (mul_le_mul_of_nonneg_left hw0 hB)
  have hepow : Real.sqrt (U : ℝ)*(U : ℝ)^(-β) = (U : ℝ)^(1/2-β) := by
    rw [Real.sqrt_eq_rpow,←Real.rpow_add hUp]
    congr 1
  calc
    _ ≤ B*(U : ℝ)^(-β) := hp
    _ = logarithmicWeylConstant*(Real.sqrt (U : ℝ)*(U : ℝ)^(-β))*|t|^(1/6 : ℝ) := by dsimp [B]; ring
    _ = _ := by rw [hepow]

end Legendre.Density.Oscillation
