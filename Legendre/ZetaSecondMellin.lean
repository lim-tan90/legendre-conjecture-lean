/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaEulerPrimitive

/-!
# The second Euler Mellin remainder

The bounded periodic primitive gives an absolutely convergent and holomorphic
Mellin remainder throughout Re(s)>-1, one full half-plane beyond the first
fractional-part representation.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Topology Set

/-- Cut off the periodic primitive below one. -/
noncomputable def zetaSecondKernel (t : ℝ) : ℂ := (Ioi (1 : ℝ)).indicator zetaEulerPrimitive t

/-- The kernel is measurable even at the cutoff. -/
theorem zetaSecondKernel_measurable : Measurable zetaSecondKernel :=
  zetaEulerPrimitive_continuous.measurable.indicator measurableSet_Ioi

/-- A uniform bound for the cutoff kernel. -/
theorem norm_zetaSecondKernel_le (t : ℝ) : ‖zetaSecondKernel t‖ ≤ 1 := by
  by_cases ht : t ∈ Ioi (1 : ℝ)
  · rw [zetaSecondKernel,indicator_of_mem ht]
    exact (norm_zetaEulerPrimitive_le t).trans (by norm_num)
  · simp [zetaSecondKernel,ht]

/-- Bounded measurability gives local integrability. -/
theorem zetaSecondKernel_locallyIntegrable : LocallyIntegrable zetaSecondKernel := by
  apply (locallyIntegrable_const (1 : ℂ)).mono zetaSecondKernel_measurable.aestronglyMeasurable
  exact .of_forall (fun t => by simpa only [norm_one] using norm_zetaSecondKernel_le t)

/-- No growth at infinity is needed for the kernel. -/
theorem zetaSecondKernel_isBigO_atTop :
    zetaSecondKernel =O[atTop] (fun t : ℝ => t^(-(0 : ℝ))) := by
  apply Asymptotics.IsBigO.of_bound 1
  exact .of_forall (fun t => by simpa using norm_zetaSecondKernel_le t)

/-- The cutoff vanishes in a neighborhood of zero. -/
theorem zetaSecondKernel_isBigO_at_zero (b : ℝ) :
    zetaSecondKernel =O[𝓝[>] 0] (fun t : ℝ => t^(-b)) := by
  apply Asymptotics.IsBigO.of_bound 0
  filter_upwards [(eventually_lt_nhds (show (0 : ℝ) < 1 by norm_num)).filter_mono
    nhdsWithin_le_nhds] with t ht
  simp [zetaSecondKernel,indicator_of_notMem (show t ∉ Ioi (1 : ℝ) by exact not_lt.mpr ht.le)]

/-- The second Mellin remainder. -/
noncomputable def zetaSecondMellinRemainder (s : ℂ) : ℂ := mellin zetaSecondKernel (-s-1)

/-- Absolute convergence now holds for Re(s)>-1. -/
theorem zetaSecondMellinRemainder_convergent {s : ℂ} (hs : -1 < s.re) :
    MellinConvergent zetaSecondKernel (-s-1) := by
  apply mellinConvergent_of_isBigO_rpow
    (zetaSecondKernel_locallyIntegrable.locallyIntegrableOn (Ioi 0))
    zetaSecondKernel_isBigO_atTop (by simp only [sub_re,neg_re,one_re]; linarith)
    (zetaSecondKernel_isBigO_at_zero (-s.re-2))
  simp only [sub_re,neg_re,one_re]
  linarith

/-- Holomorphic dependence on the complex parameter in the enlarged half-plane. -/
theorem zetaSecondMellinRemainder_differentiableAt {s : ℂ} (hs : -1 < s.re) :
    DifferentiableAt ℂ zetaSecondMellinRemainder s := by
  have h := mellin_differentiableAt_of_isBigO_rpow
    (zetaSecondKernel_locallyIntegrable.locallyIntegrableOn (Ioi 0))
    zetaSecondKernel_isBigO_atTop (s := -s-1)
    (by simp only [sub_re,neg_re,one_re]; linarith)
    (zetaSecondKernel_isBigO_at_zero (-s.re-2))
    (by simp only [sub_re,neg_re,one_re]; linarith)
  exact h.comp s (differentiableAt_id.neg.sub_const 1)

