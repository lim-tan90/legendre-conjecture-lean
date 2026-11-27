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

/-- Uniform finite tails of the divisor-square series, with the logarithm
depending only on the lower cutoff. -/
theorem uniform_divisor_square_tail :
    ∃ C : ℝ, 0 < C ∧ ∀ X N : ℕ, 1 ≤ X → ∀ a : ℝ, 2/3 ≤ a →
      (∑ n ∈ Finset.Ioc X N, (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a)) ≤
        C*(X : ℝ)^(1-2*a)*(1+Real.log X)^3 := by
  let q := (2 : ℝ)^(-(1/3 : ℝ))
  have hq : 0 < q := by dsimp [q]; positivity
  have hq₁ : q < 1 := Real.rpow_lt_one_of_one_lt_of_neg (by norm_num) (by norm_num)
  let f := fun j : ℕ => (j+2 : ℝ)^3*q^j
  have hf : Summable f := by
    have h := summable_pow_mul_geometric_of_norm_lt_one 3
      (show ‖q‖ < 1 by rwa [Real.norm_of_nonneg hq.le])
    have hh := ((summable_nat_add_iff 2).mpr h).mul_right ((q^2)⁻¹)
    convert hh using 1
    funext j
    dsimp [f]
    push_cast
    rw [pow_add]
    field_simp [hq.ne']
  have hfpos : 0 < ∑' j, f j := by
    have h0 : 0 < f 0 := by dsimp [f]; positivity
    exact h0.trans_le (hf.le_tsum 0 fun j _ => by dsimp [f]; positivity)
  refine ⟨2*(∑' j, f j),by positivity,?_⟩
  intro X N hX a ha
  let J := Nat.log 2 N+1
  let U := fun j : ℕ => X*2^j
  let L := 1+Real.log X
  have hXp : (0 : ℝ) < X := by exact_mod_cast (zero_lt_one.trans_le hX)
  have hlogX : 0 ≤ Real.log X := Real.log_nonneg (by exact_mod_cast hX)
  have hL : 0 < L := by dsimp [L]; linarith
  have hlog2 : Real.log 2 ≤ 1 := by
    have h := Real.log_le_sub_one_of_pos (by norm_num : 0 < (2 : ℝ))
    norm_num at h
    exact h
  have hqA : (2 : ℝ)^(1-2*a) ≤ q :=
    Real.rpow_le_rpow_of_exponent_le (by norm_num) (by linarith)
  have hcover : N ≤ X*2^J := by
    have h := (Nat.lt_pow_succ_log_self (by norm_num : 1 < (2 : ℕ)) N).le
    exact h.trans (by simpa only [one_mul] using Nat.mul_le_mul_right (2^J) hX)
  have hblock (j : ℕ) :
      (∑ n ∈ Finset.Ioc (U j) (2*(U j)), (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a)) ≤
        (2*(X : ℝ)^(1-2*a)*L^3)*f j := by
    let c := fun n : ℕ => (n.divisors.card : ℂ)
    have hU : 1 ≤ U j := one_le_mul hX (one_le_pow₀ (by norm_num))
    have hUr : (0 : ℝ) < U j := by exact_mod_cast (zero_lt_one.trans_le hU)
    have hlog0 : 0 ≤ 1+Real.log (2*(U j) : ℕ) := by
      have hb : (1 : ℝ) ≤ (2*(U j) : ℕ) := by exact_mod_cast (show 1 ≤ 2*(U j) by omega)
      linarith [Real.log_nonneg hb]
    have hlog : 1+Real.log (2*(U j) : ℕ) ≤ (j+2 : ℝ)*L := by
      dsimp [U,L]
      push_cast
      rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) (by positivity),
        Real.log_mul hXp.ne' (by positivity), Real.log_pow]
      have hh := mul_le_mul_of_nonneg_left hlog2 (Nat.cast_nonneg j : (0 : ℝ) ≤ j)
      nlinarith [mul_nonneg (Nat.cast_nonneg j : (0 : ℝ) ≤ j) hlogX]
    have hb := dyadic_coefficient_energy_le c (C := 1) zero_le_one (by linarith : 0 ≤ a)
      hU (fun n _ => by simp [c])
    simp only [c, Complex.norm_natCast, one_pow, one_mul] at hb
    apply hb.trans
    have hpow : (U j : ℝ)*(U j : ℝ)^(-2*a) = (X : ℝ)^(1-2*a)*((2 : ℝ)^(1-2*a))^j := by
      rw [show (X : ℝ)^(1-2*a) = (X : ℝ)*(X : ℝ)^(-2*a) by
        rw [sub_eq_add_neg, show -(2*a) = -2*a by ring, Real.rpow_add hXp, Real.rpow_one]]
      exact dyadic_power_weight X j a
    calc
      _ = (2*((U j : ℝ)*(U j : ℝ)^(-2*a)))*(1+Real.log (2*(U j) : ℕ))^3 := by push_cast; ring
      _ ≤ (2*((U j : ℝ)*(U j : ℝ)^(-2*a)))*((j+2 : ℝ)*L)^3 :=
        mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hlog0 hlog 3) (by positivity)
      _ = (2*(X : ℝ)^(1-2*a)*L^3)*((j+2 : ℝ)^3*((2 : ℝ)^(1-2*a))^j) := by
        rw [hpow,mul_pow]
        ring
      _ ≤ _ := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        exact pow_le_pow_left₀ (by positivity) hqA j
  calc
    _ ≤ ∑ n ∈ Finset.Ioc X (X*2^J), (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a) :=
      Finset.sum_le_sum_of_subset_of_nonneg (Finset.Ioc_subset_Ioc_right hcover) (fun _ _ _ => by positivity)
    _ = ∑ j ∈ Finset.range J, ∑ n ∈ Finset.Ioc (U j) (2*(U j)),
        (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a) := sum_dyadic_blocks _ _ _
    _ ≤ ∑ j ∈ Finset.range J, (2*(X : ℝ)^(1-2*a)*L^3)*f j :=
      Finset.sum_le_sum fun j _ => hblock j
    _ ≤ _ := by
      rw [← Finset.mul_sum]
      exact (mul_le_mul_of_nonneg_left (hf.sum_le_tsum _ (fun j _ => by dsimp [f]; positivity))
        (by positivity)).trans_eq (by ring)

end Legendre.Density.Moment
