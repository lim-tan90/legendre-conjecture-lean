/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaLocalBound
public import Mathlib.Analysis.Meromorphic.LogDeriv

/-!
# Removing the zeros in a high zeta disk

Original deductions using mathlib v4.35.0 (Apache-2.0). The finite divisor
on the radius-5/4 disk determines an entire factor. Division by that factor,
with removable values filled in, leaves a holomorphic function on the
radius-3/2 disk and a nonvanishing function on the smaller disk.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric MeromorphicOn Filter Topology

/-- The analytic zero divisor on the inner closed disk. -/
noncomputable def localZetaDivisor (t : ℝ) :=
  divisor riemannZeta (closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4))

/-- Compactness ensures that the product used for zero removal really is finite. -/
theorem localZetaDivisor_finite (t : ℝ) : (localZetaDivisor t).support.Finite :=
  (localZetaDivisor t).finiteSupport (isCompact_closedBall _ _)

/-- All local divisor exponents are nonnegative, since the disk avoids the pole. -/
theorem localZetaDivisor_nonneg {t : ℝ} (ht : 3 ≤ |t|) (z : ℂ) :
    0 ≤ localZetaDivisor t z := by
  have hsmall : AnalyticOnNhd ℂ riemannZeta
      (closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)) :=
    (riemannZeta_analyticOnNhd_disk ht).mono (closedBall_subset_closedBall (by norm_num))
  exact hsmall.divisor_nonneg z

/-- Entire factor carrying exactly the selected local zero multiplicities. -/
noncomputable def localZetaFactor (t : ℝ) : ℂ → ℂ :=
  ∏ᶠ u : ℂ, (fun z ↦ z - u) ^ (localZetaDivisor t u)

/-- The selected zero factor is entire. -/
theorem localZetaFactor_analyticAt {t : ℝ} (ht : 3 ≤ |t|) (z : ℂ) :
    AnalyticAt ℂ (localZetaFactor t) z :=
  Function.FactorizedRational.analyticAt (localZetaDivisor_nonneg ht z)

/-- Its order at every point equals the selected multiplicity, including zero outside the disk. -/
theorem localZetaFactor_order (t : ℝ) (z : ℂ) :
    meromorphicOrderAt (localZetaFactor t) z = (localZetaDivisor t z : WithTop ℤ) :=
  Function.FactorizedRational.meromorphicOrderAt_eq _ (localZetaDivisor_finite t)

/-- Vanishing divisor exponent implies that the entire factor is nonzero there. -/
theorem localZetaFactor_ne_zero {t : ℝ} {z : ℂ} (hz : localZetaDivisor t z = 0) :
    localZetaFactor t z ≠ 0 := Function.FactorizedRational.ne_zero hz

/-- Analytic order and natural zero multiplicity agree as finite meromorphic orders. -/
theorem riemannZeta_meromorphicOrderAt_eq {z : ℂ} (hz : z ≠ 1) :
    meromorphicOrderAt riemannZeta z = ((zeroMultiplicity z : ℤ) : WithTop ℤ) := by
  rw [(analyticOn_riemannZeta z hz).meromorphicOrderAt_eq, ← zeroMultiplicity_cast hz]
  simp

/-- On the selected disk the divisor recovers the full analytic zero multiplicity. -/
theorem localZetaDivisor_eq_multiplicity {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)) :
    localZetaDivisor t z = (zeroMultiplicity z : ℤ) := by
  have hzbig := (closedBall_subset_closedBall (by norm_num : (5 / 4 : ℝ) ≤ 3 / 2)) hz
  have hzne : z ≠ 1 := by
    intro heq
    have h := (zeta_disk_coordinates ht hzbig).2
    simp only [heq, one_im, abs_zero] at h
    norm_num at h
  rw [localZetaDivisor, (riemannZeta_analyticOnNhd_disk ht).meromorphicOn.mono_set
    (closedBall_subset_closedBall (by norm_num : (5 / 4 : ℝ) ≤ 3 / 2)) |>.divisor_apply hz,
    riemannZeta_meromorphicOrderAt_eq hzne]
  simp

