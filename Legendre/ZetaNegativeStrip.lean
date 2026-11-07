/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaReflection
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex

/-!
# Nonvanishing in the strip immediately left of zero

The functional equation and the proved nonvanishing on Re(s)≥1 exclude
zeros in -1<Re(s)≤0, including the real axis. This permits a fixed negative
left edge for Perron contours, without a height-dependent zero cutoff.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex

/-- The cosine factor in the functional equation has no zero in 1≤Re(s)<2 except s=1. -/
theorem cos_functional_factor_ne_zero {s : ℂ} (hs : 1 ≤ s.re) (hs2 : s.re < 2)
    (hs1 : s ≠ 1) : cos ((Real.pi : ℂ)*s/2) ≠ 0 := by
  intro hz
  obtain ⟨k,hk⟩ := Complex.cos_eq_zero_iff.1 hz
  have hp : (Real.pi : ℂ) ≠ 0 := ofReal_ne_zero.mpr Real.pi_ne_zero
  have he : s = 2*(k : ℂ)+1 := by
    apply mul_left_cancel₀ hp
    linear_combination 2*hk
  have hr := congrArg Complex.re he
  simp only [add_re,mul_re,re_ofNat,intCast_re,intCast_im,im_ofNat,mul_zero,sub_zero,one_re] at hr
  have hk0 : (0 : ℝ) ≤ k := by linarith
  have hk1 : (k : ℝ) < 1 := by linarith
  have hk0' : (0 : ℤ) ≤ k := by exact_mod_cast hk0
  have hk1' : k < (1 : ℤ) := by exact_mod_cast hk1
  have hke : k = 0 := by omega
  apply hs1
  simpa only [hke,Int.cast_zero,mul_zero,zero_add] using he

/-- There are no zeta zeros in the strip -1<Re(s)≤0. -/
theorem riemannZeta_ne_zero_negative_strip {s : ℂ} (hs : -1 < s.re) (hs0 : s.re ≤ 0) :
    riemannZeta s ≠ 0 := by
  by_cases hzero : s = 0
  · rw [hzero,riemannZeta_zero]
    norm_num
  let r := 1-s
  have hr : 1 ≤ r.re := by dsimp [r]; linarith
  have hr2 : r.re < 2 := by dsimp [r]; linarith
  have hr1 : r ≠ 1 := by
    intro he
    apply hzero
    dsimp [r] at he
    linear_combination -he
  have hrneg (n : ℕ) : r ≠ -(n : ℂ) := by
    intro he
    have hre := congrArg Complex.re he
    simp only [neg_re,natCast_re] at hre
    linarith [Nat.cast_nonneg (α := ℝ) n]
  have hbase : (2*(Real.pi : ℂ)) ≠ 0 := mul_ne_zero (by norm_num) (ofReal_ne_zero.mpr Real.pi_ne_zero)
  have hf : 2*(2*(Real.pi : ℂ))^(-r)*Gamma r*cos ((Real.pi : ℂ)*r/2)*riemannZeta r ≠ 0 :=
    mul_ne_zero (mul_ne_zero (mul_ne_zero (mul_ne_zero (by norm_num)
      (cpow_ne_zero_iff.mpr (.inl hbase))) (Gamma_ne_zero hrneg))
      (cos_functional_factor_ne_zero hr hr2 hr1)) (riemannZeta_ne_zero_of_one_le_re hr)
  have he := riemannZeta_one_sub hrneg hr1
  dsimp [r] at he hf
  rw [sub_sub_cancel] at he
  rw [he]
  exact hf

/-- A fixed negative vertical line is nonvanishing at every height. -/
theorem riemannZeta_ne_zero_perron_left (t : ℝ) :
    riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*I) ≠ 0 := by
  apply riemannZeta_ne_zero_negative_strip <;> norm_num

end Legendre.Zeta
