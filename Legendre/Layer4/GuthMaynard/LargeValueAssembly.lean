/-
Copyright (c) 2026 S. McColm.
Released under the MIT-0 license; retained verbatim in
licenses/smccolm-Lean-MIT-0.txt.

Adapted for Lean 4.35.0 from smccolm/Lean,
commit 4c8fb7f7816508825089230e3730b69165e5e303,
Riemann Zeta/9. Zero Density, Large Values and Prime Transfer/
71 Guth-Maynard, 2026/GuthMaynard/LargeValuesFinal.lean (complementary ranges and final assembly)
and GuthMaynard/Statements.lean (Theorem 1.1 interfaces)
See docs/smccolm-guth-provenance.md for changes and reused dependencies.
-/
module
public import Legendre.Layer4.GuthMaynard.SmoothAssembly
public import Legendre.Layer4.GuthMaynard.ClassicalAdapter

@[expose] public section
open Complex Finset Real
open scoped BigOperators Matrix.Norms.L2Operator
namespace Legendre.Density.GuthMaynard

/--
Theorem 1.1 (Large values estimate).
Suppose $b_n$ is a sequence of complex numbers with $|b_n| \le 1$, and $W$ is a sequence of
$1$-separated points in $[0, T]$ such that $|D_N(t)| \ge V$ for all $t \in W$.
Then $|W| \lessapprox N^2 V^{-2} + N^{18/5} V^{-4} + T N^{12/5} V^{-4}$.

We formulate $T^{o(1)}$ explicitly with $\varepsilon$.  This is the project's
internal open-dyadic-support interface: it asks for a global coefficient bound
because that is convenient for downstream consumers.  The literal published
Theorem 1.1 contract (closed sum, support-only coefficient bound, and positive
phase) and its native proof are in `RiemannZeta.PublicationContract`.
-/
def GuthMaynardLargeValues : Prop :=
  ∀ (ε : ℝ), ε > 0 →
    ∃ (C T₀ : ℝ), 0 < C ∧ 1 ≤ T₀ ∧
    ∀ (N : ℕ) (V T : ℝ) (b : ℕ → ℂ) (W : Finset ℝ),
      0 < N → T₀ ≤ T → 0 < V →
      (∀ n, ‖b n‖ ≤ 1) →
      IsSeparated 1 W →
      InBaseInterval T W →
      (∀ t ∈ W, V ≤ ‖sourceDirichletPoly N b t‖) →
      (W.card : ℝ) ≤ C * T ^ ε * ((N:ℝ)^2 * V^(-2:ℝ) + (N:ℝ)^(18/5:ℝ) * V^(-4:ℝ) + T * (N:ℝ)^(12/5:ℝ) * V^(-4:ℝ))

/-- The equivalent negative-sign form consumed by the project's detector
polynomials. Its proof is coefficient conjugation, not an additional analytic
assumption. -/
def GuthMaynardLargeValuesNeg : Prop :=
  ∀ (ε : ℝ), ε > 0 →
    ∃ (C T₀ : ℝ), 0 < C ∧ 1 ≤ T₀ ∧
    ∀ (N : ℕ) (V T : ℝ) (b : ℕ → ℂ) (W : Finset ℝ),
      0 < N → T₀ ≤ T → 0 < V →
      (∀ n, ‖b n‖ ≤ 1) →
      IsSeparated 1 W →
      InBaseInterval T W →
      (∀ t ∈ W, V ≤ ‖dirichletPoly N b t‖) →
      (W.card : ℝ) ≤ C * T ^ ε * ((N:ℝ)^2 * V^(-2:ℝ) + (N:ℝ)^(18/5:ℝ) * V^(-4:ℝ) + T * (N:ℝ)^(12/5:ℝ) * V^(-4:ℝ))

theorem guthMaynardLargeValues_neg
    (hLargeValues : GuthMaynardLargeValues) : GuthMaynardLargeValuesNeg := by
  intro ε hε
  obtain ⟨C, T₀, hC, hT₀, hLarge⟩ := hLargeValues ε hε
  refine ⟨C, T₀, hC, hT₀, ?_⟩
  intro N V T b W hN hT hV hb hSeparated hInterval hValues
  apply hLarge N V T (conjugateCoeffs b) W hN hT hV
  · intro n
    rw [norm_conjugateCoeffs]
    exact hb n
  · exact hSeparated
  · exact hInterval
  · intro t ht
    rw [norm_sourceDirichletPoly_conjugateCoeffs]
    exact hValues t ht

theorem gm_inv_rpow_two {V : ℝ} (hV : 0 < V) :
    V ^ (-2 : ℝ) = 1 / V ^ 2 := by
  rw [Real.rpow_neg hV.le, Real.rpow_two, inv_eq_one_div]

theorem gm_inv_rpow_four {V : ℝ} (hV : 0 < V) :
    V ^ (-4 : ℝ) = 1 / V ^ 4 := by
  rw [Real.rpow_neg hV.le, ← Real.rpow_natCast]
  norm_num

