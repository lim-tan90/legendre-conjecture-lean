/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform
public import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
public import Mathlib.MeasureTheory.Integral.Prod

/-! Scalar Gaussian Mellin inversion with a uniform bound in the contour width. -/

@[expose] public section
open Complex MeasureTheory Set
namespace Legendre.Zeta

/-- The Gaussian inverse Mellin transform of the simple pole is a bounded
Gaussian cumulative integral. -/
theorem gaussian_pole_line_eq (c x : ℝ) (hc : 0 < c) :
    (∫ u : ℝ, Complex.exp (((c : ℂ)+(u : ℂ)*I)^2 +
        ((c : ℂ)+(u : ℂ)*I)*(x : ℂ))/((c : ℂ)+(u : ℂ)*I)) =
      (Real.pi : ℂ)^(1/2 : ℂ) *
        ∫ v in Ioi (0 : ℝ), Complex.exp (-(((x-v : ℝ) : ℂ)^2)/4) := by
  let z := fun u : ℝ => (c : ℂ)+(u : ℂ)*I
  let f := fun u v : ℝ => Complex.exp ((z u)^2 + z u*((x-v : ℝ) : ℂ))
  let μ := (volume : Measure ℝ).restrict (Ioi (0 : ℝ))
  have hf : Integrable (Function.uncurry f) ((volume : Measure ℝ).prod μ) := by
    have hu : Integrable (fun u : ℝ => Real.exp (-1*u^2)) :=
      integrable_exp_neg_mul_sq one_pos
    have hv : Integrable (fun v : ℝ => Real.exp (-c*v)) μ :=
      integrableOn_exp_mul_Ioi (by linarith : -c < 0) _
    apply ((hu.mul_prod hv).const_mul (Real.exp (c^2+c*x))).mono'
    · apply Continuous.aestronglyMeasurable
      dsimp [Function.uncurry,f,z]
      fun_prop
    · filter_upwards with p
      dsimp only [Function.uncurry,f,z]
      rw [Complex.norm_exp]
      have hRe : ((((c : ℂ)+(p.1 : ℂ)*I)^2 +
          ((c : ℂ)+(p.1 : ℂ)*I)*((x-p.2 : ℝ) : ℂ))).re =
          (c^2+c*x)+(-1*p.1^2 + -c*p.2) := by
        rw [pow_two]
        simp
        ring
      rw [hRe, Real.exp_add (c^2+c*x),Real.exp_add (-1*p.1^2)]
  have hinner (u : ℝ) :
      (∫ v : ℝ, f u v ∂μ) = Complex.exp ((z u)^2+z u*(x : ℂ))/z u := by
    have hre : (z u).re = c := by simp [z]
    have hn : z u ≠ 0 := by
      intro h
      have h0 := congrArg Complex.re h
      simp [hre] at h0
      linarith
    have hpoint (v : ℝ) : f u v =
        Complex.exp ((z u)^2+z u*(x : ℂ))*Complex.exp ((-z u)*(v : ℂ)) := by
      dsimp only [f]
      rw [← Complex.exp_add]
      congr 1
      push_cast
      ring
    simp_rw [hpoint,integral_const_mul]
    rw [integral_exp_mul_complex_Ioi (a := -z u) (by simp [hre,hc]) 0]
    simp [div_eq_mul_inv]
  have houter (v : ℝ) :
      (∫ u : ℝ, f u v) = (Real.pi : ℂ)^(1/2 : ℂ)*
        Complex.exp (-(((x-v : ℝ) : ℂ)^2)/4) := by
    let q : ℂ := ((x-v : ℝ) : ℂ)
    have hpoint (u : ℝ) : f u v =
        Complex.exp ((-1 : ℂ)*(u : ℂ)^2 + (((2*c : ℝ) : ℂ)+q)*I*u +
          ((c : ℂ)^2+(c : ℂ)*q)) := by
      dsimp only [f,z,q]
      congr 1
      push_cast
      linear_combination (u : ℂ)^2 * Complex.I_sq
    simp_rw [hpoint]
    rw [integral_cexp_quadratic (by norm_num : (-1 : ℂ).re < 0),
      neg_neg, div_one]
    congr 2
    have hI : (((((2*c : ℝ) : ℂ)+q)*I)^2) =
        -((((2*c : ℝ) : ℂ)+q)^2) := by rw [mul_pow, I_sq]; ring
    rw [hI]
    dsimp only [q]
    push_cast
    ring
  calc
    _ = ∫ u : ℝ, ∫ v : ℝ, f u v ∂μ := by simp_rw [hinner,z]
    _ = ∫ v : ℝ, ∫ u : ℝ, f u v ∂volume ∂μ := integral_integral_swap hf
    _ = _ := by simp_rw [houter, integral_const_mul]; rfl

