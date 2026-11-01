/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronExplicit

/-!
# Quantitative contour remainder for the truncated explicit formula

For a fixed admissible rectangle the logarithmic derivative has a finite
boundary bound M. The remainder is bounded by the proved Perron error plus
M T x^a/(πa) and M(σ−a)max(x^a,x^σ)/(πT). The dependence of M and a on T
is retained; no uniform log-squared bound at all heights is asserted.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology Set MeasureTheory

/-- A rectangular boundary is compact. -/
theorem isCompact_rectangleBorder (z w : ℂ) : IsCompact (RectangleBorder z w) := by
  unfold RectangleBorder
  exact (((isCompact_uIcc.reProdIm isCompact_singleton).union
    (isCompact_singleton.reProdIm isCompact_uIcc)).union
    (isCompact_uIcc.reProdIm isCompact_singleton)).union
    (isCompact_singleton.reProdIm isCompact_uIcc)

/-- On an admissible boundary ζ′/ζ has a finite nonnegative norm bound. -/
theorem exists_perron_boundary_bound {a σ T : ℝ} (ha1 : a < 1) (hσ : 1 < σ) (hT : 0 < T)
    (hz : ∀ s ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I),
      riemannZeta s ≠ 0) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ s ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I),
      ‖logDeriv riemannZeta s‖ ≤ M := by
  have hc : ContinuousOn (fun s : ℂ => ‖logDeriv riemannZeta s‖)
      (RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I)) := by
    intro s hs
    have hs1 : s ≠ 1 := by intro he; subst s; exact one_not_mem_perronRectangleBorder ha1 hσ hT hs
    have hζ := analytic_off_pole s (by simpa using hs1)
    exact (hζ.deriv.div hζ (hz s hs)).continuousAt.norm.continuousWithinAt
  obtain ⟨C, hC⟩ := (isCompact_rectangleBorder ((a : ℂ)-(T : ℂ)*I)
    ((σ : ℂ)+(T : ℂ)*I)).bddAbove_image hc
  refine ⟨max C 0, le_max_right _ _, fun s hs => ?_⟩
  exact (hC (mem_image_of_mem _ hs)).trans (le_max_left _ _)

/-- Each side is genuinely integrable before the contour bound is used. -/
theorem perron_rectangleBorderIntegrable {x a σ T : ℝ} (hx : 0 < x) (ha : 0 < a)
    (ha1 : a < 1) (hσ : 1 < σ) (hT : 0 < T)
    (hz : ∀ s ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I),
      riemannZeta s ≠ 0) :
    RectangleBorderIntegrable (perronIntegrand x) ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) := by
  apply ContinuousOn.rectangleBorder_integrable
  intro s hs
  have hR : s ∈ perronRectangle a σ T := rectangleBorder_subset_rectangle _ _ hs
  have hs0 := ne_zero_of_mem_perronRectangle ha (by linarith) hT.le hR
  have hs1 : s ≠ 1 := by intro he; subst s; exact one_not_mem_perronRectangleBorder ha1 hσ hT hs
  exact (perronIntegrand_analyticAt hx hs0 hs1 (hz s hs)).continuousAt.continuousWithinAt

/-- The normalization factor has norm 1/(2π). -/
theorem norm_perron_normalization : ‖(1/(2*Real.pi*I) : ℂ)‖ = 1/(2*Real.pi) := by
  simp [norm_mul, abs_of_pos Real.pi_pos]

/-- The left vertical side lies in the rectangular boundary. -/
theorem perron_left_mem_boundary {a σ T t : ℝ} (ht : t ∈ Icc (-T) T) :
    (a : ℂ)+(t : ℂ)*I ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) := by
  apply mem_union_left
  apply mem_union_left
  apply mem_union_right
  simp only [mem_reProdIm, mem_singleton_iff, add_re, mul_re, ofReal_re, ofReal_im,
    I_re, I_im, mul_zero, mul_one, sub_self, add_zero, sub_re, sub_zero,
    add_im, mul_im, zero_add, sub_im, zero_sub]
  exact ⟨trivial, ⟨(min_le_left (-T) T).trans ht.1, ht.2.trans (le_max_right _ _)⟩⟩

