/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronRectangle
public import Legendre.PerronError

/-!
# A truncated explicit formula with analytic multiplicity

The finite zero sum contains all critical-strip zeros with |Im ρ|≤T.
The remainder retains the left and horizontal contour integrals and the
proved fixed-x Perron truncation error. No uniform-in-height O-term is assumed.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology Set MeasureTheory

/-- The finite sum in the explicit formula. Multiplicities are not assumed to be one. -/
noncomputable def truncatedZeroSum (x T : ℝ) : ℂ :=
  ∑ s ∈ (symmetricZeros_finite T).toFinset, (zeroMultiplicity s : ℂ) * perronWeight x s

/-- Kernel poles away from 0 are exactly 1 and the zeta zeros. -/
theorem perronIntegrand_pole_iff {x : ℝ} (hx : 0 < x) {s : ℂ} (hs0 : s ≠ 0) :
    meromorphicOrderAt (perronIntegrand x) s < 0 ↔ s = 1 ∨ riemannZeta s = 0 := by
  by_cases hs1 : s = 1
  · subst s
    rw [perronIntegrand_order_one hx]
    simp only [true_or, iff_true]
    exact WithTop.coe_lt_coe.2 (by norm_num)
  by_cases hz : riemannZeta s = 0
  · rw [perronIntegrand_order_at_zero hx hs0 hs1 hz]
    simp only [hz, or_true, iff_true]
    exact WithTop.coe_lt_coe.2 (by norm_num)
  · have h := (perronIntegrand_analyticAt hx hs0 hs1 hz).meromorphicOrderAt_nonneg
    exact ⟨fun hn => (not_lt_of_ge h hn).elim, fun h => by rcases h with h|h <;> contradiction⟩

/-- All the relevant poles are at most simple, even when the zeta zeros are multiple. -/
theorem perronIntegrand_simple_poles {x a σ T : ℝ} (hx : 0 < x) (ha : 0 < a)
    (haσ : a ≤ σ) (hT : 0 ≤ T) :
    HasSimplePolesOn (perronIntegrand x) (perronRectangle a σ T) := by
  intro s hs
  have hs0 := ne_zero_of_mem_perronRectangle ha haσ hT hs
  by_cases hs1 : s = 1
  · subst s
    rw [perronIntegrand_order_one hx]
    exact le_rfl
  · by_cases hz : riemannZeta s = 0
    · rw [perronIntegrand_order_at_zero hx hs0 hs1 hz]
      exact le_rfl
    · exact (show (-1 : WithTop ℤ) ≤ 0 from WithTop.coe_le_coe.2 (by norm_num)).trans
        (perronIntegrand_analyticAt hx hs0 hs1 hz).meromorphicOrderAt_nonneg

/-- The rectangle contains the main pole and precisely the desired truncated zero set. -/
theorem perronRectangle_poles {x a σ T : ℝ} (hx : 0 < x) (ha : 0 < a) (ha1 : a < 1)
    (hσ : 1 < σ) (hT : 0 < T)
    (hcut : ∀ s ∈ symmetricZeros T, a < s.re) :
    perronRectangle a σ T ∩ {s | meromorphicOrderAt (perronIntegrand x) s < 0} =
      insert 1 (symmetricZeros T) := by
  ext s
  constructor
  · rintro ⟨hs, hpole⟩
    rcases (perronIntegrand_pole_iff hx
      (ne_zero_of_mem_perronRectangle ha (by linarith) hT.le hs)).1 hpole with hs1|hz
    · exact mem_insert_iff.2 (.inl hs1)
    · exact mem_insert_iff.2 (.inr (perronRectangle_zeros ha ha1 hσ hT.le hcut ▸ ⟨hs,hz⟩))
  · intro hs
    rcases mem_insert_iff.1 hs with hs1|hz
    · subst s
      exact ⟨one_mem_perronRectangle ha1 hσ hT, by change meromorphicOrderAt (perronIntegrand x) 1 < 0; rw [perronIntegrand_order_one hx]; exact WithTop.coe_lt_coe.2 (by norm_num)⟩
    · have hR : s ∈ perronRectangle a σ T :=
        ((perronRectangle_zeros ha ha1 hσ hT.le hcut).symm ▸ hz).1
      exact ⟨hR, (perronIntegrand_pole_iff hx
        (ne_zero_of_mem_perronRectangle ha (by linarith) hT.le hR)).2 (.inr hz.1.1)⟩

