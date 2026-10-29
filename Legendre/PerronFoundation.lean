/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaPole
public import Mathlib.NumberTheory.LSeries.SumCoeff
public import Mathlib.NumberTheory.Chebyshev
public import Mathlib.Analysis.SpecialFunctions.Pow.Continuity

/-!
# Forward Abel representation and the weighted Perron pole

Reuses mathlib v4.35.0, commit 56a005855ea17e0b0958f73ec801ae140b0a1679
(Apache-2.0). The Abel integral interface is Xavier Roblot's
`NumberTheory/LSeries/SumCoeff.lean`; the linear Chebyshev bound and complex
power continuity are upstream inputs. Local deductions are recorded in
`docs/zeta-provenance.md`.

This is the forward Mellin/Abel representation, not Perron inversion or a
truncated contour formula. The weighted-pole result is a punctured-neighborhood
limit; it does not evaluate any contour integral.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology MeasureTheory
open scoped LSeries.notation

/-- Identify the partial sum convention used by Abel summation with ψ. -/
theorem vonMangoldt_partialSums_floor_eq_psi (t : ℝ) :
    (∑ k ∈ Finset.Icc 1 ⌊t⌋₊, ArithmeticFunction.vonMangoldt k) = Chebyshev.psi t := by
  unfold Chebyshev.psi
  congr 1

/-- The coefficient partial sums are O(n), by the proved Chebyshev bound. -/
theorem vonMangoldt_partialSums_isBigO :
    (fun n : ℕ ↦ ∑ k ∈ Finset.Icc 1 n, ArithmeticFunction.vonMangoldt k)
      =O[atTop] (fun n ↦ (n : ℝ) ^ (1 : ℝ)) := by
  apply Asymptotics.IsBigO.of_bound (Real.log 4 + 4)
  apply Filter.Eventually.of_forall
  intro n
  have h := vonMangoldt_partialSums_floor_eq_psi (n : ℝ)
  simp only [Nat.floor_natCast] at h
  rw [h]
  simp only [Real.norm_eq_abs, abs_of_nonneg (Chebyshev.psi_nonneg _), Real.rpow_one,
    abs_of_nonneg (show (0 : ℝ) ≤ (n : ℝ) from Nat.cast_nonneg n)]
  exact Chebyshev.psi_le_const_mul_self (Nat.cast_nonneg n)

/-- Complex-valued partial sums agree with the real Chebyshev function. -/
theorem vonMangoldt_partialSums_complex_eq_psi (t : ℝ) :
    (∑ k ∈ Finset.Icc 1 ⌊t⌋₊, (ArithmeticFunction.vonMangoldt k : ℂ)) =
      (Chebyshev.psi t : ℂ) := by
  exact_mod_cast vonMangoldt_partialSums_floor_eq_psi t

/-- An integrable scalar majorant for the Chebyshev Mellin kernel on t>1. -/
theorem norm_psi_mellin_integrand_le (s : ℂ) {t : ℝ} (ht : 1 < t) :
    ‖(Chebyshev.psi t : ℂ) * (t : ℂ) ^ (-(s + 1))‖ ≤
      (Real.log 4 + 4) * t ^ (-s.re) := by
  have htpos : 0 < t := lt_trans zero_lt_one ht
  rw [norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Chebyshev.psi_nonneg _), norm_cpow_eq_rpow_re_of_pos htpos]
  simp only [neg_re, add_re, one_re]
  have hpower : t * t ^ (-(s.re + 1)) = t ^ (-s.re) := by
    conv_lhs => lhs; rw [← Real.rpow_one t]
    rw [← Real.rpow_add htpos]
    congr 1
    ring
  calc
    Chebyshev.psi t * t ^ (-(s.re + 1)) ≤
        ((Real.log 4 + 4) * t) * t ^ (-(s.re + 1)) :=
      mul_le_mul_of_nonneg_right (Chebyshev.psi_le_const_mul_self htpos.le)
        (Real.rpow_nonneg htpos.le _)
    _ = (Real.log 4 + 4) * t ^ (-s.re) := by rw [mul_assoc, hpower]

