/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronInversion

/-!
# Finite-height error bounds for Perron inversion

Original deductions from mathlib v4.35.0 (Apache-2.0). Integration by parts
on a positive-height interval gives a quantitative scalar tail bound.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Topology
open scoped ComplexConjugate
open scoped LSeries.notation

/-- The reciprocal-square tail has an elementary exact integral. -/
theorem integral_perron_inv_sq {T U : ℝ} (hT : 0 < T) (hTU : T ≤ U) :
    (∫ t : ℝ in T..U, 1 / t ^ 2) = 1 / T - 1 / U := by
  have hn : (0 : ℝ) ∉ Set.uIcc T U := by
    rw [Set.uIcc_of_le hTU]
    intro h
    linarith [h.1]
  have he : (fun t : ℝ ↦ 1 / t ^ 2) = (fun t : ℝ ↦ t ^ (-2 : ℝ)) := by
    funext t
    simp [one_div]
  rw [he, integral_rpow (.inr ⟨by norm_num, hn⟩)]
  norm_num [Real.rpow_neg_one]
  ring

/-- Height decay for either boundary term from integration by parts. -/
theorem norm_perronTail_boundary_height_le {y σ t : ℝ} (hy : 0 < y) (ht : 0 < t) :
    ‖(1 / ((σ : ℂ) + (t : ℂ) * I)) * perronOscPrimitive y σ t‖ ≤
      (y ^ σ / |Real.log y|) / t := by
  rw [norm_mul, norm_div, norm_one, norm_perronOscPrimitive hy]
  have hn : t ≤ ‖(σ : ℂ) + (t : ℂ) * I‖ := by
    simpa [abs_of_pos ht] using abs_im_le_norm ((σ : ℂ) + (t : ℂ) * I)
  calc
    _ ≤ (1 / t) * (y ^ σ / |Real.log y|) :=
      mul_le_mul_of_nonneg_right (one_div_le_one_div_of_le ht hn) (by positivity)
    _ = _ := by ring

/-- Quantitative remainder bound on an interval of positive heights. -/
theorem norm_integral_perronTail_remainder_height_le {y σ T U : ℝ} (hy : 0 < y)
    (hT : 0 < T) (hTU : T ≤ U) :
    ‖∫ t : ℝ in T..U, perronReciprocalDeriv σ t * perronOscPrimitive y σ t‖ ≤
      (y ^ σ / |Real.log y|) * (1 / T - 1 / U) := by
  let C := y ^ σ / |Real.log y|
  have hg : ContinuousOn (fun t : ℝ ↦ C * (1 / t ^ 2)) (Set.uIcc T U) := by
    apply continuousOn_const.mul
    apply continuousOn_const.div (continuousOn_id.pow 2)
    intro t ht
    apply pow_ne_zero
    change t ≠ 0
    have htT : T ≤ t := by simpa only [min_eq_left hTU] using ht.1
    exact (hT.trans_le htT).ne'
  have hb := intervalIntegral.norm_integral_le_of_norm_le (a := T) (b := U) hTU
    (Filter.Eventually.of_forall (fun t (ht : t ∈ Set.Ioc T U) ↦
      show ‖perronReciprocalDeriv σ t * perronOscPrimitive y σ t‖ ≤ C * (1 / t ^ 2) from by
        rw [norm_mul, norm_perronOscPrimitive hy]
        exact (mul_le_mul_of_nonneg_right
          (norm_perronReciprocalDeriv_le (σ := σ) (hT.trans ht.1)) (by positivity)).trans_eq
            (mul_comm _ _)))
    (hg.intervalIntegrable (μ := volume))
  rw [intervalIntegral.integral_const_mul, integral_perron_inv_sq hT hTU] at hb
  exact hb