theorem gaussian_pole_line_uniform (c x : ℝ) (hc : 0 < c) :
    ‖∫ u : ℝ, Complex.exp (((c : ℂ)+(u : ℂ)*I)^2+
        ((c : ℂ)+(u : ℂ)*I)*(x : ℂ))/((c : ℂ)+(u : ℂ)*I)‖ ≤
      ‖(Real.pi : ℂ)^(1/2 : ℂ)‖ * Real.sqrt (Real.pi/(1/4)) := by
  rw [gaussian_pole_line_eq c x hc, norm_mul]
  apply mul_le_mul_of_nonneg_left _ (norm_nonneg _)
  apply (norm_integral_le_integral_norm _).trans
  have he (v : ℝ) :
      ‖Complex.exp (-(((x-v : ℝ) : ℂ)^2)/4)‖ = Real.exp (-(1/4)*(v-x)^2) := by
    rw [Complex.norm_exp]
    congr 1
    rw [← ofReal_pow, ← ofReal_neg, ← ofReal_ofNat, ← ofReal_div, ofReal_re]
    ring
  simp_rw [he]
  have hInt : Integrable (fun v : ℝ => Real.exp (-(1/4)*(v-x)^2)) := by
    apply (integrable_exp_neg_mul_sq (by norm_num : (0 : ℝ) < 1/4)).comp_sub_right
  exact (MeasureTheory.setIntegral_le_integral hInt
    (Filter.Eventually.of_forall fun v => Real.exp_nonneg _)).trans_eq (by
      rw [integral_sub_right_eq_self (fun v : ℝ => Real.exp (-(1/4)*v^2)) x, integral_gaussian])

theorem gaussian_pole_line_integrable (c x : ℝ) (hc : 0 < c) :
    Integrable (fun u : ℝ => Complex.exp (((c : ℂ)+(u : ℂ)*I)^2+
        ((c : ℂ)+(u : ℂ)*I)*(x : ℂ))/((c : ℂ)+(u : ℂ)*I)) := by
  let z := fun u : ℝ => (c : ℂ)+(u : ℂ)*I
  have hre (u : ℝ) : (z u).re = c := by simp [z]
  have hz (u : ℝ) : z u ≠ 0 := by
    intro h
    have hzero := congrArg Complex.re h
    rw [hre, zero_re] at hzero
    exact hc.ne' hzero
  have hc₀ : Continuous z := by dsimp [z]; fun_prop
  have hcont : Continuous (fun u => Complex.exp ((z u)^2+z u*(x : ℂ))/z u) :=
    ((hc₀.pow 2).add (hc₀.mul continuous_const)).cexp.div hc₀ hz
  apply ((integrable_exp_neg_mul_sq one_pos).const_mul
    (Real.exp (c^2+c*x)/c)).mono' hcont.aestronglyMeasurable
  filter_upwards with u
  change ‖Complex.exp ((z u)^2+z u*(x : ℂ))/z u‖ ≤ _
  have hRe : ((z u)^2+z u*(x : ℂ)).re = (c^2+c*x)+(-1*u^2) := by
    rw [pow_two]
    simp [z]
    ring
  have hn : c ≤ ‖z u‖ := by simpa only [hre, abs_of_pos hc] using abs_re_le_norm (z u)
  rw [norm_div, Complex.norm_exp, hRe, Real.exp_add]
  calc
    _ ≤ Real.exp (c^2+c*x)*Real.exp (-1*u^2)/c :=
      div_le_div_of_nonneg_left (by positivity) hc hn
    _ = _ := by ring

end Legendre.Zeta
