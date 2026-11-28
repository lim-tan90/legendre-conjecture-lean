/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.TruncatedZetaSquare
public import Legendre.Layer4.FourthMoment.FourthMomentPairing

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set Detector
open scoped ComplexConjugate

/-- The untruncated critical coefficient of the square of the zeta series. -/
noncomputable def criticalDivisorCoefficient (n : ℕ) : ℂ :=
  verticalCoefficients (fun k : ℕ => (k.divisors.card : ℂ)) (1/2) n

theorem norm_criticalDivisorCoefficient_sq {n : ℕ} (hn : 0 < n) :
    ‖criticalDivisorCoefficient n‖^2 = (n.divisors.card : ℝ)^2/n := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  rw [criticalDivisorCoefficient,norm_verticalCoefficients _ _ hn,Complex.norm_natCast,mul_pow,
    ← Real.rpow_mul_natCast hnR.le,Nat.cast_ofNat,show (-(1/2 : ℝ))*2 = -1 by norm_num,
    Real.rpow_neg_one,div_eq_mul_inv]

theorem sum_norm_criticalDivisorCoefficient_le (M : ℕ) :
    (∑ m ∈ Finset.Icc 1 M, ‖criticalDivisorCoefficient m‖) ≤ (M : ℝ)^2 := by
  calc
    _ ≤ ∑ _m ∈ Finset.Icc 1 M, (M : ℝ) := by
      apply Finset.sum_le_sum
      intro m hm
      have hm₁ := (Finset.mem_Icc.mp hm).1
      have hmM := (Finset.mem_Icc.mp hm).2
      have hcard : m.divisors.card ≤ m := Nat.card_divisors_le_self m
      rw [criticalDivisorCoefficient,norm_verticalCoefficients _ _ hm₁,Complex.norm_natCast]
      calc
        _ ≤ (m.divisors.card : ℝ)*1 := mul_le_mul_of_nonneg_left
          (Real.rpow_le_one_of_one_le_of_nonpos (by exact_mod_cast hm₁) (by norm_num))
          (Nat.cast_nonneg _)
        _ ≤ (M : ℝ) := by rw [mul_one]; exact_mod_cast hcard.trans hmM
    _ = _ := by
      rw [Finset.sum_const,Nat.card_Icc]
      simp [nsmul_eq_mul,pow_two]

