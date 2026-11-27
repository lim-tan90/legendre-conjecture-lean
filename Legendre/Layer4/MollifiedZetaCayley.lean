/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.CayleyDisk
public import Legendre.Layer4.MollifiedZetaVertical

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Metric Set
open Density.Detector

/-- The log radius ratio of the Cayley disks gives a linear gap factor. -/
theorem log_cayley_radius_ratio_ge {ε : ℝ} (hε : 0 < ε) (hε' : ε ≤ 1) :
    ε/8 ≤ Real.log ((1-ε/8)/(1-ε/4)) := by
  let r := 1-ε/4
  let R := 1-ε/8
  have hr : 0 < r := by dsimp [r]; linarith
  have hR : 0 < R := by dsimp [R]; linarith
  have hR₁ : R ≤ 1 := by dsimp [R]; linarith
  have hgap : R-r = ε/8 := by dsimp [R,r]; ring
  have hlog := Real.log_le_sub_one_of_pos (div_pos hr hR)
  rw [Real.log_div hr.ne' hR.ne'] at hlog
  change ε/8 ≤ Real.log (R/r)
  rw [Real.log_div hR.ne' hr.ne']
  have hsmall : ε/8 ≤ (R-r)/R := by
    rw [hgap]
    exact (le_div_iff₀ hR).2 (mul_le_of_le_one_right (by positivity) hR₁)
  rw [sub_div, div_self hR.ne'] at hsmall
  linarith

/-- A Cayley disk counts analytic zeta multiplicities close to a center height.
Its physical center stays at real part four as the left boundary approaches one. -/
theorem sum_zeta_multiplicity_le_cayley_circle (X : ℕ) (hX : 1 ≤ X)
    {a ε t : ℝ} (ha : 3/4 ≤ a) (ha₁ : a ≤ 1) (hε : 0 < ε) (hε' : ε ≤ 1)
    (ht : 64/ε < t) (S : Finset ℂ)
    (hS : ∀ z ∈ S, z.re ∈ Icc (a+ε) 1 ∧ |z.im-t| ≤ 1) :
    (ε/8)*(∑ z ∈ S, (zeroMultiplicity z : ℝ)) ≤
      Real.circleAverage (fun w => ‖mollifiedError X (halfPlaneDiskMap a (4-a) w+(t : ℂ)*I)‖^2)
        0 (1-ε/8) + (4/3 : ℝ)*‖mollifiedError X ((4 : ℂ)+(t : ℂ)*I)‖^2 := by
  classical
  let b := 4-a
  let Φ := fun w => halfPlaneDiskMap a b w+(t : ℂ)*I
  let Ψ := fun z => halfPlaneDiskInverse a b (z-(t : ℂ)*I)
  let E := mollifiedError X ∘ Φ
  let r := 1-ε/4
  let R := 1-ε/8
  have hb : 0 < b := by dsimp [b]; linarith
  have hr : 0 < r := by dsimp [r]; linarith
  have hrR : r < R := by dsimp [r,R]; linarith
  have hR : R < 1 := by dsimp [R]; linarith
  have hcenter : Φ 0 = (4 : ℂ)+(t : ℂ)*I := by
    dsimp only [Φ]
    rw [halfPlaneDiskMap_zero, show a+b = 4 from by dsimp [b]; ring]
    norm_num
  have hErr : ‖E 0‖ ≤ 1/2 := by
    change ‖mollifiedError X (Φ 0)‖ ≤ 1/2
    rw [hcenter]
    exact norm_mollifiedError_le_re_four X hX (by simp)
  have hnorm {w : ℂ} (hw : w ∈ closedBall (0 : ℂ) R) : ‖w‖ ≤ R := by
    simpa only [mem_closedBall, dist_zero_right] using hw
  have hw1 {w : ℂ} (hw : w ∈ closedBall (0 : ℂ) R) : w ≠ 1 := by
    have h := (hnorm hw).trans_lt hR
    intro e; simp [e] at h
  have hA {w : ℂ} (hw : w ∈ closedBall (0 : ℂ) R) : AnalyticAt ℂ Φ w :=
    (halfPlaneDiskMap_analyticAt a b (hw1 hw)).add analyticAt_const
  have hP {w : ℂ} (hw : w ∈ closedBall (0 : ℂ) R) : Φ w ≠ 1 := by
    have hpad := norm_halfPlaneDiskMap_sub_center_le (a := a) hb hR (hnorm hw)
    have hheight := (Complex.abs_im_le_norm (halfPlaneDiskMap a b w-((a+b : ℝ) : ℂ))).trans hpad
    simp only [sub_im, ofReal_im, sub_zero] at hheight
    have hpad' : 2*b/(1-R) ≤ 64/ε := by
      have he : 2*b/(1-R) = 16*b/ε := by
        dsimp [R]
        field_simp [hε.ne']
        ring
      rw [he]
      exact div_le_div_of_nonneg_right (by dsimp [b]; linarith) hε.le
    have hpos : 0 < (Φ w).im := by
      change 0 < (halfPlaneDiskMap a b w+(t : ℂ)*I).im
      simp only [add_im, mul_im, ofReal_re, ofReal_im, I_re, I_im, mul_one, mul_zero, add_zero]
      linarith [(abs_le.mp (hheight.trans hpad')).1]
    intro he
    rw [he, one_im] at hpos
    exact (lt_irrefl _ hpos)
  have hEA : AnalyticOnNhd ℂ E (closedBall 0 R) := fun w hw =>
    (mollifiedError_analyticAt X (hP hw)).comp (hA hw)
  have hball (z : ℂ) (hz : z ∈ S) : Ψ z ∈ closedBall 0 r := by
    rw [mem_closedBall, dist_zero_right]
    apply norm_halfPlaneDiskInverse_le ha hε
    · simpa [sub_re] using (hS z hz).1.1
    · simpa [sub_re] using (hS z hz).1.2
    · simpa [sub_im] using (hS z hz).2
  have hΦΨ (z : ℂ) (hz : z ∈ S) : Φ (Ψ z) = z := by
    have hne : z-(t : ℂ)*I ≠ ((a-b : ℝ) : ℂ) := by
      intro he
      have he' := congrArg Complex.re he
      simp [sub_re] at he'
      linarith [(hS z hz).1.1]
    dsimp only [Φ, Ψ]
    rw [halfPlaneDiskMap_of_inverse hb.ne' hne, sub_add_cancel]
  let S' := S.image Ψ
  have hS' (w : ℂ) (hw : w ∈ S') : w ∈ closedBall 0 r := by
    obtain ⟨z,hz,rfl⟩ := Finset.mem_image.mp hw
    exact hball z hz
  have hmult (w : ℂ) (hw : w ∈ S') :
      (zeroMultiplicity (Φ w) : ℕ∞) ≤ analyticOrderAt (fun w => 1-(E w)^2) w := by
    have hw' := closedBall_subset_closedBall hrR.le (hS' w hw)
    have hderiv : deriv Φ w ≠ 0 := by
      have hd := (halfPlaneDiskMap_hasDerivAt a b (hw1 hw')).add_const ((t : ℂ)*I)
      exact hd.deriv.trans (halfPlaneDiskMap_hasDerivAt a b (hw1 hw')).deriv.symm ▸
        halfPlaneDiskMap_deriv_ne_zero a hb.ne' (hw1 hw')
    change (zeroMultiplicity (Φ w) : ℕ∞) ≤ analyticOrderAt (squaredErrorDetector X ∘ Φ) w
    rw [analyticOrderAt_comp_of_deriv_ne_zero (hA hw') hderiv, zeroMultiplicity_cast (hP hw')]
    exact analyticOrderAt_squaredErrorDetector_ge_zeta X (hP hw')
  have hsum : (∑ w ∈ S', (zeroMultiplicity (Φ w) : ℝ)) = ∑ z ∈ S, (zeroMultiplicity z : ℝ) := by
    dsimp only [S']
    rw [Finset.sum_image (fun z hz z' hz' h => by simpa only [hΦΨ z hz, hΦΨ z' hz'] using congrArg Φ h)]
    exact Finset.sum_congr rfl (fun z hz => by rw [hΦΨ z hz])
  have hj := sum_weights_le_squared_error_circle E 0 hErr hr hrR hEA S'
    (fun w => zeroMultiplicity (Φ w)) hS' hmult
  rw [hsum] at hj
  have hlog : 0 < Real.log (R/r) := Real.log_pos ((one_lt_div hr).2 hrR)
  have hh := (le_div_iff₀ hlog).1 hj
  have he : ε/8 ≤ Real.log (R/r) := log_cayley_radius_ratio_ge hε hε'
  calc
    _ ≤ Real.log (R/r)*(∑ z ∈ S, (zeroMultiplicity z : ℝ)) :=
      mul_le_mul_of_nonneg_right he (Finset.sum_nonneg fun _ _ => Nat.cast_nonneg _)
    _ ≤ _ := by
      rw [mul_comm]
      simpa only [E, Function.comp_apply, hcenter] using hh

/-- Vertical moments on the Cayley image bound a density increment with
a single inverse power of the distance from the target line. -/
theorem zeroDensityCount_le_cayley_vertical (X : ℕ) (hX : 1 ≤ X)
    {a ε U V M : ℝ} (ha : 3/4 ≤ a) (ha₁ : a ≤ 1) (hε : 0 < ε) (hε₁ : ε ≤ 1)
    (hU : 64/ε < U-1) (hUV : U ≤ V)
    (hM : ∀ b ∈ Icc a (4+64/ε),
      (∫ t in Icc (U-1-64/ε) (V+1+64/ε), ‖mollifiedError X ((b : ℂ)+(t : ℂ)*I)‖^2) ≤ M) :
    (zeroDensityCount (a+ε) V : ℝ) ≤ (zeroDensityCount (a+ε) U : ℝ) +
      (M+(4/3 : ℝ)*(V-U+2)*(9/(X : ℝ))^2)/(ε/4) := by
  classical
  let H := 64/ε
  let R := 1-ε/8
  let b := 4-a
  let A := U-1
  let B := V+1
  let D := 9/(X : ℝ)
  let q := fun θ : ℝ => halfPlaneDiskMap a b (circleMap 0 R θ)
  let avg := fun t : ℝ => Real.circleAverage
    (fun w => ‖mollifiedError X (halfPlaneDiskMap a b w+(t : ℂ)*I)‖^2) 0 R
  let center := fun t : ℝ => ‖mollifiedError X ((4 : ℂ)+(t : ℂ)*I)‖^2
  have hH : 0 < H := by dsimp [H]; positivity
  have hA : 0 < A := hH.trans hU
  have hAB : A ≤ B := by dsimp [A,B]; linarith
  have hb : 0 < b := by dsimp [b]; linarith
  have hR : 0 ≤ R := by dsimp [R]; linarith
  have hR₁ : R < 1 := by dsimp [R]; linarith
  have hcircle (θ : ℝ) : ‖circleMap (0 : ℂ) R θ‖ = R := by
    have hh := circleMap_mem_sphere' (0 : ℂ) R θ
    simpa only [mem_sphere, dist_zero_right, abs_of_nonneg hR] using hh
  have hq : Continuous q := by
    have hc : Continuous (circleMap (0 : ℂ) R) := by fun_prop [circleMap]
    apply continuous_iff_continuousAt.mpr
    intro θ
    have hn : circleMap (0 : ℂ) R θ ≠ 1 := by
      intro he
      have hh := hcircle θ
      rw [he, norm_one] at hh
      linarith
    exact (halfPlaneDiskMap_analyticAt a b hn).continuousAt.comp hc.continuousAt
  have hpad (θ : ℝ) : ‖q θ-(4 : ℂ)‖ ≤ H := by
    have hh := norm_halfPlaneDiskMap_sub_center_le (a := a) hb hR₁ (hcircle θ).le
    rw [show a+b = 4 from by dsimp [b]; ring] at hh
    have he : 2*b/(1-R) = 16*b/ε := by
      dsimp [R]
      field_simp [hε.ne']
      ring
    rw [he] at hh
    apply (by simpa only [q, ofReal_ofNat] using hh : ‖q θ-(4 : ℂ)‖ ≤ 16*b/ε).trans
    exact div_le_div_of_nonneg_right (by dsimp [b]; linarith) hε.le
  have haq (θ : ℝ) : (q θ).re ∈ Icc a (4+H) := by
    have hh := halfPlaneDiskMap_re_gt (a := a) hb ((hcircle θ).trans_lt hR₁)
    have hn := (Complex.abs_re_le_norm (q θ-(4 : ℂ))).trans (hpad θ)
    simp only [sub_re, re_ofNat] at hn
    exact ⟨hh.le, by linarith [(abs_le.mp hn).2]⟩
  have hdq (θ : ℝ) : (q θ).im ∈ Icc (-H) H := by
    have hh := (Complex.abs_im_le_norm (q θ-(4 : ℂ))).trans (hpad θ)
    change -H ≤ (q θ).im ∧ (q θ).im ≤ H
    simpa only [sub_im, im_ofNat, sub_zero] using abs_le.mp hh
  have haEq (t : ℝ) : avg t =
      (2*Real.pi)⁻¹*(∫ θ in Icc 0 (2*Real.pi), ‖mollifiedError X (q θ+(t : ℂ)*I)‖^2) := by
    dsimp only [avg]
    rw [Real.circleAverage_def, smul_eq_mul, intervalIntegral.integral_of_le (by positivity : 0 ≤ 2*Real.pi),
      ← integral_Icc_eq_integral_Ioc]
  have havg : IntegrableOn avg (Icc A B) ∧ (∫ t in Icc A B, avg t) ≤ M := by
    rw [funext haEq]
    exact integral_mollified_translatedAverage_le_vertical X q hq hU hAB haq hdq hM
  have hci : IntegrableOn center (Icc A B) := integrableOn_mollifiedError_vertical X 4 hA
  have hC : (∫ t in Icc A B, center t) ≤ (V-U+2)*D^2 := by
    calc
      _ ≤ ∫ _ in Icc A B, D^2 := by
        apply setIntegral_mono_on hci (integrable_const _) measurableSet_Icc
        intro t _
        have h := norm_mollifiedError_le_right_half_plane X hX (δ := 1) (by norm_num)
          (s := (4 : ℂ)+(t : ℂ)*I) (by norm_num)
        have hh : ‖mollifiedError X ((4 : ℂ)+(t : ℂ)*I)‖ ≤ D := by
          dsimp [D]
          simpa only [Real.rpow_neg_one, show (2+(1 : ℝ)⁻¹)^2 = 9 by norm_num,
            div_eq_mul_inv, mul_comm] using h
        exact pow_le_pow_left₀ (norm_nonneg _) hh 2
      _ = _ := by
        rw [setIntegral_const, measureReal_def, Real.volume_Icc, ENNReal.toReal_ofReal (sub_nonneg.mpr hAB),
          smul_eq_mul]
        dsimp [A,B]
        ring
  apply zeroDensityCount_le_of_multiplicity_sweep hUV
  intro S hS
  let g := fun t : ℝ => avg t+(4/3 : ℝ)*center t
  have hgi : IntegrableOn g (Icc A B) := havg.1.add (hci.const_mul _)
  have hbound (t : ℝ) (ht : t ∈ Icc A B) :
      (ε/8)*(∑ z ∈ S.filter (fun z => t ∈ Icc (z.im-1) (z.im+1)), (zeroMultiplicity z : ℝ)) ≤
        g t := by
    apply sum_zeta_multiplicity_le_cayley_circle X hX ha ha₁ hε hε₁ (hU.trans_le ht.1)
    intro z hz
    obtain ⟨hzS,hzt⟩ := Finset.mem_filter.mp hz
    exact ⟨(hS z hzS).1, abs_le.mpr ⟨by linarith [hzt.2],by linarith [hzt.1]⟩⟩
  have hsweep := sum_zeta_multiplicity_le_of_height_window_bound (h := 1) (L := ε/8) (by norm_num)
    S (fun z hz => (hS z hz).2) g hgi hbound
  have hden : 0 < ε/4 := by positivity
  apply (le_div_iff₀ hden).2
  have hsum : (∑ z ∈ S, (zeroMultiplicity z : ℝ))*(ε/4) ≤ ∫ t in Icc A B, g t :=
    (by ring : (∑ z ∈ S, (zeroMultiplicity z : ℝ))*(ε/4) =
      (2*1*(ε/8))*(∑ z ∈ S, (zeroMultiplicity z : ℝ))).trans_le hsweep
  apply hsum.trans
  dsimp only [g]
  rw [integral_add havg.1 (hci.const_mul (4/3 : ℝ)), integral_const_mul]
  have hh := add_le_add havg.2 (mul_le_mul_of_nonneg_left hC (by norm_num : (0 : ℝ) ≤ 4/3))
  exact hh.trans_eq (by dsimp [D]; ring)

end Legendre.Zeta
