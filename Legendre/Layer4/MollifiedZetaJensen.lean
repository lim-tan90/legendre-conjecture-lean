/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The squared-error detector and multiplicity argument adapt the corresponding
part of GuthMaynard/ClassicalDensity.lean in smccolm/Lean, commit
4c8fb7f7816508825089230e3730b69165e5e303 (MIT-0), to the local mollifier and
zero multiplicities. Retained license: licenses/smccolm-Lean-MIT-0.txt.
-/
module
public import Legendre.Layer4.DetectorProduct
public import Legendre.ZetaCounting
public import Legendre.Layer4.JensenCircleMean
public import Legendre.Layer4.ZetaSquareSeries
public import Legendre.ZetaGrowth
public import Mathlib.Analysis.SumIntegralComparisons
public import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
public import Mathlib.Analysis.SpecialFunctions.Complex.Analytic

@[expose] public section
namespace Legendre.Density.Detector
open Complex Set MeasureTheory
open scoped ArithmeticFunction.Moebius
open Smooth Zeta

/-- Ingham's error of the finite mollified zeta function from one. -/
noncomputable def mollifiedError (X : ℕ) (s : ℂ) : ℂ :=
  riemannZeta s * finiteSeries (μ : ArithmeticFunction ℂ) X s - 1

/-- The analytic zero detector vanishes at every zeta zero. -/
noncomputable def squaredErrorDetector (X : ℕ) (s : ℂ) : ℂ :=
  1-(mollifiedError X s)^2

theorem finiteSeries_analyticAt (f : ArithmeticFunction ℂ) (N : ℕ) (s : ℂ) :
    AnalyticAt ℂ (finiteSeries f N) s := by
  unfold finiteSeries
  apply Finset.analyticAt_fun_sum
  intro n hn
  have hn₀ : (n : ℂ) ≠ 0 := by
    exact_mod_cast (show n ≠ 0 by have := (Finset.mem_Icc.mp hn).1; omega)
  exact analyticAt_const.mul ((differentiable_id.neg.const_cpow (Or.inl hn₀)).analyticAt s)

theorem mollifiedError_analyticAt (X : ℕ) {s : ℂ} (hs : s ≠ 1) :
    AnalyticAt ℂ (mollifiedError X) s :=
  ((Legendre.Zeta.analytic_off_pole s (by simpa using hs)).mul (finiteSeries_analyticAt _ _ _)).sub
    analyticAt_const

theorem squaredErrorDetector_analyticAt (X : ℕ) {s : ℂ} (hs : s ≠ 1) :
    AnalyticAt ℂ (squaredErrorDetector X) s :=
  analyticAt_const.sub ((mollifiedError_analyticAt X hs).pow 2)

theorem analyticOrderAt_squaredErrorDetector_ge_zeta (X : ℕ) {s : ℂ} (hs : s ≠ 1) :
    analyticOrderAt riemannZeta s ≤ analyticOrderAt (squaredErrorDetector X) s := by
  let M := finiteSeries (μ : ArithmeticFunction ℂ) X
  let G := fun z => 2-riemannZeta z*M z
  have hZ : AnalyticAt ℂ riemannZeta s := Legendre.Zeta.analytic_off_pole s (by simpa using hs)
  have hM : AnalyticAt ℂ M s := finiteSeries_analyticAt _ _ _
  have hG : AnalyticAt ℂ G s := analyticAt_const.sub (hZ.mul hM)
  have he : squaredErrorDetector X = (riemannZeta*M)*G := by
    funext z
    dsimp [squaredErrorDetector,mollifiedError,M,G]
    ring
  rw [he,analyticOrderAt_mul (hZ.mul hM) hG,analyticOrderAt_mul hZ hM]
  exact (le_add_of_nonneg_right zero_le).trans (le_add_of_nonneg_right zero_le)

