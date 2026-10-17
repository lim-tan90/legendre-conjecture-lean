/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Basic
public import Mathlib.NumberTheory.Chebyshev
public import Mathlib.NumberTheory.PrimeCounting
public import Mathlib.Algebra.Order.Floor.Semiring

/-!
# Layer 1: explicit interval and Chebyshev bounds

This module formalizes the *core* of Layer 1 of the roadmap:

* a clean predicate `HasPrimeIn x h` for “there is a prime in `(x, x + h]`”;
* an explicit short-interval theorem `hasPrimeIn_self`: for every real `x ≥ 1`
  there is a prime in `(x, 2x]` (the sharp form of Bertrand's postulate);
* the Chebyshev bridge `exists_prime_of_theta_lt`: a strict increase of
  `θ(y) - θ(x)` forces a prime in `(x, y]`;
* explicit upper/lower bounds for `θ`, `ψ`, and `π`, re-exported from mathlib
  with a stable project-local API.

The stronger explicit results of Nagura (1952) and Dusart (2010) are *not*
proved here; they require sharper explicit Chebyshev estimates than mathlib
currently provides.  They are therefore not claimed.
-/

@[expose] public section

namespace Legendre

open Filter

/-- `HasPrimeIn x h` means that the half-open interval `(x, x + h]` contains a
prime.  This is the interval form used by short-interval prime theorems. -/
def HasPrimeIn (x h : ℝ) : Prop :=
  ∃ p : ℕ, p.Prime ∧ x < (p : ℝ) ∧ (p : ℝ) ≤ x + h

theorem hasPrimeIn_iff {x h : ℝ} :
    HasPrimeIn x h ↔ ∃ p : ℕ, p.Prime ∧ x < (p : ℝ) ∧ (p : ℝ) ≤ x + h :=
  Iff.rfl

/-- Monotonicity of `HasPrimeIn` in the interval length. -/
theorem HasPrimeIn.mono {x h h' : ℝ} (hh : h ≤ h') (H : HasPrimeIn x h) :
    HasPrimeIn x h' := by
  obtain ⟨p, hp, hxp, hpx⟩ := H
  exact ⟨p, hp, hxp, le_trans hpx (by linarith)⟩

/-- **Layer 1 explicit short interval.**  For every real `x ≥ 1`, the interval
`(x, 2x]` contains a prime.  This is the sharp form of Bertrand's postulate,
obtained from mathlib's `Nat.exists_prime_lt_and_le_two_mul` by applying it to
`⌊x⌋`. -/
theorem hasPrimeIn_self (x : ℝ) (hx : 1 ≤ x) : HasPrimeIn x x := by
  let n : ℕ := ⌊x⌋₊
  have hn0 : n ≠ 0 := by
    have hnpos : 0 < n := Nat.floor_pos.mpr hx
    omega
  obtain ⟨p, hp, hnp, hp2n⟩ := Nat.exists_prime_lt_and_le_two_mul n hn0
  refine ⟨p, hp, ?_, ?_⟩
  · -- `x < n + 1 ≤ p`
    have hxlt : x < (n : ℝ) + 1 := Nat.lt_floor_add_one x
    have hsucc : (n : ℝ) + 1 ≤ (p : ℝ) := by
      exact_mod_cast Nat.succ_le_of_lt hnp
    linarith
  · -- `p ≤ 2n ≤ 2x`
    have hp2n' : (p : ℝ) ≤ 2 * (n : ℝ) := by exact_mod_cast hp2n
    have hnle : (n : ℝ) ≤ x := Nat.floor_le (by linarith)
    linarith

/-- **Layer 1 Chebyshev bridge.**  If `θ` strictly increases from `x` to `y`,
then there is a prime in `(x, y]`.  This is the elementary step that turns a
lower bound for `θ(y) - θ(x)` into a prime in a short interval. -/
theorem exists_prime_of_theta_lt {x y : ℝ} (hy : 0 ≤ y)
    (h : Chebyshev.theta x < Chebyshev.theta y) :
    ∃ p : ℕ, p.Prime ∧ x < (p : ℝ) ∧ (p : ℝ) ≤ y := by
  by_contra hno
  push Not at hno
  have hsub : (Finset.Ioc 0 ⌊y⌋₊).filter (fun p : ℕ => p.Prime) ⊆
      (Finset.Ioc 0 ⌊x⌋₊).filter (fun p : ℕ => p.Prime) := by
    intro p hp
    have hp' : (0 < p ∧ p ≤ ⌊y⌋₊) ∧ p.Prime := by
      simpa only [Finset.mem_filter, Finset.mem_Ioc] using hp
    have hple : p ≤ ⌊x⌋₊ := by
      by_contra hnot
      have hxp : x < (p : ℝ) := by
        by_contra hxnot
        exact hnot (Nat.le_floor (le_of_not_gt hxnot))
      have hp_le_y : (p : ℝ) ≤ y := by
        exact le_trans (by exact_mod_cast hp'.1.2) (Nat.floor_le hy)
      have hy_lt_p : y < (p : ℝ) := hno p hp'.2 hxp
      linarith
    exact Finset.mem_filter.mpr
      ⟨Finset.mem_Ioc.mpr ⟨hp'.1.1, hple⟩, hp'.2⟩
  have hle : Chebyshev.theta y ≤ Chebyshev.theta x := by
    unfold Chebyshev.theta
    refine Finset.sum_le_sum_of_subset_of_nonneg hsub ?_
    intro p hp hps
    have hp_prime : p.Prime := (Finset.mem_filter.mp hp).2
    have hp_two : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp_prime.two_le
    exact Real.log_nonneg (by linarith)
  linarith

/-- Interval form of the Chebyshev bridge: a strict increase of `θ` from `x`
to `x + d` gives a prime in `(x, x + d]`. -/
theorem hasPrimeIn_of_theta_gap {x d : ℝ} (hx : 0 ≤ x) (hd : 0 ≤ d)
    (h : Chebyshev.theta x < Chebyshev.theta (x + d)) : HasPrimeIn x d := by
  obtain ⟨p, hp, hxp, hpy⟩ := exists_prime_of_theta_lt (by linarith) h
  exact ⟨p, hp, hxp, hpy⟩

/-! ## Explicit Chebyshev bounds

These are project-local names for mathlib's explicit bounds.  They are useful
as stable imports for later layers; the proofs are mathlib's. -/

/-- Explicit upper bound `θ(x) ≤ log 4 · x` for `x ≥ 0`. -/
theorem theta_upper_explicit (x : ℝ) (hx : 0 ≤ x) :
    Chebyshev.theta x ≤ Real.log 4 * x :=
  Chebyshev.theta_le_log4_mul_x hx

/-- Explicit lower bound for `θ(n)`, `n : ℕ`. -/
theorem theta_lower_explicit (n : ℕ) :
    (n : ℝ) * Real.log 2 - Real.log ((n : ℝ) + 1) -
        2 * Real.sqrt (n : ℝ) * Real.log (n : ℝ) ≤ Chebyshev.theta (n : ℝ) :=
  Chebyshev.theta_ge n

/-- Explicit upper bound `ψ(x) ≤ log 4 · x + 2√x log x` for `x ≥ 1`. -/
theorem psi_upper_explicit (x : ℝ) (hx : 1 ≤ x) :
    Chebyshev.psi x ≤ Real.log 4 * x + 2 * Real.sqrt x * Real.log x :=
  Chebyshev.psi_le hx

/-- Explicit lower bound for `ψ(n)`, `n : ℕ`. -/
theorem psi_lower_explicit (n : ℕ) :
    (n : ℝ) * Real.log 2 - Real.log ((n : ℝ) + 1) ≤ Chebyshev.psi (n : ℝ) :=
  Chebyshev.psi_ge n

/-- Explicit lower bound for `π(n)`, from the Chebyshev `ψ` lower bound. -/
theorem pi_lower_explicit (n : ℕ) :
    ((n : ℝ) * Real.log 2 - Real.log ((n : ℝ) + 1)) / Real.log (n : ℝ) ≤
      (Nat.primeCounting n : ℝ) :=
  Chebyshev.pi_ge n

/-- Explicit upper bound for `π(⌊x⌋)`, for `x > 1`. -/
theorem pi_upper_explicit (x : ℝ) (hx : 1 < x) :
    (Nat.primeCounting ⌊x⌋₊ : ℝ) ≤
      Real.log 4 * x / Real.log (Real.sqrt x) + Real.sqrt x :=
  Chebyshev.pi_le_log4_mul_div hx

end Legendre

end
