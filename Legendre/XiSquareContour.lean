/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The vertical-contour, reflection and conjugation proof organization adapts
DensitySquareContour.lean, DensitySquareEquation.lean and
DensitySquareConjugation.lean from openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The entire xi numerator removes both completed zeta poles. The rectangle
residue calculation uses the already credited PNT+ rectangle API.
The upstream licenses are retained in licenses/.
-/
module

public import Legendre.XiGaussianEnvelope
public import Legendre.PNT.ResidueCalcOnRectangles
public import Mathlib.Analysis.Complex.RemovableSingularity


/-!
# An exact Gaussian functional equation for the entire xi square

The integrable envelope justifies both vertical lines and the vanishing
horizontal edges. The rectangle residue gives an exact smoothed identity;
conjugation then reduces the critical-line fourth power to a single contour.
The mean bound for that contour, and hence the fourth-moment theorem, remain open.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter MeasureTheory Set
open scoped Topology Interval ComplexConjugate

noncomputable def xiSquareContour (s w : ℂ) : ℂ :=
  xiSquareGaussian s w / w

theorem xiSquareContour_bound (s : ℂ) (K : ℝ)
    (hK : ∀ x u : ℝ, |x| ≤ 1 →
      ‖xiSquareGaussian s ((x : ℂ) + u * I)‖ ≤ K * xiGaussianEnvelope u)
    (x u : ℝ) (hx : |x| ≤ 1) (hn : 1 ≤ ‖(x : ℂ) + u * I‖) :
    ‖xiSquareContour s ((x : ℂ) + u * I)‖ ≤ K * xiGaussianEnvelope u := by
  rw [xiSquareContour, norm_div]
  exact (div_le_self (norm_nonneg _) hn).trans (hK x u hx)

theorem xiSquareContour_vertical_integrable (s : ℂ)
    (hs : s.re = 1 / 2) (x : ℝ) (hx : |x| = 1) :
    Integrable (fun u : ℝ => xiSquareContour s ((x : ℂ) + u * I)) := by
  obtain ⟨K, _, hK⟩ := xiSquareGaussian_band_bound s hs
  have hcont : Continuous (fun u : ℝ => xiSquareContour s ((x : ℂ) + u * I)) := by
    have hF : Continuous (xiSquareGaussian s) :=
      continuous_iff_continuousAt.mpr (fun w => (xiSquareGaussian_analytic s w).continuousAt)
    apply (hF.comp (by fun_prop)).div (by fun_prop)
    intro u he
    have hr := congrArg Complex.re he
    simp only [add_re, ofReal_re, mul_re, I_re, I_im, ofReal_im, mul_zero,
      zero_mul, sub_self, add_zero, zero_re] at hr
    simp [hr] at hx
  apply (xiGaussianEnvelope_integrable.const_mul K).mono' hcont.aestronglyMeasurable
  filter_upwards with u
  apply xiSquareContour_bound s K hK x u hx.le
  have hn := Complex.abs_re_le_norm ((x : ℂ) + u * I)
  simpa only [add_re, ofReal_re, mul_re, I_re, I_im, ofReal_im, mul_zero,
    zero_mul, sub_self, add_zero, hx] using hn

theorem xiSquareContour_horizontal_bound (s : ℂ)
    (K : ℝ) (hK : ∀ x u : ℝ, |x| ≤ 1 →
      ‖xiSquareGaussian s ((x : ℂ) + u * I)‖ ≤ K * xiGaussianEnvelope u)
    (u : ℝ) (hu : 1 ≤ |u|) :
    ‖∫ x in (-1 : ℝ)..1, xiSquareContour s ((x : ℂ) + u * I)‖ ≤
      2 * K * xiGaussianEnvelope u := by
  have hb : ∀ x ∈ Ι (-1 : ℝ) 1,
      ‖xiSquareContour s ((x : ℂ) + u * I)‖ ≤ K * xiGaussianEnvelope u := by
    intro x hx
    have hxm : -1 ≤ x ∧ x ≤ 1 := by
      rw [uIoc_of_le (by norm_num : (-1 : ℝ) ≤ 1)] at hx
      exact ⟨hx.1.le, hx.2⟩
    apply xiSquareContour_bound s K hK x u (abs_le.mpr hxm)
    have hn := Complex.abs_im_le_norm ((x : ℂ) + u * I)
    have he : (((x : ℂ) + u * I).im) = u := by simp
    rw [he] at hn
    exact hu.trans hn
  have h := intervalIntegral.norm_integral_le_of_norm_le_const hb
  norm_num at h
  convert h using 1
  ring

