/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PrimeIntervals
public import Legendre.PerronGoodHeight
public import Legendre.PerronFullExplicit

/-!
# Layer 3: prime counting, finite explicit formula and classical PNT

This is the import interface for the documented Layer 3 scope. It exports
partial summation, Perron inversion with an error bound, the finite
multiplicity-weighted zero-sum formula, the classical PNT error for ψ, θ
and π−Li₂, and an unconditional sublinear prime-interval theorem.

The full-strip explicit formula now has a fixed negative edge, the evaluated
origin residue, and one absolute coefficient for the uniform contour error.
No polynomial short-interval exponent or numerical threshold is asserted.
-/

@[expose] public section

namespace Legendre.PNT

open Filter Topology Asymptotics Real

/-- A single decay constant works for all three PNT errors and for prime intervals.
The scale is sublinear and asymptotically dominates every fixed sublinear power. -/
theorem layer3_pnt_package : ∃ c > 0,
    ((fun x : ℝ => Chebyshev.psi x-x) =O[atTop] classicalError c) ∧
    ((fun x : ℝ => Chebyshev.theta x-x) =O[atTop] classicalError c) ∧
    ((fun x : ℝ => primeCount x-logarithmicIntegral x) =O[atTop] classicalError c) ∧
    classicalError c =o[atTop] (fun x : ℝ => x) ∧
    (∀ a : ℝ, a < 1 → (fun x : ℝ => x^a) =o[atTop] classicalError c) ∧
    ∃ X ≥ (1 : ℝ), ∀ x : ℝ, X ≤ x → HasPrimeIn x (classicalError c x) := by
  obtain ⟨c,hc,K,_hK,hψ,hθ,hπ,_hsub,hinterval⟩ := pnt_classical_error_with_prime_intervals
  let d := c/2
  have hd : 0 < d := by dsimp [d]; positivity
  have hdc : d < c := by dsimp [d]; linarith
  have hdom : classicalError c =O[atTop] classicalError d := by
    apply IsBigO.of_bound 1
    filter_upwards [eventually_mul_classicalError_le hdc 1,eventually_gt_atTop (0 : ℝ)]
      with x hx hx0
    simpa only [Real.norm_eq_abs,abs_of_pos (classicalError_pos c hx0),
      abs_of_pos (classicalError_pos d hx0),one_mul] using hx
  have hi : ∀ᶠ x : ℝ in atTop, HasPrimeIn x (classicalError d x) := by
    filter_upwards [hinterval,eventually_mul_classicalError_le hdc K] with x hx hcmp
    exact hx.mono hcmp
  obtain ⟨X,hX⟩ := eventually_atTop.1 hi
  exact ⟨d,hd,hψ.trans hdom,hθ.trans hdom,hπ.trans hdom,classicalError_isLittleO hd,
    fun a ha => rpow_isLittleO_classicalError d ha,
    max X 1,le_max_right _ _,fun x hx => hX x ((le_max_left _ _).trans hx)⟩

end Legendre.PNT
