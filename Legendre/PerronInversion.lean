/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronResidue
public import Mathlib.Analysis.Normed.Group.Tannery

/-!
# Perron inversion for the von Mangoldt series

Original deductions using mathlib v4.35.0 (Apache-2.0). A summable bound
uniform in nonnegative height permits passage from scalar inversion to
the coefficient-weighted series. The endpoint retains its half weight.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology
open scoped LSeries.notation

/-- A height-independent scalar bound, including the endpoint. -/
noncomputable def perronKernelBound (y σ : ℝ) : ℝ :=
  if y = 1 then 1 else (y ^ σ / |Real.log y|) * (2 + Real.pi) / (2 * Real.pi * σ)

/-- The scalar majorant is nonnegative on positive lines. -/
theorem perronKernelBound_nonneg {y σ : ℝ} (hy : 0 ≤ y) (hσ : 0 < σ) :
    0 ≤ perronKernelBound y σ := by
  unfold perronKernelBound
  split_ifs <;> positivity

/-- The endpoint has a uniform bound as well as the nonendpoint kernels. -/
theorem norm_truncatedPerronKernel_le_bound {y σ T : ℝ} (hy : 0 < y)
    (hσ : 0 < σ) (hT : 0 ≤ T) :
    ‖truncatedPerronKernel y σ T‖ ≤ perronKernelBound y σ := by
  by_cases hone : y = 1
  · subst y
    rw [truncatedPerronKernel_one hσ, norm_real, Real.norm_eq_abs,
      abs_of_nonneg (div_nonneg (Real.arctan_nonneg.mpr (div_nonneg hT hσ.le))
        Real.pi_pos.le)]
    simp only [perronKernelBound, ite_true]
    apply (div_le_iff₀ Real.pi_pos).mpr
    linarith [Real.arctan_lt_pi_div_two (T / σ), Real.pi_pos]
  · simpa only [perronKernelBound, ite_eq_right hone] using
      norm_truncatedPerronKernel_uniform_le hy hone hσ hT

/-- Far enough down the coefficient series, the logarithmic denominator is bounded away from zero. -/
theorem log_ratio_abs_ge_log_two {x : ℝ} (hx : 0 < x) {n : ℕ}
    (hn : 2 * x ≤ (n : ℝ)) : Real.log 2 ≤ |Real.log (x / n)| := by
  have hnpos : (0 : ℝ) < n := by linarith
  have hratio : 0 < x / n := div_pos hx hnpos
  have hhalf : x / n ≤ (2 : ℝ)⁻¹ := (div_le_iff₀ hnpos).mpr (by linarith)
  have hlog := Real.log_le_log hratio hhalf
  rw [Real.log_inv] at hlog
  have htwo : 0 < Real.log 2 := Real.log_pos (by norm_num)
  rw [abs_of_nonpos (by linarith : Real.log (x / n) ≤ 0)]
  linarith

/-- Away from the finite initial segment, the scalar majorant is a constant times n^(-σ). -/
theorem perronKernelBound_ratio_le {x σ : ℝ} (hx : 0 < x) (hσ : 0 < σ)
    {n : ℕ} (hn : 2 * x ≤ (n : ℝ)) :
    perronKernelBound (x / n) σ ≤
      (1 / (n : ℝ) ^ σ) * (x ^ σ / Real.log 2 * (2 + Real.pi) / (2 * Real.pi * σ)) := by
  have hnpos : (0 : ℝ) < n := by linarith
  have hratio : x / n < 1 := (div_lt_one hnpos).mpr (by linarith)
  have hlog := log_ratio_abs_ge_log_two hx hn
  have htwo : 0 < Real.log 2 := Real.log_pos (by norm_num)
  rw [perronKernelBound, ite_eq_right hratio.ne, Real.div_rpow hx.le (Nat.cast_nonneg n)]
  calc
    _ ≤ (x ^ σ / (n : ℝ) ^ σ / Real.log 2) * (2 + Real.pi) /
        (2 * Real.pi * σ) :=
      div_le_div_of_nonneg_right
        (mul_le_mul_of_nonneg_right
          (div_le_div_of_nonneg_left (by positivity) htwo hlog) (by positivity))
        (by positivity)
    _ = _ := by ring

