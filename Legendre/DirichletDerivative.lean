/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.DirichletMeanValue
public import Mathlib.Analysis.InnerProductSpace.Calculus

/-!
# Derivatives of Dirichlet polynomials and their coefficient energies

Differentiation multiplies a coefficient by -i log n. Squared coefficient
energy grows by at most log²N on the support 1≤n≤N.
-/

@[expose] public section

namespace Legendre.Density

open Complex MeasureTheory

/-- Differentiating a real phase multiplies it by i times its frequency. -/
theorem realPhase_hasDerivAt (u t : ℝ) :
    HasDerivAt (realPhase u) (((u : ℂ)*I)*realPhase u t) t := by
  have hlin : HasDerivAt (fun x : ℝ => ((x*u : ℝ) : ℂ)*I) ((u : ℂ)*I) t :=
    by simpa only [id_eq, one_mul] using!
      (((hasDerivAt_id t).mul_const u).ofReal_comp).mul_const I
  unfold realPhase
  convert! hlin.cexp using 1; ring

/-- Derivative coefficients on the imaginary axis. -/
noncomputable def dirichletDerivativeCoefficients (a : ℕ → ℂ) (n : ℕ) : ℂ :=
  a n*((-(Real.log n) : ℂ)*I)

/-- The derivative is another Dirichlet polynomial with the same finite support. -/
theorem dirichletPolynomial_hasDerivAt (N : ℕ) (a : ℕ → ℂ) (t : ℝ) :
    HasDerivAt (dirichletPolynomial N a)
      (dirichletPolynomial N (dirichletDerivativeCoefficients a) t) t := by
  unfold dirichletPolynomial exponentialSum
  have h := HasDerivAt.sum (u := Finset.Icc 1 N)
    (fun n _hn => (realPhase_hasDerivAt (-Real.log n) t).const_mul (a n))
  convert! h using 1
  · funext u
    simp only [Finset.sum_apply]
  · apply Finset.sum_congr rfl
    intro n hn
    simp only [dirichletDerivativeCoefficients, ofReal_neg]
    ring

/-- Differentiated coefficient norm. -/
theorem norm_dirichletDerivativeCoefficients (a : ℕ → ℂ) (n : ℕ) :
    ‖dirichletDerivativeCoefficients a n‖ = ‖a n‖*|Real.log n| := by
  simp only [dirichletDerivativeCoefficients, norm_mul, norm_I, mul_one, norm_neg,
    norm_real, Real.norm_eq_abs]

/-- Coefficient energy of the derivative is controlled uniformly by log²N. -/
theorem derivative_coefficientEnergy_le (N : ℕ) (a : ℕ → ℂ) :
    coefficientEnergy (Finset.Icc 1 N) (dirichletDerivativeCoefficients a) ≤
      (Real.log N)^2*coefficientEnergy (Finset.Icc 1 N) a := by
  unfold coefficientEnergy
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro n hn
  have hn1 : (1 : ℝ) ≤ n := by exact_mod_cast (Finset.mem_Icc.1 hn).1
  have hnN : (n : ℝ) ≤ N := by exact_mod_cast (Finset.mem_Icc.1 hn).2
  have hn0 : (0 : ℝ) < n := by linarith
  have hlogn : 0 ≤ Real.log n := Real.log_nonneg hn1
  have hlogs := Real.log_le_log hn0 hnN
  have hlogN : 0 ≤ Real.log N := hlogn.trans hlogs
  rw [norm_dirichletDerivativeCoefficients, mul_pow, sq_abs]
  have hsq := (sq_le_sq₀ hlogn hlogN).2 hlogs
  nlinarith [mul_le_mul_of_nonneg_left hsq (sq_nonneg ‖a n‖)]

/-- The squared modulus has a continuous real derivative, including at polynomial zeros. -/
theorem dirichletPolynomial_norm_sq_hasDerivAt (N : ℕ) (a : ℕ → ℂ) (t : ℝ) :
    HasDerivAt (fun u : ℝ => ‖dirichletPolynomial N a u‖^2)
      (2*inner ℝ (dirichletPolynomial N a t)
        (dirichletPolynomial N (dirichletDerivativeCoefficients a) t)) t :=
  (dirichletPolynomial_hasDerivAt N a t).norm_sq

/-- An integrable quadratic majorant for the squared-modulus derivative. -/
theorem abs_norm_sq_derivative_le (N : ℕ) (a : ℕ → ℂ) (t : ℝ) :
    |2*inner ℝ (dirichletPolynomial N a t)
      (dirichletPolynomial N (dirichletDerivativeCoefficients a) t)| ≤
      ‖dirichletPolynomial N a t‖^2+
        ‖dirichletPolynomial N (dirichletDerivativeCoefficients a) t‖^2 := by
  rw [abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2)]
  have h := abs_real_inner_le_norm (dirichletPolynomial N a t)
    (dirichletPolynomial N (dirichletDerivativeCoefficients a) t)
  nlinarith [sq_nonneg (‖dirichletPolynomial N a t‖-
    ‖dirichletPolynomial N (dirichletDerivativeCoefficients a) t‖)]

end Legendre.Density