theorem xiSquareContour_horizontal_tendsto (s : ℂ)
    (hs : s.re = 1 / 2) :
    Tendsto (fun u : ℝ => ∫ x in (-1 : ℝ)..1,
      xiSquareContour s ((x : ℂ) + u * I)) atTop (𝓝 0) ∧
    Tendsto (fun u : ℝ => ∫ x in (-1 : ℝ)..1,
      xiSquareContour s ((x : ℂ) + (-u) * I)) atTop (𝓝 0) := by
  obtain ⟨K, _, hK⟩ := xiSquareGaussian_band_bound s hs
  have he : Tendsto (fun u => 2 * K * xiGaussianEnvelope u) atTop (𝓝 0) := by
    simpa only [mul_zero] using xiGaussianEnvelope_tendsto.const_mul (2 * K)
  constructor
  · rw [tendsto_zero_iff_norm_tendsto_zero]
    apply squeeze_zero' (Filter.Eventually.of_forall (fun _ => norm_nonneg _)) _ he
    filter_upwards [eventually_ge_atTop (1 : ℝ)] with u hu
    exact xiSquareContour_horizontal_bound s K hK u (by simpa [abs_of_pos (by linarith : 0 < u)])
  · rw [tendsto_zero_iff_norm_tendsto_zero]
    apply squeeze_zero' (Filter.Eventually.of_forall (fun _ => norm_nonneg _)) _ he
    filter_upwards [eventually_ge_atTop (1 : ℝ)] with u hu
    have h := xiSquareContour_horizontal_bound s K hK (-u)
      (by simpa [abs_of_pos (by linarith : 0 < u)])
    simpa only [xiGaussianEnvelope, neg_sq, Complex.ofReal_neg] using h

/-- Coordinate wrapper around the existing PNT+ rectangle integral. -/
noncomputable def xiRectangleIntegral (f : ℂ → ℂ) (a b c d : ℝ) : ℂ :=
  RectangleIntegral f ((a : ℂ)+(c : ℂ)*I) ((b : ℂ)+(d : ℂ)*I)

/-- The entire numerator leaves exactly the central simple-pole residue. -/
theorem xiSquareGaussian_rectangle (s : ℂ) (a b c d : ℝ)
    (ha : a < 0) (hb : 0 < b) (hc : c < 0) (hd : 0 < d) :
    xiRectangleIntegral (xiSquareContour s) a b c d =
      (2*(Real.pi : ℂ)*I)*zetaXi s^2 := by
  let F := xiSquareGaussian s
  let g := dslope F 0
  let z : ℂ := (a : ℂ)+(c : ℂ)*I
  let w : ℂ := (b : ℂ)+(d : ℂ)*I
  have hF : Differentiable ℂ F := fun v => (xiSquareGaussian_analytic s v).differentiableAt
  have hg : Differentiable ℂ g := by
    apply differentiableOn_univ.1
    exact (Complex.differentiableOn_dslope (f := F) (s := Set.univ) (c := 0) Filter.univ_mem).2
      hF.differentiableOn
  have hzwre : z.re ≤ w.re := by simp only [z,w,add_re,ofReal_re,mul_re,I_re,I_im,ofReal_im,mul_zero,zero_mul,sub_self,add_zero]; linarith
  have hzwim : z.im ≤ w.im := by simp only [z,w,add_im,ofReal_im,mul_im,I_re,I_im,ofReal_re,mul_one,zero_mul,add_zero,zero_add]; linarith
  have hmid : Rectangle z w ∈ 𝓝 (0 : ℂ) := by
    rw [rectangle_mem_nhds_iff,mem_reProdIm]
    have hz : z.re = a ∧ z.im = c := by simp [z]
    have hw : w.re = b ∧ w.im = d := by simp [w]
    rw [hz.1,hw.1,hz.2,hw.2,uIoo_of_le (by linarith : a ≤ b),uIoo_of_le (by linarith : c ≤ d)]
    exact ⟨⟨ha,hb⟩,hc,hd⟩
  have hprincipal : Set.EqOn
      (xiSquareContour s-fun v => zetaXi s^2/(v-0)) g (Rectangle z w \ {0}) := by
    intro v hv
    have hv0 : v ≠ 0 := hv.2
    change F v/v-zetaXi s^2/(v-0) = dslope F 0 v
    rw [dslope_of_ne F hv0]
    simp only [slope,smul_eq_mul,vsub_eq_sub,sub_zero]
    have he : F 0 = zetaXi s^2 := by simp [F,xiSquareGaussian]
    rw [he]
    ring
  have h := ResidueTheoremOnRectangleWithSimplePole hzwre hzwim hmid
    (fun v _ => (hg v).differentiableWithinAt) hprincipal
  change (1/(2*(Real.pi : ℂ)*I))*RectangleIntegral (xiSquareContour s) z w = zetaXi s^2 at h
  have hconst : (2*(Real.pi : ℂ)*I) ≠ 0 := by
    exact mul_ne_zero (mul_ne_zero (by norm_num) (ofReal_ne_zero.2 Real.pi_ne_zero)) I_ne_zero
  change RectangleIntegral (xiSquareContour s) z w = _
  calc
    _ = (2*(Real.pi : ℂ)*I)*((1/(2*(Real.pi : ℂ)*I))*
        RectangleIntegral (xiSquareContour s) z w) := by field_simp
    _ = _ := by rw [h]