/-- A summable coefficient majorant, uniform in all nonnegative heights. -/
theorem summable_vonMangoldt_perronKernelBound {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) :
    Summable (fun n : ℕ ↦ ‖(ArithmeticFunction.vonMangoldt n : ℂ)‖ *
      perronKernelBound (x / n) σ) := by
  let C := x ^ σ / Real.log 2 * (2 + Real.pi) / (2 * Real.pi * σ)
  have hbase := (vonMangoldt_series_summable (s := (σ : ℂ)) (by simpa using hσ)).norm
  apply (hbase.mul_right C).of_norm_bounded_eventually_nat
  obtain ⟨N, hN⟩ := exists_nat_ge (2 * x)
  filter_upwards [eventually_ge_atTop N] with n hn
  have hnlarge : 2 * x ≤ (n : ℝ) := hN.trans (by exact_mod_cast hn)
  have hnpos : (0 : ℝ) < n := by linarith
  have hnzero : n ≠ 0 := by exact_mod_cast hnpos.ne'
  rw [Real.norm_eq_abs, abs_of_nonneg
    (mul_nonneg (norm_nonneg _) (perronKernelBound_nonneg
      (div_nonneg hx.le (Nat.cast_nonneg n)) (by linarith))),
    LSeries.norm_term_eq, ite_eq_right hnzero]
  simp only [ofReal_re]
  calc
    _ ≤ ‖(ArithmeticFunction.vonMangoldt n : ℂ)‖ * ((1 / (n : ℝ) ^ σ) * C) :=
      mul_le_mul_of_nonneg_left (perronKernelBound_ratio_le hx (by linarith) hnlarge)
        (norm_nonneg _)
    _ = _ := by ring

/-- The limit can be passed through the von Mangoldt series. -/
theorem tendsto_truncatedPerron_tsum {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) :
    Tendsto (fun T : ℝ ↦ truncatedPerron x σ T) atTop
      (𝓝 (∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n))) := by
  have hlim (n : ℕ) : Tendsto (fun T : ℝ ↦
      (ArithmeticFunction.vonMangoldt n : ℂ) * truncatedPerronKernel (x / n) σ T)
      atTop (𝓝 ((ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n))) := by
    by_cases hn : n = 0
    · subst n
      simp
    · exact tendsto_const_nhds.mul (tendsto_truncatedPerronKernel
        (div_pos hx (Nat.cast_pos.mpr (Nat.pos_of_ne_zero hn))) (by linarith))
  have hb : ∀ᶠ T : ℝ in atTop, ∀ n : ℕ,
      ‖(ArithmeticFunction.vonMangoldt n : ℂ) * truncatedPerronKernel (x / n) σ T‖ ≤
        ‖(ArithmeticFunction.vonMangoldt n : ℂ)‖ * perronKernelBound (x / n) σ := by
    filter_upwards [eventually_ge_atTop (0 : ℝ)] with T hT n
    by_cases hn : n = 0
    · subst n
      simp
    · rw [norm_mul]
      exact mul_le_mul_of_nonneg_left (norm_truncatedPerronKernel_le_bound
        (div_pos hx (Nat.cast_pos.mpr (Nat.pos_of_ne_zero hn))) (by linarith) hT)
        (norm_nonneg _)
  have h := tendsto_tsum_of_dominated_convergence
    (summable_vonMangoldt_perronKernelBound hx hσ) hlim hb
  simpa only [← truncatedPerron_eq_tsum_kernels hx hσ] using h

/-- Beyond x, the limiting coefficient is zero, including the zero-index convention. -/
theorem vonMangoldt_mul_scalarPerronValue_eq_zero {x : ℝ} {n : ℕ}
    (hn : x < (n : ℝ)) :
    (ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n) = 0 := by
  by_cases hnzero : n = 0
  · subst n
    simp
  · have hnpos : (0 : ℝ) < n := Nat.cast_pos.mpr (Nat.pos_of_ne_zero hnzero)
    simp [scalarPerronValue, (div_lt_one hnpos).mpr hn]

/-- The limiting series is in fact a finite half-weighted sum. -/
theorem vonMangoldt_scalarPerronValue_tsum_eq_sum {x : ℝ} (hx : 0 < x) :
    (∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n)) =
      ∑ n ∈ Finset.Icc 0 ⌊x⌋₊,
        (ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n) := by
  apply tsum_eq_sum
  intro n hn
  have hnx : ⌊x⌋₊ < n := by simpa using hn
  exact vonMangoldt_mul_scalarPerronValue_eq_zero
    (lt_of_not_ge (fun h ↦ (not_le.mpr hnx) ((Nat.le_floor_iff hx.le).mpr h)))

