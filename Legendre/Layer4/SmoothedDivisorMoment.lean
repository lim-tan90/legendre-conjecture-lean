/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.DivisorEnergy
public import Legendre.ZeroDetector.TailEnergy

@[expose] public section
namespace Legendre.Density.Moment
open Detector

/-- The off-diagonal index weight in a smoothed polynomial preserves the
upper length power and uses the divisor-square harmonic bound. -/
theorem smoothed_tail_index_energy_le {X N : ℕ} {a : ℝ} (ha : a ≤ 1) :
    (∑ n ∈ Finset.Ioc X N, (n : ℝ)*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a)) ≤
      (N : ℝ)^(2-2*a)*(1+Real.log N)^4 := by
  have hsum : (∑ n ∈ Finset.Ioc X N, (n.divisors.card : ℝ)^2/n) ≤ (1+Real.log N)^4 :=
    (Finset.sum_le_sum_of_subset_of_nonneg (s := Finset.Ioc X N) (t := Finset.Icc 1 N)
      (by
        intro n hn
        have hh := Finset.mem_Ioc.mp hn
        exact Finset.mem_Icc.mpr ⟨by omega,hh.2⟩)
      (fun _ _ _ => by positivity)).trans (divisor_square_harmonic N)
  calc
    _ ≤ ∑ n ∈ Finset.Ioc X N, ((n.divisors.card : ℝ)^2/n)*(N : ℝ)^(2-2*a) := by
      apply Finset.sum_le_sum
      intro n hn
      have hh := Finset.mem_Ioc.mp hn
      have hn₀ : (0 : ℝ) < n := by exact_mod_cast (show 0 < n from by omega)
      have hnN : (n : ℝ) ≤ N := by exact_mod_cast hh.2
      have hpow : (n : ℝ)^(2-2*a) ≤ (N : ℝ)^(2-2*a) :=
        Real.rpow_le_rpow hn₀.le hnN (by linarith)
      apply le_trans _ (mul_le_mul_of_nonneg_left hpow (by positivity))
      rw [show 2-2*a = 2+(-2*a) by ring, Real.rpow_add hn₀, Real.rpow_two]
      field_simp [hn₀.ne']
      exact le_rfl
  _ = (N : ℝ)^(2-2*a)*(∑ n ∈ Finset.Ioc X N, (n.divisors.card : ℝ)^2/n) := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro n hn
    ring
  _ ≤ _ := mul_le_mul_of_nonneg_left hsum (by positivity)

/-- The diagonal term has geometric tail decay uniformly from real part (3/4). -/
theorem smoothed_tail_diagonal_energy_le {X N : ℕ} (hX : 1 ≤ X) (hN : 1 ≤ N)
    {a : ℝ} (ha : 3/4 ≤ a) :
    (∑ n ∈ Finset.Ioc X N, (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a)) ≤
      (2/(1-(2 : ℝ)^(-(1/2 : ℝ))))*(X : ℝ)^(1-2*a)*(1+Real.log (2*X*N : ℕ))^3 := by
  let d := (1 : ℝ)-(2 : ℝ)^(-(1/2 : ℝ))
  let c := fun n : ℕ => (n.divisors.card : ℂ)
  have h := high_tail_coefficient_energy_le c hX hN (C := 1) zero_le_one (by linarith : 1/2 < a)
    (fun n => by simp [c])
  have hXp : (0 : ℝ) < X := by exact_mod_cast (zero_lt_one.trans_le hX)
  have hdn : 0 < d := sub_pos.mpr (Real.rpow_lt_one_of_one_lt_of_neg (by norm_num) (by norm_num))
  have hd : d ≤ 1-(2 : ℝ)^(1-2*a) := by
    dsimp [d]
    exact sub_le_sub_left (Real.rpow_le_rpow_of_exponent_le (by norm_num) (by linarith)) _
  have hbase : (1 : ℝ) ≤ (2*X*N : ℕ) := by exact_mod_cast
    (show 1 ≤ 2*X*N from one_le_mul (one_le_mul (by norm_num) hX) hN)
  have hnonneg : 0 ≤ 1+Real.log (2*X*N : ℕ) := by linarith [Real.log_nonneg hbase]
  simp only [c, Complex.norm_natCast, one_pow, one_mul] at h
  apply h.trans
  calc
    _ ≤ (2*(X : ℝ)*(1+Real.log (2*X*N : ℕ))^3*(X : ℝ)^(-2*a))/d :=
      div_le_div_of_nonneg_left (by positivity) hdn hd
    _ = _ := by
      rw [show (1-2*a) = 1+(-2*a) by ring, Real.rpow_add hXp, Real.rpow_one]
      dsimp [d]
      ring

end Legendre.Density.Moment
