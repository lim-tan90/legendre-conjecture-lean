/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaLogDerivative
public import Mathlib.Analysis.SumIntegralComparisons
public import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

/-!
# Explicit logarithmic-derivative bounds for every right half-plane

Original deductions using mathlib v4.35.0, commit
56a005855ea17e0b0958f73ec801ae140b0a1679 (Apache-2.0).
The sum/integral comparison is due to Kevin H. Wilson and Alastair Irving
(`Analysis/SumIntegralComparisons.lean`); the improper power integral is from
David Loeffler's `Analysis/SpecialFunctions/ImproperIntegrals.lean`.
The logarithm/power comparison and von Mangoldt identity are mathlib inputs.

The estimates apply to Re(s)≥1+ε with ε>0. They make no assertion to the left
of Re(s)=1 and do not prove a logarithmic zero-free region or Perron's formula.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex ArithmeticFunction
open scoped LSeries.notation

/-- Integral-test upper bound for a real power series, including n=0,1. -/
theorem tsum_nat_rpow_neg_le {p : ℝ} (hp : 1 < p) :
    (∑' n : ℕ, (n : ℝ) ^ (-p)) ≤ 1 + 1 / (p - 1) := by
  have hanti : AntitoneOn (fun x : ℝ ↦ x ^ (-p)) (Set.Ici 1) :=
    (Real.antitoneOn_rpow_Ioi_of_exponent_nonpos (by linarith)).mono
      (fun _ hx ↦ lt_of_lt_of_le zero_lt_one hx)
  have htail := AntitoneOn.tsum_comp_add_le_integral (f := fun x : ℝ ↦ x ^ (-p)) 1
    (by simpa only [Nat.cast_one] using hanti)
    (by simpa only [Nat.cast_one] using
      (integrableOn_Ioi_rpow_of_lt (a := -p) (by linarith) zero_lt_one))
    (fun x hx ↦ Real.rpow_nonneg (le_trans (by norm_num) hx.le) _)
  simp only [Nat.cast_one] at htail
  rw [integral_Ioi_rpow_of_lt (by linarith) zero_lt_one, Real.one_rpow] at htail
  have hsum : Summable (fun n : ℕ ↦ (n : ℝ) ^ (-p)) :=
    Real.summable_nat_rpow.mpr (by linarith)
  rw [← hsum.sum_add_tsum_nat_add 2]
  norm_num [Finset.sum_range_succ, Real.zero_rpow (by linarith : -p ≠ 0)]
  have hfrac : -(1 : ℝ) / (-p + 1) = 1 / (p - 1) := by
    field_simp [show p - 1 ≠ 0 by linarith, show -p + 1 ≠ 0 by linarith]
    ring
  rw [hfrac] at htail
  simpa [Nat.add_assoc] using add_le_add_left htail 1

/-- A summable power majorant for every von Mangoldt term at Re(s)=1+2a. -/
theorem vonMangoldt_term_one_add_two_mul_le {a : ℝ} (ha : 0 < a) (n : ℕ) :
    ‖LSeries.term (↗vonMangoldt) ((1 + 2 * a : ℝ) : ℂ) n‖ ≤
      (1 / a) * (n : ℝ) ^ (-(1 + a)) := by
  by_cases hn : n = 0
  · subst n
    rw [LSeries.term_zero, norm_zero, Nat.cast_zero]
    positivity
  · rw [LSeries.norm_term_eq, ite_eq_right hn]
    simp only [Complex.ofReal_re, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg vonMangoldt_nonneg]
    have hnpos : (0 : ℝ) < n := by exact_mod_cast Nat.pos_of_ne_zero hn
    have hcoeff : vonMangoldt n ≤ (n : ℝ) ^ a / a :=
      vonMangoldt_le_log.trans (Real.log_natCast_le_rpow_div n ha)
    calc
      vonMangoldt n / (n : ℝ) ^ (1 + 2 * a) ≤
          ((n : ℝ) ^ a / a) / (n : ℝ) ^ (1 + 2 * a) :=
        div_le_div_of_nonneg_right hcoeff (Real.rpow_nonneg hnpos.le _)
      _ = (1 / a) * (n : ℝ) ^ (a - (1 + 2 * a)) := by
        rw [Real.rpow_sub hnpos]
        ring
      _ = (1 / a) * (n : ℝ) ^ (-(1 + a)) := by ring_nf

/-- Closed-form bound for the absolutely convergent majorant. -/
theorem vonMangoldt_majorant_le {a : ℝ} (ha : 0 < a) :
    (∑' n : ℕ, ‖LSeries.term (↗vonMangoldt) ((1 + 2 * a : ℝ) : ℂ) n‖) ≤
      (1 / a) * (1 + 1 / a) := by
  have hsum := vonMangoldt_series_summable (s := ((1 + 2 * a : ℝ) : ℂ))
    (by simp only [Complex.ofReal_re]; linarith)
  have hp : 1 < 1 + a := by linarith
  have hpower : Summable (fun n : ℕ ↦ (n : ℝ) ^ (-(1 + a))) :=
    Real.summable_nat_rpow.mpr (by linarith)
  calc
    _ ≤ ∑' n : ℕ, (1 / a) * (n : ℝ) ^ (-(1 + a)) :=
      hsum.norm.tsum_le_tsum (vonMangoldt_term_one_add_two_mul_le ha) (hpower.mul_left _)
    _ = (1 / a) * ∑' n : ℕ, (n : ℝ) ^ (-(1 + a)) := tsum_mul_left
    _ ≤ (1 / a) * (1 + 1 / a) := by
      have h := tsum_nat_rpow_neg_le hp
      simp only [add_sub_cancel_left] at h
      exact mul_le_mul_of_nonneg_left h (by positivity)

/-- Explicit uniform estimate on every closed half-plane to the right of 1. -/
theorem norm_logDeriv_le_of_re_ge_one_add {ε : ℝ} (hε : 0 < ε) {s : ℂ}
    (hs : 1 + ε ≤ s.re) :
    ‖logDeriv riemannZeta s‖ ≤ (2 / ε) * (1 + 2 / ε) := by
  have ha : 0 < ε / 2 := by positivity
  have hbase : 1 < 1 + 2 * (ε / 2) := by linarith
  have h := (norm_logDeriv_le_majorant hbase (s := s) (by linarith)).trans
    (vonMangoldt_majorant_le ha)
  have hfrac : 1 / (ε / 2) = 2 / ε := by ring
  simpa only [hfrac] using h

/-- In the range 0<ε≤1, a simpler quadratic blow-up bound. -/
theorem norm_logDeriv_le_six_div_sq {ε : ℝ} (hε : 0 < ε) (hε₁ : ε ≤ 1)
    {s : ℂ} (hs : 1 + ε ≤ s.re) :
    ‖logDeriv riemannZeta s‖ ≤ 6 / ε ^ 2 := by
  apply (norm_logDeriv_le_of_re_ge_one_add hε hs).trans
  apply (le_div_iff₀ (sq_pos_of_pos hε)).mpr
  field_simp
  nlinarith

/-- Pointwise version expressed directly in the distance Re(s)-1. -/
theorem norm_logDeriv_le_re_sub_one {s : ℂ} (hs : 1 < s.re) :
    ‖logDeriv riemannZeta s‖ ≤
      (2 / (s.re - 1)) * (1 + 2 / (s.re - 1)) :=
  norm_logDeriv_le_of_re_ge_one_add (by linarith) (by linarith)

end Legendre.Zeta
