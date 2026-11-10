/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local finite-family layer cake identity for squared amplitudes.
-/
module
public import Mathlib.MeasureTheory.Integral.Layercake
public import Mathlib.MeasureTheory.Integral.Bochner.SumMeasure
public import Mathlib.Tactic

@[expose] public section
namespace Legendre.Density.Moment
open MeasureTheory Set
open scoped BigOperators

/-- Counting measure turns the layer cake identity into a finite second-moment formula. -/
theorem finite_square_layercake {ι : Type*} [Fintype ι] (x : ι → ℝ) (M : ℝ)
    (hM : 0 ≤ M) (hx : ∀ i, 0 ≤ x i ∧ x i ≤ M) :
    (∑ i, (x i)^2) = ∫ u : ℝ in Ioc 0 (M^2),
      ((Finset.univ.filter (fun i => u ≤ (x i)^2)).card : ℝ) := by
  classical
  letI : MeasurableSpace ι := ⊤
  haveI : MeasurableSingletonClass ι := ⟨fun i => by trivial⟩
  have hf : Integrable (fun i => (x i)^2) (Measure.count : Measure ι) :=
    integrable_count_iff.mpr (hasSum_fintype (fun i : ι => ‖(x i)^2‖)).summable
  have hh := hf.integral_eq_integral_Ioc_meas_le
    (Filter.Eventually.of_forall (fun i => sq_nonneg (x i)))
    (Filter.Eventually.of_forall (fun i => pow_le_pow_left₀ (hx i).1 (hx i).2 2))
  rw [integral_count] at hh
  convert hh using 1
  apply setIntegral_congr_fun measurableSet_Ioc
  intro u hu
  have he : {i : ι | u ≤ (x i)^2} =
      ((Finset.univ.filter (fun i => u ≤ (x i)^2) : Finset ι) : Set ι) := by ext i; simp
  change ((Finset.univ.filter (fun i => u ≤ (x i)^2)).card : ℝ) =
    ((Measure.count : Measure ι) {i | u ≤ (x i)^2}).toReal
  rw [he,Measure.count_apply_finset]
  simp

end Legendre.Density.Moment
