/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaGrowth
public import Mathlib.Topology.Algebra.Order.Floor
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts

/-!
# A bounded primitive for the centered fractional part

The periodic quadratic (fract(t)^2-fract(t))/2 is continuous, bounded,
and has right derivative fract(t)-1/2 even at integer endpoints.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology MeasureTheory Set

/-- The centered periodic Bernoulli primitive, zero at the integers. -/
noncomputable def zetaEulerPrimitive (t : ℝ) : ℂ :=
  (((Int.fract t)^2-Int.fract t)/2 : ℝ)

/-- The primitive is bounded uniformly on the whole real axis. -/
theorem norm_zetaEulerPrimitive_le (t : ℝ) : ‖zetaEulerPrimitive t‖ ≤ 1/2 := by
  have h0 := Int.fract_nonneg t
  have h1 := Int.fract_lt_one t
  rw [zetaEulerPrimitive,norm_real,Real.norm_eq_abs,abs_le]
  constructor <;> nlinarith [sq_nonneg (Int.fract t),mul_nonneg h0 (sub_nonneg.2 h1.le)]

/-- Matching endpoint values make the periodic primitive continuous at integers too. -/
theorem zetaEulerPrimitive_continuous : Continuous zetaEulerPrimitive := by
  have h : Continuous (fun t : ℝ => (((t^2-t)/2 : ℝ) : ℂ)) := by fun_prop
  exact h.continuousOn.comp_fract'' (by norm_num)

/-- At an integer the primitive vanishes. -/
theorem zetaEulerPrimitive_int (n : ℤ) : zetaEulerPrimitive n = 0 := by
  simp [zetaEulerPrimitive]

/-- One-sided differentiation avoids an exception at each integer. -/
theorem zetaEulerPrimitive_hasDerivWithinAt_right (t : ℝ) :
    HasDerivWithinAt zetaEulerPrimitive ((Int.fract t-1/2 : ℝ) : ℂ) (Ioi t) t := by
  have hf : ∀ᶠ u : ℝ in 𝓝[≥] t, Int.floor u = Int.floor t :=
    (tendsto_pure.1 (tendsto_floor_right_pure_floor t))
  have he : zetaEulerPrimitive =ᶠ[𝓝[>] t]
      (fun u : ℝ => ((((u-(Int.floor t : ℝ))^2-(u-(Int.floor t : ℝ)))/2 : ℝ) : ℂ)) := by
    filter_upwards [hf.filter_mono (nhdsWithin_mono _ Ioi_subset_Ici_self)] with u hu
    simp only [zetaEulerPrimitive,Int.fract,hu]
  have hd := (((hasDerivAt_id t).sub_const (Int.floor t : ℝ)).pow 2 |>.sub
    ((hasDerivAt_id t).sub_const (Int.floor t : ℝ))).div_const 2
  have hd' : HasDerivAt
      (fun u : ℝ => ((((u-(Int.floor t : ℝ))^2-(u-(Int.floor t : ℝ)))/2 : ℝ) : ℂ))
      ((Int.fract t-1/2 : ℝ) : ℂ) t := by
    convert! hd.ofReal_comp using 1
    congr 1
    simp only [Int.fract,id_eq]
    ring
  apply hd'.hasDerivWithinAt.congr_of_eventuallyEq he
  rfl

end Legendre.Zeta
