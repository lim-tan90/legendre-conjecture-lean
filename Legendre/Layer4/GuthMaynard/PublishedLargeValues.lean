/-
Copyright (c) 2026 S. McColm.
Released under the MIT-0 license; retained verbatim in
licenses/smccolm-Lean-MIT-0.txt.

Adapted for Lean 4.35.0 from smccolm/Lean,
commit 4c8fb7f7816508825089230e3730b69165e5e303,
Riemann Zeta/9. Zero Density, Large Values and Prime Transfer/
71 Guth-Maynard, 2026/PublicationContract.lean (Theorem 1.1 only)
See docs/smccolm-guth-provenance.md for changes and reused dependencies.
-/
module
public import Legendre.Layer4.GuthMaynard.LargeValueAssembly

@[expose] public section
open Complex Finset Set
namespace Legendre.Density.GuthMaynard

/-- Guth--Maynard Theorem 1.1 with the literal closed sum `N <= n <= 2N`,
positive phase, one-separated ordinates in `[0,T]`, and the coefficient bound
restricted to the actual support of the polynomial. -/
def PublishedGuthMaynardLargeValues : Prop :=
  ∀ (epsilon : ℝ), epsilon > 0 →
    ∃ (C T₀ : ℝ), 0 < C ∧ 1 ≤ T₀ ∧
    ∀ (N : ℕ) (V T : ℝ) (b : ℕ → ℂ) (W : Finset ℝ),
      0 < N → T₀ ≤ T → 0 < V →
      (∀ n ∈ publishedDyadicInterval N, ‖b n‖ ≤ 1) →
      IsSeparated 1 W →
      InBaseInterval T W →
      (∀ t ∈ W, V ≤ ‖publishedSourceDirichletPoly N b t‖) →
      (W.card : ℝ) ≤ C * T ^ epsilon *
        ((N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
          (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
          T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ))

private noncomputable def restrictDyadicCoeffs
    (N : ℕ) (b : ℕ → ℂ) (n : ℕ) : ℂ :=
  if n ∈ dyadicInterval N then b n else 0

private theorem norm_restrictDyadicCoeffs_le_one
    {N : ℕ} {b : ℕ → ℂ}
    (hb : ∀ n ∈ publishedDyadicInterval N, ‖b n‖ ≤ 1) (n : ℕ) :
    ‖restrictDyadicCoeffs N b n‖ ≤ 1 := by
  by_cases hn : n ∈ dyadicInterval N
  · rw [restrictDyadicCoeffs, ite_eq_left hn]
    apply hb n
    rw [dyadicInterval, Finset.mem_Ioc] at hn
    rw [publishedDyadicInterval, Finset.mem_Icc]
    exact ⟨hn.1.le, hn.2⟩
  · simp [restrictDyadicCoeffs, hn]

private theorem sourceDirichletPoly_restrictDyadicCoeffs
    (N : ℕ) (b : ℕ → ℂ) (t : ℝ) :
    sourceDirichletPoly N (restrictDyadicCoeffs N b) t =
      sourceDirichletPoly N b t := by
  unfold sourceDirichletPoly
  apply Finset.sum_congr rfl
  intro n hn
  simp [restrictDyadicCoeffs, hn]

/-- Native realization of the literal publication-facing Theorem 1.1. -/
theorem guthMaynardLargeValues_published_native :
    PublishedGuthMaynardLargeValues := by
  intro epsilon hepsilon
  obtain ⟨C₀, T₀, hC₀, hT₀, hLarge⟩ :=
    guthMaynardLargeValues_native epsilon hepsilon
  refine ⟨64 * (C₀ + 1), T₀, by positivity, hT₀, ?_⟩
  intro N V T b W hN hT hV hb hSeparated hInterval hValues
  have hTOne : 1 ≤ T := hT₀.trans hT
  have hNOne : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hTPow : 1 ≤ T ^ epsilon := Real.one_le_rpow hTOne hepsilon.le
  have hNPow : 1 ≤ (N : ℝ) ^ (12 / 5 : ℝ) := by
    exact Real.one_le_rpow hNOne (by norm_num)
  let B : ℝ :=
    (N : ℝ) ^ 2 * V ^ (-2 : ℝ) +
      (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) +
      T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ)
  have hBNonneg : 0 ≤ B := by
    dsimp [B]
    positivity
  by_cases hVTwo : V ≤ 2
  · have hVPower : (2 : ℝ) ^ (-4 : ℝ) ≤ V ^ (-4 : ℝ) :=
      Real.rpow_le_rpow_of_nonpos hV hVTwo (by norm_num)
    have hVPowerConcrete : (1 : ℝ) / 16 ≤ V ^ (-4 : ℝ) := by
      norm_num at hVPower ⊢
      exact hVPower
    have hTTerm : T / 16 ≤
        T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ) := by
      have hTNonneg : 0 ≤ T := by linarith
      have hTN : T ≤ T * (N : ℝ) ^ (12 / 5 : ℝ) := by
        nlinarith
      have hTNNonneg : 0 ≤ T * (N : ℝ) ^ (12 / 5 : ℝ) := by positivity
      have hInv := mul_le_mul_of_nonneg_left hVPowerConcrete hTNNonneg
      nlinarith
    have hCard : (W.card : ℝ) ≤ 2 * T :=
      gmSeparated_card_le_two_height hTOne hSeparated hInterval
    have hBLower : T / 16 ≤ B := by
      dsimp [B]
      have hFirst : 0 ≤ (N : ℝ) ^ 2 * V ^ (-2 : ℝ) := by positivity
      have hSecond : 0 ≤ (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) := by
        positivity
      linarith
    calc
      (W.card : ℝ) ≤ 2 * T := hCard
      _ ≤ 32 * B := by nlinarith
      _ ≤ 64 * (C₀ + 1) * T ^ epsilon * B := by
        have hFactor : 32 ≤ 64 * (C₀ + 1) * T ^ epsilon := by
          nlinarith [hC₀, hTPow]
        exact mul_le_mul_of_nonneg_right hFactor hBNonneg
  · have hVTwo : 2 < V := lt_of_not_ge hVTwo
    have hValuesOpen : ∀ t ∈ W,
        V / 2 ≤ ‖sourceDirichletPoly N (restrictDyadicCoeffs N b) t‖ := by
      intro t ht
      rw [sourceDirichletPoly_restrictDyadicCoeffs]
      have hClosed := hValues t ht
      rw [publishedSourceDirichletPoly_eq_left_add] at hClosed
      have hLeft : ‖b N * (N : ℂ) ^ (t * I)‖ ≤ 1 := by
        rw [norm_mul]
        have hNMem : N ∈ publishedDyadicInterval N := by
          rw [publishedDyadicInterval, Finset.mem_Icc]
          omega
        have hbN := hb N hNMem
        have hNRealPos : (0 : ℝ) < N := by exact_mod_cast hN
        change ‖b N‖ * ‖((N : ℝ) : ℂ) ^ (t * I)‖ ≤ 1
        rw [Complex.norm_cpow_eq_rpow_re_of_pos hNRealPos]
        simp only [mul_re, ofReal_re, I_re, ofReal_im, I_im, mul_zero,
          sub_zero, Real.rpow_zero, mul_one]
        exact hbN
      have hTriangle := norm_add_le
        (b N * (N : ℂ) ^ (t * I)) (sourceDirichletPoly N b t)
      linarith
    have hApplied := hLarge N (V / 2) T (restrictDyadicCoeffs N b) W
      hN hT (by positivity) (norm_restrictDyadicCoeffs_le_one hb)
      hSeparated hInterval hValuesOpen
    have hHalf2 : (V / 2) ^ (-2 : ℝ) = 4 * V ^ (-2 : ℝ) := by
      rw [Real.div_rpow (le_of_lt hV) (by norm_num : (0 : ℝ) ≤ 2)]
      norm_num [Real.rpow_neg (le_of_lt hV)]
      ring
    have hHalf4 : (V / 2) ^ (-4 : ℝ) = 16 * V ^ (-4 : ℝ) := by
      rw [Real.div_rpow (le_of_lt hV) (by norm_num : (0 : ℝ) ≤ 2)]
      norm_num [Real.rpow_neg (le_of_lt hV)]
      ring
    rw [hHalf2, hHalf4] at hApplied
    have hScaled :
        (N : ℝ) ^ 2 * (4 * V ^ (-2 : ℝ)) +
            (N : ℝ) ^ (18 / 5 : ℝ) * (16 * V ^ (-4 : ℝ)) +
            T * (N : ℝ) ^ (12 / 5 : ℝ) * (16 * V ^ (-4 : ℝ)) ≤
          16 * B := by
      dsimp [B]
      have h1 : 0 ≤ (N : ℝ) ^ 2 * V ^ (-2 : ℝ) := by positivity
      have h2 : 0 ≤ (N : ℝ) ^ (18 / 5 : ℝ) * V ^ (-4 : ℝ) := by positivity
      have h3 : 0 ≤ T * (N : ℝ) ^ (12 / 5 : ℝ) * V ^ (-4 : ℝ) := by
        positivity
      nlinarith
    calc
      (W.card : ℝ) ≤ C₀ * T ^ epsilon *
          ((N : ℝ) ^ 2 * (4 * V ^ (-2 : ℝ)) +
            (N : ℝ) ^ (18 / 5 : ℝ) * (16 * V ^ (-4 : ℝ)) +
            T * (N : ℝ) ^ (12 / 5 : ℝ) * (16 * V ^ (-4 : ℝ))) := hApplied
      _ ≤ C₀ * T ^ epsilon * (16 * B) := by
        exact mul_le_mul_of_nonneg_left hScaled
          (mul_nonneg hC₀.le (Real.rpow_nonneg (by linarith) _))
      _ ≤ 64 * (C₀ + 1) * T ^ epsilon * B := by
        have hTPowNonneg := Real.rpow_nonneg (by linarith : 0 ≤ T) epsilon
        have hCoeff : 16 * C₀ ≤ 64 * (C₀ + 1) := by nlinarith
        calc
          C₀ * T ^ epsilon * (16 * B) =
              (16 * C₀) * (T ^ epsilon * B) := by ring
          _ ≤ (64 * (C₀ + 1)) * (T ^ epsilon * B) :=
            mul_le_mul_of_nonneg_right hCoeff (mul_nonneg hTPowNonneg hBNonneg)
          _ = 64 * (C₀ + 1) * T ^ epsilon * B := by ring

end Legendre.Density.GuthMaynard
