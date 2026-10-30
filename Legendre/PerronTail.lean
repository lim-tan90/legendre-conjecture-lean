/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronOscillation
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts
public import Mathlib.MeasureTheory.Integral.IntegralEqImproper

/-!
# Conditional convergence of scalar Perron integrals

Original deductions using mathlib v4.35.0 (Apache-2.0). Integration by parts
turns the bounded oscillatory primitive into a vanishing boundary term and
an absolutely integrable remainder on (1,∞). No value for the resulting
limit away from y=1 is asserted here.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Topology
open scoped ComplexConjugate

/-- An oscillatory primitive for the numerator when y≠1. -/
noncomputable def perronOscPrimitive (y σ t : ℝ) : ℂ :=
  (y ^ σ : ℝ) * exp (((Real.log y : ℂ) * I) * (t : ℂ)) / ((Real.log y : ℂ) * I)

/-- Derivative of the reciprocal vertical factor. -/
noncomputable def perronReciprocalDeriv (σ t : ℝ) : ℂ :=
  -I / ((σ : ℂ) + (t : ℂ) * I) ^ 2

/-- A positive vertical line avoids zero at every height. -/
theorem perronVertical_ne_zero {σ : ℝ} (hσ : 0 < σ) (t : ℝ) :
    (σ : ℂ) + (t : ℂ) * I ≠ 0 := by
  intro h
  have hr := congrArg Complex.re h
  simp at hr
  linarith