/-- Convergent vertical contours retain the central xi-square residue. -/
theorem xiSquareContour_limit (s : ℂ) (hs : s.re = 1/2) :
    I*(∫ u : ℝ, xiSquareContour s (1+(u : ℂ)*I))-
      I*(∫ u : ℝ, xiSquareContour s (-1+(u : ℂ)*I)) =
        (2*(Real.pi : ℂ)*I)*zetaXi s^2 := by
  obtain ⟨htop,hbot⟩ := xiSquareContour_horizontal_tendsto s hs
  have hr := intervalIntegral_tendsto_integral
    (xiSquareContour_vertical_integrable s hs 1 (by norm_num))
    tendsto_neg_atTop_atBot tendsto_id
  have hl := intervalIntegral_tendsto_integral
    (xiSquareContour_vertical_integrable s hs (-1) (by norm_num))
    tendsto_neg_atTop_atBot tendsto_id
  have hlim := ((hbot.sub htop).add (hr.const_mul I)).sub (hl.const_mul I)
  have hlim' : Tendsto (fun T : ℝ => xiRectangleIntegral (xiSquareContour s) (-1) 1 (-T) T)
      atTop (𝓝 (I*(∫ u : ℝ, xiSquareContour s (1+(u : ℂ)*I))-
        I*(∫ u : ℝ, xiSquareContour s (-1+(u : ℂ)*I)))) := by
    simpa [xiRectangleIntegral,RectangleIntegral,HIntegral,VIntegral,smul_eq_mul] using hlim
  apply tendsto_nhds_unique hlim'
  apply tendsto_const_nhds.congr'
  filter_upwards [eventually_ge_atTop (1 : ℝ)] with T hT
  exact (xiSquareGaussian_rectangle s (-1) 1 (-T) T (by norm_num) (by norm_num)
    (by linarith) (by linarith)).symm

/-- Reflecting the left line introduces the orientation minus sign. -/
theorem xiSquareContour_left_reflection (s : ℂ) :
    (∫ u : ℝ, xiSquareContour s (-1+(u : ℂ)*I)) =
      -(∫ u : ℝ, xiSquareContour (1-s) (1+(u : ℂ)*I)) := by
  have he (u : ℝ) : xiSquareContour s (-1+(-u : ℝ)*I) =
      -xiSquareContour (1-s) (1+(u : ℂ)*I) := by
    have hw : (-1 : ℂ)+(-u : ℝ)*I = -(1+(u : ℂ)*I) := by push_cast; ring
    rw [xiSquareContour,hw,xiSquareGaussian_reflection,xiSquareContour,div_neg]
  calc
    _ = ∫ u : ℝ, xiSquareContour s (-1+(-u : ℝ)*I) := by
      symm
      simpa only [Complex.ofReal_neg] using
        integral_neg_eq_self (fun u : ℝ => xiSquareContour s (-1+(u : ℂ)*I)) volume
    _ = _ := by simp_rw [he]; rw [integral_neg]

/-- The right-hand Gaussian contour before normalizing by the Gamma factor. -/
noncomputable def xiSquareIntegral (s : ℂ) : ℂ :=
  (2*(Real.pi : ℂ))⁻¹*∫ u : ℝ, xiSquareContour s (1+(u : ℂ)*I)

/-- An exact smoothed functional equation for the entire xi square. -/
theorem zetaXi_square_equation (s : ℂ) (hs : s.re = 1/2) :
    zetaXi s^2 = xiSquareIntegral s+xiSquareIntegral (1-s) := by
  have h := xiSquareContour_limit s hs
  rw [xiSquareContour_left_reflection] at h
  have hpi : (Real.pi : ℂ) ≠ 0 := ofReal_ne_zero.2 Real.pi_ne_zero
  have he : (2*(Real.pi : ℂ))*zetaXi s^2 =
      (∫ u : ℝ, xiSquareContour s (1+(u : ℂ)*I))+
        (∫ u : ℝ, xiSquareContour (1-s) (1+(u : ℂ)*I)) := by
    apply mul_left_cancel₀ (show (I : ℂ) ≠ 0 from I_ne_zero)
    calc
      _ = (2*(Real.pi : ℂ)*I)*zetaXi s^2 := by ring
      _ = _ := h.symm.trans (by ring)
  unfold xiSquareIntegral
  field_simp
  simp_rw [mul_comm I]
  linear_combination he

