/-
Copyright (c) 2026 S. McColm.
Released under the MIT-0 license; retained verbatim in
licenses/smccolm-Lean-MIT-0.txt.

Adapted for Lean 4.35.0 from smccolm/Lean,
commit 4c8fb7f7816508825089230e3730b69165e5e303,
Riemann Zeta/9. Zero Density, Large Values and Prime Transfer/
71 Guth-Maynard, 2026/GuthMaynard/FiniteDensityTransfer.lean and GuthMaynard/BetaDependence.lean.
Only the finite-polynomial localization and its rational factor are
ported, using the Lean 4.35.0 complex analyticity API.
See docs/smccolm-guth-provenance.md.
-/
module
public import Legendre.Layer4.GuthMaynard.FinitePowers
public import Mathlib.Analysis.Complex.PhragmenLindelof
public import Mathlib.Analysis.SpecialFunctions.Complex.Analytic

@[expose] public section
open Complex Finset Set Filter Asymptotics PhragmenLindelof
namespace Legendre.Density.GuthMaynard

/-- The rational localization factor has norm at most one in the closed right half-plane. -/
lemma localizer_norm_le_one (k : ℕ) (H : ℝ) (hH : 0 < H) (w : ℂ)
    (hw : 0 ≤ w.re) : ‖((H : ℂ) / (H + w)) ^ k‖ ≤ 1 := by
  rw [norm_pow, norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hH]
  have hden : H ≤ ‖(H : ℂ) + w‖ := by
    calc
      H ≤ |H + w.re| := by
        rw [abs_of_nonneg (by linarith)]
        linarith
      _ = |((H : ℂ) + w).re| := by simp
      _ ≤ ‖(H : ℂ) + w‖ := abs_re_le_norm _
  have hratio : H / ‖(H : ℂ) + w‖ ≤ 1 :=
    (div_le_one (hH.trans_le hden)).mpr hden
  exact pow_le_one₀ (by positivity) hratio

/-- Away from the central boundary segment, the rational localizer decays polynomially. -/
lemma localizer_norm_boundary_le (k : ℕ) (H R y : ℝ)
    (hH : 0 < H) (hR : 0 < R) (hy : R ≤ |y|) :
    ‖((H : ℂ) / (H + (y : ℂ) * I)) ^ k‖ ≤ (H / R) ^ k := by
  rw [norm_pow, norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hH]
  have hden : |y| ≤ ‖(H : ℂ) + (y : ℂ) * I‖ := by
    calc
      |y| = |((H : ℂ) + (y : ℂ) * I).im| := by simp
      _ ≤ ‖(H : ℂ) + (y : ℂ) * I‖ := abs_im_le_norm _
  have hdenPos : 0 < ‖(H : ℂ) + (y : ℂ) * I‖ :=
    lt_of_lt_of_le (hR.trans_le hy) hden
  have hratio : H / ‖(H : ℂ) + (y : ℂ) * I‖ ≤ H / R := by
    exact div_le_div_of_nonneg_left hH.le hR (hy.trans hden)
  exact pow_le_pow_left₀ (by positivity) hratio k

/-- For a bounded horizontal displacement, the localizer loses less than one quarter. -/
lemma localizer_factor_gt_three_fourths (k : ℕ) (H a : ℝ)
    (hH : 0 < H) (ha : 0 ≤ a) (haOne : a ≤ 1) (hHk : 4 * (k : ℝ) < H) :
    3 / 4 < ‖((H : ℂ) / (H + (a : ℂ))) ^ k‖ := by
  have hHa : 0 < H + a := by linarith
  rw [norm_pow, norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hH]
  have hnorm : ‖(H : ℂ) + (a : ℂ)‖ = H + a := by
    rw [← ofReal_add, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hHa]
  rw [hnorm]
  let r : ℝ := H / (H + a)
  have hr0 : 0 ≤ r := by dsimp [r]; positivity
  have hBernoulli : 1 + (k : ℝ) * (r - 1) ≤ r ^ k := by
    exact one_add_mul_sub_le_pow (by linarith) k
  have hFrac : (k : ℝ) * a / (H + a) < 1 / 4 := by
    have hkA : (k : ℝ) * a ≤ k := by
      have hk0 : 0 ≤ (k : ℝ) := Nat.cast_nonneg k
      nlinarith
    have hDiv : (k : ℝ) * a / (H + a) ≤ (k : ℝ) / H := by
      rw [div_le_div_iff₀ hHa hH]
      have hk0 : 0 ≤ (k : ℝ) := Nat.cast_nonneg k
      nlinarith [mul_nonneg hk0 ha]
    have hkDiv : (k : ℝ) / H < 1 / 4 := by
      rw [div_lt_iff₀ hH]
      nlinarith
    exact hDiv.trans_lt hkDiv
  have hrSub : r - 1 = -a / (H + a) := by
    dsimp [r]
    field_simp
    ring
  rw [hrSub] at hBernoulli
  have : 3 / 4 < 1 + (k : ℝ) * (-a / (H + a)) := by
    have hrewrite : (k : ℝ) * (-a / (H + a)) = -((k : ℝ) * a / (H + a)) := by
      ring
    rw [hrewrite]
    linarith
  exact this.trans_le hBernoulli

