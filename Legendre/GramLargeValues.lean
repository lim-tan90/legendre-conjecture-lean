/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The quadratic row-bound proof generalizes openai/math at commit
4eaee87548250b2682affda7d05d947c05554bae,
lean/OAI/NumberTheory/Ostmann/Preliminaries/SymmetricQuadraticBound.lean.
See licenses/openai-math-Apache-2.0.txt for its original license.
-/
module

public import Legendre.LargeSieve.FiniteMatrixDuality
public import Legendre.DirichletMeanValue

/-!
# Gram-matrix bounds underlying the Halasz--Montgomery method

The coefficient vector is controlled by absolute row sums of its sample Gram
matrix. This finite-dimensional theorem makes its analytic kernel hypothesis
explicit and does not assume a zero-density theorem.
-/

@[expose] public section

namespace Legendre.Density

open Matrix Complex

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- A symmetric absolute kernel bounds its complex quadratic form by weighted row sums. -/
theorem complex_quadratic_le_norm_rows (K : Matrix ι ι ℂ)
    (hsym : ∀ i j, ‖K i j‖ = ‖K j i‖) (u : ι → ℂ) :
    ‖star u ⬝ᵥ (K *ᵥ u)‖ ≤ ∑ i, ‖u i‖^2*(∑ j, ‖K i j‖) := by
  have hswap : (∑ i, ∑ j, ‖K i j‖*‖u j‖^2) = ∑ i, ∑ j, ‖K i j‖*‖u i‖^2 := by
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro i hi
    apply Finset.sum_congr rfl
    intro j hj
    rw [hsym j i]
  have hfactor : (∑ i, ∑ j, ‖K i j‖*‖u i‖^2) = ∑ i, ‖u i‖^2*(∑ j, ‖K i j‖) := by
    apply Finset.sum_congr rfl
    intro i hi
    rw [← Finset.sum_mul, mul_comm]
  have havg : (∑ i, ∑ j, ‖K i j‖*(‖u i‖^2+‖u j‖^2)/2) =
      ∑ i, ‖u i‖^2*(∑ j, ‖K i j‖) := by
    simp_rw [mul_add, add_div, Finset.sum_add_distrib, ← Finset.sum_div]
    rw [hswap, hfactor]
    ring
  have he : star u ⬝ᵥ (K *ᵥ u) = ∑ i, ∑ j, star (u i)*K i j*u j := by
    simp only [dotProduct, mulVec, Pi.star_apply, Finset.mul_sum, mul_assoc]
  rw [he]
  calc
    _ ≤ ∑ i, ∑ j, ‖star (u i)*K i j*u j‖ :=
      (norm_sum_le _ _).trans (Finset.sum_le_sum (fun i _hi => norm_sum_le _ _))
    _ = ∑ i, ∑ j, ‖K i j‖*‖u i‖*‖u j‖ := by
      simp only [norm_mul, norm_star]
      apply Finset.sum_congr rfl
      intro i hi
      apply Finset.sum_congr rfl
      intro j hj
      ring
    _ ≤ ∑ i, ∑ j, ‖K i j‖*(‖u i‖^2+‖u j‖^2)/2 := by
      apply Finset.sum_le_sum
      intro i hi
      apply Finset.sum_le_sum
      intro j hj
      nlinarith [mul_nonneg (norm_nonneg (K i j)) (sq_nonneg (‖u i‖-‖u j‖))]
    _ = _ := havg

omit [Fintype ι] in
/-- Absolute symmetry of the sample Gram matrix. -/
theorem gram_norm_symmetric (F : Matrix ι κ ℂ) (i j : ι) :
    ‖(F*Fᴴ) i j‖ = ‖(F*Fᴴ) j i‖ := by
  have he : star ((F*Fᴴ) i j) = (F*Fᴴ) j i := by
    simp only [Matrix.mul_apply, conjTranspose_apply, star_sum, star_mul, star_star]
  rw [← he, norm_star]

