/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local derivatives of one additive difference of the logarithmic phase.
The second derivative has size abs(t)*h/U^3, uniformly on the required closure.
-/
module
public import Legendre.Layer4.Exponential.LogPhase

@[expose] public section
namespace Legendre.Density.Oscillation
open Set

noncomputable def logarithmicShiftPhase (t h x : ℝ) : ℝ :=
  logarithmicPhase t (x+h)-logarithmicPhase t x

noncomputable def logarithmicShiftFirst (t h x : ℝ) : ℝ :=
  -t/(2*Real.pi)/(x+h)-(-t/(2*Real.pi)/x)

noncomputable def logarithmicShiftSecond (t h x : ℝ) : ℝ :=
  t/(2*Real.pi)/(x+h)^2-t/(2*Real.pi)/x^2

theorem logarithmicShiftPhase_deriv (t h x : ℝ) (hx : x ≠ 0) (hxh : x+h ≠ 0) :
    HasDerivAt (logarithmicShiftPhase t h) (logarithmicShiftFirst t h x) x := by
  exact ((logarithmicPhase_deriv t (x+h) hxh).comp_add_const x h).sub
    (logarithmicPhase_deriv t x hx)

theorem logarithmicShiftFirst_deriv (t h x : ℝ) (hx : x ≠ 0) (hxh : x+h ≠ 0) :
    HasDerivAt (logarithmicShiftFirst t h) (logarithmicShiftSecond t h x) x := by
  exact ((logarithmicPhase_second_deriv t (x+h) hxh).comp_add_const x h).sub
    (logarithmicPhase_second_deriv t x hx)

theorem logarithmicPhase_third_deriv (t x : ℝ) (hx : x ≠ 0) :
    HasDerivAt (fun y : ℝ => t/(2*Real.pi)/y^2) (-t/(Real.pi*x^3)) x := by
  convert! (hasDerivAt_const x (t/(2*Real.pi))).div ((hasDerivAt_id x).pow 2) (pow_ne_zero 2 hx) using 1
  simp only [Pi.pow_apply,id_eq,zero_mul,zero_sub]
  field_simp
  ring

/-- Positive shifts have one uniform second-derivative scale, for either sign of t. -/
theorem logarithmicShiftSecond_bounds (t h U x : ℝ) (hU : 0 < U) (hh : 0 < h)
    (hhU : h ≤ U) (hx : U ≤ x) (hxU : x ≤ 3*U) :
    |t| *h/(64*Real.pi*U^3) ≤ |logarithmicShiftSecond t h x| ∧
      |logarithmicShiftSecond t h x| ≤ 64*(|t| *h/(64*Real.pi*U^3)) := by
  let g := fun y : ℝ => t/(2*Real.pi)/y^2
  let g' := fun y : ℝ => -t/(Real.pi*y^3)
  have hg (y : ℝ) (hy : y ∈ Icc x (x+h)) : HasDerivAt g (g' y) y := by
    apply logarithmicPhase_third_deriv
    linarith [hy.1]
  obtain ⟨c,hc,he⟩ := exists_hasDerivAt_eq_slope g g' (by linarith : x < x+h)
    (fun y hy => (hg y hy).continuousAt.continuousWithinAt)
    (fun y hy => hg y ⟨hy.1.le,hy.2.le⟩)
  have hcp : 0 < c := by linarith [hc.1]
  have hcU : c ≤ 4*U := by linarith [hc.2]
  have hUc : U ≤ c := by linarith [hc.1]
  have hcl : U^3 ≤ c^3 := pow_le_pow_left₀ hU.le hUc 3
  have hcu : c^3 ≤ 64*U^3 := by
    have hh := pow_le_pow_left₀ hcp.le hcU 3
    norm_num [mul_pow] at hh
    exact hh
  have heq : logarithmicShiftSecond t h x = h*g' c := by
    have hxhe : x+h-x = h := by ring
    rw [hxhe] at he
    have hb := (eq_div_iff hh.ne').mp he
    dsimp [logarithmicShiftSecond,g] at hb ⊢
    linarith
  have habs : |logarithmicShiftSecond t h x| = |t| *h/(Real.pi*c^3) := by
    rw [heq,abs_mul,abs_of_pos hh]
    dsimp [g']
    rw [abs_div,abs_neg,abs_of_pos (by positivity : 0 < Real.pi*c^3)]
    ring
  rw [habs]
  constructor
  · exact div_le_div_of_nonneg_left (by positivity) (by positivity)
      (by nlinarith [mul_le_mul_of_nonneg_left hcu Real.pi_pos.le])
  · have he64 : 64*(|t| *h/(64*Real.pi*U^3)) = |t| *h/(Real.pi*U^3) := by ring
    rw [he64]
    exact div_le_div_of_nonneg_left (by positivity) (by positivity)
      (mul_le_mul_of_nonneg_left hcl Real.pi_pos.le)

end Legendre.Density.Oscillation