/-- The oscillatory primitive differentiates to the original numerator. -/
theorem perronOscPrimitive_hasDerivAt {y : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (σ t : ℝ) : HasDerivAt (perronOscPrimitive y σ)
      ((y : ℂ) ^ ((σ : ℂ) + (t : ℂ) * I)) t := by
  let c : ℂ := (Real.log y : ℂ) * I
  have hc : c ≠ 0 := mul_ne_zero
    (ofReal_ne_zero.mpr (Real.log_ne_zero_of_pos_of_ne_one hy hyone)) I_ne_zero
  have hd : HasDerivAt (fun u : ℝ ↦ exp (c * (u : ℂ))) (exp (c * (t : ℂ)) * c) t := by
    simpa using! ((Complex.hasDerivAt_exp _).comp t
      (((hasDerivAt_id (t : ℂ)).const_mul c).comp_ofReal))
  change HasDerivAt (fun u : ℝ ↦ (y ^ σ : ℝ) * exp (c * (u : ℂ)) / c) _ t
  convert! (hd.const_mul ((y ^ σ : ℝ) : ℂ)).div_const c using 1
  rw [cpow_vertical_eq_exp hy]
  change ((y ^ σ : ℝ) : ℂ) * exp (c * (t : ℂ)) =
    ((y ^ σ : ℝ) : ℂ) * (exp (c * (t : ℂ)) * c) / c
  field_simp

/-- The primitive's norm is independent of height. -/
theorem norm_perronOscPrimitive {y : ℝ} (hy : 0 < y) (σ t : ℝ) :
    ‖perronOscPrimitive y σ t‖ = y ^ σ / |Real.log y| := by
  simp [perronOscPrimitive, norm_exp, Complex.norm_real,
    Real.norm_eq_abs, abs_of_nonneg (Real.rpow_nonneg hy.le _), mul_re]

/-- The reciprocal vertical factor has the indicated derivative. -/
theorem perronReciprocal_hasDerivAt {σ : ℝ} (hσ : 0 < σ) (t : ℝ) :
    HasDerivAt (fun u : ℝ ↦ (1 : ℂ) / ((σ : ℂ) + (u : ℂ) * I))
      (perronReciprocalDeriv σ t) t := by
  have hl : HasDerivAt (fun u : ℝ ↦ (σ : ℂ) + (u : ℂ) * I) I t := by
    simpa using (((hasDerivAt_id (t : ℂ)).mul_const I).const_add (σ : ℂ)).comp_ofReal
  simpa only [one_div, perronReciprocalDeriv] using! hl.inv (perronVertical_ne_zero hσ t)

/-- The reciprocal derivative is continuous for σ>0. -/
theorem perronReciprocalDeriv_continuous {σ : ℝ} (hσ : 0 < σ) :
    Continuous (perronReciprocalDeriv σ) := by
  exact continuous_const.div ((continuous_const.add (continuous_ofReal.mul_const I)).pow 2)
    (fun t ↦ pow_ne_zero _ (perronVertical_ne_zero hσ t))

/-- Quadratic height decay of the reciprocal derivative. -/
theorem norm_perronReciprocalDeriv_le {σ t : ℝ} (ht : 0 < t) :
    ‖perronReciprocalDeriv σ t‖ ≤ 1 / t ^ 2 := by
  have hn : t ≤ ‖(σ : ℂ) + (t : ℂ) * I‖ := by
    simpa [abs_of_pos ht] using abs_im_le_norm ((σ : ℂ) + (t : ℂ) * I)
  simp only [perronReciprocalDeriv, norm_div, norm_neg, norm_I, norm_pow]
  exact one_div_le_one_div_of_le (sq_pos_of_pos ht) (pow_le_pow_left₀ ht.le hn 2)

/-- Finite integration by parts for the scalar weight. -/
theorem integral_perronWeight_parts {y σ : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (hσ : 0 < σ) (a b : ℝ) :
    (∫ t : ℝ in a..b, perronWeight y ((σ : ℂ) + (t : ℂ) * I)) =
      (1 / ((σ : ℂ) + (b : ℂ) * I)) * perronOscPrimitive y σ b -
      (1 / ((σ : ℂ) + (a : ℂ) * I)) * perronOscPrimitive y σ a -
      ∫ t : ℝ in a..b, perronReciprocalDeriv σ t * perronOscPrimitive y σ t := by
  have hp : Continuous (perronOscPrimitive y σ) :=
    continuous_iff_continuousAt.mpr (fun t ↦
      (perronOscPrimitive_hasDerivAt hy hyone σ t).continuousAt)
  have hn : Continuous (fun t : ℝ ↦ (y : ℂ) ^ ((σ : ℂ) + (t : ℂ) * I)) :=
    (continuous_const_cpow' (ofReal_ne_zero.mpr hy.ne')).comp
      (continuous_const.add (continuous_ofReal.mul_const I))
  have h := intervalIntegral.integral_mul_deriv_eq_deriv_mul
    (fun t _ ↦ perronReciprocal_hasDerivAt hσ t)
    (fun t _ ↦ perronOscPrimitive_hasDerivAt hy hyone σ t)
    ((perronReciprocalDeriv_continuous hσ).intervalIntegrable (μ := volume) a b)
    (hn.intervalIntegrable (μ := volume) a b)
  simpa only [perronWeight, div_eq_inv_mul, one_div, mul_one] using h

/-- The integration-by-parts remainder is absolutely integrable on (1,∞). -/
theorem perronTail_remainder_integrable {y σ : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (hσ : 0 < σ) : IntegrableOn
      (fun t : ℝ ↦ perronReciprocalDeriv σ t * perronOscPrimitive y σ t) (Set.Ioi 1) := by
  have hp : Continuous (perronOscPrimitive y σ) :=
    continuous_iff_continuousAt.mpr (fun t ↦
      (perronOscPrimitive_hasDerivAt hy hyone σ t).continuousAt)
  have hm := (integrableOn_Ioi_rpow_of_lt (a := (-2 : ℝ)) (by norm_num) zero_lt_one).const_mul
    (y ^ σ / |Real.log y|)
  apply hm.mono' (((perronReciprocalDeriv_continuous hσ).mul hp).aestronglyMeasurable)
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  have htpos : 0 < t := lt_trans zero_lt_one ht
  simp only [Pi.mul_apply]
  rw [norm_mul, norm_perronOscPrimitive hy]
  have hb := mul_le_mul_of_nonneg_right (norm_perronReciprocalDeriv_le (σ := σ) htpos)
    (div_nonneg (Real.rpow_nonneg hy.le σ) (abs_nonneg (Real.log y)))
  simpa [Real.rpow_neg, Real.rpow_two, div_eq_mul_inv, mul_comm] using hb

/-- The boundary term from integration by parts tends to zero at positive infinity. -/
theorem perronTail_boundary_tendsto_zero {y σ : ℝ} (hy : 0 < y) :
    Tendsto (fun t : ℝ ↦ (1 / ((σ : ℂ) + (t : ℂ) * I)) * perronOscPrimitive y σ t)
      atTop (𝓝 0) := by
  apply squeeze_zero_norm' (a := fun t : ℝ ↦ (y ^ σ / |Real.log y|) / t)
  · filter_upwards [eventually_gt_atTop (0 : ℝ)] with t ht
    rw [norm_mul, norm_div, norm_one, norm_perronOscPrimitive hy]
    have hn : t ≤ ‖(σ : ℂ) + (t : ℂ) * I‖ := by
      simpa [abs_of_pos ht] using abs_im_le_norm ((σ : ℂ) + (t : ℂ) * I)
    calc
      _ ≤ (1 / t) * (y ^ σ / |Real.log y|) :=
        mul_le_mul_of_nonneg_right (one_div_le_one_div_of_le ht hn)
          (div_nonneg (Real.rpow_nonneg hy.le σ) (abs_nonneg (Real.log y)))
      _ = _ := by ring
  · exact tendsto_const_nhds.div_atTop tendsto_id

/-- Conditional convergence on the positive half-line, with an explicit remainder integral. -/
theorem tendsto_integral_perronWeight_Ioi_one {y σ : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (hσ : 0 < σ) :
    Tendsto (fun T : ℝ ↦ ∫ t : ℝ in 1..T, perronWeight y ((σ : ℂ) + (t : ℂ) * I))
      atTop (𝓝 (-(1 / ((σ : ℂ) + I) * perronOscPrimitive y σ 1) -
        ∫ t : ℝ in Set.Ioi 1, perronReciprocalDeriv σ t * perronOscPrimitive y σ t)) := by
  have hr := intervalIntegral_tendsto_integral_Ioi 1
    (perronTail_remainder_integrable hy hyone hσ) tendsto_id
  have hb := (perronTail_boundary_tendsto_zero (σ := σ) hy).sub_const
    (1 / ((σ : ℂ) + I) * perronOscPrimitive y σ 1)
  have h := hb.sub hr
  simp only [zero_sub] at h
  apply h.congr'
  filter_upwards [] with T
  simpa only [ofReal_one, one_mul, id_eq] using!
    (integral_perronWeight_parts hy hyone hσ 1 T).symm

/-- The scalar weight is continuous on a positive vertical line. -/
theorem perronWeight_vertical_continuous {y σ : ℝ} (hy : 0 < y) (hσ : 0 < σ) :
    Continuous (fun t : ℝ ↦ perronWeight y ((σ : ℂ) + (t : ℂ) * I)) := by
  exact ((continuous_const_cpow' (ofReal_ne_zero.mpr hy.ne')).comp
    (continuous_const.add (continuous_ofReal.mul_const I))).div
      (continuous_const.add (continuous_ofReal.mul_const I)) (perronVertical_ne_zero hσ)

/-- Reflection of height conjugates the scalar kernel. -/
theorem perronWeight_vertical_neg {y : ℝ} (hy : 0 < y) (σ t : ℝ) :
    perronWeight y ((σ : ℂ) + ((-t : ℝ) : ℂ) * I) =
      conj (perronWeight y ((σ : ℂ) + (t : ℂ) * I)) := by
  have ha : (y : ℂ).arg ≠ Real.pi := by
    simpa [arg_ofReal_of_nonneg hy.le] using Real.pi_ne_zero.symm
  have hs : (σ : ℂ) + ((-t : ℝ) : ℂ) * I = conj ((σ : ℂ) + (t : ℂ) * I) := by
    simp
  simp only [perronWeight, hs, cpow_conj _ _ ha, conj_ofReal, map_div₀]

/-- A symmetric finite integral is the sum of a positive-half integral and its conjugate. -/
theorem integral_perronWeight_symmetric {y σ : ℝ} (hy : 0 < y) (hσ : 0 < σ) (T : ℝ) :
    (∫ t : ℝ in -T..T, perronWeight y ((σ : ℂ) + (t : ℂ) * I)) =
      conj (∫ t : ℝ in 0..T, perronWeight y ((σ : ℂ) + (t : ℂ) * I)) +
        (∫ t : ℝ in 0..T, perronWeight y ((σ : ℂ) + (t : ℂ) * I)) := by
  have hc := perronWeight_vertical_continuous hy hσ
  have hsplit := intervalIntegral.integral_add_adjacent_intervals
    (hc.intervalIntegrable (μ := volume) (-T) 0) (hc.intervalIntegrable (μ := volume) 0 T)
  rw [← hsplit]
  congr 1
  have hn := intervalIntegral.integral_comp_neg
    (f := fun t : ℝ ↦ perronWeight y ((σ : ℂ) + (t : ℂ) * I)) (a := 0) (b := T)
  simp only [neg_zero] at hn
  rw [← hn]
  simp_rw [perronWeight_vertical_neg hy]
  exact conjLIE.toLinearIsometry.intervalIntegral_comp_comm _

/-- The scalar truncated Perron kernel has a limit away from y=1.
The value of this limit (0 or 1) is not determined by this theorem. -/
theorem exists_tendsto_truncatedPerronKernel {y σ : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (hσ : 0 < σ) : ∃ L : ℂ,
      Tendsto (fun T : ℝ ↦ truncatedPerronKernel y σ T) atTop (𝓝 L) := by
  have hc := perronWeight_vertical_continuous hy hσ
  have hpos := (tendsto_integral_perronWeight_Ioi_one hy hyone hσ).const_add
    (∫ t : ℝ in 0..1, perronWeight y ((σ : ℂ) + (t : ℂ) * I))
  have hzero : ∃ L : ℂ, Tendsto
      (fun T : ℝ ↦ ∫ t : ℝ in 0..T, perronWeight y ((σ : ℂ) + (t : ℂ) * I))
      atTop (𝓝 L) := by
    refine ⟨_, hpos.congr' ?_⟩
    filter_upwards [] with T
    exact intervalIntegral.integral_add_adjacent_intervals
      (hc.intervalIntegrable (μ := volume) 0 1) (hc.intervalIntegrable (μ := volume) 1 T)
  obtain ⟨L, hL⟩ := hzero
  refine ⟨(1 / (2 * Real.pi) : ℂ) * (conj L + L), ?_⟩
  have hconj := continuous_conj.continuousAt.tendsto.comp hL
  have h := (hconj.add hL).const_mul (1 / (2 * Real.pi) : ℂ)
  apply h.congr'
  filter_upwards [] with T
  simp only [truncatedPerronKernel, integral_perronWeight_symmetric hy hσ, Function.comp_apply]

/-- Existence of the scalar kernel limit for every positive base, including the endpoint. -/
theorem exists_tendsto_truncatedPerronKernel_pos {y σ : ℝ} (hy : 0 < y) (hσ : 0 < σ) :
    ∃ L : ℂ, Tendsto (fun T : ℝ ↦ truncatedPerronKernel y σ T) atTop (𝓝 L) := by
  by_cases h : y = 1
  · subst y
    exact ⟨1 / 2, tendsto_truncatedPerronKernel_one hσ⟩
  · exact exists_tendsto_truncatedPerronKernel hy h hσ

end Legendre.Zeta