theorem gm_classical_min_low
    {N : ℕ} {V B : ℝ} (hN : 0 < N) (hV : 0 < V)
    (hLow : V ≤ B * (N : ℝ) ^ (7 / 10 : ℝ)) :
    min ((N : ℝ) / V ^ 2) ((N : ℝ) ^ 4 / V ^ 6) ≤
      B ^ 2 * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ) := by
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have hpowSeven : ((N : ℝ) ^ (7 / 10 : ℝ)) ^ 2 =
      (N : ℝ) ^ (7 / 5 : ℝ) := by
    rw [← Real.rpow_natCast, ← Real.rpow_mul hn.le]
    congr 1
    ring
  have hVsq : V ^ 2 ≤ B ^ 2 * (N : ℝ) ^ (7 / 5 : ℝ) := by
    have hs := pow_le_pow_left₀ hV.le hLow 2
    calc
      V ^ 2 ≤ (B * (N : ℝ) ^ (7 / 10 : ℝ)) ^ 2 := hs
      _ = B ^ 2 * (N : ℝ) ^ (7 / 5 : ℝ) := by
        rw [mul_pow, hpowSeven]
  have hpowTwelve : (N : ℝ) * (N : ℝ) ^ (7 / 5 : ℝ) =
      (N : ℝ) ^ (12 / 5 : ℝ) := by
    calc
      (N : ℝ) * (N : ℝ) ^ (7 / 5 : ℝ) =
          (N : ℝ) ^ (1 : ℝ) * (N : ℝ) ^ (7 / 5 : ℝ) := by
            rw [Real.rpow_one]
      _ = (N : ℝ) ^ ((1 : ℝ) + 7 / 5) := (Real.rpow_add hn _ _).symm
      _ = (N : ℝ) ^ (12 / 5 : ℝ) := by
        congr 1
        ring
  have hnum : (N : ℝ) * V ^ 2 ≤ B ^ 2 * (N : ℝ) ^ (12 / 5 : ℝ) := by
    calc
      (N : ℝ) * V ^ 2 ≤ (N : ℝ) *
          (B ^ 2 * (N : ℝ) ^ (7 / 5 : ℝ)) := by gcongr
      _ = B ^ 2 * (N : ℝ) ^ (12 / 5 : ℝ) := by
        rw [← hpowTwelve]
        ring
  calc
    min ((N : ℝ) / V ^ 2) ((N : ℝ) ^ 4 / V ^ 6) ≤ (N : ℝ) / V ^ 2 := min_le_left _ _
    _ ≤ B ^ 2 * (N : ℝ) ^ (12 / 5 : ℝ) / V ^ 4 := by
      rw [show (N : ℝ) / V ^ 2 = ((N : ℝ) * V ^ 2) / V ^ 4 by
        field_simp [hV.ne']]
      apply (div_le_div_iff_of_pos_right (pow_pos hV 4)).2
      exact hnum
    _ = B ^ 2 * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ) := by
      rw [gm_inv_rpow_four hV]
      ring

theorem gm_classical_min_high
    {N : ℕ} {V : ℝ} (hN : 0 < N) (hV : 0 < V)
    (hHigh : (1 / 2 : ℝ) * (N : ℝ) ^ (4 / 5 : ℝ) ≤ V) :
    min ((N : ℝ) / V ^ 2) ((N : ℝ) ^ 4 / V ^ 6) ≤
      4 * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ) := by
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have hpowEight : ((N : ℝ) ^ (4 / 5 : ℝ)) ^ 2 =
      (N : ℝ) ^ (8 / 5 : ℝ) := by
    rw [← Real.rpow_natCast, ← Real.rpow_mul hn.le]
    congr 1
    ring
  have hNsq : (N : ℝ) ^ (8 / 5 : ℝ) ≤ 4 * V ^ 2 := by
    have hs := pow_le_pow_left₀ (by positivity : 0 ≤ (1 / 2 : ℝ) *
      (N : ℝ) ^ (4 / 5 : ℝ)) hHigh 2
    calc
      (N : ℝ) ^ (8 / 5 : ℝ) =
          4 * ((1 / 2 : ℝ) * (N : ℝ) ^ (4 / 5 : ℝ)) ^ 2 := by
        rw [mul_pow, hpowEight]
        ring
      _ ≤ 4 * V ^ 2 := by gcongr
  have hnum : (N : ℝ) ^ 4 ≤
      4 * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ 2 := by
    calc
      (N : ℝ) ^ 4 = (N : ℝ) ^ (12 / 5 : ℝ) *
          (N : ℝ) ^ (8 / 5 : ℝ) := by
        rw [← Real.rpow_add hn]
        norm_num [Real.rpow_natCast]
      _ ≤ (N : ℝ) ^ (12 / 5 : ℝ) * (4 * V ^ 2) := by gcongr
      _ = 4 * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ 2 := by ring
  calc
    min ((N : ℝ) / V ^ 2) ((N : ℝ) ^ 4 / V ^ 6) ≤
        (N : ℝ) ^ 4 / V ^ 6 := min_le_right _ _
    _ ≤ 4 * (N : ℝ) ^ (12 / 5 : ℝ) / V ^ 4 := by
      field_simp [hV.ne']
      nlinarith
    _ = 4 * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ) := by
      rw [gm_inv_rpow_four hV]
      ring

