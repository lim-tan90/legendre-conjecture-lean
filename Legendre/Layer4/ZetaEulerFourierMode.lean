/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.ZetaFiniteEuler
public import Mathlib.MeasureTheory.Integral.IntegralEqImproper
public import Mathlib.Analysis.Real.Pi.Bounds

@[expose] public section
namespace Legendre.Zeta
open Complex Filter Set MeasureTheory
open scoped Topology

noncomputable def eulerFourierMode (k : ℤ) (x : ℝ) : ℂ :=
  Complex.exp ((2*(Real.pi : ℂ)*(k : ℂ)*I)*(x : ℂ))

@[simp] theorem norm_eulerFourierMode (k : ℤ) (x : ℝ) :
    ‖eulerFourierMode k x‖ = 1 := by
  rw [eulerFourierMode,Complex.norm_exp]
  simp [mul_re,mul_im]

theorem eulerFourierMode_hasDerivAt (k : ℤ) (x : ℝ) :
    HasDerivAt (eulerFourierMode k) ((2*(Real.pi : ℂ)*(k : ℂ)*I)*eulerFourierMode k x) x := by
  have h := (((hasDerivAt_id x).ofReal_comp).const_mul (2*(Real.pi : ℂ)*(k : ℂ)*I)).cexp
  unfold eulerFourierMode
  simpa [mul_comm] using h

