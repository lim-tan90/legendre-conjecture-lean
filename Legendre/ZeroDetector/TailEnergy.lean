/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZeroDetector.DetectorSamples
public import Mathlib.Algebra.Order.Field.GeomSum
public import Mathlib.Data.Nat.Log

/-!
# High-tail energies for the actual zeta detector

Dyadic decomposition turns the proved divisor-square mean into X^(1-2σ)
decay above the critical line, with all logarithmic losses displayed.
-/

@[expose] public section

open scoped BigOperators
namespace Legendre.Density.Detector

/-- Scaling a dyadic block produces the density-relevant geometric factor. -/
theorem dyadic_power_weight (X j : ℕ) (σ : ℝ) :
    ((X*2^j : ℕ) : ℝ)*((X*2^j : ℕ) : ℝ)^(-2*σ) =
      (X : ℝ)*(X : ℝ)^(-2*σ)*((2 : ℝ)^(1-2*σ))^j := by
  rw [Nat.cast_mul,Nat.cast_pow,Nat.cast_ofNat,Real.mul_rpow (Nat.cast_nonneg X) (by positivity)]
  have hp : ((2 : ℝ)^j)^(-2*σ) = ((2 : ℝ)^(-2*σ))^j := by
    rw [← Real.rpow_natCast_mul (by norm_num),← Real.rpow_mul_natCast (by norm_num)]
    congr 1
    ring
  rw [hp]
  rw [Real.rpow_sub (by norm_num : (0 : ℝ) < 2),Real.rpow_one]
  rw [show (2 : ℝ)/2^(2*σ) = 2*2^(-2*σ) by
    rw [show (-2 : ℝ)*σ = -(2*σ) by ring,Real.rpow_neg (by norm_num : (0 : ℝ) ≤ 2),div_eq_mul_inv]]
  rw [mul_pow]
  ring

/-- A finite initial tail is exactly the union of its dyadic blocks. -/
theorem sum_dyadic_blocks (f : ℕ → ℝ) (X K : ℕ) :
    (∑ n ∈ Finset.Ioc X (X*2^K), f n) =
      ∑ j ∈ Finset.range K, ∑ n ∈ Finset.Ioc (X*2^j) (2*(X*2^j)), f n := by
  induction K with
  | zero => simp
  | succ K ih =>
    have hX : X ≤ X*2^K := by exact le_mul_of_one_le_right' (Nat.one_le_iff_ne_zero.2 (pow_ne_zero _ (by decide : (2 : ℕ) ≠ 0)))
    have hK : X*2^K ≤ X*2^(K+1) := by gcongr; norm_num
    have he : X*2^(K+1) = 2*(X*2^K) := by ring
    have hu := Finset.Ioc_union_Ioc_eq_Ioc hX hK
    have hd : Disjoint (Finset.Ioc X (X*2^K)) (Finset.Ioc (X*2^K) (X*2^(K+1))) := by
      apply Finset.disjoint_left.2
      intro n hn hm
      have h1 := (Finset.mem_Ioc.1 hn).2
      have h2 := (Finset.mem_Ioc.1 hm).1
      omega
    rw [← hu,Finset.sum_union hd,ih,Finset.sum_range_succ,he]