/-- A positive-height tail interval is uniformly small, independently of its upper endpoint. -/
theorem norm_integral_perronWeight_tail_le {y σ T U : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (hσ : 0 < σ) (hT : 0 < T) (hTU : T ≤ U) :
    ‖∫ t : ℝ in T..U, perronWeight y ((σ : ℂ) + (t : ℂ) * I)‖ ≤
      2 * (y ^ σ / |Real.log y|) / T := by
  rw [integral_perronWeight_parts hy hyone hσ]
  calc
    _ ≤ (y ^ σ / |Real.log y|) / U + (y ^ σ / |Real.log y|) / T +
        (y ^ σ / |Real.log y|) * (1 / T - 1 / U) :=
      (norm_sub_le _ _).trans (add_le_add
        ((norm_sub_le _ _).trans (add_le_add
          (norm_perronTail_boundary_height_le hy (hT.trans_le hTU))
          (norm_perronTail_boundary_height_le hy hT)))
        (norm_integral_perronTail_remainder_height_le hy hT hTU))
    _ = _ := by ring

/-- Finite differences of scalar kernels satisfy a quantitative tail bound. -/
theorem norm_truncatedPerronKernel_sub_le {y σ T U : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (hσ : 0 < σ) (hT : 0 < T) (hTU : T ≤ U) :
    ‖truncatedPerronKernel y σ U - truncatedPerronKernel y σ T‖ ≤
      2 * (y ^ σ / |Real.log y|) / (Real.pi * T) := by
  let f := fun t : ℝ ↦ perronWeight y ((σ : ℂ) + (t : ℂ) * I)
  have hc := perronWeight_vertical_continuous hy hσ
  have hadd : (∫ t : ℝ in 0..U, f t) - (∫ t : ℝ in 0..T, f t) =
      ∫ t : ℝ in T..U, f t := by
    rw [sub_eq_iff_eq_add, add_comm]
    exact (intervalIntegral.integral_add_adjacent_intervals
      (hc.intervalIntegrable (μ := volume) 0 T)
      (hc.intervalIntegrable (μ := volume) T U)).symm
  have he : truncatedPerronKernel y σ U - truncatedPerronKernel y σ T =
      (1 / (2 * Real.pi) : ℂ) * (conj (∫ t : ℝ in T..U, f t) +
        ∫ t : ℝ in T..U, f t) := by
    simp only [truncatedPerronKernel, integral_perronWeight_symmetric hy hσ]
    rw [← hadd, map_sub]
    dsimp [f]
    ring
  rw [he, norm_mul]
  have hn : ‖(1 / (2 * Real.pi) : ℂ)‖ = 1 / (2 * Real.pi) := by
    simp [abs_of_pos Real.pi_pos]
  rw [hn]
  calc
    _ ≤ (1 / (2 * Real.pi)) * (2 * (2 * (y ^ σ / |Real.log y|) / T)) := by
      apply mul_le_mul_of_nonneg_left _ (by positivity)
      apply (norm_add_le _ _).trans
      rw [norm_conj]
      have hb := norm_integral_perronWeight_tail_le hy hyone hσ hT hTU
      dsimp [f]
      linarith
    _ = _ := by ring

/-- Quantitative scalar inversion away from the endpoint. -/
theorem norm_truncatedPerronKernel_sub_value_le {y σ T : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (hσ : 0 < σ) (hT : 0 < T) :
    ‖truncatedPerronKernel y σ T - scalarPerronValue y‖ ≤
      2 * (y ^ σ / |Real.log y|) / (Real.pi * T) := by
  rw [norm_sub_rev]
  apply le_of_tendsto ((tendsto_truncatedPerronKernel hy hσ).sub_const
    (truncatedPerronKernel y σ T)).norm
  filter_upwards [eventually_ge_atTop T] with U hU
  exact norm_truncatedPerronKernel_sub_le hy hyone hσ hT hU

/-- Coefficient of the scalar O(1/T) error, with a separate endpoint value. -/
noncomputable def perronScalarError (y σ : ℝ) : ℝ :=
  if y = 1 then σ / Real.pi else 2 * (y ^ σ / |Real.log y|) / Real.pi

/-- The scalar error coefficient is nonnegative. -/
theorem perronScalarError_nonneg {y σ : ℝ} (hy : 0 ≤ y) (hσ : 0 < σ) :
    0 ≤ perronScalarError y σ := by
  unfold perronScalarError
  split_ifs <;> positivity

/-- The scalar O(1/T) bound includes y=1, using its exact arctangent value. -/
theorem norm_truncatedPerronKernel_error_le {y σ T : ℝ} (hy : 0 < y) (hσ : 0 < σ)
    (hT : 0 < T) :
    ‖truncatedPerronKernel y σ T - scalarPerronValue y‖ ≤ perronScalarError y σ / T := by
  by_cases hone : y = 1
  · subst y
    simpa [perronScalarError, scalarPerronValue, div_div] using
      norm_truncatedPerronKernel_one_sub_half_le hσ hT
  · simpa only [perronScalarError, ite_eq_right hone, div_div] using
      norm_truncatedPerronKernel_sub_value_le hy hone hσ hT

/-- Comparison with the previously established summable kernel majorant. -/
theorem perronScalarError_le_bound {y σ : ℝ} (hy : 0 ≤ y) (hσ : 0 < σ) :
    perronScalarError y σ ≤
      perronKernelBound y σ * (4 * σ / (2 + Real.pi) + σ / Real.pi) := by
  have hp : (0 : ℝ) < 2 + Real.pi := by positivity
  by_cases hone : y = 1
  · simp only [perronScalarError, perronKernelBound, ite_eq_left hone, one_mul]
    have : 0 ≤ 4 * σ / (2 + Real.pi) := by positivity
    linarith
  · simp only [perronScalarError, perronKernelBound, ite_eq_right hone]
    calc
      _ = ((y ^ σ / |Real.log y|) * (2 + Real.pi) / (2 * Real.pi * σ)) *
          (4 * σ / (2 + Real.pi)) := by field_simp; ring
      _ ≤ _ := mul_le_mul_of_nonneg_left
        (le_add_of_nonneg_right (by positivity)) (by positivity)

/-- Summability of the explicit error coefficients, before their sum is used. -/
theorem summable_vonMangoldt_perronScalarError {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) :
    Summable (fun n : ℕ ↦ ‖(ArithmeticFunction.vonMangoldt n : ℂ)‖ *
      perronScalarError (x / n) σ) := by
  apply ((summable_vonMangoldt_perronKernelBound hx hσ).mul_right
    (4 * σ / (2 + Real.pi) + σ / Real.pi)).of_nonneg_of_le
  · intro n
    exact mul_nonneg (norm_nonneg _) (perronScalarError_nonneg
      (div_nonneg hx.le (Nat.cast_nonneg n)) (by linarith))
  · intro n
    simpa only [mul_assoc] using mul_le_mul_of_nonneg_left
      (perronScalarError_le_bound (div_nonneg hx.le (Nat.cast_nonneg n))
        (by linarith : 0 < σ))
        (norm_nonneg _)

/-- Explicit convergent series controlling the fixed-x finite-height Perron error. -/
noncomputable def perronErrorConstant (x σ : ℝ) : ℝ :=
  ∑' n : ℕ, ‖(ArithmeticFunction.vonMangoldt n : ℂ)‖ * perronScalarError (x / n) σ

/-- The error constant is nonnegative. -/
theorem perronErrorConstant_nonneg {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) :
    0 ≤ perronErrorConstant x σ := by
  apply tsum_nonneg
  intro n
  exact mul_nonneg (norm_nonneg _) (perronScalarError_nonneg
    (div_nonneg hx.le (Nat.cast_nonneg n)) (by linarith))

/-- Finite Perron series are absolutely summable using the uniform kernel bound. -/
theorem summable_vonMangoldt_truncatedPerronKernel {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ)
    (hT : 0 ≤ T) : Summable (fun n : ℕ ↦
      (ArithmeticFunction.vonMangoldt n : ℂ) * truncatedPerronKernel (x / n) σ T) := by
  apply (summable_vonMangoldt_perronKernelBound hx hσ).of_norm_bounded
  intro n
  by_cases hn : n = 0
  · subst n
    simp
  · rw [norm_mul]
    exact mul_le_mul_of_nonneg_left (norm_truncatedPerronKernel_le_bound
      (div_pos hx (Nat.cast_pos.mpr (Nat.pos_of_ne_zero hn))) (by linarith) hT)
      (norm_nonneg _)

/-- The limiting Perron coefficient series has finite support, hence is summable. -/
theorem summable_vonMangoldt_scalarPerronValue {x : ℝ} (hx : 0 < x) :
    Summable (fun n : ℕ ↦
      (ArithmeticFunction.vonMangoldt n : ℂ) * scalarPerronValue (x / n)) := by
  apply (hasSum_sum_of_ne_finset_zero (s := Finset.Icc 0 ⌊x⌋₊) ?_).summable
  intro n hn
  have hnx : ⌊x⌋₊ < n := by simpa using hn
  exact vonMangoldt_mul_scalarPerronValue_eq_zero
    (lt_of_not_ge (fun h ↦ (not_le.mpr hnx) ((Nat.le_floor_iff hx.le).mpr h)))

/-- A truncated Perron formula with an explicit O(1/T) bound, for every positive x.
The constant is a proved convergent series and includes the half-weight endpoint. -/
theorem norm_truncatedPerron_sub_psi_le {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ) (hT : 0 < T) :
    ‖truncatedPerron x σ T - ((Chebyshev.psi x : ℂ) -
      if (⌊x⌋₊ : ℝ) = x then (ArithmeticFunction.vonMangoldt ⌊x⌋₊ : ℂ) / 2 else 0)‖ ≤
        perronErrorConstant x σ / T := by
  let a := fun n : ℕ ↦ (ArithmeticFunction.vonMangoldt n : ℂ)
  let b := fun n : ℕ ↦ a n * (truncatedPerronKernel (x / n) σ T - scalarPerronValue (x / n))
  have hb (n : ℕ) : ‖b n‖ ≤ ‖a n‖ * perronScalarError (x / n) σ / T := by
    by_cases hn : n = 0
    · subst n
      simp [b, a]
    · dsimp [b]
      rw [norm_mul, mul_div_assoc]
      exact mul_le_mul_of_nonneg_left (norm_truncatedPerronKernel_error_le
        (div_pos hx (Nat.cast_pos.mpr (Nat.pos_of_ne_zero hn))) (by linarith) hT)
        (norm_nonneg _)
  have hmajor := (summable_vonMangoldt_perronScalarError hx hσ).div_const T
  have hsumb : Summable (fun n ↦ ‖b n‖) := hmajor.of_nonneg_of_le (fun n ↦ norm_nonneg _) hb
  have heq : truncatedPerron x σ T - ((Chebyshev.psi x : ℂ) -
      if (⌊x⌋₊ : ℝ) = x then (ArithmeticFunction.vonMangoldt ⌊x⌋₊ : ℂ) / 2 else 0) =
      ∑' n : ℕ, b n := by
    rw [truncatedPerron_eq_tsum_kernels hx hσ, ← vonMangoldt_scalarPerronValue_tsum_eq_psi hx,
      ← (summable_vonMangoldt_truncatedPerronKernel hx hσ hT.le).tsum_sub
        (summable_vonMangoldt_scalarPerronValue hx)]
    apply tsum_congr
    intro n
    dsimp [b, a]
    ring
  rw [heq]
  calc
    _ ≤ ∑' n : ℕ, ‖b n‖ := norm_tsum_le_tsum_norm hsumb
    _ ≤ ∑' n : ℕ, ‖a n‖ * perronScalarError (x / n) σ / T := hsumb.tsum_le_tsum hb hmajor
    _ = _ := by rw [tsum_div_const]; rfl

/-- A closed-form bound for the full coefficient Dirichlet majorant. -/
theorem vonMangoldt_dirichlet_norm_sum_le {σ : ℝ} (hσ : 1 < σ) :
    (∑' n : ℕ, ‖LSeries.term (↗ArithmeticFunction.vonMangoldt) (σ : ℂ) n‖) ≤
      (2 / (σ - 1)) * (1 + 2 / (σ - 1)) := by
  have h := vonMangoldt_majorant_le (a := (σ - 1) / 2) (by linarith)
  have he : 1 + 2 * ((σ - 1) / 2) = σ := by ring
  simpa only [he, show 1 / ((σ - 1) / 2) = 2 / (σ - 1) by
    field_simp] using h

/-- Explicit comparison for the error series after its finite initial segment. -/
theorem vonMangoldt_perronScalarError_tail_le {x σ : ℝ} (hx : 0 < x)
    {n : ℕ} (hn : 2 * x ≤ (n : ℝ)) :
    ‖(ArithmeticFunction.vonMangoldt n : ℂ)‖ * perronScalarError (x / n) σ ≤
      ‖LSeries.term (↗ArithmeticFunction.vonMangoldt) (σ : ℂ) n‖ *
        (2 * x ^ σ / (Real.pi * Real.log 2)) := by
  have hnpos : (0 : ℝ) < n := by linarith
  have hnzero : n ≠ 0 := by exact_mod_cast hnpos.ne'
  have hratio : x / n < 1 := (div_lt_one hnpos).mpr (by linarith)
  have htwo : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hlog := log_ratio_abs_ge_log_two hx hn
  have hb : perronScalarError (x / n) σ ≤
      (1 / (n : ℝ) ^ σ) * (2 * x ^ σ / (Real.pi * Real.log 2)) := by
    rw [perronScalarError, ite_eq_right hratio.ne,
      Real.div_rpow hx.le (Nat.cast_nonneg n)]
    calc
      _ ≤ 2 * (x ^ σ / (n : ℝ) ^ σ / Real.log 2) / Real.pi :=
        div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left
          (div_le_div_of_nonneg_left (by positivity) htwo hlog) (by norm_num))
          Real.pi_pos.le
      _ = _ := by ring
  rw [LSeries.norm_term_eq, ite_eq_right hnzero]
  simp only [ofReal_re]
  exact (mul_le_mul_of_nonneg_left hb (norm_nonneg _)).trans_eq (by ring)

/-- A finite, explicit upper bound: exceptional coefficients plus a closed Dirichlet tail bound. -/
noncomputable def perronErrorUpper (x σ : ℝ) : ℝ :=
  (∑ n ∈ Finset.range (⌊2 * x⌋₊ + 1), ‖(ArithmeticFunction.vonMangoldt n : ℂ)‖ *
    perronScalarError (x / n) σ) +
    (2 * x ^ σ / (Real.pi * Real.log 2)) * ((2 / (σ - 1)) * (1 + 2 / (σ - 1)))

/-- The convergent-series error constant is bounded by the finite explicit expression. -/
theorem perronErrorConstant_le_upper {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) :
    perronErrorConstant x σ ≤ perronErrorUpper x σ := by
  let N := ⌊2 * x⌋₊ + 1
  let C := 2 * x ^ σ / (Real.pi * Real.log 2)
  let f := fun n : ℕ ↦ ‖LSeries.term (↗ArithmeticFunction.vonMangoldt) (σ : ℂ) n‖
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hf : Summable f :=
    (vonMangoldt_series_summable (s := (σ : ℂ)) (by simpa using hσ)).norm
  have hshift : Summable (fun n : ℕ ↦ f (n + N)) := (summable_nat_add_iff N).mpr hf
  have hpart : (∑' n : ℕ, f (n + N)) ≤ ∑' n : ℕ, f n := by
    have he := hf.sum_add_tsum_nat_add N
    have hp : 0 ≤ ∑ n ∈ Finset.range N, f n := Finset.sum_nonneg (fun _ _ ↦ norm_nonneg _)
    linarith
  have herr := summable_vonMangoldt_perronScalarError hx hσ
  rw [perronErrorConstant, ← herr.sum_add_tsum_nat_add N]
  change _ ≤ (∑ n ∈ Finset.range N, ‖(ArithmeticFunction.vonMangoldt n : ℂ)‖ *
    perronScalarError (x / n) σ) + C * ((2 / (σ - 1)) * (1 + 2 / (σ - 1)))
  apply add_le_add le_rfl
  calc
    _ ≤ ∑' n : ℕ, f (n + N) * C := by
      apply ((summable_nat_add_iff N).mpr herr).tsum_le_tsum _ (hshift.mul_right C)
      intro n
      apply vonMangoldt_perronScalarError_tail_le hx
      have hN : 2 * x < (N : ℝ) := by
        simpa only [N, Nat.cast_add, Nat.cast_one] using Nat.lt_floor_add_one (2 * x)
      have hn : (N : ℝ) ≤ (n + N : ℕ) := by exact_mod_cast Nat.le_add_left N n
      linarith
    _ = (∑' n : ℕ, f (n + N)) * C := tsum_mul_right
    _ ≤ (∑' n : ℕ, f n) * C := mul_le_mul_of_nonneg_right hpart hC
    _ ≤ _ := by
      rw [mul_comm]
      exact mul_le_mul_of_nonneg_left (vonMangoldt_dirichlet_norm_sum_le hσ) hC

/-- Finite-height Perron error with a finite explicit coefficient bound. -/
theorem norm_truncatedPerron_sub_psi_le_upper {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ)
    (hT : 0 < T) :
    ‖truncatedPerron x σ T - ((Chebyshev.psi x : ℂ) -
      if (⌊x⌋₊ : ℝ) = x then (ArithmeticFunction.vonMangoldt ⌊x⌋₊ : ℂ) / 2 else 0)‖ ≤
        perronErrorUpper x σ / T :=
  (norm_truncatedPerron_sub_psi_le hx hσ hT).trans
    (div_le_div_of_nonneg_right (perronErrorConstant_le_upper hx hσ) hT.le)

end Legendre.Zeta
