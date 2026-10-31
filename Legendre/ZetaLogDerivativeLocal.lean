/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaRegularizedBound

/-!
# Effective local logarithmic-derivative estimates

Original deductions using mathlib v4.35.0 (Apache-2.0). Positivity of the
real parts of the zero principal parts supplies both a uniform upper bound
for -Re(ζ'/ζ) and the extra negative term forced by any selected zero.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric

/-- The zero principal parts can only decrease -Re(ζ'/ζ) on the right of 1. -/
theorem neg_logDeriv_re_le_local {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : ‖z - ((2 : ℂ) + (t : ℂ) * I)‖ ≤ 1) (hre : 1 < z.re) :
    (-logDeriv riemannZeta z).re ≤ 144 * localZetaLogBound t := by
  have hzbig : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2) := by
    rw [mem_closedBall, dist_eq_norm]
    linarith
  have he := logDeriv_riemannZeta_eq_regularized_add ht hzbig
    (riemannZeta_ne_zero_of_one_le_re hre.le)
  have hS : 0 ≤ ∑ u ∈ (localZetaDivisor_finite t).toFinset,
      ((localZetaDivisor t u : ℂ) / (z - u)).re :=
    Finset.sum_nonneg (fun u _ ↦ localZetaPrincipalPart_re_nonneg ht hre)
  have hnorm := norm_logDeriv_localZetaRegularized_le ht hz
  have hreal := (neg_le_abs (logDeriv (localZetaRegularized t) z).re).trans
    (abs_re_le_norm _)
  have her := congrArg Complex.re he
  simp only [add_re] at her
  rw [show (∑ u ∈ (localZetaDivisor_finite t).toFinset, (localZetaDivisor t u : ℂ) / (z - u)).re =
    ∑ u ∈ (localZetaDivisor_finite t).toFinset, ((localZetaDivisor t u : ℂ) / (z - u)).re from
      map_sum Complex.reCLM _ _] at her
  simp only [neg_re]
  linarith

/-- One selected zero contributes at least its simple-zero principal part. -/
theorem neg_logDeriv_re_le_local_sub_zero {t : ℝ} (ht : 3 ≤ |t|) {z ρ : ℂ}
    (hz : ‖z - ((2 : ℂ) + (t : ℂ) * I)‖ ≤ 1) (hre : 1 < z.re)
    (hρ : ρ ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)) (hzero : riemannZeta ρ = 0) :
    (-logDeriv riemannZeta z).re ≤
      144 * localZetaLogBound t - ((1 : ℂ) / (z - ρ)).re := by
  have hρbig := (closedBall_subset_closedBall (by norm_num : (5 / 4 : ℝ) ≤ 3 / 2)) hρ
  have hρpos : 0 < ρ.re := by have h := (zeta_disk_coordinates ht hρbig).1; linarith
  have hρlt : ρ.re < 1 := by
    by_contra h
    exact riemannZeta_ne_zero_of_one_le_re (not_lt.mp h) hzero
  have hm : 1 ≤ zeroMultiplicity ρ := zeroMultiplicity_pos ⟨hzero, hρpos, hρlt⟩
  have hD : 1 ≤ localZetaDivisor t ρ := by
    rw [localZetaDivisor_eq_multiplicity ht hρ]
    exact_mod_cast hm
  have hmem : ρ ∈ (localZetaDivisor_finite t).toFinset := by
    apply (localZetaDivisor_finite t).mem_toFinset.mpr
    change localZetaDivisor t ρ ≠ 0
    omega
  have hρinv : 0 ≤ ((1 : ℂ) / (z - ρ)).re := by
    simp only [div_re, one_re, one_im, one_mul, zero_mul, zero_div, add_zero, sub_re]
    exact div_nonneg (by linarith : 0 ≤ z.re - ρ.re) (normSq_nonneg _)
  have hterm : ((1 : ℂ) / (z - ρ)).re ≤ ((localZetaDivisor t ρ : ℂ) / (z - ρ)).re := by
    have he : ((localZetaDivisor t ρ : ℂ) / (z - ρ)).re =
        (localZetaDivisor t ρ : ℝ) * ((1 : ℂ) / (z - ρ)).re := by
      rw [show (localZetaDivisor t ρ : ℂ) / (z - ρ) =
        (localZetaDivisor t ρ : ℂ) * ((1 : ℂ) / (z - ρ)) by ring]
      simp [mul_re]
    rw [he]
    have hDreal : (1 : ℝ) ≤ (localZetaDivisor t ρ : ℝ) := by exact_mod_cast hD
    nlinarith
  have hsum := Finset.single_le_sum (s := (localZetaDivisor_finite t).toFinset)
    (f := fun u ↦ ((localZetaDivisor t u : ℂ) / (z - u)).re)
    (fun u _ ↦ localZetaPrincipalPart_re_nonneg ht hre) hmem
  have hzbig : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2) := by
    rw [mem_closedBall, dist_eq_norm]
    linarith
  have her := congrArg Complex.re (logDeriv_riemannZeta_eq_regularized_add ht hzbig
    (riemannZeta_ne_zero_of_one_le_re hre.le))
  simp only [add_re] at her
  rw [show (∑ u ∈ (localZetaDivisor_finite t).toFinset, (localZetaDivisor t u : ℂ) / (z - u)).re =
    ∑ u ∈ (localZetaDivisor_finite t).toFinset, ((localZetaDivisor t u : ℂ) / (z - u)).re from
      map_sum Complex.reCLM _ _] at her
  have hnorm := norm_logDeriv_localZetaRegularized_le ht hz
  have hreal := (neg_le_abs (logDeriv (localZetaRegularized t) z).re).trans
    (abs_re_le_norm _)
  simp only [neg_re]
  linarith

end Legendre.Zeta
