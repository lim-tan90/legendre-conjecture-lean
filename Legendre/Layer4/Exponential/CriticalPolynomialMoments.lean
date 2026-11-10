/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local conversion of the proved polynomial distribution bound to sampled moments.
-/
module
public import Legendre.Layer4.Exponential.CriticalPolynomialCount
public import Legendre.Layer4.FiniteDyadicMoment

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

theorem ordinateTwist_norm (a : ℕ → ℂ) (c : ℝ) (n : ℕ) :
    ‖ordinateTwist a c n‖ = ‖a n‖ := by
  simp only [ordinateTwist,norm_mul,norm_realPhase,mul_one]

theorem complex_polynomial_time_shift (X : ℕ) (a : ℕ → ℂ) (c β t : ℝ) :
    complexDirichletPolynomial X a ((β : ℂ)+(t : ℂ)*I) =
      complexDirichletPolynomial X (ordinateTwist a c) ((β : ℂ)+((t-c : ℝ) : ℂ)*I) := by
  unfold complexDirichletPolynomial
  apply Finset.sum_congr rfl
  intro n hn
  have hnp : (0 : ℝ) < n := by exact_mod_cast (Finset.mem_Icc.mp hn).1
  have hn0 : (n : ℂ) ≠ 0 := by exact_mod_cast hnp.ne'
  rw [ordinateTwist,realPhase_neg_log_eq_cpow hnp c,Complex.ofReal_natCast,mul_assoc,
    ←Complex.cpow_add _ _ hn0]
  congr 2
  push_cast
  ring

theorem bounded_polynomial_norm (X : ℕ) (a : ℕ → ℂ) (ha : ∀ n, ‖a n‖ ≤ 1)
    (s : ℂ) (hs : 0 ≤ s.re) : ‖complexDirichletPolynomial X a s‖ ≤ (X : ℝ) := by
  unfold complexDirichletPolynomial
  calc
    _ ≤ ∑ n ∈ Finset.Icc 1 X, ‖a n*(n : ℂ)^(-s)‖ := norm_sum_le _ _
    _ ≤ ∑ _n ∈ Finset.Icc 1 X, (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro n hn
      have hn1 := (Finset.mem_Icc.mp hn).1
      have hnp : 0 < n := Nat.zero_lt_one.trans_le hn1
      have hp : ‖(n : ℂ)^(-s)‖ ≤ 1 := by
        rw [norm_natCast_cpow_of_pos hnp]
        exact Real.rpow_le_one_of_one_le_of_nonpos (by exact_mod_cast hn1) (by simpa)
      rw [norm_mul]
      simpa only [one_mul] using mul_le_mul (ha n) hp (norm_nonneg _) zero_le_one
    _ = _ := by simp

noncomputable def criticalPolynomialCountCost (X : ℕ) (T : ℝ) : ℝ :=
  criticalPolynomialCountConstant*(X : ℝ)*(1+Real.log X)^13*(1+Real.log (2*T))

theorem criticalPolynomialCountCost_nonneg (X : ℕ) (hX : 1 ≤ X) (T : ℝ) (hT : 1 ≤ T) :
    0 ≤ criticalPolynomialCountCost X T := by
  have := criticalPolynomialCountConstant_pos
  have := Real.log_nonneg (show (1 : ℝ) ≤ X by exact_mod_cast hX)
  have := Real.log_nonneg (show 1 ≤ 2*T by linarith)
  unfold criticalPolynomialCountCost
  positivity

/-- The distribution estimate is uniform under a common vertical translation. -/
theorem critical_polynomial_shifted_count {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (X : ℕ) (hX : 1 ≤ X) (a : ℕ → ℂ) (ha : ∀ n, ‖a n‖ ≤ 1)
    (T c W : ℝ) (hT : 1 ≤ T) (hW : 2 ≤ W)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖complexDirichletPolynomial X a
      ((1/2 : ℂ)+((t i+c : ℝ) : ℂ)*I)‖) :
    (S.card : ℝ) ≤ criticalPolynomialCountCost X T*(1/W^2+T/W^6) := by
  apply critical_polynomial_count S t X hX (ordinateTwist a c)
    (fun n => by simpa only [ordinateTwist_norm] using ha n) T W hT hW ht hs
  intro i hi
  have hh := hw i hi
  have he := complex_polynomial_time_shift X a c (1/2) (t i+c)
  norm_num only [Complex.ofReal_div,Complex.ofReal_one,Complex.ofReal_ofNat,add_sub_cancel_right] at he
  rw [he] at hh
  exact hh

/-- Finite second moment with an arbitrary splitting amplitude; no density input. -/
theorem critical_polynomial_second_moment {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (X J : ℕ) (hX : 1 ≤ X) (hcover : X ≤ 2^J)
    (a : ℕ → ℂ) (ha : ∀ n, ‖a n‖ ≤ 1) (T c V : ℝ) (hT : 1 ≤ T) (hV : 2 ≤ V)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (∑ i ∈ S, ‖complexDirichletPolynomial X a
      ((1/2 : ℂ)+((t i+c : ℝ) : ℂ)*I)‖^2) ≤
      (S.card : ℝ)*V^2+4*criticalPolynomialCountCost X T*(J : ℝ)+
        8*(criticalPolynomialCountCost X T*T)/V^4 := by
  classical
  have hA := criticalPolynomialCountCost_nonneg X hX T hT
  apply Moment.finite_dyadic_second_moment S _ J V (criticalPolynomialCountCost X T)
    (criticalPolynomialCountCost X T*T) (by linarith) hA (by positivity)
  · intro i hi
    refine ⟨norm_nonneg _,?_⟩
    have hh := bounded_polynomial_norm X a ha ((1/2 : ℂ)+((t i+c : ℝ) : ℂ)*I) (by norm_num)
    have hc : (X : ℝ) ≤ (2 : ℝ)^J := by exact_mod_cast hcover
    have hpp : 0 ≤ (2 : ℝ)^J := by positivity
    nlinarith
  · intro j hj
    let Q := S.filter (fun i => V*(2 : ℝ)^j ≤ ‖complexDirichletPolynomial X a
      ((1/2 : ℂ)+((t i+c : ℝ) : ℂ)*I)‖)
    have hv : 2 ≤ V*(2 : ℝ)^j := by
      nlinarith [one_le_pow₀ (by norm_num : (1 : ℝ) ≤ 2) (n := j)]
    have hh := critical_polynomial_shifted_count Q t X hX a ha T c (V*(2 : ℝ)^j) hT hv
      (fun i hi => ht i (Finset.mem_filter.mp hi).1)
      (fun i hi k hk hik => hs i (Finset.mem_filter.mp hi).1 k (Finset.mem_filter.mp hk).1 hik)
      (fun i hi => (Finset.mem_filter.mp hi).2)
    convert hh using 1 <;> ring

end Legendre.Density.Oscillation
