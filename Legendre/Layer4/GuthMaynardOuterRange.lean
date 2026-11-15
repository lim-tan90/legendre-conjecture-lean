/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local comparison of the proved Ingham and full Huxley curves with the
Guth--Maynard exponent. The genuinely stronger middle range is not assumed.
-/
module
public import Legendre.Layer4.HuxleyFullDensity

@[expose] public section
namespace Legendre.Density.Moment

/-- Ingham already supplies the Guth--Maynard exponent through sigma=7/10. -/
theorem ingham_le_guth_maynard_lower (σ : ℝ) (hσ : 1/2 ≤ σ) (hσu : σ ≤ 7/10) :
    3*(1-σ)/(2-σ) ≤ 15*(1-σ)/(3+5*σ) := by
  have hd : 0 < 2-σ := by linarith
  have he : 0 < 3+5*σ := by linarith
  have hh : (3 : ℝ)/(2-σ) ≤ 15/(3+5*σ) :=
    (div_le_div_iff₀ hd he).mpr (by linarith)
  have hm := mul_le_mul_of_nonneg_right hh (show 0 ≤ 1-σ by linarith)
  convert hm using 1 <;> ring

/-- The full Huxley curve supplies the Guth--Maynard exponent from sigma=4/5. -/
theorem huxley_le_guth_maynard_upper (σ : ℝ) (hσ : 4/5 ≤ σ) (hσ1 : σ ≤ 1) :
    3*(1-σ)/(3*σ-1) ≤ 15*(1-σ)/(3+5*σ) := by
  have hd : 0 < 3*σ-1 := by linarith
  have he : 0 < 3+5*σ := by linarith
  have hh : (3 : ℝ)/(3*σ-1) ≤ 15/(3+5*σ) :=
    (div_le_div_iff₀ hd he).mpr (by linarith)
  have hm := mul_le_mul_of_nonneg_right hh (show 0 ≤ 1-σ by linarith)
  convert hm using 1 <;> ring

end Legendre.Density.Moment

namespace Legendre.Zeta
open Set Density.Moment

/-- Closed outer-range Guth--Maynard exponent with one uniform coefficient and all heights. -/
theorem guth_maynard_outer_density_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (1/2 : ℝ) 1,
      (σ ≤ 7/10 ∨ 4/5 ≤ σ) → ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^(15*(1-σ)/(3+5*σ)+ε) := by
  intro ε hε
  obtain ⟨CI,hCI,hi⟩ := ingham_density_epsilon ε hε
  obtain ⟨CH,hCH,hh⟩ := huxley_curved_density_epsilon ε hε
  refine ⟨CI+CH,by positivity,?_⟩
  intro σ hσ hout T hT
  rcases hout with hlo | hhi
  · have hc := hi σ hσ T hT
    have hp := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith)
      (add_le_add (ingham_le_guth_maynard_lower σ hσ.1 hlo) (le_rfl : ε ≤ ε))
    exact hc.trans (mul_le_mul (show CI ≤ CI+CH by linarith) hp (by positivity) (by positivity))
  · have hc := hh σ hσ T hT
    have hp := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith)
      (add_le_add (huxley_le_guth_maynard_upper σ hhi hσ.2) (le_rfl : ε ≤ ε))
    exact hc.trans (mul_le_mul (show CH ≤ CI+CH by linarith) hp (by positivity) (by positivity))

end Legendre.Zeta