/-- The raw quotient is meromorphic on the larger disk before removable values are inserted. -/
theorem localZetaQuotient_meromorphicOn {t : ℝ} (ht : 3 ≤ |t|) :
    MeromorphicOn (fun z ↦ riemannZeta z / localZetaFactor t z)
      (closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) := by
  intro z hz
  exact ((riemannZeta_analyticOnNhd_disk ht) z hz).meromorphicAt.div
    (localZetaFactor_analyticAt ht z).meromorphicAt

/-- The raw quotient has the remaining order after subtracting the selected divisor. -/
theorem localZetaQuotient_order {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) :
    meromorphicOrderAt (fun w ↦ riemannZeta w / localZetaFactor t w) z =
      meromorphicOrderAt riemannZeta z - (localZetaDivisor t z : WithTop ℤ) := by
  have h := meromorphicOrderAt_div ((riemannZeta_analyticOnNhd_disk ht) z hz).meromorphicAt
    (localZetaFactor_analyticAt ht z).meromorphicAt
  simpa only [localZetaFactor_order] using! h

/-- The quotient, with removable singularities filled in on the larger disk. -/
noncomputable def localZetaRegularized (t : ℝ) : ℂ → ℂ :=
  toMeromorphicNFOn (fun z ↦ riemannZeta z / localZetaFactor t z)
    (closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2))

/-- Filling in removable values preserves the meromorphic order. -/
theorem localZetaRegularized_order {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) :
    meromorphicOrderAt (localZetaRegularized t) z =
      meromorphicOrderAt riemannZeta z - (localZetaDivisor t z : WithTop ℤ) := by
  exact (meromorphicOrderAt_congr
    ((localZetaQuotient_meromorphicOn ht).toMeromorphicNFOn_eq_self_on_nhdsNE hz)).trans
      (localZetaQuotient_order ht hz)

/-- Points of the larger high disk cannot be the zeta pole. -/
theorem zeta_disk_ne_one {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) : z ≠ 1 := by
  intro heq
  have h := (zeta_disk_coordinates ht hz).2
  simp only [heq, one_im, abs_zero] at h
  norm_num at h

/-- Outside the selected disk no zero factor is inserted. -/
theorem localZetaDivisor_eq_zero_of_not_mem {t : ℝ} {z : ℂ}
    (hz : z ∉ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)) :
    localZetaDivisor t z = 0 := by
  simp [localZetaDivisor, hz]

/-- The regularized quotient has no remaining pole anywhere on the larger disk. -/
theorem localZetaRegularized_analyticOnNhd {t : ℝ} (ht : 3 ≤ |t|) :
    AnalyticOnNhd ℂ (localZetaRegularized t)
      (closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) := by
  have hNF := meromorphicNFOn_toMeromorphicNFOn
    (fun z ↦ riemannZeta z / localZetaFactor t z)
    (closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2))
  intro z hz
  apply (hNF hz).meromorphicOrderAt_nonneg_iff_analyticAt.mp
  change 0 ≤ meromorphicOrderAt (localZetaRegularized t) z
  rw [localZetaRegularized_order ht hz]
  by_cases hsmall : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)
  · rw [localZetaDivisor_eq_multiplicity ht hsmall,
      riemannZeta_meromorphicOrderAt_eq (zeta_disk_ne_one ht hz)]
    simp
  · rw [localZetaDivisor_eq_zero_of_not_mem hsmall]
    simp only [WithTop.coe_zero, sub_zero]
    exact ((riemannZeta_analyticOnNhd_disk ht) z hz).meromorphicOrderAt_nonneg

/-- All selected zeros have been removed: the regularized quotient is nonzero on the inner disk. -/
theorem localZetaRegularized_ne_zero {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)) :
    localZetaRegularized t z ≠ 0 := by
  have hzbig := (closedBall_subset_closedBall (by norm_num : (5 / 4 : ℝ) ≤ 3 / 2)) hz
  have hNF := (localZetaRegularized_analyticOnNhd ht z hzbig).meromorphicNFAt
  apply hNF.meromorphicOrderAt_eq_zero_iff.mp
  rw [localZetaRegularized_order ht hzbig, localZetaDivisor_eq_multiplicity ht hz,
    riemannZeta_meromorphicOrderAt_eq (zeta_disk_ne_one ht hzbig)]
  simp

