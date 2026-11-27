/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.CubicIntegrability
public import Legendre.Layer4.KernelHeightPacking
public import Legendre.Layer4.MollifierFourthMoment
public import Legendre.Layer4.PackedCriticalMass
public import Legendre.Layer4.WeightedIntegral

@[expose] public section
namespace Legendre.Density.Moment
open MeasureTheory Set
open Detector.Smooth

private theorem criticalWeight_mass_pos : 0 < ∫ v : ℝ, criticalWeight v := by
  apply (integral_pos_iff_support_of_nonneg criticalWeight_nonneg criticalWeight_integrable).mpr
  have hs : Function.support criticalWeight = univ := by
    ext v
    simp [criticalWeight, show 1+|v| ≠ 0 by positivity]
  simp [hs]

private theorem criticalWeight_shift_le_height (t v T : ℝ) (hT : 1 ≤ T) :
    criticalWeight (v-t) ≤ (1+|t|)^3*momentHeightWeight T v := by
  have hTp : 0 < T := by linarith
  have hdiv : |v/T| ≤ |v| := by
    rw [abs_div, abs_of_pos hTp]
    exact div_le_self (abs_nonneg _) hT
  have hab : |v| ≤ |v-t|+|t| := by
    simpa only [sub_add_cancel] using abs_add_le (v-t) t
  have hden : 1+|v/T| ≤ (1+|t|)*(1+|v-t|) := by
    nlinarith [mul_nonneg (abs_nonneg t) (abs_nonneg (v-t))]
  unfold momentHeightWeight criticalWeight
  rw [mul_one_div]
  apply (div_le_div_iff₀ (by positivity) (by positivity)).2
  simpa only [one_mul, mul_pow] using pow_le_pow_left₀ (by positivity : 0 ≤ 1+|v/T|) hden 3

private theorem integral_criticalWeight_strip_le_height (T v : ℝ) (hT : 1 ≤ T) :
    (∫ t in Icc (-T) T, criticalWeight (v-t)) ≤
      (27*(∫ x : ℝ, criticalWeight x)+128)*momentHeightWeight T v := by
  let M := ∫ x : ℝ, criticalWeight x
  have hM : 0 ≤ M := criticalWeight_mass_pos.le
  have hTp : 0 < T := by linarith
  have hTi : -T ≤ T := by linarith
  have hW := momentHeightWeight_nonneg T v
  have hc : Continuous (fun t : ℝ => criticalWeight (v-t)) :=
    criticalWeight_continuous.comp (continuous_const.sub continuous_id)
  by_cases hv : |v| ≤ 2*T
  · have hi : Integrable (fun t => criticalWeight (v-t)) := criticalWeight_integrable.comp_sub_left v
    have hwhole : (∫ t : ℝ, criticalWeight (v-t)) = M := integral_sub_left_eq_self criticalWeight volume v
    have hsmall : (∫ t in Icc (-T) T, criticalWeight (v-t)) ≤ M :=
      (setIntegral_le_integral hi (Filter.Eventually.of_forall (fun _ => criticalWeight_nonneg _))).trans_eq hwhole
    have hvT : |v/T| ≤ 2 := by
      rw [abs_div, abs_of_pos hTp]
      exact (div_le_iff₀ hTp).2 (by linarith)
    have hWb : 1 ≤ 27*momentHeightWeight T v := by
      unfold momentHeightWeight criticalWeight
      rw [mul_one_div]
      apply (le_div_iff₀ (by positivity : 0 < (1+|v/T|)^3)).2
      simpa only [one_mul, show (3 : ℝ)^3 = 27 by norm_num] using
        pow_le_pow_left₀ (by positivity : 0 ≤ 1+|v/T|) (by linarith : 1+|v/T| ≤ 3) 3
    have hh : M ≤ M*(27*momentHeightWeight T v) := le_mul_of_one_le_right hM hWb
    exact hsmall.trans (hh.trans (by dsimp only [M] at *; nlinarith))
  · have hv' : 2*T < |v| := lt_of_not_ge hv
    have hb : (∫ t in Icc (-T) T, criticalWeight (v-t)) ≤ 128*T/(T+|v|)^3 := by
      calc
        _ ≤ ∫ _ in Icc (-T) T, 64/(T+|v|)^3 :=
          setIntegral_mono_on hc.continuousOn.integrableOn_Icc (integrable_const _)
            measurableSet_Icc (fun t ht => moment_kernel_far_bound T v t hTp (abs_le.mpr ht) hv')
        _ = _ := by
          rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hTi, intervalIntegral.integral_const]
          rw [smul_eq_mul]
          ring
    have hT3 : T ≤ T^3 := by simpa only [pow_one] using (pow_le_pow_right₀ hT (show 1 ≤ (3 : ℕ) by norm_num))
    calc
      _ ≤ 128*T/(T+|v|)^3 := hb
      _ ≤ 128*T^3/(T+|v|)^3 := div_le_div_of_nonneg_right
        (mul_le_mul_of_nonneg_left hT3 (by norm_num)) (by positivity)
      _ = 128*momentHeightWeight T v := by rw [momentHeightWeight_eq T v hTp]; ring
      _ ≤ _ := by dsimp only [M] at *; nlinarith

