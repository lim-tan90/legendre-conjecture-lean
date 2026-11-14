/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local actual large-value count for integer powers of short blocks.
Every powered piece uses the proved analytic Halasz estimate.
-/
module
public import Legendre.Layer4.HalaszScaledBlock
public import Legendre.Layer4.Arithmetic.PoweredBlockDecomposition

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- The coefficient amplitude is uniform in the input block and all powers k<=K. -/
theorem powered_block_uniform_amplitude (r K : ℕ) (η : ℝ) (hη : 0 < η) :
    ∃ C : ℝ, 0 < C ∧ ∀ a : ℕ → ℂ, ∀ U k : ℕ, 1 ≤ U → k ≤ K →
      (∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ (n.divisors.card : ℝ)^r) → ∀ n : ℕ,
      ‖((Powers.blockArithmeticCoefficient a U (2*U))^k) n‖ ≤
        C*((2 : ℝ)^K*(U : ℝ)^k)^η*(n.divisors.card : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Powers.bounded_powers_coefficients_subpower r K η hη
  refine ⟨C,hC,?_⟩
  intro a U k hU hk ha n
  by_cases hn : n = 0
  · subst n
    simp only [ArithmeticFunction.map_zero,norm_zero]
    positivity
  have hnp : 0 < n := Nat.pos_of_ne_zero hn
  have hD : (1 : ℝ) ≤ n.divisors.card := by
    exact_mod_cast Finset.card_pos.mpr ⟨1,Nat.one_mem_divisors.mpr hn⟩
  by_cases htop : (2*U)^k < n
  · rw [Powers.power_support _ (2*U) k (Powers.blockArithmeticCoefficient_support a U (2*U)) n htop,
      norm_zero]
    positivity
  · have hnU : (n : ℝ) ≤ (2 : ℝ)^K*(U : ℝ)^k := by
      have he : (n : ℝ) ≤ (2*(U : ℝ))^k := by exact_mod_cast (le_of_not_gt htop)
      rw [mul_pow] at he
      exact he.trans (mul_le_mul_of_nonneg_right
        (pow_le_pow_right₀ (by norm_num : (1 : ℝ) ≤ 2) hk) (by positivity))
    have hh := hb (Powers.blockArithmeticCoefficient a U (2*U))
      (Powers.blockArithmeticCoefficient_norm a U (2*U) r ha) k hk n hnp
    calc
      _ ≤ C*(n : ℝ)^η := hh
      _ ≤ C*((2 : ℝ)^K*(U : ℝ)^k)^η :=
        mul_le_mul_of_nonneg_left (Real.rpow_le_rpow (Nat.cast_nonneg n) hnU hη.le) hC.le
      _ ≤ _ := le_mul_of_one_le_right (by positivity) hD

/-- A bounded integer power gives an unconditional count with all losses explicit. -/
theorem halasz_powered_block_count {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (a : ℕ → ℂ) (U k : ℕ) (hU : 1 ≤ U) (hk : 1 ≤ k) (T σ W A : ℝ)
    (hT : 1 ≤ T) (hσ : 2/3 ≤ σ) (hσ1 : σ ≤ 1) (hW : 0 < W) (hA : 0 < A)
    (ht : ∀ i ∈ S, |t i| ≤ T) (hβ : ∀ i ∈ S, β i ∈ Icc σ 1)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (ha : ∀ n, ‖((Powers.blockArithmeticCoefficient a U (2*U))^k) n‖ ≤
      A*(n.divisors.card : ℝ))
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
      a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) :
    (S.card : ℝ) ≤ (k : ℝ)*
      (8*Oscillation.halaszCountConstant*(1+Real.log (2*(2*U : ℕ)^k+1))^15*
      (1+Real.log (2*T))*
        (((2*U : ℕ)^k : ℝ)^(2-2*σ)/(W^k/((k : ℝ)*A))^2+
          T*(U : ℝ)^((k : ℝ)*(4-6*σ))/(W^k/((k : ℝ)*A))^6)) := by
  classical
  let f := (Powers.blockArithmeticCoefficient a U (2*U))^k
  let W' := W^k/(k : ℝ)
  let B := fun j i => ∑ n ∈ Finset.Ioc (2^j*U^k) (2*(2^j*U^k)),
    f n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))
  let Q := fun j => S.filter (fun i => W' ≤ ‖B j i‖)
  have hkp : (0 : ℝ) < k := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hk)
  have hY : (2 : ℝ) ≤ ((2*U : ℕ)^k : ℝ) := by
    have h2U : (2 : ℕ) ≤ 2*U := by omega
    have hh := (le_self_pow₀ (show 1 ≤ 2*U by omega) (show k ≠ 0 by omega))
    exact_mod_cast h2U.trans hh
  have hsub : S ⊆ (Finset.range k).biUnion Q := by
    intro i hi
    obtain ⟨j,hj,hlarge⟩ := Powers.exists_large_powered_block a U k hU hk
      ((β i : ℂ)+(t i : ℂ)*I) W hW.le (hw i hi)
    exact Finset.mem_biUnion.mpr ⟨j,hj,Finset.mem_filter.mpr ⟨hi,hlarge⟩⟩
  have hcard : (S.card : ℝ) ≤ ∑ j ∈ Finset.range k, ((Q j).card : ℝ) := by
    exact_mod_cast (Finset.card_le_card hsub).trans Finset.card_biUnion_le
  have hblock (j : ℕ) (hj : j ∈ Finset.range k) :
      ((Q j).card : ℝ) ≤
      8*Oscillation.halaszCountConstant*(1+Real.log (2*(2*U : ℕ)^k+1))^15*
      (1+Real.log (2*T))*
        (((2*U : ℕ)^k : ℝ)^(2-2*σ)/(W^k/((k : ℝ)*A))^2+
          T*(U : ℝ)^((k : ℝ)*(4-6*σ))/(W^k/((k : ℝ)*A))^6) := by
    have hbase : U^k ≤ 2^j*U^k := Nat.le_mul_of_pos_left _ (by positivity)
    have htop : (2^j*U^k : ℕ) ≤ (2*U)^k := by
      rw [mul_pow]
      exact Nat.mul_le_mul_right _ (Nat.pow_le_pow_right (by norm_num) (Finset.mem_range.mp hj).le)
    have hh := halasz_scaled_divisor_block_count (Q j) t β (U^k) (2^j*U^k)
      (one_le_pow₀ hU) hbase (fun n => f n) T ((2*U : ℕ)^k) σ W' A hT hY
      (by exact_mod_cast htop) hσ hσ1 (div_pos (pow_pos hW k) hkp) hA
      (fun i hi => ht i (Finset.mem_filter.mp hi).1)
      (fun i hi => hβ i (Finset.mem_filter.mp hi).1)
      (fun i hi l hl hil => hs i (Finset.mem_filter.mp hi).1 l (Finset.mem_filter.mp hl).1 hil)
      (fun n _ => ha n) (fun i hi => (Finset.mem_filter.mp hi).2)
    have he : W'/A = W^k/((k : ℝ)*A) := by dsimp [W']; ring
    have hUpow : ((U^k : ℕ) : ℝ)^(4-6*σ) = (U : ℝ)^((k : ℝ)*(4-6*σ)) := by
      rw [Nat.cast_pow,←Real.rpow_natCast (U : ℝ) k,←Real.rpow_mul (Nat.cast_nonneg U)]
    rw [he,hUpow] at hh
    exact hh
  have hh := hcard.trans (Finset.sum_le_sum hblock)
  simpa only [Finset.sum_const,Finset.card_range,nsmul_eq_mul] using hh

end Legendre.Density.Moment