/-- A geometric tail bound retains the useful X^(1-2σ) decay. -/
theorem dyadic_tail_coefficient_energy_le (a : ℕ → ℂ) {X K : ℕ} (hX : 1 ≤ X)
    {C σ : ℝ} (hC : 0 ≤ C) (hσ : 0 ≤ σ)
    (ha : ∀ n, ‖a n‖ ≤ C*(n.divisors.card : ℝ)) :
    (∑ n ∈ Finset.Ioc X (X*2^K), ‖a n‖^2*(n : ℝ)^(-2*σ)) ≤
      C^2*(2*(X : ℝ)*(1+Real.log (X*2^K : ℕ))^3*(X : ℝ)^(-2*σ))*
        (∑ j ∈ Finset.range K, ((2 : ℝ)^(1-2*σ))^j) := by
  rw [sum_dyadic_blocks,Finset.mul_sum]
  apply Finset.sum_le_sum
  intro j hj
  have hjK : j+1 ≤ K := Nat.succ_le_of_lt (Finset.mem_range.1 hj)
  have hU : 1 ≤ X*2^j := by
    simpa only [one_mul] using Nat.mul_le_mul hX
      (Nat.one_le_iff_ne_zero.2 (pow_ne_zero j (by decide : (2 : ℕ) ≠ 0)))
  have hb := dyadic_coefficient_energy_le a hC hσ hU (fun n _ => ha n)
  have hlog : Real.log (2*(X*2^j) : ℕ) ≤ Real.log (X*2^K : ℕ) := by
    apply Real.log_le_log (by positivity)
    exact_mod_cast (show 2*(X*2^j) ≤ X*2^K by
      rw [show 2*(X*2^j) = X*2^(j+1) by ring]
      gcongr)
  have hp : (1+Real.log (2*(X*2^j) : ℕ))^3 ≤ (1+Real.log (X*2^K : ℕ))^3 := by
    have hh : (1 : ℝ) ≤ (2*(X*2^j) : ℕ) := by exact_mod_cast (by omega : 1 ≤ 2*(X*2^j))
    have hnonneg : 0 ≤ 1+Real.log (2*(X*2^j) : ℕ) := by
      have hl := Real.log_nonneg hh
      linarith
    exact pow_le_pow_left₀ hnonneg (by linarith) 3
  apply hb.trans
  have hm := mul_le_mul_of_nonneg_left hp
    (show 0 ≤ C^2*(2*((X*2^j : ℕ) : ℝ))*((X*2^j : ℕ) : ℝ)^(-2*σ) by positivity)
  calc
    _ = (C^2*(2*((X*2^j : ℕ) : ℝ))*((X*2^j : ℕ) : ℝ)^(-2*σ))*
        (1+Real.log (2*(X*2^j) : ℕ))^3 := by push_cast; ring
    _ ≤ (C^2*(2*((X*2^j : ℕ) : ℝ))*((X*2^j : ℕ) : ℝ)^(-2*σ))*
        (1+Real.log (X*2^K : ℕ))^3 := hm
    _ = _ := by
      have hw' := dyadic_power_weight X j σ
      calc
        _ = C^2*2*(((X*2^j : ℕ) : ℝ)*((X*2^j : ℕ) : ℝ)^(-2*σ))*
            (1+Real.log (X*2^K : ℕ))^3 := by ring
        _ = _ := by rw [hw']; ring

/-- Above the critical line the dyadic ratio is strictly smaller than one. -/
theorem dyadic_density_ratio_lt_one {σ : ℝ} (hσ : 1/2 < σ) :
    (2 : ℝ)^(1-2*σ) < 1 :=
  Real.rpow_lt_one_of_one_lt_of_neg (by norm_num) (by linarith)

/-- Summing the finite geometric factor gives a bound uniform in the number of blocks. -/
theorem dyadic_geometric_energy_le (a : ℕ → ℂ) {X K : ℕ} (hX : 1 ≤ X)
    {C σ : ℝ} (hC : 0 ≤ C) (hσ : 1/2 < σ)
    (ha : ∀ n, ‖a n‖ ≤ C*(n.divisors.card : ℝ)) :
    (∑ n ∈ Finset.Ioc X (X*2^K), ‖a n‖^2*(n : ℝ)^(-2*σ)) ≤
      (C^2*(2*(X : ℝ)*(1+Real.log (X*2^K : ℕ))^3*(X : ℝ)^(-2*σ)))/
        (1-(2 : ℝ)^(1-2*σ)) := by
  have hr := dyadic_density_ratio_lt_one hσ
  have hsum : (∑ j ∈ Finset.range K, ((2 : ℝ)^(1-2*σ))^j) ≤
      1/(1-(2 : ℝ)^(1-2*σ)) := by
    simpa only [Finset.range_eq_Ico,pow_zero] using
      (geom_sum_Ico_le_of_lt_one (m := 0) (n := K)
        (Real.rpow_nonneg (by norm_num : (0 : ℝ) ≤ 2) (1-2*σ)) hr)
  calc
    _ ≤ _ := dyadic_tail_coefficient_energy_le a hX hC (by linarith) ha
    _ ≤ (C^2*(2*(X : ℝ)*(1+Real.log (X*2^K : ℕ))^3*(X : ℝ)^(-2*σ)))*
        (1/(1-(2 : ℝ)^(1-2*σ))) := by
      apply mul_le_mul_of_nonneg_left hsum
      have hxlog : 0 ≤ Real.log (X*2^K : ℕ) := Real.log_nonneg (by
        exact_mod_cast (show 1 ≤ X*2^K from by
          simpa only [one_mul] using Nat.mul_le_mul hX
            (Nat.one_le_iff_ne_zero.2 (pow_ne_zero K (by decide : (2 : ℕ) ≠ 0)))))
      positivity
    _ = _ := by ring

/-- Every finite high tail has useful X^(1-2σ) decay, with a logarithmic loss. -/
theorem high_tail_coefficient_energy_le (a : ℕ → ℂ) {X M : ℕ} (hX : 1 ≤ X) (hM : 1 ≤ M)
    {C σ : ℝ} (hC : 0 ≤ C) (hσ : 1/2 < σ)
    (ha : ∀ n, ‖a n‖ ≤ C*(n.divisors.card : ℝ)) :
    (∑ n ∈ Finset.Ioc X M, ‖a n‖^2*(n : ℝ)^(-2*σ)) ≤
      C^2*(2*(X : ℝ)*(1+Real.log (2*X*M : ℕ))^3*(X : ℝ)^(-2*σ))/
        (1-(2 : ℝ)^(1-2*σ)) := by
  let K := Nat.log 2 M+1
  have hMp : M ≠ 0 := by omega
  have hpow : M ≤ 2^K := (Nat.lt_pow_succ_log_self (by decide : 1 < (2 : ℕ)) M).le
  have hlow : M ≤ X*2^K := hpow.trans (by
    simpa only [one_mul] using Nat.mul_le_mul_right (2^K) hX)
  have hhigh : X*2^K ≤ 2*X*M := by
    have hp := Nat.pow_log_le_self 2 hMp
    dsimp [K]
    rw [pow_succ]
    nlinarith
  have hbase : 1 ≤ X*2^K := hM.trans hlow
  have hlog0 : 0 ≤ Real.log (X*2^K : ℕ) := Real.log_nonneg (by exact_mod_cast hbase)
  have hlog : Real.log (X*2^K : ℕ) ≤ Real.log (2*X*M : ℕ) :=
    Real.log_le_log (by exact_mod_cast (by omega : 0 < X*2^K)) (by exact_mod_cast hhigh)
  have hp := pow_le_pow_left₀ (by linarith : 0 ≤ 1+Real.log (X*2^K : ℕ))
    (add_le_add (le_refl (1 : ℝ)) hlog) 3
  have hd : 0 < 1-(2 : ℝ)^(1-2*σ) := sub_pos.2 (dyadic_density_ratio_lt_one hσ)
  calc
    _ ≤ ∑ n ∈ Finset.Ioc X (X*2^K), ‖a n‖^2*(n : ℝ)^(-2*σ) := by
      apply Finset.sum_le_sum_of_subset_of_nonneg
      · exact Finset.Ioc_subset_Ioc_right hlow
      · intro n _ _; positivity
    _ ≤ _ := dyadic_geometric_energy_le a hX hC hσ ha
    _ ≤ _ := by
      apply div_le_div_of_nonneg_right _ hd.le
      have hmul := mul_le_mul_of_nonneg_left hp
        (show 0 ≤ C^2*(2*(X : ℝ))*(X : ℝ)^(-2*σ) by positivity)
      convert! hmul using 1 <;> ring

open scoped ArithmeticFunction.Moebius

/-- The coefficient energy on a vertical line has the standard real-power weight. -/
theorem norm_verticalCoefficients_sq (a : ℕ → ℂ) (σ : ℝ) {n : ℕ} (hn : 0 < n) :
    ‖verticalCoefficients a σ n‖^2 = ‖a n‖^2*(n : ℝ)^(-2*σ) := by
  rw [norm_verticalCoefficients a σ hn,mul_pow]
  have hp : ((n : ℝ)^(-σ))^2 = (n : ℝ)^(-2*σ) := by
    rw [← Real.rpow_mul_natCast (Nat.cast_nonneg n) (-σ) 2]
    congr 1
    norm_num
    ring
  rw [hp]

/-- The tail coefficient energy is exactly supported beyond the cancellation cutoff. -/
theorem detector_tail_energy_eq (X N : ℕ) (σ : ℝ) :
    coefficientEnergy (Finset.Icc 1 (X*N)) (verticalCoefficients (detectorTailCoefficients X N) σ) =
      ∑ n ∈ Finset.Ioc X (X*N), ‖mollifierCoefficient X N n‖^2*(n : ℝ)^(-2*σ) := by
  classical
  unfold coefficientEnergy
  calc
    _ = ∑ n ∈ Finset.Icc 1 (X*N),
        if X < n then ‖mollifierCoefficient X N n‖^2*(n : ℝ)^(-2*σ) else 0 := by
      apply Finset.sum_congr rfl
      intro n hn
      rw [norm_verticalCoefficients_sq _ _ (Nat.zero_lt_one.trans_le (Finset.mem_Icc.1 hn).1)]
      unfold detectorTailCoefficients
      split_ifs <;> simp
    _ = ∑ n ∈ (Finset.Icc 1 (X*N)).filter (fun n => X < n),
        ‖mollifierCoefficient X N n‖^2*(n : ℝ)^(-2*σ) := (Finset.sum_filter _ _).symm
    _ = _ := by
      congr 1
      ext n
      simp only [Finset.mem_filter,Finset.mem_Icc,Finset.mem_Ioc]
      omega

/-- Explicit high-tail energy majorant; its geometric denominator is positive for σ>1/2. -/
noncomputable def detectorTailEnergyBound (X N : ℕ) (σ : ℝ) : ℝ :=
  2*(X : ℝ)^(1-2*σ)*(1+Real.log (2*X*(X*N) : ℕ))^3/(1-(2 : ℝ)^(1-2*σ))

theorem detector_tail_energy_le {X N : ℕ} (hX : 1 ≤ X) (hN : 1 ≤ N)
    {σ : ℝ} (hσ : 1/2 < σ) :
    coefficientEnergy (Finset.Icc 1 (X*N)) (verticalCoefficients (detectorTailCoefficients X N) σ) ≤
      detectorTailEnergyBound X N σ := by
  rw [detector_tail_energy_eq]
  have hM : 1 ≤ X*N := by simpa only [one_mul] using Nat.mul_le_mul hX hN
  have h := high_tail_coefficient_energy_le (mollifierCoefficient X N) hX hM zero_le_one hσ
    (fun n => by simpa only [one_mul] using norm_mollifierCoefficient_le X N n)
  simp only [one_pow,one_mul] at h
  have hXp : (0 : ℝ) < X := by exact_mod_cast (Nat.zero_lt_one.trans_le hX)
  have he : (X : ℝ)*(X : ℝ)^(-2*σ) = (X : ℝ)^(1-2*σ) := by
    rw [Real.rpow_sub hXp,Real.rpow_one,show (-2 : ℝ)*σ = -(2*σ) by ring,Real.rpow_neg hXp.le]
    ring
  apply h.trans_eq
  unfold detectorTailEnergyBound
  congr 1
  calc
    _ = 2*((X : ℝ)*(X : ℝ)^(-2*σ))*(1+Real.log (2*X*(X*N) : ℕ))^3 := by ring
    _ = _ := by rw [he]

/-- Critical-line Möbius energy has only a harmonic loss, uniformly to its right. -/
theorem mollifier_vertical_energy_le (X : ℕ) {σ : ℝ} (hσ : 1/2 ≤ σ) :
    coefficientEnergy (Finset.Icc 1 X) (verticalCoefficients (μ : ArithmeticFunction ℂ) σ) ≤
      1+Real.log X := by
  have hsum : coefficientEnergy (Finset.Icc 1 X)
      (verticalCoefficients (μ : ArithmeticFunction ℂ) σ) ≤
        ∑ n ∈ Finset.Icc 1 X, 1/(n : ℝ) := by
    apply Finset.sum_le_sum
    intro n hn
    have hn1 := (Finset.mem_Icc.1 hn).1
    have hnp := Nat.zero_lt_one.trans_le hn1
    rw [norm_verticalCoefficients_sq _ _ hnp]
    have hmu : ‖(μ : ArithmeticFunction ℂ) n‖ ≤ 1 := by
      simpa only [ArithmeticFunction.intCoe_apply] using norm_moebius_le_one n
    have hsq : ‖(μ : ArithmeticFunction ℂ) n‖^2 ≤ 1 := by
      simpa only [one_pow] using pow_le_pow_left₀ (norm_nonneg _) hmu 2
    calc
      _ ≤ 1*(n : ℝ)^(-2*σ) :=
        mul_le_mul_of_nonneg_right hsq (Real.rpow_nonneg (Nat.cast_nonneg n) _)
      _ ≤ (n : ℝ)^(-1 : ℝ) := by
        rw [one_mul]
        exact Real.rpow_le_rpow_of_exponent_le (by exact_mod_cast hn1) (by linarith)
      _ = _ := by rw [Real.rpow_neg_one,one_div]
  rw [← harmonic_real_eq_sum] at hsum
  exact hsum.trans (harmonic_le_one_add_log X)

/-- The sample coefficient is nonnegative for all natural lengths and heights. -/
theorem complexSampleCoefficient_nonneg (N H : ℕ) : 0 ≤ complexSampleCoefficient N H := by
  have hl := log_nat_nonneg N
  unfold complexSampleCoefficient
  positivity

/-- Actual separated zeros have a bound with both coefficient energies fully estimated. -/
theorem actual_zero_sample_card_le_explicit (S : Finset ℂ) {H X : ℕ} (hH : 1 ≤ H) (hX : 1 < X)
    {σ : ℝ} (hσ : 1/2 < σ) (hσ1 : σ ≤ 1)
    (hzero : ∀ ρ ∈ S, Legendre.Zeta.NontrivialZero ρ)
    (hre : ∀ ρ ∈ S, σ ≤ ρ.re)
    (hheight : ∀ ρ ∈ S, 1 ≤ ρ.im ∧ ρ.im ≤ (H : ℝ))
    (hsep : ∀ ρ ∈ S, ∀ z ∈ S, ρ ≠ z → 1 ≤ |ρ.im-z.im|) :
    (S.card : ℝ) ≤ (64/9 : ℝ)*(
      complexSampleCoefficient (X*zetaDetectorLength H X) H*
        detectorTailEnergyBound X (zetaDetectorLength H X) σ+
      ((zetaDetectorLength H X : ℝ)^(1-σ))^2*complexSampleCoefficient X H*(1+Real.log X)) := by
  have h := actual_zero_sample_card_le S hH hX ⟨hσ.le,hσ1⟩ hzero hre hheight hsep
  apply h.trans
  apply mul_le_mul_of_nonneg_left _ (by norm_num : (0 : ℝ) ≤ 64/9)
  have hN : 1 ≤ zetaDetectorLength H X := hX.le.trans (zetaDetectorLength_ge hH hX.le)
  apply add_le_add
  · exact mul_le_mul_of_nonneg_left (detector_tail_energy_le hX.le hN hσ)
      (complexSampleCoefficient_nonneg _ _)
  · exact mul_le_mul_of_nonneg_left (mollifier_vertical_energy_le X hσ.le)
      (mul_nonneg (sq_nonneg _) (complexSampleCoefficient_nonneg _ _))

end Legendre.Density.Detector
