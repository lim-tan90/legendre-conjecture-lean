/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.DirichletMeanValue
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Continuous large-value measure bound for Dirichlet polynomials

Markov's inequality transfers the proved mean-square bound to the Lebesgue
measure of times with |P(t)|≥V. This is a continuous-time measure bound, not
a count of separated sampling points or a large-sieve theorem.
-/

@[expose] public section

namespace Legendre.Density

open MeasureTheory Set

/-- Weighted measure estimate on every finite interval, including the threshold equality. -/
theorem dirichlet_large_values_mul_measure_le (N : ℕ) (a : ℕ → ℂ)
    {A B V : ℝ} (hAB : A ≤ B) (hV : 0 < V) :
    V^2*(volume.restrict (Ioc A B)).real {t : ℝ | V ≤ ‖dirichletPolynomial N a t‖} ≤
      (B-A+4*(N : ℝ)*(1+Real.log N))*coefficientEnergy (Finset.Icc 1 N) a := by
  have hi : Integrable (fun t : ℝ => ‖dirichletPolynomial N a t‖^2)
      (volume.restrict (Ioc A B)) :=
    ((continuous_dirichletPolynomial N a).norm.pow 2).intervalIntegrable A B |>.1
  have hm := mul_meas_ge_le_integral_of_nonneg
    (Filter.Eventually.of_forall (fun t : ℝ => sq_nonneg ‖dirichletPolynomial N a t‖)) hi (V^2)
  have hs : {t : ℝ | V^2 ≤ ‖dirichletPolynomial N a t‖^2} =
      {t : ℝ | V ≤ ‖dirichletPolynomial N a t‖} := by
    ext t
    exact sq_le_sq₀ hV.le (norm_nonneg _)
  rw [hs, ← intervalIntegral.integral_of_le hAB] at hm
  exact hm.trans (integral_dirichletPolynomial_norm_sq_le N a A B)

/-- An explicit V⁻² continuous large-value bound with all length dependence displayed. -/
theorem dirichlet_large_values_measure_le (N : ℕ) (a : ℕ → ℂ)
    {A B V : ℝ} (hAB : A ≤ B) (hV : 0 < V) :
    (volume.restrict (Ioc A B)).real {t : ℝ | V ≤ ‖dirichletPolynomial N a t‖} ≤
      ((B-A+4*(N : ℝ)*(1+Real.log N))*coefficientEnergy (Finset.Icc 1 N) a)/V^2 := by
  apply (le_div_iff₀ (sq_pos_of_pos hV)).2
  simpa only [mul_comm (V^2)] using dirichlet_large_values_mul_measure_le N a hAB hV

end Legendre.Density
