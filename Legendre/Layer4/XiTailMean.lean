/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityTailBlock.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiFiniteMean
public import Legendre.Layer4.DivisorEnergy

@[expose] public section
namespace Legendre.Zeta

open Complex MeasureTheory Set
open Density Density.Moment
open scoped BigOperators Classical

 theorem xiFiniteSquare_tail_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ M N : ℕ, 1 ≤ M → ∀ T : ℝ, 1 ≤ T →
      ∀ S : Finset ℕ, S ⊆ Finset.Icc M N →
      (∫ t in Icc (-T) T,
        ‖∑ n ∈ S, xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖ ^ 2) ≤
          C * (10 * T) ^ 2 * ((N : ℝ) + T) *
            ((N : ℝ) * (1 + Real.log N) ^ 3 / (M : ℝ) ^ 3) := by
  obtain ⟨C, hC, hb⟩ := xiFiniteSquare_mean
  refine ⟨C * xiMellinConstant ^ 2, mul_pos hC (sq_pos_of_pos xiMellinConstant_pos), ?_⟩
  intro M N hM T hT S hS
  have hSN : S ⊆ Finset.Icc 1 N := fun n hn =>
    Finset.mem_Icc.mpr ⟨hM.trans (Finset.mem_Icc.mp (hS hn)).1, (Finset.mem_Icc.mp (hS hn)).2⟩
  have h := hb N T 1 hT (by norm_num) (by norm_num) S hSN
  have he := divisor_shifted_tail S M N hM hS
  have hbound := h.trans (mul_le_mul_of_nonneg_left he (by positivity))
  convert hbound using 1
  simp only [xiMellinCost, Real.rpow_one, div_one]
  ring

end Legendre.Zeta
