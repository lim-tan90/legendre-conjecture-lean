/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.CriticalConvolution
public import Legendre.Layer4.MollifiedZetaSmoothed
public import Legendre.Layer4.MollifiedZetaVertical

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory Set

private theorem stronglyMeasurable_criticalIntegral_vertical (X : ℕ) {a Y : ℝ}
    (ha : 1/2 < a) (ha₁ : a ≤ 7/6) (hY : 0 < Y) :
    StronglyMeasurable (fun t : ℝ => detectorCriticalIntegral X ((a : ℂ)+(t : ℂ)*I) Y) := by
  let d := 1/2-a
  let l := fun u : ℝ => (d : ℂ)+(u : ℂ)*I
  have hl : Continuous l := by dsimp [l]; fun_prop
  have hlr (u : ℝ) : (l u).re = d := by simp [l]
  have hK : Continuous (fun u : ℝ => detectorKernel (l u)) := by
    unfold detectorKernel
    apply continuous_const.div
      ((hl.mul (hl.add continuous_const)).mul (hl.add continuous_const))
    intro u
    apply mul_ne_zero
    · apply mul_ne_zero
      · intro h
        have h0 := hlr u
        rw [h, zero_re] at h0
        dsimp [d] at h0
        linarith
      · intro h
        have h' := congrArg Complex.re h
        change (l u+1).re = (0 : ℂ).re at h'
        rw [add_re, hlr, one_re, zero_re] at h'
        dsimp [d] at h'
        linarith
    · intro h
      have h' := congrArg Complex.re h
      change (l u+2).re = (0 : ℂ).re at h'
      rw [add_re, hlr, re_ofNat, zero_re] at h'
      dsimp [d] at h'
      linarith
  have hYc : Continuous (fun u : ℝ => (Y : ℂ)^(l u)) :=
    (differentiable_id.const_cpow (.inl (by exact_mod_cast hY.ne'))).continuous.comp hl
  let F := fun p : ℝ × ℝ => (criticalProduct X 0 (p.1+p.2)*(Y : ℂ)^l p.2)*detectorKernel (l p.2)
  have hF : Continuous F :=
    (((criticalProduct_continuous X 0).comp (continuous_fst.add continuous_snd)).mul
      (hYc.comp continuous_snd)).mul (hK.comp continuous_snd)
  have he (t u : ℝ) :
      detectorIntegrand X ((a : ℂ)+(t : ℂ)*I) Y
        (((1/2-(((a : ℂ)+(t : ℂ)*I).re) : ℝ) : ℂ)+(u : ℂ)*I) = F (t,u) := by
    have hsum : (a : ℂ)+(t : ℂ)*I+l u = (1/2 : ℂ)+((t+u : ℝ) : ℂ)*I := by
      apply Complex.ext <;> simp [l,d]
    simp only [detectorIntegrand, add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im, mul_zero,
      zero_mul, sub_self, add_zero, F, criticalProduct, zero_add, l] at hsum ⊢
    rw [hsum]
  unfold detectorCriticalIntegral
  simp_rw [he]
  exact hF.stronglyMeasurable.integral_prod_right'.const_mul _

/-- The shifted critical-line integral has a height second moment with
the explicit line-shift power and the retained logarithmic scales. -/
theorem detectorCriticalIntegral_second_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 2 ≤ T →
      ∀ α a Y : ℝ, 1/2 < α → α ≤ a → a ≤ 7/6 → 1 ≤ Y →
      let L := 1+Real.log (X*X : ℕ)
      let g := fun t : ℝ => ‖detectorCriticalIntegral X ((a : ℂ)+(t : ℂ)*I) Y‖^2
      IntegrableOn g (Icc (-T) T) ∧
      (∫ t in Icc (-T) T, g t) ≤
        C*(Y^(1/2-α)/(α-1/2))^2*Real.sqrt (T*(Real.log T)^4*(T*L^4+(X*X : ℕ)*L^3)) := by
  obtain ⟨C,hC,hb⟩ := Moment.criticalMass_second_moment
  refine ⟨256*C,by positivity,?_⟩
  intro X hX T hT α a Y hα hαa ha hY
  dsimp only
  let K := 16*Y^(1/2-α)/(α-1/2)
  let g := fun t : ℝ => ‖detectorCriticalIntegral X ((a : ℂ)+(t : ℂ)*I) Y‖^2
  have hpoint (t : ℝ) : g t ≤ K^2*criticalMass X t^2 := by
    have hp := detectorCriticalIntegral_uniform_bound_wide X ((a : ℂ)+(t : ℂ)*I) hα
      (by simpa using hαa) (by simpa using ha) hY
    have hm : ((a : ℂ)+(t : ℂ)*I).im = t := by simp
    rw [hm] at hp
    simpa only [g, K, mul_pow] using pow_le_pow_left₀ (norm_nonneg _) hp 2
  obtain ⟨hi,hb⟩ := hb X hX T hT
  have hG : IntegrableOn g (Icc (-T) T) := by
    have hmeas := stronglyMeasurable_criticalIntegral_vertical X (Y := Y)
      (hα.trans_le hαa) ha (by linarith)
    apply (hi.const_mul (K^2)).mono' (hmeas.aestronglyMeasurable.norm.pow 2)
    filter_upwards with t
    change ‖g t‖ ≤ K^2*criticalMass X t^2
    rw [Real.norm_of_nonneg (sq_nonneg _)]
    exact hpoint t
  refine ⟨hG,?_⟩
  have h := integral_mono hG (hi.const_mul (K^2)) hpoint
  rw [integral_const_mul] at h
  exact h.trans ((mul_le_mul_of_nonneg_left hb (sq_nonneg K)).trans_eq (by dsimp [K]; ring))

private theorem detectorWeight_head_error_le {Y : ℝ} (hY : 1 ≤ Y) :
    ‖detectorWeight (1/Y)-(1/2 : ℂ)‖ ≤ 1/Y := by
  have hYp : 0 < Y := by linarith
  have h : 1/Y ≤ 1 := (div_le_one hYp).2 hY
  have hh : 0 ≤ (1 : ℝ)/Y := by positivity
  have hsq := pow_le_pow_left₀ (by linarith : 0 ≤ 1-1/Y) (by linarith : 1-1/Y ≤ 1) 2
  have hc : (1/2 : ℂ) = ((1/2 : ℝ) : ℂ) := by norm_num
  rw [detectorWeight_eq _ h, hc, ← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs]
  apply abs_le.mpr
  constructor <;> nlinarith

/-- Arithmetic and critical-line terms in the smoothed vertical second moment. -/
noncomputable def smoothedMollifiedMomentBound (X : ℕ) (T α Y : ℝ) : ℝ :=
  let L := 1+Real.log (X*X : ℕ)
  (∑ n ∈ Finset.Ioc X ⌊Y⌋₊, (T+(n : ℝ))*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α)) +
    (Y^(1/2-α)/(α-1/2))^2*Real.sqrt (T*(Real.log T)^4*(T*L^4+(X*X : ℕ)*L^3)) +
    1/T + T/Y^2

/-- A high-height shell has a second moment for the genuine mollified
error. The two residue corrections contribute (T^{-1}) and (T/Y^2). -/
theorem smoothed_mollifiedError_shell_second_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 8 ≤ T → (X : ℝ) ≤ 2*T →
      ∀ α a Y : ℝ, 1/2 < α → α ≤ a → a ≤ 7/6 → 1 ≤ Y → Y ≤ (T/2)^2 →
      (∫ t in Icc (T/2) T, ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
        C*smoothedMollifiedMomentBound X T α Y := by
  obtain ⟨P,hP,hPb⟩ := integral_detectorTail_norm_sq_le_weighted
  obtain ⟨Q,hQ,hQb⟩ := detectorCriticalIntegral_second_moment
  let C := 1024*(P+Q+1)
  have hC : 0 < C := by dsimp [C]; positivity
  refine ⟨C,hC,?_⟩
  intro X hX T hT hXT α a Y hα hαa ha hY hYt
  let J := Icc (T/2) T
  let s := fun t : ℝ => (a : ℂ)+(t : ℂ)*I
  let e := fun t => ‖mollifiedError X (s t)‖^2
  let p := fun t => ‖detectorTail X (s t) Y‖^2
  let q := fun t => ‖detectorCriticalIntegral X (s t) Y‖^2
  let B := (8/T)^2+(1/Y)^2
  have hTp : 0 < T := by linarith
  have hYp : 0 < Y := by linarith
  have hhalf : T/2 ≤ T := by linarith
  have hsre (t : ℝ) : (s t).re = a := by simp [s]
  have hsim (t : ℝ) : (s t).im = t := by simp [s]
  have hj : J ⊆ Icc (-T) T := Icc_subset_Icc (by linarith) le_rfl
  have he : IntegrableOn e J := Zeta.integrableOn_mollifiedError_vertical X a (by linarith)
  have hp : IntegrableOn p (Icc (-T) T) := by
    have h (t : ℝ) : detectorTail X (s t) Y =
        Moment.subsetPolynomial (Finset.Icc 1 ⌊Y⌋₊)
          (verticalCoefficients (polynomialCoefficient X Y) a) t := by
      rw [detectorTail_polynomial]
      dsimp only [s]
      rw [complexDirichletPolynomial_vertical]
      rfl
    dsimp only [p]
    simp_rw [h]
    exact ((Moment.subsetPolynomial_continuous _ _).norm.pow 2).continuousOn.integrableOn_Icc
  obtain ⟨hq,hqb⟩ := hQb X hX T (by linarith) α a Y hα hαa ha hY
  have hq' : IntegrableOn q (Icc (-T) T) := hq
  have hpJ := hp.mono_set hj
  have hqJ := hq'.mono_set hj
  have hPJ :
      (∫ t in J, p t) ≤
        P*∑ n ∈ Finset.Ioc X ⌊Y⌋₊, (T+(n : ℝ))*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α) := by
    have hint := setIntegral_mono_set hp (Filter.Eventually.of_forall (fun _ => sq_nonneg _))
      hj.eventuallySubset
    apply hint.trans
    have hb := hPb X Y hYp a T 0 (by linarith)
    rw [zero_sub, zero_add] at hb
    apply hb.trans
    apply mul_le_mul_of_nonneg_left _ hP.le
    apply Finset.sum_le_sum
    intro n hn
    have hn₁ : (1 : ℝ) ≤ n := by exact_mod_cast (show 1 ≤ n from by
      have := (Finset.mem_Ioc.mp hn).1
      omega)
    exact mul_le_mul_of_nonneg_left
      (Real.rpow_le_rpow_of_exponent_le hn₁ (by linarith)) (by positivity)
  have hQJ : (∫ t in J, q t) ≤ Q*(Y^(1/2-α)/(α-1/2))^2*
        Real.sqrt (T*(Real.log T)^4*
          (T*(1+Real.log (X*X : ℕ))^4+(X*X : ℕ)*(1+Real.log (X*X : ℕ))^3)) :=
    (setIntegral_mono_set hq' (Filter.Eventually.of_forall (fun _ => sq_nonneg _))
      hj.eventuallySubset).trans hqb
  have hpt (t : ℝ) (ht : t ∈ J) : e t ≤ 16*(p t+q t+B) := by
    have hs : s t ≠ 1 := by
      intro h
      have ht' := congrArg Complex.im h
      rw [hsim, one_im] at ht'
      linarith [ht.1]
    have hE := mollifiedError_eq_smoothed_terms_wide X hX hs
      (by rw [hsre]; exact hα.trans_le hαa) (by rw [hsre]; exact ha) hY
    have hPole : ‖detectorPrincipalPole X (s t) Y‖ ≤ 8/T := by
      have ht₀ : 0 ≤ t := by linarith [ht.1]
      have hpole := detectorPrincipalPole_high_bound X (s t) (by rw [hsre]; linarith)
        (T := T/2) (by positivity) (by rw [hsim, abs_of_nonneg ht₀]; exact ht.1)
        (by linarith) hY hYt
      exact hpole.trans_eq (by ring)
    let x := ‖detectorTail X (s t) Y‖
    let y := ‖detectorCriticalIntegral X (s t) Y‖
    let z := ‖detectorPrincipalPole X (s t) Y‖
    let w := ‖detectorWeight (1/Y)-(1/2 : ℂ)‖
    have hnorm : ‖mollifiedError X (s t)‖ ≤ 2*(x+y+z+w) := by
      rw [hE, norm_mul]
      have h₂ : ‖(2 : ℂ)‖ = 2 := by norm_num
      rw [h₂]
      exact mul_le_mul_of_nonneg_left
        ((norm_add_le _ _).trans
          (add_le_add_left ((norm_sub_le _ _).trans (add_le_add_left (norm_sub_le _ _) _)) _))
        (by norm_num)
    have hsq := pow_le_pow_left₀ (norm_nonneg _) hnorm 2
    have hz := pow_le_pow_left₀ (norm_nonneg _) hPole 2
    have hw := pow_le_pow_left₀ (norm_nonneg _) (detectorWeight_head_error_le hY) 2
    change _ ≤ 16*(x^2+y^2+B)
    change z^2 ≤ _ at hz
    change w^2 ≤ _ at hw
    change ‖mollifiedError X (s t)‖^2 ≤ _
    dsimp only [B]
    nlinarith [sq_nonneg (x-y),sq_nonneg (x-z),sq_nonneg (x-w),
      sq_nonneg (y-z),sq_nonneg (y-w),sq_nonneg (z-w)]
  have hc : Integrable (fun _ : ℝ => B) (volume.restrict J) := integrable_const _
  have h := setIntegral_mono_on he (((hpJ.add hqJ).add hc).const_mul 16) measurableSet_Icc hpt
  change (∫ t in J, e t) ≤ ∫ t in J, 16*(p t+q t+B) at h
  rw [integral_const_mul] at h
  change (∫ t in J, e t) ≤ 16*(∫ t in J, (p+q) t+B) at h
  rw [integral_add (hpJ.add hqJ) hc] at h
  change (∫ t in J, e t) ≤ 16*((∫ t in J, p t+q t)+(∫ _ in J, B)) at h
  rw [integral_add hpJ hqJ, setIntegral_const, measureReal_def, Real.volume_Icc, ENNReal.toReal_ofReal (sub_nonneg.mpr hhalf),
    smul_eq_mul] at h
  let A := ∑ n ∈ Finset.Ioc X ⌊Y⌋₊, (T+(n : ℝ))*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α)
  let R := (Y^(1/2-α)/(α-1/2))^2*Real.sqrt (T*(Real.log T)^4*
    (T*(1+Real.log (X*X : ℕ))^4+(X*X : ℕ)*(1+Real.log (X*X : ℕ))^3))
  have hA : 0 ≤ A := Finset.sum_nonneg (fun _ _ => by positivity)
  have hR : 0 ≤ R := by dsimp [R]; positivity
  have hBJ : (T-T/2)*B ≤ 64*(1/T)+T/Y^2 := by
    have hh : (T-T/2)*B = 32/T+(T/2)/Y^2 := by
      dsimp [B]
      field_simp
      ring
    rw [hh]
    have hu : (T/2)/Y^2 ≤ T/Y^2 := div_le_div_of_nonneg_right (by linarith) (by positivity)
    apply add_le_add _ hu
    rw [← mul_one_div]
    exact mul_le_mul_of_nonneg_right (by norm_num) (by positivity)
  change (∫ t in J, e t) ≤ C*(A+R+1/T+T/Y^2)
  have h1 : (∫ t in J, e t) ≤ 16*(P*A+Q*R+64*(1/T)+T/Y^2) := by
    have hcomb : (∫ t in J, p t)+(∫ t in J, q t)+(T-T/2)*B ≤
        (P*A+Q*R)+(64*(1/T)+T/Y^2) :=
      add_le_add (add_le_add hPJ (by simpa only [R, ← mul_assoc] using hQJ)) hBJ
    exact (h.trans (mul_le_mul_of_nonneg_left hcomb (by norm_num))).trans_eq (by ring)
  exact h1.trans (by
    dsimp only [C]
    nlinarith [mul_nonneg hP.le hA,mul_nonneg hQ.le hR,
      mul_nonneg hP.le hR,mul_nonneg hQ.le hA,
      mul_nonneg hP.le (by positivity : 0 ≤ 1/T),mul_nonneg hQ.le (by positivity : 0 ≤ 1/T),
      mul_nonneg hP.le (by positivity : 0 ≤ T/Y^2),mul_nonneg hQ.le (by positivity : 0 ≤ T/Y^2),
      show 0 ≤ T/Y^2 by positivity])

end Legendre.Density.Detector.Smooth
