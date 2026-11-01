/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaRegularizedBound

/-!
# Logarithmic derivatives at a quantitative distance from zeros

The regularized Cauchy estimate is extended to distance 9/8 from 2+it,
so it reaches Re(s)=7/8 on the horizontal diameter. The finite principal
parts are bounded by their multiplicity divided by the zero separation.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric Filter Topology

/-- A slightly wider Cauchy estimate reaches the strip edge Re(s)=7/8. -/
theorem norm_logDeriv_localZetaRegularized_le_wide {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : ‖z-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 9/8) :
    ‖logDeriv (localZetaRegularized t) z‖ ≤ 608*localZetaLogBound t := by
  let c := (2 : ℂ)+(t : ℂ)*I
  let M := localZetaLogBound t
  have hM : 0 < M := localZetaLogBound_pos t
  obtain ⟨F,hFc,hF,hFre⟩ := exists_localZetaLog_bounded ht
  have hFdiff : DifferentiableOn ℂ F (ball c (5/4)) :=
    fun w hw => (hF w hw).differentiableAt.differentiableWithinAt
  have hshift : DifferentiableOn ℂ (fun w : ℂ => F (c+w)) (ball 0 (5/4)) := by
    intro w hw
    have hcw : c+w ∈ ball c (5/4) := by simpa [mem_ball,dist_eq_norm] using hw
    exact ((hF (c+w) hcw).differentiableAt.comp w
      ((differentiableAt_const c).add differentiableAt_id)).differentiableWithinAt
  have hbound (w : ℂ) (hw : ‖w-c‖ ≤ 19/16) : ‖F w‖ ≤ 38*M := by
    have hdist : ‖w-c‖ < 5/4 := by linarith
    have hh := borelCaratheodory_zero (f := fun v : ℂ => F (c+v)) (R := 5/4)
      hM hshift (fun v hv => hFre (c+v) (by simpa [c,mem_ball,dist_eq_norm] using hv))
      (by norm_num) (z := w-c) (by simpa only [mem_ball_zero_iff] using hdist)
      (by simpa using hFc)
    simp only [add_sub_cancel] at hh
    apply hh.trans
    apply (div_le_iff₀ (by linarith : 0 < (5/4 : ℝ)-‖w-c‖)).2
    nlinarith [mul_le_mul_of_nonneg_left hw hM.le]
  have hsub : closedBall z (1/16) ⊆ ball c (5/4) := by
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
    (R := 1/16) (C := 38*M) (by norm_num) hd (by
      intro w hw
      apply hbound
      have hwN : ‖w-z‖ = 1/16 := by simpa only [mem_sphere,dist_eq_norm] using hw
      have htri := norm_sub_le_norm_sub_add_norm_sub w z c
      dsimp [c] at htri
      linarith)
  have hzinner : z ∈ ball c (5/4) := by rw [mem_ball,dist_eq_norm]; dsimp [c]; linarith
  rw [(hF z hzinner).deriv] at hC
  convert! hC using 1
  ring

/-- Quantitative distance from all critical-strip zeros excludes a zero in the larger local disk. -/
theorem zeta_ne_zero_of_local_separation {t δ : ℝ} (ht : 3 ≤ |t|) (hδ : 0 < δ) {z : ℂ}
    (hz : ‖z-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 9/8)
    (hsep : ∀ ρ : ℂ, NontrivialZero ρ → δ ≤ ‖z-ρ‖) : riemannZeta z ≠ 0 := by
  intro hzero
  have hbig : z ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (3/2) := by
    rw [mem_closedBall,dist_eq_norm]
    linarith
  have hre : 0 < z.re := by have h := (zeta_disk_coordinates ht hbig).1; linarith
  have hre1 : z.re < 1 := by
    by_contra h
    exact riemannZeta_ne_zero_of_one_le_re (le_of_not_gt h) hzero
  have h := hsep z ⟨hzero,hre,hre1⟩
  simp only [sub_self,norm_zero] at h
  linarith

/-- The finite local principal parts are bounded by the multiplicity divided by the separation. -/
theorem norm_localZetaPrincipalParts_le {t δ : ℝ} (ht : 3 ≤ |t|) (hδ : 0 < δ) {z : ℂ}
    (hsep : ∀ ρ : ℂ, NontrivialZero ρ → δ ≤ ‖z-ρ‖) :
    ‖∑ u ∈ (localZetaDivisor_finite t).toFinset, (localZetaDivisor t u : ℂ)/(z-u)‖ ≤
      (localZetaDegree t : ℝ)/δ := by
  classical
  have hterm (u : ℂ) (hu : u ∈ (localZetaDivisor_finite t).toFinset) :
      ‖(localZetaDivisor t u : ℂ)/(z-u)‖ ≤ ((localZetaDivisor t u).toNat : ℝ)/δ := by
    have hu' := (localZetaDivisor_finite t).mem_toFinset.1 hu
    have hzero := localZetaDivisor_support_zero ht hu'
    have hmem := (localZetaDivisor t).supportWithinDomain hu'
    have hbig := (closedBall_subset_closedBall (by norm_num : (5/4 : ℝ) ≤ 3/2)) hmem
    have hpos : 0 < u.re := by have h := (zeta_disk_coordinates ht hbig).1; linarith
    have hdist := hsep u ⟨hzero.1,hpos,hzero.2⟩
    have hnorm : ‖(localZetaDivisor t u : ℂ)‖ = ((localZetaDivisor t u).toNat : ℝ) := by
      have he := Int.toNat_of_nonneg (localZetaDivisor_nonneg ht u)
      calc
        _ = ‖(((localZetaDivisor t u).toNat : ℕ) : ℂ)‖ := by
          congr 1
          exact_mod_cast he.symm
        _ = _ := by simp
    rw [norm_div,hnorm]
    exact div_le_div_of_nonneg_left (Nat.cast_nonneg _) hδ hdist
  calc
    _ ≤ ∑ u ∈ (localZetaDivisor_finite t).toFinset, ‖(localZetaDivisor t u : ℂ)/(z-u)‖ :=
      norm_sum_le _ _
    _ ≤ ∑ u ∈ (localZetaDivisor_finite t).toFinset, ((localZetaDivisor t u).toNat : ℝ)/δ :=
      Finset.sum_le_sum hterm
    _ = _ := by rw [← Finset.sum_div]; simp only [localZetaDegree,Nat.cast_sum]

/-- An explicit analytic log-derivative bound in terms of a zero-separation radius. -/
theorem norm_logDeriv_le_local_separated {t δ : ℝ} (ht : 3 ≤ |t|) (hδ : 0 < δ) {z : ℂ}
    (hz : ‖z-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 9/8)
    (hsep : ∀ ρ : ℂ, NontrivialZero ρ → δ ≤ ‖z-ρ‖) :
    ‖logDeriv riemannZeta z‖ ≤ 608*localZetaLogBound t+(localZetaDegree t : ℝ)/δ := by
  have hzbig : z ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (3/2) := by
    rw [mem_closedBall,dist_eq_norm]
    linarith
  rw [logDeriv_riemannZeta_eq_regularized_add ht hzbig
    (zeta_ne_zero_of_local_separation ht hδ hz hsep)]
  exact (norm_add_le _ _).trans (add_le_add
    (norm_logDeriv_localZetaRegularized_le_wide ht hz) (norm_localZetaPrincipalParts_le ht hδ hsep))

end Legendre.Zeta
