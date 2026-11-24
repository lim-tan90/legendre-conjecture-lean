/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityFiniteBlockSquare.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.BlockCauchy

@[expose] public section
namespace Legendre.Density.Moment

open scoped BigOperators

 theorem moment_finite_block_square {ι : Type*} (R : Finset ι) (J : ℕ) (f : ι → ℕ → ℂ) :
    (∑ i ∈ R, ‖∑ j ∈ Finset.range J, f i j‖ ^ 2) ≤
      (J : ℝ) * ∑ j ∈ Finset.range J, ∑ i ∈ R, ‖f i j‖ ^ 2 := by
  calc
    _ ≤ ∑ i ∈ R, (J : ℝ) * ∑ j ∈ Finset.range J, ‖f i j‖ ^ 2 := by
      apply Finset.sum_le_sum
      intro i _
      simpa using moment_weighted_sum_norm_sq (Finset.range J) (f i) (fun _ => (1 : ℝ))
        (fun _ _ => by norm_num)
    _ = _ := by rw [← Finset.mul_sum, Finset.sum_comm]

/-- Assemble per-block energies with positive weights tailored to the block. -/
theorem finite_blocks_weighted_energy {ι : Type*} (S : Finset ι) (J : ℕ)
    (f : ι → ℕ → ℂ) (w : ℕ → ℝ) (hw : ∀ j ∈ Finset.range J, 0 < w j)
    (K : ℝ) (hblock : ∀ j ∈ Finset.range J, (∑ i ∈ S, ‖f i j‖^2) ≤ K*(w j)^2) :
    (∑ i ∈ S, ‖∑ j ∈ Finset.range J, f i j‖^2) ≤ K*(∑ j ∈ Finset.range J, w j)^2 := by
  let W := ∑ j ∈ Finset.range J, w j
  have hW : 0 ≤ W := Finset.sum_nonneg (fun j hj => (hw j hj).le)
  calc
    _ ≤ ∑ i ∈ S, W*∑ j ∈ Finset.range J, ‖f i j‖^2/w j :=
      Finset.sum_le_sum fun i _ => moment_weighted_sum_norm_sq _ (f i) w hw
    _ = W*∑ j ∈ Finset.range J, (∑ i ∈ S, ‖f i j‖^2)/w j := by
      rw [← Finset.mul_sum, Finset.sum_comm (s := S)]
      simp_rw [Finset.sum_div]
    _ ≤ W*∑ j ∈ Finset.range J, K*w j := by
      apply mul_le_mul_of_nonneg_left _ hW
      apply Finset.sum_le_sum
      intro j hj
      apply (div_le_iff₀ (hw j hj)).mpr
      simpa only [pow_two,mul_assoc] using hblock j hj
    _ = _ := by rw [← Finset.mul_sum]; change W*(K*W) = K*W^2; ring

end Legendre.Density.Moment