/-- At a nonzero zeta value the selected divisor vanishes. -/
theorem localZetaDivisor_eq_zero_of_ne_zero {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : riemannZeta z ≠ 0) : localZetaDivisor t z = 0 := by
  by_cases hsmall : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)
  · rw [localZetaDivisor_eq_multiplicity ht hsmall, zeroMultiplicity_eq_zero hz]
    simp
  · exact localZetaDivisor_eq_zero_of_not_mem hsmall

/-- At points where the zero factor is nonzero, regularization retains the ordinary quotient value. -/
theorem localZetaRegularized_eq {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2))
    (hp : localZetaFactor t z ≠ 0) :
    localZetaRegularized t z = riemannZeta z / localZetaFactor t z := by
  rw [localZetaRegularized, toMeromorphicNFOn_eq_toMeromorphicNFAt
    (localZetaQuotient_meromorphicOn ht) hz,
    toMeromorphicNFAt_eq_self.mpr (((riemannZeta_analyticOnNhd_disk ht z hz).fun_div
      (localZetaFactor_analyticAt ht z) hp).meromorphicNFAt)]

/-- Local equality with the ordinary quotient at any point with nonzero zero factor. -/
theorem localZetaRegularized_eventuallyEq {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2))
    (hp : localZetaFactor t z ≠ 0) :
    localZetaRegularized t =ᶠ[𝓝 z] (fun w ↦ riemannZeta w / localZetaFactor t w) := by
  have h := toMeromorphicNFOn_eq_toMeromorphicNFAt_on_nhds
    (localZetaQuotient_meromorphicOn ht) hz
  rw [toMeromorphicNFAt_eq_self.mpr (((riemannZeta_analyticOnNhd_disk ht z hz).fun_div
    (localZetaFactor_analyticAt ht z) hp).meromorphicNFAt)] at h
  exact h

/-- A concrete finite product formula for the zero factor, with no infinite-product convention. -/
theorem localZetaFactor_eq_prod (t : ℝ) (z : ℂ) :
    localZetaFactor t z = ∏ u ∈ (localZetaDivisor_finite t).toFinset,
      (z - u) ^ (localZetaDivisor t u) := by
  have hs : (fun u : ℂ ↦ (fun w : ℂ ↦ w - u) ^ (localZetaDivisor t u)).mulSupport ⊆
      (localZetaDivisor_finite t).toFinset := by
    simp only [Function.FactorizedRational.mulSupport]
    intro u hu
    exact (localZetaDivisor_finite t).mem_toFinset.mpr hu
  rw [localZetaFactor, finprod_eq_prod_of_mulSupport_subset _ hs]
  simp only [Finset.prod_apply, Pi.pow_apply]

/-- Logarithmic derivative of the zero factor is the exact finite sum of its principal parts. -/
theorem localZetaFactor_logDeriv {t : ℝ} {z : ℂ} (hz : localZetaDivisor t z = 0) :
    logDeriv (localZetaFactor t) z = ∑ u ∈ (localZetaDivisor_finite t).toFinset,
      (localZetaDivisor t u : ℂ) / (z - u) := by
  classical
  have hne (u : ℂ) (hu : u ∈ (localZetaDivisor_finite t).toFinset) : z - u ≠ 0 := by
    intro heq
    have hzu := sub_eq_zero.mp heq
    have hnonzero := (localZetaDivisor_finite t).mem_toFinset.mp hu
    exact hnonzero (hzu ▸ hz)
  have heq : localZetaFactor t = (fun w ↦ ∏ u ∈ (localZetaDivisor_finite t).toFinset,
      (w - u) ^ (localZetaDivisor t u)) := funext (localZetaFactor_eq_prod t)
  rw [heq, logDeriv_fun_prod
    (f := fun u w : ℂ ↦ (w - u) ^ (localZetaDivisor t u)) (x := z)
    (fun u hu ↦ zpow_ne_zero _ (hne u hu))
    (fun u hu ↦ (differentiableAt_id.sub_const u).zpow (.inl (hne u hu)))]
  apply Finset.sum_congr rfl
  intro u hu
  rw [logDeriv_fun_zpow (by fun_prop)]
  simp [logDeriv_apply, div_eq_mul_inv]

