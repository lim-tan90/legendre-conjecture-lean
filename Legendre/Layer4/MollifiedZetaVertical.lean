/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.MollifiedZetaJensen
public import Mathlib.MeasureTheory.Integral.Prod

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Metric Set
open Density.Detector

/-- The mollified error has a finite second moment on every compact vertical segment above the pole. -/
theorem integrableOn_mollifiedError_vertical (X : ℕ) (a : ℝ) {A B : ℝ} (hA : 0 < A) :
    IntegrableOn (fun t : ℝ => ‖mollifiedError X ((a : ℂ) + (t : ℂ)*I)‖^2) (Icc A B) := by
  apply ContinuousOn.integrableOn_compact isCompact_Icc
  have hc : Continuous (fun t : ℝ => (a : ℂ) + (t : ℂ)*I) := by fun_prop
  have hm : ContinuousOn (fun t : ℝ => mollifiedError X ((a : ℂ) + (t : ℂ)*I)) (Icc A B) := by
    intro t ht
    apply ContinuousAt.continuousWithinAt
    refine (mollifiedError_analyticAt X ?_).continuousAt.comp hc.continuousAt
    intro he
    have him := congrArg Complex.im he
    simp at him
    linarith [ht.1]
  exact hm.norm.pow 2

/-- Height integration of a continuously parametrized contour average is
controlled by the uniform vertical moment on the enlarged rectangle. -/
theorem integral_mollified_translatedAverage_le_vertical (X : ℕ) (q : ℝ → ℂ)
    (hq : Continuous q) {H A B α β M : ℝ} (hA : H < A) (hAB : A ≤ B)
    (ha : ∀ θ, (q θ).re ∈ Icc α β) (hd : ∀ θ, (q θ).im ∈ Icc (-H) H)
    (hM : ∀ a ∈ Icc α β,
      (∫ t in Icc (A-H) (B+H), ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤ M) :
    let K := fun t : ℝ => (2*Real.pi)⁻¹*
      ∫ θ in Icc 0 (2*Real.pi), ‖mollifiedError X (q θ+(t : ℂ)*I)‖^2
    IntegrableOn K (Icc A B) ∧ (∫ t in Icc A B, K t) ≤ M := by
  dsimp only
  let width := 2*Real.pi
  have hwidth : 0 < width := by dsimp [width]; positivity
  let a := fun θ => (q θ).re
  let d := fun θ => (q θ).im
  let f := fun x y : ℝ => ‖mollifiedError X ((x : ℂ)+(y : ℂ)*I)‖^2
  let g := fun t θ : ℝ => f (a θ) (t+d θ)
  have hca : Continuous a := continuous_re.comp hq
  have hcd : Continuous d := continuous_im.comp hq
  have hg : Integrable (Function.uncurry g)
      ((volume.restrict (Icc A B)).prod (volume.restrict (Icc 0 width))) := by
    rw [Measure.prod_restrict]
    apply ContinuousOn.integrableOn_compact (isCompact_Icc.prod isCompact_Icc)
    let z := fun p : ℝ × ℝ => (a p.2 : ℂ) + ((p.1+d p.2 : ℝ) : ℂ)*I
    have hc : Continuous z := by dsimp only [z]; fun_prop
    have hm : ContinuousOn (fun p => mollifiedError X (z p)) (Icc A B ×ˢ Icc 0 width) := by
      intro p hp
      apply ContinuousAt.continuousWithinAt
      refine (mollifiedError_analyticAt X ?_).continuousAt.comp hc.continuousAt
      intro he
      have him := congrArg Complex.im he
      simp [z] at him
      linarith [hp.1.1, (hd p.2).1]
    exact hm.norm.pow 2
  have havg (t : ℝ) :
      width⁻¹*(∫ θ in Icc 0 width, ‖mollifiedError X (q θ+(t : ℂ)*I)‖^2) =
        width⁻¹*(∫ θ in Icc 0 width, g t θ) := by
    congr 1
    apply integral_congr_ae
    filter_upwards with θ
    have he : q θ+(t : ℂ)*I = (a θ : ℂ)+((t+d θ : ℝ) : ℂ)*I := by
      apply Complex.ext <;> simp [a,d,add_comm]
    dsimp only [g,f]
    rw [he]
  have hupper (θ : ℝ) : (∫ t in Icc A B, g t θ) ≤ M := by
    have hart : Icc (A+d θ) (B+d θ) ⊆ Icc (A-H) (B+H) := by
      apply Icc_subset_Icc <;> linarith [(hd θ).1, (hd θ).2]
    calc
      _ = ∫ t in Icc (A+d θ) (B+d θ), f (a θ) t := by
        rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hAB,
          integral_Icc_eq_integral_Ioc,
          ← intervalIntegral.integral_of_le (add_le_add_left hAB (d θ))]
        exact intervalIntegral.integral_comp_add_right (f (a θ)) (d θ)
      _ ≤ ∫ t in Icc (A-H) (B+H), f (a θ) t :=
        setIntegral_mono_set (integrableOn_mollifiedError_vertical X _ (sub_pos.mpr hA))
          (Filter.Eventually.of_forall fun _ => sq_nonneg _) hart.eventuallySubset
      _ ≤ M := hM _ (ha θ)
  have hconst : Integrable (fun _ : ℝ => M) (volume.restrict (Icc 0 width)) := integrable_const _
  have he : (fun t : ℝ => (2*Real.pi)⁻¹*
      ∫ θ in Icc 0 (2*Real.pi), ‖mollifiedError X (q θ+(t : ℂ)*I)‖^2) =
      (fun t : ℝ => width⁻¹*∫ θ in Icc 0 width, g t θ) := funext havg
  rw [he]
  constructor
  · exact hg.integral_prod_left.const_mul _
  · rw [integral_const_mul, integral_integral_swap hg]
    calc
      _ ≤ width⁻¹ * ∫ _ in Icc 0 width, M :=
        mul_le_mul_of_nonneg_left (integral_mono hg.integral_prod_right hconst hupper)
          (inv_nonneg.mpr hwidth.le)
      _ = M := by
        rw [setIntegral_const, measureReal_def, Real.volume_Icc, sub_zero,
          ENNReal.toReal_ofReal hwidth.le, smul_eq_mul, ← mul_assoc, inv_mul_cancel₀ hwidth.ne',
          one_mul]