set_option maxHeartbeats 1000000 in
theorem gm_classical_source_low
    (ε B : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧
      ∀ (N : ℕ) (V T : ℝ) (b : ℕ → ℂ) (W : Finset ℝ),
      0 < N → 1 ≤ T → (N : ℝ) ≤ T → 0 < V →
      V ≤ B * (N : ℝ) ^ (7 / 10 : ℝ) →
      (∀ n, ‖b n‖ ≤ 1) → IsSeparated 1 W → InBaseInterval T W →
      (∀ t ∈ W, V ≤ ‖sourceDirichletPoly N b t‖) →
      (W.card : ℝ) ≤ C * T ^ ε *
        ((N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
          (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
  obtain ⟨C₀, hC₀, hMHH⟩ := classical_montgomery_halasz_huxley_native ε hε
  let C := C₀ * (1 + B ^ 2)
  refine ⟨C, by dsimp only [C]; positivity, ?_⟩
  intro N V T b W hN hT hNT hV hLow hb hSep hBase hLarge
  have hb' : ∀ n ∈ dyadicInterval N, ‖conjugateCoeffs b n‖ ≤ 1 := by
    intro n hn
    rw [norm_conjugateCoeffs]
    exact hb n
  have hLarge' : ∀ t ∈ W, V ≤ ‖dirichletPoly N (conjugateCoeffs b) t‖ := by
    intro t ht
    rw [← norm_sourceDirichletPoly_eq_dirichletPoly_conjugateCoeffs]
    exact hLarge t ht
  have hraw := hMHH N T V W (conjugateCoeffs b) hN hT hNT hV hb' hSep hBase hLarge'
  have hmin := gm_classical_min_low hN hV hLow
  have hBsq : 0 ≤ B ^ 2 := sq_nonneg B
  have hfirst : (N : ℝ) ^ 2 / V ^ 2 = (N : ℝ) ^ 2 * V ^ (-2 : ℝ) := by
    rw [gm_inv_rpow_two hV]
    ring
  let X : ℝ := (N : ℝ) ^ 2 * V ^ (-2 : ℝ)
  let Y : ℝ := (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ)
  let Z : ℝ := T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)
  have hX : 0 ≤ X := by dsimp only [X]; positivity
  have hY : 0 ≤ Y := by dsimp only [Y]; positivity
  have hZ : 0 ≤ Z := by dsimp only [Z]; positivity
  have hinner₁ : (N : ℝ) ^ 2 / V ^ 2 +
      T * min ((N : ℝ) / V ^ 2) ((N : ℝ) ^ 4 / V ^ 6) ≤ X + B ^ 2 * Z := by
    rw [hfirst]
    dsimp only [X, Z]
    have hm := mul_le_mul_of_nonneg_left hmin (zero_le_one.trans hT)
    nlinarith
  have hinner₂ : X + B ^ 2 * Z ≤ (1 + B ^ 2) * (X + Y + Z) := by
    nlinarith [mul_nonneg hBsq hZ]
  calc
    (W.card : ℝ) ≤ C₀ * T ^ ε *
        ((N : ℝ) ^ 2 / V ^ 2 +
          T * min ((N : ℝ) / V ^ 2) ((N : ℝ) ^ 4 / V ^ 6)) := hraw
    _ ≤ C₀ * T ^ ε * (X + B ^ 2 * Z) :=
      mul_le_mul_of_nonneg_left hinner₁
        (mul_nonneg hC₀.le (Real.rpow_nonneg (zero_le_one.trans hT) ε))
    _ ≤ C * T ^ ε *
        ((N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
          (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
      dsimp only [C]
      dsimp only [X, Y, Z] at hinner₂ ⊢
      nlinarith [mul_nonneg (mul_nonneg hC₀.le
        (Real.rpow_nonneg (zero_le_one.trans hT) ε))
        (sub_nonneg.mpr hinner₂)]

set_option maxHeartbeats 1000000 in
theorem gm_classical_source_high
    (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧
      ∀ (N : ℕ) (V T : ℝ) (b : ℕ → ℂ) (W : Finset ℝ),
      0 < N → 1 ≤ T → (N : ℝ) ≤ T → 0 < V →
      (1 / 2 : ℝ) * (N : ℝ) ^ (4 / 5 : ℝ) ≤ V →
      (∀ n, ‖b n‖ ≤ 1) → IsSeparated 1 W → InBaseInterval T W →
      (∀ t ∈ W, V ≤ ‖sourceDirichletPoly N b t‖) →
      (W.card : ℝ) ≤ C * T ^ ε *
        ((N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
          (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
  obtain ⟨C₀, hC₀, hMHH⟩ := classical_montgomery_halasz_huxley_native ε hε
  let C := 5 * C₀
  refine ⟨C, by dsimp only [C]; positivity, ?_⟩
  intro N V T b W hN hT hNT hV hHigh hb hSep hBase hLarge
  have hb' : ∀ n ∈ dyadicInterval N, ‖conjugateCoeffs b n‖ ≤ 1 := by
    intro n hn
    rw [norm_conjugateCoeffs]
    exact hb n
  have hLarge' : ∀ t ∈ W, V ≤ ‖dirichletPoly N (conjugateCoeffs b) t‖ := by
    intro t ht
    rw [← norm_sourceDirichletPoly_eq_dirichletPoly_conjugateCoeffs]
    exact hLarge t ht
  have hraw := hMHH N T V W (conjugateCoeffs b) hN hT hNT hV hb' hSep hBase hLarge'
  have hmin := gm_classical_min_high hN hV hHigh
  have hfirst : (N : ℝ) ^ 2 / V ^ 2 = (N : ℝ) ^ 2 * V ^ (-2 : ℝ) := by
    rw [gm_inv_rpow_two hV]
    ring
  let X : ℝ := (N : ℝ) ^ 2 * V ^ (-2 : ℝ)
  let Y : ℝ := (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ)
  let Z : ℝ := T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)
  have hX : 0 ≤ X := by dsimp only [X]; positivity
  have hY : 0 ≤ Y := by dsimp only [Y]; positivity
  have hZ : 0 ≤ Z := by dsimp only [Z]; positivity
  have hinner₁ : (N : ℝ) ^ 2 / V ^ 2 +
      T * min ((N : ℝ) / V ^ 2) ((N : ℝ) ^ 4 / V ^ 6) ≤ X + 4 * Z := by
    rw [hfirst]
    dsimp only [X, Z]
    have hm := mul_le_mul_of_nonneg_left hmin (zero_le_one.trans hT)
    nlinarith
  have hinner₂ : X + 4 * Z ≤ 5 * (X + Y + Z) := by nlinarith
  calc
    (W.card : ℝ) ≤ C₀ * T ^ ε *
        ((N : ℝ) ^ 2 / V ^ 2 +
          T * min ((N : ℝ) / V ^ 2) ((N : ℝ) ^ 4 / V ^ 6)) := hraw
    _ ≤ C₀ * T ^ ε * (X + 4 * Z) :=
      mul_le_mul_of_nonneg_left hinner₁
        (mul_nonneg hC₀.le (Real.rpow_nonneg (zero_le_one.trans hT) ε))
    _ ≤ C * T ^ ε * (X + Y + Z) := by
      dsimp only [C]
      nlinarith [mul_nonneg (mul_nonneg hC₀.le
        (Real.rpow_nonneg (zero_le_one.trans hT) ε))
        (sub_nonneg.mpr hinner₂)]
    _ = C * T ^ ε *
        ((N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
          (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by rfl

set_option maxHeartbeats 1000000 in
theorem gm_classical_source_near_height
    (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧
      ∀ (N : ℕ) (V T : ℝ) (b : ℕ → ℂ) (W : Finset ℝ),
      0 < N → 1 ≤ T → T ≤ 2 * (N : ℝ) → 0 < V →
      (∀ n, ‖b n‖ ≤ 1) → IsSeparated 1 W → InBaseInterval T W →
      (∀ t ∈ W, V ≤ ‖sourceDirichletPoly N b t‖) →
      (W.card : ℝ) ≤ C * T ^ ε *
        ((N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
          (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
  obtain ⟨C₀, hC₀, hSecond⟩ := classical_large_values_second_branch_unrestricted
  let C := 3 * C₀
  refine ⟨C, by dsimp only [C]; positivity, ?_⟩
  intro N V T b W hN hT hTN hV hb hSep hBase hLarge
  have hb' : ∀ n ∈ dyadicInterval N, ‖conjugateCoeffs b n‖ ≤ 1 := by
    intro n hn
    rw [norm_conjugateCoeffs]
    exact hb n
  have hLarge' : ∀ t ∈ W, V ≤ ‖dirichletPoly N (conjugateCoeffs b) t‖ := by
    intro t ht
    rw [← norm_sourceDirichletPoly_eq_dirichletPoly_conjugateCoeffs]
    exact hLarge t ht
  have hraw := hSecond N T V W (conjugateCoeffs b) hN hT hV hb' hSep hBase hLarge'
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have hfirst : (N : ℝ) ^ 2 / V ^ 2 = (N : ℝ) ^ 2 * V ^ (-2 : ℝ) := by
    rw [gm_inv_rpow_two hV]
    ring
  have hsecond : T * (N : ℝ) / V ^ 2 ≤
      2 * ((N : ℝ) ^ 2 * V ^ (-2 : ℝ)) := by
    rw [gm_inv_rpow_two hV]
    have hmul := mul_le_mul_of_nonneg_right hTN hn.le
    field_simp [hV.ne']
    nlinarith
  have hTone : 1 ≤ T ^ ε := Real.one_le_rpow hT hε.le
  let X : ℝ := (N : ℝ) ^ 2 * V ^ (-2 : ℝ)
  let Y : ℝ := (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ)
  let Z : ℝ := T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)
  have hX : 0 ≤ X := by dsimp only [X]; positivity
  have hY : 0 ≤ Y := by dsimp only [Y]; positivity
  have hZ : 0 ≤ Z := by dsimp only [Z]; positivity
  have hinner₁ : (N : ℝ) ^ 2 / V ^ 2 + T * (N : ℝ) / V ^ 2 ≤ 3 * X := by
    rw [hfirst]
    dsimp only [X]
    nlinarith
  have hinner₂ : 3 * X ≤ 3 * T ^ ε * (X + Y + Z) := by
    nlinarith [mul_nonneg (zero_le_one.trans hTone) (add_nonneg (add_nonneg hX hY) hZ)]
  calc
    (W.card : ℝ) ≤ C₀ * ((N : ℝ) ^ 2 / V ^ 2 + T * (N : ℝ) / V ^ 2) := hraw
    _ ≤ C₀ * (3 * X) := mul_le_mul_of_nonneg_left hinner₁ hC₀.le
    _ ≤ C * T ^ ε * (X + Y + Z) := by
      dsimp only [C]
      nlinarith [mul_nonneg hC₀.le (sub_nonneg.mpr hinner₂)]
    _ = C * T ^ ε *
        ((N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
          (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by rfl

theorem gm_source_scale_bounds
    {N Q : ℕ} (hN : 30 ≤ N)
    (hQ : Q = gmSourceLeftScale N ∨ Q = N ∨ Q = gmSourceRightScale N) :
    N ≤ 2 * Q ∧ Q ≤ 2 * N := by
  rcases hQ with hQ | hQ | hQ
  · subst Q
    dsimp only [gmSourceLeftScale]
    omega
  · subst Q
    omega
  · subst Q
    dsimp only [gmSourceRightScale]
    omega

theorem gm_source_scale_gt_one
    {N Q : ℕ} (hN : 30 ≤ N)
    (hQ : Q = gmSourceLeftScale N ∨ Q = N ∨ Q = gmSourceRightScale N) :
    1 < Q := by
  have h := (gm_source_scale_bounds hN hQ).1
  omega

theorem gm_rpow_scale_le_sixteen
    {N Q : ℕ} (hQ : Q ≤ 2 * N) :
    (Q : ℝ) ^ (18 / 5 : ℝ) ≤ 16 * (N : ℝ) ^ (18 / 5 : ℝ) := by
  have hn : (0 : ℝ) ≤ N := Nat.cast_nonneg N
  have hcast : (Q : ℝ) ≤ 2 * (N : ℝ) := by exact_mod_cast hQ
  calc
    (Q : ℝ) ^ (18 / 5 : ℝ) ≤ (2 * (N : ℝ)) ^ (18 / 5 : ℝ) :=
      Real.rpow_le_rpow (Nat.cast_nonneg Q) hcast (by norm_num)
    _ = (2 : ℝ) ^ (18 / 5 : ℝ) * (N : ℝ) ^ (18 / 5 : ℝ) :=
      Real.mul_rpow (by norm_num) hn
    _ ≤ 16 * (N : ℝ) ^ (18 / 5 : ℝ) := by
      have hpow : (2 : ℝ) ^ (18 / 5 : ℝ) ≤ (2 : ℝ) ^ (4 : ℝ) :=
        Real.rpow_le_rpow_of_exponent_le (by norm_num) (by norm_num)
      have hpow' : (2 : ℝ) ^ (18 / 5 : ℝ) ≤ 16 := hpow.trans_eq (by norm_num)
      exact mul_le_mul_of_nonneg_right hpow' (Real.rpow_nonneg hn _)

theorem gm_rpow_scale_le_eight
    {N Q : ℕ} (hQ : Q ≤ 2 * N) :
    (Q : ℝ) ^ (12 / 5 : ℝ) ≤ 8 * (N : ℝ) ^ (12 / 5 : ℝ) := by
  have hn : (0 : ℝ) ≤ N := Nat.cast_nonneg N
  have hcast : (Q : ℝ) ≤ 2 * (N : ℝ) := by exact_mod_cast hQ
  calc
    (Q : ℝ) ^ (12 / 5 : ℝ) ≤ (2 * (N : ℝ)) ^ (12 / 5 : ℝ) :=
      Real.rpow_le_rpow (Nat.cast_nonneg Q) hcast (by norm_num)
    _ = (2 : ℝ) ^ (12 / 5 : ℝ) * (N : ℝ) ^ (12 / 5 : ℝ) :=
      Real.mul_rpow (by norm_num) hn
    _ ≤ 8 * (N : ℝ) ^ (12 / 5 : ℝ) := by
      have hpow : (2 : ℝ) ^ (12 / 5 : ℝ) ≤ (2 : ℝ) ^ (3 : ℝ) :=
        Real.rpow_le_rpow_of_exponent_le (by norm_num) (by norm_num)
      have hpow' : (2 : ℝ) ^ (12 / 5 : ℝ) ≤ 8 := hpow.trans_eq (by norm_num)
      exact mul_le_mul_of_nonneg_right hpow' (Real.rpow_nonneg hn _)

theorem gm_source_scale_critical_lower
    {N Q : ℕ} {V : ℝ} (hQ : Q ≤ 2 * N)
    (hLow : 6 * (N : ℝ) ^ (7 / 10 : ℝ) ≤ V) :
    (Q : ℝ) ^ (7 / 10 : ℝ) ≤ V / 3 := by
  have hcast : (Q : ℝ) ≤ 2 * (N : ℝ) := by exact_mod_cast hQ
  have hn : (0 : ℝ) ≤ N := Nat.cast_nonneg N
  have hq := Real.rpow_le_rpow (Nat.cast_nonneg Q) hcast (by norm_num : (0 : ℝ) ≤ 7 / 10)
  rw [Real.mul_rpow (by norm_num : (0 : ℝ) ≤ 2) hn] at hq
  have htwo : (2 : ℝ) ^ (7 / 10 : ℝ) ≤ 2 := by
    calc
      (2 : ℝ) ^ (7 / 10 : ℝ) ≤ (2 : ℝ) ^ (1 : ℝ) :=
        Real.rpow_le_rpow_of_exponent_le (by norm_num) (by norm_num)
      _ = 2 := Real.rpow_one _
  have hmid : (Q : ℝ) ^ (7 / 10 : ℝ) ≤
      2 * (N : ℝ) ^ (7 / 10 : ℝ) :=
    hq.trans (mul_le_mul_of_nonneg_right htwo (Real.rpow_nonneg hn _))
  linarith

theorem gm_source_scale_critical_upper
    {N Q : ℕ} {V : ℝ} (hQ : N ≤ 2 * Q)
    (hHigh : V ≤ (1 / 2 : ℝ) * (N : ℝ) ^ (4 / 5 : ℝ)) :
    V / 3 ≤ (Q : ℝ) ^ (4 / 5 : ℝ) := by
  have hcast : (N : ℝ) ≤ 2 * (Q : ℝ) := by exact_mod_cast hQ
  have hq0 : (0 : ℝ) ≤ Q := Nat.cast_nonneg Q
  have hnq := Real.rpow_le_rpow (Nat.cast_nonneg N) hcast (by norm_num : (0 : ℝ) ≤ 4 / 5)
  rw [Real.mul_rpow (by norm_num : (0 : ℝ) ≤ 2) hq0] at hnq
  have htwo : (2 : ℝ) ^ (4 / 5 : ℝ) ≤ 2 := by
    calc
      (2 : ℝ) ^ (4 / 5 : ℝ) ≤ (2 : ℝ) ^ (1 : ℝ) :=
        Real.rpow_le_rpow_of_exponent_le (by norm_num) (by norm_num)
      _ = 2 := Real.rpow_one _
  have hmid : (N : ℝ) ^ (4 / 5 : ℝ) ≤
      2 * (Q : ℝ) ^ (4 / 5 : ℝ) :=
    hnq.trans (mul_le_mul_of_nonneg_right htwo (Real.rpow_nonneg hq0 _))
  linarith [Real.rpow_nonneg hq0 (4 / 5 : ℝ)]

theorem gm_div_three_rpow_neg_four {V : ℝ} (hV : 0 < V) :
    (V / 3) ^ (-4 : ℝ) = 81 * V ^ (-4 : ℝ) := by
  rw [gm_inv_rpow_four (div_pos hV (by norm_num)), gm_inv_rpow_four hV]
  field_simp [hV.ne']
  ring

set_option maxHeartbeats 1000000 in
/-- The genuinely Guth--Maynard part of Theorem 1.1 after the exact
three-piece source localization.  The hypotheses are the central range in
which all three localized scales satisfy Proposition 3.1. -/
theorem gm_source_large_values_critical
    (cutoff : GMSmoothCutoff) (ε : ℝ) (hε : 0 < ε) :
    ∃ C T₀ : ℝ, 0 < C ∧ 4096 ≤ T₀ ∧
      ∀ (N : ℕ) (V T : ℝ) (b : ℕ → ℂ) (W : Finset ℝ),
      30 ≤ N → 2 * T₀ ≤ (N : ℝ) → 2 * (N : ℝ) ≤ T → 0 < V →
      6 * (N : ℝ) ^ (7 / 10 : ℝ) ≤ V →
      V ≤ (1 / 2 : ℝ) * (N : ℝ) ^ (4 / 5 : ℝ) →
      (∀ n, ‖b n‖ ≤ 1) → IsSeparated 1 W → InBaseInterval T W →
      (∀ t ∈ W, V ≤ ‖sourceDirichletPoly N b t‖) →
      (W.card : ℝ) ≤ C * T ^ ε *
        ((N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
  obtain ⟨C₀, T₀, hC₀, hT₀, hFull⟩ :=
    gmProposition3_1_smooth_fullHeight cutoff ε hε
  let C := 3888 * C₀
  refine ⟨C, T₀, by dsimp only [C]; positivity, hT₀, ?_⟩
  intro N V T b W hN hNlarge hNT hV hLow hHigh hb hSep hBase hLarge
  have hNpos : 0 < N := by omega
  have hbDyadic : ∀ n ∈ dyadicInterval N, ‖b n‖ ≤ 1 := by
    intro n hn
    exact hb n
  obtain ⟨W', Q, c, hsub, hcardNat, hcase, hc, hlarge, hmatrix⟩ :=
    source_large_values_localize_to_matrix cutoff hN b W V hV hbDyadic hLarge
  have hQcase : Q = gmSourceLeftScale N ∨ Q = N ∨ Q = gmSourceRightScale N := by
    rcases hcase with ⟨hQ, hcEq⟩ | ⟨hQ, hcEq⟩ | ⟨hQ, hcEq⟩
    · exact Or.inl hQ
    · exact Or.inr (Or.inl hQ)
    · exact Or.inr (Or.inr hQ)
  have hQB := gm_source_scale_bounds hN hQcase
  have hQgt : 1 < Q := gm_source_scale_gt_one hN hQcase
  have hQpos : (0 : ℝ) < Q := by exact_mod_cast (Nat.zero_lt_of_lt hQgt)
  have hQone : (1 : ℝ) ≤ Q := by exact_mod_cast (Nat.one_le_iff_ne_zero.mpr (Nat.zero_lt_of_lt hQgt).ne')
  have hT₀Q : T₀ ≤ (Q : ℝ) ^ (6 / 5 : ℝ) := by
    have hNQ : (N : ℝ) ≤ 2 * Q := by exact_mod_cast hQB.1
    have hT₀leQ : T₀ ≤ (Q : ℝ) := by linarith
    exact hT₀leQ.trans (by
      simpa only [Real.rpow_one] using
        Real.rpow_le_rpow_of_exponent_le hQone (by norm_num : (1 : ℝ) ≤ 6 / 5))
  have hQT : (Q : ℝ) ≤ T := by
    have hQN : (Q : ℝ) ≤ 2 * N := by exact_mod_cast hQB.2
    exact hQN.trans hNT
  have hVL : (Q : ℝ) ^ (7 / 10 : ℝ) ≤ V / 3 :=
    gm_source_scale_critical_lower hQB.2 hLow
  have hVU : V / 3 ≤ (Q : ℝ) ^ (4 / 5 : ℝ) :=
    gm_source_scale_critical_upper hQB.1 hHigh
  have hSep' : IsSeparated 1 W' := by
    intro x hx y hy hxy
    exact hSep x (hsub hx) y (hsub hy) hxy
  have hBase' : InBaseInterval T W' := by
    intro t ht
    exact hBase t (hsub ht)
  have hfull := hFull Q (V / 3) T W' c hQgt hT₀Q hQT
    (div_pos hV (by norm_num)) hVL hVU hSep' hBase' hc hlarge
  have hcardReal : (W.card : ℝ) ≤ 3 * (W'.card : ℝ) := by exact_mod_cast hcardNat
  have hQ18 := gm_rpow_scale_le_sixteen hQB.2
  have hQ12 := gm_rpow_scale_le_eight hQB.2
  have htail : 0 ≤ T := hQpos.le.trans hQT
  have hshape :
      (Q : ℝ) ^ (18 / 5 : ℝ) * (V / 3) ^ (-4 : ℝ) +
          T * (Q : ℝ) ^ (12 / 5 : ℝ) * (V / 3) ^ (-4 : ℝ) ≤
        1296 * ((N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
    rw [gm_div_three_rpow_neg_four hV]
    have hV4 : 0 ≤ V ^ (-4 : ℝ) := Real.rpow_nonneg hV.le _
    have h₁ : (Q : ℝ) ^ (18 / 5 : ℝ) * (81 * V ^ (-4 : ℝ)) ≤
        1296 * ((N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
      have hm := mul_le_mul_of_nonneg_right hQ18
        (mul_nonneg (by norm_num : (0 : ℝ) ≤ 81) hV4)
      nlinarith
    have h₂ : T * (Q : ℝ) ^ (12 / 5 : ℝ) * (81 * V ^ (-4 : ℝ)) ≤
        648 * (T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
      have hm := mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_left hQ12 htail)
        (mul_nonneg (by norm_num : (0 : ℝ) ≤ 81) hV4)
      nlinarith
    nlinarith [h₁, h₂, mul_nonneg htail
      (mul_nonneg (Real.rpow_nonneg (Nat.cast_nonneg N) (12 / 5 : ℝ)) hV4)]
  calc
    (W.card : ℝ) ≤ 3 * (W'.card : ℝ) := hcardReal
    _ ≤ 3 * (C₀ * T ^ ε *
        ((Q : ℝ) ^ (18 / 5 : ℝ) * (V / 3) ^ (-4 : ℝ) +
          T * (Q : ℝ) ^ (12 / 5 : ℝ) * (V / 3) ^ (-4 : ℝ))) := by
      gcongr
    _ ≤ C * T ^ ε *
        ((N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)) := by
      dsimp only [C]
      have hcoef : 0 ≤ 3 * (C₀ * T ^ ε) := by positivity
      nlinarith [mul_nonneg hcoef (sub_nonneg.mpr hshape)]

set_option maxHeartbeats 2000000 in
/-- Guth--Maynard Theorem 1.1, with every source reduction and complementary
range discharged.  The proof uses the native Section 12 theorem in the
central range and the native Montgomery--Halasz--Huxley estimates elsewhere. -/
theorem guthMaynardLargeValues_native : GuthMaynardLargeValues := by
  intro ε hε
  let cutoff : GMSmoothCutoff := Classical.choice exists_gmSmoothCutoff
  obtain ⟨Ccrit, Tcrit, hCcrit, hTcrit, hCrit⟩ :=
    gm_source_large_values_critical cutoff ε hε
  let B : ℝ := 2 * Tcrit + 30
  obtain ⟨Clow, hClow, hLowBound⟩ := gm_classical_source_low ε B hε
  obtain ⟨Chigh, hChigh, hHighBound⟩ := gm_classical_source_high ε hε
  obtain ⟨Cnear, hCnear, hNearBound⟩ := gm_classical_source_near_height ε hε
  let C : ℝ := Ccrit + Clow + Chigh + Cnear
  refine ⟨C, 1, by dsimp only [C]; positivity, le_rfl, ?_⟩
  intro N V T b W hN hT hV hb hSep hBase hLarge
  have hTnonneg : 0 ≤ T := zero_le_one.trans hT
  have hTpow : 0 ≤ T ^ ε := Real.rpow_nonneg hTnonneg _
  let S : ℝ :=
    (N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
      (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
      T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)
  have hS : 0 ≤ S := by dsimp only [S]; positivity
  have hCcritC : Ccrit ≤ C := by dsimp only [C]; linarith
  have hClowC : Clow ≤ C := by dsimp only [C]; linarith
  have hChighC : Chigh ≤ C := by dsimp only [C]; linarith
  have hCnearC : Cnear ≤ C := by dsimp only [C]; linarith
  by_cases hNear : T ≤ 2 * (N : ℝ)
  · have hbound := hNearBound N V T b W hN hT hNear hV hb hSep hBase hLarge
    have hcoef : Cnear * T ^ ε ≤ C * T ^ ε :=
      mul_le_mul_of_nonneg_right hCnearC hTpow
    exact hbound.trans (by
      dsimp only [S] at hS ⊢
      exact mul_le_mul_of_nonneg_right hcoef hS)
  have hTwoNT : 2 * (N : ℝ) ≤ T := (le_of_not_ge hNear)
  have hNT : (N : ℝ) ≤ T := by
    have hn : (0 : ℝ) ≤ N := Nat.cast_nonneg N
    linarith
  by_cases hHigh : (1 / 2 : ℝ) * (N : ℝ) ^ (4 / 5 : ℝ) ≤ V
  · have hbound := hHighBound N V T b W hN hT hNT hV hHigh hb hSep hBase hLarge
    have hcoef : Chigh * T ^ ε ≤ C * T ^ ε :=
      mul_le_mul_of_nonneg_right hChighC hTpow
    exact hbound.trans (by
      dsimp only [S] at hS ⊢
      exact mul_le_mul_of_nonneg_right hcoef hS)
  have hNotHigh : V < (1 / 2 : ℝ) * (N : ℝ) ^ (4 / 5 : ℝ) := lt_of_not_ge hHigh
  by_cases hLow : V ≤ 6 * (N : ℝ) ^ (7 / 10 : ℝ)
  · have hBle : (6 : ℝ) ≤ B := by
      dsimp only [B]
      linarith [hTcrit]
    have hLowB : V ≤ B * (N : ℝ) ^ (7 / 10 : ℝ) := by
      exact hLow.trans (mul_le_mul_of_nonneg_right hBle
        (Real.rpow_nonneg (Nat.cast_nonneg N) _))
    have hbound := hLowBound N V T b W hN hT hNT hV hLowB hb hSep hBase hLarge
    have hcoef : Clow * T ^ ε ≤ C * T ^ ε :=
      mul_le_mul_of_nonneg_right hClowC hTpow
    exact hbound.trans (by
      dsimp only [S] at hS ⊢
      exact mul_le_mul_of_nonneg_right hcoef hS)
  have hCentralLow : 6 * (N : ℝ) ^ (7 / 10 : ℝ) ≤ V := le_of_not_ge hLow
  by_cases hN30 : 30 ≤ N
  · by_cases hNlarge : 2 * Tcrit ≤ (N : ℝ)
    · have hbound := hCrit N V T b W hN30 hNlarge hTwoNT hV hCentralLow
          hNotHigh.le hb hSep hBase hLarge
      have hcriticalShape :
          (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
            T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ) ≤ S := by
        dsimp only [S]
        have hfirst : 0 ≤ (N : ℝ) ^ 2 * V ^ (-2 : ℝ) := by positivity
        linarith
      have hbound' : (W.card : ℝ) ≤ Ccrit * T ^ ε * S :=
        hbound.trans (mul_le_mul_of_nonneg_left hcriticalShape
          (mul_nonneg hCcrit.le hTpow))
      have hcoef : Ccrit * T ^ ε ≤ C * T ^ ε :=
        mul_le_mul_of_nonneg_right hCcritC hTpow
      exact hbound'.trans (mul_le_mul_of_nonneg_right hcoef hS)
    · have hNltB : (N : ℝ) < B := by
        dsimp only [B]
        linarith [lt_of_not_ge hNlarge]
      have hNone : (1 : ℝ) ≤ N := by exact_mod_cast (Nat.one_le_iff_ne_zero.mpr hN.ne')
      have hpowLeN : (N : ℝ) ^ (4 / 5 : ℝ) ≤ (N : ℝ) := by
        simpa only [Real.rpow_one] using
          Real.rpow_le_rpow_of_exponent_le hNone (by norm_num : (4 / 5 : ℝ) ≤ 1)
      have hpowOne : 1 ≤ (N : ℝ) ^ (7 / 10 : ℝ) :=
        Real.one_le_rpow hNone (by norm_num)
      have hLowB : V ≤ B * (N : ℝ) ^ (7 / 10 : ℝ) := by
        have hBpos : 0 < B := by dsimp only [B]; linarith [hTcrit]
        nlinarith [mul_le_mul_of_nonneg_left hpowOne hBpos.le]
      have hbound := hLowBound N V T b W hN hT hNT hV hLowB hb hSep hBase hLarge
      have hcoef : Clow * T ^ ε ≤ C * T ^ ε :=
        mul_le_mul_of_nonneg_right hClowC hTpow
      exact hbound.trans (by
        dsimp only [S] at hS ⊢
        exact mul_le_mul_of_nonneg_right hcoef hS)
  · have hNltB : (N : ℝ) < B := by
      have hNlt : N < 30 := lt_of_not_ge hN30
      have hcast : (N : ℝ) < 30 := by exact_mod_cast hNlt
      dsimp only [B]
      linarith [hTcrit]
    have hNone : (1 : ℝ) ≤ N := by exact_mod_cast (Nat.one_le_iff_ne_zero.mpr hN.ne')
    have hpowLeN : (N : ℝ) ^ (4 / 5 : ℝ) ≤ (N : ℝ) := by
      simpa only [Real.rpow_one] using
        Real.rpow_le_rpow_of_exponent_le hNone (by norm_num : (4 / 5 : ℝ) ≤ 1)
    have hpowOne : 1 ≤ (N : ℝ) ^ (7 / 10 : ℝ) :=
      Real.one_le_rpow hNone (by norm_num)
    have hLowB : V ≤ B * (N : ℝ) ^ (7 / 10 : ℝ) := by
      have hBpos : 0 < B := by dsimp only [B]; linarith [hTcrit]
      nlinarith [mul_le_mul_of_nonneg_left hpowOne hBpos.le]
    have hbound := hLowBound N V T b W hN hT hNT hV hLowB hb hSep hBase hLarge
    have hcoef : Clow * T ^ ε ≤ C * T ^ ε :=
      mul_le_mul_of_nonneg_right hClowC hTpow
    exact hbound.trans (by
      dsimp only [S] at hS ⊢
      exact mul_le_mul_of_nonneg_right hcoef hS)


end Legendre.Density.GuthMaynard
