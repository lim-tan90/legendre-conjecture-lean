/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronFoundation
public import Mathlib.Analysis.MellinTransform
public import Mathlib.Analysis.Complex.Convex

/-!
# A bounded fractional-part Mellin remainder for zeta

Original deductions using mathlib v4.35.0 (Apache-2.0).
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Topology
open scoped LSeries.notation

/-- Fractional part on t>1, extended by zero to the rest of the real axis. -/
noncomputable def zetaFractionalPart (t : ℝ) : ℂ :=
  (Set.Ioi (1 : ℝ)).indicator (fun u ↦ ((u - (⌊u⌋₊ : ℝ) : ℝ) : ℂ)) t

/-- Measurability is sufficient; the fractional-part function has jumps at integers. -/
theorem zetaFractionalPart_measurable : Measurable zetaFractionalPart := by
  have hfloor : Monotone (fun t : ℝ ↦ (⌊t⌋₊ : ℝ)) := by
    intro a b hab
    change (⌊a⌋₊ : ℝ) ≤ (⌊b⌋₊ : ℝ)
    exact_mod_cast Nat.floor_mono hab
  unfold zetaFractionalPart
  exact (measurable_ofReal.comp (measurable_id.sub
    hfloor.measurable)).indicator measurableSet_Ioi

/-- The cutoff fractional part is globally bounded by 1. -/
theorem norm_zetaFractionalPart_le (t : ℝ) : ‖zetaFractionalPart t‖ ≤ 1 := by
  by_cases ht : t ∈ Set.Ioi (1 : ℝ)
  · rw [zetaFractionalPart, Set.indicator_of_mem ht, norm_real, Real.norm_eq_abs,
      abs_of_nonneg (sub_nonneg.mpr (Nat.floor_le (le_trans zero_le_one ht.le)))]
    have h := Nat.lt_floor_add_one t
    linarith
  · simp only [zetaFractionalPart, Set.indicator_of_notMem ht, norm_zero]
    norm_num

/-- Bounded measurability gives local integrability, despite the integer jumps. -/
theorem zetaFractionalPart_locallyIntegrable : LocallyIntegrable zetaFractionalPart := by
  apply (locallyIntegrable_const (1 : ℂ)).mono zetaFractionalPart_measurable.aestronglyMeasurable
  exact .of_forall (fun t ↦ by simpa only [norm_one] using norm_zetaFractionalPart_le t)

/-- Uniform boundedness at infinity in the form required by the Mellin interface. -/
theorem zetaFractionalPart_isBigO_atTop :
    zetaFractionalPart =O[atTop] (fun t : ℝ ↦ t ^ (-(0 : ℝ))) := by
  apply Asymptotics.IsBigO.of_bound 1
  exact .of_forall (fun t ↦ by simpa using norm_zetaFractionalPart_le t)

/-- The cutoff vanishes near zero, so any Mellin growth exponent there is available. -/
theorem zetaFractionalPart_isBigO_at_zero (b : ℝ) :
    zetaFractionalPart =O[𝓝[>] 0] (fun t : ℝ ↦ t ^ (-b)) := by
  apply Asymptotics.IsBigO.of_bound 0
  filter_upwards [(eventually_lt_nhds (show (0 : ℝ) < 1 by norm_num)).filter_mono
    nhdsWithin_le_nhds] with t ht
  simp [zetaFractionalPart, Set.indicator_of_notMem (show t ∉ Set.Ioi (1 : ℝ) by
    exact not_lt.mpr ht.le)]

/-- The fractional-part Mellin remainder used in Euler summation. -/
noncomputable def zetaMellinRemainder (s : ℂ) : ℂ := mellin zetaFractionalPart (-s)

/-- Absolute convergence of the remainder throughout Re(s)>0. -/
theorem zetaMellinRemainder_convergent {s : ℂ} (hs : 0 < s.re) :
    MellinConvergent zetaFractionalPart (-s) := by
  apply mellinConvergent_of_isBigO_rpow
    (zetaFractionalPart_locallyIntegrable.locallyIntegrableOn (Set.Ioi 0))
    zetaFractionalPart_isBigO_atTop (by simpa using neg_neg_of_pos hs)
    (zetaFractionalPart_isBigO_at_zero (-s.re - 1))
  simp only [neg_re]
  linarith

