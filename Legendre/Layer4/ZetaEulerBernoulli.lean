/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.ZetaEulerFourierMode
public import Mathlib.NumberTheory.ZetaValues
public import Mathlib.MeasureTheory.Integral.DominatedConvergence

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set

noncomputable def eulerBernoulliScale : ℂ :=
  (-(2*(Real.pi : ℂ)*I)^2)⁻¹

noncomputable def eulerBernoulliCoefficient (k : ℤ) : ℂ :=
  eulerBernoulliScale*((k : ℂ)^2)⁻¹

@[simp] theorem eulerBernoulliCoefficient_zero : eulerBernoulliCoefficient 0 = 0 := by
  simp [eulerBernoulliCoefficient]

theorem eulerBernoulliCoefficient_summable_norm :
    Summable fun k : ℤ => ‖eulerBernoulliCoefficient k‖ := by
  have h := (Real.summable_one_div_int_pow (p := 2)).2 (by norm_num)
  apply (h.mul_left ‖eulerBernoulliScale‖).congr
  intro k
  rw [eulerBernoulliCoefficient,norm_mul,norm_inv,norm_pow,norm_intCast,
    sq_abs,one_div]

private theorem eulerFourierMode_eq_fourier (k : ℤ) (x : ℝ) :
    eulerFourierMode k x = fourier (T := 1) k (x : UnitAddCircle) := by
  rw [fourier_coe_apply,eulerFourierMode,Complex.ofReal_one,div_one]
  congr 1
  ring

private theorem eulerFourierMode_fract (k : ℤ) (x : ℝ) :
    eulerFourierMode k (Int.fract x) = eulerFourierMode k x := by
  rw [eulerFourierMode_eq_fourier,eulerFourierMode_eq_fourier]
  have h : ((Int.fract x : ℝ) : UnitAddCircle) = (x : UnitAddCircle) := by
    have hk : (((⌊x⌋ : ℤ) : ℝ) : UnitAddCircle) = 0 := by
      rw [← mul_one ((⌊x⌋ : ℤ) : ℝ),← zsmul_eq_mul,AddCircle.coe_zsmul,
        AddCircle.coe_period,smul_zero]
    rw [Int.fract,AddCircle.coe_sub,hk,sub_zero]
  rw [h]