/-- Exact local logarithmic-derivative decomposition at every nonzero zeta value in the larger disk. -/
theorem logDeriv_riemannZeta_eq_regularized_add {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (3 / 2))
    (hζ : riemannZeta z ≠ 0) :
    logDeriv riemannZeta z = logDeriv (localZetaRegularized t) z +
      ∑ u ∈ (localZetaDivisor_finite t).toFinset, (localZetaDivisor t u : ℂ) / (z - u) := by
  have hD := localZetaDivisor_eq_zero_of_ne_zero ht hζ
  have hp := localZetaFactor_ne_zero hD
  have he := (logDeriv_congr_nhds (localZetaRegularized_eventuallyEq ht hz hp)).eq_of_nhds
  rw [logDeriv_fun_div z hζ hp ((riemannZeta_analyticOnNhd_disk ht) z hz).differentiableAt
    (localZetaFactor_analyticAt ht z).differentiableAt, localZetaFactor_logDeriv hD] at he
  exact sub_eq_iff_eq_add.mp he.symm

/-- A point with nonzero local divisor is a zeta zero strictly to the left of Re(s)=1. -/
theorem localZetaDivisor_support_zero {t : ℝ} (ht : 3 ≤ |t|) {u : ℂ}
    (hu : u ∈ (localZetaDivisor t).support) : riemannZeta u = 0 ∧ u.re < 1 := by
  have hζ : riemannZeta u = 0 := by
    by_contra h
    exact hu (localZetaDivisor_eq_zero_of_ne_zero ht h)
  refine ⟨hζ, lt_of_not_ge ?_⟩
  intro hre
  exact riemannZeta_ne_zero_of_one_le_re hre hζ

/-- Every selected principal part has nonnegative real part to the right of 1. -/
theorem localZetaPrincipalPart_re_nonneg {t : ℝ} (ht : 3 ≤ |t|) {z u : ℂ}
    (hz : 1 < z.re) : 0 ≤ ((localZetaDivisor t u : ℂ) / (z - u)).re := by
  by_cases hu : localZetaDivisor t u = 0
  · simp [hu]
  · have hure := (localZetaDivisor_support_zero ht hu).2
    have hpos : 0 ≤ z.re - u.re := by linarith
    have hD : (0 : ℝ) ≤ (localZetaDivisor t u : ℝ) := by
      exact_mod_cast localZetaDivisor_nonneg ht u
    simp only [div_re, intCast_re, intCast_im, sub_re, zero_mul, zero_div, add_zero]
    exact div_nonneg (mul_nonneg hD hpos) (normSq_nonneg _)

/-- Total selected multiplicity, expressed as a finite natural number. -/
noncomputable def localZetaDegree (t : ℝ) : ℕ :=
  ∑ u ∈ (localZetaDivisor_finite t).toFinset, (localZetaDivisor t u).toNat

/-- The natural degree recovers the integer divisor sum, without discarding negative values. -/
theorem localZetaDegree_cast {t : ℝ} (ht : 3 ≤ |t|) :
    (localZetaDegree t : ℤ) = ∑ᶠ u : ℂ, localZetaDivisor t u := by
  rw [finsum_eq_sum_of_support_subset _ (by
    intro u hu
    exact (localZetaDivisor_finite t).mem_toFinset.mpr hu)]
  simp only [localZetaDegree, Nat.cast_sum]
  apply Finset.sum_congr rfl
  intro u hu
  exact Int.toNat_of_nonneg (localZetaDivisor_nonneg ht u)

/-- The factor degree satisfies the explicit Jensen logarithmic bound. -/
theorem localZetaDegree_le {t : ℝ} (ht : 3 ≤ |t|) :
    (localZetaDegree t : ℝ) ≤ Real.log (24 * (|t| + 2)) / Real.log (6 / 5) := by
  have he : (localZetaDegree t : ℝ) =
      ((∑ᶠ u : ℂ, localZetaDivisor t u : ℤ) : ℝ) := by
    exact_mod_cast localZetaDegree_cast ht
  rw [he]
  exact zeta_local_divisor_sum_le ht