/-- Holomorphic dependence on s in the half-plane of absolute convergence. -/
theorem zetaMellinRemainder_differentiableAt {s : ℂ} (hs : 0 < s.re) :
    DifferentiableAt ℂ zetaMellinRemainder s := by
  have h := mellin_differentiableAt_of_isBigO_rpow
    (zetaFractionalPart_locallyIntegrable.locallyIntegrableOn (Set.Ioi 0))
    zetaFractionalPart_isBigO_atTop (s := -s) (by simpa using neg_neg_of_pos hs)
    (zetaFractionalPart_isBigO_at_zero (-s.re - 1)) (by simp only [neg_re]; linarith)
  exact h.comp s differentiableAt_id.neg

/-- The Mellin integrand is a cutoff of the ordinary fractional-part integrand. -/
theorem zetaMellin_integrand_eq_indicator (s : ℂ) (t : ℝ) :
    (t : ℂ) ^ (-s - 1) * zetaFractionalPart t = (Set.Ioi (1 : ℝ)).indicator
      (fun u ↦ (u : ℂ) ^ (-(s + 1)) * ((u - (⌊u⌋₊ : ℝ) : ℝ) : ℂ)) t := by
  by_cases ht : t ∈ Set.Ioi (1 : ℝ)
  · simp only [zetaFractionalPart, Set.indicator_of_mem ht]
    congr 2
    ring
  · simp only [zetaFractionalPart, Set.indicator_of_notMem ht, mul_zero]

/-- The Mellin expression is the usual fractional-part integral on t>1. -/
theorem zetaMellinRemainder_eq_integral (s : ℂ) :
    zetaMellinRemainder s = ∫ t : ℝ in Set.Ioi 1,
      (t : ℂ) ^ (-(s + 1)) * ((t - (⌊t⌋₊ : ℝ) : ℝ) : ℂ) := by
  simp only [zetaMellinRemainder, mellin, smul_eq_mul, zetaMellin_integrand_eq_indicator]
  rw [integral_indicator measurableSet_Ioi,
    Measure.restrict_restrict_of_subset (Set.Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))]

/-- Absolute integrability of the uncut remainder on its actual integration domain. -/
theorem zetaMellinRemainder_integrable {s : ℂ} (hs : 0 < s.re) :
    IntegrableOn (fun t : ℝ ↦ (t : ℂ) ^ (-(s + 1)) *
      ((t - (⌊t⌋₊ : ℝ) : ℝ) : ℂ)) (Set.Ioi 1) := by
  have h := zetaMellinRemainder_convergent hs
  unfold MellinConvergent at h
  simp only [smul_eq_mul, zetaMellin_integrand_eq_indicator] at h
  rw [IntegrableOn, integrable_indicator_iff measurableSet_Ioi] at h
  unfold IntegrableOn at h
  rw [Measure.restrict_restrict_of_subset
    (Set.Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))] at h
  exact h