/-- A Dirichlet polynomial on an arbitrary finite positive support. -/
noncomputable def finiteDirichletSeries
    (S : Finset ℕ) (a : ℕ → ℂ) (s : ℂ) : ℂ :=
  ∑ n ∈ S, a n * (n : ℂ) ^ (-s)

/-- The coefficient mass used to bound a finite Dirichlet polynomial in the
closed right half-plane. -/
noncomputable def finiteDirichletMass (S : Finset ℕ) (a : ℕ → ℂ) : ℝ :=
  ∑ n ∈ S, ‖a n‖

theorem norm_finiteDirichletSeries_le_mass
    (S : Finset ℕ) (a : ℕ → ℂ) (s : ℂ)
    (hS : ∀ n ∈ S, 0 < n) (hs : 0 ≤ s.re) :
    ‖finiteDirichletSeries S a s‖ ≤ finiteDirichletMass S a := by
  unfold finiteDirichletSeries finiteDirichletMass
  calc
    ‖∑ n ∈ S, a n * (n : ℂ) ^ (-s)‖ ≤
        ∑ n ∈ S, ‖a n * (n : ℂ) ^ (-s)‖ := norm_sum_le _ _
    _ ≤ ∑ n ∈ S, ‖a n‖ := by
      apply Finset.sum_le_sum
      intro n hn
      rw [norm_mul, Complex.norm_natCast_cpow_of_pos (hS n hn)]
      exact mul_le_of_le_one_right (norm_nonneg _) <|
        Real.rpow_le_one_of_one_le_of_nonpos
          (by exact_mod_cast (hS n hn)) (by simp [hs])

