/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaWideZeroRemoval
public import Mathlib.Analysis.Complex.AbsMax
public import Mathlib.Analysis.Complex.HasPrimitives
public import Mathlib.Analysis.Complex.BorelCaratheodory
public import Mathlib.Analysis.Complex.Liouville

/-!
# Quantitative bounds after removal of the local zeta zeros

Original deductions using mathlib v4.35.0 (Apache-2.0).
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric Filter Topology

/-- Explicit boundary bound for the regularized quotient. -/
theorem norm_wideZetaRegularized_sphere_le {t : ℝ} (ht : 4 ≤ |t|) {z : ℂ}
    (hz : z ∈ sphere ((2 : ℂ) + (t : ℂ) * I) (5 / 2)) :
    ‖wideZetaRegularized t z‖ ≤ 4 * (|t| + 5)^2 * (4 : ℝ) ^ wideZetaDegree t := by
  have hp := one_fourth_pow_le_norm_wideZetaFactor ht hz
  have hpow : (0 : ℝ) < (1 / 4 : ℝ) ^ wideZetaDegree t := by positivity
  have hnorm : 0 < ‖wideZetaFactor t z‖ := hpow.trans_le hp
  rw [wideZetaRegularized_eq ht (sphere_subset_closedBall hz) (norm_pos_iff.mp hnorm), norm_div]
  calc
    _ ≤ (4 * (|t| + 5)^2) / ‖wideZetaFactor t z‖ :=
      div_le_div_of_nonneg_right (norm_riemannZeta_wide_disk_le ht (sphere_subset_closedBall hz))
        (norm_nonneg _)
    _ ≤ (4 * (|t| + 5)^2) / ((1 / 4 : ℝ) ^ wideZetaDegree t) :=
      div_le_div_of_nonneg_left (by positivity) hpow hp
    _ = _ := by simp [div_eq_mul_inv]

