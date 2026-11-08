/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaDensitySelection
public import Legendre.DirichletSamplingSharp

/-!
# Multiplicity-weighted zero detection with linear mean-square error

The analytic detector property is still an explicit hypothesis. The improved
bound combines proved representative selection with the optimized sampling
inequality; it does not assert either Ingham's or Huxley's density theorem.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex

/-- A detector with N>1 benefits from the linear Hilbert mean-square error
and the optimized single-logarithm sampling factor. -/
theorem zeroDensityCount_le_of_dirichlet_detector_linear_log (σ : ℝ) {T : ℝ}
    (hT : 7 ≤ T) (N : ℕ) (a : ℕ → ℂ) (hN : 1 < N) {V : ℝ} (hV : 0 < V)
    (hdetect : ∀ ρ : ℂ, ρ ∈ zerosRightOf σ T →
      V ≤ ‖Density.dirichletPolynomial N a ρ.im‖) :
    (zeroDensityCount σ T : ℝ) ≤
      (2*densitySelectionConstant*Real.log T)*
        (((1+2*Real.log N)*(T+1+2*Real.pi*(N : ℝ))*
          Density.coefficientEnergy (Finset.Icc 1 N) a)/V^2) := by
  classical
  obtain ⟨r,hrs,hsep,hcount⟩ := exists_density_separated_representatives σ hT
  have hs := Density.dirichlet_large_sample_card_le_linear_log r Complex.im N a hN
    (δ := 1) (L := 0) (U := T+1) (by norm_num) (by linarith) hV
    (fun ρ hρ => by
      have hz := (zerosRightOf_finite σ T).mem_toFinset.1 (hrs hρ)
      exact ⟨hz.1.2.1.le,by linarith [hz.1.2.2]⟩)
    hsep (fun ρ hρ => hdetect ρ ((zerosRightOf_finite σ T).mem_toFinset.1 (hrs hρ)))
  have hA : 0 ≤ 2*densitySelectionConstant*Real.log T :=
    mul_nonneg (mul_nonneg (by norm_num) densitySelectionConstant_pos.le)
      (Real.log_nonneg (by linarith))
  apply hcount.trans
  apply mul_le_mul_of_nonneg_left _ hA
  simpa only [inv_one,sub_zero] using hs

end Legendre.Zeta
