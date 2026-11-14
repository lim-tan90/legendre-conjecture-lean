/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local integer-shift optimization. The cube-root scale is retained as an
explicit positive real parameter so the finite endpoint cases are visible.
-/
module
public import Legendre.Layer4.Exponential.LogDifferencing

@[expose] public section
namespace Legendre.Density.Oscillation

/-- Optimize actual finite differencing, including prefixes shorter than the chosen shift. -/
theorem logarithmic_weyl_square_budget (U M : ℕ) (t s C S : ℝ)
    (hU : 1 ≤ U) (hMU : M ≤ U) (ht : 1 ≤ t) (hs : 0 < s) (hs1 : 1 ≤ s)
    (hs3 : s^3 = t) (hU2 : (U : ℝ)^2 ≤ 4*t) (hC : 0 ≤ C)
    (hS : 0 ≤ S) (hSM : S ≤ M)
    (hvdc : ∀ H : ℕ, 1 ≤ H → H ≤ M →
      S^2 ≤ 2*(U : ℝ)^2/H+2*(U : ℝ)*C*
        (Real.sqrt (t*H/(U : ℝ))+(U : ℝ)*Real.sqrt ((U : ℝ)/t))) :
    S^2 ≤ (4+8*C)*(U : ℝ)*s := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hMp : (0 : ℝ) ≤ M := Nat.cast_nonneg M
  have hMUr : (M : ℝ) ≤ U := by exact_mod_cast hMU
  have htp : 0 < t := by linarith
  have hS2 : S^2 ≤ (M : ℝ)^2 := pow_le_pow_left₀ hS hSM 2
  have hUs : (U : ℝ) ≤ 2*s^2 := by
    apply (sq_le_sq₀ hUp.le (by positivity)).mp
    have hh := mul_le_mul_of_nonneg_right hs1 (show 0 ≤ s^3 by positivity)
    nlinarith
  have hsecond : (U : ℝ)*Real.sqrt ((U : ℝ)/t) ≤ 3*s := by
    apply (sq_le_sq₀ (by positivity) (by positivity)).mp
    rw [mul_pow,Real.sq_sqrt (by positivity : 0 ≤ (U : ℝ)/t),mul_pow]
    have he : (U : ℝ)^2*((U : ℝ)/t) ≤ 4*(U : ℝ) := by
      rw [←mul_div_assoc]
      apply (div_le_iff₀ htp).mpr
      nlinarith [mul_le_mul_of_nonneg_left hU2 hUp.le]
    nlinarith
  by_cases hlarge : 2 ≤ (U : ℝ)/s
  · let H := ⌊(U : ℝ)/s⌋₊
    have hH : 1 ≤ H := Nat.floor_pos.mpr (by linarith)
    have hHp : (0 : ℝ) < H := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hH)
    have hHhi : (H : ℝ) ≤ (U : ℝ)/s := Nat.floor_le (by positivity)
    have hfloor : (U : ℝ)/s < (H : ℝ)+1 := Nat.lt_floor_add_one _
    have hHlo : (U : ℝ) ≤ 2*(H : ℝ)*s := by
      have hh : (U : ℝ)/s ≤ 2*(H : ℝ) := by linarith
      exact (div_le_iff₀ hs).mp hh
    by_cases hHM : H ≤ M
    · have hlin : 2*(U : ℝ)^2/H ≤ 4*(U : ℝ)*s := by
        apply (div_le_iff₀ hHp).mpr
        nlinarith [mul_le_mul_of_nonneg_left hHlo (show 0 ≤ 2*(U : ℝ) by positivity)]
      have hroot : Real.sqrt (t*H/(U : ℝ)) ≤ s := by
        apply Real.sqrt_le_iff.mpr ⟨hs.le,?_⟩
        apply (div_le_iff₀ hUp).mpr
        have hh := (le_div_iff₀ hs).mp hHhi
        nlinarith [mul_le_mul_of_nonneg_left hh (sq_nonneg s)]
      have hh := hvdc H hH hHM
      have hcorr := mul_le_mul_of_nonneg_left (add_le_add hroot hsecond)
        (show 0 ≤ 2*(U : ℝ)*C by positivity)
      nlinarith
    · have hMH : (M : ℝ) ≤ H := by exact_mod_cast (le_of_not_ge hHM)
      have hMs : (M : ℝ) ≤ 2*s := hMH.trans (hHhi.trans ((div_le_iff₀ hs).mpr (by nlinarith)))
      have hh := mul_le_mul hMUr hMs hMp hUp.le
      nlinarith
  · have hUs' : (U : ℝ) ≤ 2*s := (div_le_iff₀ hs).mp (le_of_not_ge hlarge)
    have hMU2 := pow_le_pow_left₀ hMp hMUr 2
    nlinarith [mul_le_mul_of_nonneg_left hUs' hUp.le]

end Legendre.Density.Oscillation
