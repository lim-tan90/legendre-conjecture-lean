/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The shifted-mollifier organization adapts DensityDetectorAnalytic.lean from
openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The pole-removed zeta numerator and its divided difference are local deductions:
the principal pole at w=1-s is retained, including its exact coefficient.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorIntegral
public import Legendre.Layer4.DetectorKernelLeft
public import Legendre.ZetaGrowth

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory Set
open scoped ArithmeticFunction.Moebius

noncomputable def detectorIntegrand (X : ℕ) (s : ℂ) (Y : ℝ) (w : ℂ) : ℂ :=
  riemannZeta (s+w)*finiteSeries (μ : ArithmeticFunction ℂ) X (s+w)*(Y : ℂ)^w*detectorKernel w

noncomputable def detectorNumerator (X : ℕ) (s : ℂ) (Y : ℝ) (w : ℂ) : ℂ :=
  Zeta.poleRemovedZeta (s+w)*finiteSeries (μ : ArithmeticFunction ℂ) X (s+w)*(Y : ℂ)^w

noncomputable def detectorRegularFactor (X : ℕ) (s : ℂ) (Y : ℝ) (w : ℂ) : ℂ :=
  dslope (detectorNumerator X s Y) 0 w/((w+1)*(w+2))

noncomputable def detectorPrincipalPole (X : ℕ) (s : ℂ) (Y : ℝ) : ℂ :=
  finiteSeries (μ : ArithmeticFunction ℂ) X 1*(Y : ℂ)^(1-s)*detectorKernel (1-s)

theorem mollifier_shift_analytic (X : ℕ) (s w : ℂ) :
    AnalyticAt ℂ (fun z => finiteSeries (μ : ArithmeticFunction ℂ) X (s+z)) w := by
  unfold finiteSeries
  apply Finset.analyticAt_fun_sum
  intro n hn
  have hnC : (n : ℂ) ≠ 0 := by exact_mod_cast (Nat.zero_lt_one.trans_le (Finset.mem_Icc.mp hn).1).ne'
  have ha : AnalyticAt ℂ (fun z : ℂ => -(s+z)) w :=
    (analyticAt_const.add analyticAt_id).neg
  exact analyticAt_const.mul
    (((differentiable_id.const_cpow (Or.inl hnC)).analyticAt (-(s+w))).comp
      (f := fun z : ℂ => -(s+z)) ha)

theorem detectorNumerator_analytic (X : ℕ) (s : ℂ) {Y : ℝ} (hY : 0 < Y) (w : ℂ) :
    AnalyticAt ℂ (detectorNumerator X s Y) w := by
  have hζ := (Zeta.poleRemovedZeta_differentiable.analyticAt (s+w)).comp
    (analyticAt_const.add analyticAt_id)
  exact (hζ.mul (mollifier_shift_analytic X s w)).mul
    ((differentiable_id.const_cpow (Or.inl (by exact_mod_cast hY.ne'))).analyticAt w)

theorem detectorNumerator_zero (X : ℕ) {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s = 0) (Y : ℝ) : detectorNumerator X s Y 0 = 0 := by
  simp [detectorNumerator,Zeta.poleRemovedZeta_eq hs,hz]

theorem detectorRegularFactor_analytic (X : ℕ) (s : ℂ) {Y : ℝ} (hY : 0 < Y)
    {w : ℂ} (hw : -1 < w.re) : AnalyticAt ℂ (detectorRegularFactor X s Y) w := by
  have hd : Differentiable ℂ (dslope (detectorNumerator X s Y) 0) := by
    apply differentiableOn_univ.mp
    exact (Complex.differentiableOn_dslope (s := Set.univ) Filter.univ_mem).mpr
      (fun v _ => (detectorNumerator_analytic X s hY v).differentiableAt.differentiableWithinAt)
  have h1 : w+1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    norm_num at this
    linarith
  have h2 : w+2 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    norm_num at this
    linarith
  exact (hd.analyticAt w).div
    ((analyticAt_id.add analyticAt_const).mul (analyticAt_id.add analyticAt_const))
    (mul_ne_zero h1 h2)

theorem detectorIntegrand_regularized (X : ℕ) {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s = 0) (Y : ℝ) {w : ℂ} (hw : w ≠ 0) (hp : w ≠ 1-s) :
    detectorIntegrand X s Y w = detectorRegularFactor X s Y w/(w-(1-s)) := by
  have hsw : s+w ≠ 1 := by intro h; apply hp; linear_combination h
  rw [detectorRegularFactor,dslope_of_ne _ hw,slope_def_field,
    detectorNumerator_zero X hs hz,sub_zero,sub_zero]
  rw [detectorNumerator,Zeta.poleRemovedZeta_eq hsw]
  unfold detectorIntegrand detectorKernel
  have hp0 : w-(1-s) ≠ 0 := sub_ne_zero.mpr hp
  have he : s+w-1 = w-(1-s) := by ring
  rw [he]
  field_simp

theorem detectorRegularFactor_at_principal_pole (X : ℕ) {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s = 0) (Y : ℝ) :
    detectorRegularFactor X s Y (1-s) = detectorPrincipalPole X s Y := by
  have hp : (1 : ℂ)-s ≠ 0 := sub_ne_zero.mpr (Ne.symm hs)
  rw [detectorRegularFactor,dslope_of_ne _ hp,slope_def_field,
    detectorNumerator_zero X hs hz,sub_zero,sub_zero]
  simp only [detectorNumerator,add_sub_cancel,Zeta.poleRemovedZeta_one,one_mul]
  unfold detectorPrincipalPole detectorKernel
  simp only [div_eq_mul_inv,mul_inv_rev,one_mul]
  ring

theorem norm_detectorPrincipalPole_le (X : ℕ) (s : ℂ) {Y : ℝ} (hY : 0 < Y)
    (ht : 0 < |s.im|) :
    ‖detectorPrincipalPole X s Y‖ ≤ (X : ℝ)*Y^(1-s.re)*(|s.im|^3)⁻¹ := by
  have he : (1 : ℂ)-s = ((1-s.re : ℝ) : ℂ)+((-s.im : ℝ) : ℂ)*I := by
    apply Complex.ext <;> simp
  have hk := detectorKernel_high_bound (1-s.re) (-s.im) (by simpa using ht)
  rw [← he,abs_neg] at hk
  rw [detectorPrincipalPole,norm_mul,norm_mul,Complex.norm_cpow_eq_rpow_re_of_pos hY]
  simp only [sub_re,one_re]
  exact mul_le_mul (mul_le_mul_of_nonneg_right (norm_mollifier_finiteSeries_le X (by norm_num))
    (Real.rpow_nonneg hY.le _)) hk (norm_nonneg _) (by positivity)

end Legendre.Density.Detector.Smooth