/-- The periodic primitive is an absolutely convergent Bernoulli series
plus its constant Fourier term. -/
theorem hasSum_eulerBernoulli (x : ℝ) :
    HasSum (fun k : ℤ => eulerBernoulliCoefficient k*eulerFourierMode k x)
      (zetaEulerPrimitive x+(1/12 : ℂ)) := by
  have hf : Int.fract x ∈ Icc (0 : ℝ) 1 := ⟨Int.fract_nonneg x,(Int.fract_lt_one x).le⟩
  have h := (hasSum_one_div_pow_mul_fourier_mul_bernoulliFun (k := 2) (by norm_num) hf).mul_left
    eulerBernoulliScale
  convert h using 1
  · funext k
    rw [eulerBernoulliCoefficient, ← eulerFourierMode_eq_fourier, eulerFourierMode_fract]
    ring
  · rw [bernoulliFun_two]
    unfold eulerBernoulliScale zetaEulerPrimitive
    push_cast
    norm_num
    field_simp [ofReal_ne_zero.mpr Real.pi_pos.ne',Complex.I_ne_zero]
    ring

/-- Integrating the Bernoulli primitive against an integrable power preserves
its Fourier expansion. Each nonzero mode uses the boundary-sized estimate. -/
theorem norm_integral_eulerBernoulli_cpow_sub_constant_le {a : ℝ} (ha : 1 ≤ a)
    {u : ℂ} (hu : u.re < -2) (hheight : |u.im| ≤ a) (hsize : ‖u‖ ≤ 4*a) :
    ‖(∫ x in Ioi a, zetaEulerPrimitive x*(x : ℂ)^u)+
      (1/12 : ℂ)*(∫ x in Ioi a, (x : ℂ)^u)‖ ≤
      5*a^u.re*(∑' k : ℤ, ‖eulerBernoulliCoefficient k‖) := by
  let A := fun k : ℤ => eulerBernoulliCoefficient k
  let f := fun (k : ℤ) (x : ℝ) => A k*(eulerFourierMode k x*(x : ℂ)^u)
  let μ := volume.restrict (Ioi a)
  let g := fun x : ℝ => (x : ℂ)^u
  have ha₀ : 0 < a := by linarith
  have hgi : Integrable g μ := integrableOn_Ioi_cpow_of_lt (by linarith only [hu]) ha₀
  have hf_norm (k : ℤ) (x : ℝ) : ‖f k x‖ = ‖A k‖*‖g x‖ := by
    simp [f,g]
  have hfi (k : ℤ) : Integrable (f k) μ := by
    have hm : Continuous (eulerFourierMode k) :=
      continuous_iff_continuousAt.2 fun x => (eulerFourierMode_hasDerivAt k x).continuousAt
    have hp : AEStronglyMeasurable (f k) μ :=
      aestronglyMeasurable_const.mul (hm.aestronglyMeasurable.mul hgi.aestronglyMeasurable)
    apply (hgi.norm.const_mul ‖A k‖).mono hp
    filter_upwards with x
    rw [hf_norm,Real.norm_eq_abs,abs_of_nonneg (by positivity)]
  have hsm : Summable fun k : ℤ => (∫ x, ‖f k x‖ ∂μ) := by
    simp_rw [hf_norm,integral_const_mul]
    exact eulerBernoulliCoefficient_summable_norm.mul_right _
  have hsum := integral_tsum_of_summable_integral_norm hfi hsm
  have he (x : ℝ) : (∑' k, f k x) =
      zetaEulerPrimitive x*g x+(1/12 : ℂ)*g x := by
    have h := ((hasSum_eulerBernoulli x).mul_right (g x)).tsum_eq
    convert h using 1
    · apply tsum_congr
      intro k
      dsimp only [f,g,A]
      ring
    · ring
  simp_rw [he] at hsum
  have hbi : Integrable (fun x => zetaEulerPrimitive x*g x) μ := by
    apply (hgi.norm.const_mul (1/2 : ℝ)).mono
      (zetaEulerPrimitive_continuous.aestronglyMeasurable.mul hgi.aestronglyMeasurable)
    filter_upwards with x
    change ‖zetaEulerPrimitive x*g x‖ ≤ ‖(1/2 : ℝ)*‖g x‖‖
    rw [norm_mul,Real.norm_eq_abs,abs_of_nonneg (by positivity)]
    exact mul_le_mul_of_nonneg_right (norm_zetaEulerPrimitive_le x) (norm_nonneg _)
  have hci : Integrable (fun x => (1/12 : ℂ)*g x) μ := hgi.const_mul _
  rw [integral_add hbi hci,integral_const_mul] at hsum
  change ‖(∫ x, zetaEulerPrimitive x*g x ∂μ)+(1/12 : ℂ)*(∫ x, g x ∂μ)‖ ≤ _
  rw [← hsum]
  have hbound (k : ℤ) : ‖∫ x, f k x ∂μ‖ ≤ ‖A k‖*(5*a^u.re) := by
    by_cases hk : k = 0
    · subst k
      simp [f,A]
    · dsimp only [f]
      rw [integral_const_mul,norm_mul]
      exact mul_le_mul_of_nonneg_left
        (norm_integral_eulerFourierMode_cpow_le k hk ha hu hheight hsize) (norm_nonneg _)
  have hsm' := eulerBernoulliCoefficient_summable_norm.mul_right (5*a^u.re)
  have hσ : Summable fun k : ℤ => ‖∫ x, f k x ∂μ‖ :=
    hsm'.of_nonneg_of_le (fun _ => norm_nonneg _) hbound
  apply (norm_tsum_le_tsum_norm hσ).trans
  have h := hσ.tsum_le_tsum hbound hsm'
  rw [tsum_mul_right] at h
  exact h.trans_eq (by simp [A,mul_comm])

end Legendre.Zeta
