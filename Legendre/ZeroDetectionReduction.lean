/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaDensitySelection
public import Legendre.DirichletSampling

/-!
# From Dirichlet-polynomial zero detectors to multiplicity-weighted density

The detector property is an explicit analytic hypothesis, to be supplied by
later zeta estimates. The reduction proves separated selection, local
multiplicity control and sampling rather than assuming a density conclusion.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex

/-- A uniform ordinate detector gives an explicit upper bound on the full density count. -/
theorem zeroDensityCount_le_of_dirichlet_detector (σ : ℝ) {T : ℝ} (hT : 7 ≤ T)
    (N : ℕ) (a : ℕ → ℂ) {V : ℝ} (hV : 0 < V)
    (hdetect : ∀ ρ : ℂ, ρ ∈ zerosRightOf σ T →
      V ≤ ‖Density.dirichletPolynomial N a ρ.im‖) :
    (zeroDensityCount σ T : ℝ) ≤
      (2*densitySelectionConstant*Real.log T)*
        (((2+(Real.log N)^2)*(T+1+4*(N : ℝ)*(1+Real.log N))*
          Density.coefficientEnergy (Finset.Icc 1 N) a)/V^2) := by
  classical
  obtain ⟨r,hrs,hsep,hcount⟩ := exists_density_separated_representatives σ hT
  have hs := Density.dirichlet_large_sample_card_le r Complex.im N a
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
  simpa only [inv_one,one_add_one_eq_two,sub_zero] using hs

end Legendre.Zeta
