/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaCounting
public import Mathlib.Analysis.SpecialFunctions.Gamma.Deligne

/-!
# Reflection of critical-strip zeros, including analytic multiplicity

Original deductions using mathlib v4.35.0 (Apache-2.0).
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology

/-- The completed zeta function is analytic away from its two poles. -/
theorem completedZeta_analyticAt {s : ℂ} (hs0 : s ≠ 0) (hs1 : s ≠ 1) :
    AnalyticAt ℂ completedRiemannZeta s := by
  rw [Complex.analyticAt_iff_eventually_differentiableAt]
  filter_upwards [eventually_ne_nhds hs0, eventually_ne_nhds hs1] with z hz0 hz1
  exact differentiableAt_completedZeta hz0 hz1

/-- Gamma completion does not change the zero order inside the critical strip. -/
theorem zeta_order_eq_completed {s : ℂ} (hs : 0 < s.re) (hs1 : s ≠ 1) :
    analyticOrderAt riemannZeta s = analyticOrderAt completedRiemannZeta s := by
  have hs0 : s ≠ 0 := by intro h; simp [h] at hs
  have he : riemannZeta =ᶠ[𝓝 s]
      (fun z : ℂ ↦ completedRiemannZeta z * (Gammaℝ z)⁻¹) := by
    filter_upwards [eventually_ne_nhds hs0] with z hz
    rw [riemannZeta_def_of_ne_zero hz, div_eq_mul_inv]
  rw [analyticOrderAt_congr he]
  have hG : AnalyticAt ℂ (fun z : ℂ ↦ (Gammaℝ z)⁻¹) s := by
    rw [Complex.analyticAt_iff_eventually_differentiableAt]
    exact .of_forall (fun _ ↦ differentiable_Gammaℝ_inv _)
  have hGzero : analyticOrderAt (fun z : ℂ ↦ (Gammaℝ z)⁻¹) s = 0 :=
    analyticOrderAt_eq_zero.mpr (.inr (inv_ne_zero (Gammaℝ_ne_zero_of_re_pos hs)))
  simpa only [hGzero, add_zero] using!
    analyticOrderAt_mul (completedZeta_analyticAt hs0 hs1) hG

/-- The functional equation preserves analytic order under s↦1−s. -/
theorem zeta_order_one_sub {s : ℂ} (hs0 : 0 < s.re) (hs1 : s.re < 1) :
    analyticOrderAt riemannZeta (1 - s) = analyticOrderAt riemannZeta s := by
  have hsne : s ≠ 1 := by intro h; simp [h] at hs1
  have hrpos : 0 < (1 - s).re := by simp only [sub_re, one_re]; linarith
  have hrne : 1 - s ≠ 1 := by
    intro h
    have h0 : s = 0 := by linear_combination -h
    simp [h0] at hs0
  rw [zeta_order_eq_completed hrpos hrne, zeta_order_eq_completed hs0 hsne]
  have hcomp := analyticOrderAt_comp_of_deriv_ne_zero (f := completedRiemannZeta)
    (g := fun z : ℂ ↦ 1 - z) (z₀ := s) (by fun_prop) (by simp)
  have heq : (completedRiemannZeta ∘ (fun z : ℂ ↦ 1 - z)) = completedRiemannZeta := by
    funext z
    exact completedRiemannZeta_one_sub z
  rw [heq] at hcomp
  exact hcomp.symm

/-- Critical-strip reflection retains the natural zero multiplicity. -/
theorem zeroMultiplicity_one_sub {s : ℂ} (hs0 : 0 < s.re) (hs1 : s.re < 1) :
    zeroMultiplicity (1 - s) = zeroMultiplicity s := by
  unfold zeroMultiplicity analyticOrderNatAt
  rw [zeta_order_one_sub hs0 hs1]

/-- A critical-strip zero reflects to a critical-strip zero in the opposite half-plane. -/
theorem NontrivialZero.one_sub {s : ℂ} (hs : NontrivialZero s) : NontrivialZero (1 - s) := by
  have hs0 : s ≠ 0 := by intro h; have hp := hs.2.1; simp [h] at hp
  have hr0 : 1 - s ≠ 0 := by intro h; have h1 := sub_eq_zero.mp h; have hp := hs.2.2; rw [← h1] at hp; norm_num at hp
  have hG := Gammaℝ_ne_zero_of_re_pos hs.2.1
  have hξ : completedRiemannZeta s = 0 := by
    have h := (div_eq_iff hG).mp (riemannZeta_def_of_ne_zero hs0).symm
    rw [hs.1, zero_mul] at h
    exact h
  refine ⟨?_, ?_, ?_⟩
  · rw [riemannZeta_def_of_ne_zero hr0, completedRiemannZeta_one_sub, hξ, zero_div]
  · simp only [sub_re, one_re]; linarith [hs.2.2]
  · simp only [sub_re, one_re]; linarith [hs.2.1]

/-- Map every upper critical-strip zero into the right half of the strip, using either sign of height. -/
noncomputable def rightHalfZero (s : ℂ) : ℂ := if 1 / 2 ≤ s.re then s else 1 - s

/-- The reflection map preserves zeros, multiplicity and absolute height. -/
theorem rightHalfZero_properties {s : ℂ} (hs : NontrivialZero s) :
    NontrivialZero (rightHalfZero s) ∧ 1 / 2 ≤ (rightHalfZero s).re ∧
      |(rightHalfZero s).im| = |s.im| ∧ zeroMultiplicity (rightHalfZero s) = zeroMultiplicity s := by
  unfold rightHalfZero
  split_ifs with h
  · exact ⟨hs, h, rfl, rfl⟩
  · refine ⟨hs.one_sub, ?_, ?_, zeroMultiplicity_one_sub hs.2.1 hs.2.2⟩
    · simp only [sub_re, one_re]; linarith
    · simp

/-- Opposite signs of height prevent a collision between the two branches of reflection. -/
theorem rightHalfZero_injOn : Set.InjOn rightHalfZero {s : ℂ | 0 < s.im} := by
  intro s hs z hz he
  change 0 < s.im at hs
  change 0 < z.im at hz
  dsimp [rightHalfZero] at he
  split_ifs at he with hS hZ hZ
  · exact he
  · have hi := congrArg Complex.im he
    simp only [sub_im, one_im, zero_sub] at hi
    linarith
  · have hi := congrArg Complex.im he
    simp only [sub_im, one_im, zero_sub] at hi
    linarith
  · linear_combination -he

end Legendre.Zeta
