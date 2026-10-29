/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaCounting
public import Mathlib.Analysis.Calculus.LogDeriv
public import Mathlib.NumberTheory.ZetaValues

/-!
# Layer 2: logarithmic derivative and a right-half-plane bound

The convergent von Mangoldt identity is reused from Michael Stoll's
`Mathlib/NumberTheory/LSeries/Dirichlet.lean`, mathlib v4.35.0,
commit 56a005855ea17e0b0958f73ec801ae140b0a1679 (Apache-2.0).
The Basel sum comes from `Mathlib/NumberTheory/ZetaValues.lean`.
The norm comparisons and the explicit bound here are deductions in this
repository. The bound Re(s) ≥ 3 is deliberately far from the critical line;
it is not a quantitative zero-free-region estimate or a Perron formula.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex ArithmeticFunction
open scoped LSeries.notation

/-- Absolute convergence of the von Mangoldt Dirichlet series for Re(s)>1. -/
theorem vonMangoldt_series_summable {s : ℂ} (hs : 1 < s.re) :
    Summable (LSeries.term (↗vonMangoldt) s) :=
  LSeriesSummable_vonMangoldt hs

/-- The negative logarithmic derivative equals the convergent von Mangoldt
series; this interface reuses the upstream analytic proof. -/
theorem neg_logDeriv_eq_vonMangoldt_series {s : ℂ} (hs : 1 < s.re) :
    -logDeriv riemannZeta s = ∑' n : ℕ, LSeries.term (↗vonMangoldt) s n := by
  simpa [LSeries, logDeriv_apply, neg_div] using
    (LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs).symm

/-- A fixed absolutely convergent majorant controls a whole closed half-plane. -/
theorem norm_logDeriv_le_majorant {σ : ℝ} (hσ : 1 < σ) {s : ℂ} (hs : σ ≤ s.re) :
    ‖logDeriv riemannZeta s‖ ≤
      ∑' n : ℕ, ‖LSeries.term (↗vonMangoldt) (σ : ℂ) n‖ := by
  have hsum := vonMangoldt_series_summable (s := s) (hσ.trans_le hs)
  have hbase := vonMangoldt_series_summable (s := (σ : ℂ)) (by simpa using hσ)
  calc
    ‖logDeriv riemannZeta s‖ = ‖∑' n : ℕ, LSeries.term (↗vonMangoldt) s n‖ := by
      rw [← neg_logDeriv_eq_vonMangoldt_series (hσ.trans_le hs), norm_neg]
    _ ≤ ∑' n : ℕ, ‖LSeries.term (↗vonMangoldt) s n‖ := norm_tsum_le_tsum_norm hsum.norm
    _ ≤ ∑' n : ℕ, ‖LSeries.term (↗vonMangoldt) (σ : ℂ) n‖ :=
      hsum.norm.tsum_le_tsum (fun n ↦ LSeries.norm_term_le_of_re_le_re _ (by simpa using hs) n)
        hbase.norm

/-- A simple coefficient bound used for the explicit estimate. -/
theorem vonMangoldt_le_nat (n : ℕ) : vonMangoldt n ≤ (n : ℝ) := by
  by_cases hn : n = 0
  · subst n
    simp
  · have hnpos : (0 : ℝ) < n := by exact_mod_cast Nat.pos_of_ne_zero hn
    exact vonMangoldt_le_log.trans ((Real.log_le_sub_one_of_pos hnpos).trans (by linarith))

/-- At real part 3, the norm of each term is bounded by the Basel summand. -/
theorem vonMangoldt_term_three_le (n : ℕ) :
    ‖LSeries.term (↗vonMangoldt) (3 : ℂ) n‖ ≤ (1 : ℝ) / (n : ℝ) ^ 2 := by
  by_cases hn : n = 0
  · subst n
    simp
  · rw [LSeries.norm_term_eq, ite_eq_right hn]
    simp only [show (3 : ℂ).re = (3 : ℝ) from rfl, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg vonMangoldt_nonneg, Real.rpow_ofNat]
    have hnpos : (0 : ℝ) < n := by exact_mod_cast Nat.pos_of_ne_zero hn
    calc
      vonMangoldt n / (n : ℝ) ^ 3 ≤ (n : ℝ) / (n : ℝ) ^ 3 :=
        div_le_div_of_nonneg_right (vonMangoldt_le_nat n) (by positivity)
      _ = 1 / (n : ℝ) ^ 2 := by field_simp

/-- Explicit uniform bound on a closed half-plane, not near Re(s)=1. -/
theorem norm_logDeriv_le_pi_sq_div_six {s : ℂ} (hs : 3 ≤ s.re) :
    ‖logDeriv riemannZeta s‖ ≤ Real.pi ^ 2 / 6 := by
  have hsum := vonMangoldt_series_summable (s := (3 : ℂ)) (by norm_num)
  calc
    ‖logDeriv riemannZeta s‖ ≤ ∑' n : ℕ, ‖LSeries.term (↗vonMangoldt) (3 : ℂ) n‖ :=
      norm_logDeriv_le_majorant (by norm_num) hs
    _ ≤ ∑' n : ℕ, (1 : ℝ) / (n : ℝ) ^ 2 :=
      hsum.norm.tsum_le_tsum vonMangoldt_term_three_le hasSum_zeta_two.summable
    _ = Real.pi ^ 2 / 6 := hasSum_zeta_two.tsum_eq

/-- A zero-free region eliminates the corresponding multiplicity-weighted count. -/
theorem zeroDensityCount_eq_zero_of_zero_free {σ T : ℝ}
    (h : ∀ s ∈ zerosRightOf σ T, riemannZeta s ≠ 0) :
    zeroDensityCount σ T = 0 := by
  have hnot : ¬0 < zeroDensityCount σ T := by
    intro hpos
    obtain ⟨s, hs⟩ := (zeroDensityCount_pos_iff σ T).mp hpos
    exact h s hs hs.1.1.1
  omega

/-- Every bounded height has a non-effective cutoff 0<σ<1 with N(σ,T)=0.
The closed density cutoff is obtained by moving halfway into the open strip. -/
theorem exists_zero_density_cutoff (T : ℝ) :
    ∃ σ : ℝ, 0 < σ ∧ σ < 1 ∧ zeroDensityCount σ T = 0 := by
  obtain ⟨width, hwidth, hfree⟩ := exists_zero_free_strip T
  let gap := min width 1
  have hgap : 0 < gap := lt_min hwidth zero_lt_one
  have hgap_le_width : gap ≤ width := min_le_left _ _
  have hgap_le_one : gap ≤ 1 := min_le_right _ _
  refine ⟨1 - gap / 2, by linarith, by linarith, ?_⟩
  apply zeroDensityCount_eq_zero_of_zero_free
  intro s hs
  have hpole : s ≠ 1 := by
    intro h
    have := hs.1.1.2.2
    simp [h] at this
  apply hfree s (by linarith [hs.2]) _ hpole
  exact abs_le.mpr ⟨by linarith [hs.1.2.1, hs.1.2.2], hs.1.2.2⟩

end Legendre.Zeta
