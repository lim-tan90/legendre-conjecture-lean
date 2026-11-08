/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ExponentialMeanValue
public import Legendre.DirichletSpacing

/-!
# Elementary mean-square estimates for Dirichlet polynomials

For P(t)=Σ_{1≤n≤N} a(n)n^(-it), the deviation from interval length times
Σ|a(n)|² is at most 4 N H_N Σ|a(n)|², uniformly in both endpoints.
This elementary O(N log N) error is weaker than Montgomery--Vaughan's O(N)
mean-value theorem; no such stronger result is claimed or assumed.
-/

@[expose] public section

namespace Legendre.Density

open Complex MeasureTheory Filter Topology

/-- A finite Dirichlet polynomial on the imaginary axis; n=0 is excluded. -/
noncomputable def dirichletPolynomial (N : ℕ) (a : ℕ → ℂ) (t : ℝ) : ℂ :=
  exponentialSum (Finset.Icc 1 N) a (fun n => -Real.log n) t

/-- The real-frequency convention agrees with the usual complex power. -/
theorem realPhase_neg_log_eq_cpow {x : ℝ} (hx : 0 < x) (t : ℝ) :
    realPhase (-Real.log x) t = (x : ℂ)^(-(t : ℂ)*I) := by
  rw [cpow_def_of_ne_zero (ofReal_ne_zero.mpr hx.ne'), ← ofReal_log hx.le]
  unfold realPhase
  congr 1
  push_cast
  ring

/-- Usual Σ a(n)n^(-it) notation, valid for every N including zero. -/
theorem dirichletPolynomial_eq_sum (N : ℕ) (a : ℕ → ℂ) (t : ℝ) :
    dirichletPolynomial N a t = ∑ n ∈ Finset.Icc 1 N, a n*(n : ℂ)^(-(t : ℂ)*I) := by
  unfold dirichletPolynomial exponentialSum
  apply Finset.sum_congr rfl
  intro n hn
  rw [realPhase_neg_log_eq_cpow (by exact_mod_cast (Finset.mem_Icc.1 hn).1), ofReal_natCast]

/-- Frequencies of distinct positive integer indices cannot coincide. -/
theorem dirichlet_frequencies_inj (N : ℕ) :
    Set.InjOn (fun n : ℕ => -Real.log n) (Finset.Icc 1 N : Set ℕ) := by
  intro m hm n hn he
  have hmpos : (0 : ℝ) < m := by exact_mod_cast (Finset.mem_Icc.1 hm).1
  have hnpos : (0 : ℝ) < n := by exact_mod_cast (Finset.mem_Icc.1 hn).1
  exact Nat.cast_injective (Real.strictMonoOn_log.injOn hmpos hnpos (neg_injective he))

/-- Continuity gives actual integrability on every finite interval. -/
theorem continuous_dirichletPolynomial (N : ℕ) (a : ℕ → ℂ) :
    Continuous (dirichletPolynomial N a) := continuous_exponentialSum _ _ _

/-- The off-diagonal cancellation error has an explicit harmonic energy bound. -/
theorem dirichlet_meanValueError_le (N : ℕ) (a : ℕ → ℂ) :
    meanValueError (Finset.Icc 1 N) a (fun n => -Real.log n) ≤
      4*(N : ℝ)*(harmonic N : ℝ)*coefficientEnergy (Finset.Icc 1 N) a := by
  have h := meanValueError_le_energy (Finset.Icc 1 N) a (fun n => -Real.log n)
    (R := 2*(N : ℝ)*(harmonic N : ℝ)) (fun m hm => by
      simpa only [neg_sub_neg, abs_sub_comm] using sum_inv_abs_log_gaps_le hm)
  convert h using 1; ring

/-- A uniform finite-interval mean-square theorem with analytic cancellation. -/
theorem abs_integral_dirichletPolynomial_sub_diagonal_le (N : ℕ) (a : ℕ → ℂ) (A B : ℝ) :
    |(∫ t : ℝ in A..B, ‖dirichletPolynomial N a t‖^2)-
      (B-A)*coefficientEnergy (Finset.Icc 1 N) a| ≤
      4*(N : ℝ)*(harmonic N : ℝ)*coefficientEnergy (Finset.Icc 1 N) a :=
  (abs_integral_exponentialSum_sub_diagonal_le _ _ _ (dirichlet_frequencies_inj N) A B).trans
    (dirichlet_meanValueError_le N a)

/-- The coefficient energy is nonnegative, also for empty support. -/
theorem coefficientEnergy_nonneg (S : Finset ℕ) (a : ℕ → ℂ) : 0 ≤ coefficientEnergy S a :=
  Finset.sum_nonneg (fun n _hn => sq_nonneg ‖a n‖)

/-- Logarithmic form of the finite-interval mean-square estimate. -/
theorem abs_integral_dirichletPolynomial_sub_diagonal_le_log (N : ℕ) (a : ℕ → ℂ) (A B : ℝ) :
    |(∫ t : ℝ in A..B, ‖dirichletPolynomial N a t‖^2)-
      (B-A)*coefficientEnergy (Finset.Icc 1 N) a| ≤
      4*(N : ℝ)*(1+Real.log N)*coefficientEnergy (Finset.Icc 1 N) a := by
  apply (abs_integral_dirichletPolynomial_sub_diagonal_le N a A B).trans
  apply mul_le_mul_of_nonneg_right _ (coefficientEnergy_nonneg _ _)
  exact mul_le_mul_of_nonneg_left (harmonic_le_one_add_log N) (by positivity)

/-- Upper mean-square bound with all coefficient and length dependence displayed. -/
theorem integral_dirichletPolynomial_norm_sq_le (N : ℕ) (a : ℕ → ℂ) (A B : ℝ) :
    (∫ t : ℝ in A..B, ‖dirichletPolynomial N a t‖^2) ≤
      (B-A+4*(N : ℝ)*(1+Real.log N))*coefficientEnergy (Finset.Icc 1 N) a := by
  have h := (le_abs_self _).trans (abs_integral_dirichletPolynomial_sub_diagonal_le_log N a A B)
  nlinarith

/-- For a fixed Dirichlet polynomial its long-interval mean is exactly the coefficient energy. -/
theorem tendsto_dirichletPolynomial_mean_square (N : ℕ) (a : ℕ → ℂ) :
    Tendsto (fun T : ℝ => (∫ t : ℝ in 0..T, ‖dirichletPolynomial N a t‖^2)/T)
      atTop (𝓝 (coefficientEnergy (Finset.Icc 1 N) a)) :=
  tendsto_exponentialSum_mean_square _ _ _ (dirichlet_frequencies_inj N)

end Legendre.Density
