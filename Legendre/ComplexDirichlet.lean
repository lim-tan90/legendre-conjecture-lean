/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The real-part differentiation argument adapts BetaDerivative.lean from
openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The local version removes Dirichlet characters and bridges to the existing
Dirichlet-polynomial mean-square interface. The upstream license is retained
in licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.DirichletSamplingSharp
public import Legendre.ZeroDetector.BetaVariation
public import Mathlib.Analysis.Complex.RealDeriv
public import Mathlib.Analysis.SpecialFunctions.Pow.Deriv

/-!
# Finite Dirichlet polynomials at varying real parts

Zeros need not have the same real part. These interfaces retain that variation
and connect complex evaluation to the proved imaginary-axis mean values.
-/

@[expose] public section

namespace Legendre.Density

open Complex

noncomputable def complexDirichletPolynomial (N : ℕ) (a : ℕ → ℂ) (s : ℂ) : ℂ :=
  ∑ n ∈ Finset.Icc 1 N, a n*(n : ℂ)^(-s)

noncomputable def verticalCoefficients (a : ℕ → ℂ) (σ : ℝ) (n : ℕ) : ℂ :=
  a n*(n : ℂ)^(-(σ : ℂ))

noncomputable def logDerivativeCoefficients (a : ℕ → ℂ) (n : ℕ) : ℂ :=
  -Complex.log n*a n

/-- Complex evaluation on a vertical line agrees with the existing phase convention. -/
theorem complexDirichletPolynomial_vertical (N : ℕ) (a : ℕ → ℂ) (σ t : ℝ) :
    complexDirichletPolynomial N a ((σ : ℂ)+(t : ℂ)*I) =
      dirichletPolynomial N (verticalCoefficients a σ) t := by
  unfold complexDirichletPolynomial dirichletPolynomial exponentialSum
  apply Finset.sum_congr rfl
  intro n hn
  have hnpos : (0 : ℝ) < n := by exact_mod_cast (Finset.mem_Icc.1 hn).1
  have hn0 : (n : ℂ) ≠ 0 := by exact_mod_cast hnpos.ne'
  rw [realPhase_neg_log_eq_cpow hnpos t,ofReal_natCast]
  unfold verticalCoefficients
  rw [mul_assoc,← cpow_add _ _ hn0]
  congr 2
  ring

/-- The norm of a vertical coefficient is the usual real weight n^(-σ). -/
theorem norm_verticalCoefficients (a : ℕ → ℂ) (σ : ℝ) {n : ℕ} (hn : 0 < n) :
    ‖verticalCoefficients a σ n‖ = ‖a n‖*(n : ℝ)^(-σ) := by
  rw [verticalCoefficients,norm_mul,norm_natCast_cpow_of_pos hn]
  simp only [neg_re,ofReal_re]

/-- Moving right decreases coefficient energy, with no sign restriction on σ. -/
theorem vertical_coefficientEnergy_mono (N : ℕ) (a : ℕ → ℂ) {σ β : ℝ} (hσβ : σ ≤ β) :
    coefficientEnergy (Finset.Icc 1 N) (verticalCoefficients a β) ≤
      coefficientEnergy (Finset.Icc 1 N) (verticalCoefficients a σ) := by
  apply Finset.sum_le_sum
  intro n hn
  have hn1 := (Finset.mem_Icc.1 hn).1
  have hnp : 0 < n := Nat.zero_lt_one.trans_le hn1
  rw [norm_verticalCoefficients a β hnp,norm_verticalCoefficients a σ hnp]
  apply pow_le_pow_left₀ (mul_nonneg (norm_nonneg _) (Real.rpow_nonneg (Nat.cast_nonneg _) _))
  apply mul_le_mul_of_nonneg_left _ (norm_nonneg _)
  exact Real.rpow_le_rpow_of_exponent_le (by exact_mod_cast hn1) (neg_le_neg hσβ)

/-- The logarithmic derivative has the expected coefficient norm bound. -/
theorem norm_logDerivativeCoefficients_le (a : ℕ → ℂ) {n N : ℕ}
    (hn : 1 ≤ n) (hnN : n ≤ N) :
    ‖logDerivativeCoefficients a n‖ ≤ Real.log N*‖a n‖ := by
  have hnR : (1 : ℝ) ≤ n := by exact_mod_cast hn
  have hlog : ‖Complex.log (n : ℂ)‖ = Real.log n := by
    rw [← Complex.natCast_log,Complex.norm_real,Real.norm_eq_abs,
      abs_of_nonneg (Real.log_nonneg hnR)]
  rw [logDerivativeCoefficients,norm_mul,norm_neg,hlog]
  exact mul_le_mul_of_nonneg_right
    (Real.log_le_log (zero_lt_one.trans_le hnR) (by exact_mod_cast hnN)) (norm_nonneg _)

/-- At each real part, one β derivative costs at most log²N in coefficient energy. -/
theorem logDerivative_vertical_energy_le (N : ℕ) (a : ℕ → ℂ) (σ : ℝ) :
    coefficientEnergy (Finset.Icc 1 N) (verticalCoefficients (logDerivativeCoefficients a) σ) ≤
      (Real.log N)^2*coefficientEnergy (Finset.Icc 1 N) (verticalCoefficients a σ) := by
  unfold coefficientEnergy
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro n hn
  have hnp : 0 < n := Nat.zero_lt_one.trans_le (Finset.mem_Icc.1 hn).1
  rw [norm_verticalCoefficients _ σ hnp,norm_verticalCoefficients _ σ hnp]
  have hh := mul_le_mul_of_nonneg_right
    (norm_logDerivativeCoefficients_le a (Finset.mem_Icc.1 hn).1 (Finset.mem_Icc.1 hn).2)
    (Real.rpow_nonneg (Nat.cast_nonneg n) (-σ))
  have hp := pow_le_pow_left₀
    (mul_nonneg (norm_nonneg _) (Real.rpow_nonneg (Nat.cast_nonneg n) (-σ))) hh 2
  convert! hp using 1
  ring

/-- Real-part differentiation of the actual finite complex polynomial. -/
theorem complexDirichletPolynomial_hasDerivAt_beta (N : ℕ) (a : ℕ → ℂ) (γ β : ℝ) :
    HasDerivAt (fun b : ℝ => complexDirichletPolynomial N a ((b : ℂ)+(γ : ℂ)*I))
      (complexDirichletPolynomial N (logDerivativeCoefficients a) ((β : ℂ)+(γ : ℂ)*I)) β := by
  unfold complexDirichletPolynomial
  apply HasDerivAt.fun_sum
  intro n hn
  have hn0 : (n : ℂ) ≠ 0 := by
    have hn1 := (Finset.mem_Icc.1 hn).1
    exact_mod_cast (by omega : n ≠ 0)
  have hcomplex := (((hasDerivAt_id (β : ℂ)).add_const ((γ : ℂ)*I)).neg).const_cpow
    (c := (n : ℂ)) (Or.inl hn0)
  convert! hcomplex.comp_ofReal.const_mul (a n) using 1
  dsimp [logDerivativeCoefficients]
  ring

/-- Continuous dependence on the real part, including polynomial zeros. -/
theorem continuous_complexDirichletPolynomial_beta (N : ℕ) (a : ℕ → ℂ) (γ : ℝ) :
    Continuous (fun β : ℝ => complexDirichletPolynomial N a ((β : ℂ)+(γ : ℂ)*I)) :=
  continuous_iff_continuousAt.2 (fun β => (complexDirichletPolynomial_hasDerivAt_beta N a γ β).continuousAt)

end Legendre.Density
