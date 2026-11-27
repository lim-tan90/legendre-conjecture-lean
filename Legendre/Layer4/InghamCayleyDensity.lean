/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.MollifiedZetaBalancedMoment
public import Legendre.Layer4.MollifiedZetaCayley
public import Legendre.Layer4.InghamShrinkingStrip

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set Density.Moment Density.Detector

private theorem two_thirds_window_padding :
    ∃ T₀ : ℝ, 16 ≤ T₀ ∧ Real.exp 7 ≤ T₀ ∧
      ∀ T : ℝ, T₀ ≤ T → 1+64*Real.log T ≤ T^(2/3 : ℝ)/8 := by
  obtain ⟨D,hD,hlog⟩ := exists_log_pow_le_rpow 1 (show (0 : ℝ) < 1/3 by norm_num)
  let K := 8*(1+64*D)
  have hK : 0 < K := by dsimp [K]; positivity
  refine ⟨max (max 16 (Real.exp 7)) (K^3),
    le_trans (le_max_left _ _) (le_max_left _ _),
    le_trans (le_max_right _ _) (le_max_left _ _), ?_⟩
  intro T hT
  have hT₂ : 2 ≤ T := by linarith [le_trans (le_trans (le_max_left (16 : ℝ) (Real.exp 7))
    (le_max_left _ (K^3))) hT]
  have hT₁ : 1 ≤ T := by linarith only [hT₂]
  have hT₀ : 0 ≤ T := by linarith
  let R := T^(1/3 : ℝ)
  have hR : 1 ≤ R := Real.one_le_rpow hT₁ (by norm_num)
  have hKR : K ≤ R := by
    have hh := Real.rpow_le_rpow (pow_nonneg hK.le 3) ((le_max_right _ _).trans hT)
      (show (0 : ℝ) ≤ 1/3 by norm_num)
    rw [← Real.rpow_natCast_mul hK.le, Nat.cast_ofNat, show (3 : ℝ)*(1/3 : ℝ) = 1 by norm_num,
      Real.rpow_one] at hh
    exact hh
  have htt : R^2 = T^(2/3 : ℝ) := by
    dsimp only [R]
    rw [← Real.rpow_mul_natCast hT₀, Nat.cast_ofNat]
    congr 1
    ring
  have hl : Real.log T ≤ D*R := by simpa only [pow_one] using hlog T hT₂
  have hh := mul_le_mul_of_nonneg_right hKR (show 0 ≤ R by linarith)
  rw [← htt]
  dsimp only [K] at hh
  nlinarith

private theorem two_thirds_double_le (T : ℝ) (hT : 0 ≤ T) :
    (1/2 : ℝ)*(2*T)^(2/3 : ℝ) ≤ 7/8*T^(2/3 : ℝ) := by
  have htwo : (2 : ℝ)^(2/3 : ℝ) ≤ 7/4 := by
    apply le_of_pow_le_pow_left₀ (show (3 : ℕ) ≠ 0 by norm_num) (by positivity)
    rw [← Real.rpow_mul_natCast (by norm_num : (0 : ℝ) ≤ 2), Nat.cast_ofNat,
      show (2/3 : ℝ)*3 = 2 by norm_num, Real.rpow_two]
    norm_num
  rw [Real.mul_rpow (by norm_num) hT]
  calc
    _ ≤ (1/2 : ℝ)*((7/4 : ℝ)*T^(2/3 : ℝ)) :=
      mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_right htwo (by positivity)) (by norm_num)
    _ = _ := by ring

