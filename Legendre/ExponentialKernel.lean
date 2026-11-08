/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
public import Mathlib.Analysis.Complex.Trigonometric

/-!
# Oscillatory kernels for finite Dirichlet-polynomial mean values

Local proofs using mathlib. The off-diagonal integral is bounded independently
of both endpoints. All finite-interval integrability hypotheses are proved.
-/

@[expose] public section

open scoped ComplexConjugate

namespace Legendre.Density

open Complex MeasureTheory

/-- A unit complex phase with real frequency. -/
noncomputable def realPhase (u t : ℝ) : ℂ := exp ((t*u : ℝ)*I)

/-- The phase is continuous on the whole real line. -/
theorem continuous_realPhase (u : ℝ) : Continuous (realPhase u) := by
  unfold realPhase
  fun_prop

/-- Every real-frequency phase has modulus one. -/
theorem norm_realPhase (u t : ℝ) : ‖realPhase u t‖ = 1 :=
  norm_exp_ofReal_mul_I _

/-- Conjugating a phase changes the sign of its frequency. -/
theorem conj_realPhase (u t : ℝ) : star (realPhase u t) = realPhase (-u) t := by
  change conj (realPhase u t) = realPhase (-u) t
  simp only [realPhase, ← exp_conj, map_mul, conj_ofReal, conj_I]
  congr 1
  push_cast
  ring

/-- Multiplication of a phase and a conjugate produces the difference frequency. -/
theorem realPhase_mul_conj (u v t : ℝ) :
    realPhase u t * star (realPhase v t) = realPhase (u-v) t := by
  rw [conj_realPhase]
  simp only [realPhase, ← exp_add]
  congr 1
  push_cast
  ring

/-- The finite oscillatory integral; the frequency-zero case is retained. -/
noncomputable def oscillatoryKernel (u A B : ℝ) : ℂ := ∫ t : ℝ in A..B, realPhase u t

/-- The diagonal integral is exactly the interval length, with oriented endpoints. -/
theorem oscillatoryKernel_zero (A B : ℝ) : oscillatoryKernel 0 A B = (B-A : ℝ) := by
  simp [oscillatoryKernel, realPhase]

/-- Exact off-diagonal integral, with its nonzero frequency hypothesis explicit. -/
theorem oscillatoryKernel_eq {u : ℝ} (hu : u ≠ 0) (A B : ℝ) :
    oscillatoryKernel u A B = (realPhase u B-realPhase u A)/((u : ℂ)*I) := by
  have hc : (u : ℂ)*I ≠ 0 := mul_ne_zero (ofReal_ne_zero.mpr hu) I_ne_zero
  have hphase (t : ℝ) : realPhase u t = exp (((u : ℂ)*I)*t) := by
    unfold realPhase
    push_cast
    congr 1
    ring
  simp_rw [oscillatoryKernel, hphase]
  exact integral_exp_mul_complex hc

/-- The cancellation bound is independent of the interval length and location. -/
theorem norm_oscillatoryKernel_le {u : ℝ} (hu : u ≠ 0) (A B : ℝ) :
    ‖oscillatoryKernel u A B‖ ≤ 2/|u| := by
  rw [oscillatoryKernel_eq hu, norm_div, norm_mul, norm_I, mul_one, norm_real, Real.norm_eq_abs]
  exact div_le_div_of_nonneg_right
    (by
      have h := norm_sub_le (realPhase u B) (realPhase u A)
      rw [norm_realPhase, norm_realPhase] at h
      norm_num at h
      exact h) (abs_nonneg u)

end Legendre.Density