/-- Integrating the circle averages in height costs at most the uniform vertical
second moment on the enlarged rectangle. -/
theorem integral_mollified_circleAverage_le_vertical (X : ℕ) (b : ℝ)
    {R A B M : ℝ} (hR : 0 ≤ R) (hA : R < A) (hAB : A ≤ B)
    (hM : ∀ a ∈ Icc (b-R) (b+R),
      (∫ t in Icc (A-R) (B+R), ‖mollifiedError X ((a : ℂ) + (t : ℂ)*I)‖^2) ≤ M) :
    IntegrableOn (fun t : ℝ =>
      Real.circleAverage (fun z => ‖mollifiedError X z‖^2) ((b : ℂ) + (t : ℂ)*I) R)
      (Icc A B) ∧
    (∫ t in Icc A B,
      Real.circleAverage (fun z => ‖mollifiedError X z‖^2) ((b : ℂ) + (t : ℂ)*I) R) ≤ M := by
  let q := fun θ => circleMap (b : ℂ) R θ
  have hq : Continuous q := by dsimp only [q]; fun_prop [circleMap]
  have hre (θ : ℝ) : (q θ).re = b+R*Real.cos θ := by
    simp [q, circleMap, exp_ofReal_mul_I, mul_re, -Complex.ofReal_cos]
  have him (θ : ℝ) : (q θ).im = R*Real.sin θ := by
    simp [q, circleMap, exp_ofReal_mul_I, mul_im, -Complex.ofReal_sin]
  have hb (θ : ℝ) : (q θ).re ∈ Icc (b-R) (b+R) := by
    rw [hre]
    exact ⟨by linarith [mul_le_mul_of_nonneg_left (Real.neg_one_le_cos θ) hR],
      by linarith [mul_le_mul_of_nonneg_left (Real.cos_le_one θ) hR]⟩
  have hi (θ : ℝ) : (q θ).im ∈ Icc (-R) R := by
    rw [him]
    exact ⟨by linarith [mul_le_mul_of_nonneg_left (Real.neg_one_le_sin θ) hR],
      by linarith [mul_le_mul_of_nonneg_left (Real.sin_le_one θ) hR]⟩
  have he : (fun t : ℝ =>
      Real.circleAverage (fun z => ‖mollifiedError X z‖^2) ((b : ℂ)+(t : ℂ)*I) R) =
      (fun t : ℝ => (2*Real.pi)⁻¹*
        ∫ θ in Icc 0 (2*Real.pi), ‖mollifiedError X (q θ+(t : ℂ)*I)‖^2) := by
    funext t
    rw [Real.circleAverage_def, smul_eq_mul, intervalIntegral.integral_of_le (by positivity : 0 ≤ 2*Real.pi),
      ← integral_Icc_eq_integral_Ioc]
    congr 1
    apply integral_congr_ae
    filter_upwards with θ
    dsimp [q, circleMap]
    rw [add_right_comm]
  rw [he]
  exact integral_mollified_translatedAverage_le_vertical X q hq hA hAB hb hi hM