/-- Explicit bound for the fractional-part remainder: no hidden height-dependent constant. -/
theorem norm_zetaMellinRemainder_le {s : ℂ} (hs : 0 < s.re) :
    ‖zetaMellinRemainder s‖ ≤ 1 / s.re := by
  have hm := integrableOn_Ioi_rpow_of_lt (a := -s.re - 1) (by linarith) zero_lt_one
  have hb : ∀ t ∈ Set.Ioi (1 : ℝ),
      ‖(t : ℂ) ^ (-(s + 1)) * ((t - (⌊t⌋₊ : ℝ) : ℝ) : ℂ)‖ ≤ t ^ (-s.re - 1) := by
    intro t ht
    have htpos : 0 < t := zero_lt_one.trans ht
    have hf := norm_zetaFractionalPart_le t
    rw [zetaFractionalPart, Set.indicator_of_mem ht] at hf
    rw [norm_mul, norm_cpow_eq_rpow_re_of_pos htpos]
    simp only [neg_re, add_re, one_re]
    have he : -(s.re + 1) = -s.re - 1 := by ring
    rw [he]
    exact (mul_le_mul_of_nonneg_left hf (Real.rpow_nonneg htpos.le _)).trans_eq (mul_one _)
  rw [zetaMellinRemainder_eq_integral]
  calc
    _ ≤ ∫ t : ℝ in Set.Ioi 1, t ^ (-s.re - 1) :=
      (norm_integral_le_integral_norm _).trans (integral_mono_ae
        (zetaMellinRemainder_integrable hs).norm hm
        (by filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht; exact hb t ht))
    _ = _ := by
      rw [integral_Ioi_rpow_of_lt (by linarith) zero_lt_one, Real.one_rpow]
      ring

