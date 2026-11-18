/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GuthMaynard.ShiftedSamples
public import Legendre.Layer4.HuxleyShortTail

@[expose] public section
open Finset Complex Set
open scoped BigOperators
namespace Legendre.Density.GuthMaynard

set_option maxHeartbeats 400000 in
/-- The actual compact detector tail has the Guth–Maynard central exponent
after dyadic decomposition and coefficient normalization. -/
theorem gm_actual_typeI_count (ε : ℝ) (hε : 0 < ε) :
    ∃ C T₀ : ℝ, 0 < C ∧ 128 ≤ T₀ ∧
      ∀ T σ : ℝ, T₀ ≤ T → 7/10 ≤ σ → σ ≤ 4/5 →
      ∀ X : ℕ, T^(1/200 : ℝ) ≤ (X : ℝ) →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, t i ∈ Set.Icc 0 T) → (∀ i ∈ S, β i ∈ Set.Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖) →
      (S.card : ℝ) ≤ C*T^(final_exponent σ+ε) := by
  classical
  let ρ := min (ε/(3*804)) (1/2)
  have hρ : 0 < ρ := lt_min (by positivity) (by norm_num)
  have hρ2 : ρ ≤ 1/2 := min_le_right _ _
  have hρε : 804*ρ ≤ ε/3 := by
    have h : ρ ≤ ε/(3*804) := min_le_left _ _
    linarith
  obtain ⟨A₀,hA₀,hdiv⟩ := divisorCountBound_native ρ hρ
  let A := 1+A₀*2^ρ
  have hA : 1 ≤ A := le_add_of_nonneg_right (by positivity)
  have hAp : 0 < A := by linarith
  let B := 2/Real.log 2
  have hB : 0 < B := by dsimp [B]; positivity
  obtain ⟨C,T₁,hC,hT₁,hcount⟩ := gm_section13_varying_line_count (ε/3) (by linarith)
  obtain ⟨D,hD,hlog⟩ := Moment.exists_one_add_log_pow_le_rpow 805 (ε/3) (by linarith)
  let T₀ := max 128 (max T₁ ((16*B*A)^2))
  refine ⟨C*(16*A)^804*B^805*D,T₀,by positivity,le_max_left _ _,?_⟩
  intro T σ hT hσL hσU X hXlo ι S t β ht hβ hs hw
  have h128 : 128 ≤ T := (le_max_left _ _).trans hT
  have hT2 : 2 ≤ T := by linarith
  have hT1' : T₁ ≤ T := (le_max_left _ _).trans ((le_max_right _ _).trans hT)
  have hTgeo : (16*B*A)^2 ≤ T := (le_max_right _ _).trans ((le_max_right _ _).trans hT)
  have hTp : 0 < T := by linarith
  have hTone : 1 ≤ T := by linarith
  have hX : 1 ≤ X := by
    exact_mod_cast (Real.one_le_rpow hTone (by norm_num : (0 : ℝ) ≤ 1/200)).trans hXlo
  let Y := T^(1/2 : ℝ)
  have hY4 : 4 ≤ Y := (Moment.sqrt_detector_scale T h128).1
  obtain ⟨J,hJ,hcover,hJlog⟩ :=
    Moment.moment_detector_dyadic_cover X hX Y (by linarith)
  let G := A*T^ρ
  have hG : 1 ≤ G := by
    have h := Real.one_le_rpow hTone hρ.le
    dsimp [G]
    nlinarith
  have hGp : 0 < G := by linarith
  have hJr : (1 : ℝ) ≤ J := by exact_mod_cast hJ
  have hJp : (0 : ℝ) < J := by linarith
  have hJLog : (J : ℝ) ≤ B*(1+Real.log T) := by
    have hLog : Real.log Y ≤ 1+Real.log T := by
      dsimp [Y]
      rw [Real.log_rpow hTp]
      linarith [Real.log_nonneg hTone]
    exact hJlog.trans (mul_le_mul_of_nonneg_left hLog hB.le)
  let L := 1/(16*(J : ℝ)*G)
  have hL : 0 < L := by dsimp [L]; positivity
  have hL1 : L ≤ 1 := (div_le_one (by positivity)).2 (by nlinarith)
  have hLlo : T^(-2 : ℝ) ≤ L := by
    rw [gm_inv_rpow_two hTp]
    apply one_div_le_one_div_of_le (by positivity)
    have hBAsqrt : 16*B*A ≤ T^(1/2 : ℝ) := by
      simpa only [Real.sqrt_eq_rpow] using Real.le_sqrt_of_sq_le hTgeo
    have hTρ : T^ρ ≤ T^(1/2 : ℝ) := Real.rpow_le_rpow_of_exponent_le hTone hρ2
    have h16J : 16*(J : ℝ) ≤ 16*B*T := by
      have hlogT := Real.log_le_sub_one_of_pos hTp
      nlinarith [mul_nonneg hB.le (show 0 ≤ T-1-Real.log T by linarith)]
    calc
      _ ≤ (16*B*T)*(A*T^ρ) := mul_le_mul h16J le_rfl hGp.le (by positivity)
      _ = T*((16*B*A)*T^ρ) := by ring
      _ ≤ T*(T^(1/2 : ℝ)*T^(1/2 : ℝ)) := by gcongr
      _ = T^2 := by rw [← Real.rpow_add hTp]; norm_num [Real.rpow_one]; ring
  let N (j : ℕ) := 2^j*X
  let coeff (n : ℕ) := Detector.Smooth.polynomialCoefficient X Y n
  let P (j : ℕ) (i : ι) := finiteDirichletSeries (dyadicInterval (N j)) coeff
    ((β i : ℂ)+(t i : ℂ)*I)
  let Q (j : ℕ) := S.filter (fun i => 1/(16*(J : ℝ)) ≤ ‖P j i‖)
  have hsub : S ⊆ (range J).biUnion Q := by
    intro i hi
    have h := hw i hi
    rw [Detector.Smooth.detectorTail_blocks X J hX Y (by linarith) hcover] at h
    obtain ⟨j,hj,hjlarge⟩ :=
      Moment.exists_large_dyadic_piece J hJ (fun j => P j i) (1/16) h
    refine mem_biUnion.mpr ⟨j,hj,mem_filter.mpr ⟨hi,?_⟩⟩
    convert hjlarge using 1 <;> ring
  have hCard : (S.card : ℝ) ≤ ∑ j ∈ range J, ((Q j).card : ℝ) := by
    exact_mod_cast (Finset.card_le_card hsub).trans Finset.card_biUnion_le
  have hblock (j : ℕ) (_hj : j ∈ range J) :
      ((Q j).card : ℝ) ≤ C*(16*G)^804*(J : ℝ)^804*T^(final_exponent σ+ε/3) := by
    have hNlo : T^(1/200 : ℝ) ≤ (N j : ℝ) := hXlo.trans (by
      exact_mod_cast Nat.le_mul_of_pos_left X (by positivity : 0 < (2 : ℕ)^j))
    have hN : 1 < N j := by
      exact_mod_cast (Real.one_lt_rpow (by linarith : 1 < T) (by norm_num : (0 : ℝ) < 1/200)).trans_le hNlo
    by_cases hNhi : (N j : ℝ) ≤ Y
    · have hN2 : (N j : ℝ)^2 ≤ T^(15/(6+10*σ)) := by
        have hSq : Y^2 = T := by
          dsimp [Y]
          rw [← Real.rpow_natCast, ← Real.rpow_mul hTp.le]
          norm_num
        calc
          _ ≤ Y^2 := pow_le_pow_left₀ (by positivity) hNhi _
          _ = T := hSq
          _ ≤ _ := by
            nth_rewrite 1 [← Real.rpow_one T]
            exact Real.rpow_le_rpow_of_exponent_le hTone
              ((le_div_iff₀ (denom_pos σ hσL)).2 (by linarith))
      let a (n : ℕ) := coeff n/(G : ℂ)
      have ha : ∀ n ∈ dyadicInterval (N j), ‖a n‖ ≤ 1 := by
        intro n hn
        have hn' := Finset.mem_Ioc.mp hn
        have hn0 : 0 < n := (Nat.zero_le _).trans_lt hn'.1
        have hnT : (n : ℝ) ≤ 2*T := by
          have hm : (n : ℝ) ≤ 2*(N j : ℝ) := by exact_mod_cast hn'.2
          have hy : Y ≤ T := by
            dsimp [Y]
            simpa only [Real.rpow_one] using
              Real.rpow_le_rpow_of_exponent_le hTone (by norm_num : (1/2 : ℝ) ≤ 1)
          linarith
        have hnorm : ‖coeff n‖ ≤ G := by
          have h1 := Detector.Smooth.polynomialCoefficient_norm X Y (by linarith) n
          apply h1.trans ((hdiv n hn0).trans ?_)
          have hp := Real.rpow_le_rpow (by positivity : (0 : ℝ) ≤ n) hnT hρ.le
          rw [Real.mul_rpow (by norm_num : (0 : ℝ) ≤ 2) hTp.le] at hp
          dsimp [G,A]
          calc
            _ ≤ A₀*(2^ρ*T^ρ) := mul_le_mul_of_nonneg_left hp hA₀.le
            _ ≤ _ := by nlinarith [Real.rpow_nonneg hTp.le ρ]
        simpa only [a,norm_div,Complex.norm_real,Real.norm_eq_abs,abs_of_pos hGp] using
          (div_le_one hGp).mpr hnorm
      have haEval (i : ι) :
          finiteDirichletSeries (dyadicInterval (N j)) a ((β i : ℂ)+(t i : ℂ)*I) =
            P j i/(G : ℂ) := by
        dsimp only [P, finiteDirichletSeries]
        rw [Finset.sum_div]
        apply sum_congr rfl
        intro n hn
        dsimp [a]
        ring
      have hQ := hcount σ T L (N j) a hσL hσU hT1' hN hL hL1 hLlo hNlo hNhi hN2 ha
        (Q j) t β
        (fun i hi => ht i (mem_filter.mp hi).1)
        (fun i hi => hβ i (mem_filter.mp hi).1)
        (fun i hi l hl hn => hs i (mem_filter.mp hi).1 l (mem_filter.mp hl).1 hn)
        (fun i hi => by
          rw [haEval, norm_div, Complex.norm_real, Real.norm_eq_abs,abs_of_pos hGp]
          have hh := div_le_div_of_nonneg_right (mem_filter.mp hi).2 hGp.le
          convert hh using 1
          dsimp [L]
          ring)
      apply hQ.trans_eq
      dsimp [L]
      rw [div_pow, one_pow, div_div_eq_mul_div, div_one,
        show 16*(J : ℝ)*G = (16*G)*(J : ℝ) by ring, mul_pow]
      ac_rfl
    · have hzero (i : ι) : P j i = 0 := by
        unfold P finiteDirichletSeries
        apply sum_eq_zero
        intro n hn
        have hn' : N j < n := (Finset.mem_Ioc.mp hn).1
        have hYn : Y ≤ n := (le_of_not_ge hNhi).trans (by exact_mod_cast hn'.le)
        dsimp only [coeff]
        rw [Detector.Smooth.polynomialCoefficient_above X n Y (by linarith) hYn, zero_mul]
      have hE : Q j = ∅ := by
        apply Finset.eq_empty_iff_forall_notMem.mpr
        intro i hi
        have h := (mem_filter.mp hi).2
        rw [hzero i,norm_zero] at h
        have hp : 0 < (1 : ℝ)/(16*(J : ℝ)) := by positivity
        linarith
      rw [hE,Finset.card_empty,Nat.cast_zero]
      positivity
  have hs := hCard.trans (sum_le_sum hblock)
  simp only [sum_const,card_range,nsmul_eq_mul] at hs
  have hBudget : 804*ρ+ε/3+ε/3 ≤ ε := by linarith
  have hJpow : (J : ℝ)^805 ≤ B^805*(D*T^(ε/3)) := by
    calc
      _ ≤ (B*(1+Real.log T))^805 := pow_le_pow_left₀ (by positivity) hJLog _
      _ = B^805 * (1+Real.log T)^805 := mul_pow _ _ _
      _ ≤ _ := mul_le_mul_of_nonneg_left (hlog T hT2) (by positivity)
  have hGpow : (16*G)^804 = (16*A)^804*T^(804*ρ) := by
    have hpow : (T^ρ)^804 = T^(804*ρ) := by
      rw [← Real.rpow_natCast (T^ρ) 804, ← Real.rpow_mul hTp.le]
      congr 1
      push_cast
      ring
    dsimp only [G]
    rw [← mul_assoc, mul_pow, hpow]
  let P₁ := (16*A)^804
  let B₁ := B^805
  have hScale : T^(804*ρ)*(T^(ε/3)*T^(final_exponent σ+ε/3)) ≤
      T^(final_exponent σ+ε) := by
    rw [← Real.rpow_add hTp, ← Real.rpow_add hTp]
    exact Real.rpow_le_rpow_of_exponent_le hTone (by linarith only [hBudget])
  change (S.card : ℝ) ≤ C*P₁*B₁*D*T^(final_exponent σ+ε)
  have hP1 : 0 ≤ P₁ := by dsimp only [P₁]; positivity
  have hB1 : 0 ≤ B₁ := by dsimp only [B₁]; positivity
  calc
    _ ≤ (J : ℝ)*(C*(16*G)^804*(J : ℝ)^804*T^(final_exponent σ+ε/3)) := hs
    _ = (C*P₁*T^(804*ρ)*T^(final_exponent σ+ε/3))*((J : ℝ)*(J : ℝ)^804) := by
      rw [hGpow]
      change (J : ℝ)*(C*(P₁*T^(804*ρ))*(J : ℝ)^804*T^(final_exponent σ+ε/3)) = _
      ac_rfl
    _ = (C*P₁*T^(804*ρ)*T^(final_exponent σ+ε/3))*(J : ℝ)^805 := by
      rw [← pow_succ']
    _ ≤ (C*P₁*T^(804*ρ)*T^(final_exponent σ+ε/3))*(B₁*(D*T^(ε/3))) :=
      mul_le_mul_of_nonneg_left hJpow (by positivity)
    _ = (C*P₁*B₁*D)*(T^(804*ρ)*(T^(ε/3)*T^(final_exponent σ+ε/3))) := by ac_rfl
    _ ≤ _ := mul_le_mul_of_nonneg_left hScale (by positivity)

end Legendre.Density.GuthMaynard