/-- A Gram row bound transfers to every complex coefficient vector by finite duality. -/
theorem finite_gram_row_bound (F : Matrix ι κ ℂ) {R : ℝ} (hR : 0 ≤ R)
    (hrow : ∀ i, ∑ j, ‖(F*Fᴴ) i j‖ ≤ R) (a : κ → ℂ) :
    (∑ i, ‖(F *ᵥ a) i‖^2) ≤ R*(∑ n, ‖a n‖^2) := by
  apply LargeSieve.finite_matrix_duality F R hR
  intro b
  have hq := complex_quadratic_le_norm_rows (F*Fᴴ) (gram_norm_symmetric F) b
  have hi : star (Fᴴ *ᵥ b) ⬝ᵥ (Fᴴ *ᵥ b) = star b ⬝ᵥ ((F*Fᴴ) *ᵥ b) := by
    rw [star_mulVec, conjTranspose_conjTranspose, ← dotProduct_mulVec, mulVec_mulVec]
  rw [← hi, LargeSieve.complex_self_quadratic, norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Finset.sum_nonneg (fun i _hi => sq_nonneg ‖(Fᴴ *ᵥ b) i‖))] at hq
  apply hq.trans
  calc
    _ ≤ ∑ i, ‖b i‖^2*R :=
      Finset.sum_le_sum (fun i _hi => mul_le_mul_of_nonneg_left (hrow i) (sq_nonneg _))
    _ = _ := by rw [← Finset.sum_mul, mul_comm]


/-- Multiplication and conjugation subtract sample times at the same frequency. -/
theorem realPhase_time_difference (u s t : ℝ) :
    realPhase u s*star (realPhase u t) = realPhase u (s-t) := by
  have hcomm (x y : ℝ) : realPhase x y = realPhase y x := by
    unfold realPhase
    congr 1
    push_cast
    ring
  rw [hcomm u s, hcomm u t, realPhase_mul_conj, hcomm]

/-- Finite exponential samples are controlled by actual pair-correlation kernel row sums. -/
theorem exponential_samples_le_gram_rows (t : ι → ℝ) (ν : κ → ℝ) (a : κ → ℂ)
    {R : ℝ} (hR : 0 ≤ R)
    (hrow : ∀ i, ∑ j, ‖∑ n, realPhase (ν n) (t i-t j)‖ ≤ R) :
    (∑ i, ‖∑ n, a n*realPhase (ν n) (t i)‖^2) ≤ R*(∑ n, ‖a n‖^2) := by
  let F : Matrix ι κ ℂ := fun i n => realPhase (ν n) (t i)
  have hG (i j : ι) : (F*Fᴴ) i j = ∑ n, realPhase (ν n) (t i-t j) := by
    dsimp only [F]
    apply Finset.sum_congr rfl
    intro n hn
    exact realPhase_time_difference _ _ _
  have hr : ∀ i, ∑ j, ‖(F*Fᴴ) i j‖ ≤ R := by
    intro i
    simpa only [hG] using hrow i
  simpa only [F, Matrix.mulVec, dotProduct, mul_comm] using!
    finite_gram_row_bound F hR hr a

/-- The Halasz--Montgomery finite Gram estimate for ordinary Dirichlet polynomials. -/
theorem dirichlet_samples_le_gram_rows (t : ι → ℝ) (N : ℕ) (a : ℕ → ℂ)
    {R : ℝ} (hR : 0 ≤ R)
    (hrow : ∀ i, ∑ j, ‖dirichletPolynomial N (fun _ => 1) (t i-t j)‖ ≤ R) :
    (∑ i, ‖dirichletPolynomial N a (t i)‖^2) ≤ R*coefficientEnergy (Finset.Icc 1 N) a := by
  classical
  let S : Finset ℕ := Finset.Icc 1 N
  have hsum (f : ℕ → ℂ) : (∑ n : S, f n.val) = ∑ n ∈ S, f n :=
    Finset.sum_coe_sort S f
  have hkernel (u : ℝ) : (∑ n : S, realPhase (-Real.log (n.val : ℝ)) u) =
      dirichletPolynomial N (fun _ => 1) u := by
    rw [hsum (fun n : ℕ => realPhase (-Real.log (n : ℝ)) u)]
    simp only [dirichletPolynomial, exponentialSum, one_mul, S]
  have hpoly (u : ℝ) : (∑ n : S, a n.val*realPhase (-Real.log (n.val : ℝ)) u) =
      dirichletPolynomial N a u := by
    rw [hsum (fun n : ℕ => a n*realPhase (-Real.log (n : ℝ)) u)]
    rfl
  have hE : (∑ n : S, ‖a n.val‖^2) = coefficientEnergy (Finset.Icc 1 N) a :=
    Finset.sum_coe_sort S (fun n => ‖a n‖^2)
  have h := exponential_samples_le_gram_rows (κ := S) t
    (fun n => -Real.log (n.val : ℝ)) (fun n => a n.val) hR (fun i => by
      simpa only [hkernel] using hrow i)
  simpa only [hpoly, hE] using h

end Legendre.Density