private theorem integral_const_Icc_real {A B : ℝ} (hAB : A ≤ B) (c : ℝ) :
    (∫ _ in Icc A B, c) = (B-A)*c := by
  rw [setIntegral_const, measureReal_def, Real.volume_Icc, ENNReal.toReal_ofReal (sub_nonneg.mpr hAB),
    smul_eq_mul]

/-- Integration over all centers counts each selected ordinate over a window
of length (2h), with no spacing requirement. -/
theorem sum_zeta_multiplicity_le_of_height_window_bound {U V h L : ℝ}
    (hh : 0 < h) (S : Finset ℂ) (hS : ∀ z ∈ S, z.im ∈ Icc U V)
    (f : ℝ → ℝ) (hi : IntegrableOn f (Icc (U-h) (V+h)))
    (hpoint : ∀ t ∈ Icc (U-h) (V+h),
      L*(∑ z ∈ S.filter (fun z => t ∈ Icc (z.im-h) (z.im+h)), (zeroMultiplicity z : ℝ)) ≤ f t) :
    (2*h*L)*(∑ z ∈ S, (zeroMultiplicity z : ℝ)) ≤ ∫ t in Icc (U-h) (V+h), f t := by
  classical
  let A := U-h
  let B := V+h
  let w := fun z : ℂ => (zeroMultiplicity z : ℝ)
  let window := fun z : ℂ => Icc (z.im-h) (z.im+h)
  let weight := fun z : ℂ => (window z).indicator (fun _ => w z)
  let count := fun t : ℝ => ∑ z ∈ S, weight z t
  have hweight (z : ℂ) : IntegrableOn (weight z) (Icc A B) :=
    (integrable_const _).indicator measurableSet_Icc
  have hcount : IntegrableOn count (Icc A B) := integrable_finsetSum S (fun z _ => hweight z)
  have hint : (∫ t in Icc A B, count t) = (2*h)*(∑ z ∈ S, w z) := by
    change (∫ t in Icc A B, ∑ z ∈ S, weight z t) = _
    rw [integral_finsetSum S (fun z _ => hweight z), Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro z hz
    have hwindow : window z ⊆ Icc A B := by
      exact Icc_subset_Icc (sub_le_sub_right (hS z hz).1 h) (add_le_add_left (hS z hz).2 h)
    change (∫ t in Icc A B, (window z).indicator (fun _ => w z) t) = _
    rw [setIntegral_indicator measurableSet_Icc, inter_eq_right.mpr hwindow, setIntegral_const,
      measureReal_def, Real.volume_Icc, ENNReal.toReal_ofReal (sub_nonneg.mpr
        (show z.im-h ≤ z.im+h by linarith)), smul_eq_mul]
    ring
  have hcountEq (t : ℝ) : count t = ∑ z ∈ S.filter (fun z => t ∈ window z), w z := by
    change (∑ z ∈ S, weight z t) = _
    rw [Finset.sum_filter]
    simp only [weight, indicator_apply]
  have hb : (∫ t in Icc A B, L*count t) ≤ ∫ t in Icc A B, f t :=
    setIntegral_mono_on (hcount.const_mul L) hi measurableSet_Icc (fun t ht => by
      rw [hcountEq]
      exact hpoint t ht)
  rw [integral_const_mul, hint] at hb
  exact (by ring : (2*h*L)*(∑ z ∈ S, w z) = L*((2*h)*(∑ z ∈ S, w z))).trans_le hb

/-- A sweep of centers of constant real part bounds the total analytic
multiplicity by separate vertical and center second moments. -/
theorem sum_zeta_multiplicity_le_mollified_vertical_center_moment (X : ℕ)
    {b σ U V h r R M C : ℝ} (hb : 1 ≤ b) (hUV : U ≤ V) (hh : 0 < h)
    (hr : 0 < r) (hrR : r < R) (hgeom : (b-σ)^2+h^2 ≤ r^2) (hU : R < U-h)
    (hErr : ∀ t ∈ Icc (U-h) (V+h),
      ‖mollifiedError X ((b : ℂ) + (t : ℂ)*I)‖ ≤ 1/2)
    (hC : (∫ t in Icc (U-h) (V+h), ‖mollifiedError X ((b : ℂ)+(t : ℂ)*I)‖^2) ≤ C)
    (hM : ∀ a ∈ Icc (b-R) (b+R),
      (∫ t in Icc (U-h-R) (V+h+R), ‖mollifiedError X ((a : ℂ) + (t : ℂ)*I)‖^2) ≤ M)
    (S : Finset ℂ) (hS : ∀ z ∈ S, z.re ∈ Icc σ 1 ∧ z.im ∈ Icc U V) :
    (2*h*Real.log (R/r))*(∑ z ∈ S, (zeroMultiplicity z : ℝ)) ≤
      M + (4/3 : ℝ)*C := by
  classical
  let A := U-h
  let B := V+h
  let L := Real.log (R/r)
  have hAB : A ≤ B := by dsimp [A,B]; linarith
  have hR := hr.trans hrR
  have hL : 0 < L := Real.log_pos ((one_lt_div hr).mpr hrR)
  let avg := fun t : ℝ =>
    Real.circleAverage (fun z => ‖mollifiedError X z‖^2) ((b : ℂ)+(t : ℂ)*I) R
  let center := fun t : ℝ => ‖mollifiedError X ((b : ℂ)+(t : ℂ)*I)‖^2
  have hcenter : IntegrableOn center (Icc A B) :=
    integrableOn_mollifiedError_vertical X b (hR.trans hU)
  have havg := integral_mollified_circleAverage_le_vertical X b hR.le hU hAB hM
  let f := fun t : ℝ => avg t+(4/3 : ℝ)*center t
  have hfi : IntegrableOn f (Icc A B) := havg.1.add (hcenter.const_mul _)
  have hpoint (t : ℝ) (ht : t ∈ Icc A B) :
      L*(∑ z ∈ S.filter (fun z => t ∈ Icc (z.im-h) (z.im+h)), (zeroMultiplicity z : ℝ)) ≤ f t := by
    let c := (b : ℂ)+(t : ℂ)*I
    let Sₜ := S.filter (fun z => t ∈ Icc (z.im-h) (z.im+h))
    have hball (z : ℂ) (hz : z ∈ Sₜ) : z ∈ closedBall c r := by
      have hzS := Finset.mem_filter.mp hz
      have hre := (hS z hzS.1).1
      have hwin := hzS.2
      change z.im-h ≤ t ∧ t ≤ z.im+h at hwin
      have hresq : (z.re-b)^2 ≤ (b-σ)^2 := by
        rw [show (z.re-b)^2 = (b-z.re)^2 by ring]
        exact pow_le_pow_left₀ (by linarith [hre.2]) (by linarith [hre.1]) 2
      have himsq : (z.im-t)^2 ≤ h^2 := by
        rw [← sq_abs (z.im-t)]
        exact pow_le_pow_left₀ (abs_nonneg _) (abs_le.mpr ⟨by linarith [hwin.2],
          by linarith [hwin.1]⟩) 2
      rw [mem_closedBall, Complex.dist_eq]
      apply le_of_pow_le_pow_left₀ (by norm_num : (2 : ℕ) ≠ 0) hr.le
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp [c, sub_re, sub_im]
      nlinarith
    have hpole : (1 : ℂ) ∉ closedBall c R := by
      intro hp
      rw [mem_closedBall, Complex.dist_eq] at hp
      have him := Complex.abs_im_le_norm ((1 : ℂ)-c)
      have ht₁ : A ≤ t := ht.1
      have ht₀ : 0 ≤ t := by linarith
      simp [c, sub_im, abs_of_nonneg ht₀] at him
      linarith
    have hcountBound :=
      sum_zeta_multiplicity_le_mollified_circle_with_center_error X c (hErr t ht) r R hr hrR
        hpole Sₜ hball
    rw [mul_comm]
    exact (le_div_iff₀ hL).mp hcountBound
  apply (sum_zeta_multiplicity_le_of_height_window_bound hh S (fun z hz => (hS z hz).2) f hfi hpoint).trans
  dsimp only [f]
  rw [integral_add havg.1 (hcenter.const_mul (4/3 : ℝ)), integral_const_mul]
  exact add_le_add havg.2 (mul_le_mul_of_nonneg_left hC (by norm_num))

/-- A multiplicity estimate on the upper-height zeros gives the increment
of the actual density count. -/
theorem zeroDensityCount_le_of_multiplicity_sweep {σ U V B : ℝ} (hUV : U ≤ V)
    (hsweep : ∀ S : Finset ℂ, (∀ z ∈ S, z.re ∈ Icc σ 1 ∧ z.im ∈ Icc U V) →
      (∑ z ∈ S, (zeroMultiplicity z : ℝ)) ≤ B) :
    (zeroDensityCount σ V : ℝ) ≤ (zeroDensityCount σ U : ℝ)+B := by
  classical
  let Z := (zerosRightOf_finite σ V).toFinset
  let S := Z.filter (fun z => U < z.im)
  have hS (z : ℂ) (hz : z ∈ S) : z.re ∈ Icc σ 1 ∧ z.im ∈ Icc U V := by
    have hh := Finset.mem_filter.1 hz
    have h := (zerosRightOf_finite σ V).mem_toFinset.1 hh.1
    exact ⟨⟨h.2, h.1.1.2.2.le⟩, ⟨hh.2.le, h.1.2.2⟩⟩
  have hbound := hsweep S hS
  have hlow : Z.filter (fun z => ¬ U < z.im) = (zerosRightOf_finite σ U).toFinset := by
    ext z
    simp only [Z, Finset.mem_filter, Set.Finite.mem_toFinset, not_lt]
    constructor
    · rintro ⟨hz, hu⟩
      exact ⟨⟨hz.1.1, hz.1.2.1, hu⟩, hz.2⟩
    · intro hz
      exact ⟨⟨⟨hz.1.1, hz.1.2.1, hz.1.2.2.trans hUV⟩, hz.2⟩, hz.1.2.2⟩
  have hsplit := Finset.sum_filter_add_sum_filter_not Z (fun z => U < z.im) zeroMultiplicity
  change (∑ z ∈ S, zeroMultiplicity z) +
    (∑ z ∈ Z.filter (fun z => ¬ U < z.im), zeroMultiplicity z) = _ at hsplit
  rw [hlow] at hsplit
  change (∑ z ∈ S, zeroMultiplicity z) + zeroDensityCount σ U = zeroDensityCount σ V at hsplit
  rw [← hsplit, Nat.cast_add, Nat.cast_sum]
  calc
    _ = (zeroDensityCount σ U : ℝ)+(∑ z ∈ S, (zeroMultiplicity z : ℝ)) := add_comm _ _
    _ ≤ _ := add_le_add_right hbound _

/-- The actual density increment for a sweep of disks with adjustable center
and radii. The hypotheses control the center and the enlarged rectangle. -/
theorem zeroDensityCount_le_mollified_vertical_center_moment (X : ℕ)
    {b σ U V h r R M C : ℝ} (hb : 1 ≤ b) (hUV : U ≤ V) (hh : 0 < h)
    (hr : 0 < r) (hrR : r < R) (hgeom : (b-σ)^2+h^2 ≤ r^2) (hU : R < U-h)
    (hErr : ∀ t ∈ Icc (U-h) (V+h),
      ‖mollifiedError X ((b : ℂ)+(t : ℂ)*I)‖ ≤ 1/2)
    (hC : (∫ t in Icc (U-h) (V+h), ‖mollifiedError X ((b : ℂ)+(t : ℂ)*I)‖^2) ≤ C)
    (hM : ∀ a ∈ Icc (b-R) (b+R),
      (∫ t in Icc (U-h-R) (V+h+R), ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤ M) :
    (zeroDensityCount σ V : ℝ) ≤ (zeroDensityCount σ U : ℝ) +
      (M + (4/3 : ℝ)*C) / (2*h*Real.log (R/r)) := by
  apply zeroDensityCount_le_of_multiplicity_sweep hUV
  intro S hS
  have hlog : 0 < Real.log (R/r) := Real.log_pos ((one_lt_div hr).mpr hrR)
  have hprod : 0 < 2*h*Real.log (R/r) := by positivity
  have hsum := sum_zeta_multiplicity_le_mollified_vertical_center_moment X hb hUV hh hr hrR hgeom
    hU hErr hC hM S hS
  exact (le_div_iff₀ hprod).2 ((mul_comm _ _).trans_le hsum)

/-- The near-one sweep can use the smaller of the vertical moment and the
integrated pointwise bound for its center term. -/
theorem zeroDensityCount_le_mollified_vertical_min_center_offset (X : ℕ) (hX : 1 ≤ X)
    {δ η U V M : ℝ} (hδ : 0 < δ) (hη : 0 < η)
    (hU : δ+5*η < U) (hUV : U ≤ V) (hscale : 2*(2+η⁻¹)^2 ≤ (X : ℝ)^η)
    (hM : ∀ a ∈ Icc (1-δ-2*η) (1+δ+6*η),
      (∫ t in Icc (U-(δ+5*η)) (V+(δ+5*η)),
        ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤ M) :
    (zeroDensityCount (1-δ) V : ℝ) ≤ (zeroDensityCount (1-δ) U : ℝ) +
      (M + (4/3 : ℝ)*min M ((V-U+2*η)*((X : ℝ)^(-η)*(2+η⁻¹)^2)^2)) /
        (2*η*Real.log ((δ+4*η)/(δ+3*η))) := by
  let D := (X : ℝ)^(-η)*(2+η⁻¹)^2
  have hX₀ : (0 : ℝ) < X := by exact_mod_cast hX
  have hD : D ≤ 1/2 := by
    dsimp [D]
    rw [Real.rpow_neg hX₀.le, inv_mul_eq_div]
    apply (div_le_iff₀ (Real.rpow_pos_of_pos hX₀ η)).mpr
    linarith
  have hErr (t : ℝ) : ‖mollifiedError X (((1+2*η : ℝ) : ℂ)+(t : ℂ)*I)‖ ≤ D :=
    norm_mollifiedError_le_right_half_plane X hX η hη (by simp)
  have hC :
      (∫ t in Icc (U-η) (V+η), ‖mollifiedError X (((1+2*η : ℝ) : ℂ)+(t : ℂ)*I)‖^2) ≤
        min M ((V-U+2*η)*D^2) := by
    have hi := integrableOn_mollifiedError_vertical X (1+2*η) (B := V+η)
      (by linarith : 0 < U-η)
    apply le_min
    · have hs : Icc (U-η) (V+η) ⊆ Icc (U-(δ+5*η)) (V+(δ+5*η)) := by
        apply Icc_subset_Icc <;> linarith
      have hi' := integrableOn_mollifiedError_vertical X (1+2*η) (B := V+(δ+5*η))
        (sub_pos.mpr hU)
      exact (setIntegral_mono_set hi' (Filter.Eventually.of_forall fun _ => sq_nonneg _)
        hs.eventuallySubset).trans (hM _ ⟨by linarith, by linarith⟩)
    · calc
        _ ≤ ∫ _ in Icc (U-η) (V+η), D^2 :=
          setIntegral_mono_on hi (integrable_const _) measurableSet_Icc fun t _ =>
            pow_le_pow_left₀ (norm_nonneg _) (hErr t) 2
        _ = _ := by rw [integral_const_Icc_real (show U-η ≤ V+η by linarith)]; ring
  refine zeroDensityCount_le_mollified_vertical_center_moment X (b := 1+2*η)
    (by linarith) hUV hη (by positivity) (by linarith) ?_ (by linarith)
    (fun t _ => (hErr t).trans hD) hC ?_
  · nlinarith [sq_nonneg η, mul_pos hδ hη]
  · simpa only [show 1+2*η-(δ+4*η) = 1-δ-2*η by ring,
      show 1+2*η+(δ+4*η) = 1+δ+6*η by ring,
      show U-η-(δ+4*η) = U-(δ+5*η) by ring,
      show V+η+(δ+4*η) = V+(δ+5*η) by ring] using hM

/-- The center offset can be chosen independently of the gap from one.
The explicit center bound uses the squared mollifier tail. -/
theorem zeroDensityCount_le_mollified_vertical_near_one_offset (X : ℕ) (hX : 1 ≤ X)
    {δ η U V M : ℝ} (hδ : 0 < δ) (hη : 0 < η)
    (hU : δ+5*η < U) (hUV : U ≤ V) (hscale : 2*(2+η⁻¹)^2 ≤ (X : ℝ)^η)
    (hM : ∀ a ∈ Icc (1-δ-2*η) (1+δ+6*η),
      (∫ t in Icc (U-(δ+5*η)) (V+(δ+5*η)),
        ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤ M) :
    (zeroDensityCount (1-δ) V : ℝ) ≤ (zeroDensityCount (1-δ) U : ℝ) +
      (M + (4/3 : ℝ)*(V-U+2*η)*((X : ℝ)^(-η)*(2+η⁻¹)^2)^2) /
        (2*η*Real.log ((δ+4*η)/(δ+3*η))) := by
  apply (zeroDensityCount_le_mollified_vertical_min_center_offset X hX hδ hη hU hUV hscale hM).trans
  have hlog : 0 < Real.log ((δ+4*η)/(δ+3*η)) := by
    apply Real.log_pos ((one_lt_div (by positivity)).mpr (by linarith))
  have hden : 0 ≤ 2*η*Real.log ((δ+4*η)/(δ+3*η)) := by positivity
  apply add_le_add_right
  apply div_le_div_of_nonneg_right _ hden
  apply add_le_add_right
  rw [mul_assoc]
  exact mul_le_mul_of_nonneg_left (min_le_right _ _) (by norm_num)

/-- The near-one density increment, with its full logarithmic radius factor
and an explicit decaying contribution from the center of each disk. -/
theorem zeroDensityCount_le_mollified_vertical_near_one (X : ℕ) (hX : 1 ≤ X)
    {δ U V M : ℝ} (hδ : 0 < δ) (hU : 6*δ < U) (hUV : U ≤ V)
    (hscale : 2*(2+δ⁻¹)^2 ≤ (X : ℝ)^δ)
    (hM : ∀ a ∈ Icc (1-3*δ) (1+7*δ),
      (∫ t in Icc (U-6*δ) (V+6*δ), ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤ M) :
    (zeroDensityCount (1-δ) V : ℝ) ≤ (zeroDensityCount (1-δ) U : ℝ) +
      (M + (4/3 : ℝ)*(V-U+2*δ)*((X : ℝ)^(-δ)*(2+δ⁻¹)^2)^2) /
        (2*δ*Real.log (5/4)) := by
  have h := zeroDensityCount_le_mollified_vertical_near_one_offset X hX hδ hδ
    (by linarith : δ+5*δ < U) hUV hscale (M := M)
  have hratio : (δ+4*δ)/(δ+3*δ) = 5/4 := by field_simp [hδ.ne']; ring
  rw [hratio] at h
  apply h
  simpa only [show 1-δ-2*δ = 1-3*δ by ring, show 1+δ+6*δ = 1+7*δ by ring,
    show δ+5*δ = 6*δ by ring] using hM

end Legendre.Zeta