/-- The entire completion respects complex conjugation, including both removed poles. -/
theorem zetaXi_conj (s : ℂ) : zetaXi (conj s) = conj (zetaXi s) := by
  by_cases hs0 : s = 0
  · subst s; simp
  by_cases hs1 : s = 1
  · subst s; simp
  have hc0 : conj s ≠ 0 := by simpa using hs0
  have hc1 : conj s ≠ 1 := by
    intro he
    have hh := congrArg (starRingEnd ℂ) he
    exact hs1 (by simpa using hh)
  rw [zetaXi_eq_completed hc0 hc1,zetaXi_eq_completed hs0 hs1,completedRiemannZeta_conj]
  simp only [map_mul,map_sub,map_one]

theorem xiSquareGaussian_conj (s w : ℂ) :
    xiSquareGaussian (conj s) (conj w) = conj (xiSquareGaussian s w) := by
  simp only [xiSquareGaussian,← map_add,zetaXi_conj,map_mul,map_pow]
  congr 1
  calc
    _ = Complex.exp (conj (w^2)) := by
      congr 1
      exact (map_pow (starRingEnd ℂ) w 2).symm
    _ = _ := Complex.exp_conj (w^2)

theorem xiSquareContour_conj (s w : ℂ) :
    xiSquareContour (conj s) (conj w) = conj (xiSquareContour s w) := by
  simp only [xiSquareContour,xiSquareGaussian_conj,map_div₀]

theorem xiSquareIntegral_conj (s : ℂ) : xiSquareIntegral (conj s) = conj (xiSquareIntegral s) := by
  have he (u : ℝ) : xiSquareContour (conj s) (1+(u : ℂ)*I) =
      conj (xiSquareContour s (1+(-u : ℝ)*I)) := by
    simpa only [map_add,map_one,map_mul,map_neg,Complex.conj_ofReal,Complex.conj_I,
      Complex.ofReal_neg,neg_mul,mul_neg,neg_neg] using
      xiSquareContour_conj s (1+(-u : ℝ)*I)
  unfold xiSquareIntegral
  simp_rw [he]
  rw [integral_conj]
  have hn := integral_neg_eq_self (fun u : ℝ => xiSquareContour s (1+(u : ℂ)*I)) volume
  rw [hn]
  simp only [map_mul,map_inv₀,map_ofNat,Complex.conj_ofReal]

/-- The exact smoothed zeta square after dividing by the nonzero completion. -/
noncomputable def xiSmoothedZetaSquare (s : ℂ) : ℂ := xiSquareIntegral s/xiSquareNormalizer s

/-- Pointwise fourth-power reduction to one normalized Gaussian contour.
The mean estimate for that contour is a separate remaining analytic step. -/
theorem riemannZeta_fourth_le_smoothed (s : ℂ) (hs : s.re = 1/2) :
    ‖riemannZeta s‖^4 ≤ 4*‖xiSmoothedZetaSquare s‖^2 := by
  have hspos : 0 < s.re := by linarith
  have hs1 : s ≠ 1 := by intro he; simp [he] at hs
  have hQ := xiSquareNormalizer_ne_zero hs
  have hnum : zetaXi s^2 = xiSquareNormalizer s*riemannZeta s^2 := by
    rw [zetaXi_eq_gamma_zeta hspos hs1]
    unfold xiSquareNormalizer
    ring
  have he := congrArg (fun v : ℂ => v/xiSquareNormalizer s) (zetaXi_square_equation s hs)
  rw [hnum,mul_div_cancel_left₀ _ hQ,add_div] at he
  have hreflect : (1 : ℂ)-s = conj s := by
    apply Complex.ext
    · simp only [sub_re,one_re,conj_re,hs]; norm_num
    · simp
  have hn : ‖xiSquareIntegral (1-s)/xiSquareNormalizer s‖ = ‖xiSmoothedZetaSquare s‖ := by
    rw [hreflect,xiSquareIntegral_conj,norm_div,norm_conj]
    exact (norm_div (xiSquareIntegral s) (xiSquareNormalizer s)).symm
  have hb : ‖riemannZeta s^2‖ ≤ 2*‖xiSmoothedZetaSquare s‖ := by
    calc
      _ = ‖xiSmoothedZetaSquare s+xiSquareIntegral (1-s)/xiSquareNormalizer s‖ := by rw [he]; rfl
      _ ≤ ‖xiSmoothedZetaSquare s‖+‖xiSquareIntegral (1-s)/xiSquareNormalizer s‖ := norm_add_le _ _
      _ = _ := by rw [hn]; ring
  have hp := pow_le_pow_left₀ (norm_nonneg (riemannZeta s^2)) hb 2
  simpa only [norm_pow,mul_pow,← pow_mul,show (2 : ℕ)*2 = 4 by norm_num,
    show (2 : ℝ)^2 = 4 by norm_num] using hp

end Legendre.Zeta