/-- Either horizontal side lies in the rectangular boundary. -/
theorem perron_horizontal_mem_boundary {a σ T u t : ℝ} (hu : u ∈ Icc a σ)
    (ht : t = T ∨ t = -T) :
    (u : ℂ)+(t : ℂ)*I ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) := by
  have hreal : u ∈ uIcc a σ := Icc_subset_uIcc hu
  rcases ht with ht|ht
  · rw [ht]
    apply mem_union_left
    apply mem_union_right
    simpa [mem_reProdIm] using And.intro hreal (rfl : T = T)
  · rw [ht]
    apply mem_union_left
    apply mem_union_left
    apply mem_union_left
    simpa [mem_reProdIm] using And.intro hreal (rfl : -T = -T)

/-- Explicit bound on the normalized left vertical integral. -/
theorem norm_perron_left_le {x a σ T M : ℝ} (hx : 0 < x) (ha : 0 < a) (hT : 0 < T)
    (hM : 0 ≤ M)
    (hb : ∀ s ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I),
      ‖logDeriv riemannZeta s‖ ≤ M) :
    ‖VIntegral' (perronIntegrand x) a (-T) T‖ ≤ M*T/(Real.pi*a) * x^a := by
  have hi : ‖∫ t : ℝ in -T..T, perronIntegrand x ((a : ℂ)+(t : ℂ)*I)‖ ≤
      (M*x^a/a) * |T-(-T)| := by
    apply intervalIntegral.norm_integral_le_of_norm_le_const
    intro t ht
    have ht' : t ∈ Icc (-T) T := by
      simpa only [uIcc_of_le (by linarith : -T ≤ T)] using (uIoc_subset_uIcc ht)
    have hn : a ≤ ‖(a : ℂ)+(t : ℂ)*I‖ := by
      simpa [abs_of_pos ha] using abs_re_le_norm ((a : ℂ)+(t : ℂ)*I)
    rw [perronIntegrand, norm_mul, norm_neg, norm_perronWeight hx]
    simp only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im, mul_zero, mul_one, sub_self, add_zero]
    calc
      _ ≤ M * (x^a/‖(a : ℂ)+(t : ℂ)*I‖) :=
        mul_le_mul_of_nonneg_right (hb _ (perron_left_mem_boundary ht')) (by positivity)
      _ ≤ M * (x^a/a) := mul_le_mul_of_nonneg_left
        (div_le_div_of_nonneg_left (by positivity) ha hn) hM
      _ = _ := by ring
  simp only [VIntegral', VIntegral, smul_eq_mul, norm_mul, norm_I, one_mul,
    norm_perron_normalization]
  calc
    _ ≤ (1/(2*Real.pi)) * ((M*x^a/a) * |T-(-T)|) :=
      mul_le_mul_of_nonneg_left hi (by positivity)
    _ = _ := by rw [abs_of_pos (by linarith : 0 < T-(-T))]; field_simp; ring

/-- Explicit bound on a normalized horizontal side at either sign of height. -/
theorem norm_perron_horizontal_le {x a σ T t M : ℝ} (hx : 0 < x) (haσ : a ≤ σ)
    (hT : 0 < T) (ht : t = T ∨ t = -T) (hM : 0 ≤ M)
    (hb : ∀ s ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I),
      ‖logDeriv riemannZeta s‖ ≤ M) :
    ‖HIntegral' (perronIntegrand x) a σ t‖ ≤
      M*(σ-a)/(2*Real.pi*T) * max (x^a) (x^σ) := by
  have htabs : |t| = T := by rcases ht with rfl|rfl <;> simp [abs_of_pos hT]
  have ht0 : t ≠ 0 := by intro he; rw [he, abs_zero] at htabs; linarith
  have hi : ‖∫ u : ℝ in a..σ, perronIntegrand x ((u : ℂ)+(t : ℂ)*I)‖ ≤
      (M*max (x^a) (x^σ)/T) * |σ-a| := by
    apply intervalIntegral.norm_integral_le_of_norm_le_const
    intro u hu
    have hu' := uIoc_subset_uIcc hu
    rw [uIcc_of_le haσ] at hu'
    rw [perronIntegrand, norm_mul, norm_neg]
    calc
      _ ≤ M * (max (x^a) (x^σ)/|t|) := mul_le_mul
        (hb _ (perron_horizontal_mem_boundary hu' ht))
        (norm_perronWeight_horizontal_le hx hu' ht0) (norm_nonneg _) hM
      _ = _ := by rw [htabs]; ring
  simp only [HIntegral', HIntegral, smul_eq_mul, norm_mul, norm_perron_normalization]
  calc
    _ ≤ (1/(2*Real.pi)) * ((M*max (x^a) (x^σ)/T)*|σ-a|) :=
      mul_le_mul_of_nonneg_left hi (by positivity)
    _ = _ := by rw [abs_of_nonneg (sub_nonneg.2 haσ)]; ring

/-- A finite-height explicit-formula error bound with all contour dependence displayed. -/
theorem norm_truncatedExplicitError_le_boundary_bound {x a σ T M : ℝ} (hx : 0 < x)
    (ha : 0 < a) (ha1 : a < 1) (hσ : 1 < σ) (hT : 0 < T) (hM : 0 ≤ M)
    (hb : ∀ s ∈ RectangleBorder ((a : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I),
      ‖logDeriv riemannZeta s‖ ≤ M) :
    ‖truncatedExplicitError x a σ T‖ ≤ perronErrorUpper x σ/T +
      M*T/(Real.pi*a)*x^a + M*(σ-a)/(Real.pi*T)*max (x^a) (x^σ) := by
  have hv := norm_perron_left_le hx ha hT hM hb
  have hu := norm_perron_horizontal_le hx (by linarith : a ≤ σ) hT (.inl rfl) hM hb
  have hl := norm_perron_horizontal_le hx (by linarith : a ≤ σ) hT (.inr rfl) hM hb
  have he := norm_truncatedExplicitError_le (a := a) hx hσ hT
  have htwo : M*(σ-a)/(Real.pi*T)*max (x^a) (x^σ) =
      2*(M*(σ-a)/(2*Real.pi*T)*max (x^a) (x^σ)) := by ring
  rw [htwo]
  linarith

/-- Arbitrarily high admissible contours give an explicit finite zero-sum formula,
with an error bound uniform in x for each selected contour. -/
theorem exists_truncated_explicit_formula {H σ : ℝ} (hH : 0 ≤ H) (hσ : 1 < σ) :
    ∃ T ∈ Ioo H (H+1), ∃ a ∈ Ioo (0 : ℝ) 1, ∃ M ≥ 0, ∀ x : ℝ, 0 < x →
      ∃ E : ℂ, halfWeightedPsi x = (x : ℂ)-truncatedZeroSum x T+E ∧
      ‖E‖ ≤ perronErrorUpper x σ/T + M*T/(Real.pi*a)*x^a +
        M*(σ-a)/(Real.pi*T)*max (x^a) (x^σ) := by
  obtain ⟨T, hT, hgood⟩ := exists_good_zero_height hH
  have hTpos : 0 < T := by linarith [hT.1]
  obtain ⟨a, ha, hcut⟩ := exists_symmetricZeroCutoff T
  have hz := perronRectangleBorder_nonvanishing ha.1 ha.2 hσ hTpos hcut hgood
  obtain ⟨M, hM, hb⟩ := exists_perron_boundary_bound ha.2 hσ hTpos hz
  refine ⟨T,hT,a,ha,M,hM,fun x hx => ?_⟩
  refine ⟨truncatedExplicitError x a σ T,
    halfWeightedPsi_explicit hx ha.1 ha.2 hσ hTpos hcut hgood, ?_⟩
  exact norm_truncatedExplicitError_le_boundary_bound hx ha.1 ha.2 hσ hTpos hM hb

end Legendre.Zeta
