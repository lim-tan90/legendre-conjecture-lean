/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.GramLargeValues

/-!
# Finite Halasz--Montgomery large-value inequalities

The analytic input is an upper bound on the off-diagonal correlation kernel.
This module derives a genuine cardinality inequality from that input, with
all coefficients and the large-value threshold kept explicit.
-/

@[expose] public section

namespace Legendre.Density

open Complex

/-- The unweighted correlation kernel at zero is its number of terms. -/
theorem dirichlet_unit_at_zero (N : ℕ) : dirichletPolynomial N (fun _ => 1) 0 = (N : ℂ) := by
  simp [dirichletPolynomial, exponentialSum, realPhase]

/-- A uniform off-diagonal kernel bound gives the finite Halasz--Montgomery energy estimate. -/
theorem halasz_montgomery_energy {ι : Type*} [Fintype ι] (t : ι → ℝ)
    (N : ℕ) (a : ℕ → ℂ) {B : ℝ} (hB : 0 ≤ B)
    (hkernel : ∀ i j : ι, i ≠ j → ‖dirichletPolynomial N (fun _ => 1) (t i-t j)‖ ≤ B) :
    (∑ i, ‖dirichletPolynomial N a (t i)‖^2) ≤
      ((N : ℝ)+((Fintype.card ι-1 : ℕ) : ℝ)*B)*coefficientEnergy (Finset.Icc 1 N) a := by
  classical
  apply dirichlet_samples_le_gram_rows t N a (by positivity)
  intro i
  rw [← Finset.sum_erase_add _ _ (Finset.mem_univ i)]
  have hs : (∑ j ∈ Finset.univ.erase i,
      ‖dirichletPolynomial N (fun _ => 1) (t i-t j)‖) ≤
      ∑ _j ∈ Finset.univ.erase i, B :=
    Finset.sum_le_sum (fun j hj => hkernel i j (Finset.mem_erase.1 hj).1.symm)
  calc
    _ ≤ (∑ _j ∈ Finset.univ.erase i, B)+(N : ℝ) := by
      simpa only [sub_self,dirichlet_unit_at_zero,norm_natCast] using! add_le_add hs (le_refl (N : ℝ))
    _ = _ := by
      simp only [Finset.sum_const, Finset.card_erase_of_mem (Finset.mem_univ i),
        Finset.card_univ, nsmul_eq_mul]
      ring

/-- The correlation kernel separates the diagonal from the cardinality-dependent off-diagonal. -/
theorem halasz_montgomery_large_values {ι : Type*} [Fintype ι] (t : ι → ℝ)
    (N : ℕ) (a : ℕ → ℂ) {B V : ℝ} (hB : 0 ≤ B) (hV : 0 ≤ V)
    (hkernel : ∀ i j : ι, i ≠ j → ‖dirichletPolynomial N (fun _ => 1) (t i-t j)‖ ≤ B)
    (hlarge : ∀ i : ι, V ≤ ‖dirichletPolynomial N a (t i)‖) :
    (Fintype.card ι : ℝ)*(V^2-B*coefficientEnergy (Finset.Icc 1 N) a) ≤
      (N : ℝ)*coefficientEnergy (Finset.Icc 1 N) a := by
  have h := halasz_montgomery_energy t N a hB hkernel
  have hcount : (Fintype.card ι : ℝ)*V^2 ≤ ∑ i, ‖dirichletPolynomial N a (t i)‖^2 := by
    have he : (Fintype.card ι : ℝ)*V^2 = ∑ _i : ι, V^2 := by simp
    rw [he]
    exact Finset.sum_le_sum (fun i _hi => pow_le_pow_left₀ hV (hlarge i) 2)
  have hc : ((Fintype.card ι-1 : ℕ) : ℝ) ≤ (Fintype.card ι : ℝ) := by
    exact_mod_cast Nat.sub_le (Fintype.card ι) 1
  have hE := coefficientEnergy_nonneg (Finset.Icc 1 N) a
  have hb := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hc hB) hE
  nlinarith

/-- When the threshold dominates the off-diagonal energy, the number of large values is bounded. -/
theorem halasz_montgomery_card_le {ι : Type*} [Fintype ι] (t : ι → ℝ)
    (N : ℕ) (a : ℕ → ℂ) {B V : ℝ} (hB : 0 ≤ B) (hV : 0 ≤ V)
    (hkernel : ∀ i j : ι, i ≠ j → ‖dirichletPolynomial N (fun _ => 1) (t i-t j)‖ ≤ B)
    (hlarge : ∀ i : ι, V ≤ ‖dirichletPolynomial N a (t i)‖)
    (hpositive : B*coefficientEnergy (Finset.Icc 1 N) a < V^2) :
    (Fintype.card ι : ℝ) ≤ ((N : ℝ)*coefficientEnergy (Finset.Icc 1 N) a)/
      (V^2-B*coefficientEnergy (Finset.Icc 1 N) a) := by
  apply (le_div_iff₀ (sub_pos.2 hpositive)).2
  exact halasz_montgomery_large_values t N a hB hV hkernel hlarge

end Legendre.Density
