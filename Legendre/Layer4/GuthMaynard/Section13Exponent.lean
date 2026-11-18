/-
Copyright (c) 2026 S. McColm.
Released under the MIT-0 license; retained verbatim in
licenses/smccolm-Lean-MIT-0.txt.

Adapted for Lean 4.35.0 from smccolm/Lean,
commit 4c8fb7f7816508825089230e3730b69165e5e303,
Riemann Zeta/9. Zero Density, Large Values and Prime Transfer/
71 Guth-Maynard, 2026/GuthMaynard/ExponentArithmetic.lean and GuthMaynard/CentralTypeI.lean.
The compact detector uses the lower scale T^(1/200). The bounded power
selection is adjusted to k <= 201, and the native count allows height 3*T.
See docs/smccolm-guth-provenance.md.
-/
module
public import Legendre.Layer4.GuthMaynard.PublishedLargeValues

@[expose] public section
namespace Legendre.Density.GuthMaynard

lemma denom_pos (σ : ℝ) (hσ : 7/10 ≤ σ) : 0 < 6 + 10 * σ := by linarith

/-- The `alpha` definition used by the source-facing construction in `ExponentArithmetic`. -/
noncomputable def alpha (σ : ℝ) : ℝ := 15 * (1 - σ) / ((3 + 5 * σ) * (18/5 - 4 * σ))
/-- The `final_exponent` definition used by the source-facing construction in `ExponentArithmetic`. -/
-- Source-equation compatibility keeps this established public name.
@[nolint defsWithUnderscore]
noncomputable def final_exponent (σ : ℝ) : ℝ := 15 * (1 - σ) / (3 + 5 * σ)

