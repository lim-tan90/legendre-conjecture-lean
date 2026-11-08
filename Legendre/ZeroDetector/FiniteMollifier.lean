/-
Adapted from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae.
Originals: lean/OAI/NumberTheory/Ostmann/ZeroDensity/FiniteDetector.lean
and Mollifier.lean. Apache-2.0; retained license:
licenses/openai-math-Apache-2.0.txt.
Changes: specialize the finite-series identity to untwisted coefficients,
remove Dirichlet-character dependencies, and expose local v4.35.0 modules.
-/
module

public import Legendre.ZeroDetector.Mollifier
public import Legendre.DirichletMeanValueSharp

/-!
# Exact finite mollifier identity for the Riemann-zeta detector

The identity holds for every complex s and needs no convergent infinite
Dirichlet series in the critical strip. Analytic smallness is a separate input.
-/

@[expose] public section

namespace Legendre.Density.Detector

open scoped ArithmeticFunction.Moebius ArithmeticFunction.zeta LSeries.notation

/-- Finite Dirichlet series at a complex argument. -/
noncomputable def finiteSeries (f : ArithmeticFunction ℂ) (N : ℕ) (s : ℂ) : ℂ :=
  ∑ n ∈ Finset.Icc 1 N, f n*(n : ℂ)^(-s)

/-- Finite support makes the infinite-series expression exact at every s. -/
theorem LSeries_eq_finiteSeries_of_support (f : ArithmeticFunction ℂ) (N : ℕ) (s : ℂ)
    (hsupport : ∀ n, N < n → f n = 0) : LSeries f s = finiteSeries f N s := by
  unfold LSeries finiteSeries
  rw [tsum_eq_sum (s := Finset.Icc 1 N)]
  · apply Finset.sum_congr rfl
    intro n hn
    rw [LSeries.term_def₀ (by simp)]
  · intro n hn
    rw [LSeries.term_def₀ (by simp)]
    by_cases hnzero : n = 0
    · simp [hnzero]
    · have hNn : N < n := by simp only [Finset.mem_Icc] at hn; omega
      simp [hsupport n hNn]

theorem LSeries_truncate_eq_finiteSeries (f : ArithmeticFunction ℂ) (N : ℕ) (s : ℂ) :
    LSeries (truncate N f) s = finiteSeries f N s := by
  rw [LSeries_eq_finiteSeries_of_support (truncate N f) N s
    (by intro n hn; simp [not_le_of_gt hn])]
  unfold finiteSeries
  apply Finset.sum_congr rfl
  intro n hn
  simp [(Finset.mem_Icc.mp hn).2]

theorem truncated_summable (N : ℕ) (f : ArithmeticFunction ℂ) (s : ℂ) :
    LSeriesSummable (truncate N f) s := by
  apply summable_of_ne_finset_zero (s := Finset.range (N+1))
  intro n hn
  have hnN : ¬n ≤ N := by simpa using hn
  simp [LSeries.term,hnN]

/-- Dirichlet convolution multiplies the two finite series, at every s. -/
theorem mollifier_product (X N : ℕ) (s : ℂ) :
    LSeries (mollifierCoefficient X N) s =
      finiteSeries (μ : ArithmeticFunction ℂ) X s *
        finiteSeries (ζ : ArithmeticFunction ℂ) N s := by
  rw [mollifierCoefficient,ArithmeticFunction.LSeries_mul'
    (truncated_summable X _ s) (truncated_summable N _ s),
    LSeries_truncate_eq_finiteSeries,LSeries_truncate_eq_finiteSeries]

/-- The detector has no coefficient in the Möbius cancellation range. -/
noncomputable def detectorPolynomial (X N : ℕ) (s : ℂ) : ℂ :=
  ∑ n ∈ Finset.Ioc X (X*N), mollifierCoefficient X N n*(n : ℂ)^(-s)

