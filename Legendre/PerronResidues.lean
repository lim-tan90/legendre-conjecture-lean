/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronContour
public import Legendre.ZetaCounting
public import Legendre.PNT.ResidueCalcOnRectangles

/-!
# Multiplicity-weighted Perron residues

Local proofs using analytic factorization and the proved PNT+ simple-pole
residue interface. No simplicity assumption on zeta zeros is made.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology

/-- At a zero of arbitrary finite analytic order, the logarithmic residue
is its multiplicity. The statement also includes order-zero points. -/
theorem tendsto_mul_logDeriv_of_analytic {f : ℂ → ℂ} {p : ℂ}
    (hf : AnalyticAt ℂ f p) (hfinite : analyticOrderAt f p ≠ ⊤) :
    Tendsto (fun z => (z-p) * logDeriv f z) (𝓝[≠] p)
      (𝓝 (analyticOrderNatAt f p : ℂ)) := by
  obtain ⟨g, hg, hgp, heq⟩ := hf.analyticOrderAt_ne_top.1 hfinite
  simp only [smul_eq_mul] at heq
  have hlog : AnalyticAt ℂ (logDeriv g) p := hg.deriv.div hg hgp
  have hlim : Tendsto (fun z : ℂ => (analyticOrderNatAt f p : ℂ) +
      (z-p) * logDeriv g z) (𝓝[≠] p) (𝓝 (analyticOrderNatAt f p : ℂ)) := by
    have hsub : Tendsto (fun z : ℂ => z-p) (𝓝[≠] p) (𝓝 0) := by
      simpa using (tendsto_id.sub_const p).mono_left
        (nhdsWithin_le_nhds : 𝓝[≠] p ≤ 𝓝 p)
    simpa using tendsto_const_nhds.add
      (hsub.mul (hlog.continuousAt.tendsto.mono_left nhdsWithin_le_nhds))
  apply hlim.congr'
  filter_upwards [(logDeriv_congr_nhds heq).filter_mono nhdsWithin_le_nhds,
    hg.eventually_analyticAt.filter_mono nhdsWithin_le_nhds,
    (hg.continuousAt.eventually_ne hgp).filter_mono nhdsWithin_le_nhds,
    self_mem_nhdsWithin] with z hz hgz hgn hzp
  have hzp' : z-p ≠ 0 := sub_ne_zero.2 hzp
  rw [hz, logDeriv_fun_mul (f := fun z => (z-p)^analyticOrderNatAt f p)
    (g := g) z (pow_ne_zero _ hzp') hgn (by fun_prop) hgz.differentiableAt,
    logDeriv_fun_pow (by fun_prop : DifferentiableAt ℂ (fun z : ℂ => z-p) z)]
  have hlin : logDeriv (fun z : ℂ => z-p) z = 1/(z-p) := by
    simp [logDeriv_apply]
  rw [hlin]
  field_simp

/-- The Perron weight is analytic wherever its denominator is nonzero. -/
theorem perronWeight_analyticAt {x : ℝ} (hx : 0 < x) {s : ℂ} (hs : s ≠ 0) :
    AnalyticAt ℂ (perronWeight x) s := by
  have h : AnalyticAt ℂ (fun z : ℂ => exp (log (x : ℂ)*z)/z) s :=
    ((analyticAt_const.mul analyticAt_id).cexp).div analyticAt_id hs
  change AnalyticAt ℂ (fun z : ℂ => (x : ℂ)^z/z) s
  simpa only [cpow_def_of_ne_zero (ofReal_ne_zero.2 hx.ne')] using h

/-- No extra zero is introduced by the Perron weight. -/
theorem perronWeight_ne_zero {x : ℝ} (hx : 0 < x) {s : ℂ} (hs : s ≠ 0) :
    perronWeight x s ≠ 0 := by
  exact div_ne_zero (cpow_ne_zero_iff.2 (.inl (ofReal_ne_zero.2 hx.ne'))) hs

/-- Away from zeta zeros and the poles at 0 and 1, the kernel is analytic. -/
theorem perronIntegrand_analyticAt {x : ℝ} (hx : 0 < x) {s : ℂ}
    (hs0 : s ≠ 0) (hs1 : s ≠ 1) (hz : riemannZeta s ≠ 0) :
    AnalyticAt ℂ (perronIntegrand x) s := by
  have hζ := analytic_off_pole s (by simpa using hs1)
  exact ((hζ.deriv.div hζ hz).neg).mul (perronWeight_analyticAt hx hs0)

/-- The Perron kernel is meromorphic at every nonzero point, including 1. -/
theorem perronIntegrand_meromorphicAt {x : ℝ} (hx : 0 < x) {s : ℂ} (hs : s ≠ 0) :
    MeromorphicAt (perronIntegrand x) s := by
  by_cases hs1 : s = 1
  · subst s
    exact (((perronPoleNumerator_analyticAt_one hx).meromorphicAt.div
      (analyticAt_id.sub analyticAt_const).meromorphicAt).congr
      (perronIntegrand_eventuallyEq_poleNumerator x).symm)
  · have hζ := (analytic_off_pole s (by simpa using hs1))
    exact (hζ.deriv.meromorphicAt.div hζ.meromorphicAt).neg.mul
      (perronWeight_analyticAt hx hs).meromorphicAt

/-- Multiplicity is positive at every zeta zero off the pole. -/
theorem zeroMultiplicity_pos_of_zero {s : ℂ} (hs : s ≠ 1) (hz : riemannZeta s = 0) :
    0 < zeroMultiplicity s := by
  exact ENat.toNat_pos (analyticOrderAt_ne_zero.2
    ⟨analytic_off_pole s (by simpa using hs), hz⟩) (analytic_order_finite hs)

/-- The analytic zero order is also the meromorphic order, without discarding infinity. -/
theorem zeta_meromorphicOrder_eq_multiplicity {s : ℂ} (hs : s ≠ 1) :
    meromorphicOrderAt riemannZeta s = ((zeroMultiplicity s : ℤ) : WithTop ℤ) := by
  rw [(analytic_off_pole s (by simpa using hs)).meromorphicOrderAt_eq,
    ← zeroMultiplicity_cast hs]
  simp

/-- All nonzero zeta zeros give simple poles of the kernel, irrespective of their multiplicity. -/
theorem perronIntegrand_order_at_zero {x : ℝ} (hx : 0 < x) {s : ℂ}
    (hs0 : s ≠ 0) (hs1 : s ≠ 1) (hz : riemannZeta s = 0) :
    meromorphicOrderAt (perronIntegrand x) s = -1 := by
  have hζ := analytic_off_pole s (by simpa using hs1)
  have hn := zeroMultiplicity_pos_of_zero hs1 hz
  have ho : meromorphicOrderAt (logDeriv riemannZeta) s = -1 :=
    meromorphicOrderAt_logDeriv_eq_neg_one hζ.meromorphicAt
      (by rw [zeta_meromorphicOrder_eq_multiplicity hs1]; exact_mod_cast hn.ne')
      (by rw [zeta_meromorphicOrder_eq_multiplicity hs1]; exact WithTop.coe_ne_top)
  have heq : perronIntegrand x = (perronWeight x) * (-logDeriv riemannZeta) := by
    funext z
    simp only [perronIntegrand, Pi.mul_apply, Pi.neg_apply, mul_comm]
  rw [heq, meromorphicOrderAt_mul_of_ne_zero (perronWeight_analyticAt hx hs0)
    (perronWeight_ne_zero hx hs0), ← meromorphicOrderAt_neg, ho]

/-- At 1 the kernel has a simple pole with its nonzero residue x. -/
theorem perronIntegrand_order_one {x : ℝ} (hx : 0 < x) :
    meromorphicOrderAt (perronIntegrand x) 1 = -1 := by
  have ha := perronPoleNumerator_analyticAt_one hx
  have hn : perronPoleNumerator x 1 ≠ 0 := by
    rw [perronPoleNumerator_one]
    exact ofReal_ne_zero.2 hx.ne'
  rw [meromorphicOrderAt_congr (perronIntegrand_eventuallyEq_poleNumerator x)]
  have ho := meromorphicOrderAt_div (f := perronPoleNumerator x)
    (g := fun z : ℂ => z-1) ha.meromorphicAt
    ((show AnalyticAt ℂ (fun z : ℂ => z-1) 1 from by fun_prop).meromorphicAt)
  have hnum : meromorphicOrderAt (perronPoleNumerator x) 1 = 0 := by
    rw [ha.meromorphicOrderAt_eq, ha.analyticOrderAt_eq_zero.2 hn]
    simp
  change meromorphicOrderAt ((perronPoleNumerator x)/(fun z : ℂ => z-1)) 1 = -1
  rw [ho, hnum, meromorphicOrderAt_id_sub_const]
  norm_num

/-- The residue at a zeta zero is minus its analytic multiplicity times x^ρ/ρ. -/
theorem residue_perronIntegrand_at_zero {x : ℝ} (hx : 0 < x) {s : ℂ}
    (hs0 : s ≠ 0) (hs1 : s ≠ 1) :
    residue (perronIntegrand x) s = -(zeroMultiplicity s : ℂ) * perronWeight x s := by
  apply residue_eq_of_tendsto
  have h := ((tendsto_mul_logDeriv_of_analytic
    (analytic_off_pole s (by simpa using hs1)) (analytic_order_finite hs1)).neg).mul
      ((perronWeight_analyticAt hx hs0).continuousAt.tendsto.mono_left nhdsWithin_le_nhds)
  apply h.congr'
  apply Filter.Eventually.of_forall
  intro z
  simp only [perronIntegrand]
  ring

/-- The main pole contributes x to the normalized contour formula. -/
theorem residue_perronIntegrand_one {x : ℝ} (hx : 0 < x) :
    residue (perronIntegrand x) 1 = x := by
  apply residue_eq_of_tendsto
  exact tendsto_sub_mul_perronIntegrand_at_one hx

end Legendre.Zeta