/-- All integer exponents can be written as natural powers under the high-disk hypothesis. -/
theorem localZetaFactor_eq_prod_nat {t : ℝ} (ht : 3 ≤ |t|) (z : ℂ) :
    localZetaFactor t z = ∏ u ∈ (localZetaDivisor_finite t).toFinset,
      (z - u) ^ (localZetaDivisor t u).toNat := by
  rw [localZetaFactor_eq_prod]
  apply Finset.prod_congr rfl
  intro u hu
  simpa only [Int.toNat_of_nonneg (localZetaDivisor_nonneg ht u)] using
    zpow_natCast (z - u) (localZetaDivisor t u).toNat

/-- The factor at the disk center has a quantitative upper bound. -/
theorem norm_localZetaFactor_center_le {t : ℝ} (ht : 3 ≤ |t|) :
    ‖localZetaFactor t ((2 : ℂ) + (t : ℂ) * I)‖ ≤ (5 / 4 : ℝ) ^ localZetaDegree t := by
  rw [localZetaFactor_eq_prod_nat ht, norm_prod]
  have hp : ∀ u ∈ (localZetaDivisor_finite t).toFinset,
      ‖((2 : ℂ) + (t : ℂ) * I - u) ^ (localZetaDivisor t u).toNat‖ ≤
        (5 / 4 : ℝ) ^ (localZetaDivisor t u).toNat := by
    intro u hu
    have hmem := (localZetaDivisor t).supportWithinDomain
      ((localZetaDivisor_finite t).mem_toFinset.mp hu)
    have hn : ‖(2 : ℂ) + (t : ℂ) * I - u‖ ≤ 5 / 4 := by
      simpa only [mem_closedBall, dist_eq_norm, norm_sub_rev] using hmem
    rw [norm_pow]
    exact pow_le_pow_left₀ (norm_nonneg _) hn _
  calc
    _ ≤ ∏ u ∈ (localZetaDivisor_finite t).toFinset,
        (5 / 4 : ℝ) ^ (localZetaDivisor t u).toNat :=
      Finset.prod_le_prod₀ (fun _ _ ↦ norm_nonneg _) hp
    _ = _ := Finset.prod_pow_eq_pow_sum _ _ _

/-- On the larger disk's boundary the zero factor is quantitatively separated from zero. -/
theorem one_fourth_pow_le_norm_localZetaFactor {t : ℝ} (ht : 3 ≤ |t|) {z : ℂ}
    (hz : z ∈ sphere ((2 : ℂ) + (t : ℂ) * I) (3 / 2)) :
    (1 / 4 : ℝ) ^ localZetaDegree t ≤ ‖localZetaFactor t z‖ := by
  rw [localZetaFactor_eq_prod_nat ht, norm_prod]
  have hp : ∀ u ∈ (localZetaDivisor_finite t).toFinset,
      (1 / 4 : ℝ) ^ (localZetaDivisor t u).toNat ≤
        ‖(z - u) ^ (localZetaDivisor t u).toNat‖ := by
    intro u hu
    have hmem := (localZetaDivisor t).supportWithinDomain
      ((localZetaDivisor_finite t).mem_toFinset.mp hu)
    have huN : ‖u - ((2 : ℂ) + (t : ℂ) * I)‖ ≤ 5 / 4 := by
      simpa only [mem_closedBall, dist_eq_norm] using hmem
    have hzN : ‖z - ((2 : ℂ) + (t : ℂ) * I)‖ = 3 / 2 := by
      simpa only [mem_sphere, dist_eq_norm] using hz
    have hn : 1 / 4 ≤ ‖z - u‖ := by
      have htri := norm_sub_le_norm_sub_add_norm_sub z u ((2 : ℂ) + (t : ℂ) * I)
      linarith
    rw [norm_pow]
    exact pow_le_pow_left₀ (by norm_num : (0 : ℝ) ≤ 1 / 4) hn _
  calc
    _ = ∏ u ∈ (localZetaDivisor_finite t).toFinset,
        (1 / 4 : ℝ) ^ (localZetaDivisor t u).toNat := (Finset.prod_pow_eq_pow_sum _ _ _).symm
    _ ≤ _ := Finset.prod_le_prod₀ (fun _ _ ↦ by positivity) hp

end Legendre.Zeta