/-- At or below x, the only correction to full coefficient weight is half the endpoint. -/
theorem vonMangoldt_mul_scalarPerronValue_eq {x : ℝ} {n : ℕ} (hn : (n : ℝ) ≤ x) :
    (ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n) =
      (ArithmeticFunction.vonMangoldt n : ℂ) -
        if (n : ℝ) = x then (ArithmeticFunction.vonMangoldt n : ℂ) / 2 else 0 := by
  by_cases hnzero : n = 0
  · subst n
    simp
  · have hnpos : (0 : ℝ) < n := Nat.cast_pos.mpr (Nat.pos_of_ne_zero hnzero)
    by_cases heq : (n : ℝ) = x
    · rw [← heq]
      simp only [div_self hnpos.ne', scalarPerronValue, lt_self_iff_false, ite_false,
        ite_true]
      ring
    · have hratio : 1 < x / n := (one_lt_div hnpos).mpr (lt_of_le_of_ne hn heq)
      simp only [scalarPerronValue, ite_eq_right (not_lt.mpr hratio.le),
        ite_eq_right hratio.ne', mul_one, ite_eq_right heq, sub_zero]

/-- The coefficient-weighted step sum is ψ, with its integer endpoint counted only halfway. -/
theorem vonMangoldt_scalarPerronValue_tsum_eq_psi {x : ℝ} (hx : 0 < x) :
    (∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n)) =
      (Chebyshev.psi x : ℂ) -
        if (⌊x⌋₊ : ℝ) = x then (ArithmeticFunction.vonMangoldt ⌊x⌋₊ : ℂ) / 2 else 0 := by
  classical
  rw [vonMangoldt_scalarPerronValue_tsum_eq_sum hx]
  have heq : (∑ n ∈ Finset.Icc 0 ⌊x⌋₊,
      (ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n)) =
      ∑ n ∈ Finset.Icc 0 ⌊x⌋₊, ((ArithmeticFunction.vonMangoldt n : ℂ) -
        if (n : ℝ) = x then (ArithmeticFunction.vonMangoldt n : ℂ) / 2 else 0) := by
    apply Finset.sum_congr rfl
    intro n hn
    exact vonMangoldt_mul_scalarPerronValue_eq
      ((Nat.le_floor_iff hx.le).mp (Finset.mem_Icc.mp hn).2)
  rw [heq, Finset.sum_sub_distrib]
  have hpsi : (∑ n ∈ Finset.Icc 0 ⌊x⌋₊, (ArithmeticFunction.vonMangoldt n : ℂ)) =
      (Chebyshev.psi x : ℂ) := by
    exact_mod_cast (Chebyshev.psi_eq_sum_Icc x).symm
  rw [hpsi]
  congr 1
  by_cases hfloor : (⌊x⌋₊ : ℝ) = x
  · have htest (n : ℕ) : ((n : ℝ) = x) ↔ n = ⌊x⌋₊ := by
      constructor
      · intro he
        exact Nat.cast_injective (he.trans hfloor.symm)
      · rintro rfl
        exact hfloor
    simp only [htest, Finset.sum_ite_eq', Finset.mem_Icc, Nat.zero_le, le_refl,
      and_self, ite_true]
  · rw [ite_eq_right hfloor]
    apply Finset.sum_eq_zero
    intro n hn
    have hne : (n : ℝ) ≠ x := by
      intro he
      apply hfloor
      rw [← he, Nat.floor_natCast]
    exact ite_eq_right hne

/-- Perron inversion on every vertical line to the right of 1, with half weight at integers. -/
theorem tendsto_truncatedPerron {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) :
    Tendsto (fun T : ℝ ↦ truncatedPerron x σ T) atTop
      (𝓝 ((Chebyshev.psi x : ℂ) -
        if (⌊x⌋₊ : ℝ) = x then (ArithmeticFunction.vonMangoldt ⌊x⌋₊ : ℂ) / 2 else 0)) := by
  simpa only [vonMangoldt_scalarPerronValue_tsum_eq_psi hx] using
    tendsto_truncatedPerron_tsum hx hσ

/-- Away from integer endpoints, the Perron integral converges to ψ itself. -/
theorem tendsto_truncatedPerron_of_not_nat {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ)
    (hxnat : ∀ n : ℕ, (n : ℝ) ≠ x) :
    Tendsto (fun T : ℝ ↦ truncatedPerron x σ T) atTop (𝓝 (Chebyshev.psi x : ℂ)) := by
  simpa only [ite_eq_right (hxnat ⌊x⌋₊), sub_zero] using tendsto_truncatedPerron hx hσ

/-- At a positive integer, the coefficient at that endpoint has half weight. -/
theorem tendsto_truncatedPerron_nat {σ : ℝ} (hσ : 1 < σ) {m : ℕ} (hm : 0 < m) :
    Tendsto (fun T : ℝ ↦ truncatedPerron m σ T) atTop
      (𝓝 ((Chebyshev.psi m : ℂ) - (ArithmeticFunction.vonMangoldt m : ℂ) / 2)) := by
  simpa only [Nat.floor_natCast, ite_true] using
    tendsto_truncatedPerron (Nat.cast_pos.mpr hm) hσ

end Legendre.Zeta
