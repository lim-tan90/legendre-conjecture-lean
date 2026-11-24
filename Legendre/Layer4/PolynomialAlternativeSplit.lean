/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.BalancedAlternatives
public import Mathlib.Algebra.Field.GeomSum

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- Summation of the increasing block-length power. The ratio is bounded
away from one by the distance from the upper real-part endpoint. -/
theorem detector_dyadic_increasing_sum (J : ℕ) (X Y a δ : ℝ) (hX : 0 < X) (hY : 0 < Y)
    (hδ : 0 < δ) (hδa : δ ≤ a) (ha : a ≤ 1)
    (hJ : J = 0 ∨ (2 : ℝ)^J*X ≤ 2*Y) :
    (∑ j ∈ Finset.range J, ((2 : ℝ)^j*X)^a) ≤
      (2/((2 : ℝ)^δ-1))*Y^a := by
  have hδ2 : (1 : ℝ) < 2^δ := Real.one_lt_rpow (by norm_num) hδ
  have ha2 : (2 : ℝ)^δ ≤ 2^a := Real.rpow_le_rpow_of_exponent_le (by norm_num) hδa
  have hr : (1 : ℝ) < 2^a := hδ2.trans_le ha2
  have hden : 0 < (2 : ℝ)^δ-1 := sub_pos.mpr hδ2
  rcases hJ with rfl|hJ
  · simp only [Finset.range_zero,Finset.sum_empty]
    positivity
  have hpow (j : ℕ) : ((2 : ℝ)^j*X)^a = X^a*((2 : ℝ)^a)^j := by
    rw [Real.mul_rpow (by positivity) hX.le, mul_comm, ← Real.rpow_natCast_mul (by norm_num : (0 : ℝ) ≤ 2),
      mul_comm (j : ℝ) a, Real.rpow_mul (by norm_num), Real.rpow_natCast]
  have h2 : (2 : ℝ)^a ≤ 2 := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2) ha
  have hlast : (X^a)*((2 : ℝ)^a)^J ≤ 2*Y^a := by
    rw [← hpow]
    calc
      _ ≤ (2*Y)^a := Real.rpow_le_rpow (by positivity) hJ (hδ.le.trans hδa)
      _ = (2 : ℝ)^a*Y^a := Real.mul_rpow (by norm_num) hY.le
      _ ≤ _ := mul_le_mul_of_nonneg_right h2 (by positivity)
  simp_rw [hpow]
  rw [← Finset.mul_sum,geom_sum_eq hr.ne']
  calc
    _ ≤ X^a*(((2 : ℝ)^a)^J/((2 : ℝ)^a-1)) :=
      mul_le_mul_of_nonneg_left
        (div_le_div_of_nonneg_right (sub_le_self _ zero_le_one) (sub_nonneg.mpr hr.le)) (by positivity)
    _ ≤ X^a*(((2 : ℝ)^a)^J/((2 : ℝ)^δ-1)) :=
      mul_le_mul_of_nonneg_left
        (div_le_div_of_nonneg_left (by positivity) hden (sub_le_sub_right ha2 _)) (by positivity)
    _ = (X^a*((2 : ℝ)^a)^J)/((2 : ℝ)^δ-1) := by ring
    _ ≤ (2*Y^a)/((2 : ℝ)^δ-1) := div_le_div_of_nonneg_right hlast hden.le
    _ = _ := by ring

/-- Below a fixed upper real part, the high-length part of the polynomial
count needs only the three logarithms from divisor energy. -/
theorem polynomial_alternative_count_split (τ : ℝ) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ Y T σ : ℝ,
      2 ≤ Y → 1 ≤ T → 1/2 ≤ σ → σ ≤ τ → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ) ≤ C*((1+Real.log (2*Y+1))^3*Y^(2-2*σ) +
        (1+Real.log (2*Y+1))^5*T*(X : ℝ)^(1-2*σ)) := by
  obtain ⟨K,hK,hblock⟩ := polynomial_actual_block_length
  let δ := 1-τ
  let A := 2/((2 : ℝ)^δ-1)
  let B := 2/Real.log 2
  have hδ : 0 < δ := by dsimp [δ]; linarith
  have hA : 0 < A := div_pos (by norm_num) (sub_pos.mpr (Real.one_lt_rpow (by norm_num) hδ))
  have hB : 0 < B := div_pos (by norm_num) (Real.log_pos (by norm_num))
  refine ⟨512*K*(A^2+B^2),by positivity,?_⟩
  intro X hX Y T σ hY hT hσ hστ ι S t β ht hs hβ hlarge
  obtain ⟨J,hcover,hJlog,hleft,htop⟩ := detector_dyadic_cover_support X hX Y hY
  let a := 1-σ
  let b := 1/2-σ
  let L := 1+Real.log (2*Y+1)
  let U := fun j : ℕ => 2^j*X
  let w := fun j : ℕ => ((U j : ℕ) : ℝ)^a+Real.sqrt T*((U j : ℕ) : ℝ)^b
  let f := fun i j => ∑ n ∈ Finset.Ioc (U j) (2*U j),
    Detector.Smooth.polynomialCoefficient X Y n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))
  have ha : 0 ≤ a := by dsimp [a]; linarith
  have hb : b ≤ 0 := by dsimp [b]; linarith
  have hX₀ : (0 : ℝ) < X := by exact_mod_cast hX
  have hU (j : ℕ) : X ≤ U j := Nat.le_mul_of_pos_left X (by positivity)
  have hUp (j : ℕ) : (0 : ℝ) < U j := by exact_mod_cast (hX.trans (hU j))
  have hL : 0 ≤ L := by dsimp [L]; linarith [Real.log_nonneg (show 1 ≤ 2*Y+1 by linarith)]
  have hw (j : ℕ) (_hj : j ∈ Finset.range J) : 0 < w j := by
    dsimp only [w]
    have := hUp j
    positivity
  have hlen (j : ℕ) (hj : j ∈ Finset.range J) :
      (∑ i ∈ S, ‖f i j‖^2) ≤ (K*L^3)*(w j)^2 := by
    have hleft' : (U j : ℝ) ≤ Y := by simpa only [U,Nat.cast_mul,Nat.cast_pow,Nat.cast_ofNat] using hleft j hj
    have h := hblock S t β X (U j) (hX.trans (hU j)) T Y σ hT hY hleft' hσ ht hβ hs
    have haeq : ((U j : ℝ)^a)^2 = (U j : ℝ)*(U j : ℝ)^(1-2*σ) := by
      rw [← Real.rpow_mul_natCast (hUp j).le]
      calc
        _ = (U j : ℝ)^(1+(1-2*σ)) := by congr 1; dsimp [a]; ring
        _ = _ := by rw [Real.rpow_add (hUp j), Real.rpow_one]
    have hbeq : (Real.sqrt T*(U j : ℝ)^b)^2 = T*(U j : ℝ)^(1-2*σ) := by
      rw [mul_pow, Real.sq_sqrt (by linarith), ← Real.rpow_mul_natCast (hUp j).le]
      congr 2
      dsimp [b]
      ring
    have hpower : ((U j : ℝ)+T)*(U j : ℝ)^(1-2*σ) =
        ((U j : ℝ)^a)^2+(Real.sqrt T*(U j : ℝ)^b)^2 := by
      rw [add_mul,haeq,hbeq]
    have hpower' : ((U j : ℝ)+T)*(U j : ℝ)^(1-2*σ) ≤ (w j)^2 := by
      rw [hpower]
      dsimp only [w]
      have hpos : 0 ≤ (U j : ℝ)^a*(Real.sqrt T*(U j : ℝ)^b) := by
        have := hUp j
        positivity
      nlinarith
    apply h.trans
    simpa only [mul_assoc] using
      mul_le_mul_of_nonneg_left hpower' (mul_nonneg hK.le (pow_nonneg hL 3))
  have hinc : (∑ j ∈ Finset.range J, (U j : ℝ)^a) ≤ A*Y^a := by
    have h := detector_dyadic_increasing_sum J X Y a δ hX₀ (by linarith)
      hδ (by dsimp [a,δ]; linarith) (by dsimp [a]; linarith) htop
    simpa only [U,A,Nat.cast_mul,Nat.cast_pow,Nat.cast_ofNat] using h
  have hdec : (∑ j ∈ Finset.range J, Real.sqrt T*(U j : ℝ)^b) ≤ B*L*Real.sqrt T*(X : ℝ)^b := by
    have hJ : (J : ℝ) ≤ B*L := by
      apply hJlog.trans
      apply mul_le_mul_of_nonneg_left _ hB.le
      have h := Real.log_le_log (by linarith : 0 < Y) (by linarith : Y ≤ 2*Y+1)
      dsimp [L]
      linarith
    calc
      _ ≤ ∑ j ∈ Finset.range J, Real.sqrt T*(X : ℝ)^b := by
        apply Finset.sum_le_sum
        intro j _
        exact mul_le_mul_of_nonneg_left (Real.rpow_le_rpow_of_nonpos hX₀
          (by exact_mod_cast hU j) hb) (Real.sqrt_nonneg T)
      _ = (J : ℝ)*(Real.sqrt T*(X : ℝ)^b) := by rw [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
      _ ≤ (B*L)*(Real.sqrt T*(X : ℝ)^b) := mul_le_mul_of_nonneg_right hJ (by positivity)
      _ = _ := by ring
  have hsW : (∑ j ∈ Finset.range J, w j) ≤ A*Y^a+B*L*Real.sqrt T*(X : ℝ)^b := by
    dsimp only [w]
    rw [Finset.sum_add_distrib]
    exact add_le_add hinc hdec
  have hsW₀ : 0 ≤ ∑ j ∈ Finset.range J, w j := Finset.sum_nonneg (fun j hj => (hw j hj).le)
  have hWsq := pow_le_pow_left₀ hsW₀ hsW 2
  have hlight := detectorTail_dyadic_count_lower S t β X J hX Y hY hcover hlarge
  have hheavy := finite_blocks_weighted_energy S J f w hw (K*L^3) hlen
  have hcard : (S.card : ℝ) ≤ 256*(K*L^3)*(A*Y^a+B*L*Real.sqrt T*(X : ℝ)^b)^2 := by
    have h := hlight.trans (hheavy.trans (mul_le_mul_of_nonneg_left hWsq (by positivity)))
    linarith
  have hYsq : (Y^a)^2 = Y^(2-2*σ) := by
    rw [← Real.rpow_mul_natCast (by linarith : 0 ≤ Y)]
    congr 1
    dsimp [a]
    ring
  have hXsq : ((X : ℝ)^b)^2 = (X : ℝ)^(1-2*σ) := by
    rw [← Real.rpow_mul_natCast hX₀.le]
    congr 1
    dsimp [b]
    ring
  have hquad : (A*Y^a+B*L*Real.sqrt T*(X : ℝ)^b)^2 ≤
      2*(A*Y^a)^2+2*(B*L*Real.sqrt T*(X : ℝ)^b)^2 := by
    nlinarith [sq_nonneg (A*Y^a-B*L*Real.sqrt T*(X : ℝ)^b)]
  calc
    _ ≤ 256*(K*L^3)*(A*Y^a+B*L*Real.sqrt T*(X : ℝ)^b)^2 := hcard
    _ ≤ 256*(K*L^3)*(2*(A*Y^a)^2+2*(B*L*Real.sqrt T*(X : ℝ)^b)^2) :=
      mul_le_mul_of_nonneg_left hquad (by positivity)
    _ = 512*K*(A^2*(L^3*Y^(2-2*σ))+B^2*(L^5*T*(X : ℝ)^(1-2*σ))) := by
      simp only [mul_pow,hYsq,hXsq,Real.sq_sqrt (show 0 ≤ T by linarith)]
      ring
    _ ≤ 512*K*((A^2+B^2)*(L^3*Y^(2-2*σ)+L^5*T*(X : ℝ)^(1-2*σ))) := by
      have h₁ : 0 ≤ B^2*(L^3*Y^(2-2*σ)) := by positivity
      have h₂ : 0 ≤ A^2*(L^5*T*(X : ℝ)^(1-2*σ)) := by positivity
      apply mul_le_mul_of_nonneg_left _ (by positivity : 0 ≤ 512*K)
      nlinarith
    _ = _ := by dsimp only [L]; ring

theorem polynomial_alternative_balanced_split (τ : ℝ) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 ≤ σ → σ ≤ τ →
      ∀ X : ℕ, 1 ≤ X → T ≤ X → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I)
        (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*(T^balancedDensityExponent σ*(Real.log T)^3+
        T^(2-2*σ)*(Real.log T)^5) := by
  obtain ⟨C,hC,hb⟩ := polynomial_alternative_count_split τ hτ
  refine ⟨C*8^5,by positivity,?_⟩
  intro T σ hT hσ hστ X hX hTX ι S t β ht hs hβ hlarge
  have hσ1 := hστ.trans hτ.le
  let Y := T^detectorBalanceExponent σ
  have hY : 2 ≤ Y := by
    have hh := Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
      (balance_exponent_ge_one σ hσ hσ1)
    rw [Real.rpow_one] at hh
    exact hT.trans hh
  have h := hb X hX Y T σ hY (by linarith) hσ hστ S t β ht hs hβ hlarge
  have hlog := balanced_log_cost T σ hT hσ hσ1
  have hL : 0 ≤ 1+Real.log (2*Y+1) := by
    linarith [Real.log_nonneg (show 1 ≤ 2*Y+1 by linarith)]
  have hlogT : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  obtain ⟨hye,hxe⟩ := balanced_polynomial_endpoint_powers T X σ (by linarith) hTX hσ hσ1
  apply h.trans
  calc
    _ ≤ C*((8*Real.log T)^3*T^balancedDensityExponent σ+(8*Real.log T)^5*T^(2-2*σ)) := by
      rw [show Y^(2-2*σ) = T^balancedDensityExponent σ from hye, mul_assoc _ T]
      apply mul_le_mul_of_nonneg_left _ hC.le
      apply add_le_add
      · exact mul_le_mul_of_nonneg_right (pow_le_pow_left₀ hL hlog 3) (by positivity)
      · exact mul_le_mul (pow_le_pow_left₀ hL hlog 5) hxe (by positivity) (by positivity)
    _ ≤ _ := by
      have hnonneg : 0 ≤ C*T^balancedDensityExponent σ*(Real.log T)^3 := by positivity
      nlinarith

end Legendre.Density.Moment
