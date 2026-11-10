/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local bounded-coefficient specialization of the analytic large-value bound.
-/
module
public import Legendre.Layer4.Exponential.BoundedCriticalBlocks

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

/-- The critical block energy is bounded by one, independently of the block length. -/
theorem critical_block_count {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (ha : ∀ n, ‖a n‖ ≤ 1)
    (T W : ℝ) (hT : 1 ≤ T) (hW : 0 < W)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
      a n*(n : ℂ)^(-((1/2 : ℂ)+(t i : ℂ)*I))‖) :
    (S.card : ℝ) ≤ halaszCountConstant*(1+Real.log (2*U))^6*(1+Real.log (2*T))*
      ((U : ℝ)/W^2+(U : ℝ)*T/W^6) := by
  have hh := halasz_complex_large_values_two_term S t (fun _ => 1/2) U hU a T
    (1/2) (1/2) W hT hW le_rfl (by norm_num) (fun _ _ => ⟨le_rfl,le_rfl⟩) ht hs
    (by intro i hi; convert hw i hi using 1 <;> norm_num)
  apply hh.trans
  have hE := critical_block_energy_le_one U hU a ha
  have hE0 := coefficientEnergy_nonneg (Finset.Ioc U (2*U)) (verticalCoefficients a (1/2))
  have hK := halaszCountConstant_pos
  have hlog : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
  have he3 := pow_le_pow_left₀ hE0 hE 3
  norm_num only [one_pow] at he3
  have h1 := div_le_div_of_nonneg_right (mul_le_of_le_one_right (Nat.cast_nonneg U) hE) (sq_nonneg W)
  have h2 := div_le_div_of_nonneg_right
    (mul_le_of_le_one_right (show 0 ≤ (U : ℝ)*T by positivity) he3) (by positivity : 0 ≤ W^6)
  exact mul_le_mul_of_nonneg_left (add_le_add h1 h2) (by positivity)

theorem critical_threshold_compare (J : ℕ) (hJ : 1 ≤ J) (T W : ℝ) (hT : 0 ≤ T)
    (hW : 0 < W) :
    1/(W/(2*(J : ℝ)))^2+T/(W/(2*(J : ℝ)))^6 ≤
      (2*(J : ℝ))^6*(1/W^2+T/W^6) := by
  have hJp : (0 : ℝ) < J := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hJ)
  have hJ1 : (1 : ℝ) ≤ 2*J := by exact_mod_cast (show 1 ≤ 2*J by omega)
  have hp := pow_le_pow_right₀ hJ1 (by norm_num : (2 : ℕ) ≤ 6)
  have hh := div_le_div_of_nonneg_right hp (sq_nonneg W)
  calc
    _ = (2*(J : ℝ))^2/W^2+(2*(J : ℝ))^6*T/W^6 := by field_simp
    _ ≤ (2*(J : ℝ))^6/W^2+(2*(J : ℝ))^6*T/W^6 := add_le_add hh le_rfl
    _ = _ := by ring