/-- The Mellin integrand is an ordinary cutoff of the Euler integrand. -/
theorem zetaSecondMellin_integrand_eq_indicator (s : ℂ) (t : ℝ) :
    (t : ℂ)^((-s-1)-1)*zetaSecondKernel t = (Ioi (1 : ℝ)).indicator
      (fun u : ℝ => (u : ℂ)^(-s-2)*zetaEulerPrimitive u) t := by
  by_cases ht : t ∈ Ioi (1 : ℝ)
  · simp only [zetaSecondKernel,indicator_of_mem ht]
    congr 2
    ring
  · simp only [zetaSecondKernel,indicator_of_notMem ht,mul_zero]

/-- Integral representation on t>1. -/
theorem zetaSecondMellinRemainder_eq_integral (s : ℂ) :
    zetaSecondMellinRemainder s = ∫ t : ℝ in Ioi 1, (t : ℂ)^(-s-2)*zetaEulerPrimitive t := by
  simp only [zetaSecondMellinRemainder,mellin,smul_eq_mul,zetaSecondMellin_integrand_eq_indicator]
  rw [integral_indicator measurableSet_Ioi,
    Measure.restrict_restrict_of_subset (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))]

/-- Genuine absolute integrability precedes every subsequent use of the integral. -/
theorem zetaSecondMellinRemainder_integrable {s : ℂ} (hs : -1 < s.re) :
    IntegrableOn (fun t : ℝ => (t : ℂ)^(-s-2)*zetaEulerPrimitive t) (Ioi 1) := by
  have h := zetaSecondMellinRemainder_convergent hs
  unfold MellinConvergent at h
  simp only [smul_eq_mul,zetaSecondMellin_integrand_eq_indicator] at h
  rw [IntegrableOn,integrable_indicator_iff measurableSet_Ioi] at h
  unfold IntegrableOn at h
  rw [Measure.restrict_restrict_of_subset (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))] at h
  exact h

/-- Explicit norm bound, without a height-dependent coefficient. -/
theorem norm_zetaSecondMellinRemainder_le {s : ℂ} (hs : -1 < s.re) :
    ‖zetaSecondMellinRemainder s‖ ≤ 1/(s.re+1) := by
  have hm := integrableOn_Ioi_rpow_of_lt (a := -s.re-2) (by linarith) zero_lt_one
  have hb (t : ℝ) (ht : t ∈ Ioi (1 : ℝ)) :
      ‖(t : ℂ)^(-s-2)*zetaEulerPrimitive t‖ ≤ t^(-s.re-2) := by
    have htpos : 0 < t := zero_lt_one.trans ht
    rw [norm_mul,norm_cpow_eq_rpow_re_of_pos htpos]
    simp only [sub_re,neg_re,re_ofNat]
    exact (mul_le_mul_of_nonneg_left ((norm_zetaEulerPrimitive_le t).trans (by norm_num))
      (Real.rpow_nonneg htpos.le _)).trans_eq (mul_one _)
  rw [zetaSecondMellinRemainder_eq_integral]
  calc
    _ ≤ ∫ t : ℝ in Ioi 1, t^(-s.re-2) :=
      (norm_integral_le_integral_norm _).trans (integral_mono_ae
        (zetaSecondMellinRemainder_integrable hs).norm hm
        (by filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht; exact hb t ht))
    _ = _ := by
      rw [integral_Ioi_rpow_of_lt (by linarith) zero_lt_one,Real.one_rpow]
      rw [show -s.re-2+1 = -(s.re+1) by ring]
      simp only [div_neg,neg_div,neg_neg,one_div]

end Legendre.Zeta
