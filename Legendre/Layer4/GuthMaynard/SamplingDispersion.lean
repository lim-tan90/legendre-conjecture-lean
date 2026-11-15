/-
Adapted from Scott McColm's Lean formalization (MIT-0).
Source: https://github.com/smccolm/Lean
Commit: 4c8fb7f7816508825089230e3730b69165e5e303
Original files under Riemann Zeta/9. Zero Density, Large Values and Prime Transfer/
71 Guth-Maynard, 2026/GuthMaynard/: LargeValuesPoisson.lean (first Gram trace),
LargeValuesFinal.lean (spectral moments and raw dispersion count).
Retained license: licenses/smccolm-Lean-MIT-0.txt.
Changes: selected finite results only; local imports and namespace; Lean 4.35.0.
No Poisson or off-diagonal trace estimate is assumed here.
-/
module
public import Legendre.Layer4.GuthMaynard.TraceDispersion

@[expose] public section
namespace Legendre.Density.GuthMaynard
open Complex Finset
open scoped BigOperators Matrix.Norms.L2Operator

/-- The half-open dyadic block contains exactly N integers, including N=0. -/
theorem gmDyadicInterval_card (N : ℕ) : (dyadicInterval N).card = N := by
  simp [dyadicInterval]
  omega

/-- The first Gram trace is the row cardinality times the common diagonal
cutoff sum. -/
theorem gmMatrix_gram_trace_eq_cutoff_sum (cutoff : GMSmoothCutoff)
    (N : ℕ) (W : Finset ℝ) :
    Matrix.trace (gmMatrix cutoff N W * (gmMatrix cutoff N W).conjTranspose) =
      (W.card : ℂ) *
        ∑ n : GMColumn N, (cutoff ((n : ℝ) / N) ^ 2 : ℂ) := by
  simp only [Matrix.trace, Matrix.diag_apply]
  simp_rw [gmMatrix_gram_apply_eq_phase_sum]
  simp only [sub_self, zero_mul, Complex.cpow_zero, mul_one]
  rw [Finset.sum_const, Finset.card_univ, Fintype.card_coe]
  simp only [nsmul_eq_mul]

/-- The `gmCutoffColumnMass` definition used by the source-facing construction in `LargeValuesFinal`. -/
noncomputable def gmCutoffColumnMass (cutoff : GMSmoothCutoff) (N : ℕ) : ℝ :=
  ∑ n : GMColumn N, cutoff ((n : ℝ) / N) ^ 2

theorem gmCutoffColumnMass_nonneg (cutoff : GMSmoothCutoff) (N : ℕ) :
    0 ≤ gmCutoffColumnMass cutoff N := by
  unfold gmCutoffColumnMass
  positivity