/-- The Cayley count between heights (T^(2/3)) and T carries a fifth power
of the logarithm and the linear near-one exponent (3(1-sigma)). -/
theorem ingham_cayley_log_five_increment :
    ∃ C T₀ : ℝ, 0 < C ∧ 16 ≤ T₀ ∧ Real.exp 7 ≤ T₀ ∧ ∀ T : ℝ, T₀ ≤ T →
      ∀ σ ∈ Icc (9/10 : ℝ) 1,
      (zeroDensityCount σ T : ℝ) ≤ (zeroDensityCount σ (T^(2/3 : ℝ)) : ℝ) +
        C*T^(3*(1-σ))*(Real.log T)^5 := by
  obtain ⟨T₀,hT₀,hTe,hpadding⟩ := two_thirds_window_padding
  obtain ⟨P,hP,hp⟩ := mollifiedError_two_thirds_window_log_four
  refine ⟨4*(32*P*Real.exp 3+216),T₀,by positivity,hT₀,hTe,?_⟩
  intro T hT σ hσ
  let L := Real.log T
  let U := T^(2/3 : ℝ)
  let ε := L⁻¹
  let a := σ-ε
  let W := T^(3*(1-σ))
  have hT₁ : 1 ≤ T := by linarith [hT₀.trans hT]
  have hTpos : 0 < T := by linarith
  have hU₀ : 0 < U := by dsimp [U]; positivity
  have hUT : U ≤ T := by
    simpa only [Real.rpow_one] using
      Real.rpow_le_rpow_of_exponent_le hT₁ (by norm_num : (2/3 : ℝ) ≤ 1)
  have hL₁ : 1 ≤ L := by
    have hh := Real.log_le_log (Real.exp_pos 7) (hTe.trans hT)
    rw [Real.log_exp] at hh
    exact (by norm_num : (1 : ℝ) ≤ 7).trans hh
  have hL₀ : 0 < L := by linarith
  have hε : 0 < ε := inv_pos.mpr hL₀
  have hε₁ : ε ≤ 1 := inv_le_one_of_one_le₀ hL₁
  have hpad := hpadding T hT
  change 1+64*L ≤ U/8 at hpad
  have hLlarge : 20/3 ≤ L := by
    have hh := Real.log_le_log (Real.exp_pos 7) (hTe.trans hT)
    rw [Real.log_exp] at hh
    exact (by norm_num : (20/3 : ℝ) ≤ 7).trans hh
  have hεsmall : ε ≤ 3/20 := by
    change L⁻¹ ≤ _
    rw [← one_div]
    apply (div_le_iff₀ hL₀).2
    nlinarith
  have ha : 3/4 ≤ a := by dsimp [a]; linarith [hσ.1]
  have ha₁ : a ≤ 1 := by dsimp [a]; linarith [hσ.2]
  have hεH : 64/ε = 64*L := by simp [ε, div_eq_mul_inv]
  have hU : 64/ε < U-1 := by rw [hεH]; linarith
  obtain ⟨X,hX,hTX,hXT,hb⟩ := hp (2*T) (by linarith [hT₀.trans hT])
  let M := P*((2*T)^(3*(1-a))*(Real.log (2*T))^4)
  have hM (b : ℝ) (hh : b ∈ Icc a (4+64/ε)) :
      (∫ t in Icc (U-1-64/ε) (T+1+64/ε), ‖mollifiedError X ((b : ℂ)+(t : ℂ)*I)‖^2) ≤ M := by
    have hStart : (1/2 : ℝ)*(2*T)^(2/3 : ℝ) ≤ U-1-64/ε := by
      have hh := two_thirds_double_le T hTpos.le
      change _ ≤ 7/8*U at hh
      rw [hεH]
      linarith
    have hEnd : T+1+64/ε ≤ 2*T := by rw [hεH]; linarith
    have hi := integrableOn_mollifiedError_vertical X b
      (A := (1/2 : ℝ)*(2*T)^(2/3 : ℝ)) (B := 2*T) (by positivity)
    exact (setIntegral_mono_set hi (Filter.Eventually.of_forall (fun _ => sq_nonneg _))
      (Icc_subset_Icc hStart hEnd).eventuallySubset).trans (hb a b ha ha₁ hh.1)
  have hN := zeroDensityCount_le_cayley_vertical X hX ha ha₁ hε hε₁ hU hUT hM
  rw [show a+ε = σ by dsimp [a]; ring] at hN
  have hw : 1 ≤ W := Real.one_le_rpow hT₁ (by linarith [hσ.2])
  have hshift : T^(3*ε) = Real.exp 3 := by
    rw [Real.rpow_def_of_pos hTpos]
    change Real.exp (L*(3*L⁻¹)) = _
    congr 1
    field_simp
  have hpow : (2*T)^(3*(1-a)) ≤ 2*(W*Real.exp 3) := by
    rw [Real.mul_rpow (by norm_num) hTpos.le,
      show 3*(1-a) = 3*(1-σ)+3*ε by dsimp [a]; ring, Real.rpow_add hTpos, hshift]
    apply mul_le_mul_of_nonneg_right _ (by positivity)
    rw [show 3*(1-σ)+3*ε = 3*(1-a) by dsimp [a]; ring]
    simpa only [Real.rpow_one] using
      Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2)
        (show 3*(1-a) ≤ 1 by linarith)
  have hlog : Real.log (2*T) ≤ 2*L := by
    rw [Real.log_mul (by norm_num) hTpos.ne']
    have hh := Real.log_le_log (by norm_num : 0 < (2 : ℝ)) (by linarith [hT₀.trans hT] : 2 ≤ T)
    dsimp [L]
    linarith
  have hMbound : M ≤ 32*P*Real.exp 3*(W*L^4) := by
    calc
      _ ≤ P*((2*(W*Real.exp 3))*(2*L)^4) := by
        dsimp only [M]
        exact mul_le_mul_of_nonneg_left
          (mul_le_mul hpow (pow_le_pow_left₀ (Real.log_nonneg (by linarith)) hlog 4)
            (by positivity) (by positivity)) hP.le
      _ = _ := by ring
  have hD : 9/(X : ℝ) ≤ 9/T := div_le_div_of_nonneg_left (by norm_num) hTpos (by linarith)
  have hcenter : (4/3 : ℝ)*(T-U+2)*(9/(X : ℝ))^2 ≤ 216 := by
    calc
      _ ≤ (4/3 : ℝ)*(2*T)*(9/T)^2 := by
        apply mul_le_mul
        · linarith [hT₀.trans hT]
        · exact pow_le_pow_left₀ (by positivity) hD 2
        · positivity
        · positivity
      _ = 216/T := by field_simp; ring
      _ ≤ _ := (div_le_iff₀ hTpos).2 (by linarith)
  have hunit : 1 ≤ W*L^4 := one_le_mul_of_one_le_of_one_le hw (one_le_pow₀ hL₁)
  have hB := add_le_add hMbound (hcenter.trans (show (216 : ℝ) ≤ 216*(W*L^4) by linarith))
  refine hN.trans (add_le_add_right ?_ _)
  apply (div_le_iff₀ (by positivity : 0 < ε/4)).2
  apply hB.trans_eq
  dsimp only [W, ε]
  field_simp
  ring

private theorem log_one_add_le_two_sqrt {x : ℝ} (hx : 0 ≤ x) :
    Real.log (1+x) ≤ 2*√x := by
  have hpos : 0 < 1+x := by linarith
  have hs : 0 < √(1+x) := Real.sqrt_pos.2 hpos
  have hpow : Real.log (1+x) = 2*Real.log (√(1+x)) := by
    rw [← Real.log_rpow hs]
    rw [Real.rpow_two, Real.sq_sqrt hpos.le]
  have hroot : √(1+x) ≤ 1+√x := by
    apply le_of_pow_le_pow_left₀ (by norm_num : (2 : ℕ) ≠ 0) (by positivity)
    rw [Real.sq_sqrt hpos.le]
    nlinarith only [Real.sq_sqrt hx, Real.sqrt_nonneg x]
  rw [hpow]
  linarith only [Real.log_le_sub_one_of_pos hs, hroot]

/-- Above a fixed height, the increment from its two-thirds power has
the exact Ingham exponent uniformly throughout the density strip. -/
theorem ingham_density_log_five_increment :
    ∃ C T₀ : ℝ, 0 < C ∧ 16 ≤ T₀ ∧ Real.exp 7 ≤ T₀ ∧ ∀ T : ℝ, T₀ ≤ T →
      ∀ σ ∈ Icc (1/2 : ℝ) 1,
      (zeroDensityCount σ T : ℝ) ≤ (zeroDensityCount σ (T^(2/3 : ℝ)) : ℝ) +
        C*T^balancedDensityExponent σ*(Real.log T)^5 := by
  obtain ⟨P,T₀,hP,hT₀,hTe,hstep⟩ := ingham_cayley_log_five_increment
  obtain ⟨Q,hQ,hknown⟩ := ingham_density_log_five_shrinking_strip
  let D := Real.exp (3*(110 : ℝ)^2)
  let C := Q+P*D
  refine ⟨C,T₀,by dsimp [C,D]; positivity,hT₀,hTe,?_⟩
  intro T hT σ hσ
  let L := Real.log T
  let δ := 1-σ
  let E := balancedDensityExponent σ
  have hT₂ : 2 ≤ T := by linarith only [hT₀,hT]
  have hTp : 0 < T := by linarith only [hT₂]
  have hL : 0 < L := Real.log_pos (by linarith only [hT₂])
  have hδ : 0 ≤ δ := by dsimp [δ]; linarith only [hσ.2]
  change _ ≤ _+C*T^E*L^5
  by_cases hrange : σ ≤ 9/10 ∨ 55*Real.log (1+L) ≤ δ*L ∨ δ*L ≤ 1/4000000
  · have hb := hknown σ hσ T hT₂ hrange
    have hQC : Q ≤ C := le_add_of_nonneg_right (by dsimp [D]; positivity)
    exact hb.trans ((mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hQC (by positivity))
      (by positivity)).trans (le_add_of_nonneg_left (Nat.cast_nonneg _)))
  · push Not at hrange
    have hlinear := hstep T hT σ ⟨hrange.1.le,hσ.2⟩
    have hsmall : δ*L ≤ 110*√L := hrange.2.1.le.trans (by
      linarith only [log_one_add_le_two_sqrt hL.le])
    have hδL : δ^2*L ≤ 110^2 := by
      have hsq := pow_le_pow_left₀ (mul_nonneg hδ hL.le) hsmall 2
      rw [mul_pow, mul_pow, Real.sq_sqrt hL.le] at hsq
      exact le_of_mul_le_mul_right (by
        calc
          δ^2*L*L = δ^2*L^2 := by ring
          _ ≤ _ := hsq) hL
    have hgap : 3*δ-E = 3*δ^2/(2-σ) := by
      dsimp [δ,E,balancedDensityExponent]
      field_simp [show 2-σ ≠ 0 by linarith only [hσ.2]]
      ring
    have hdif : 3*δ-E ≤ 3*δ^2 := by
      rw [hgap]
      exact div_le_self (by positivity) (by linarith only [hσ.2])
    have hfac : T^(3*δ-E) ≤ D := by
      rw [Real.rpow_def_of_pos hTp]
      dsimp only [D]
      apply Real.exp_le_exp.mpr
      have h := mul_le_mul_of_nonneg_left hdif hL.le
      change L*(3*δ-E) ≤ _
      nlinarith only [h,hδL]
    have hmul : T^(3*δ) = T^E*T^(3*δ-E) := by
      rw [← Real.rpow_add hTp]
      congr 1
      ring
    apply hlinear.trans
    apply add_le_add_right
    change P*T^(3*δ)*L^5 ≤ C*T^E*L^5
    rw [hmul]
    apply mul_le_mul_of_nonneg_right _ (by positivity)
    calc
      _ ≤ P*(T^E*D) :=
        mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hfac (by positivity)) hP.le
      _ = (P*D)*T^E := by ring
      _ ≤ C*T^E := mul_le_mul_of_nonneg_right (le_add_of_nonneg_left hQ.le) (by positivity)