/-- Dyadic decomposition preserves the two analytic terms for a full polynomial. -/
theorem critical_polynomial_count_dyadic {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (X J : ℕ) (hX : 1 ≤ X) (hJ : 1 ≤ J) (hcover : X ≤ 2^J)
    (a : ℕ → ℂ) (ha : ∀ n, ‖a n‖ ≤ 1) (T W : ℝ) (hT : 1 ≤ T) (hW : 2 ≤ W)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖complexDirichletPolynomial X a
      ((1/2 : ℂ)+(t i : ℂ)*I)‖) :
    (S.card : ℝ) ≤ halaszCountConstant*(1+Real.log (2*(2 : ℝ)^J))^6*
      (1+Real.log (2*T))*(2 : ℝ)^J*(2*(J : ℝ))^6*(J : ℝ)*(1/W^2+T/W^6) := by
  classical
  let F (j : ℕ) (i : ι) := ∑ n ∈ Finset.Ioc (2^j) (2*(2^j)),
    criticalCutoff X a n*(n : ℂ)^(-((1/2 : ℂ)+(t i : ℂ)*I))
  let Q (j : ℕ) := S.filter (fun i => W/(2*(J : ℝ)) ≤ ‖F j i‖)
  have hJp : (0 : ℝ) < J := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hJ)
  have hWp : 0 < W := by linarith
  have hv : 0 < W/(2*(J : ℝ)) := by positivity
  have hsub : S ⊆ (Finset.range J).biUnion Q := by
    intro i hi
    have hw' := hw i hi
    rw [critical_polynomial_blocks X J hX a _ hcover] at hw'
    obtain ⟨j,hj,hlarge⟩ := exists_large_block J hJ (a 1) (fun j => F j i) W hW (ha 1) hw'
    exact Finset.mem_biUnion.mpr ⟨j,hj,Finset.mem_filter.mpr ⟨hi,hlarge⟩⟩
  have hcard : (S.card : ℝ) ≤ ∑ j ∈ Finset.range J, ((Q j).card : ℝ) := by
    exact_mod_cast (Finset.card_le_card hsub).trans Finset.card_biUnion_le
  let A := halaszCountConstant*(1+Real.log (2*(2 : ℝ)^J))^6*(1+Real.log (2*T))
  have hA : 0 ≤ A := by
    have := halaszCountConstant_pos
    have : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
    dsimp [A]; positivity
  have hbound (j : ℕ) (hj : j ∈ Finset.range J) :
      ((Q j).card : ℝ) ≤ A*(2 : ℝ)^J*(2*(J : ℝ))^6*(1/W^2+T/W^6) := by
    have hU : 1 ≤ (2 : ℕ)^j := Nat.one_le_pow _ _ (by norm_num)
    have hu : (2 : ℝ)^j ≤ (2 : ℝ)^J := pow_le_pow_right₀ (by norm_num) (Finset.mem_range.mp hj).le
    have hl := Real.log_le_log (by positivity : 0 < 2*(2 : ℝ)^j)
      (mul_le_mul_of_nonneg_left hu (by norm_num : (0 : ℝ) ≤ 2))
    have hl0 : 0 ≤ 1+Real.log (2*(2 : ℝ)^j) := by
      have hh : 1 ≤ 2*(2 : ℝ)^j := by nlinarith [one_le_pow₀ (by norm_num : (1 : ℝ) ≤ 2) (n := j)]
      have := Real.log_nonneg hh
      linarith
    have hh := critical_block_count (Q j) t (2^j) hU (criticalCutoff X a)
      (criticalCutoff_norm X a ha) T (W/(2*(J : ℝ))) hT hv
      (fun i hi => ht i (Finset.mem_filter.mp hi).1)
      (fun i hi k hk hik => hs i (Finset.mem_filter.mp hi).1 k (Finset.mem_filter.mp hk).1 hik)
      (fun i hi => (Finset.mem_filter.mp hi).2)
    push_cast at hh
    have hlogT : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
    have hK := halaszCountConstant_pos
    have hcost : halaszCountConstant*(1+Real.log (2*(2 : ℝ)^j))^6*(1+Real.log (2*T)) ≤ A := by
      dsimp [A]
      gcongr
    have hterms : (2 : ℝ)^j/(W/(2*(J : ℝ)))^2+(2 : ℝ)^j*T/(W/(2*(J : ℝ)))^6 ≤
        (2 : ℝ)^J*((2*(J : ℝ))^6*(1/W^2+T/W^6)) := by
      calc
        _ = (2 : ℝ)^j*(1/(W/(2*(J : ℝ)))^2+T/(W/(2*(J : ℝ)))^6) := by ring
        _ ≤ (2 : ℝ)^J*((2*(J : ℝ))^6*(1/W^2+T/W^6)) := by
          exact mul_le_mul hu (critical_threshold_compare J hJ T W (by linarith) hWp)
            (by positivity) (by positivity)
    have hprod := mul_le_mul hcost hterms (by positivity) hA
    exact hh.trans (by convert hprod using 1 <;> ring)
  have hh := hcard.trans (Finset.sum_le_sum hbound)
  simp only [Finset.sum_const,Finset.card_range,nsmul_eq_mul] at hh
  dsimp [A] at hh
  convert hh using 1 <;> ring

end Legendre.Density.Oscillation