theorem gmCutoffColumnMass_le (cutoff : GMSmoothCutoff) (N : ℕ) :
    gmCutoffColumnMass cutoff N ≤ N := by
  unfold gmCutoffColumnMass
  calc
    (∑ n : GMColumn N, cutoff ((n : ℝ) / N) ^ 2) ≤
        ∑ _n : GMColumn N, (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro n hn
      have h0 := cutoff.nonneg ((n : ℝ) / N)
      have h1 := cutoff.bounded ((n : ℝ) / N)
      nlinarith
    _ = N := by simp [gmDyadicInterval_card]

theorem gmMatrix_first_spectral_moment_eq
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    (∑ i : GMRow W,
        (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) =
      (W.card : ℝ) * gmCutoffColumnMass cutoff N := by
  let H := gmMatrix_gram_isHermitian cutoff N W
  have hspectral := H.trace_eq_sum_eigenvalues
  have htrace := gmMatrix_gram_trace_eq_cutoff_sum cutoff N W
  rw [htrace] at hspectral
  apply Complex.ofReal_injective
  simpa only [gmCutoffColumnMass, Complex.ofReal_mul, Complex.ofReal_natCast,
    Complex.ofReal_sum, Complex.ofReal_pow,RCLike.ofReal_eq_complex_ofReal] using hspectral.symm

theorem gmMatrix_first_spectral_moment_nonneg
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    0 ≤ ∑ i : GMRow W,
      (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i := by
  rw [gmMatrix_first_spectral_moment_eq]
  exact mul_nonneg (Nat.cast_nonneg W.card)
    (gmCutoffColumnMass_nonneg cutoff N)

theorem gmMatrix_first_spectral_moment_le
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    (∑ i : GMRow W,
        (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ≤
      (W.card : ℝ) * N := by
  rw [gmMatrix_first_spectral_moment_eq]
  exact mul_le_mul_of_nonneg_left (gmCutoffColumnMass_le cutoff N)
    (Nat.cast_nonneg W.card)

/-- The `gmCubicSpectralDispersion` definition used by the source-facing construction in `LargeValuesFinal`. -/
noncomputable def gmCubicSpectralDispersion
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) : ℝ :=
  (∑ i : GMRow W,
      (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i ^ 3) -
    (∑ i : GMRow W,
      (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
      (W.card : ℝ) ^ 2

theorem gmCubicSpectralDispersion_nonneg
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) (hW : W.Nonempty) :
    0 ≤ gmCubicSpectralDispersion cutoff N W := by
  let s : Finset (GMRow W) := Finset.univ
  let x : GMRow W → ℝ := gmMatrixSingularValue cutoff N W
  have hs : s.Nonempty := by
    rcases hW with ⟨t, ht⟩
    exact ⟨⟨t, ht⟩, Finset.mem_univ _⟩
  have h := sixthMoment_dispersion_nonneg s x hs
  have hsquare : ∀ i : GMRow W, x i ^ 2 =
      (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i := by
    intro i
    exact gmMatrixSingularValue_sq cutoff N W i
  have hsixth : ∀ i : GMRow W, x i ^ 6 =
      (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i ^ 3 := by
    intro i
    exact gmMatrixSingularValue_sixth cutoff N W i
  simpa only [gmCubicSpectralDispersion, s, x, Finset.card_univ,
    Fintype.card_coe, hsquare, hsixth] using h

/-- Guth--Maynard Proposition 4.6 before the individual `S₁/S₂/S₃`
estimates are inserted.  The sampling-matrix large-value inequality and the
sixth-moment dispersion alternative are both consumed here. -/
theorem gm_largeValues_raw_dispersion
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ)
    (b : ℕ → ℂ) (V : ℝ)
    (hN : 0 < N) (hV : 0 < V) (hW : W.Nonempty)
    (hb : ∀ n ∈ dyadicInterval N, ‖b n‖ ≤ 1)
    (hLarge : ∀ t ∈ W, V ≤ ‖gmSmoothDirichletPoly cutoff N b t‖) :
    (W.card : ℝ) ^ 3 * V ^ 6 / (N : ℝ) ^ 3 ≤
      4 * gmCubicSpectralDispersion cutoff N W + 8 * (N : ℝ) ^ 3 := by
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have hwNat : 0 < W.card := hW.card_pos
  have hw : (0 : ℝ) < W.card := by exact_mod_cast hwNat
  have hwne : (W.card : ℝ) ≠ 0 := hw.ne'
  have hCard := gm_largeValues_card_le_operatorNorm cutoff N W b V hV hb hLarge
  obtain ⟨j, hj⟩ := exists_gmMatrixOperatorNorm_le_singularValue cutoff N W hW
  have hOp0 : 0 ≤ gmMatrixOperatorNorm cutoff N W := by
    change 0 ≤ ‖gmMatrix cutoff N W‖
    exact norm_nonneg (gmMatrix cutoff N W)
  have hSing0 : 0 ≤ gmMatrixSingularValue cutoff N W j :=
    gmMatrixSingularValue_nonneg cutoff N W j
  have hCardCube : (W.card : ℝ) ^ 3 ≤
      ((N : ℝ) * gmMatrixOperatorNorm cutoff N W ^ 2 / V ^ 2) ^ 3 :=
    pow_le_pow_left₀ (Nat.cast_nonneg W.card) hCard 3
  have hToOp : (W.card : ℝ) ^ 3 * V ^ 6 / (N : ℝ) ^ 3 ≤
      gmMatrixOperatorNorm cutoff N W ^ 6 := by
    calc
      (W.card : ℝ) ^ 3 * V ^ 6 / (N : ℝ) ^ 3 ≤
          ((N : ℝ) * gmMatrixOperatorNorm cutoff N W ^ 2 / V ^ 2) ^ 3 *
            V ^ 6 / (N : ℝ) ^ 3 := by
        gcongr
      _ = gmMatrixOperatorNorm cutoff N W ^ 6 := by
        field_simp [hn.ne', hV.ne']
  have hOpSing : gmMatrixOperatorNorm cutoff N W ^ 6 ≤
      gmMatrixSingularValue cutoff N W j ^ 6 :=
    pow_le_pow_left₀ hOp0 hj 6
  have hDisp := gmMatrix_singularValue_sixth_le_dispersion_max cutoff N W j
  have hAverage :
      (∑ i : GMRow W,
          (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
          (W.card : ℝ) ^ 3 ≤ (N : ℝ) ^ 3 := by
    rw [gmMatrix_first_spectral_moment_eq]
    field_simp [hwne]
    exact pow_le_pow_left₀ (gmCutoffColumnMass_nonneg cutoff N)
      (gmCutoffColumnMass_le cutoff N) 3
  have hD0 := gmCubicSpectralDispersion_nonneg cutoff N W hW
  calc
    (W.card : ℝ) ^ 3 * V ^ 6 / (N : ℝ) ^ 3 ≤
        gmMatrixOperatorNorm cutoff N W ^ 6 := hToOp
    _ ≤ gmMatrixSingularValue cutoff N W j ^ 6 := hOpSing
    _ ≤ max (4 * gmCubicSpectralDispersion cutoff N W)
          (8 * (∑ i : GMRow W,
            (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
              (W.card : ℝ) ^ 3) := by
      simpa only [gmCubicSpectralDispersion] using hDisp
    _ ≤ 4 * gmCubicSpectralDispersion cutoff N W + 8 * (N : ℝ) ^ 3 := by
      apply max_le
      · exact le_add_of_nonneg_right
          (mul_nonneg (show (0 : ℝ) ≤ 8 by norm_num) (by positivity))
      · calc
          8 * (∑ i : GMRow W,
              (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
                (W.card : ℝ) ^ 3 =
              8 * ((∑ i : GMRow W,
                (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
                  (W.card : ℝ) ^ 3) := by ring
          _ ≤ 8 * (N : ℝ) ^ 3 :=
            mul_le_mul_of_nonneg_left hAverage (show (0 : ℝ) ≤ 8 by norm_num)
          _ ≤ 4 * gmCubicSpectralDispersion cutoff N W + 8 * (N : ℝ) ^ 3 :=
            le_add_of_nonneg_left (mul_nonneg (by norm_num) hD0)


/-- The sixth operator moment is controlled by actual cubic spectral dispersion. -/
theorem gmMatrix_operatorNorm_sixth_le_dispersion
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) (hW : W.Nonempty) :
    gmMatrixOperatorNorm cutoff N W ^ 6 ≤
      4*gmCubicSpectralDispersion cutoff N W+8*(N : ℝ)^3 := by
  have hwNat : 0 < W.card := hW.card_pos
  have hw : (0 : ℝ) < W.card := by exact_mod_cast hwNat
  have hwne : (W.card : ℝ) ≠ 0 := hw.ne'
  obtain ⟨j, hj⟩ := exists_gmMatrixOperatorNorm_le_singularValue cutoff N W hW
  have hOp0 : 0 ≤ gmMatrixOperatorNorm cutoff N W := by
    change 0 ≤ ‖gmMatrix cutoff N W‖
    exact norm_nonneg (gmMatrix cutoff N W)
  have hSing0 : 0 ≤ gmMatrixSingularValue cutoff N W j :=
    gmMatrixSingularValue_nonneg cutoff N W j
  have hOpSing : gmMatrixOperatorNorm cutoff N W ^ 6 ≤
      gmMatrixSingularValue cutoff N W j ^ 6 :=
    pow_le_pow_left₀ hOp0 hj 6
  have hDisp := gmMatrix_singularValue_sixth_le_dispersion_max cutoff N W j
  have hAverage :
      (∑ i : GMRow W,
          (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
          (W.card : ℝ) ^ 3 ≤ (N : ℝ) ^ 3 := by
    rw [gmMatrix_first_spectral_moment_eq]
    field_simp [hwne]
    exact pow_le_pow_left₀ (gmCutoffColumnMass_nonneg cutoff N)
      (gmCutoffColumnMass_le cutoff N) 3
  have hD0 := gmCubicSpectralDispersion_nonneg cutoff N W hW
  calc
    gmMatrixOperatorNorm cutoff N W ^ 6 ≤ gmMatrixSingularValue cutoff N W j ^ 6 := hOpSing
    _ ≤ max (4 * gmCubicSpectralDispersion cutoff N W)
          (8 * (∑ i : GMRow W,
            (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
              (W.card : ℝ) ^ 3) := by
      simpa only [gmCubicSpectralDispersion] using hDisp
    _ ≤ 4 * gmCubicSpectralDispersion cutoff N W + 8 * (N : ℝ) ^ 3 := by
      apply max_le
      · exact le_add_of_nonneg_right
          (mul_nonneg (show (0 : ℝ) ≤ 8 by norm_num) (by positivity))
      · calc
          8 * (∑ i : GMRow W,
              (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
                (W.card : ℝ) ^ 3 =
              8 * ((∑ i : GMRow W,
                (gmMatrix_gram_isHermitian cutoff N W).eigenvalues i) ^ 3 /
                  (W.card : ℝ) ^ 3) := by ring
          _ ≤ 8 * (N : ℝ) ^ 3 :=
            mul_le_mul_of_nonneg_left hAverage (show (0 : ℝ) ≤ 8 by norm_num)
          _ ≤ 4 * gmCubicSpectralDispersion cutoff N W + 8 * (N : ℝ) ^ 3 :=
            le_add_of_nonneg_left (mul_nonneg (by norm_num) hD0)


/-- Arbitrary coefficient energy is retained; no coefficient normalization is assumed. -/
theorem gm_largeValues_energy_dispersion
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) (hW : W.Nonempty)
    (b : ℕ → ℂ) (V : ℝ) (hV : 0 ≤ V)
    (hLarge : ∀ t ∈ W, V ≤ ‖gmSmoothDirichletPoly cutoff N b t‖) :
    (W.card : ℝ)^3*V^6 ≤
      (∑ n : GMColumn N, ‖b n‖^2)^3*
        (4*gmCubicSpectralDispersion cutoff N W+8*(N : ℝ)^3) := by
  have hc := (gmMatrix_sample_energy_lower cutoff N W b V hV hLarge).trans
    (gmMatrix_energy_le_operatorNorm cutoff N W b)
  have hp := pow_le_pow_left₀ (show 0 ≤ (W.card : ℝ)*V^2 by positivity) hc 3
  have he : (W.card : ℝ)^3*V^6 ≤
      gmMatrixOperatorNorm cutoff N W^6*(∑ n : GMColumn N, ‖b n‖^2)^3 := by
    simp only [gmCoefficientVector] at hp
    convert hp using 1 <;> ring
  have hb := gmMatrix_operatorNorm_sixth_le_dispersion cutoff N W hW
  calc
    _ ≤ gmMatrixOperatorNorm cutoff N W^6*(∑ n : GMColumn N, ‖b n‖^2)^3 := he
    _ ≤ (4*gmCubicSpectralDispersion cutoff N W+8*(N : ℝ)^3)*
        (∑ n : GMColumn N, ‖b n‖^2)^3 := mul_le_mul_of_nonneg_right hb (by positivity)
    _ = _ := by ring

/-- The dispersion is the literal centered cubic Gram trace. -/
theorem gmCubicSpectralDispersion_eq_trace (cutoff : GMSmoothCutoff) (N : ℕ)
    (W : Finset ℝ) :
    gmCubicSpectralDispersion cutoff N W =
      (Matrix.trace ((gmMatrix cutoff N W*(gmMatrix cutoff N W).conjTranspose)^3)).re-
        (Matrix.trace (gmMatrix cutoff N W*(gmMatrix cutoff N W).conjTranspose)).re^3/
          (W.card : ℝ)^2 := by
  have H := gmMatrix_gram_isHermitian cutoff N W
  have ht1 := congrArg Complex.re H.trace_eq_sum_eigenvalues
  have ht3 := congrArg Complex.re (Matrix.IsHermitian.trace_cube_eq_sum_eigenvalues_cube H)
  simp only [RCLike.ofReal_eq_complex_ofReal,Complex.re_sum,←Complex.ofReal_pow,Complex.ofReal_re] at ht1 ht3
  unfold gmCubicSpectralDispersion
  rw [ht1,ht3]

end Legendre.Density.GuthMaynard
