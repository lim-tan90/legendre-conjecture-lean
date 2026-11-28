/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.ZeroDetector.FiniteMollifier
public import Legendre.ComplexDirichlet
public import Legendre.Layer4.DivisorEnergy
public import Legendre.Layer4.CriticalPolynomialMean

@[expose] public section
namespace Legendre.Density.Detector
open Complex
open scoped ArithmeticFunction.zeta

/-- Convolution coefficients of the square of the Euler polynomial. -/
noncomputable def truncatedZetaSquare (N : ℕ) : ArithmeticFunction ℂ :=
  truncate N (ζ : ArithmeticFunction ℂ)*truncate N (ζ : ArithmeticFunction ℂ)

theorem truncatedZetaSquare_apply (N n : ℕ) :
    truncatedZetaSquare N n =
      ((n.divisorsAntidiagonal.filter fun p => p.1 ≤ N ∧ p.2 ≤ N).card : ℂ) := by
  rw [truncatedZetaSquare,ArithmeticFunction.mul_apply,Finset.card_filter]
  push_cast
  apply Finset.sum_congr rfl
  intro p hp
  obtain ⟨hprod,hn⟩ := Nat.mem_divisorsAntidiagonal.mp hp
  have ha : p.1 ≠ 0 := by intro h; simp [h] at hprod; omega
  have hb : p.2 ≠ 0 := by intro h; simp [h] at hprod; omega
  by_cases hp₁ : p.1 ≤ N <;> by_cases hp₂ : p.2 ≤ N <;>
    simp [hp₁,hp₂,ArithmeticFunction.natCoe_apply,ArithmeticFunction.zeta_apply_ne ha,
      ArithmeticFunction.zeta_apply_ne hb]

theorem truncatedZetaSquare_eq_divisorCard {N n : ℕ} (hn : n ≤ N) :
    truncatedZetaSquare N n = (n.divisors.card : ℂ) := by
  rw [truncatedZetaSquare_apply,Finset.filter_eq_self.mpr]
  · rw [← Nat.map_div_right_divisors]
    simp
  intro p hp
  obtain ⟨hprod,hn₀⟩ := Nat.mem_divisorsAntidiagonal.mp hp
  exact ⟨(Nat.le_of_dvd (Nat.pos_of_ne_zero hn₀) ⟨p.2,hprod.symm⟩).trans hn,
    (Nat.le_of_dvd (Nat.pos_of_ne_zero hn₀) ⟨p.1,by rw [mul_comm,hprod]⟩).trans hn⟩

theorem truncatedZetaSquare_support {N n : ℕ} (hn : N*N < n) :
    truncatedZetaSquare N n = 0 := by
  rw [truncatedZetaSquare_apply]
  have he : (n.divisorsAntidiagonal.filter fun p => p.1 ≤ N ∧ p.2 ≤ N) = ∅ := by
    apply Finset.eq_empty_iff_forall_notMem.mpr
    intro p hp
    obtain ⟨hmem,h₁,h₂⟩ := Finset.mem_filter.mp hp
    have hprod := (Nat.mem_divisorsAntidiagonal.mp hmem).1
    exact (not_le_of_gt hn) (hprod ▸ Nat.mul_le_mul h₁ h₂)
  simp [he]

/-- Squaring the Euler polynomial gives a single Dirichlet polynomial. -/
theorem euler_sum_sq_eq_finiteSeries (N : ℕ) (s : ℂ) :
    (∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s))^2 =
      finiteSeries (truncatedZetaSquare N) (N*N) s := by
  have he : finiteSeries (ζ : ArithmeticFunction ℂ) N s =
      ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s) := by
    apply Finset.sum_congr rfl
    intro n hn
    have hn₀ : n ≠ 0 := by have := (Finset.mem_Icc.mp hn).1; omega
    simp [ArithmeticFunction.natCoe_apply,ArithmeticFunction.zeta_apply_ne hn₀]
  rw [← he,← LSeries_eq_finiteSeries_of_support _ _ s (fun _ => truncatedZetaSquare_support),
    truncatedZetaSquare,ArithmeticFunction.LSeries_mul' (truncated_summable N _ s)
      (truncated_summable N _ s),LSeries_truncate_eq_finiteSeries,sq]

private theorem eulerHalfCoefficient_eq_real (n : ℕ) :
    (n : ℂ)^(-(1/2 : ℂ)) = (((√(n : ℝ))⁻¹ : ℝ) : ℂ) := by
  rw [show -(1/2 : ℂ) = ((-(1/2 : ℝ) : ℝ) : ℂ) by norm_num,
    ← Complex.ofReal_natCast,← Complex.ofReal_cpow (Nat.cast_nonneg n),Real.rpow_neg (Nat.cast_nonneg n),
    ← Real.sqrt_eq_rpow]

/-- The sum of the absolute critical coefficients is at most four times the cutoff. -/
theorem sum_norm_truncatedZetaSquare_vertical_le (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 (N*N), ‖verticalCoefficients (truncatedZetaSquare N) (1/2) n‖) ≤ 4*N := by
  let S := Finset.Icc 1 (N*N)
  let H := ∑ n ∈ Finset.Icc 1 N, (√(n : ℝ))⁻¹
  have he : (∑ n ∈ S, ‖verticalCoefficients (truncatedZetaSquare N) (1/2) n‖) = H^2 := by
    have hs := euler_sum_sq_eq_finiteSeries N (1/2)
    have hh (n : ℕ) (_hn : n ∈ Finset.Icc 1 N) :
        (n : ℂ)^(-(1/2 : ℂ)) = ↑((√(n : ℝ))⁻¹) :=
      eulerHalfCoefficient_eq_real n
    rw [Finset.sum_congr rfl hh,← Complex.ofReal_sum,← Complex.ofReal_pow] at hs
    change (↑(H^2) : ℂ) = _ at hs
    rw [← Complex.ofReal_re (H^2),hs]
    unfold finiteSeries
    rw [Complex.re_sum]
    exact Finset.sum_congr rfl (fun n hn => by
      have hp := eulerHalfCoefficient_eq_real n
      rw [verticalCoefficients,show ((1/2 : ℝ) : ℂ) = 1/2 by norm_num,
        truncatedZetaSquare_apply,hp,← Complex.ofReal_natCast,← Complex.ofReal_mul,
        Complex.norm_real,Complex.ofReal_re,Real.norm_eq_abs,abs_of_nonneg (by positivity)])
  have hH : 0 ≤ H := Finset.sum_nonneg fun _ _ => by positivity
  rw [he]
  calc
    _ ≤ (2*√(N : ℝ))^2 := pow_le_pow_left₀ hH (sum_inv_sqrt_Icc_le N) 2
    _ = _ := by rw [mul_pow,Real.sq_sqrt (Nat.cast_nonneg N)]; norm_num

end Legendre.Density.Detector
