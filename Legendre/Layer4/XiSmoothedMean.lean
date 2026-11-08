/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensitySmoothedMean.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The infinite zeta series is obtained by a nonnegative Fatou argument.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiPartialMean
public import Legendre.Layer4.XiSquareLimit
public import Legendre.Layer4.PositiveLimit

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Filter Set
open Density Density.Moment
open scoped BigOperators Topology

theorem xiSmoothedZetaSquare_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ N : ℕ, 1 ≤ N → ∀ T : ℝ,
      1 ≤ T → 1 ≤ Real.log N → 10*T ≤ N →
      Integrable (fun t : ℝ => ‖xiSmoothedZetaSquare ((1/2 : ℂ)+(t : ℂ)*I)‖^2)
        (volume.restrict (Icc (-T) T)) ∧
      (∫ t in Icc (-T) T, ‖xiSmoothedZetaSquare ((1/2 : ℂ)+(t : ℂ)*I)‖^2) ≤
        C*((N : ℝ)+T)*(Real.log N)^6 := by
  obtain ⟨C,hC,hb⟩ := xiFiniteSquare_partial_mean
  refine ⟨C,hC,?_⟩
  intro N hN T hT hL hscale
  apply moment_integral_limit_bound
    (fun J t => ‖∑ n ∈ Finset.Icc 1 (2^J*N),
      xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2) _ _ _ (by positivity)
  · intro J
    exact ((xiFiniteSquare_continuousOn _ (fun n hn => (Finset.mem_Icc.mp hn).1) T hT).norm.pow 2).integrableOn_Icc
  · intro J t
    exact sq_nonneg _
  · intro t
    exact ((xiSquare_partial_limit N hN t).norm).pow 2
  · intro J
    exact hb N hN T hT hL hscale J

end Legendre.Zeta
