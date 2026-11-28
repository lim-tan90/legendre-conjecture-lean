/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.FourthMomentKernel
public import Legendre.Layer4.GaussianMean

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set
open scoped ComplexConjugate

private theorem log_gap_of_small_index {m n M : ℕ} (hm : 0 < m) (hn : 0 < n)
    (hmM : m ≤ M) (hne : n ≠ m) :
    1/(2*(M : ℝ)) ≤ |Real.log m-Real.log n| := by
  have hmR : (0 : ℝ) < m := by exact_mod_cast hm
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hMR : (0 : ℝ) < M := by exact_mod_cast hm.trans_le hmM
  have hmMR : (m : ℝ) ≤ M := by exact_mod_cast hmM
  rcases lt_or_gt_of_ne hne with h|h
  · have hmn : (n : ℝ)+1 ≤ m := by exact_mod_cast (show n+1 ≤ m by omega)
    rw [abs_of_nonneg (sub_nonneg.mpr (Real.log_le_log hnR (by linarith only [hmn])))]
    calc
      _ ≤ 1/(m : ℝ) := one_div_le_one_div_of_le hmR (by linarith only [hmMR,hMR])
      _ ≤ ((m : ℝ)-n)/m := div_le_div_of_nonneg_right (by linarith only [hmn]) hmR.le
      _ ≤ _ := log_gap_lower hnR hmR
  · have hmn : (m : ℝ)+1 ≤ n := by exact_mod_cast (show m+1 ≤ n by omega)
    have hm₁ : (1 : ℝ) ≤ m := by exact_mod_cast hm
    rw [abs_sub_comm,abs_of_nonneg (sub_nonneg.mpr (Real.log_le_log hmR (by linarith only [hmn])))]
    calc
      _ ≤ 1/((m : ℝ)+1) := one_div_le_one_div_of_le (by positivity) (by linarith only [hmMR,hm₁])
      _ ≤ Real.log ((m : ℝ)+1)-Real.log m := by
        convert log_gap_lower hmR (show (0 : ℝ) < (m : ℝ)+1 by positivity) using 1
        ring_nf
      _ ≤ _ := sub_le_sub_right (Real.log_le_log (by positivity) hmn) _

private theorem weighted_polynomial_pairing_eq (A B : Finset ℕ) (a b : ℕ → ℂ) (T : ℝ) :
    (∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*subsetPolynomial A a (T*x)*
      star (subsetPolynomial B b (T*x))) =
    ∑ m ∈ B, ∑ n ∈ A, a n*star (b m)*fourthMomentKernel (T*(Real.log m-Real.log n)) := by
  let F := fun m n : ℕ => fun x : ℝ =>
    (a n*star (b m))*((fourthMomentWeight x : ℂ)*realPhase (T*(Real.log m-Real.log n)) x)
  have hF (m n : ℕ) : Continuous (F m n) := continuous_const.mul
    ((continuous_ofReal.comp continuous_fourthMomentWeight).mul (continuous_realPhase _))
  have hpoint (x : ℝ) : (fourthMomentWeight x : ℂ)*subsetPolynomial A a (T*x)*
      star (subsetPolynomial B b (T*x)) = ∑ m ∈ B, ∑ n ∈ A, F m n x := by
    simp only [subsetPolynomial,exponentialSum,star_sum,Finset.mul_sum,Finset.sum_mul,star_mul]
    apply Finset.sum_congr rfl
    intro m hm
    apply Finset.sum_congr rfl
    intro n hn
    have hφ : realPhase (-Real.log n) (T*x)*star (realPhase (-Real.log m) (T*x)) =
        realPhase (T*(Real.log m-Real.log n)) x := by
      rw [realPhase_mul_conj]
      unfold realPhase
      congr 2
      ring
    dsimp only [F]
    rw [← hφ]
    ring
  simp_rw [hpoint]
  rw [intervalIntegral.integral_finsetSum (s := B)
    (fun m _ => (continuous_finsetSum A (fun n _ => hF m n)).intervalIntegrable (μ := volume) 1 2)]
  apply Finset.sum_congr rfl
  intro m hm
  rw [intervalIntegral.integral_finsetSum (s := A) (fun n _ => (hF m n).intervalIntegrable (μ := volume) 1 2)]
  apply Finset.sum_congr rfl
  intro n hn
  exact intervalIntegral.integral_const_mul _ _