private theorem log_norm_one_sub_sq_le (z : ℂ) : Real.log ‖1-z^2‖ ≤ ‖z‖^2 := by
  have hpow : ‖(z)^2‖ = ‖z‖^2 := by
    rw [pow_two,norm_mul,pow_two]
  have hb : ‖(1-z^2)‖ ≤ 1+‖z‖^2 := by
    have h := norm_sub_le (1 : ℂ) ((z)^2)
    rw [norm_one,hpow] at h
    exact h
  rcases eq_zero_or_norm_pos ((1-z^2)) with h|h
  · simp only [h,norm_zero,Real.log_zero]
    positivity
  · exact (Real.log_le_log h hb).trans (by
      have hh := Real.log_le_sub_one_of_pos (show 0 < 1+‖z‖^2 by positivity)
      linarith)

theorem log_norm_squaredErrorDetector_le (X : ℕ) (s : ℂ) :
    Real.log ‖squaredErrorDetector X s‖ ≤ ‖mollifiedError X s‖^2 :=
  log_norm_one_sub_sq_le (mollifiedError X s)

theorem mollifiedError_eq_tsum_tail (X : ℕ) (hX : 1 ≤ X) {s : ℂ} (hs : 1 < s.re) :
    mollifiedError X s = ∑' n : ℕ, LSeries.term (detectorCoefficient X) s (n+2) := by
  let f := LSeries.term (detectorCoefficient X) s
  have hf : Summable f := detectorCoefficient_summable X hs
  have he := hf.sum_add_tsum_nat_add 2
  have h1 : f 1 = 1 := by
    dsimp [f]
    rw [LSeries.term_of_ne_zero (by norm_num : (1 : ℕ) ≠ 0),detectorCoefficient_one hX]
    simp
  have h0 : f 0 = 0 := by simp [f]
  rw [Finset.sum_range_succ,Finset.sum_range_one,h0,h1,zero_add] at he
  rw [mollifiedError,← mollifier_zeta_product X hs,LSeries,← he]
  ring

