/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.HarmonicLogIntegral

@[expose] public section
namespace Legendre.Density.Moment

/-- For cutoffs at least one, the reciprocal product weights of ordered
tuples of positive factors whose product is at most the cutoff. -/
noncomputable def harmonicFactorTuples : ℕ → ℝ → ℝ
  | 0, _ => 1
  | k+1, x => ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, harmonicFactorTuples k (x/n)/n

private theorem sum_inv_floor_le {x : ℝ} (hx : 1 ≤ x) :
    (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (n : ℝ)⁻¹) ≤ 1+Real.log x := by
  have h := abs_inverse_log_sum_sub_main_le hx 0
  norm_num at h
  have hh := (abs_le.mp h).2
  linarith only [hh]

private theorem log_sum_scaled_error {x : ℝ} (hx : 1 ≤ x) (k : ℕ) :
    |(∑ n ∈ Finset.Icc 1 ⌊x⌋₊, ((Real.log (x/n))^k/(k.factorial : ℝ))/n) -
      (Real.log x)^(k+1)/((k+1).factorial : ℝ)| ≤ (1+Real.log x)^k := by
  have hw : (0 : ℝ) < k.factorial := by exact_mod_cast Nat.factorial_pos k
  have hl : 0 ≤ Real.log x := Real.log_nonneg hx
  have he (n : ℕ) : ((Real.log (x/n))^k/(k.factorial : ℝ))/n =
      ((Real.log (x/n))^k/n)/(k.factorial : ℝ) := by ring
  simp_rw [he,← Finset.sum_div]
  rw [Nat.factorial_succ,Nat.cast_mul,← div_div,← sub_div,abs_div,abs_of_pos hw]
  apply (div_le_div_of_nonneg_right (abs_inverse_log_sum_sub_main_le hx k) hw.le).trans
  have hfact : (1 : ℝ) ≤ k.factorial := by exact_mod_cast Nat.factorial_pos k
  calc
    _ ≤ (Real.log x)^k := (div_le_self (pow_nonneg hl _) hfact)
    _ ≤ _ := pow_le_pow_left₀ hl (by linarith) _

/-- Integration in logarithmic variables gives the factorial main term.
The error has one fewer logarithm, uniformly in the real cutoff. -/
theorem abs_harmonicFactorTuples_sub_log_main_le (k : ℕ) {x : ℝ} (hx : 1 ≤ x) :
    |harmonicFactorTuples (k+1) x - (Real.log x)^(k+1)/((k+1).factorial : ℝ)| ≤
      (k+1 : ℕ)*(1+Real.log x)^k := by
  induction k generalizing x with
  | zero =>
    simpa [harmonicFactorTuples] using abs_inverse_log_sum_sub_main_le hx 0
  | succ k ih =>
    let S := Finset.Icc 1 ⌊x⌋₊
    let f := fun n : ℕ => harmonicFactorTuples (k+1) (x/n)/n
    let g := fun n : ℕ => ((Real.log (x/n))^(k+1)/((k+1).factorial : ℝ))/n
    let main := (Real.log x)^(k+2)/((k+2).factorial : ℝ)
    let K := ((k+1 : ℕ) : ℝ)*(1+Real.log x)^k
    have hlo (n : ℕ) (hn : n ∈ S) : (1 : ℝ) ≤ n := by
      exact_mod_cast (Finset.mem_Icc.mp hn).1
    have hhi (n : ℕ) (hn : n ∈ S) : (n : ℝ) ≤ x :=
      (by exact_mod_cast (Finset.mem_Icc.mp hn).2 : (n : ℝ) ≤ ⌊x⌋₊).trans
        (Nat.floor_le (zero_le_one.trans hx))
    have hx₀ : 0 < x := zero_lt_one.trans_le hx
    have hpoint (n : ℕ) (hn : n ∈ S) : |f n-g n| ≤ K*(n : ℝ)⁻¹ := by
      have hn₀ : (0 : ℝ) < n := zero_lt_one.trans_le (hlo n hn)
      have hnx : 1 ≤ x/(n : ℝ) := (one_le_div hn₀).2 (hhi n hn)
      have hlog : Real.log (x/(n : ℝ)) ≤ Real.log x :=
        Real.log_le_log (div_pos hx₀ hn₀) (div_le_self hx₀.le (hlo n hn))
      have hh := ih hnx
      dsimp only [f,g,K]
      rw [← sub_div,abs_div,abs_of_pos hn₀,div_eq_mul_inv]
      apply mul_le_mul_of_nonneg_right _ (inv_nonneg.mpr hn₀.le)
      apply hh.trans
      apply mul_le_mul_of_nonneg_left _ (Nat.cast_nonneg _)
      exact pow_le_pow_left₀ (by linarith only [Real.log_nonneg hnx])
        (add_le_add_right hlog 1) _
    have hsum : |(∑ n ∈ S, f n)-(∑ n ∈ S, g n)| ≤ K*(1+Real.log x) := by
      rw [← Finset.sum_sub_distrib]
      calc
        _ ≤ ∑ n ∈ S, |f n-g n| := Finset.abs_sum_le_sum_abs _ _
        _ ≤ ∑ n ∈ S, K*(n : ℝ)⁻¹ := Finset.sum_le_sum hpoint
        _ ≤ _ := by
          rw [← Finset.mul_sum]
          exact mul_le_mul_of_nonneg_left (sum_inv_floor_le hx)
            (by
              dsimp [K]
              exact mul_nonneg (Nat.cast_nonneg _) (pow_nonneg
                (by linarith only [Real.log_nonneg hx]) _))
    change |(∑ n ∈ S, f n)-main| ≤ _
    rw [show (∑ n ∈ S, f n)-main =
      ((∑ n ∈ S, f n)-(∑ n ∈ S, g n))+((∑ n ∈ S, g n)-main) by ring]
    apply (abs_add_le _ _).trans
    apply (add_le_add hsum (log_sum_scaled_error hx (k+1))).trans_eq
    dsimp only [K]
    push_cast
    rw [pow_succ]
    ring

end Legendre.Density.Moment