/-- Absolute (Bochner) integrability of the forward Mellin kernel for Re(s)>1.
This rules out relying on the integral's default value for a divergent kernel. -/
theorem psi_mellin_integrable {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun t : ℝ ↦ (Chebyshev.psi t : ℂ) * (t : ℂ) ^ (-(s + 1)))
      (Set.Ioi 1) := by
  have hmajor := (integrableOn_Ioi_rpow_of_lt (a := -s.re) (by linarith) zero_lt_one).const_mul
    (Real.log 4 + 4)
  have hpsi : Measurable (fun t : ℝ ↦ (Chebyshev.psi t : ℂ)) :=
    continuous_ofReal.measurable.comp Chebyshev.psi_mono.measurable
  have hpow : ContinuousOn (fun t : ℝ ↦ (t : ℂ) ^ (-(s + 1))) (Set.Ioi 1) := by
    intro t ht
    exact (continuousAt_ofReal_cpow_const t (-(s + 1))
      (.inr (ne_of_gt (lt_trans zero_lt_one ht)))).continuousWithinAt
  apply hmajor.mono' (hpsi.aestronglyMeasurable.mul
    (hpow.aestronglyMeasurable measurableSet_Ioi))
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  exact norm_psi_mellin_integrand_le s ht

/-- Forward Abel representation of -ζ'/ζ, not an inversion formula. -/
theorem neg_logDeriv_eq_psi_integral {s : ℂ} (hs : 1 < s.re) :
    -logDeriv riemannZeta s =
      s * ∫ t : ℝ in Set.Ioi 1, (Chebyshev.psi t : ℂ) * (t : ℂ) ^ (-(s + 1)) := by
  rw [neg_logDeriv_eq_vonMangoldt_series hs]
  have h := LSeries_eq_mul_integral_of_nonneg ArithmeticFunction.vonMangoldt
    (r := 1) (by norm_num) hs vonMangoldt_partialSums_isBigO
    (fun _ ↦ ArithmeticFunction.vonMangoldt_nonneg)
  simpa only [LSeries, vonMangoldt_partialSums_complex_eq_psi] using h

/-- Weight appearing in the classical ψ-Perron integrand. -/
noncomputable def perronWeight (x : ℝ) (s : ℂ) : ℂ := (x : ℂ) ^ s / s

/-- The weighted logarithmic-derivative kernel. This definition alone is
not a statement of Perron inversion. -/
noncomputable def perronIntegrand (x : ℝ) (s : ℂ) : ℂ :=
  (-logDeriv riemannZeta s) * perronWeight x s

/-- At s=1 the analytic weight equals x. -/
theorem perronWeight_one (x : ℝ) : perronWeight x 1 = x := by
  simp [perronWeight]

/-- For x>0, the weight has no singularity at 1. -/
theorem perronWeight_continuousAt_one {x : ℝ} (hx : 0 < x) :
    ContinuousAt (perronWeight x) 1 := by
  exact (continuousAt_const_cpow (ofReal_ne_zero.mpr hx.ne')).div continuousAt_id (by norm_num)

/-- The coefficient of the pole at 1 in the weighted kernel is x. -/
theorem tendsto_sub_mul_perronIntegrand_at_one {x : ℝ} (hx : 0 < x) :
    Tendsto (fun s : ℂ ↦ (s - 1) * perronIntegrand x s)
      (𝓝[≠] 1) (𝓝 (x : ℂ)) := by
  have hw := (perronWeight_continuousAt_one hx).tendsto.mono_left
    (nhdsWithin_le_nhds : 𝓝[≠] (1 : ℂ) ≤ 𝓝 1)
  have h := tendsto_sub_mul_neg_logDeriv_at_one.mul hw
  simp only [perronWeight_one, one_mul] at h
  apply h.congr'
  filter_upwards [] with s
  simp only [perronIntegrand, mul_assoc]

end Legendre.Zeta