theorem mollifier_polynomial_split {X N : ℕ} (hX : 1 ≤ X) (hXN : X ≤ N) (s : ℂ) :
    finiteSeries (mollifierCoefficient X N) (X*N) s = 1+detectorPolynomial X N s := by
  classical
  have hN : 1 ≤ N := hX.trans hXN
  have hprod : 1 ≤ X*N := by have := Nat.mul_pos (by omega : 0 < X) (by omega : 0 < N); omega
  let f : ℕ → ℂ := fun n => mollifierCoefficient X N n*(n : ℂ)^(-s)
  have hsub : insert 1 (Finset.Ioc X (X*N)) ⊆ Finset.Icc 1 (X*N) := by
    intro n hn
    rcases Finset.mem_insert.mp hn with rfl | hn
    · exact Finset.mem_Icc.mpr ⟨le_rfl,hprod⟩
    · exact Finset.mem_Icc.mpr ⟨by have := (Finset.mem_Ioc.mp hn).1; omega,(Finset.mem_Ioc.mp hn).2⟩
  have hsum : ∑ n ∈ insert 1 (Finset.Ioc X (X*N)), f n = ∑ n ∈ Finset.Icc 1 (X*N), f n := by
    apply Finset.sum_subset hsub
    intro n hn hnot
    have hnot1 : n ≠ 1 := by intro h; subst n; exact hnot (Finset.mem_insert_self _ _)
    have hnotIoc : n ∉ Finset.Ioc X (X*N) := fun h => hnot (Finset.mem_insert_of_mem h)
    have hnX : n ≤ X := by
      have hnmax := (Finset.mem_Icc.mp hn).2
      simp only [Finset.mem_Ioc] at hnotIoc
      omega
    have hn2 : 2 ≤ n := by have := (Finset.mem_Icc.mp hn).1; omega
    simp [f,mollifierCoefficient_vanish hXN hn2 hnX]
  rw [Finset.sum_insert (show 1 ∉ Finset.Ioc X (X*N) by simp; omega)] at hsum
  have hf1 : f 1 = 1 := by simp [f,mollifierCoefficient_one hX hN]
  rw [hf1] at hsum
  exact hsum.symm

/-- Exact cancellation identity, including arguments outside absolute convergence. -/
theorem finite_mollifier_identity {X N : ℕ} (hX : 1 ≤ X) (hXN : X ≤ N) (s : ℂ) :
    finiteSeries (μ : ArithmeticFunction ℂ) X s *
      finiteSeries (ζ : ArithmeticFunction ℂ) N s = 1+detectorPolynomial X N s := by
  rw [← mollifier_product,LSeries_eq_finiteSeries_of_support _ (X*N) s
    (fun _ hn => mollifierCoefficient_support hn)]
  exact mollifier_polynomial_split hX hXN s

/-- An analytic small-product estimate would force the finite detector to be large. -/
theorem detector_large_of_small_product {X N : ℕ} (hX : 1 ≤ X) (hXN : X ≤ N) (s : ℂ)
    (hsmall : ‖finiteSeries (μ : ArithmeticFunction ℂ) X s *
      finiteSeries (ζ : ArithmeticFunction ℂ) N s‖ ≤ 1/2) :
    1/2 ≤ ‖detectorPolynomial X N s‖ := by
  rw [finite_mollifier_identity hX hXN s] at hsmall
  have htriangle := norm_sub_le (1+detectorPolynomial X N s) (detectorPolynomial X N s)
  simp only [add_sub_cancel_right,norm_one] at htriangle
  linarith

/-- Möbius coefficients have modulus at most one, including n=0. -/
theorem norm_moebius_le_one (n : ℕ) : ‖(μ n : ℂ)‖ ≤ 1 := by
  rcases ArithmeticFunction.moebius_eq_or n with hm | hm | hm <;> simp [hm]

/-- An unconditional norm bound for the finite Möbius polynomial. -/
theorem norm_mollifier_finiteSeries_le (X : ℕ) {s : ℂ} (hs : 0 ≤ s.re) :
    ‖finiteSeries (μ : ArithmeticFunction ℂ) X s‖ ≤ (X : ℝ) := by
  unfold finiteSeries
  calc
    _ ≤ ∑ n ∈ Finset.Icc 1 X, ‖(μ : ArithmeticFunction ℂ) n*(n : ℂ)^(-s)‖ := norm_sum_le _ _
    _ ≤ ∑ _n ∈ Finset.Icc 1 X, (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro n hn
      have hn1 := (Finset.mem_Icc.1 hn).1
      have hnpos : 0 < n := Nat.zero_lt_one.trans_le hn1
      have hpower : ‖(n : ℂ)^(-s)‖ ≤ 1 := by
        rw [Complex.norm_natCast_cpow_of_pos hnpos]
        exact Real.rpow_le_one_of_one_le_of_nonpos (by exact_mod_cast hn1) (by simpa)
      rw [norm_mul]
      have hmu : ‖(μ : ArithmeticFunction ℂ) n‖ ≤ 1 := by
        simpa only [ArithmeticFunction.intCoe_apply] using norm_moebius_le_one n
      simpa only [one_mul] using mul_le_mul hmu hpower (norm_nonneg _) zero_le_one
    _ = _ := by simp

/-- The constant arithmetic zeta coefficients give the usual finite zeta sum. -/
theorem finiteSeries_zeta_eq (N : ℕ) (s : ℂ) :
    finiteSeries (ζ : ArithmeticFunction ℂ) N s = ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s) := by
  unfold finiteSeries
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : n ≠ 0 := by have := (Finset.mem_Icc.1 hn).1; omega
  simp [ArithmeticFunction.natCoe_apply,ArithmeticFunction.zeta_apply_ne hn0]

end Legendre.Density.Detector
