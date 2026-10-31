/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaZeroRemoval

/-!
# The argument principle on the local high zeta disks

Original deductions using mathlib v4.35.0 (Apache-2.0). On a zero-free
boundary, the integral of ζ'/ζ counts all interior zeros with their
analytic multiplicities. This is a local disk statement, not the global
Riemann-von Mangoldt asymptotic for N(T).
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric Filter Topology

/-- If the boundary has no zeros, every selected divisor point is strictly interior. -/
theorem localZetaDivisor_mem_ball {t : ℝ} (ht : 3 ≤ |t|)
    (hb : ∀ z ∈ sphere ((2 : ℂ) + (t : ℂ) * I) (5 / 4), riemannZeta z ≠ 0)
    {u : ℂ} (hu : u ∈ (localZetaDivisor t).support) :
    u ∈ ball ((2 : ℂ) + (t : ℂ) * I) (5 / 4) := by
  have hmem := (localZetaDivisor t).supportWithinDomain hu
  rw [mem_closedBall] at hmem
  rw [mem_ball]
  apply lt_of_le_of_ne hmem
  intro he
  exact hb u (by simpa only [mem_sphere] using he) (localZetaDivisor_support_zero ht hu).1

/-- The zero-removed logarithmic derivative is analytic on the whole inner closed disk. -/
theorem localZetaRegularized_logDeriv_analyticOnNhd {t : ℝ} (ht : 3 ≤ |t|) :
    AnalyticOnNhd ℂ (logDeriv (localZetaRegularized t))
      (closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4)) := by
  intro z hz
  have hzbig := (closedBall_subset_closedBall (by norm_num : (5 / 4 : ℝ) ≤ 3 / 2)) hz
  have hA := localZetaRegularized_analyticOnNhd ht z hzbig
  exact hA.deriv.fun_div hA (localZetaRegularized_ne_zero ht hz)

/-- Cauchy-Goursat eliminates the regularized logarithmic derivative from the zero-counting contour. -/
theorem circleIntegral_localZetaRegularized_logDeriv {t : ℝ} (ht : 3 ≤ |t|) :
    (∮ z in C((2 : ℂ) + (t : ℂ) * I, 5 / 4), logDeriv (localZetaRegularized t) z) = 0 := by
  let c := (2 : ℂ) + (t : ℂ) * I
  have hA := localZetaRegularized_logDeriv_analyticOnNhd ht
  have hd : DiffContOnCl ℂ (logDeriv (localZetaRegularized t)) (ball c (5 / 4)) := by
    refine ⟨hA.differentiableOn.mono ball_subset_closedBall, ?_⟩
    simpa only [closure_ball c (by norm_num : (5 / 4 : ℝ) ≠ 0)] using hA.continuousOn
  exact hd.circleIntegral_eq_zero (by norm_num)

/-- Local zeta argument principle, with every zero counted by its analytic multiplicity. -/
theorem circleIntegral_logDeriv_riemannZeta_eq_degree {t : ℝ} (ht : 3 ≤ |t|)
    (hb : ∀ z ∈ sphere ((2 : ℂ) + (t : ℂ) * I) (5 / 4), riemannZeta z ≠ 0) :
    (∮ z in C((2 : ℂ) + (t : ℂ) * I, 5 / 4), logDeriv riemannZeta z) =
      2 * Real.pi * I * (localZetaDegree t : ℂ) := by
  classical
  let c := (2 : ℂ) + (t : ℂ) * I
  let S := (localZetaDivisor_finite t).toFinset
  have hball (u : ℂ) (hu : u ∈ S) : u ∈ ball c (5 / 4) :=
    localZetaDivisor_mem_ball ht hb ((localZetaDivisor_finite t).mem_toFinset.mp hu)
  have hterm (u : ℂ) (hu : u ∈ S) :
      CircleIntegrable (fun z : ℂ ↦ (localZetaDivisor t u : ℂ) / (z - u)) c (5 / 4) := by
    apply ContinuousOn.circleIntegrable (by norm_num)
    apply continuousOn_const.div (continuousOn_id.sub continuousOn_const)
    intro z hz he
    change z - u = 0 at he
    have hzu := sub_eq_zero.mp he
    have hin := hball u hu
    rw [mem_ball] at hin
    rw [mem_sphere, hzu] at hz
    linarith
  have hsum : CircleIntegrable (fun z : ℂ ↦ ∑ u ∈ S,
      (localZetaDivisor t u : ℂ) / (z - u)) c (5 / 4) := by
    exact CircleIntegrable.fun_sum S hterm
  have hreg : CircleIntegrable (logDeriv (localZetaRegularized t)) c (5 / 4) :=
    ((localZetaRegularized_logDeriv_analyticOnNhd ht).continuousOn.mono
      sphere_subset_closedBall).circleIntegrable (by norm_num)
  have heq : (∮ z in C(c, 5 / 4), logDeriv riemannZeta z) =
      ∮ z in C(c, 5 / 4), logDeriv (localZetaRegularized t) z +
        ∑ u ∈ S, (localZetaDivisor t u : ℂ) / (z - u) := by
    apply circleIntegral.integral_congr (by norm_num)
    intro z hz
    exact logDeriv_riemannZeta_eq_regularized_add ht
      ((closedBall_subset_closedBall (by norm_num : (5 / 4 : ℝ) ≤ 3 / 2))
        (sphere_subset_closedBall hz)) (hb z hz)
  rw [heq, circleIntegral.integral_add hreg hsum,
    circleIntegral_localZetaRegularized_logDeriv ht, zero_add,
    circleIntegral.integral_fun_sum hterm]
  have hdegree : (∑ u ∈ S, (localZetaDivisor t u : ℂ)) = (localZetaDegree t : ℂ) := by
    simp only [localZetaDegree, Nat.cast_sum]
    apply Finset.sum_congr rfl
    intro u hu
    norm_cast
    exact (Int.toNat_of_nonneg (localZetaDivisor_nonneg ht u)).symm
  calc
    _ = ∑ u ∈ S, (localZetaDivisor t u : ℂ) * (2 * Real.pi * I) := by
      apply Finset.sum_congr rfl
      intro u hu
      rw [show (fun z : ℂ ↦ (localZetaDivisor t u : ℂ) / (z - u)) =
        (fun z : ℂ ↦ (localZetaDivisor t u : ℂ) * (z - u)⁻¹) by
          funext z; exact div_eq_mul_inv _ _]
      rw [circleIntegral.integral_const_mul, circleIntegral.integral_sub_inv_of_mem_ball (hball u hu)]
    _ = (∑ u ∈ S, (localZetaDivisor t u : ℂ)) * (2 * Real.pi * I) := (Finset.sum_mul ..).symm
    _ = _ := by rw [hdegree, mul_comm]

end Legendre.Zeta
