/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronOriginResidue
public import Mathlib.NumberTheory.Harmonic.ZetaAsymp
public import Mathlib.NumberTheory.Harmonic.GammaDeriv
public import Mathlib.Analysis.Calculus.IteratedDeriv.Lemmas

/-!
# Evaluation of the origin correction

Twice differentiating the functional equation after multiplying by s avoids
introducing a singular sinc quotient. The Gamma and zeta Laurent constants
cancel, leaving ζ′(0)=-log(2π)/2 and ζ′/ζ(0)=log(2π).
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology

/-- The analytic factor multiplying sin(πs/2) after the zeta pole has been removed. -/
noncomputable def zetaOriginFunctionalFactor (s : ℂ) : ℂ :=
  -2*(2*(Real.pi : ℂ))^(s-1)*Gamma (1-s)*riemannZeta₁ (1-s)

/-- The pole-removed zeta function has derivative γ at 1. -/
theorem hasDerivAt_riemannZetaOne_one :
    HasDerivAt riemannZeta₁ (Real.eulerMascheroniConstant : ℂ) 1 := by
  simpa only [deriv_riemannZeta₁_one] using (differentiable_riemannZeta₁ 1).hasDerivAt

/-- Gamma is analytic near 1. -/
theorem Gamma_analyticAt_one : AnalyticAt ℂ Gamma 1 := by
  rw [Complex.analyticAt_iff_eventually_differentiableAt]
  filter_upwards [(isOpen_lt continuous_const continuous_re).mem_nhds (by norm_num : 0 < (1 : ℂ).re)] with z hz
  exact (hasDerivAt_Gamma_of_re_pos hz).differentiableAt

/-- The functional factor is analytic near zero. -/
theorem zetaOriginFunctionalFactor_analyticAt : AnalyticAt ℂ zetaOriginFunctionalFactor 0 := by
  have hp0 : 2*(Real.pi : ℂ) ≠ 0 := mul_ne_zero (by norm_num) (ofReal_ne_zero.mpr Real.pi_ne_zero)
  have hp : AnalyticAt ℂ (fun z : ℂ => (2*(Real.pi : ℂ))^(z-1)) 0 := by
    have he : AnalyticAt ℂ (fun z : ℂ => exp (log (2*(Real.pi : ℂ))*(z-1))) 0 := by fun_prop
    simpa only [cpow_def_of_ne_zero hp0] using he
  have hlin : AnalyticAt ℂ (fun z : ℂ => 1-z) 0 := by fun_prop
  have hG : AnalyticAt ℂ (fun z : ℂ => Gamma (1-z)) 0 := by
    simpa using Gamma_analyticAt_one.fun_comp_of_eq hlin (by simp)
  have hZ : AnalyticAt ℂ (fun z : ℂ => riemannZeta₁ (1-z)) 0 := by
    simpa using (differentiable_riemannZeta₁.analyticAt (1 : ℂ)).fun_comp_of_eq hlin (by simp)
  exact ((analyticAt_const.mul hp).mul hG).mul hZ

/-- The two appearances of γ cancel in the derivative of the analytic factor. -/
theorem zetaOriginFunctionalFactor_hasDerivAt :
    HasDerivAt zetaOriginFunctionalFactor (-(log (2*(Real.pi : ℂ)))/(Real.pi : ℂ)) 0 := by
  have hp0 : 2*(Real.pi : ℂ) ≠ 0 := mul_ne_zero (by norm_num) (ofReal_ne_zero.mpr Real.pi_ne_zero)
  have hp := ((hasDerivAt_id (0 : ℂ)).sub_const 1).const_cpow (c := 2*(Real.pi : ℂ)) (.inl hp0)
  have hG := hasDerivAt_Gamma_one.comp_of_eq (0 : ℂ) ((hasDerivAt_id (0 : ℂ)).const_sub 1) (by simp)
  have hZ := hasDerivAt_riemannZetaOne_one.comp_of_eq (0 : ℂ) ((hasDerivAt_id (0 : ℂ)).const_sub 1) (by simp)
  convert! ((hp.const_mul (-2)).mul hG).mul hZ using 1
  norm_num only [id_eq,Function.comp_apply,Pi.mul_apply,sub_zero,zero_sub,cpow_neg_one,Gamma_one,riemannZeta₁_one,mul_one,one_mul]
  field_simp
  ring