/-- Complete equation (13.1) scale selection. The lower detector scale gives
the uniform numerical bound on `k`; the final hypothesis is the sharp upper
bound needed in the large-scale `k = 2` branch. -/
theorem k_selection (N T σ : ℝ)
    (hN : 1 < N) (hT : 1 < T)
    (hσLower : 7 / 10 ≤ σ)
    (hScaleLower : T ^ (1 / 200 : ℝ) ≤ N)
    (hScaleUpper : N ^ (2 : ℝ) ≤ T ^ (15 / (6 + 10 * σ))) :
    ∃ k : ℕ, 2 ≤ k ∧ k ≤ 201 ∧
      T ^ (10 / (6 + 10 * σ)) ≤ N ^ (k : ℝ) ∧
      N ^ (k : ℝ) ≤ T ^ (15 / (6 + 10 * σ)) := by
  let d := 6 + 10 * σ
  have hd : 0 < d := denom_pos σ hσLower
  have hdThirteen : 13 ≤ d := by
    dsimp [d]
    linarith
  have hTpos : 0 < T := by linarith
  have hNpos : 0 < N := by linarith
  have hlogN : 0 < Real.log N := Real.log_pos hN
  have hlogT : 0 < Real.log T := Real.log_pos hT
  have hLowerLog : (1 / 200 : ℝ) * Real.log T ≤ Real.log N := by
    have hLog := (Real.log_le_log_iff
      (Real.rpow_pos_of_pos hTpos _) hNpos).2 hScaleLower
    rw [Real.log_rpow hTpos] at hLog
    exact hLog
  by_cases hSmall : N ≤ T ^ (5 / d)
  · have hSmallLog : Real.log N ≤ (5 / d) * Real.log T := by
      have hLog := (Real.log_le_log_iff hNpos
        (Real.rpow_pos_of_pos hTpos _)).2 hSmall
      simpa [Real.log_rpow hTpos] using hLog
    let B := (10 / d) * Real.log T / Real.log N
    have hBNonneg : 0 ≤ B := by
      dsimp [B]
      positivity
    have hBTwo : (2 : ℝ) ≤ B := by
      rw [le_div_iff₀ hlogN]
      calc
        2 * Real.log N ≤ 2 * ((5 / d) * Real.log T) := by gcongr
        _ = (10 / d) * Real.log T := by ring
    have hLogRatio : Real.log T / Real.log N ≤ 200 := by
      rw [div_le_iff₀ hlogN]
      linarith
    have hTenDiv : 0 ≤ 10 / d ∧ 10 / d ≤ 1 := by
      constructor
      · positivity
      · exact (div_le_one hd).2 (by linarith)
    have hBTwoHundred : B ≤ 200 := by
      dsimp [B]
      rw [mul_div_assoc]
      calc
        (10 / d) * (Real.log T / Real.log N)
            ≤ 1 * (Real.log T / Real.log N) := by
              gcongr
              exact hTenDiv.2
        _ ≤ 200 := by simpa using hLogRatio
    let k := ⌈B⌉₊
    have hBLeK : B ≤ (k : ℝ) := Nat.le_ceil B
    have hkLt : (k : ℝ) < B + 1 := Nat.ceil_lt_add_one hBNonneg
    have hkLower : 2 ≤ k := by
      exact_mod_cast hBTwo.trans hBLeK
    have hkUpper : k ≤ 201 := by
      have hkReal : (k : ℝ) < 201 := by linarith
      exact_mod_cast hkReal.le
    have hBmul : B * Real.log N = (10 / d) * Real.log T := by
      dsimp [B]
      field_simp
    have hLowerPower : T ^ (10 / d) ≤ N ^ (k : ℝ) := by
      apply (Real.log_le_log_iff
        (Real.rpow_pos_of_pos hTpos _) (Real.rpow_pos_of_pos hNpos _)).1
      rw [Real.log_rpow hTpos, Real.log_rpow hNpos]
      calc
        (10 / d) * Real.log T = B * Real.log N := hBmul.symm
        _ ≤ (k : ℝ) * Real.log N := by gcongr
    have hUpperLog : (k : ℝ) * Real.log N ≤ (15 / d) * Real.log T := by
      have hkMul : (k : ℝ) * Real.log N <
          (B + 1) * Real.log N := by gcongr
      rw [add_mul, hBmul] at hkMul
      calc
        (k : ℝ) * Real.log N ≤
            (10 / d) * Real.log T + Real.log N := by
              simpa only [one_mul] using hkMul.le
        _ ≤ (10 / d) * Real.log T + (5 / d) * Real.log T := by gcongr
        _ = (15 / d) * Real.log T := by ring
    have hUpperPower : N ^ (k : ℝ) ≤ T ^ (15 / d) := by
      apply (Real.log_le_log_iff
        (Real.rpow_pos_of_pos hNpos _) (Real.rpow_pos_of_pos hTpos _)).1
      simpa [Real.log_rpow hNpos, Real.log_rpow hTpos] using hUpperLog
    exact ⟨k, hkLower, hkUpper, hLowerPower, hUpperPower⟩
  · have hLarge : T ^ (5 / d) < N := lt_of_not_ge hSmall
    have hLowerPower : T ^ (10 / d) ≤ N ^ (2 : ℝ) := by
      have hSquare := Real.rpow_lt_rpow (Real.rpow_nonneg (le_of_lt hTpos) _)
        hLarge (by norm_num : (0 : ℝ) < 2)
      have hPowerIdentity : (T ^ (5 / d)) ^ (2 : ℝ) = T ^ (10 / d) := by
        rw [← Real.rpow_mul (le_of_lt hTpos)]
        congr 1
        ring
      rw [hPowerIdentity] at hSquare
      exact hSquare.le
    exact ⟨2, by norm_num, by norm_num, hLowerPower, hScaleUpper⟩

lemma central_denominators_pos (σ : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5) :
    0 < 3 + 5 * σ ∧ 0 < 18 / 5 - 4 * σ := by
  constructor <;> linarith

lemma alpha_pos (σ : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5) :
    0 < alpha σ := by
  rcases central_denominators_pos σ hσLower hσUpper with ⟨hFirst, hSecond⟩
  unfold alpha
  exact div_pos (mul_pos (by norm_num) (by linarith)) (mul_pos hFirst hSecond)

lemma final_exponent_nonneg (σ : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5) :
    0 ≤ final_exponent σ := by
  rcases central_denominators_pos σ hσLower hσUpper with ⟨hDenom, _⟩
  unfold final_exponent
  exact div_nonneg (mul_nonneg (by norm_num) (by linarith)) hDenom.le

/-- The first large-values term uses the upper edge of (13.1). -/
lemma first_term_exponent_identity (σ : ℝ)
    (hσLower : 7 / 10 ≤ σ) :
    (15 / (6 + 10 * σ)) * (2 - 2 * σ) = final_exponent σ := by
  have hDenom : 0 < 3 + 5 * σ := by linarith
  unfold final_exponent
  field_simp
  ring

