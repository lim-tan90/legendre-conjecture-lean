/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.SmoothedDivisorMoment
public import Legendre.Layer4.MollifiedZetaSmoothedMoment
public import Legendre.Layer4.DensityBalance

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set
open Detector Detector.Smooth

set_option maxHeartbeats 600000 in
private theorem three_halves_moment_bound {X : ℕ} {T α : ℝ}
    (hX : 1 ≤ X) (hT : 16 ≤ T) (hTX : T ≤ X) (hXT : (X : ℝ) ≤ 2*T)
    (hlogX : 1+Real.log X ≤ 4*Real.log T) (hα : 3/4 ≤ α) (hα₁ : α ≤ 1) :
    let D := 2/(1-(2 : ℝ)^(-(1/2 : ℝ)))
    smoothedMollifiedMomentBound X T α (T^(3/2 : ℝ)) ≤
      (D*7^3+3^4+2048+2)*T^(3*(1-α))*(Real.log T)^4 := by
  dsimp only
  let Y := T^(3/2 : ℝ)
  let N := ⌊Y⌋₊
  let L := Real.log T
  let W := T^(3*(1-α))
  let Lx := 1+Real.log (X*X : ℕ)
  let D := 2/(1-(2 : ℝ)^(-(1/2 : ℝ)))
  have hTp : 0 < T := by linarith
  have hT₁ : 1 ≤ T := by linarith
  have hT₂ : 2 ≤ T := by linarith
  have hXp : (0 : ℝ) < X := by linarith
  have hL : 1 ≤ L := by
    have hh := Real.log_le_log (by norm_num : 0 < (4 : ℝ)) (by linarith : 4 ≤ T)
    have he : Real.log 4 = 2*Real.log 2 := by
      simpa only [show (2 : ℝ)^2 = 4 by norm_num, Nat.cast_ofNat] using Real.log_pow (2 : ℝ) 2
    rw [he] at hh
    exact (one_le_two_log 2 le_rfl).trans hh
  have hL0 : 0 ≤ L := zero_le_one.trans hL
  have hY : T ≤ Y := by
    have h := Real.rpow_le_rpow_of_exponent_le hT₁ (by norm_num : (1 : ℝ) ≤ 3/2)
    simpa only [Real.rpow_one] using h
  have hYp : 0 < Y := hTp.trans_le hY
  have hY₁ : 1 ≤ Y := hT₁.trans hY
  have hN : 1 ≤ N := (Nat.le_floor_iff hYp.le).2 (by simpa using hY₁)
  have hNp : (0 : ℝ) < N := by exact_mod_cast (zero_lt_one.trans_le hN)
  have hNY : (N : ℝ) ≤ Y := Nat.floor_le hYp.le
  have hlogY : Real.log Y = (3/2)*L := Real.log_rpow hTp _
  have hlogN : Real.log N ≤ (3/2)*L :=
    (Real.log_le_log hNp hNY).trans_eq hlogY
  have hlog2 : Real.log 2 ≤ L := Real.log_le_log (by norm_num) hT₂
  have hlogXN : 1+Real.log (2*X*N : ℕ) ≤ 7*L := by
    push_cast
    rw [Real.log_mul (by positivity) hNp.ne', Real.log_mul (by norm_num) hXp.ne']
    linarith
  have hlogXN0 : 0 ≤ 1+Real.log (2*X*N : ℕ) := by
    have hbase : (1 : ℝ) ≤ (2*X*N : ℕ) := by exact_mod_cast
      (one_le_mul (one_le_mul (by norm_num : 1 ≤ (2 : ℕ)) hX) hN)
    linarith [Real.log_nonneg hbase]
  have hlogN0 : 0 ≤ 1+Real.log N :=
    by linarith [Real.log_nonneg (show (1 : ℝ) ≤ N by exact_mod_cast hN)]
  have hLx0 : 0 ≤ Lx := by
    have hbase : (1 : ℝ) ≤ (X*X : ℕ) := by exact_mod_cast (one_le_mul hX hX)
    dsimp [Lx]
    linarith [Real.log_nonneg hbase]
  have hLx : Lx ≤ 8*L := by
    dsimp [Lx]
    push_cast
    rw [Real.log_mul hXp.ne' hXp.ne']
    linarith
  have hD : 0 < D := by
    dsimp [D]
    exact div_pos (by norm_num) (sub_pos.mpr
      (Real.rpow_lt_one_of_one_lt_of_neg (by norm_num) (by norm_num)))
  have hW : 1 ≤ W := Real.one_le_rpow hT₁ (by linarith)
  have hYW : Y^(2-2*α) = W := by
    dsimp only [Y,W]
    rw [← Real.rpow_mul hTp.le]
    congr 1
    ring
  have hYW' : Y^(1-2*α)*Y = W := by
    rw [← Real.rpow_add_one hYp.ne', show 1-2*α+1 = 2-2*α by ring]
    exact hYW
  have hXW : T*(X : ℝ)^(1-2*α) ≤ W := by
    have hpow := (balanced_polynomial_endpoint_powers T (X : ℝ) α hT₁ hTX
      (by linarith) hα₁).2
    exact hpow.trans (Real.rpow_le_rpow_of_exponent_le hT₁ (by linarith))
  have hdiag :
      T*(∑ n ∈ Finset.Ioc X N, (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α)) ≤ D*7^3*(W*L^4) := by
    have h := smoothed_tail_diagonal_energy_le hX hN hα
    have hl3 : L^3 ≤ L^4 := pow_le_pow_right₀ hL (by norm_num)
    calc
      _ ≤ T*(D*(X : ℝ)^(1-2*α)*(1+Real.log (2*X*N : ℕ))^3) :=
        mul_le_mul_of_nonneg_left h hTp.le
      _ = D*(T*(X : ℝ)^(1-2*α))*(1+Real.log (2*X*N : ℕ))^3 := by ring
      _ ≤ D*W*(7*L)^3 := mul_le_mul (mul_le_mul_of_nonneg_left hXW hD.le)
        (pow_le_pow_left₀ hlogXN0 hlogXN 3) (by positivity) (by positivity)
      _ = D*7^3*W*L^3 := by ring
      _ ≤ _ := by
        have h := mul_le_mul_of_nonneg_left hl3 (show 0 ≤ D*7^3*W by positivity)
        convert h using 1
        ring
  have hoff :
      (∑ n ∈ Finset.Ioc X N, (n : ℝ)*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α)) ≤ 3^4*(W*L^4) := by
    calc
      _ ≤ (N : ℝ)^(2-2*α)*(1+Real.log N)^4 := smoothed_tail_index_energy_le (X := X) (N := N) hα₁
      _ ≤ Y^(2-2*α)*(3*L)^4 := mul_le_mul (Real.rpow_le_rpow hNp.le hNY (by linarith))
        (pow_le_pow_left₀ hlogN0 (by linarith) 4) (by positivity) (by positivity)
      _ = _ := by rw [hYW]; ring
  have hpoly :
      (∑ n ∈ Finset.Ioc X N, (T+(n : ℝ))*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α)) ≤
        (D*7^3+3^4)*(W*L^4) := by
    have he (n : ℕ) :
        (T+(n : ℝ))*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α) =
          T*((n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α))+
            (n : ℝ)*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α) := by ring
    simp_rw [he, Finset.sum_add_distrib, ← Finset.mul_sum]
    exact (add_le_add hdiag hoff).trans_eq (by ring)
  have hXsq : (((X*X : ℕ) : ℝ)) ≤ 4*T^2 := by
    push_cast
    have hh := pow_le_pow_left₀ (Nat.cast_nonneg X) hXT 2
    nlinarith
  have hradicand : T*Lx^4+((X*X : ℕ) : ℝ)*Lx^3 ≤ 8192*T^2*L^4 := by
    have h1 : T*Lx^4 ≤ T^2*(8*L)^4 :=
      mul_le_mul (by nlinarith [mul_nonneg (show 0 ≤ T-1 by linarith) hTp.le])
        (pow_le_pow_left₀ hLx0 hLx 4) (by positivity) (by positivity)
    have h2 : (((X*X : ℕ) : ℝ))*Lx^3 ≤ 4*T^2*(8*L)^3 :=
      mul_le_mul hXsq (pow_le_pow_left₀ hLx0 hLx 3) (by positivity) (by positivity)
    have h3 := mul_le_mul_of_nonneg_left (pow_le_pow_right₀ hL (by norm_num : (3 : ℕ) ≤ 4))
      (show 0 ≤ T^2 by positivity)
    nlinarith [mul_nonneg (sq_nonneg T) (pow_nonneg hL0 4)]
  have hsqrt : √(T*L^4*(T*Lx^4+((X*X : ℕ) : ℝ)*Lx^3)) ≤ 128*Y*L^4 := by
    apply le_of_pow_le_pow_left₀ (by norm_num : (2 : ℕ) ≠ 0) (by positivity)
    rw [Real.sq_sqrt (by positivity)]
    have hpow : Y^2 = T^3 := by
      dsimp only [Y]
      rw [← Real.rpow_mul_natCast hTp.le]
      norm_num
    have hh := mul_le_mul_of_nonneg_left hradicand (show 0 ≤ T*L^4 by positivity)
    rw [mul_pow, mul_pow, hpow]
    nlinarith [mul_nonneg (pow_nonneg hTp.le 3) (pow_nonneg hL0 8)]
  have hgap : 1/(α-1/2) ≤ 4 := by
    apply (div_le_iff₀ (by linarith : 0 < α-1/2)).2
    linarith
  have hYSq : (Y^(1/2-α))^2 = Y^(1-2*α) := by
    rw [← Real.rpow_mul_natCast hYp.le, Nat.cast_ofNat]
    congr 1
    ring
  have hcrit :
      (Y^(1/2-α)/(α-1/2))^2*√(T*L^4*(T*Lx^4+((X*X : ℕ) : ℝ)*Lx^3)) ≤ 2048*(W*L^4) := by
    have hfac : (Y^(1/2-α)/(α-1/2))^2 ≤ 16*Y^(1-2*α) := by
      have hh := pow_le_pow_left₀ (one_div_nonneg.mpr (by linarith : 0 ≤ α-1/2)) hgap 2
      rw [← mul_one_div, mul_pow, hYSq, mul_comm (16 : ℝ)]
      exact mul_le_mul_of_nonneg_left (by simpa only [show (4 : ℝ)^2 = 16 by norm_num] using hh) (by positivity)
    calc
      _ ≤ (16*Y^(1-2*α))*(128*Y*L^4) :=
        mul_le_mul hfac hsqrt (Real.sqrt_nonneg _) (by positivity)
      _ = 2048*(Y^(1-2*α)*Y)*L^4 := by ring
      _ = _ := by rw [hYW']; ring
  have hc₁ : 1/T ≤ W*L^4 :=
    ((div_le_one hTp).2 hT₁).trans (one_le_mul_of_one_le_of_one_le hW (one_le_pow₀ hL))
  have hc₂ : T/Y^2 ≤ W*L^4 := by
    have hYY : Y ≤ Y^2 := by simpa only [pow_one] using (pow_le_pow_right₀ hY₁ (show 1 ≤ (2 : ℕ) by norm_num))
    exact ((div_le_one (sq_pos_of_pos hYp)).2 (hY.trans hYY)).trans
      (one_le_mul_of_one_le_of_one_le hW (one_le_pow₀ hL))
  change (∑ n ∈ Finset.Ioc X N, (T+(n : ℝ))*(n.divisors.card : ℝ)^2*(n : ℝ)^(-2*α)) +
    (Y^(1/2-α)/(α-1/2))^2*√(T*L^4*(T*Lx^4+((X*X : ℕ) : ℝ)*Lx^3)) +
      1/T+T/Y^2 ≤ (D*7^3+3^4+2048+2)*W*L^4
  exact (add_le_add (add_le_add (add_le_add hpoly hcrit) hc₁) hc₂).trans_eq (by ring)

/-- The smoothed error on a high shell has the height power (3(1-alpha))
and a fourth power of the logarithm uniformly above real part (3/4). -/
theorem smoothed_mollifiedError_shell_log_four :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 16 ≤ T → ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ α a : ℝ, 3/4 ≤ α → α ≤ 1 → α ≤ a → a ≤ 7/6 →
      (∫ t in Icc (T/2) T, ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
        C*T^(3*(1-α))*(Real.log T)^4 := by
  obtain ⟨C,hC,hb⟩ := smoothed_mollifiedError_shell_second_moment
  let D := 2/(1-(2 : ℝ)^(-(1/2 : ℝ)))
  have hD : 0 < D := div_pos (by norm_num) (sub_pos.mpr
    (Real.rpow_lt_one_of_one_lt_of_neg (by norm_num) (by norm_num)))
  refine ⟨C*(D*7^3+3^4+2048+2),by positivity,?_⟩
  intro T hT
  obtain ⟨X,hX,hTX,hXT,_,hlogX⟩ := balanced_detector_cutoff T (by linarith)
  refine ⟨X,hX,hTX,hXT,?_⟩
  intro α a hα hα₁ hαa ha
  have hY₀ : 1 ≤ T^(3/2 : ℝ) := Real.one_le_rpow (by linarith) (by norm_num)
  have hYt : T^(3/2 : ℝ) ≤ (T/2)^2 := by
    convert balanced_scale_below_half_height_square T 1 hT le_rfl using 2
    norm_num [detectorBalanceExponent]
  have h := hb X hX T (by linarith) hXT α a (T^(3/2 : ℝ)) (by linarith) hαa ha hY₀ hYt
  exact (h.trans (mul_le_mul_of_nonneg_left
    (three_halves_moment_bound hX hT hTX hXT hlogX hα hα₁) hC.le)).trans_eq (by dsimp only [D]; ring)

/-- Within distance (1/sqrt{log T}) of one, the same fourth-log moment
retains the exact curved Ingham height exponent. -/
theorem smoothed_mollifiedError_shell_ingham_power :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 16 ≤ T → ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ α a : ℝ, 3/4 ≤ α → α ≤ 1 → α ≤ a → a ≤ 7/6 → (1-α)^2*Real.log T ≤ 1 →
      (∫ t in Icc (T/2) T, ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
        C*T^balancedDensityExponent α*(Real.log T)^4 := by
  obtain ⟨C,hC,hb⟩ := smoothed_mollifiedError_shell_log_four
  refine ⟨C*Real.exp 3,by positivity,?_⟩
  intro T hT
  obtain ⟨X,hX,hTX,hXT,h⟩ := hb T hT
  refine ⟨X,hX,hTX,hXT,?_⟩
  intro α a hα hα₁ hαa ha hnear
  have hTp : 0 < T := by linarith
  have hh : 3*(1-α)-balancedDensityExponent α = 3*(1-α)^2/(2-α) := by
    unfold balancedDensityExponent
    field_simp [show 2-α ≠ 0 by linarith]
    ring
  have hgap : 3*(1-α)-balancedDensityExponent α ≤ 3*(1-α)^2 := by
    rw [hh]
    exact div_le_self (by positivity) (by linarith)
  have hp : T^(3*(1-α)-balancedDensityExponent α) ≤ Real.exp 3 := by
    rw [Real.rpow_def_of_pos hTp, Real.exp_le_exp]
    have hlogT : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
    have hg := mul_le_mul_of_nonneg_left hgap hlogT
    nlinarith only [hg,hnear]
  have he : T^(3*(1-α)) = T^balancedDensityExponent α*T^(3*(1-α)-balancedDensityExponent α) := by
    rw [← Real.rpow_add hTp, add_comm, sub_add_cancel]
  calc
    _ ≤ C*T^(3*(1-α))*(Real.log T)^4 := h α a hα hα₁ hαa ha
    _ = C*T^balancedDensityExponent α*T^(3*(1-α)-balancedDensityExponent α)*(Real.log T)^4 := by
      rw [he]
      ring
    _ ≤ _ := by
      have h := mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_left hp (show 0 ≤ C*T^balancedDensityExponent α by positivity))
        (show 0 ≤ (Real.log T)^4 by positivity)
      convert h using 1
      ring

end Legendre.Density.Moment