theorem differentiable_finiteDirichletSeries_add
    (S : Finset ℕ) (a : ℕ → ℂ) (z : ℂ) (hS : ∀ n ∈ S, 0 < n) :
    Differentiable ℂ (fun w : ℂ => finiteDirichletSeries S a (z + w)) := by
  intro w
  apply AnalyticAt.differentiableAt
  unfold finiteDirichletSeries
  have hEq :
      (fun u : ℂ => ∑ n ∈ S, a n * (n : ℂ) ^ (-(z + u))) =
        ∑ n ∈ S, fun u : ℂ => a n * (n : ℂ) ^ (-(z + u)) := by
    funext u
    simp
  rw [hEq]
  apply Finset.analyticAt_sum
  intro n hn
  have hnPos : 0 < n := hS n hn
  have hpow : AnalyticAt ℂ (fun u : ℂ => (n : ℂ) ^ (-(z + u))) w :=
    analyticAt_const.cpow ((analyticAt_const.add analyticAt_id).neg)
      (Complex.natCast_mem_slitPlane.mpr hnPos.ne')
  exact analyticAt_const.mul hpow

/-- Rational localization of a finite Dirichlet polynomial. -/
noncomputable def localizedFiniteDirichlet
    (S : Finset ℕ) (a : ℕ → ℂ) (k : ℕ) (z : ℂ) (H : ℝ) (w : ℂ) : ℂ :=
  (((H : ℂ) / (H + w)) ^ k) * finiteDirichletSeries S a (z + w)

theorem localizedFiniteDirichlet_le_mass
    (S : Finset ℕ) (a : ℕ → ℂ) (k : ℕ) (z w : ℂ) (H : ℝ)
    (hS : ∀ n ∈ S, 0 < n) (hH : 0 < H) (hz : 0 ≤ z.re) (hw : 0 ≤ w.re) :
    ‖localizedFiniteDirichlet S a k z H w‖ ≤ finiteDirichletMass S a := by
  rw [localizedFiniteDirichlet, norm_mul]
  calc
    ‖((H : ℂ) / (H + w)) ^ k‖ * ‖finiteDirichletSeries S a (z + w)‖ ≤
        1 * finiteDirichletMass S a := by
      gcongr
      · exact localizer_norm_le_one k H hH w hw
      · exact norm_finiteDirichletSeries_le_mass S a (z + w) hS (by simp; linarith)
    _ = finiteDirichletMass S a := one_mul _

theorem localizedFiniteDirichlet_halfPlane_bound
    (S : Finset ℕ) (a : ℕ → ℂ) (k : ℕ) (z : ℂ) (H C : ℝ)
    (hS : ∀ n ∈ S, 0 < n) (hH : 0 < H) (hz : 0 ≤ z.re)
    (hBoundary : ∀ y : ℝ,
      ‖localizedFiniteDirichlet S a k z H (y * I)‖ ≤ C)
    (w : ℂ) (hw : 0 ≤ w.re) :
    ‖localizedFiniteDirichlet S a k z H w‖ ≤ C := by
  apply PhragmenLindelof.right_half_plane_of_bounded_on_real
      (f := localizedFiniteDirichlet S a k z H)
  · exact (by
      unfold localizedFiniteDirichlet
      apply DifferentiableOn.diffContOnCl
      intro u hu
      have hne : (H : ℂ) + u ≠ 0 := by
        intro h
        have hre := congrArg Complex.re h
        simp only [add_re, ofReal_re, zero_re] at hre
        rw [closure_setOfPred_lt_re] at hu
        change 0 ≤ u.re at hu
        linarith
      exact ((((differentiableAt_const (c := (H : ℂ))).div
        ((differentiableAt_const (c := (H : ℂ))).add differentiableAt_id) hne).pow k).mul
          (differentiable_finiteDirichletSeries_add S a z hS u)).differentiableWithinAt)
  · refine ⟨1, by norm_num, 0, ?_⟩
    apply Asymptotics.IsBigO.of_bound (finiteDirichletMass S a)
    have hopen : ∀ᶠ u in (Bornology.cobounded ℂ ⊓ Filter.principal {u : ℂ | 0 < u.re}),
        0 < u.re := Filter.le_principal_iff.mp inf_le_right
    filter_upwards [hopen] with u hu
    simp only [zero_mul, Real.exp_zero, norm_one, mul_one]
    exact localizedFiniteDirichlet_le_mass S a k z u H hS hH hz hu.le
  · refine ⟨finiteDirichletMass S a, ?_⟩
    rw [eventually_map]
    exact Filter.eventually_atTop.mpr ⟨0, fun x hx =>
      localizedFiniteDirichlet_le_mass S a k z x H hS hH hz (by simpa using hx)⟩
  · exact hBoundary
  · exact hw

/-- A large value to the right of a fixed vertical line produces a comparably
large value on that line after a controlled ordinate displacement. -/
theorem exists_nearby_large_value_finiteDirichlet
    (S : Finset ℕ) (coeff : ℕ → ℂ) (k : ℕ) (z : ℂ) (H R A a : ℝ)
    (hS : ∀ n ∈ S, 0 < n) (hH : 0 < H) (hR : 0 < R) (hA : 0 < A)
    (hz : 0 ≤ z.re) (ha : 0 ≤ a)
    (hLarge : A ≤ ‖finiteDirichletSeries S coeff (z + a)‖)
    (hFactor : 3 / 4 < ‖((H : ℂ) / (H + (a : ℂ))) ^ k‖)
    (hExterior : finiteDirichletMass S coeff * (H / R) ^ k < (3 / 4) * A) :
    ∃ y : ℝ, |y| ≤ R ∧
      (3 / 4) * A ≤ ‖finiteDirichletSeries S coeff (z + y * I)‖ := by
  by_contra! hNo
  have hBoundary : ∀ y : ℝ,
      ‖localizedFiniteDirichlet S coeff k z H (y * I)‖ ≤ (3 / 4) * A := by
    intro y
    rw [localizedFiniteDirichlet, norm_mul]
    by_cases hy : |y| ≤ R
    · calc
        ‖((H : ℂ) / (H + (y : ℂ) * I)) ^ k‖ *
            ‖finiteDirichletSeries S coeff (z + (y : ℂ) * I)‖ ≤
            1 * ((3 / 4) * A) := by
          gcongr
          · exact localizer_norm_le_one k H hH (y * I) (by simp)
          · exact (hNo y hy).le
        _ = (3 / 4) * A := one_mul _
    · have hyR : R ≤ |y| := le_of_lt (lt_of_not_ge hy)
      calc
        ‖((H : ℂ) / (H + (y : ℂ) * I)) ^ k‖ *
            ‖finiteDirichletSeries S coeff (z + (y : ℂ) * I)‖ ≤
            (H / R) ^ k * finiteDirichletMass S coeff := by
          gcongr
          · exact localizer_norm_boundary_le k H R y hH hR hyR
          · exact norm_finiteDirichletSeries_le_mass S coeff
              (z + y * I) hS (by simp [hz])
        _ = finiteDirichletMass S coeff * (H / R) ^ k := by ring
        _ ≤ (3 / 4) * A := hExterior.le
  have hPL := localizedFiniteDirichlet_halfPlane_bound
    S coeff k z H ((3 / 4) * A) hS hH hz hBoundary (a : ℂ) (by simpa using ha)
  rw [localizedFiniteDirichlet, norm_mul] at hPL
  have hStrict : (3 / 4) * A <
      ‖((H : ℂ) / (H + (a : ℂ))) ^ k‖ *
        ‖finiteDirichletSeries S coeff (z + a)‖ := by
    calc
      (3 / 4) * A < ‖((H : ℂ) / (H + (a : ℂ))) ^ k‖ * A := by gcongr
      _ ≤ ‖((H : ℂ) / (H + (a : ℂ))) ^ k‖ *
          ‖finiteDirichletSeries S coeff (z + a)‖ := by gcongr
  exact (not_lt_of_ge hPL) hStrict


end Legendre.Density.GuthMaynard