/-- The middle large-values term defines the splitting exponent `alpha`. -/
lemma second_term_exponent_identity (σ : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5) :
    alpha σ * (18 / 5 - 4 * σ) = final_exponent σ := by
  rcases central_denominators_pos σ hσLower hσUpper with ⟨hFirst, hSecond⟩
  have hSecondNe : 18 - σ * 5 * 4 ≠ 0 := by linarith
  unfold alpha final_exponent
  field_simp [hFirst.ne', hSecond.ne', hSecondNe]

/-- The third large-values term uses the lower edge of (13.1). -/
lemma third_term_exponent_identity (σ : ℝ)
    (hσLower : 7 / 10 ≤ σ) :
    1 + (10 / (6 + 10 * σ)) * (12 / 5 - 4 * σ) =
      final_exponent σ := by
  have hDenom : 0 < 3 + 5 * σ := by linarith
  unfold final_exponent
  field_simp
  ring

/-- Equation (13.2), the exponent comparison in the mean-value branch. -/
lemma mean_value_exponent_le (σ : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5) :
    1 + alpha σ * (1 - 2 * σ) ≤ final_exponent σ := by
  rcases central_denominators_pos σ hσLower hσUpper with ⟨hFirst, hSecond⟩
  unfold alpha final_exponent
  rw [le_div_iff₀ hFirst]
  have hRewrite :
      (1 + 15 * (1 - σ) / ((3 + 5 * σ) * (18 / 5 - 4 * σ)) *
          (1 - 2 * σ)) * (3 + 5 * σ) =
        (3 + 5 * σ) + 15 * (1 - σ) * (1 - 2 * σ) /
          (18 / 5 - 4 * σ) := by
    field_simp [hFirst.ne', hSecond.ne']
  rw [hRewrite]
  have hFrac :
      15 * (1 - σ) * (1 - 2 * σ) / (18 / 5 - 4 * σ) ≤
        15 * (1 - σ) - (3 + 5 * σ) := by
    rw [div_le_iff₀ hSecond]
    nlinarith [sq_nonneg (σ - 3 / 4)]
  linarith

/-- F-09, first term. -/
theorem large_values_first_term_le (σ T Q : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5)
    (hT : 1 ≤ T) (hQ : 0 ≤ Q)
    (hUpper : Q ≤ T ^ (15 / (6 + 10 * σ))) :
    Q ^ (2 - 2 * σ) ≤ T ^ final_exponent σ := by
  have hExponent : 0 ≤ 2 - 2 * σ := by linarith
  calc
    Q ^ (2 - 2 * σ) ≤
        (T ^ (15 / (6 + 10 * σ))) ^ (2 - 2 * σ) :=
      Real.rpow_le_rpow hQ hUpper hExponent
    _ = T ^ ((15 / (6 + 10 * σ)) * (2 - 2 * σ)) := by
      rw [← Real.rpow_mul (by linarith : 0 ≤ T)]
    _ = T ^ final_exponent σ := by rw [first_term_exponent_identity σ hσLower]

/-- F-09, middle term in the small-`Q` branch. -/
theorem large_values_second_term_le (σ T Q : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5)
    (hT : 1 ≤ T) (hQ : 0 ≤ Q)
    (hUpper : Q ≤ T ^ alpha σ) :
    Q ^ (18 / 5 - 4 * σ) ≤ T ^ final_exponent σ := by
  have hExponent : 0 ≤ 18 / 5 - 4 * σ :=
    (central_denominators_pos σ hσLower hσUpper).2.le
  calc
    Q ^ (18 / 5 - 4 * σ) ≤ (T ^ alpha σ) ^ (18 / 5 - 4 * σ) :=
      Real.rpow_le_rpow hQ hUpper hExponent
    _ = T ^ (alpha σ * (18 / 5 - 4 * σ)) := by
      rw [← Real.rpow_mul (by linarith : 0 ≤ T)]
    _ = T ^ final_exponent σ := by
      rw [second_term_exponent_identity σ hσLower hσUpper]