/-- Euler summation first obtained from the absolutely convergent zeta Dirichlet series. -/
theorem riemannZeta_eq_euler_sum_right {s : ℂ} (hs : 1 < s.re) :
    riemannZeta s = s / (s - 1) - s * zetaMellinRemainder s := by
  have hO : (fun n : ℕ ↦ ∑ k ∈ Finset.Icc 1 n, (1 : ℝ)) =O[atTop]
      (fun n ↦ (n : ℝ) ^ (1 : ℝ)) := by
    apply Asymptotics.IsBigO.of_bound 1
    exact .of_forall (fun n ↦ by simp [Nat.card_Icc])
  have hL := LSeries_eq_mul_integral_of_nonneg (fun _ : ℕ ↦ (1 : ℝ))
    (r := 1) zero_le_one hs hO (fun _ ↦ zero_le_one)
  have hseries : riemannZeta s = s * ∫ t : ℝ in Set.Ioi 1,
      (⌊t⌋₊ : ℂ) * (t : ℂ) ^ (-(s + 1)) := by
    simp only [ofReal_one, Finset.sum_const, Nat.card_Icc, Nat.add_sub_cancel, nsmul_eq_mul,
      mul_one] at hL
    change LSeries (1 : ℕ → ℂ) s = _ at hL
    rwa [LSeries_one_eq_riemannZeta hs] at hL
  have hp := integrableOn_Ioi_cpow_of_lt (a := -s) (by simpa using neg_lt_neg hs) zero_lt_one
  have hi : (∫ t : ℝ in Set.Ioi 1, (⌊t⌋₊ : ℂ) * (t : ℂ) ^ (-(s + 1))) =
      (∫ t : ℝ in Set.Ioi 1, (t : ℂ) ^ (-s)) - zetaMellinRemainder s := by
    rw [zetaMellinRemainder_eq_integral, ← integral_sub hp
      (zetaMellinRemainder_integrable (by linarith))]
    apply setIntegral_congr_fun measurableSet_Ioi
    intro t ht
    dsimp only
    have htpos : 0 < t := zero_lt_one.trans ht
    have he : (t : ℂ) ^ (-s) = (t : ℂ) * (t : ℂ) ^ (-(s + 1)) := by
      conv_rhs => lhs; rw [← cpow_one (t : ℂ)]
      rw [← cpow_add _ _ (ofReal_ne_zero.mpr htpos.ne')]
      congr 1
      ring
    rw [he]
    push_cast
    ring
  rw [hi, integral_Ioi_cpow_of_lt (by simpa using neg_lt_neg hs) zero_lt_one,
    ofReal_one, one_cpow] at hseries
  have he : -(1 : ℂ) / (-s + 1) = 1 / (s - 1) := by
    rw [show -s + 1 = -(s - 1) by ring, div_neg, neg_div, neg_neg]
  rw [he] at hseries
  rw [hseries]
  ring

/-- The pole-removed zeta function is entire, with the inserted residue at s=1. -/
theorem poleRemovedZeta_differentiable : Differentiable ℂ poleRemovedZeta := by
  intro s
  by_cases hs : s = 1
  · subst s
    exact poleRemovedZeta_analyticAt_one.differentiableAt
  · exact poleRemovedZeta_differentiableAt hs

/-- The Euler-summation numerator is holomorphic on Re(s)>0. -/
theorem zetaEulerNumerator_differentiableAt {s : ℂ} (hs : 0 < s.re) :
    DifferentiableAt ℂ (fun z : ℂ ↦ z - z * (z - 1) * zetaMellinRemainder z) s :=
  differentiableAt_id.sub ((differentiableAt_id.mul (differentiableAt_id.sub_const 1)).mul
    (zetaMellinRemainder_differentiableAt hs))

/-- Analytic continuation transfers Euler summation from Re(s)>1 to Re(s)>0. -/
theorem poleRemovedZeta_eq_euler_sum {s : ℂ} (hs : 0 < s.re) :
    poleRemovedZeta s = s - s * (s - 1) * zetaMellinRemainder s := by
  let U := {z : ℂ | 0 < z.re}
  have hU : IsOpen U := isOpen_lt continuous_const continuous_re
  have hH : AnalyticOnNhd ℂ poleRemovedZeta U :=
    poleRemovedZeta_differentiable.differentiableOn.analyticOnNhd hU
  have hg : AnalyticOnNhd ℂ (fun z : ℂ ↦ z - z * (z - 1) * zetaMellinRemainder z) U := by
    apply DifferentiableOn.analyticOnNhd _ hU
    intro z hz
    exact (zetaEulerNumerator_differentiableAt hz).differentiableWithinAt
  have hfg : poleRemovedZeta =ᶠ[𝓝 (2 : ℂ)]
      (fun z : ℂ ↦ z - z * (z - 1) * zetaMellinRemainder z) := by
    have he : {z : ℂ | 1 < z.re} ∈ 𝓝 (2 : ℂ) :=
      (isOpen_lt continuous_const continuous_re).mem_nhds (by norm_num)
    filter_upwards [he] with z hz
    have hzone : z ≠ 1 := by
      intro heq
      simp only [heq, one_re, lt_self_iff_false] at hz
    rw [poleRemovedZeta_eq hzone, riemannZeta_eq_euler_sum_right hz]
    field_simp
  exact (hH.eqOn_of_preconnected_of_eventuallyEq hg
    (convex_halfSpace_re_gt (0 : ℝ)).isPreconnected (z₀ := 2) (by norm_num [U]) hfg) hs

/-- Euler summation for zeta to the left of absolute Dirichlet convergence, excluding its pole. -/
theorem riemannZeta_eq_euler_sum {s : ℂ} (hs : 0 < s.re) (hsone : s ≠ 1) :
    riemannZeta s = s / (s - 1) - s * zetaMellinRemainder s := by
  have he := poleRemovedZeta_eq_euler_sum hs
  rw [poleRemovedZeta_eq hsone] at he
  apply (mul_left_cancel₀ (sub_ne_zero.mpr hsone))
  calc
    (s - 1) * riemannZeta s = _ := he
    _ = (s - 1) * (s / (s - 1) - s * zetaMellinRemainder s) := by
      field_simp

/-- Explicit polynomial-growth input on the positive half-plane, away from the pole. -/
theorem norm_riemannZeta_le_positive_re {s : ℂ} (hs : 0 < s.re) (hsone : s ≠ 1) :
    ‖riemannZeta s‖ ≤ ‖s‖ / ‖s - 1‖ + ‖s‖ / s.re := by
  rw [riemannZeta_eq_euler_sum hs hsone]
  apply (norm_sub_le _ _).trans
  rw [norm_div, norm_mul]
  exact add_le_add le_rfl (by
    simpa only [mul_one_div] using mul_le_mul_of_nonneg_left (norm_zetaMellinRemainder_le hs)
      (norm_nonneg s))

/-- A convenient polynomial bound away from the real axis in Re(s)≥1/2. -/
theorem norm_riemannZeta_le_three_mul_norm {s : ℂ} (hs : 1 / 2 ≤ s.re)
    (ht : 1 ≤ |s.im|) : ‖riemannZeta s‖ ≤ 3 * ‖s‖ := by
  have hspos : 0 < s.re := by linarith
  have hsone : s ≠ 1 := by
    intro he
    simp only [he, one_im, abs_zero] at ht
    norm_num at ht
  have hn : 1 ≤ ‖s - 1‖ := ht.trans (by simpa using abs_im_le_norm (s - 1))
  have hdiv : ‖s‖ / s.re ≤ 2 * ‖s‖ := by
    have h := div_le_div_of_nonneg_left (norm_nonneg s) (by norm_num : (0 : ℝ) < 1 / 2) hs
    linarith
  calc
    _ ≤ ‖s‖ / ‖s - 1‖ + ‖s‖ / s.re := norm_riemannZeta_le_positive_re hspos hsone
    _ ≤ ‖s‖ + 2 * ‖s‖ := add_le_add (div_le_self (norm_nonneg s) hn) hdiv
    _ = _ := by ring

/-- Absolute bound for the reciprocal-zeta Dirichlet series on Re(s)≥2. -/
theorem norm_moebius_LSeries_le_two {s : ℂ} (hs : 2 ≤ s.re) :
    ‖LSeries (↗ArithmeticFunction.moebius) s‖ ≤ 2 := by
  have hsum := ArithmeticFunction.LSeriesSummable_moebius_iff.mpr (by linarith : 1 < s.re)
  have hpow : Summable (fun n : ℕ ↦ (n : ℝ) ^ (-(2 : ℝ))) :=
    Real.summable_nat_rpow.mpr (by norm_num)
  have hb (n : ℕ) : ‖LSeries.term (↗ArithmeticFunction.moebius) s n‖ ≤
      (n : ℝ) ^ (-(2 : ℝ)) := by
    apply (LSeries.norm_term_le_of_re_le_re _ (s := (2 : ℂ)) (s' := s)
      (by simpa using hs) n).trans
    by_cases hn : n = 0
    · subst n
      simp
    · rw [LSeries.norm_term_eq, ite_eq_right hn]
      simp only [show (2 : ℂ).re = (2 : ℝ) from rfl, Real.rpow_ofNat]
      have hc : ‖(ArithmeticFunction.moebius n : ℂ)‖ ≤ 1 := by
        norm_cast
        exact ArithmeticFunction.abs_moebius_le_one
      calc
        _ ≤ 1 / (n : ℝ) ^ 2 := div_le_div_of_nonneg_right hc (by positivity)
        _ = _ := by simp [one_div]
  change ‖∑' n : ℕ, LSeries.term (↗ArithmeticFunction.moebius) s n‖ ≤ 2
  calc
    _ ≤ ∑' n : ℕ, ‖LSeries.term (↗ArithmeticFunction.moebius) s n‖ :=
      norm_tsum_le_tsum_norm hsum.norm
    _ ≤ ∑' n : ℕ, (n : ℝ) ^ (-(2 : ℝ)) := hsum.norm.tsum_le_tsum hb hpow
    _ ≤ 2 := by
      have h := tsum_nat_rpow_neg_le (p := 2) (by norm_num)
      norm_num at h ⊢
      exact h

/-- A uniform lower bound at the usual center of zero-free-region disks. -/
theorem one_half_le_norm_riemannZeta {s : ℂ} (hs : 2 ≤ s.re) :
    1 / 2 ≤ ‖riemannZeta s‖ := by
  have h := congrArg norm (ArithmeticFunction.LSeries_zeta_mul_Lseries_moebius
    (s := s) (by linarith : 1 < s.re))
  rw [norm_mul, norm_one, ArithmeticFunction.LSeries_zeta_eq_riemannZeta (by linarith)] at h
  have hb := mul_le_mul_of_nonneg_left (norm_moebius_LSeries_le_two hs)
    (norm_nonneg (riemannZeta s))
  rw [h] at hb
  linarith

end Legendre.Zeta