/-- An individual nonzero Euler Fourier mode has a boundary-sized integral.
The lower endpoint dominates the imaginary part of the underlying power. -/
theorem norm_integral_eulerFourierMode_cpow_le (k : ℤ) (hk : k ≠ 0) {a : ℝ} (ha : 1 ≤ a)
    {u : ℂ} (hu : u.re < -2) (hheight : |u.im| ≤ a) (hsize : ‖u‖ ≤ 4*a) :
    ‖∫ x in Ioi a, eulerFourierMode k x*(x : ℂ)^u‖ ≤ 5*a^u.re := by
  let c : ℂ := 2*(Real.pi : ℂ)*(k : ℂ)*I
  let F := fun x : ℝ => eulerFourierMode k x*(x : ℂ)^u
  let D := fun x : ℝ => c+u/(x : ℂ)
  let G := fun x : ℝ => F x / D x
  let R := fun x : ℝ => F x*((-u)/(x : ℂ)^2)/(D x)^2
  have ha₀ : 0 < a := by linarith
  have hu₀ : u ≠ 0 := by intro he; rw [he,Complex.zero_re] at hu; linarith
  have hkin : (1 : ℝ) ≤ |(k : ℝ)| := by
    have h : (1 : ℤ) ≤ |k| := by
      by_cases hsign : 0 ≤ k
      · rw [abs_of_nonneg hsign]
        omega
      · rw [abs_of_nonpos (le_of_not_ge hsign)]
        omega
    exact_mod_cast h
  have hd (x : ℝ) (hx : a ≤ x) : 1 ≤ ‖D x‖ := by
    have hxp : 0 < x := ha₀.trans_le hx
    have he : (D x).im = 2*Real.pi*(k : ℝ)+u.im/x := by
      dsimp only [D,c]
      simp [add_im,mul_im,mul_re,div_im,Complex.normSq_ofReal]
      field_simp
    have hfactor : |u.im/x| ≤ 1 := by
      rw [abs_div,abs_of_pos hxp]
      exact (div_le_one hxp).2 (hheight.trans hx)
    have hK : 2*Real.pi ≤ |2*Real.pi*(k : ℝ)| := by
      rw [abs_mul,abs_of_nonneg (by positivity : 0 ≤ 2*Real.pi)]
      exact le_mul_of_one_le_right (by positivity) hkin
    have htri := abs_add_le ((D x).im) (-(u.im/x))
    rw [he,add_neg_cancel_right,abs_neg,← he] at htri
    exact (show (1 : ℝ) ≤ |(D x).im| by linarith only [hfactor,htri,hK,Real.pi_gt_three]).trans
      (Complex.abs_im_le_norm (D x))
  have hF_norm (x : ℝ) (hx : 0 < x) : ‖F x‖ = x^u.re := by
    dsimp only [F]
    rw [norm_mul,norm_eulerFourierMode,one_mul,norm_cpow_eq_rpow_re_of_pos hx]
  have hD_deriv (x : ℝ) (hx : 0 < x) : HasDerivAt D ((-u)/(x : ℂ)^2) x := by
    have hb := ((hasDerivAt_const x u).div (hasDerivAt_id x).ofReal_comp
      (ofReal_ne_zero.mpr hx.ne')).const_add c
    simpa [D] using hb
  have hF_deriv (x : ℝ) (hx : 0 < x) : HasDerivAt F (D x*F x) x := by
    have hi := (eulerFourierMode_hasDerivAt k x).mul
      (hasDerivAt_ofReal_cpow_const hx.ne' hu₀)
    convert hi using 1
    dsimp only [D,F,c]
    have hpower : (x : ℂ)^(u-1) = (x : ℂ)^u/(x : ℂ) := by
      rw [sub_eq_add_neg,Complex.cpow_add _ _ (ofReal_ne_zero.mpr hx.ne'),Complex.cpow_neg,Complex.cpow_one,← div_eq_mul_inv]
    rw [hpower]
    ring
  have hG_deriv (x : ℝ) (hx : a ≤ x) : HasDerivAt G (F x-R x) x := by
    have hxp : 0 < x := ha₀.trans_le hx
    have hD₀ : D x ≠ 0 := norm_pos_iff.mp (zero_lt_one.trans_le (hd x hx))
    have hb := (hF_deriv x hxp).div (hD_deriv x hxp) hD₀
    convert hb using 1
    simp only [R]
    field_simp [hD₀,ofReal_ne_zero.mpr hxp.ne']
  have hFi : IntegrableOn F (Ioi a) := by
    have hc : ContinuousOn F (Ioi a) := fun x hx =>
      (hF_deriv x (ha₀.trans hx)).continuousAt.continuousWithinAt
    apply Integrable.mono (integrableOn_Ioi_rpow_of_lt (by linarith only [hu] : u.re < -1) ha₀)
      (hc.aestronglyMeasurable measurableSet_Ioi)
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
    rw [hF_norm x (ha₀.trans hx),Real.norm_eq_abs,abs_of_nonneg (Real.rpow_nonneg (ha₀.trans hx).le _)]
  have hRnorm (x : ℝ) (hx : a ≤ x) : ‖R x‖ ≤ ‖u‖*x^(u.re-2) := by
    have hxp : 0 < x := ha₀.trans_le hx
    dsimp only [R]
    rw [norm_div,norm_mul,norm_div,norm_neg,norm_pow,Complex.norm_real,Real.norm_eq_abs,abs_of_pos hxp,
      norm_pow,hF_norm x hxp]
    have hD₁ : 1 ≤ ‖D x‖^2 := one_le_pow₀ (hd x hx)
    apply (div_le_self (by positivity) hD₁).trans_eq
    rw [Real.rpow_sub hxp,Real.rpow_two]
    ring
  have hRp : IntegrableOn (fun x : ℝ => ‖u‖*x^(u.re-2)) (Ioi a) :=
    (integrableOn_Ioi_rpow_of_lt (by linarith only [hu] : u.re-2 < -1) ha₀).const_mul ‖u‖
  have hRi : IntegrableOn R (Ioi a) := by
    have hc : ContinuousOn R (Ioi a) := by
      intro x hx
      have hxp : 0 < x := ha₀.trans hx
      have hD₀ : D x ≠ 0 := norm_pos_iff.mp (zero_lt_one.trans_le (hd x hx.le))
      have hK : ContinuousAt (fun x : ℝ => (-u)/(x : ℂ)^2) x :=
        continuousAt_const.div (continuous_ofReal.continuousAt.pow 2)
          (pow_ne_zero 2 (ofReal_ne_zero.mpr hxp.ne'))
      exact (((hF_deriv x hxp).continuousAt.mul hK).div
        ((hD_deriv x hxp).continuousAt.pow 2) (pow_ne_zero 2 hD₀)).continuousWithinAt
    apply Integrable.mono hRp (hc.aestronglyMeasurable measurableSet_Ioi)
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
    rw [Real.norm_eq_abs,abs_of_nonneg (mul_nonneg (norm_nonneg _) (Real.rpow_nonneg (ha₀.trans hx).le _))]
    exact hRnorm x hx.le
  have hGnorm (x : ℝ) (hx : a ≤ x) : ‖G x‖ ≤ x^u.re := by
    dsimp only [G]
    rw [norm_div,hF_norm x (ha₀.trans_le hx)]
    exact div_le_self (Real.rpow_nonneg (ha₀.trans_le hx).le _) (hd x hx)
  have hins : Tendsto G atTop (𝓝 0) := by
    rw [tendsto_zero_iff_norm_tendsto_zero]
    have hexp : Tendsto (fun x : ℝ => x^u.re) atTop (𝓝 0) := by
      simpa only [neg_neg] using
        (tendsto_rpow_neg_atTop (y := -u.re) (by linarith only [hu]))
    apply squeeze_zero' (Eventually.of_forall (fun _ => norm_nonneg _)) _ hexp
    filter_upwards [eventually_ge_atTop a] with x hx
    exact hGnorm x hx
  have he := integral_Ioi_of_hasDerivAt_of_tendsto' (fun x hx => hG_deriv x hx)
    (hFi.sub hRi) hins
  change (∫ x in Ioi a, F x-R x) = _ at he
  rw [integral_sub hFi hRi,zero_sub] at he
  have hrel : (∫ x in Ioi a, F x) = -G a+(∫ x in Ioi a, R x) := by
    rw [← he]
    ring
  have herror : ‖∫ x in Ioi a, R x‖ ≤ 4*a^u.re := by
    apply (norm_integral_le_of_norm_le hRp ?_).trans
    · rw [integral_const_mul,integral_Ioi_rpow_of_lt (by linarith only [hu]) ha₀,
        show u.re-2+1 = u.re-1 by ring,← div_neg_eq_neg_div',
        show -(u.re-1) = 1-u.re by ring]
      have hb := div_le_self (show 0 ≤ a^(u.re-1) by positivity) (by linarith only [hu] : 1 ≤ 1-u.re)
      have hq : ‖u‖*(a^(u.re-1)/(1-u.re)) ≤ (4*a)*a^(u.re-1) :=
        (mul_le_mul_of_nonneg_left hb (norm_nonneg _)).trans
          (mul_le_mul_of_nonneg_right hsize (by positivity))
      apply hq.trans_eq
      rw [Real.rpow_sub ha₀,Real.rpow_one]
      field_simp
    · filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
      exact hRnorm x hx.le
  change ‖∫ x in Ioi a, F x‖ ≤ _
  rw [hrel]
  exact (norm_add_le _ _).trans (by
    rw [norm_neg]
    exact (add_le_add (hGnorm a le_rfl) herror).trans_eq (by ring))

end Legendre.Zeta
