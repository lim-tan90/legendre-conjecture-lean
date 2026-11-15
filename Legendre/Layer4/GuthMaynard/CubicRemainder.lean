/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GuthMaynard.CubicTwoTail

/-!
# The two remaining cubic trace pieces

Local assembly of the attributed Poisson, zero-mode and one-tail estimates.
This is an error bound for the actual Gram trace; no bound for S₂ or S₃ is
assumed. Its constants precede the scale and every finite sample set.
-/

@[expose] public section
namespace Legendre.Density.GuthMaynard

/-- The cubic trace equals its diagonal main term plus S₂ and S₃ up to
O_ε(T^-10), throughout the source scale window N ≤ T ≤ N². -/
theorem gmMatrix_cubic_trace_two_piece_remainder (cutoff : GMSmoothCutoff)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ K : ℝ, 0 < K ∧ ∀ (N : ℕ) (W : Finset ℝ) {T : ℝ},
      0 < N → 1 ≤ T → (N : ℝ) ≤ T → T ≤ (N : ℝ)^2 →
      IsSeparated (T^ε) W → InBaseInterval T W →
      ‖Matrix.trace ((gmMatrix cutoff N W*(gmMatrix cutoff N W).conjTranspose)^3) -
        gmCubicDiagonalMain cutoff N W - gmCubicS2 cutoff N W -
          gmCubicS3 cutoff N W‖ ≤ K/T^10 := by
  obtain ⟨K₀,hK₀,hZero⟩ := gmCubicZeroMode_main_term cutoff ε hε
  obtain ⟨K₁,hK₁,hOne⟩ := gmCubicS1_estimate cutoff ε hε
  refine ⟨K₀+K₁,by positivity,?_⟩
  intro N W T hN hT hNT hTN hSep hW
  have hNr : 1 ≤ (N : ℝ) := by exact_mod_cast hN
  have hTpos : 0 < T := lt_of_lt_of_le zero_lt_one hT
  have hDiff :
      Matrix.trace ((gmMatrix cutoff N W*(gmMatrix cutoff N W).conjTranspose)^3) -
        gmCubicDiagonalMain cutoff N W - gmCubicS2 cutoff N W -
          gmCubicS3 cutoff N W =
      (gmCubicZeroMode cutoff N W-gmCubicDiagonalMain cutoff N W)+
        gmCubicS1 cutoff N W := by
    rw [gmMatrix_cubic_trace_split cutoff N hN W]
    ring
  rw [hDiff]
  calc
    _ ≤ ‖gmCubicZeroMode cutoff N W-gmCubicDiagonalMain cutoff N W‖+
        ‖gmCubicS1 cutoff N W‖ := norm_add_le _ _
    _ ≤ K₀/T^100+K₁/T^10 := add_le_add
      (hZero N W hN hT hNT hSep hW)
      (hOne N W hN hNr hT hNT hTN hSep hW)
    _ ≤ K₀/T^10+K₁/T^10 := by
      exact add_le_add (div_le_div_of_nonneg_left hK₀.le (pow_pos hTpos 10)
        (pow_le_pow_right₀ hT (by norm_num : 10 ≤ 100))) le_rfl
    _ = (K₀+K₁)/T^10 := by ring

/-- The cyclic diagonal is exactly the actual nonnegative difference moment
multiplied by the real zero-mode mass; no triangle inequality is needed. -/
theorem gmCubicS2FirstDiagonal_eq_difference_moment (cutoff : GMSmoothCutoff)
    (N : ℕ) (W : Finset ℝ) :
    gmCubicS2FirstDiagonal cutoff N W =
      (N : ℂ)*(gmCutoffL2Sq cutoff : ℂ)*
        (gmTraceNonzeroDifferenceMoment cutoff N W : ℂ) := by
  unfold gmCubicS2FirstDiagonal gmTraceNonzeroDifferenceMoment
  push_cast
  simp_rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro t ht
  apply Finset.sum_congr rfl
  intro u hu
  unfold gmCubicS2FirstSummand
  rw [sub_self, gmTraceZeroMode_zero]
  have hRev : (u : ℝ)-(t : ℝ) = -((t : ℝ)-(u : ℝ)) := by ring
  rw [hRev,gmTraceNonzeroTailAt_neg_eq_star,Complex.star_def,Complex.mul_conj']
  ring

/-- Only the ordered difference moment and the three-tail piece remain in
the actual cubic trace. All other frequency classes have a proved small error. -/
theorem gmMatrix_cubic_trace_moment_remainder (cutoff : GMSmoothCutoff)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ K : ℝ, 0 < K ∧ ∀ (N : ℕ) (W : Finset ℝ) {T : ℝ},
      0 < N → 1 ≤ T → (N : ℝ) ≤ T → T ≤ (N : ℝ)^2 →
      IsSeparated (T^ε) W → InBaseInterval T W →
      ‖Matrix.trace ((gmMatrix cutoff N W*(gmMatrix cutoff N W).conjTranspose)^3)-
        gmCubicDiagonalMain cutoff N W-
          3*(N : ℂ)*(gmCutoffL2Sq cutoff : ℂ)*
            (gmTraceNonzeroDifferenceMoment cutoff N W : ℂ)-gmCubicS3 cutoff N W‖ ≤
        K/T^10 := by
  obtain ⟨K₀,hK₀,hRest⟩ := gmMatrix_cubic_trace_two_piece_remainder cutoff ε hε
  obtain ⟨K₁,hK₁,hOff⟩ := gmCubicS2FirstOffDiagonal_power_decay cutoff ε hε
  refine ⟨K₀+3*K₁,by positivity,?_⟩
  intro N W T hN hT hNT hTN hs hi
  have hR := hRest N W hN hT hNT hTN hs hi
  have hO := hOff W hN hT hNT hs hi
  have hEq :
      Matrix.trace ((gmMatrix cutoff N W*(gmMatrix cutoff N W).conjTranspose)^3)-
        gmCubicDiagonalMain cutoff N W-
          3*(N : ℂ)*(gmCutoffL2Sq cutoff : ℂ)*
            (gmTraceNonzeroDifferenceMoment cutoff N W : ℂ)-gmCubicS3 cutoff N W =
      (Matrix.trace ((gmMatrix cutoff N W*(gmMatrix cutoff N W).conjTranspose)^3)-
        gmCubicDiagonalMain cutoff N W-gmCubicS2 cutoff N W-gmCubicS3 cutoff N W)+
          3*gmCubicS2FirstOffDiagonal cutoff N W := by
    rw [gmCubicS2_eq_three_mul_first,gmCubicS2First_eq_diagonal_add_offDiagonal,
      gmCubicS2FirstDiagonal_eq_difference_moment]
    ring
  rw [hEq]
  calc
    _ ≤ ‖Matrix.trace ((gmMatrix cutoff N W*(gmMatrix cutoff N W).conjTranspose)^3)-
        gmCubicDiagonalMain cutoff N W-gmCubicS2 cutoff N W-gmCubicS3 cutoff N W‖+
          ‖(3 : ℂ)*gmCubicS2FirstOffDiagonal cutoff N W‖ := norm_add_le _ _
    _ ≤ K₀/T^10+3*(K₁/T^10) := by
      rw [norm_mul]
      norm_num only [Complex.norm_ofNat]
      exact add_le_add hR (mul_le_mul_of_nonneg_left hO (by norm_num))
    _ = (K₀+3*K₁)/T^10 := by ring

end Legendre.Density.GuthMaynard
