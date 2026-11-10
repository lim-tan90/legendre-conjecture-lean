/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local numerical optimization of the Halasz absorption window.
-/
module
public import Legendre.Layer4.Exponential.HalaszSubdivision

@[expose] public section
namespace Legendre.Density.Oscillation

noncomputable def halaszAbsorptionScale (B E W : ℝ) : ℝ :=
  W^4/(8*B^2*logarithmicKernelConstant^2*E^2)

theorem halaszAbsorptionScale_pos (B E W : ℝ) (hB : 0 < B) (hE : 0 < E) (hW : 0 < W) :
    0 < halaszAbsorptionScale B E W := by
  have hC := logarithmicKernelConstant_pos
  unfold halaszAbsorptionScale
  positivity

theorem halaszAbsorptionScale_sqrt (B E W : ℝ) (hB : 0 < B) (hE : 0 < E) (hW : 0 < W) :
    B*logarithmicKernelConstant*Real.sqrt (2*halaszAbsorptionScale B E W)*E = W^2/2 := by
  have hC := logarithmicKernelConstant_pos
  have he : 2*halaszAbsorptionScale B E W = (W^2/(2*B*logarithmicKernelConstant*E))^2 := by
    unfold halaszAbsorptionScale
    field_simp
    ring
  rw [he,Real.sqrt_sq (by positivity : 0 ≤ W^2/(2*B*logarithmicKernelConstant*E))]
  field_simp

theorem one_le_halaszAbsorptionScale (B E W : ℝ) (hB : 0 < B) (hE : 0 < E) (hW : 0 < W)
    (hlarge : 4*B*logarithmicKernelConstant*E ≤ W^2) :
    1 ≤ halaszAbsorptionScale B E W := by
  have hC := logarithmicKernelConstant_pos
  unfold halaszAbsorptionScale
  apply (le_div_iff₀ (by positivity : 0 < 8*B^2*logarithmicKernelConstant^2*E^2)).mpr
  have hh := pow_le_pow_left₀ (by positivity : 0 ≤ 4*B*logarithmicKernelConstant*E) hlarge 2
  nlinarith [sq_nonneg (B*logarithmicKernelConstant*E)]

theorem halasz_scale_absorbs (B E W H : ℝ) (hB : 0 < B) (hE : 0 < E) (hW : 0 < W)
    (hH : H ≤ halaszAbsorptionScale B E W) :
    B*logarithmicKernelConstant*Real.sqrt (2*H)*E ≤ W^2/2 := by
  have hC := logarithmicKernelConstant_pos
  have hh := mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left hH (by norm_num : (0 : ℝ) ≤ 2)))
      (mul_nonneg hB.le hC.le)) hE.le
  exact hh.trans_eq (halaszAbsorptionScale_sqrt B E W hB hE hW)

theorem halasz_window_overhead (B E W T : ℝ) (hB : 0 < B) (hE : 0 < E) (hW : 0 < W)
    (hT : 0 < T) :
    1+2*T/min T (halaszAbsorptionScale B E W) ≤
      3+16*T*B^2*logarithmicKernelConstant^2*E^2/W^4 := by
  have hC := logarithmicKernelConstant_pos
  by_cases hh : T ≤ halaszAbsorptionScale B E W
  · rw [min_eq_left hh]
    have he : 2*T/T = (2 : ℝ) := by field_simp
    rw [he]
    have hn : 0 ≤ 16*T*B^2*logarithmicKernelConstant^2*E^2/W^4 := by positivity
    linarith
  · rw [min_eq_right (le_of_lt (lt_of_not_ge hh))]
    have he : 2*T/halaszAbsorptionScale B E W =
        16*T*B^2*logarithmicKernelConstant^2*E^2/W^4 := by
      unfold halaszAbsorptionScale
      field_simp
      ring
    rw [he]
    linarith

end Legendre.Density.Oscillation