/-- The short divisor polynomial has at most four logarithms of mean-square energy. -/
theorem integral_scaled_criticalDivisorPolynomial_norm_sq_le
    (M : ℕ) {T : ℝ} (hT : 1 ≤ T) (hM : 1 ≤ M) (hMT : (M : ℝ) ≤ T) :
    (∫ x : ℝ in 1..2, ‖subsetPolynomial (Finset.Icc 1 M) criticalDivisorCoefficient (T*x)‖^2) ≤
      (1+2*Real.pi)*(1+Real.log T)^4 := by
  have hp : 0 < T := zero_lt_one.trans_le hT
  rw [intervalIntegral.integral_comp_mul_left (c := T) (a := 1) (b := 2)
    (fun t => ‖subsetPolynomial (Finset.Icc 1 M) criticalDivisorCoefficient t‖^2) hp.ne',
    smul_eq_mul,mul_one]
  have hE : coefficientEnergy (Finset.Icc 1 M) criticalDivisorCoefficient ≤ (1+Real.log T)^4 := by
    unfold coefficientEnergy
    have he := Finset.sum_congr rfl (fun n (hn : n ∈ Finset.Icc 1 M) =>
      norm_criticalDivisorCoefficient_sq (Finset.mem_Icc.mp hn).1)
    rw [he]
    apply (divisor_square_harmonic M).trans
    have hM₁ : (1 : ℝ) ≤ M := by exact_mod_cast hM
    exact pow_le_pow_left₀ (by linarith only [Real.log_nonneg hM₁])
      (add_le_add_right (Real.log_le_log (zero_lt_one.trans_le hM₁) hMT) 1) 4
  calc
    _ ≤ T⁻¹*((T*2-T+2*Real.pi*(M : ℝ))*coefficientEnergy (Finset.Icc 1 M) criticalDivisorCoefficient) :=
      mul_le_mul_of_nonneg_left (subsetPolynomial_mean _ _ M (fun _ h => h) _ _) (by positivity)
    _ ≤ T⁻¹*((T*(1+2*Real.pi))*(1+Real.log T)^4) := by
      apply mul_le_mul_of_nonneg_left _ (by positivity)
      apply mul_le_mul _ hE (Finset.sum_nonneg fun _ _ => sq_nonneg _) (by positivity)
      nlinarith only [mul_le_mul_of_nonneg_left hMT Real.pi_pos.le]
    _ = _ := by field_simp [hp.ne']

/-- Pair the squared Euler polynomial with a shorter divisor polynomial.
Their shared coefficients leave a harmonic divisor-square diagonal. -/
theorem norm_weighted_euler_square_sub_divisor_diagonal_le (N M : ℕ) (hM : M ≤ N)
    {T : ℝ} (hT : 0 < T) :
    ‖(∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*
      (∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+((T*x : ℝ) : ℂ)*I)))^2*
      star (subsetPolynomial (Finset.Icc 1 M) criticalDivisorCoefficient (T*x))) -
      ((1/30 : ℝ)*(∑ m ∈ Finset.Icc 1 M, (m.divisors.card : ℝ)^2/m) : ℝ)‖ ≤
      (24*((M : ℝ)/T)^2)*(4*N)*(M : ℝ)^2 := by
  let A := Finset.Icc 1 (N*N)
  let B := Finset.Icc 1 M
  let a := verticalCoefficients (truncatedZetaSquare N) (1/2)
  let b := criticalDivisorCoefficient
  have hBA : B ⊆ A := Finset.Icc_subset_Icc_right (hM.trans (by
    by_cases hN : N = 0
    · simp [hN]
    · simpa using Nat.mul_le_mul_left N (show 1 ≤ N by omega)))
  have hpoly (t : ℝ) :
      (∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I)))^2 =
        subsetPolynomial A a t := by
    rw [euler_sum_sq_eq_finiteSeries N,show (1/2 : ℂ) = ((1/2 : ℝ) : ℂ) by norm_num]
    change complexDirichletPolynomial (N*N) (truncatedZetaSquare N) _ = _
    rw [complexDirichletPolynomial_vertical]
    rfl
  have hdiag : (1/30 : ℂ)*∑ m ∈ B, a m*star (b m) =
      ((1/30 : ℝ)*(∑ m ∈ B, (m.divisors.card : ℝ)^2/m) : ℝ) := by
    push_cast
    congr 1
    apply Finset.sum_congr rfl
    intro m hm
    have hb : a m = b m := by
      unfold a b criticalDivisorCoefficient verticalCoefficients
      rw [truncatedZetaSquare_eq_divisorCard ((Finset.mem_Icc.mp hm).2.trans hM)]
    rw [hb]
    change (b m)*conj (b m) = _
    rw [Complex.mul_conj,← Complex.sq_norm]
    change (↑(‖criticalDivisorCoefficient m‖^2) : ℂ) = _
    rw [norm_criticalDivisorCoefficient_sq (Finset.mem_Icc.mp hm).1]
    push_cast
    rfl
  simp_rw [hpoly]
  have h := norm_weighted_polynomial_pairing_sub_diagonal_le A B hBA a b hT M
    (fun _ hn => (Finset.mem_Icc.mp hn).1) (fun _ hm => (Finset.mem_Icc.mp hm).2)
  rw [hdiag] at h
  apply h.trans
  apply mul_le_mul _ (sum_norm_criticalDivisorCoefficient_le M)
    (Finset.sum_nonneg fun _ _ => norm_nonneg _) (by positivity)
  exact mul_le_mul_of_nonneg_left (sum_norm_truncatedZetaSquare_vertical_le N) (by positivity)

end Legendre.Density.Moment