/-- Ingham's uniform zero-density theorem with the exact height exponent
and fifth logarithmic power, for zeta zeros counted with analytic multiplicity. -/
theorem ingham_density_log_five :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (1/2 : ℝ) 1, ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^5 := by
  obtain ⟨P,T₀,hP,hT₀,hTe,hstep⟩ := ingham_density_log_five_increment
  let B := ((zeroCount T₀ : ℝ)+1)*(Real.log 2)⁻¹^5
  let C := 2*P+B
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hB : 0 < B := by dsimp [B]; positivity
  have hC : 0 < C := by dsimp [C]; positivity
  refine ⟨C,hC,?_⟩
  intro σ hσ
  let E := balancedDensityExponent σ
  have hE : 0 ≤ E := balancedDensityExponent_nonneg σ hσ.2
  have hall (n : ℕ) (T : ℝ) (hT : 2 ≤ T) (hn : ⌊Real.log T⌋₊ = n) :
      (zeroDensityCount σ T : ℝ) ≤ C*T^E*(Real.log T)^5 := by
    induction n using Nat.strong_induction_on generalizing T with
    | h n ih =>
      have hTp : 0 < T := by linarith only [hT]
      have hL : 0 ≤ Real.log T := Real.log_nonneg (by linarith only [hT])
      by_cases ht : T₀ ≤ T
      · let U := T^(2/3 : ℝ)
        have hU₀ : 0 < U := by dsimp [U]; positivity
        have hLu : Real.log U = (2/3)*Real.log T := Real.log_rpow hTp _
        have hL7 : 7 ≤ Real.log T := by
          simpa only [Real.log_exp] using Real.log_le_log (Real.exp_pos 7) (hTe.trans ht)
        have hU : 2 ≤ U := by
          apply (Real.log_le_log_iff (by norm_num : (0 : ℝ) < 2) hU₀).1
          rw [hLu]
          linarith only [Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2), hL7]
        have hUT : U ≤ T := by
          simpa only [U, Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le
            (show 1 ≤ T by linarith only [hT]) (by norm_num : (2/3 : ℝ) ≤ 1)
        have hfloor : ⌊Real.log U⌋₊ < n := by
          apply (Nat.floor_lt (Real.log_nonneg (by linarith only [hU]))).2
          have h := Nat.lt_floor_add_one (Real.log T)
          rw [hn] at h
          rw [hLu]
          linarith only [h,hL7]
        have hpw := Real.rpow_le_rpow hU₀.le hUT hE
        have hUbound := ih _ hfloor U hU rfl
        have hupper : (zeroDensityCount σ U : ℝ) ≤ (1/2 : ℝ)*C*T^E*(Real.log T)^5 := by
          apply hUbound.trans
          rw [hLu,mul_pow]
          have ha := mul_le_mul_of_nonneg_left hpw hC.le
          calc
            _ ≤ (C*T^E)*(((2/3 : ℝ)^5)*(Real.log T)^5) :=
              mul_le_mul_of_nonneg_right ha (by positivity)
            _ = ((2/3 : ℝ)^5)*(C*T^E*(Real.log T)^5) := by ring
            _ ≤ (1/2 : ℝ)*C*T^E*(Real.log T)^5 := by
              rw [mul_assoc (1/2 : ℝ), mul_assoc (1/2 : ℝ)]
              exact mul_le_mul_of_nonneg_right (by norm_num) (by positivity)
        have hc : P+C/2 ≤ C := by dsimp only [C]; linarith only [hB]
        calc
          _ ≤ (zeroDensityCount σ U : ℝ)+P*T^E*(Real.log T)^5 := hstep T ht σ hσ
          _ ≤ (1/2 : ℝ)*C*T^E*(Real.log T)^5+P*T^E*(Real.log T)^5 :=
            add_le_add_left hupper _
          _ = (P+C/2)*T^E*(Real.log T)^5 := by ring
          _ ≤ _ := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hc (by positivity)) (by positivity)
      · have hcount := (zeroDensityCount_le σ T).trans (zeroCount_mono (le_of_not_ge ht))
        have hbase := height_log_unit 5 T σ hT hσ.2
        calc
          _ ≤ (zeroCount T₀ : ℝ) := by exact_mod_cast hcount
          _ ≤ B*T^E*(Real.log T)^5 := by
            have h := mul_le_mul_of_nonneg_left hbase (show 0 ≤ (zeroCount T₀ : ℝ)+1 by positivity)
            dsimp only [B,E]
            nlinarith only [h]
          _ ≤ _ := by
            exact mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right
              (show B ≤ C by dsimp only [C]; linarith only [hP]) (by positivity)) (by positivity)
  intro T hT
  exact hall _ T hT rfl

end Legendre.Zeta