/-- F-09, height term using the lower edge of equation (13.1). -/
theorem large_values_third_term_le (σ T Q : ℝ)
    (hσLower : 7 / 10 ≤ σ)
    (hT : 1 ≤ T)
    (hLower : T ^ (10 / (6 + 10 * σ)) ≤ Q) :
    T * Q ^ (12 / 5 - 4 * σ) ≤ T ^ final_exponent σ := by
  have hTpos : 0 < T := lt_of_lt_of_le zero_lt_one hT
  have hExponent : 12 / 5 - 4 * σ ≤ 0 := by linarith
  have hPower : Q ^ (12 / 5 - 4 * σ) ≤
      (T ^ (10 / (6 + 10 * σ))) ^ (12 / 5 - 4 * σ) :=
    Real.rpow_le_rpow_of_nonpos (Real.rpow_pos_of_pos hTpos _) hLower hExponent
  calc
    T * Q ^ (12 / 5 - 4 * σ) ≤
        T * (T ^ (10 / (6 + 10 * σ))) ^ (12 / 5 - 4 * σ) := by
      gcongr
    _ = T ^ (1 + (10 / (6 + 10 * σ)) * (12 / 5 - 4 * σ)) := by
      rw [← Real.rpow_mul hTpos.le]
      nth_rewrite 1 [← Real.rpow_one T]
      exact (Real.rpow_add hTpos _ _).symm
    _ = T ^ final_exponent σ := by rw [third_term_exponent_identity σ hσLower]

/-- F-10, the height term in the mean-value branch. -/
theorem mean_value_height_term_le (σ T Q : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5)
    (hT : 1 ≤ T) (hLower : T ^ alpha σ ≤ Q) :
    T * Q ^ (1 - 2 * σ) ≤ T ^ final_exponent σ := by
  have hTpos : 0 < T := lt_of_lt_of_le zero_lt_one hT
  have hExponent : 1 - 2 * σ ≤ 0 := by linarith
  have hPower : Q ^ (1 - 2 * σ) ≤ (T ^ alpha σ) ^ (1 - 2 * σ) :=
    Real.rpow_le_rpow_of_nonpos (Real.rpow_pos_of_pos hTpos _) hLower hExponent
  calc
    T * Q ^ (1 - 2 * σ) ≤ T * (T ^ alpha σ) ^ (1 - 2 * σ) := by gcongr
    _ = T ^ (1 + alpha σ * (1 - 2 * σ)) := by
      rw [← Real.rpow_mul hTpos.le]
      nth_rewrite 1 [← Real.rpow_one T]
      exact (Real.rpow_add hTpos _ _).symm
    _ ≤ T ^ final_exponent σ :=
      Real.rpow_le_rpow_of_exponent_le hT
        (mean_value_exponent_le σ hσLower hσUpper)

/-- All three source large-values terms have the target exponent in the
small-`Q` branch. -/
theorem large_values_terms_le (σ T Q : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5)
    (hT : 1 ≤ T) (hQ : 0 ≤ Q)
    (hEquationLower : T ^ (10 / (6 + 10 * σ)) ≤ Q)
    (hEquationUpper : Q ≤ T ^ (15 / (6 + 10 * σ)))
    (hSmall : Q ≤ T ^ alpha σ) :
    Q ^ (2 - 2 * σ) + Q ^ (18 / 5 - 4 * σ) +
        T * Q ^ (12 / 5 - 4 * σ) ≤
      3 * T ^ final_exponent σ := by
  have hFirst := large_values_first_term_le σ T Q hσLower hσUpper hT hQ hEquationUpper
  have hSecond := large_values_second_term_le σ T Q hσLower hσUpper hT hQ hSmall
  have hThird := large_values_third_term_le σ T Q hσLower hT hEquationLower
  linarith

/-- Both source mean-value terms have the target exponent in the large-`Q`
branch. -/
theorem mean_value_terms_le (σ T Q : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5)
    (hT : 1 ≤ T) (hQ : 0 ≤ Q)
    (hEquationUpper : Q ≤ T ^ (15 / (6 + 10 * σ)))
    (hLarge : T ^ alpha σ ≤ Q) :
    Q ^ (2 - 2 * σ) + T * Q ^ (1 - 2 * σ) ≤
      2 * T ^ final_exponent σ := by
  have hFirst := large_values_first_term_le σ T Q hσLower hσUpper hT hQ hEquationUpper
  have hSecond := mean_value_height_term_le σ T Q hσLower hσUpper hT hLarge
  linarith