/-- A residue sum on a finite set really is its finite sum; no summability is assumed away. -/
theorem sumResiduesIn_eq_sum {f : ℂ → ℂ} {S : Set ℂ} (hS : S.Finite) :
    sumResiduesIn f S = ∑ s ∈ hS.toFinset, residue f s := by
  classical
  have he : S = (hS.toFinset : Set ℂ) := hS.coe_toFinset.symm
  conv_lhs => rw [sumResiduesIn, he, tsum_fintype]
  exact Finset.sum_coe_sort hS.toFinset (fun s : ℂ => residue f s)

/-- Evaluating every residue gives the finite, multiplicity-weighted explicit contour formula. -/
theorem perronRectangle_integral_eq {x a σ T : ℝ} (hx : 0 < x) (ha : 0 < a)
    (ha1 : a < 1) (hσ : 1 < σ) (hT : 0 < T)
    (hcut : ∀ s ∈ symmetricZeros T, a < s.re)
    (hgood : ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T) :
    RectangleIntegral' (perronIntegrand x) ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) =
      (x : ℂ) - truncatedZeroSum x T := by
  classical
  have hpol := perronRectangle_poles hx ha ha1 hσ hT hcut
  have hfinite : (perronRectangle a σ T ∩
      {s | meromorphicOrderAt (perronIntegrand x) s < 0}).Finite := by
    rw [hpol]
    exact (symmetricZeros_finite T).insert 1
  have hnoborder : Disjoint
      (RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I))
      {s | meromorphicOrderAt (perronIntegrand x) s < 0} := by
    apply Set.disjoint_left.2
    intro s hs hpole
    have hR : s ∈ perronRectangle a σ T := rectangleBorder_subset_rectangle _ _ hs
    rcases (perronIntegrand_pole_iff hx
      (ne_zero_of_mem_perronRectangle ha (by linarith) hT.le hR)).1 hpole with hs1|hz
    · subst s
      exact one_not_mem_perronRectangleBorder ha1 hσ hT hs
    · exact perronRectangleBorder_nonvanishing ha ha1 hσ hT hcut hgood s hs hz
  have hm : MeromorphicOn (perronIntegrand x) (perronRectangle a σ T) :=
    fun s hs => perronIntegrand_meromorphicAt hx
      (ne_zero_of_mem_perronRectangle ha (by linarith) hT.le hs)
  have heq := RectangleIntegral'_eq_sumResiduesIn (f := perronIntegrand x)
    (z := (a : ℂ)-(T : ℂ)*I) (w := (σ : ℂ)+(T : ℂ)*I)
    (by simp; linarith) (by simp; linarith) hm hnoborder hfinite
    (perronIntegrand_simple_poles hx ha (by linarith) hT.le)
  rw [heq, show Rectangle ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) =
      perronRectangle a σ T by rfl, hpol,
    sumResiduesIn_eq_sum ((symmetricZeros_finite T).insert 1)]
  have h1 : (1 : ℂ) ∉ (symmetricZeros_finite T).toFinset := by
    simp [symmetricZeros, NontrivialZero]
  rw [Set.Finite.toFinset_insert, Finset.sum_insert h1, residue_perronIntegrand_one hx]
  have hz : (∑ s ∈ (symmetricZeros_finite T).toFinset, residue (perronIntegrand x) s) =
      -truncatedZeroSum x T := by
    rw [truncatedZeroSum, ← Finset.sum_neg_distrib]
    apply Finset.sum_congr rfl
    intro s hs
    have hmem := (symmetricZeros_finite T).mem_toFinset.1 hs
    have hs0 : s ≠ 0 := by intro h; have := hmem.1.2.1; simp [h] at this
    have hs1 : s ≠ 1 := by intro h; have := hmem.1.2.2; simp [h] at this
    rw [residue_perronIntegrand_at_zero hx hs0 hs1]
    ring
  rw [hz]
  ring

/-- The finite left vertical and horizontal contour remainder, with the standard orientations. -/
noncomputable def perronContourRemainder (x a σ T : ℝ) : ℂ :=
  VIntegral' (perronIntegrand x) a (-T) T + HIntegral' (perronIntegrand x) a σ T -
    HIntegral' (perronIntegrand x) a σ (-T)

