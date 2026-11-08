/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The Gaussian square and normalization organization generalizes
DensityCompletedSquare.lean and DensitySquareGaussian.lean from openai/math,
commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Here s(s-1) removes zeta's two completed poles. The source license is retained
in licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.ZetaXi
public import Legendre.GammaBounds.GaussianWeight

/-!
# Entire Gaussian square and its normalized zeta kernel

The polynomial removal of the completed poles is controlled uniformly in
height. The Gamma quotient therefore retains the exact height exponent.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex

noncomputable def xiSquareNormalizer (s : ℂ) : ℂ := (s*(s-1)*Gammaℝ s)^2

noncomputable def xiSquareGaussian (s w : ℂ) : ℂ := zetaXi (s+w)^2*Complex.exp (w^2)

noncomputable def xiSquareKernelWeight (s w : ℂ) : ℂ :=
  ((s+w)*(s+w-1)/(s*(s-1)))^2*Density.GammaBounds.gammaSquareGaussianWeight s w

theorem xiSquareGaussian_analytic (s w : ℂ) : AnalyticAt ℂ (xiSquareGaussian s) w := by
  exact (((zetaXi_differentiable.analyticAt (s+w)).comp
    (analyticAt_const.add analyticAt_id)).pow 2).mul ((analyticAt_id.pow 2).cexp)

theorem xiSquareGaussian_reflection (s w : ℂ) :
    xiSquareGaussian s (-w) = xiSquareGaussian (1-s) w := by
  rw [xiSquareGaussian,xiSquareGaussian]
  have he : zetaXi (s+-w) = zetaXi ((1-s)+w) := by
    rw [← zetaXi_one_sub (s+-w)]
    congr 1
    ring
  rw [he,neg_sq]

theorem xiSquareNormalizer_ne_zero {s : ℂ} (hs : s.re = 1/2) : xiSquareNormalizer s ≠ 0 := by
  have hs0 : s ≠ 0 := by intro he; simp [he] at hs
  have hs1 : s-1 ≠ 0 := by
    intro he
    have hh := sub_eq_zero.1 he
    simp [hh] at hs
  exact pow_ne_zero 2 (mul_ne_zero (mul_ne_zero hs0 hs1) (Gammaℝ_ne_zero_of_re_pos (by linarith)))

/-- On the right integration line the normalizer recovers zeta squared exactly. -/
theorem xiSquareGaussian_normalized {s : ℂ} (hs : s.re = 1/2) (u : ℝ) :
    xiSquareGaussian s (1+(u : ℂ)*I)/xiSquareNormalizer s =
      xiSquareKernelWeight s (1+(u : ℂ)*I)*riemannZeta (s+(1+(u : ℂ)*I))^2 := by
  have hs0 : s ≠ 0 := by intro he; simp [he] at hs
  have hs1 : s ≠ 1 := by intro he; simp [he] at hs
  have hz : 0 < (s+(1+(u : ℂ)*I)).re := by simp [hs]; norm_num
  have hz1 : s+(1+(u : ℂ)*I) ≠ 1 := by
    intro he
    have hr := congrArg Complex.re he
    norm_num [hs] at hr
  have hg : Gammaℝ s ≠ 0 := Gammaℝ_ne_zero_of_re_pos (by linarith)
  rw [xiSquareGaussian,zetaXi_eq_gamma_zeta hz hz1]
  unfold xiSquareNormalizer xiSquareKernelWeight Density.GammaBounds.gammaSquareGaussianWeight
  field_simp

/-- Entire pole removal adds only a polynomial in the shift, with no extra height power. -/
theorem xiSquareKernelWeight_bound {s : ℂ} (hs : s.re = 1/2) (w : ℂ)
    (hw : 0 ≤ w.re) (hw2 : w.re ≤ 2) :
    ‖xiSquareKernelWeight s w‖ ≤ (1+2*‖w‖)^4*
      Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)^w.re*Real.exp (-(w.im^2)/2) := by
  have hP := pow_le_pow_left₀ (norm_nonneg _) (xi_polynomial_shift_ratio_le hs w) 2
  have hG := Density.GammaBounds.gammaSquareGaussianWeight_bound s w hs hw hw2
  have hp : ((1+2*‖w‖)^2)^2 = (1+2*‖w‖)^4 := by ring
  rw [hp] at hP
  rw [xiSquareKernelWeight,norm_mul,norm_pow]
  have hh := mul_le_mul hP hG (norm_nonneg _) (by positivity : 0 ≤ (1+2*‖w‖)^4)
  simpa only [mul_assoc] using hh

end Legendre.Zeta