/-- The residual Type-II exponent is no larger than the central target. -/
lemma residual_exponent_le_final (σ : ℝ)
    (hσLower : 7 / 10 ≤ σ) (hσUpper : σ ≤ 4 / 5) :
    2 - 2 * σ ≤ final_exponent σ := by
  have hDenom : 0 < 3 + 5 * σ := (central_denominators_pos σ hσLower hσUpper).1
  unfold final_exponent
  rw [le_div_iff₀ hDenom]
  nlinarith [mul_nonneg (sub_nonneg.mpr hσUpper) (by linarith : 0 ≤ 9 / 10 - σ)]

/-- Replacing a selected block length `M ≤ 2^201 Q` costs only an absolute
factor in each of the three Guth--Maynard terms. -/
theorem selected_block_large_value_terms_le
    (σ T Q M : ℝ) (hQ : 0 < Q) (hT : 0 ≤ T)
    (hM : 0 ≤ M) (hMUpper : M ≤ (2 : ℝ) ^ 201 * Q) :
    M ^ (2 : ℕ) * Q ^ (-2 * σ) +
        M ^ (18 / 5 : ℝ) * Q ^ (-4 * σ) +
        T * M ^ (12 / 5 : ℝ) * Q ^ (-4 * σ) ≤
      ((2 : ℝ) ^ 201) ^ (4 : ℕ) *
        (Q ^ (2 - 2 * σ) + Q ^ (18 / 5 - 4 * σ) +
          T * Q ^ (12 / 5 - 4 * σ)) := by
  let K : ℝ := (2 : ℝ) ^ 201
  have hKOne : 1 ≤ K := by dsimp [K]; norm_num
  have hKPos : 0 < K := lt_of_lt_of_le zero_lt_one hKOne
  have hTwo : (0 : ℝ) ≤ 2 := by norm_num
  have hEighteen : (0 : ℝ) ≤ 18 / 5 := by norm_num
  have hTwelve : (0 : ℝ) ≤ 12 / 5 := by norm_num
  have hM2 : M ^ (2 : ℕ) ≤ K ^ (4 : ℕ) * Q ^ (2 : ℝ) := by
    calc
      M ^ (2 : ℕ) = M ^ (2 : ℝ) := by rw [Real.rpow_two]
      _ ≤ (K * Q) ^ (2 : ℝ) := Real.rpow_le_rpow hM hMUpper hTwo
      _ = K ^ (2 : ℝ) * Q ^ (2 : ℝ) := Real.mul_rpow hKPos.le hQ.le
      _ ≤ K ^ (4 : ℕ) * Q ^ (2 : ℝ) := by
        gcongr
        rw [Real.rpow_two]
        exact pow_le_pow_right₀ hKOne (by norm_num)
  have hM18 : M ^ (18 / 5 : ℝ) ≤ K ^ (4 : ℕ) * Q ^ (18 / 5 : ℝ) := by
    calc
      M ^ (18 / 5 : ℝ) ≤ (K * Q) ^ (18 / 5 : ℝ) :=
        Real.rpow_le_rpow hM hMUpper hEighteen
      _ = K ^ (18 / 5 : ℝ) * Q ^ (18 / 5 : ℝ) := Real.mul_rpow hKPos.le hQ.le
      _ ≤ K ^ (4 : ℕ) * Q ^ (18 / 5 : ℝ) := by
        gcongr
        rw [← Real.rpow_natCast]
        exact Real.rpow_le_rpow_of_exponent_le hKOne (by norm_num)
  have hM12 : M ^ (12 / 5 : ℝ) ≤ K ^ (4 : ℕ) * Q ^ (12 / 5 : ℝ) := by
    calc
      M ^ (12 / 5 : ℝ) ≤ (K * Q) ^ (12 / 5 : ℝ) :=
        Real.rpow_le_rpow hM hMUpper hTwelve
      _ = K ^ (12 / 5 : ℝ) * Q ^ (12 / 5 : ℝ) := Real.mul_rpow hKPos.le hQ.le
      _ ≤ K ^ (4 : ℕ) * Q ^ (12 / 5 : ℝ) := by
        gcongr
        rw [← Real.rpow_natCast]
        exact Real.rpow_le_rpow_of_exponent_le hKOne (by norm_num)
  dsimp [K] at hM2 hM18 hM12 hKOne hKPos ⊢
  have hCombineTwo : Q ^ (2 : ℝ) * Q ^ (-2 * σ) = Q ^ (2 - 2 * σ) := by
    rw [← Real.rpow_add hQ]
    congr 1
    ring
  have hCombineEighteen : Q ^ (18 / 5 : ℝ) * Q ^ (-4 * σ) =
      Q ^ (18 / 5 - 4 * σ) := by
    rw [← Real.rpow_add hQ]
    congr 1
    ring
  have hCombineTwelve : Q ^ (12 / 5 : ℝ) * Q ^ (-4 * σ) =
      Q ^ (12 / 5 - 4 * σ) := by
    rw [← Real.rpow_add hQ]
    congr 1
    ring
  calc
    M ^ (2 : ℕ) * Q ^ (-2 * σ) +
          M ^ (18 / 5 : ℝ) * Q ^ (-4 * σ) +
          T * M ^ (12 / 5 : ℝ) * Q ^ (-4 * σ)
        ≤ ((2 : ℝ) ^ 201) ^ (4 : ℕ) * Q ^ (2 : ℝ) * Q ^ (-2 * σ) +
          ((2 : ℝ) ^ 201) ^ (4 : ℕ) * Q ^ (18 / 5 : ℝ) * Q ^ (-4 * σ) +
          T * (((2 : ℝ) ^ 201) ^ (4 : ℕ) * Q ^ (12 / 5 : ℝ)) *
            Q ^ (-4 * σ) := by gcongr
    _ = ((2 : ℝ) ^ 201) ^ (4 : ℕ) * (Q ^ (2 : ℝ) * Q ^ (-2 * σ)) +
        ((2 : ℝ) ^ 201) ^ (4 : ℕ) * (Q ^ (18 / 5 : ℝ) * Q ^ (-4 * σ)) +
        T * ((2 : ℝ) ^ 201) ^ (4 : ℕ) *
          (Q ^ (12 / 5 : ℝ) * Q ^ (-4 * σ)) := by ring
    _ = ((2 : ℝ) ^ 201) ^ (4 : ℕ) *
        (Q ^ (2 - 2 * σ) + Q ^ (18 / 5 - 4 * σ) +
          T * Q ^ (12 / 5 - 4 * σ)) := by
      rw [hCombineTwo, hCombineEighteen, hCombineTwelve]
      ring