/-- Maximum modulus extends the boundary estimate to the entire larger disk. -/
theorem norm_wideZetaRegularized_disk_le {t : ℝ} (ht : 4 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 2)) :
    ‖wideZetaRegularized t z‖ ≤ 4 * (|t| + 5)^2 * (4 : ℝ) ^ wideZetaDegree t := by
  let c := (2 : ℂ) + (t : ℂ) * I
  have hR : (0 : ℝ) < 5 / 2 := by norm_num
  have hA := wideZetaRegularized_analyticOnNhd ht
  have hd : DiffContOnCl ℂ (wideZetaRegularized t) (ball c (5 / 2)) := by
    refine ⟨hA.differentiableOn.mono ball_subset_closedBall, ?_⟩
    simpa only [closure_ball c hR.ne'] using hA.continuousOn
  refine norm_le_of_forall_mem_frontier_norm_le isBounded_ball hd ?_ ?_
  · intro w hw
    apply norm_wideZetaRegularized_sphere_le ht
    simpa only [frontier_ball c hR.ne'] using hw
  · simpa only [closure_ball c hR.ne'] using hz

/-- Dividing by the nonzero center value controls the normalized regularized function explicitly. -/
theorem norm_wideZetaRegularized_ratio_le {t : ℝ} (ht : 4 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 2)) :
    ‖wideZetaRegularized t z / wideZetaRegularized t ((2 : ℂ) + (t : ℂ) * I)‖ ≤
      8 * (|t| + 5)^2 * (9 : ℝ) ^ wideZetaDegree t := by
  let c := (2 : ℂ) + (t : ℂ) * I
  have hcsmall : c ∈ closedBall c (9 / 4) := mem_closedBall_self (by norm_num)
  have hcbig : c ∈ closedBall c (5 / 2) := mem_closedBall_self (by norm_num)
  have hζ : riemannZeta c ≠ 0 := riemannZeta_ne_zero_of_one_le_re (by simp [c])
  have hp : wideZetaFactor t c ≠ 0 :=
    wideZetaFactor_ne_zero (wideZetaDivisor_eq_zero_of_ne_zero ht hζ)
  have hgc : 0 < ‖wideZetaRegularized t c‖ :=
    norm_pos_iff.mpr (wideZetaRegularized_ne_zero ht hcsmall)
  have heq : ‖wideZetaRegularized t c‖ * ‖wideZetaFactor t c‖ = ‖riemannZeta c‖ := by
    rw [wideZetaRegularized_eq ht hcbig hp, norm_div]
    exact div_mul_cancel₀ _ (norm_ne_zero_iff.mpr hp)
  have hcenter := one_half_le_norm_riemannZeta_disk_center t
  have hinv : 1 / ‖wideZetaRegularized t c‖ ≤ 2 * ‖wideZetaFactor t c‖ := by
    apply (div_le_iff₀ hgc).mpr
    dsimp [c] at heq ⊢
    nlinarith
  rw [norm_div, div_eq_mul_inv]
  calc
    _ ≤ (4 * (|t| + 5)^2 * (4 : ℝ) ^ wideZetaDegree t) *
        (2 * (9 / 4 : ℝ) ^ wideZetaDegree t) := by
      apply mul_le_mul (norm_wideZetaRegularized_disk_le ht hz) _ (by positivity) (by positivity)
      have hP := norm_wideZetaFactor_center_le ht
      dsimp [c] at hinv
      simpa only [one_div] using hinv.trans (mul_le_mul_of_nonneg_left hP (by norm_num))
    _ = _ := by
      have he : (4 : ℝ) ^ wideZetaDegree t * (9 / 4 : ℝ) ^ wideZetaDegree t =
          (9 : ℝ) ^ wideZetaDegree t := by rw [← mul_pow]; norm_num
      calc
        _ = 8 * (|t| + 5)^2 * ((4 : ℝ) ^ wideZetaDegree t *
            (9 / 4 : ℝ) ^ wideZetaDegree t) := by ring
        _ = _ := by rw [he]

/-- A logarithm of the center-normalized regularized zeta function on the inner disk.
Its value at the center is zero and its derivative is exactly the regularized logarithmic derivative. -/
theorem exists_wideZetaLog {t : ℝ} (ht : 4 ≤ |t|) :
    ∃ F : ℂ → ℂ, F ((2 : ℂ) + (t : ℂ) * I) = 0 ∧
      (∀ z ∈ ball ((2 : ℂ) + (t : ℂ) * I) (9 / 4),
        HasDerivAt F (logDeriv (wideZetaRegularized t) z) z) ∧
      (∀ z ∈ ball ((2 : ℂ) + (t : ℂ) * I) (9 / 4),
        exp (F z) = wideZetaRegularized t z /
          wideZetaRegularized t ((2 : ℂ) + (t : ℂ) * I)) := by
  let c := (2 : ℂ) + (t : ℂ) * I
  let g := wideZetaRegularized t
  have hA : AnalyticOnNhd ℂ g (ball c (9 / 4)) :=
    (wideZetaRegularized_analyticOnNhd ht).mono
      (ball_subset_closedBall.trans (closedBall_subset_closedBall (by norm_num)))
  have hne (z : ℂ) (hz : z ∈ ball c (9 / 4)) : g z ≠ 0 :=
    wideZetaRegularized_ne_zero ht (ball_subset_closedBall hz)
  have hD : DifferentiableOn ℂ (logDeriv g) (ball c (9 / 4)) := by
    intro z hz
    exact ((hA z hz).deriv.fun_div (hA z hz) (hne z hz)).differentiableWithinAt
  obtain ⟨F, hFc, hF⟩ := hD.isExactOn_ball.with_val_at c 0
  have hc : c ∈ ball c (9 / 4) := mem_ball_self (by norm_num)
  have hH (z : ℂ) (hz : z ∈ ball c (9 / 4)) :
      HasDerivAt (fun w ↦ exp (-F w) * g w) 0 z := by
    have hd := ((hF z hz).neg.cexp).mul (hA z hz).differentiableAt.hasDerivAt
    convert! hd using 1
    simp only [logDeriv_apply]
    field_simp [hne z hz]
    ring
  have hconst : Set.EqOn (fun w ↦ exp (-F w) * g w) (fun _ ↦ g c) (ball c (9 / 4)) := by
    refine isOpen_ball.eqOn_of_deriv_eq (convex_ball c (9 / 4)).isPreconnected
      (fun z hz ↦ (hH z hz).differentiableAt.differentiableWithinAt)
      (differentiableOn_const (g c)) ?_ hc ?_
    · intro z hz
      rw [(hH z hz).deriv, deriv_const]
    · simp [hFc]
  refine ⟨F, hFc, hF, ?_⟩
  intro z hz
  have he := congrArg (fun v : ℂ ↦ exp (F z) * v) (hconst hz)
  simp only [← mul_assoc, ← exp_add, add_neg_cancel, exp_zero, one_mul] at he
  exact (eq_div_iff (hne c hc)).mpr he.symm

/-- Fully explicit bound for the real part of the normalized logarithm. -/
noncomputable def wideZetaLogBound (t : ℝ) : ℝ :=
  (1 + Real.log 9 / Real.log (10 / 9)) * Real.log (8 * (|t| + 5)^2)

/-- Positivity of the bound used in Borel-Carathéodory. -/
theorem wideZetaLogBound_pos (t : ℝ) : 0 < wideZetaLogBound t := by
  have h5 : 0 < Real.log 9 := Real.log_pos (by norm_num)
  have h65 : 0 < Real.log (10 / 9) := Real.log_pos (by norm_num)
  have ht : 1 < 8 * (|t| + 5)^2 := by nlinarith [abs_nonneg t]
  have hL := Real.log_pos ht
  unfold wideZetaLogBound
  positivity

/-- The logarithm's real part is bounded using the center normalization and Jensen degree estimate. -/
theorem wideZetaLog_re_le {t : ℝ} (ht : 4 ≤ |t|) {F : ℂ → ℂ} {z : ℂ}
    (hz : z ∈ ball ((2 : ℂ) + (t : ℂ) * I) (9 / 4))
    (he : exp (F z) = wideZetaRegularized t z /
      wideZetaRegularized t ((2 : ℂ) + (t : ℂ) * I)) :
    (F z).re ≤ wideZetaLogBound t := by
  have hzbig := (closedBall_subset_closedBall (by norm_num : (9 / 4 : ℝ) ≤ 5 / 2))
    (ball_subset_closedBall hz)
  have hb := norm_wideZetaRegularized_ratio_le ht hzbig
  rw [← he, norm_exp] at hb
  have hlog := Real.log_le_log (Real.exp_pos (F z).re) hb
  rw [Real.log_exp, Real.log_mul (by positivity) (by positivity), Real.log_pow] at hlog
  have h5 : 0 ≤ Real.log 9 := Real.log_nonneg (by norm_num)
  calc
    _ ≤ Real.log (8 * (|t| + 5)^2) + (wideZetaDegree t : ℝ) * Real.log 9 := hlog
    _ ≤ Real.log (8 * (|t| + 5)^2) +
        (Real.log (8 * (|t| + 5)^2) / Real.log (10 / 9)) * Real.log 9 :=
      add_le_add le_rfl (mul_le_mul_of_nonneg_right (wideZetaDegree_le ht) h5)
    _ = _ := by unfold wideZetaLogBound; ring

/-- A normalized primitive satisfying the explicit Borel-Carathéodory hypotheses. -/
theorem exists_wideZetaLog_bounded {t : ℝ} (ht : 4 ≤ |t|) :
    ∃ F : ℂ → ℂ, F ((2 : ℂ) + (t : ℂ) * I) = 0 ∧
      (∀ z ∈ ball ((2 : ℂ) + (t : ℂ) * I) (9 / 4),
        HasDerivAt F (logDeriv (wideZetaRegularized t) z) z) ∧
      (∀ z ∈ ball ((2 : ℂ) + (t : ℂ) * I) (9 / 4), (F z).re ≤ wideZetaLogBound t) := by
  obtain ⟨F, hFc, hF, hexp⟩ := exists_wideZetaLog ht
  exact ⟨F, hFc, hF, fun z hz ↦ wideZetaLog_re_le ht hz (hexp z hz)⟩

/-- A slightly wider Cauchy estimate reaches the fixed negative edge Re(s)=-1/8. -/
theorem norm_logDeriv_wideZetaRegularized_le {t : ℝ} (ht : 4 ≤ |t|) {z : ℂ}
    (hz : ‖z-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 17/8) :
    ‖logDeriv (wideZetaRegularized t) z‖ ≤ 1120*wideZetaLogBound t := by
  let c := (2 : ℂ)+(t : ℂ)*I
  let M := wideZetaLogBound t
  have hM : 0 < M := wideZetaLogBound_pos t
  obtain ⟨F,hFc,hF,hFre⟩ := exists_wideZetaLog_bounded ht
  have hFdiff : DifferentiableOn ℂ F (ball c (9/4)) :=
    fun w hw => (hF w hw).differentiableAt.differentiableWithinAt
  have hshift : DifferentiableOn ℂ (fun w : ℂ => F (c+w)) (ball 0 (9/4)) := by
    intro w hw
    have hcw : c+w ∈ ball c (9/4) := by simpa [mem_ball,dist_eq_norm] using hw
    exact ((hF (c+w) hcw).differentiableAt.comp w
      ((differentiableAt_const c).add differentiableAt_id)).differentiableWithinAt
  have hbound (w : ℂ) (hw : ‖w-c‖ ≤ 35/16) : ‖F w‖ ≤ 70*M := by
    have hdist : ‖w-c‖ < 9/4 := by linarith
    have hh := borelCaratheodory_zero (f := fun v : ℂ => F (c+v)) (R := 9/4)
      hM hshift (fun v hv => hFre (c+v) (by simpa [c,mem_ball,dist_eq_norm] using hv))
      (by norm_num) (z := w-c) (by simpa only [mem_ball_zero_iff] using hdist)
      (by simpa using hFc)
    simp only [add_sub_cancel] at hh
    apply hh.trans
    apply (div_le_iff₀ (by linarith : 0 < (9/4 : ℝ)-‖w-c‖)).2
    nlinarith [mul_le_mul_of_nonneg_left hw hM.le]
  have hsub : closedBall z (1/16) ⊆ ball c (9/4) := by
    intro w hw
    have hwN : ‖w-z‖ ≤ 1/16 := by simpa only [mem_closedBall,dist_eq_norm] using hw
    have htri := norm_sub_le_norm_sub_add_norm_sub w z c
    rw [mem_ball,dist_eq_norm]
    dsimp [c] at htri
    linarith
  have hd : DiffContOnCl ℂ F (ball z (1/16)) := by
    refine ⟨hFdiff.mono (ball_subset_closedBall.trans hsub),?_⟩
    rw [closure_ball z (by norm_num : (1/16 : ℝ) ≠ 0)]
    exact fun w hw => (hF w (hsub hw)).continuousAt.continuousWithinAt
  have hC := norm_deriv_le_of_forall_mem_sphere_norm_le (f := F) (c := z)
    (R := 1/16) (C := 70*M) (by norm_num) hd (by
      intro w hw
      apply hbound
      have hwN : ‖w-z‖ = 1/16 := by simpa only [mem_sphere,dist_eq_norm] using hw
      have htri := norm_sub_le_norm_sub_add_norm_sub w z c
      dsimp [c] at htri
      linarith)
  have hzinner : z ∈ ball c (9/4) := by rw [mem_ball,dist_eq_norm]; dsimp [c]; linarith
  rw [(hF z hzinner).deriv] at hC
  convert! hC using 1
  ring

end Legendre.Zeta
