/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaWideRegularizedBound

/-!
# Logarithmic derivatives on wide disks across the full critical strip

The polynomial bound from second Euler summation supports zero removal on
a disk reaching the fixed negative Perron edge. Selected zeros in these
high disks are all nontrivial zeros, as verified using the functional equation.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric Filter Topology

/-- A zero in a wide high disk lies in the open critical strip. -/
theorem wide_disk_zero_nontrivial {t : ℝ} (ht : 4 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (5/2)) (hzero : riemannZeta z = 0) :
    NontrivialZero z := by
  have hlow := (wide_zeta_disk_coordinates ht hz).1
  refine ⟨hzero,?_,?_⟩
  · by_contra hp
    exact riemannZeta_ne_zero_negative_strip (by linarith) (le_of_not_gt hp) hzero
  · by_contra hp
    exact riemannZeta_ne_zero_of_one_le_re (le_of_not_gt hp) hzero

/-- Quantitative distance from all critical-strip zeros excludes a zero in the larger local disk. -/
theorem zeta_ne_zero_of_wide_separation {t δ : ℝ} (ht : 4 ≤ |t|) (hδ : 0 < δ) {z : ℂ}
    (hz : ‖z-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 17/8)
    (hsep : ∀ ρ : ℂ, NontrivialZero ρ → δ ≤ ‖z-ρ‖) : riemannZeta z ≠ 0 := by
  intro hzero
  have hbig : z ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (5/2) := by
    rw [mem_closedBall,dist_eq_norm]
    linarith
  have h := hsep z (wide_disk_zero_nontrivial ht hbig hzero)
  simp only [sub_self,norm_zero] at h
  linarith

/-- The finite local principal parts are bounded by the multiplicity divided by the separation. -/
theorem norm_wideZetaPrincipalParts_le {t δ : ℝ} (ht : 4 ≤ |t|) (hδ : 0 < δ) {z : ℂ}
    (hsep : ∀ ρ : ℂ, NontrivialZero ρ → δ ≤ ‖z-ρ‖) :
    ‖∑ u ∈ (wideZetaDivisor_finite t).toFinset, (wideZetaDivisor t u : ℂ)/(z-u)‖ ≤
      (wideZetaDegree t : ℝ)/δ := by
  classical
  have hterm (u : ℂ) (hu : u ∈ (wideZetaDivisor_finite t).toFinset) :
      ‖(wideZetaDivisor t u : ℂ)/(z-u)‖ ≤ ((wideZetaDivisor t u).toNat : ℝ)/δ := by
    have hu' := (wideZetaDivisor_finite t).mem_toFinset.1 hu
    have hzero := wideZetaDivisor_support_zero ht hu'
    have hmem := (wideZetaDivisor t).supportWithinDomain hu'
    have hbig := (closedBall_subset_closedBall (by norm_num : (9/4 : ℝ) ≤ 5/2)) hmem
    have hdist := hsep u (wide_disk_zero_nontrivial ht hbig hzero.1)
    have hnorm : ‖(wideZetaDivisor t u : ℂ)‖ = ((wideZetaDivisor t u).toNat : ℝ) := by
      have he := Int.toNat_of_nonneg (wideZetaDivisor_nonneg ht u)
      calc
        _ = ‖(((wideZetaDivisor t u).toNat : ℕ) : ℂ)‖ := by
          congr 1
          exact_mod_cast he.symm
        _ = _ := by simp
    rw [norm_div,hnorm]
    exact div_le_div_of_nonneg_left (Nat.cast_nonneg _) hδ hdist
  calc
    _ ≤ ∑ u ∈ (wideZetaDivisor_finite t).toFinset, ‖(wideZetaDivisor t u : ℂ)/(z-u)‖ :=
      norm_sum_le _ _
    _ ≤ ∑ u ∈ (wideZetaDivisor_finite t).toFinset, ((wideZetaDivisor t u).toNat : ℝ)/δ :=
      Finset.sum_le_sum hterm
    _ = _ := by rw [← Finset.sum_div]; simp only [wideZetaDegree,Nat.cast_sum]

/-- An explicit analytic log-derivative bound in terms of a zero-separation radius. -/
theorem norm_logDeriv_le_wide_separated {t δ : ℝ} (ht : 4 ≤ |t|) (hδ : 0 < δ) {z : ℂ}
    (hz : ‖z-((2 : ℂ)+(t : ℂ)*I)‖ ≤ 17/8)
    (hsep : ∀ ρ : ℂ, NontrivialZero ρ → δ ≤ ‖z-ρ‖) :
    ‖logDeriv riemannZeta z‖ ≤ 1120*wideZetaLogBound t+(wideZetaDegree t : ℝ)/δ := by
  have hzbig : z ∈ closedBall ((2 : ℂ)+(t : ℂ)*I) (5/2) := by
    rw [mem_closedBall,dist_eq_norm]
    linarith
  rw [logDeriv_riemannZeta_eq_wide_regularized_add ht hzbig
    (zeta_ne_zero_of_wide_separation ht hδ hz hsep)]
  exact (norm_add_le _ _).trans (add_le_add
    (norm_logDeriv_wideZetaRegularized_le ht hz) (norm_wideZetaPrincipalParts_le ht hδ hsep))

end Legendre.Zeta