theorem selected_block_mean_value_terms_le
    (σ T Q M : ℝ) (hQ : 0 < Q) (hT : 0 ≤ T)
    (hM : 0 ≤ M) (hMUpper : M ≤ (2 : ℝ) ^ 201 * Q) :
    (3 * T + M) * M * Q ^ (-2 * σ) ≤
      3 * ((2 : ℝ) ^ 201) ^ (2 : ℕ) *
        (Q ^ (2 - 2 * σ) + T * Q ^ (1 - 2 * σ)) := by
  let K : ℝ := (2 : ℝ) ^ 201
  have hKOne : 1 ≤ K := by dsimp [K]; norm_num
  have hKPos : 0 < K := lt_of_lt_of_le zero_lt_one hKOne
  have hMOne : M ≤ K * Q := hMUpper
  have hM2 : M ^ (2 : ℕ) ≤ K ^ (2 : ℕ) * Q ^ (2 : ℝ) := by
    calc
      M ^ (2 : ℕ) = M ^ (2 : ℝ) := by rw [Real.rpow_two]
      _ ≤ (K * Q) ^ (2 : ℝ) := Real.rpow_le_rpow hM hMOne (by norm_num)
      _ = K ^ (2 : ℝ) * Q ^ (2 : ℝ) := Real.mul_rpow hKPos.le hQ.le
      _ = K ^ (2 : ℕ) * Q ^ (2 : ℝ) := by rw [Real.rpow_two]
  have hKLeK2 : K ≤ K ^ (2 : ℕ) := by
    simpa only [pow_one] using pow_le_pow_right₀ hKOne (by norm_num : 1 ≤ 2)
  have hMLinear : M ≤ K ^ (2 : ℕ) * Q := hMOne.trans (by gcongr)
  have hCombineTwo : Q ^ (2 : ℝ) * Q ^ (-2 * σ) = Q ^ (2 - 2 * σ) := by
    rw [← Real.rpow_add hQ]
    congr 1
    ring
  have hCombineOne : Q * Q ^ (-2 * σ) = Q ^ (1 - 2 * σ) := by
    nth_rewrite 1 [← Real.rpow_one Q]
    rw [← Real.rpow_add hQ]
    congr 1
    ring
  dsimp [K] at hM2 hMLinear hKOne hKPos ⊢
  calc
    (3 * T + M) * M * Q ^ (-2 * σ) =
        (3 * T * M + M ^ (2 : ℕ)) * Q ^ (-2 * σ) := by ring
    _ ≤ (3 * T * (((2 : ℝ) ^ 201) ^ (2 : ℕ) * Q) +
        ((2 : ℝ) ^ 201) ^ (2 : ℕ) * Q ^ (2 : ℝ)) * Q ^ (-2 * σ) := by
      gcongr
    _ = ((2 : ℝ) ^ 201) ^ (2 : ℕ) * (Q ^ (2 : ℝ) * Q ^ (-2 * σ)) +
        3 * T * ((2 : ℝ) ^ 201) ^ (2 : ℕ) *
          (Q * Q ^ (-2 * σ)) := by ring
    _ = ((2 : ℝ) ^ 201) ^ (2 : ℕ) * Q ^ (2 - 2 * σ) +
        3 * T * ((2 : ℝ) ^ 201) ^ (2 : ℕ) * Q ^ (1 - 2 * σ) := by
      rw [hCombineTwo, hCombineOne]
    _ ≤ 3 * ((2 : ℝ) ^ 201) ^ (2 : ℕ) *
        (Q ^ (2 - 2 * σ) + T * Q ^ (1 - 2 * σ)) := by
      have hFirst : 0 ≤ ((2 : ℝ) ^ 201) ^ (2 : ℕ) * Q ^ (2 - 2 * σ) := by
        positivity
      nlinarith