/-- The square of the cubic-kernel convolution over a height window
is controlled by the corresponding weighted square on the whole line. -/
theorem critical_convolution_second_moment (T : ℝ) (hT : 1 ≤ T) (f : ℝ → ℝ)
    (hf : Continuous f) (hf0 : ∀ v, 0 ≤ f v)
    (hi : Integrable (fun v => momentHeightWeight T v*f v^2)) :
    let M := ∫ v : ℝ, criticalWeight v
    let q := fun t => ∫ v : ℝ, criticalWeight (v-t)*f v
    IntegrableOn (fun t => q t^2) (Icc (-T) T) ∧
      (∫ t in Icc (-T) T, q t^2) ≤
        M*(27*M+128)*(∫ v : ℝ, momentHeightWeight T v*f v^2) := by
  dsimp only
  let J := Icc (-T) T
  let μ := volume.restrict J
  let M := ∫ v : ℝ, criticalWeight v
  let K := 27*M+128
  let q := fun t => ∫ v : ℝ, criticalWeight (v-t)*f v
  let p := fun t v : ℝ => criticalWeight (v-t)*f v^2
  have hM : 0 < M := criticalWeight_mass_pos
  have hK : 0 < K := by dsimp only [K]; linarith
  have hcont : Continuous (Function.uncurry p) :=
    (criticalWeight_continuous.comp (continuous_snd.sub continuous_fst)).mul
      ((hf.comp continuous_snd).pow 2)
  have hp0 (t v : ℝ) : 0 ≤ p t v := mul_nonneg (criticalWeight_nonneg _) (sq_nonneg _)
  have hpL (t : ℝ) : Integrable (p t) := by
    have hc : Continuous (p t) := by
      exact (criticalWeight_continuous.comp (continuous_id.sub continuous_const)).mul (hf.pow 2)
    apply (hi.const_mul ((1+|t|)^3)).mono' hc.aestronglyMeasurable
    filter_upwards with v
    rw [Real.norm_of_nonneg (hp0 t v)]
    calc
      _ ≤ ((1+|t|)^3*momentHeightWeight T v)*f v^2 :=
        mul_le_mul_of_nonneg_right (criticalWeight_shift_le_height t v T hT) (sq_nonneg _)
      _ = _ := by ring
  have hqInt (t : ℝ) : Integrable (fun v => criticalWeight (v-t)*f v) := by
    have hc : Continuous (fun v => criticalWeight (v-t)*f v) :=
      (criticalWeight_continuous.comp (continuous_id.sub continuous_const)).mul hf
    apply ((criticalWeight_shift_integrable t).add (hpL t)).mono' hc.aestronglyMeasurable
    filter_upwards with v
    rw [Real.norm_of_nonneg (mul_nonneg (criticalWeight_nonneg _) (hf0 _))]
    have hb : f v ≤ 1+f v^2 := by nlinarith [sq_nonneg (f v-1)]
    simpa only [p, Pi.add_apply, mul_add, mul_one] using
      mul_le_mul_of_nonneg_left hb (criticalWeight_nonneg (v-t))
  have hbound (v : ℝ) : (∫ t in J, p t v) ≤ K*momentHeightWeight T v*f v^2 := by
    dsimp only [p]
    rw [integral_mul_const]
    exact mul_le_mul_of_nonneg_right (integral_criticalWeight_strip_le_height T v hT) (sq_nonneg _)
  have hcoeff (v : ℝ) : Integrable (fun t => p t v) μ := by
    exact ((criticalWeight_continuous.comp (continuous_const.sub continuous_id)).mul
      continuous_const).continuousOn.integrableOn_Icc
  have hright : Integrable (fun v => ∫ t, p t v ∂μ) := by
    apply (hi.const_mul K).mono' hcont.stronglyMeasurable.integral_prod_left'.aestronglyMeasurable
    filter_upwards with v
    change ‖∫ t, p t v ∂μ‖ ≤ K*(momentHeightWeight T v*f v^2)
    rw [Real.norm_of_nonneg (integral_nonneg (fun t => hp0 t v))]
    exact (hbound v).trans_eq (by ring)
  have hprod : Integrable (Function.uncurry p) (μ.prod volume) := by
    apply (integrable_prod_iff' hcont.aestronglyMeasurable).2
    refine ⟨Filter.Eventually.of_forall hcoeff, ?_⟩
    apply hright.congr
    filter_upwards with v
    apply integral_congr_ae
    filter_upwards with t
    exact (Real.norm_of_nonneg (hp0 t v)).symm
  have hsq (t : ℝ) : q t^2 ≤ M*(∫ v, p t v) := by
    have hw : 0 < ∫ v, criticalWeight (v-t) := by rw [criticalWeight_shift_integral]; exact hM
    have h := weighted_cauchy (fun v => criticalWeight (v-t)) f
      (criticalWeight_shift_integrable t) (hqInt t) (hpL t) (fun _ => criticalWeight_nonneg _) hw
    simpa only [criticalWeight_shift_integral] using h
  have hqi : Integrable (fun t => q t^2) μ := by
    have hqC : Continuous (fun x : ℝ × ℝ => criticalWeight (x.2-x.1)*f x.2) :=
      (criticalWeight_continuous.comp (continuous_snd.sub continuous_fst)).mul (hf.comp continuous_snd)
    have hqm : StronglyMeasurable q := hqC.stronglyMeasurable.integral_prod_right'
    apply (hprod.integral_prod_left.const_mul M).mono' (hqm.aestronglyMeasurable.pow 2)
    filter_upwards with t
    change ‖q t^2‖ ≤ M*(∫ v, p t v)
    rw [Real.norm_of_nonneg (sq_nonneg _)]
    exact hsq t
  refine ⟨hqi,?_⟩
  calc
    _ ≤ ∫ t in J, M*(∫ v, p t v) := integral_mono hqi (hprod.integral_prod_left.const_mul M) hsq
    _ = M*(∫ v, ∫ t in J, p t v) := by rw [integral_const_mul, integral_integral_swap hprod]
    _ ≤ M*(∫ v, K*(momentHeightWeight T v*f v^2)) := by
      exact mul_le_mul_of_nonneg_left (integral_mono hright (hi.const_mul K) (fun v =>
        (hbound v).trans_eq (by ring))) hM.le
    _ = _ := by rw [integral_const_mul]; dsimp only [K, M]; ring

/-- The shifted critical mass inherits the weighted product second moment. -/
theorem criticalMass_second_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 2 ≤ T →
      let L := 1+Real.log (X*X : ℕ)
      IntegrableOn (fun t => criticalMass X t^2) (Icc (-T) T) ∧
      (∫ t in Icc (-T) T, criticalMass X t^2) ≤
        C*Real.sqrt (T*(Real.log T)^4*(T*L^4+(X*X : ℕ)*L^3)) := by
  obtain ⟨C,hC,hb⟩ := weighted_criticalProduct_second_moment
  let M := ∫ v : ℝ, criticalWeight v
  have hM : 0 < M := criticalWeight_mass_pos
  refine ⟨M*(27*M+128)*C, by positivity,?_⟩
  intro X hX T hT
  dsimp only
  let f := fun v => ‖criticalProduct X 0 v‖
  have hx (t : ℝ) : criticalMass X t = ∫ v, criticalWeight (v-t)*f v := by
    rw [criticalMass_eq_shift]
    apply integral_congr_ae
    filter_upwards with v
    simp only [f, criticalProduct, zero_add, norm_mul]
    ring
  obtain ⟨hi,hb'⟩ := hb X hX T hT
  obtain ⟨hq,hqB⟩ := critical_convolution_second_moment T (by linarith)
    f (criticalProduct_continuous X 0).norm (fun _ => norm_nonneg _) hi
  simp_rw [hx]
  exact ⟨hq,hqB.trans ((mul_le_mul_of_nonneg_left hb' (by positivity : 0 ≤ M*(27*M+128))).trans_eq (by ring))⟩

end Legendre.Density.Moment