/-- The normalized vertical parametrizations use the same factor 1/(2π). -/
theorem VIntegral'_eq_truncatedPerron (x σ T : ℝ) :
    VIntegral' (perronIntegrand x) σ (-T) T = truncatedPerron x σ T := by
  simp only [VIntegral', VIntegral, truncatedPerron, smul_eq_mul]
  have hfactor : (1/(2*Real.pi*I) : ℂ)*I = 1/(2*Real.pi) := by field_simp
  rw [← mul_assoc, hfactor]

/-- The finite Perron integral equals its main pole minus the truncated zero sum,
plus the three retained contour sides. -/
theorem truncatedPerron_explicit {x a σ T : ℝ} (hx : 0 < x) (ha : 0 < a)
    (ha1 : a < 1) (hσ : 1 < σ) (hT : 0 < T)
    (hcut : ∀ s ∈ symmetricZeros T, a < s.re)
    (hgood : ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T) :
    truncatedPerron x σ T = (x : ℂ)-truncatedZeroSum x T + perronContourRemainder x a σ T := by
  have heq := perronRectangle_integral_eq hx ha ha1 hσ hT hcut hgood
  simp only [RectangleIntegral', RectangleIntegral,
    sub_re, mul_re, ofReal_re, ofReal_im, I_re, I_im, mul_zero, mul_one, sub_self,
    sub_zero, add_re, add_zero, sub_im, mul_im, zero_add, zero_sub, add_im,
    smul_eq_mul] at heq
  rw [← VIntegral'_eq_truncatedPerron]
  simp only [perronContourRemainder, HIntegral', VIntegral', smul_eq_mul]
  linear_combination heq

/-- The half-weight convention at integer endpoints. -/
noncomputable def halfWeightedPsi (x : ℝ) : ℂ :=
  (Chebyshev.psi x : ℂ) -
    if (⌊x⌋₊ : ℝ) = x then (ArithmeticFunction.vonMangoldt ⌊x⌋₊ : ℂ)/2 else 0

/-- The explicit-formula remainder retains the known Perron error as well as the three sides. -/
noncomputable def truncatedExplicitError (x a σ T : ℝ) : ℂ :=
  halfWeightedPsi x - truncatedPerron x σ T + perronContourRemainder x a σ T

/-- A genuine finite-height, multiplicity-weighted explicit formula for ψ₀. -/
theorem halfWeightedPsi_explicit {x a σ T : ℝ} (hx : 0 < x) (ha : 0 < a)
    (ha1 : a < 1) (hσ : 1 < σ) (hT : 0 < T)
    (hcut : ∀ s ∈ symmetricZeros T, a < s.re)
    (hgood : ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T) :
    halfWeightedPsi x = (x : ℂ)-truncatedZeroSum x T + truncatedExplicitError x a σ T := by
  rw [truncatedExplicitError, truncatedPerron_explicit hx ha ha1 hσ hT hcut hgood]
  ring

/-- An unconditional bound on the error in terms of the actual retained contour integrals. -/
theorem norm_truncatedExplicitError_le {x a σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ) (hT : 0 < T) :
    ‖truncatedExplicitError x a σ T‖ ≤ perronErrorUpper x σ/T +
      ‖VIntegral' (perronIntegrand x) a (-T) T‖ +
      ‖HIntegral' (perronIntegrand x) a σ T‖ +
      ‖HIntegral' (perronIntegrand x) a σ (-T)‖ := by
  have hp : ‖halfWeightedPsi x-truncatedPerron x σ T‖ ≤ perronErrorUpper x σ/T := by
    rw [norm_sub_rev]
    exact norm_truncatedPerron_sub_psi_le_upper hx hσ hT
  calc
    _ ≤ ‖halfWeightedPsi x-truncatedPerron x σ T‖ + ‖perronContourRemainder x a σ T‖ := norm_add_le _ _
    _ ≤ _ := by
      have hc : ‖perronContourRemainder x a σ T‖ ≤
          ‖VIntegral' (perronIntegrand x) a (-T) T‖ +
          ‖HIntegral' (perronIntegrand x) a σ T‖ +
          ‖HIntegral' (perronIntegrand x) a σ (-T)‖ :=
        (norm_sub_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
      linarith

end Legendre.Zeta