/-- The Section 13 count for a selected, normalized dyadic block. The
normalization loss is explicit and the constant is uniform across the
central real-part interval. -/
theorem gm_section13_selected_block_count (ε : ℝ) (hε : 0 < ε) :
    ∃ C T₀ : ℝ, 0 < C ∧ 1 ≤ T₀ ∧
      ∀ (σ T Q D : ℝ) (M : ℕ) (W : Finset ℝ) (b : ℕ → ℂ),
        7/10 ≤ σ → σ ≤ 4/5 → T₀ ≤ T → 0 < M → 1 ≤ D →
        T^(10/(6+10*σ)) ≤ Q → Q ≤ T^(15/(6+10*σ)) →
        (M : ℝ) ≤ (2 : ℝ)^201*Q →
        IsSeparated 1 W → InBaseInterval (3*T) W → (∀ n, ‖b n‖ ≤ 1) →
        (∀ t ∈ W, Q^σ/D ≤ ‖dirichletPoly M b t‖) →
        (W.card : ℝ) ≤ C * D^4 * T^(final_exponent σ+ε) := by
  obtain ⟨A, T₀, hA, hT₀, hGM⟩ := guthMaynardLargeValues_neg guthMaynardLargeValues_native ε hε
  obtain ⟨B, hB, hMV⟩ := classical_large_values_second_branch_unrestricted
  let K : ℝ := (2 : ℝ)^201
  have hK : 0 < K := by dsimp [K]; positivity
  refine ⟨9*A*3^ε*K^4+6*B*K^2,T₀,by positivity,hT₀,?_⟩
  intro σ T Q D M W b hσL hσU hT hM hD hlo hhi hMQ hs hi hb hv
  have hT1 : 1 ≤ T := hT₀.trans hT
  have hTp : 0 < T := by linarith
  have hQ : 0 < Q := (Real.rpow_pos_of_pos hTp _).trans_le hlo
  have hDp : 0 < D := by linarith
  let V := Q^σ/D
  have hV : 0 < V := div_pos (Real.rpow_pos_of_pos hQ _) hDp
  have hD2 : D^2 ≤ D^4 := pow_le_pow_right₀ hD (by norm_num)
  have hinv (j : ℝ) : V^(-j) = D^j * Q^(-j*σ) := by
    dsimp [V]
    rw [Real.div_rpow (Real.rpow_nonneg hQ.le _) hDp.le,
        ← Real.rpow_mul hQ.le, div_eq_mul_inv, ← Real.rpow_neg hDp.le]
    ring_nf
  have hinv2 : V^(-2 : ℝ) = D^2 * Q^(-2*σ) := by
    simpa only [Real.rpow_two] using hinv 2
  have hinv4 : V^(-4 : ℝ) = D^4 * Q^(-4*σ) := by
    simpa only [show (4 : ℝ) = ((4 : ℕ) : ℝ) by norm_num, Real.rpow_natCast]
      using hinv 4
  have hTε : 1 ≤ T^ε := Real.one_le_rpow hT1 hε.le
  have hpow : T^(final_exponent σ+ε) = T^(final_exponent σ)*T^ε := Real.rpow_add hTp _ _
  by_cases hsmall : Q ≤ T^alpha σ
  · have h := hGM M V (3*T) b W hM (by linarith) hV hb hs hi hv
    rw [hinv2,hinv4, Real.mul_rpow (by norm_num : (0 : ℝ) ≤ 3) hTp.le] at h
    have ht := selected_block_large_value_terms_le σ T Q M hQ hTp.le (Nat.cast_nonneg _) hMQ
    have he := large_values_terms_le σ T Q hσL hσU hT1 hQ.le hlo hhi hsmall
    calc
      _ ≤ A*(3^ε*T^ε)*(3*(D^4*((M : ℝ)^2*Q^(-2*σ)+(M : ℝ)^(18/5 : ℝ)*Q^(-4*σ)+T*(M : ℝ)^(12/5 : ℝ)*Q^(-4*σ)))) := by
        refine h.trans ?_
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        calc
          _ ≤ (M : ℝ)^2*(D^4*Q^(-2*σ))+
              (M : ℝ)^(18/5 : ℝ)*(D^4*Q^(-4*σ))+3*T*(M : ℝ)^(12/5 : ℝ)*(D^4*Q^(-4*σ)) := by
            gcongr
          _ ≤ _ := by nlinarith [show 0 ≤ (M : ℝ)^2*(D^4*Q^(-2*σ)) by positivity,
            show 0 ≤ (M : ℝ)^(18/5 : ℝ)*(D^4*Q^(-4*σ)) by positivity]
      _ ≤ A*(3^ε*T^ε)*(3*(D^4*(K^4*(3*T^final_exponent σ)))) := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        apply mul_le_mul_of_nonneg_left _ (by norm_num)
        exact mul_le_mul_of_nonneg_left (ht.trans (mul_le_mul_of_nonneg_left he (by positivity)))
          (by positivity)
      _ = 9*A*3^ε*K^4*D^4*T^(final_exponent σ+ε) := by rw [hpow]; ring
      _ ≤ _ := by
        gcongr
        exact le_add_of_nonneg_right (by positivity)
  · have h := hMV M (3*T) V W b hM (by linarith) hV (fun n _ => hb n) hs hi hv
    have ht := selected_block_mean_value_terms_le σ T Q M hQ hTp.le (Nat.cast_nonneg _) hMQ
    have he := mean_value_terms_le σ T Q hσL hσU hT1 hQ.le hhi (le_of_not_ge hsmall)
    have hr : (1 : ℝ)/V^2 = D^2*Q^(-2*σ) := (gm_inv_rpow_two hV).symm.trans hinv2
    calc
      _ ≤ B*((M : ℝ)^2/V^2+3*T*(M : ℝ)/V^2) := h
      _ = B*D^2*(((M : ℝ)^2+3*T*(M : ℝ))*Q^(-2*σ)) := by
        simp only [div_eq_mul_inv, one_mul] at hr
        simp only [div_eq_mul_inv]
        rw [hr]
        ring
      _ ≤ B*D^4*((3*T+(M : ℝ))*(M : ℝ)*Q^(-2*σ)) := by
        gcongr
        nlinarith
      _ ≤ B*D^4*(3*K^2*(2*T^final_exponent σ)) :=
        mul_le_mul_of_nonneg_left (ht.trans (mul_le_mul_of_nonneg_left he (by positivity)))
          (by positivity)
      _ = 6*B*K^2*D^4*T^final_exponent σ := by ring
      _ ≤ (9*A*3^ε*K^4+6*B*K^2)*D^4*T^final_exponent σ := by
        gcongr
        linarith [show 0 ≤ 9*A*3^ε*K^4 by positivity]
      _ ≤ _ := by
        rw [hpow]
        have hh := mul_le_mul_of_nonneg_left hTε
          (show 0 ≤ (9*A*3^ε*K^4+6*B*K^2)*D^4*T^final_exponent σ by positivity)
        simpa only [mul_one, mul_assoc] using hh

end Legendre.Density.GuthMaynard