/-- The smooth weighted pairing separates the overlapping diagonal from the
terms with distinct frequencies, with inverse-square frequency decay. -/
theorem norm_weighted_polynomial_pairing_sub_diagonal_le
    (A B : Finset ℕ) (hBA : B ⊆ A) (a b : ℕ → ℂ) {T : ℝ} (hT : 0 < T) (M : ℕ)
    (hA : ∀ n ∈ A, 0 < n) (hB : ∀ m ∈ B, m ≤ M) :
    ‖(∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*subsetPolynomial A a (T*x)*
      star (subsetPolynomial B b (T*x))) - (1/30 : ℂ)*∑ m ∈ B, a m*star (b m)‖ ≤
      (24*((M : ℝ)/T)^2)*(∑ n ∈ A, ‖a n‖)*(∑ m ∈ B, ‖b m‖) := by
  have hdiag (m : ℕ) (hm : m ∈ B) :
      (1/30 : ℂ)*(a m*star (b m)) =
        ∑ n ∈ A, a n*star (b m)*(if n = m then (1/30 : ℂ) else 0) := by
    rw [Finset.sum_eq_single m]
    · rw [ite_eq_left rfl,mul_comm]
    · intro n _ hn
      simp [hn]
    · exact fun hn => (hn (hBA hm)).elim
  rw [weighted_polynomial_pairing_eq,Finset.mul_sum,← Finset.sum_sub_distrib]
  have he (m : ℕ) (hm : m ∈ B) :
      (∑ n ∈ A, a n*star (b m)*fourthMomentKernel (T*(Real.log m-Real.log n))) -
      (1/30 : ℂ)*(a m*star (b m)) =
      ∑ n ∈ A, a n*star (b m)*(fourthMomentKernel (T*(Real.log m-Real.log n)) -
        if n = m then (1/30 : ℂ) else 0) := by
    rw [hdiag m hm,← Finset.sum_sub_distrib]
    simp_rw [mul_sub]
  apply (norm_sum_le _ _).trans
  calc
    _ ≤ ∑ m ∈ B, ∑ n ∈ A, (24*((M : ℝ)/T)^2)*‖a n‖*‖b m‖ := by
      apply Finset.sum_le_sum
      intro m hm
      rw [he m hm]
      apply (norm_sum_le _ _).trans
      apply Finset.sum_le_sum
      intro n hn
      by_cases hnm : n = m
      · subst n
        simpa [fourthMomentKernel_zero] using (show 0 ≤ (24*((M : ℝ)/T)^2)*‖a m‖*‖b m‖ by positivity)
      have hm₀ := hA m (hBA hm)
      have hM₀ : (0 : ℝ) < M := by exact_mod_cast hm₀.trans_le (hB m hm)
      have hgap := log_gap_of_small_index hm₀ (hA n hn) (hB m hm) hnm
      have hlow : T/(2*(M : ℝ)) ≤ |T*(Real.log m-Real.log n)| := by
        rw [abs_mul,abs_of_pos hT,div_eq_mul_inv]
        exact mul_le_mul_of_nonneg_left (by simpa [one_div] using hgap) hT.le
      have hpos : 0 < T/(2*(M : ℝ)) := by positivity
      have hnonzero : T*(Real.log m-Real.log n) ≠ 0 := abs_pos.mp (hpos.trans_le hlow)
      have hK := (norm_fourthMomentKernel_le hnonzero).trans
        (div_le_div_of_nonneg_left (by norm_num : (0 : ℝ) ≤ 6) (sq_pos_of_pos hpos)
          (pow_le_pow_left₀ hpos.le hlow 2))
      have hratio : (6 : ℝ)/(T/(2*(M : ℝ)))^2 = 24*((M : ℝ)/T)^2 := by
        field_simp [hT.ne', hM₀.ne']
        ring_nf
      rw [hratio] at hK
      simp only [ite_eq_right hnm,sub_zero,norm_mul,norm_star]
      calc
        _ ≤ ‖a n‖*‖b m‖*(24*((M : ℝ)/T)^2) :=
          mul_le_mul_of_nonneg_left hK (by positivity)
        _ = _ := by ring
    _ = _ := by simp_rw [← Finset.sum_mul, Finset.mul_sum]

end Legendre.Density.Moment
