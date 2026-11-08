/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensitySquareLimit.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiSquareSeries

@[expose] public section
namespace Legendre.Zeta

open Complex MeasureTheory Filter
open scoped BigOperators Topology Classical

 theorem xiSquareIntegralTerm_summable (s : ℂ)
    (hs : s.re = 1 / 2) : Summable (xiSquareIntegralTerm s) := by
  have h := hasSum_integral_of_summable_integral_norm
    (fun n => xiSquareSeriesTerm_integrable hs n)
    (xiSquareSeriesTerm_integral_summable hs)
  exact h.summable.mul_left (2 * (Real.pi : ℂ))⁻¹

 @[simp] theorem xiSquareIntegralTerm_zero (s : ℂ) :
    xiSquareIntegralTerm s 0 = 0 := by
  simp [xiSquareIntegralTerm, xiSquareSeriesTerm]

 theorem xiSquare_partial_limit (N : ℕ) (hN : 1 ≤ N)
    (t : ℝ) :
    Tendsto (fun J : ℕ => ∑ n ∈ Finset.Icc 1 (2 ^ J * N),
      xiSquareIntegralTerm (((1/2 : ℂ)+(t : ℂ)*I)) n) atTop
        (𝓝 (xiSmoothedZetaSquare (((1/2 : ℂ)+(t : ℂ)*I)))) := by
  let s := ((1/2 : ℂ)+(t : ℂ)*I)
  have hs : s.re = 1 / 2 := by simp [s]
  have hc : Tendsto (fun J : ℕ => 2 ^ J * N + 1) atTop atTop := by
    apply tendsto_atTop_mono _ (tendsto_pow_atTop_atTop_of_one_lt (by decide : 1 < (2 : ℕ)))
    intro J
    have h := Nat.le_mul_of_pos_right (2 ^ J) (by omega : 0 < N)
    omega
  have he (K : ℕ) : (∑ n ∈ Finset.Icc 1 K, xiSquareIntegralTerm s n) =
      ∑ n ∈ Finset.range (K + 1), xiSquareIntegralTerm s n := by
    apply Finset.sum_subset
    · intro n hn
      exact Finset.mem_range.mpr (by have := (Finset.mem_Icc.mp hn).2; omega)
    · intro n hn hnot
      have hn' := Finset.mem_range.mp hn
      have hzero : n = 0 := by
        by_contra hz
        exact hnot (Finset.mem_Icc.mpr ⟨by omega, by omega⟩)
      simp [hzero]
  have h := ((xiSquareIntegralTerm_summable s hs).hasSum.tendsto_sum_nat).comp hc
  rw [← xiSmoothedZetaSquare_series hs] at h
  change Tendsto (fun J => ∑ n ∈ Finset.range (2 ^ J * N + 1), xiSquareIntegralTerm s n)
    atTop (𝓝 (xiSmoothedZetaSquare s)) at h
  exact h.congr' (Filter.Eventually.of_forall (fun J => (he (2 ^ J * N)).symm))

end Legendre.Zeta