/-- The functional equation multiplied by s extends holomorphically through the origin. -/
theorem zetaOrigin_functional_eventuallyEq :
    (fun s : ℂ => s*riemannZeta s) =ᶠ[𝓝 0]
      (fun s : ℂ => zetaOriginFunctionalFactor s*sin ((Real.pi : ℂ)/2*s)) := by
  have hnb : {s : ℂ | s.re < 1} ∈ 𝓝 (0 : ℂ) :=
    (isOpen_lt continuous_re continuous_const).mem_nhds (by norm_num)
  filter_upwards [hnb] with s hs
  by_cases hs0 : s = 0
  · simp [hs0]
  · have hr : 0 < (1-s).re := by simp only [sub_re,one_re]; linarith
    have hrneg (n : ℕ) : 1-s ≠ -(n : ℂ) := by
      intro he
      have hh := congrArg Complex.re he
      simp only [sub_re,one_re,neg_re,natCast_re] at hh
      linarith [Nat.cast_nonneg (α := ℝ) n]
    have hr1 : 1-s ≠ 1 := by intro he; apply hs0; linear_combination -he
    have he := riemannZeta_one_sub hrneg hr1
    rw [sub_sub_cancel] at he
    rw [riemannZeta_eq_inv_sub_mul hr1] at he
    have hcos : cos ((Real.pi : ℂ)*(1-s)/2) = sin ((Real.pi : ℂ)/2*s) := by
      rw [show (Real.pi : ℂ)*(1-s)/2 = (Real.pi : ℂ)/2-(Real.pi : ℂ)/2*s by ring,
        Complex.cos_pi_div_two_sub]
    rw [hcos] at he
    rw [he]
    unfold zetaOriginFunctionalFactor
    rw [show -(1-s) = s-1 by ring]
    field_simp [hs0]
    ring

/-- The derivative of ζ at zero is the classical -log(2π)/2. -/
theorem deriv_riemannZeta_origin : deriv riemannZeta 0 = -log (2*(Real.pi : ℂ))/2 := by
  let b := fun s : ℂ => sin ((Real.pi : ℂ)/2*s)
  have hb : AnalyticAt ℂ b 0 := by dsimp [b]; fun_prop
  have hζ := analytic_off_pole (0 : ℂ) (by norm_num)
  have he := zetaOrigin_functional_eventuallyEq.iteratedDeriv_eq 2
  change iteratedDeriv 2 (fun s : ℂ => id s*riemannZeta s) 0 =
    iteratedDeriv 2 (fun s : ℂ => zetaOriginFunctionalFactor s*b s) 0 at he
  rw [iteratedDeriv_fun_mul (analyticAt_id.contDiffAt : ContDiffAt ℂ 2 (fun s : ℂ => s) 0) hζ.contDiffAt,
    iteratedDeriv_fun_mul zetaOriginFunctionalFactor_analyticAt.contDiffAt hb.contDiffAt] at he
  have hb1 : iteratedDeriv 1 b 0 = (Real.pi : ℂ)/2 := by
    rw [iteratedDeriv_one]
    exact (by simpa [b,Function.comp_def] using! ((Complex.hasDerivAt_sin 0).comp_of_eq (0 : ℂ)
      ((hasDerivAt_id (0 : ℂ)).const_mul ((Real.pi : ℂ)/2)) (by simp)).deriv)
  have hb2 : iteratedDeriv 2 b 0 = 0 := by
    dsimp [b]
    rw [iteratedDeriv_comp_const_mul Complex.contDiff_sin]
    simp
  have hA : iteratedDeriv 1 zetaOriginFunctionalFactor 0 = -log (2*(Real.pi : ℂ))/(Real.pi : ℂ) := by
    rw [iteratedDeriv_one]
    exact zetaOriginFunctionalFactor_hasDerivAt.deriv
  norm_num [Finset.sum_range_succ,iteratedDeriv_zero,iteratedDeriv_one,
    iteratedDeriv_fun_id,iteratedDeriv_id,b,hb1,hb2,hA] at he
  have hπ : (Real.pi : ℂ) ≠ 0 := ofReal_ne_zero.mpr Real.pi_ne_zero
  field_simp at he
  linear_combination he/2

/-- The logarithmic derivative at zero is log(2π), without an unevaluated residue coefficient. -/
theorem logDeriv_riemannZeta_origin : logDeriv riemannZeta 0 = log (2*(Real.pi : ℂ)) := by
  rw [logDeriv_apply,deriv_riemannZeta_origin,riemannZeta_zero]
  ring

end Legendre.Zeta
