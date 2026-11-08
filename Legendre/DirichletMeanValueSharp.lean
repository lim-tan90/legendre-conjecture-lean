/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.SeparatedMeanValue
public import Legendre.DirichletMeanValue

/-!
# A linear-error mean-square theorem for Dirichlet polynomials

The proved real-line Hilbert inequality removes the harmonic row-sum loss.
The bound is uniform in both interval endpoints and includes empty support.
-/

@[expose] public section

namespace Legendre.Density

open Complex MeasureTheory

/-- Logarithmic frequencies up to N are separated by 1/N. -/
theorem dirichlet_frequencies_separated (N : ℕ) :
    LargeSieve.LineSeparated (fun n : Finset.Icc 1 N => -Real.log (n.val : ℝ))
      (1/(N : ℝ)) := by
  intro m n hne
  have hmpos : (0 : ℝ) < m.val := by exact_mod_cast (Finset.mem_Icc.1 m.property).1
  have hnpos : (0 : ℝ) < n.val := by exact_mod_cast (Finset.mem_Icc.1 n.property).1
  have hne' : m.val ≠ n.val := fun he => hne (Subtype.ext he)
  have hordered (i j : ℕ) (hi : 0 < (i : ℝ)) (hij : i < j) (hj : j ≤ N) :
      1/(N : ℝ) ≤ Real.log (j : ℝ)-Real.log (i : ℝ) := by
    have hjpos : (0 : ℝ) < j := hi.trans (by exact_mod_cast hij)
    have hunit : (1 : ℝ) ≤ (j : ℝ)-i := by
      have hc : (i : ℝ)+1 ≤ j := by exact_mod_cast (by omega : i+1 ≤ j)
      linarith
    have hjN : (j : ℝ) ≤ N := by exact_mod_cast hj
    calc
      1/(N : ℝ) ≤ 1/(j : ℝ) := one_div_le_one_div_of_le hjpos hjN
      _ ≤ ((j : ℝ)-i)/j := (div_le_div_iff_of_pos_right hjpos).2 hunit
      _ ≤ _ := log_gap_lower hi hjpos
  simp only [neg_sub_neg]
  rcases lt_or_gt_of_ne hne' with hmn | hnm
  · rw [abs_of_pos (sub_pos.2 (Real.strictMonoOn_log hmpos hnpos (by exact_mod_cast hmn)))]
    exact hordered m.val n.val hmpos hmn (Finset.mem_Icc.1 n.property).2
  · rw [abs_of_neg (sub_neg.2 (Real.strictMonoOn_log hnpos hmpos (by exact_mod_cast hnm)))]
    simpa only [neg_sub] using hordered n.val m.val hnpos hnm (Finset.mem_Icc.1 m.property).2

/-- Uniform O(N) error, obtained from a proved Hilbert inequality. -/
theorem abs_integral_dirichletPolynomial_sub_diagonal_le_linear
    (N : ℕ) (a : ℕ → ℂ) (A B : ℝ) :
    |(∫ t : ℝ in A..B, ‖dirichletPolynomial N a t‖^2)-
      (B-A)*coefficientEnergy (Finset.Icc 1 N) a| ≤
      2*Real.pi*(N : ℝ)*coefficientEnergy (Finset.Icc 1 N) a := by
  classical
  by_cases hN : N = 0
  · subst N
    simp [dirichletPolynomial,exponentialSum,coefficientEnergy]
  have hNpos : (0 : ℝ) < N := by exact_mod_cast Nat.pos_of_ne_zero hN
  let S := Finset.Icc 1 N
  have hsumC (f : ℕ → ℂ) : (∑ n : S, f n.val) = ∑ n ∈ S, f n :=
    Finset.sum_coe_sort S f
  have hsumR (f : ℕ → ℝ) : (∑ n : S, f n.val) = ∑ n ∈ S, f n :=
    Finset.sum_coe_sort S f
  have hpoly (t : ℝ) :
      exponentialSum Finset.univ (fun n : S => a n.val)
        (fun n : S => -Real.log (n.val : ℝ)) t = dirichletPolynomial N a t := by
    unfold exponentialSum dirichletPolynomial
    exact hsumC (fun n => a n*realPhase (-Real.log (n : ℝ)) t)
  have henergy : coefficientEnergy Finset.univ (fun n : S => a n.val) =
      coefficientEnergy S a := hsumR (fun n => ‖a n‖^2)
  have h := abs_integral_exponentialSum_sub_diagonal_le_separation
    (fun n : S => -Real.log (n.val : ℝ)) (fun n : S => a n.val)
    (one_div_pos.2 hNpos) (dirichlet_frequencies_separated N) A B
  simp_rw [hpoly,henergy] at h
  dsimp [S] at h
  simpa only [div_div_eq_mul_div,div_one] using h

/-- Upper mean-square bound with linear rather than harmonic length error. -/
theorem integral_dirichletPolynomial_norm_sq_le_linear
    (N : ℕ) (a : ℕ → ℂ) (A B : ℝ) :
    (∫ t : ℝ in A..B, ‖dirichletPolynomial N a t‖^2) ≤
      (B-A+2*Real.pi*(N : ℝ))*coefficientEnergy (Finset.Icc 1 N) a := by
  have h := (le_abs_self _).trans
    (abs_integral_dirichletPolynomial_sub_diagonal_le_linear N a A B)
  nlinarith

end Legendre.Density
