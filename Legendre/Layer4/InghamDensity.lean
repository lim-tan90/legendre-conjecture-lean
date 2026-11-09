/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The proved compact detector, its two moment branches, and multiplicity
restoration give Ingham's curved density exponent with an arbitrary positive
height epsilon. The logarithmic power ten is not claimed to be sharp.
-/
module
public import Legendre.Layer4.InghamMultiplicity
public import Legendre.ZeroDensity

@[expose] public section
namespace Legendre.Zeta

/-- Unconditional, uniform in sigma, with all analytic zero multiplicities. -/
theorem ingham_density_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Set.Icc (1/2 : ℝ) 1,
      ∀ T : ℝ, 2 ≤ T →
        (zeroDensityCount σ T : ℝ) ≤ C*T^(3*(1-σ)/(2-σ)+ε) := by
  intro ε hε
  obtain ⟨C,hC,hb⟩ := ingham_density_log_bound
  obtain ⟨D,hD,hl⟩ := exists_log_pow_le_rpow 10 hε
  refine ⟨C*D,mul_pos hC hD,?_⟩
  intro σ hσ T hT
  calc
    _ ≤ C*T^Density.Moment.balancedDensityExponent σ*(Real.log T)^10 := hb σ hσ T hT
    _ ≤ C*T^Density.Moment.balancedDensityExponent σ*(D*T^ε) :=
      mul_le_mul_of_nonneg_left (hl T hT) (by positivity)
    _ = _ := by
      rw [Real.rpow_add (by linarith : 0 < T)]
      unfold Density.Moment.balancedDensityExponent
      ring

/-- The same proof gives the uniform linear density exponent three. -/
theorem hasZeroDensityEstimate_three : HasZeroDensityEstimate 3 := by
  intro ε hε
  obtain ⟨C,hC,hb⟩ := ingham_density_epsilon ε hε
  refine ⟨C,hC,?_⟩
  intro σ hσ T hT
  apply (hb σ hσ T hT).trans
  apply mul_le_mul_of_nonneg_left _ hC.le
  apply Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
  have hd : 0 < 2-σ := by linarith [hσ.2]
  have hh : 3*(1-σ)/(2-σ) ≤ 3*(1-σ) := by
    apply (div_le_iff₀ hd).mpr
    nlinarith [mul_nonneg (show 0 ≤ 1-σ by linarith [hσ.2]) (show 0 ≤ 1-σ by linarith [hσ.2])]
  linarith

end Legendre.Zeta
