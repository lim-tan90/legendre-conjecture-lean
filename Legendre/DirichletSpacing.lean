/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ExponentialKernel
public import Mathlib.NumberTheory.Harmonic.Bounds

/-!
# Logarithmic frequency spacing and harmonic row sums

The elementary Schur bound is O(N log N), retaining all dependence on N.
No Hilbert inequality, large sieve or external density estimate is assumed.
-/

@[expose] public section

namespace Legendre.Density

/-- Real harmonic sums in the indexing convention used by the Dirichlet polynomial. -/
theorem harmonic_real_eq_sum (N : ℕ) :
    (harmonic N : ℝ) = ∑ n ∈ Finset.Icc 1 N, 1/(n : ℝ) := by
  simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast, one_div]

/-- A lower bound for logarithmic frequency differences. -/
theorem log_gap_lower {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    (y-x)/y ≤ Real.log y-Real.log x := by
  have h := Real.one_sub_inv_le_log_of_pos (div_pos hy hx)
  rw [inv_div, Real.log_div hy.ne' hx.ne'] at h
  convert! h using 1
  field_simp

/-- The logarithmic gap for positive m<n≤N controls its reciprocal. -/
theorem inv_log_gap_le {m n N : ℝ} (hm : 0 < m) (hmn : m < n) (hnN : n ≤ N) :
    1/(Real.log n-Real.log m) ≤ N/(n-m) := by
  have hn : 0 < n := hm.trans hmn
  have hlog : 0 < Real.log n-Real.log m := sub_pos.2 (Real.strictMonoOn_log hm hn hmn)
  have hgap := (div_le_iff₀ hn).1 (log_gap_lower hm hn)
  apply (div_le_div_iff₀ hlog (sub_pos.2 hmn)).2
  nlinarith [mul_nonneg (sub_nonneg.2 hnN) hlog.le]

/-- Reciprocal absolute logarithmic gaps for distinct positive integer frequencies. -/
theorem inv_abs_log_gap_le {N m n : ℕ} (hm : m ∈ Finset.Icc 1 N)
    (hn : n ∈ Finset.Icc 1 N) (hne : m ≠ n) :
    1/|Real.log (m : ℝ)-Real.log (n : ℝ)| ≤ (N : ℝ)/|(m : ℝ)-(n : ℝ)| := by
  have hmpos : (0 : ℝ) < m := by exact_mod_cast (Finset.mem_Icc.1 hm).1
  have hnpos : (0 : ℝ) < n := by exact_mod_cast (Finset.mem_Icc.1 hn).1
  rcases lt_or_gt_of_ne hne with hmn|hnm
  · have hlt : (m : ℝ) < n := by exact_mod_cast hmn
    have hl := Real.strictMonoOn_log hmpos hnpos hlt
    rw [abs_sub_comm (Real.log (m : ℝ)), abs_sub_comm (m : ℝ),
      abs_of_pos (sub_pos.2 hl), abs_of_pos (sub_pos.2 hlt)]
    exact inv_log_gap_le hmpos hlt (by exact_mod_cast (Finset.mem_Icc.1 hn).2)
  · have hlt : (n : ℝ) < m := by exact_mod_cast hnm
    have hl := Real.strictMonoOn_log hnpos hmpos hlt
    rw [abs_of_pos (sub_pos.2 hl), abs_of_pos (sub_pos.2 hlt)]
    exact inv_log_gap_le hnpos hlt (by exact_mod_cast (Finset.mem_Icc.1 hm).2)

/-- Positive gaps to indices below m inject into the first N positive integers. -/
theorem sum_inv_left_gaps_le {N m : ℕ} (hm : m ≤ N) :
    (∑ n ∈ (Finset.Icc 1 N).filter (fun n => n < m), 1/((m-n : ℕ) : ℝ)) ≤ harmonic N := by
  classical
  rw [harmonic_real_eq_sum]
  apply Finset.sum_le_sum_of_injOn (fun n : ℕ => m-n)
  · intro n hn k hk he
    dsimp only at he
    have hn' := (Finset.mem_filter.1 hn).2
    have hk' := (Finset.mem_filter.1 hk).2
    omega
  · intro k hk
    obtain ⟨n,hn,rfl⟩ := Finset.mem_image.1 hk
    have hn' := (Finset.mem_filter.1 hn).2
    exact Finset.mem_Icc.2 ⟨by omega,by omega⟩
  · intro n hn
    exact le_rfl
  · intro n hn hnot
    positivity

/-- Positive gaps to indices above m inject into the first N positive integers. -/
theorem sum_inv_right_gaps_le (N m : ℕ) :
    (∑ n ∈ (Finset.Icc 1 N).filter (fun n => m < n), 1/((n-m : ℕ) : ℝ)) ≤ harmonic N := by
  classical
  rw [harmonic_real_eq_sum]
  apply Finset.sum_le_sum_of_injOn (fun n : ℕ => n-m)
  · intro n hn k hk he
    dsimp only at he
    have hn' := (Finset.mem_filter.1 hn).2
    have hk' := (Finset.mem_filter.1 hk).2
    omega
  · intro k hk
    obtain ⟨n,hn,rfl⟩ := Finset.mem_image.1 hk
    have hn' := Finset.mem_filter.1 hn
    have hnN := (Finset.mem_Icc.1 hn'.1).2
    exact Finset.mem_Icc.2 ⟨by omega,by omega⟩
  · intro n hn
    exact le_rfl
  · intro n hn hnot
    positivity

/-- Every absolute integer-gap row is bounded by two harmonic sums. -/
theorem sum_inv_abs_nat_gaps_le {N m : ℕ} (hm : m ∈ Finset.Icc 1 N) :
    (∑ n ∈ Finset.Icc 1 N, 1/|(m : ℝ)-(n : ℝ)|) ≤ 2*(harmonic N : ℝ) := by
  classical
  let L := (Finset.Icc 1 N).filter (fun n => n < m)
  let R := (Finset.Icc 1 N).filter (fun n => m < n)
  have hsplit : (Finset.Icc 1 N).erase m = L ∪ R := by
    ext n
    simp only [Finset.mem_erase, Finset.mem_union, Finset.mem_filter, L, R, Finset.mem_Icc]
    omega
  have hdisj : Disjoint L R := by
    apply Finset.disjoint_left.2
    intro n hn hk
    have hL := (Finset.mem_filter.1 hn).2
    have hR := (Finset.mem_filter.1 hk).2
    omega
  rw [← Finset.sum_erase_add _ _ hm, hsplit, Finset.sum_union hdisj]
  simp only [sub_self, abs_zero, div_zero, add_zero]
  have hL : (∑ n ∈ L, 1/|(m : ℝ)-(n : ℝ)|) ≤ harmonic N := by
    convert sum_inv_left_gaps_le (Finset.mem_Icc.1 hm).2 using 1
    apply Finset.sum_congr rfl
    intro n hn
    have hnm := (Finset.mem_filter.1 hn).2
    rw [Nat.cast_sub (Nat.le_of_lt hnm), abs_of_nonneg (sub_nonneg.2 (by exact_mod_cast Nat.le_of_lt hnm : (n : ℝ) ≤ m))]
  have hR : (∑ n ∈ R, 1/|(m : ℝ)-(n : ℝ)|) ≤ harmonic N := by
    convert sum_inv_right_gaps_le N m using 1
    apply Finset.sum_congr rfl
    intro n hn
    have hmn := (Finset.mem_filter.1 hn).2
    rw [Nat.cast_sub (Nat.le_of_lt hmn), abs_sub_comm, abs_of_nonneg (sub_nonneg.2 (by exact_mod_cast Nat.le_of_lt hmn : (m : ℝ) ≤ n))]
  linarith

/-- Logarithmic-frequency rows have the explicit O(N log N) Schur bound. -/
theorem sum_inv_abs_log_gaps_le {N m : ℕ} (hm : m ∈ Finset.Icc 1 N) :
    (∑ n ∈ Finset.Icc 1 N, 1/|Real.log (m : ℝ)-Real.log (n : ℝ)|) ≤
      2*(N : ℝ)*(harmonic N : ℝ) := by
  calc
    _ ≤ ∑ n ∈ Finset.Icc 1 N, (N : ℝ)/|(m : ℝ)-(n : ℝ)| := by
      apply Finset.sum_le_sum
      intro n hn
      by_cases he : m = n
      · simp [he]
      · exact inv_abs_log_gap_le hm hn he
    _ = (N : ℝ)*(∑ n ∈ Finset.Icc 1 N, 1/|(m : ℝ)-(n : ℝ)|) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro n hn
      ring
    _ ≤ _ := by
      have h := mul_le_mul_of_nonneg_left (sum_inv_abs_nat_gaps_le hm) (Nat.cast_nonneg N : (0 : ℝ) ≤ N)
      nlinarith

end Legendre.Density
