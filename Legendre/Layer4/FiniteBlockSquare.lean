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

end Legendre.Density.Moment