theorem norm_mollifiedError_le_re_four (X : ℕ) (hX : 1 ≤ X) {s : ℂ} (hs : 4 ≤ s.re) :
    ‖mollifiedError X s‖ ≤ 1/2 := by
  let f := fun x : ℝ => x^(-3 : ℝ)
  have hanti : AntitoneOn f (Ici 1) := by
    intro a ha b _hb hab
    exact Real.rpow_le_rpow_of_nonpos (by linarith [mem_Ici.mp ha]) hab (by norm_num)
  have hi : IntegrableOn f (Ioi 1) :=
    integrableOn_Ioi_rpow_of_lt (by norm_num) (by norm_num)
  have hf0 : ∀ x ∈ Ioi (1 : ℝ), 0 ≤ f x := fun x hx =>
    Real.rpow_nonneg (by linarith [mem_Ioi.mp hx]) _
  have hanti' : AntitoneOn f (Ici ((1 : ℕ) : ℝ)) := by simpa only [Nat.cast_one] using hanti
  have hi' : IntegrableOn f (Ioi ((1 : ℕ) : ℝ)) := by simpa only [Nat.cast_one] using hi
  have hf' : ∀ x ∈ Ioi ((1 : ℕ) : ℝ), 0 ≤ f x := by simpa only [Nat.cast_one] using hf0
  have hIntegral : (∫ x in Ioi (1 : ℝ), f x) = 1/2 := by
    dsimp only [f]
    rw [integral_Ioi_rpow_of_lt (by norm_num) (by norm_num)]
    norm_num
  have hsum : (∑' n : ℕ, f (↑(n+2 : ℕ))) ≤ 1/2 := by
    have h := AntitoneOn.tsum_comp_add_le_integral 1 hanti' hi' hf'
    rw [Nat.cast_one,hIntegral] at h
    exact h
  have hfs : Summable (fun n : ℕ => f (↑(n+2 : ℕ))) := by
    have h := AntitoneOn.summable_of_integrableOn_Ioi hanti' hi' hf'
    exact (summable_nat_add_iff 2).2 h
  rw [mollifiedError_eq_tsum_tail X hX (by linarith)]
  apply (norm_tsum_le_tsum_norm ((summable_nat_add_iff 2).2
    (detectorCoefficient_summable X (by linarith))).norm).trans
  apply (Summable.tsum_le_tsum _ ?_ hfs).trans hsum
  · intro n
    let m := n+2
    have hm : 0 < m := by dsimp [m]; omega
    have hmR : (1 : ℝ) ≤ m := by exact_mod_cast hm
    have hm₀ : (0 : ℝ) < m := by positivity
    change ‖LSeries.term (detectorCoefficient X) s m‖ ≤ (m : ℝ)^(-3 : ℝ)
    rw [LSeries.term_of_ne_zero hm.ne',norm_div,norm_natCast_cpow_of_pos hm]
    have hcard : (m.divisors.card : ℝ) ≤ (m : ℝ) := by exact_mod_cast Nat.card_divisors_le_self m
    have hc := (detectorCoefficient_norm X m).trans hcard
    calc
      _ ≤ (m : ℝ)/(m : ℝ)^s.re := div_le_div_of_nonneg_right hc (by positivity)
      _ ≤ (m : ℝ)/(m : ℝ)^(4 : ℝ) :=
        div_le_div_of_nonneg_left (by positivity) (by positivity)
          (Real.rpow_le_rpow_of_exponent_le hmR hs)
      _ = (m : ℝ)^(1 : ℝ)/(m : ℝ)^(4 : ℝ) := by rw [Real.rpow_one]
      _ = _ := by rw [← Real.rpow_sub hm₀]; norm_num
  · exact ((summable_nat_add_iff 2).2 (detectorCoefficient_summable X (by linarith))).norm

theorem norm_zetaSquare_term_eq_re (a : ℝ) (n : ℕ) :
    ‖LSeries.term zetaSquareCoefficient (a : ℂ) n‖ =
      (LSeries.term zetaSquareCoefficient (a : ℂ) n).re := by
  by_cases hn : n = 0
  · simp [hn]
  have hcp : (n : ℂ)^(a : ℂ) = ((n : ℝ)^a : ℝ) := by
    rw [Complex.ofReal_cpow (by positivity),Complex.ofReal_natCast]
  rw [LSeries.term_of_ne_zero hn,hcp,zetaSquareCoefficient,← Complex.ofReal_natCast,
    ← Complex.ofReal_div, norm_real,Real.norm_eq_abs,ofReal_re]
  exact abs_of_nonneg (by positivity)

theorem norm_mollifiedError_le_right_half_plane (X : ℕ) (hX : 1 ≤ X)
    {s : ℂ} (δ : ℝ) (hδ : 0 < δ) (hs : 1+2*δ ≤ s.re) :
    ‖mollifiedError X s‖ ≤ (X : ℝ)^(-δ)*(2+δ⁻¹)^2 := by
  let a := 1+δ
  let b := fun n => LSeries.term zetaSquareCoefficient (a : ℂ) n
  have ha : 1 < a := by dsimp [a]; linarith
  have hs₁ : 1 < s.re := by linarith
  have hsumm : Summable b := zetaSquareCoefficient_summable (by simpa only [ofReal_re])
  have hsum : (∑' n, ‖b n‖) ≤ (2+δ⁻¹)^2 := by
    simp_rw [show ∀ n, ‖b n‖ = (b n).re from norm_zetaSquare_term_eq_re a, ← Complex.re_tsum hsumm]
    change (LSeries zetaSquareCoefficient (a : ℂ)).re ≤ _
    rw [zeta_square_LSeries (by simpa only [ofReal_re])]
    apply (re_le_norm _).trans
    rw [pow_two,norm_mul,← pow_two]
    apply pow_le_pow_left₀ (norm_nonneg _) _ 2
    have hζ := norm_riemannZeta_le_positive_re (s := (a : ℂ)) (by simpa only [ofReal_re] using zero_lt_one.trans ha)
      (by
        intro h
        have he := congrArg Complex.re h
        simp only [ofReal_re,one_re] at he
        linarith)
    have ha₀ : 0 < a := zero_lt_one.trans ha
    rw [norm_real,Real.norm_eq_abs,abs_of_pos ha₀,ofReal_re,
      show (a : ℂ)-1 = ((a-1 : ℝ) : ℂ) by push_cast; ring, norm_real,Real.norm_eq_abs,
      abs_of_pos (sub_pos.mpr ha), div_self ha₀.ne'] at hζ
    exact hζ.trans_eq (by
      dsimp only [a]
      rw [add_sub_cancel_left]
      field_simp [hδ.ne']
      ring)
  have htailnorm : (∑' n : ℕ, ‖b (n+2)‖) ≤ ∑' n : ℕ, ‖b n‖ := by
    have hh := hsumm.norm.sum_add_tsum_nat_add 2
    rw [← hh]
    exact le_add_of_nonneg_left (Finset.sum_nonneg fun _ _ => norm_nonneg _)
  have hX₀ : (0 : ℝ) < X := by exact_mod_cast hX
  let g := fun n => LSeries.term (detectorCoefficient X) s (n+2)
  have hg : Summable g := (summable_nat_add_iff 2).2 (detectorCoefficient_summable X hs₁)
  have hb : Summable (fun n : ℕ => ‖b (n+2)‖) := (summable_nat_add_iff 2).2 hsumm.norm
  have hp (n : ℕ) : ‖g n‖ ≤ (X : ℝ)^(-δ)*‖b (n+2)‖ := by
    let m := n+2
    have hm : 0 < m := by dsimp [m]; omega
    have hm₁ : (1 : ℝ) ≤ m := by exact_mod_cast hm
    have hm₀ : (0 : ℝ) < m := by positivity
    by_cases hmX : m ≤ X
    · change ‖LSeries.term (detectorCoefficient X) s m‖ ≤ _
      rw [LSeries.term_of_ne_zero hm.ne',detectorCoefficient_small (by dsimp [m]; omega) hmX,
        zero_div,norm_zero]
      positivity
    · have hmX' : (X : ℝ) ≤ m := by exact_mod_cast (le_of_lt (lt_of_not_ge hmX))
      have hphase : (m : ℝ)^(-δ) ≤ (X : ℝ)^(-δ) :=
        Real.rpow_le_rpow_of_nonpos hX₀ hmX' (by linarith)
      have hnorm : ‖g n‖ ≤ (m.divisors.card : ℝ)*(m : ℝ)^(-s.re) := by
        change ‖LSeries.term (detectorCoefficient X) s m‖ ≤ _
        rw [LSeries.term_of_ne_zero hm.ne',norm_div,norm_natCast_cpow_of_pos hm,
          Real.rpow_neg hm₀.le, ← div_eq_mul_inv]
        exact div_le_div_of_nonneg_right (detectorCoefficient_norm X m) (by positivity)
      have hbn : ‖b m‖ = (m.divisors.card : ℝ)*(m : ℝ)^(-a) := by
        dsimp only [b]
        rw [LSeries.term_of_ne_zero hm.ne',norm_div,norm_natCast_cpow_of_pos hm,
          ofReal_re,zetaSquareCoefficient,← ofReal_natCast, norm_real,
          Real.norm_eq_abs,abs_of_nonneg (by positivity), Real.rpow_neg hm₀.le, div_eq_mul_inv]
      calc
        _ ≤ (m.divisors.card : ℝ)*(m : ℝ)^(-s.re) := hnorm
        _ ≤ (m.divisors.card : ℝ)*(m : ℝ)^(-δ-a) :=
          mul_le_mul_of_nonneg_left
            (Real.rpow_le_rpow_of_exponent_le hm₁ (by dsimp [a]; linarith)) (by positivity)
        _ = (m : ℝ)^(-δ)*‖b m‖ := by rw [sub_eq_add_neg,Real.rpow_add hm₀,hbn]; ring
        _ ≤ _ := mul_le_mul_of_nonneg_right hphase (norm_nonneg _)
  rw [mollifiedError_eq_tsum_tail X hX hs₁]
  calc
    _ ≤ ∑' n : ℕ, ‖g n‖ := norm_tsum_le_tsum_norm hg.norm
    _ ≤ ∑' n : ℕ, (X : ℝ)^(-δ)*‖b (n+2)‖ := hg.norm.tsum_le_tsum hp (hb.mul_left _)
    _ = (X : ℝ)^(-δ)*(∑' n : ℕ, ‖b (n+2)‖) := tsum_mul_left
    _ ≤ _ := mul_le_mul_of_nonneg_left (htailnorm.trans hsum) (by positivity)

end Legendre.Density.Detector

namespace Legendre.Zeta
open Complex Metric Set MeromorphicOn Real
open Density.Detector
open scoped BigOperators

/-- Jensen bounds finite weights dominated by the vanishing orders of the
squared-error detector. The error may be composed with a holomorphic map. -/
theorem sum_weights_le_squared_error_circle (E : ℂ → ℂ) (c : ℂ)
    (hErr : ‖E c‖ ≤ 1/2) {r R : ℝ} (hr : 0 < r) (hrR : r < R)
    (hE : AnalyticOnNhd ℂ E (closedBall c R))
    (S : Finset ℂ) (m : ℂ → ℕ) (hS : ∀ z ∈ S, z ∈ closedBall c r)
    (hmult : ∀ z ∈ S, (m z : ℕ∞) ≤ analyticOrderAt (fun w => 1-(E w)^2) z) :
    (∑ z ∈ S, (m z : ℝ)) ≤
      (circleAverage (fun z => ‖E z‖^2) c R + (4/3 : ℝ)*‖E c‖^2) /
        Real.log (R/r) := by
  classical
  let F := fun z => 1-(E z)^2
  have hR : 0 < R := hr.trans hrR
  have hf : AnalyticOnNhd ℂ F (closedBall c R) := fun z hz =>
    analyticAt_const.sub ((hE z hz).pow 2)
  have hsmall := hf.mono (closedBall_subset_closedBall hrR.le)
  let v := ‖E c‖^2
  have hv : 0 ≤ v := sq_nonneg _
  have hv₁ : v ≤ 1/4 := by
    have h := pow_le_pow_left₀ (norm_nonneg _) hErr 2
    norm_num at h
    exact h
  have hFbound : 1-v ≤ ‖F c‖ := by
    have hE2 : ‖(E c)^2‖ = v := by
      dsimp only [v]
      rw [pow_two,norm_mul,pow_two]
    have hh := norm_sub_le (F c) (-(E c)^2)
    have he : F c- (-(E c)^2) = 1 := by dsimp [F]; ring
    rw [he,norm_one,norm_neg,hE2] at hh
    linarith
  have hFc : F c ≠ 0 := norm_pos_iff.mp (by linarith)
  have hF0 : analyticOrderAt F c ≠ ⊤ := by
    rw [(hf c (mem_closedBall_self hR.le)).analyticOrderAt_eq_zero.mpr hFc]
    norm_num
  have hFin (z : ℂ) (hz : z ∈ closedBall c R) : analyticOrderAt F z ≠ ⊤ :=
    hf.analyticOrderAt_ne_top_of_isPreconnected (convex_closedBall c R).isPreconnected
      (mem_closedBall_self hR.le) hz hF0
  let d := divisor F (closedBall c r)
  have hds : d.support.Finite := d.finiteSupport (isCompact_closedBall ..)
  have hnonneg (z : ℂ) : 0 ≤ (d z : ℝ) := by
    have h : (0 : ℤ) ≤ d z := hsmall.divisor_nonneg z
    exact_mod_cast h
  have hdom : (∑ z ∈ S, (m z : ℝ)) ≤ ∑ᶠ z, (d z : ℝ) := by
    rw [finsum_eq_sum_of_support_subset _ (s := hds.toFinset ∪ S) (by
      intro z hz
      apply Finset.mem_union_left
      apply hds.mem_toFinset.mpr
      change ((d z : ℤ) : ℝ) ≠ 0 at hz
      exact_mod_cast hz)]
    apply (Finset.sum_le_sum (s := S) ?_).trans
      (Finset.sum_le_sum_of_subset_of_nonneg Finset.subset_union_right (fun z _ _ => hnonneg z))
    intro z hz
    have hzr := hS z hz
    have hzR := closedBall_subset_closedBall hrR.le hzr
    have hm := hmult z hz
    change (m z : ℕ∞) ≤ analyticOrderAt F z at hm
    rw [← Nat.cast_analyticOrderNatAt (hFin z hzR)] at hm
    have hn : m z ≤ analyticOrderNatAt F z := by exact_mod_cast hm
    change _ ≤ (divisor F (closedBall c r) z : ℝ)
    rw [hsmall.divisor_apply hzr, ← Nat.cast_analyticOrderNatAt (hFin z hzR)]
    simpa only [ENat.map_natCast,WithTop.untop₀_coe,Int.cast_natCast] using
      (Nat.cast_le.mpr hn : (m z : ℝ) ≤ analyticOrderNatAt F z)
  have hJs := sum_divisor_le_circle_log_norm hr hrR hf hFc
  have hSphere (z : ℂ) (hz : z ∈ sphere c |R|) : z ∈ closedBall c R := by
    rw [abs_of_pos hR] at hz
    exact sphere_subset_closedBall hz
  have hlogInt : CircleIntegrable (fun z => Real.log ‖F z‖) c R :=
    (hf.mono hSphere).meromorphicOn.circleIntegrable_log_norm
  have hcont : ContinuousOn (fun z => ‖E z‖^2) (sphere c |R|) := by
    have hcont₀ : ContinuousOn E (sphere c |R|) := fun z hz =>
      (hE z (hSphere z hz)).continuousAt.continuousWithinAt
    exact hcont₀.norm.pow 2
  have hcont' : ContinuousOn (fun z => ‖E z‖^2) (sphere c R) := by
    simpa only [abs_of_pos hR] using hcont
  have hAvg := circleAverage_mono hlogInt (hcont'.circleIntegrable hR.le)
    (fun z _ => log_norm_one_sub_sq_le (E z))
  have hvp : 0 < 1-v := by linarith
  have hlogF : -Real.log ‖F c‖ ≤ (4/3 : ℝ)*v := by
    calc
      _ ≤ -Real.log (1-v) := neg_le_neg (Real.log_le_log hvp hFbound)
      _ ≤ (1-v)⁻¹-1 := by
        simpa only [Real.log_inv] using Real.log_le_sub_one_of_pos (inv_pos.mpr hvp)
      _ = v/(1-v) := by
        field_simp [hvp.ne']
        ring
      _ ≤ v/(3/4) := div_le_div_of_nonneg_left hv (by norm_num) (by linarith)
      _ = _ := by ring
  apply hdom.trans hJs |>.trans
  apply div_le_div_of_nonneg_right _ (Real.log_nonneg ((one_le_div hr).mpr hrR.le))
  linarith

/-- Control the center term by the actual squared mollifier error. -/
theorem sum_zeta_multiplicity_le_mollified_circle_with_center_error (X : ℕ)
    (c : ℂ) (hErr : ‖mollifiedError X c‖ ≤ 1/2) (r R : ℝ) (hr : 0 < r) (hrR : r < R)
    (hPole : (1 : ℂ) ∉ closedBall c R)
    (S : Finset ℂ) (hS : ∀ z ∈ S, z ∈ closedBall c r) :
    (∑ z ∈ S, (zeroMultiplicity z : ℝ)) ≤
      (circleAverage (fun z => ‖mollifiedError X z‖^2) c R + (4/3 : ℝ)*‖mollifiedError X c‖^2) /
        Real.log (R/r) := by
  have hE : AnalyticOnNhd ℂ (mollifiedError X) (closedBall c R) :=
    fun z hz => mollifiedError_analyticAt X (fun he => hPole (he ▸ hz))
  refine sum_weights_le_squared_error_circle (mollifiedError X) c hErr hr hrR hE S zeroMultiplicity hS ?_
  intro z hz
  have hzR := closedBall_subset_closedBall hrR.le (hS z hz)
  have hz₀ : z ≠ 1 := fun he => hPole (he ▸ hzR)
  rw [zeroMultiplicity_cast hz₀]
  exact analyticOrderAt_squaredErrorDetector_ge_zeta X hz₀

/-- The actual mollified second-moment circle average bounds all zeta
multiplicities in a smaller disk, with the Jensen radius factor explicit. -/
theorem sum_zeta_multiplicity_le_mollified_circle_of_center_bound (X : ℕ)
    (c : ℂ) (hErr : ‖mollifiedError X c‖ ≤ 1/2) (r R : ℝ) (hr : 0 < r) (hrR : r < R)
    (hPole : (1 : ℂ) ∉ closedBall c R)
    (S : Finset ℂ) (hS : ∀ z ∈ S, z ∈ closedBall c r) :
    (∑ z ∈ S, (zeroMultiplicity z : ℝ)) ≤
      (circleAverage (fun z => ‖mollifiedError X z‖^2) c R + Real.log 2) /
        Real.log (R/r) := by
  apply (sum_zeta_multiplicity_le_mollified_circle_with_center_error X c hErr
    r R hr hrR hPole S hS).trans
  apply div_le_div_of_nonneg_right _ (Real.log_nonneg ((one_le_div hr).mpr hrR.le))
  have hsq := pow_le_pow_left₀ (norm_nonneg _) hErr 2
  have hlog := Real.le_log_one_add_of_nonneg (show (0 : ℝ) ≤ 1 by norm_num)
  norm_num at hsq hlog
  linarith

/-- At real part at least four the center bound holds for every nonempty
truncation. -/
theorem sum_zeta_multiplicity_le_mollified_circle (X : ℕ) (hX : 1 ≤ X)
    (c : ℂ) (hc : 4 ≤ c.re) (r R : ℝ) (hr : 0 < r) (hrR : r < R)
    (hPole : (1 : ℂ) ∉ closedBall c R)
    (S : Finset ℂ) (hS : ∀ z ∈ S, z ∈ closedBall c r) :
    (∑ z ∈ S, (zeroMultiplicity z : ℝ)) ≤
      (circleAverage (fun z => ‖mollifiedError X z‖^2) c R + Real.log 2) /
        Real.log (R/r) :=
  sum_zeta_multiplicity_le_mollified_circle_of_center_bound X c
    (norm_mollifiedError_le_re_four X hX hc) r R hr hrR hPole S hS

/-- A sufficiently long mollifier gives the center bound strictly to the
right of one, with explicit dependence on the distance. -/
theorem sum_zeta_multiplicity_le_mollified_circle_near_one_center
    (X : ℕ) (hX : 1 ≤ X) (δ : ℝ) (hδ : 0 < δ)
    (c : ℂ) (hc : 1+2*δ ≤ c.re) (hscale : 2*(2+δ⁻¹)^2 ≤ (X : ℝ)^δ)
    (r R : ℝ) (hr : 0 < r) (hrR : r < R) (hPole : (1 : ℂ) ∉ closedBall c R)
    (S : Finset ℂ) (hS : ∀ z ∈ S, z ∈ closedBall c r) :
    (∑ z ∈ S, (zeroMultiplicity z : ℝ)) ≤
      (circleAverage (fun z => ‖mollifiedError X z‖^2) c R + Real.log 2) /
        Real.log (R/r) := by
  have hX₀ : (0 : ℝ) < X := by exact_mod_cast hX
  have hXpow : 0 < (X : ℝ)^δ := Real.rpow_pos_of_pos hX₀ _
  apply sum_zeta_multiplicity_le_mollified_circle_of_center_bound X c _ r R hr hrR hPole S hS
  apply (norm_mollifiedError_le_right_half_plane X hX δ hδ hc).trans
  rw [Real.rpow_neg hX₀.le, inv_mul_eq_div]
  apply (div_le_iff₀ hXpow).mpr
  linarith

end Legendre.Zeta
