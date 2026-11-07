/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronExplicit
public import Legendre.ZetaNegativeStrip

/-!
# The extra Perron residue at the origin

A fixed negative contour crosses s=0. Its residue is -ζ′/ζ(0), with no
need to assume in advance that this coefficient is nonzero.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology

/-- ζ does not vanish at the origin. -/
theorem riemannZeta_ne_zero_origin : riemannZeta 0 ≠ 0 := by
  rw [riemannZeta_zero]
  norm_num

/-- The logarithmic derivative is analytic at zero. -/
theorem logDeriv_riemannZeta_analyticAt_origin : AnalyticAt ℂ (logDeriv riemannZeta) 0 := by
  have ha := analytic_off_pole 0 (by norm_num)
  exact ha.deriv.div ha riemannZeta_ne_zero_origin

/-- Multiplying the kernel by s removes its possible origin pole. -/
theorem perron_origin_numerator_analyticAt {x : ℝ} (hx : 0 < x) :
    AnalyticAt ℂ (fun s : ℂ => -logDeriv riemannZeta s*(x : ℂ)^s) 0 := by
  have hp : AnalyticAt ℂ (fun s : ℂ => (x : ℂ)^s) 0 := by
    have hh : AnalyticAt ℂ (fun z : ℂ => exp (log (x : ℂ)*z)) 0 :=
      (analyticAt_const.mul analyticAt_id).cexp
    simpa only [cpow_def_of_ne_zero (ofReal_ne_zero.2 hx.ne')] using hh
  exact logDeriv_riemannZeta_analyticAt_origin.neg.mul hp

/-- The kernel is meromorphic at every point, including the origin. -/
theorem perronIntegrand_meromorphicAt_all {x : ℝ} (hx : 0 < x) (s : ℂ) :
    MeromorphicAt (perronIntegrand x) s := by
  by_cases hs : s = 0
  · subst s
    have he : perronIntegrand x = (fun z : ℂ => (-logDeriv riemannZeta z*(x : ℂ)^z)/z) := by
      funext z
      simp only [perronIntegrand,perronWeight]
      ring
    rw [he]
    exact (perron_origin_numerator_analyticAt hx).meromorphicAt.div analyticAt_id.meromorphicAt
  · exact perronIntegrand_meromorphicAt hx hs

/-- The origin singularity is at most simple, even if its residue vanishes. -/
theorem perronIntegrand_order_origin_ge {x : ℝ} (hx : 0 < x) :
    (-1 : WithTop ℤ) ≤ meromorphicOrderAt (perronIntegrand x) 0 := by
  have hA := perron_origin_numerator_analyticAt hx
  have he : perronIntegrand x = (fun z : ℂ => (-logDeriv riemannZeta z*(x : ℂ)^z)/z) := by
    funext z
    simp only [perronIntegrand,perronWeight]
    ring
  rw [he]
  have ho := meromorphicOrderAt_div hA.meromorphicAt (analyticAt_id (𝕜 := ℂ) (z := 0)).meromorphicAt
  change (-1 : WithTop ℤ) ≤ meromorphicOrderAt
    ((fun z : ℂ => -logDeriv riemannZeta z*(x : ℂ)^z)/id) 0
  rw [ho,meromorphicOrderAt_id]
  change (-1 : WithTop ℤ) ≤ meromorphicOrderAt (fun z : ℂ => -logDeriv riemannZeta z*(x : ℂ)^z) 0-1
  have h : (0 : WithTop ℤ)-1 ≤ meromorphicOrderAt
      (fun z : ℂ => -logDeriv riemannZeta z*(x : ℂ)^z) 0-1 :=
    (LinearOrderedAddCommGroupWithTop.sub_le_sub_iff_left_of_ne_top
      (by simp : (1 : WithTop ℤ) ≠ ⊤)).2 hA.meromorphicOrderAt_nonneg
  simpa only [zero_sub] using h

/-- The residue at zero is independent of x. -/
theorem residue_perronIntegrand_origin {x : ℝ} (hx : 0 < x) :
    residue (perronIntegrand x) 0 = -logDeriv riemannZeta 0 := by
  apply residue_eq_of_tendsto
  have h := (perron_origin_numerator_analyticAt hx).continuousAt.tendsto.mono_left
    (nhdsWithin_le_nhds : 𝓝[≠] (0 : ℂ) ≤ 𝓝 0)
  simp only [cpow_zero,mul_one] at h
  apply h.congr'
  filter_upwards [self_mem_nhdsWithin] with z hz
  simp only [sub_zero,perronIntegrand,perronWeight]
  have hz0 : z ≠ 0 := hz
  field_simp [hz0]

/-- The kernel has at most simple poles everywhere. -/
theorem perronIntegrand_hasSimplePolesOn_all {x : ℝ} (hx : 0 < x) (S : Set ℂ) :
    HasSimplePolesOn (perronIntegrand x) S := by
  intro s _hs
  by_cases hs0 : s = 0
  · subst s
    exact perronIntegrand_order_origin_ge hx
  · by_cases hs1 : s = 1
    · subst s
      rw [perronIntegrand_order_one hx]
      exact le_rfl
    · by_cases hζ : riemannZeta s = 0
      · rw [perronIntegrand_order_at_zero hx hs0 hs1 hζ]
        exact le_rfl
      · exact (show (-1 : WithTop ℤ) ≤ 0 from WithTop.coe_le_coe.2 (by norm_num)).trans
          (perronIntegrand_analyticAt hx hs0 hs1 hζ).meromorphicOrderAt_nonneg

end Legendre.Zeta
