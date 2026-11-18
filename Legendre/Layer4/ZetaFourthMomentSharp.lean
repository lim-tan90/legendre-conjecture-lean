/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.XiSharpHeadMean
public import Legendre.Layer4.ZetaFourthMoment
public import Legendre.Layer4.DyadicHeightDensity
public import Legendre.Layer4.XiPartialMean

/-! The fourth-log bound for the critical-line fourth moment. -/

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set
open Density Density.Moment

/-- Fourth-log mean on a height shell, uniformly in the finite truncation. -/
theorem xiFiniteSquare_shell_log_four :
    ∃ C : ℝ, 0 < C ∧ ∀ N : ℕ, 1 ≤ N → ∀ T : ℝ,
      1 ≤ T → 1 ≤ Real.log N → 10*T ≤ N → (N : ℝ) ≤ 16*T → ∀ J : ℕ,
      (∫ t in Icc (T/2) T, ‖∑ n ∈ Finset.Icc 1 (2^J*N),
        xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2) ≤
          C*((N : ℝ)+T)*(Real.log N)^4 := by
  obtain ⟨CH,hCH,hhead⟩ := xiFiniteSquare_head_log_four
  obtain ⟨CT,hCT,htail⟩ := xiFiniteSquare_tail_assembly
  refine ⟨2*CH+16*CT, by positivity, ?_⟩
  intro N hN T hT hL hscale hupper J
  have hlog : (1+Real.log N)^3 ≤ 8*(Real.log N)^4 := by
    have hlo : 0 ≤ Real.log N := by linarith
    have h := pow_le_pow_left₀ (by linarith : 0 ≤ 1+Real.log N)
      (by linarith : 1+Real.log N ≤ 2*Real.log N) 3
    nlinarith [mul_nonneg (show 0 ≤ Real.log N-1 by linarith)
      (show 0 ≤ (Real.log N)^3 by positivity)]
  calc
    _ ≤ _ := xiFiniteSquare_partial_le_head_tail N J hN (T/2) T hT (by linarith)
    _ ≤ 2*(CH*((N : ℝ)+T)*(Real.log N)^4)+
        2*(CT*((N : ℝ)+T)*(1+Real.log N)^3) :=
      add_le_add (mul_le_mul_of_nonneg_left (hhead N T hT hL hscale hupper) (by norm_num))
        (mul_le_mul_of_nonneg_left (htail N hN T hT hscale J) (by norm_num))
    _ ≤ _ := by
      have hb := mul_le_mul_of_nonneg_left hlog
        (show 0 ≤ 2*CT*((N : ℝ)+T) by positivity)
      nlinarith

/-- The fourth moment has the sharp fourth logarithmic power on each dyadic shell. -/
theorem zeta_fourth_moment_shell_log_four :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (∫ t : ℝ in T/2..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^4 := by
  obtain ⟨C,hC,hb⟩ := xiFiniteSquare_shell_log_four
  refine ⟨4*C*17*5^4, by positivity, ?_⟩
  intro T hT
  obtain ⟨N,hN,hL,hscale,hsize,hlog⟩ := moment_cutoff 1 (by norm_num) T hT
  norm_num only [Nat.cast_one,one_mul,one_pow] at hscale hsize hlog
  have hT₀ : 1 ≤ T := by linarith
  have hupper : (N : ℝ) ≤ 16*T := by linarith
  have hsub : Icc (T/2) T ⊆ Icc (-T) T := fun t ht => ⟨by linarith [ht.1],ht.2⟩
  let g := fun J : ℕ => fun t : ℝ => ‖∑ n ∈ Finset.Icc 1 (2^J*N),
    xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2
  let f := fun t : ℝ => ‖xiSmoothedZetaSquare ((1/2 : ℂ)+(t : ℂ)*I)‖^2
  have hg (J : ℕ) : IntegrableOn (g J) (Icc (T/2) T) :=
    IntegrableOn.mono_set
      ((xiFiniteSquare_continuousOn _ (fun n hn => (Finset.mem_Icc.mp hn).1) T hT₀).norm.pow 2).integrableOn_Icc hsub
  obtain ⟨hi,hm⟩ := moment_integral_limit_bound g f (volume.restrict (Icc (T/2) T))
    (C*((N : ℝ)+T)*(Real.log N)^4) (by positivity) hg (fun _ _ => sq_nonneg _)
    (fun t => ((xiSquare_partial_limit N hN t).norm).pow 2) (hb N hN T hT₀ hL hscale hupper)
  rw [intervalIntegral.integral_of_le (by linarith : T/2 ≤ T), ← integral_Icc_eq_integral_Ioc]
  have hfirst : (∫ t in Icc (T/2) T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
      4*(∫ t in Icc (T/2) T, f t) := by
    rw [← integral_const_mul]
    apply integral_mono (IntegrableOn.mono_set (zeta_critical_fourth_integrable T) hsub) (hi.const_mul 4)
    intro t
    exact riemannZeta_fourth_le_smoothed _ (by simp)
  have hlog0 : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  calc
    _ ≤ 4*(C*((N : ℝ)+T)*(Real.log N)^4) :=
      hfirst.trans (mul_le_mul_of_nonneg_left hm (by norm_num))
    _ ≤ 4*(C*(17*T)*(5*Real.log T)^4) := by
      apply mul_le_mul_of_nonneg_left _ (by norm_num)
      apply mul_le_mul _ (pow_le_pow_left₀ (by linarith) hlog 4) (by positivity) (by positivity)
      exact mul_le_mul_of_nonneg_left hsize hC.le
    _ = _ := by ring

/-- The sharp logarithmic upper bound for the fourth moment on `[0,T]`. -/
theorem zeta_fourth_moment_log_four :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^4 := by
  obtain ⟨C,hC,hb⟩ := zeta_fourth_moment_shell_log_four
  let f := fun t : ℝ => ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4
  let D := (|∫ t : ℝ in 0..1, f t|+1)/(Real.log 2)^4+2*C
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hD : 0 < D := by dsimp only [D]; positivity
  have hDC : 2*C ≤ D := by
    have h : 0 ≤ (|∫ t : ℝ in 0..1, f t|+1)/(Real.log 2)^4 := by positivity
    dsimp only [D]
    linarith
  have hint (a b : ℝ) (ha : 0 ≤ a) (hab : a ≤ b) : IntervalIntegrable f volume a b := by
    apply (intervalIntegrable_iff_integrableOn_Ioc_of_le hab).mpr
    exact IntegrableOn.mono_set (zeta_critical_fourth_integrable b)
      (fun t ht => ⟨by linarith [ht.1],ht.2⟩)
  have hdyadic (j : ℕ) : (∫ t : ℝ in 0..(2 : ℝ)^j, f t) ≤
      D*2^j*(Real.log (2*2^j))^4 := by
    induction j with
    | zero =>
      simp only [pow_zero, mul_one]
      dsimp only [D]
      rw [add_mul, div_mul_cancel₀ _ (pow_ne_zero _ hlog2.ne')]
      have h0 : 0 ≤ 2*C*(Real.log 2)^4 := by positivity
      linarith [le_abs_self (∫ t : ℝ in 0..1, f t)]
    | succ j ih =>
      let P := (2 : ℝ)^j
      have hP : 1 ≤ P := one_le_pow₀ (by norm_num)
      have hP₀ : 0 ≤ P := by linarith
      have h2P : 2 ≤ 2*P := by linarith
      have h4P : 0 < 2*(2*P) := by positivity
      have hlog : 0 ≤ Real.log (2*P) := Real.log_nonneg (by linarith)
      have hs := hb (2*P) h2P
      have hs₀ : (∫ t : ℝ in P..2*P, f t) ≤ C*(2*P)*(Real.log (2*P))^4 := by
        change (∫ t : ℝ in 2*P/2..2*P, f t) ≤ _ at hs
        rw [show (2*P)/2 = P by ring] at hs
        exact hs
      rw [pow_succ, mul_comm ((2 : ℝ)^j) 2]
      change (∫ t : ℝ in 0..2*P, f t) ≤ D*(2*P)*(Real.log (2*(2*P)))^4
      rw [← intervalIntegral.integral_add_adjacent_intervals
        (hint 0 P (by norm_num) hP₀) (hint P (2*P) hP₀ (by linarith))]
      calc
        _ ≤ D*P*(Real.log (2*P))^4+C*(2*P)*(Real.log (2*P))^4 :=
          add_le_add ih hs₀
        _ ≤ D*(2*P)*(Real.log (2*P))^4 := by
          nlinarith [mul_nonneg (sub_nonneg.mpr hDC)
            (show 0 ≤ P*(Real.log (2*P))^4 by positivity)]
        _ ≤ _ := by
          apply mul_le_mul_of_nonneg_left _ (by positivity)
          exact pow_le_pow_left₀ hlog (Real.log_le_log (by positivity) (by linarith)) 4
  refine ⟨2*D*3^4, by positivity, ?_⟩
  intro T hT
  obtain ⟨J,hJlo,hJhi,_⟩ := real_height_dyadic_cover T hT
  let P := (2 : ℝ)^J
  have hT₀ : 0 ≤ T := by linarith
  have hP₀ : 0 ≤ P := by positivity
  have hmono : (∫ t : ℝ in 0..T, f t) ≤ ∫ t : ℝ in 0..P, f t := by
    rw [intervalIntegral.integral_of_le hT₀, intervalIntegral.integral_of_le hP₀]
    exact setIntegral_mono_set (IntegrableOn.mono_set (zeta_critical_fourth_integrable P)
      (show Ioc 0 P ⊆ Icc (-P) P from fun t ht => ⟨by linarith [ht.1],ht.2⟩))
      (Filter.Eventually.of_forall fun _ => by dsimp only [f]; positivity)
      (Filter.Eventually.of_forall fun t ht => ⟨ht.1,ht.2.trans hJlo⟩)
  have hlogbound : Real.log (2*P) ≤ 3*Real.log T := by
    have h := Real.log_le_log (by positivity : 0 < 2*P)
      (show 2*P ≤ 4*T by linarith)
    have h4 : Real.log 4 = 2*Real.log 2 := by
      have hpow4 := Real.log_pow (2 : ℝ) 2
      norm_num at hpow4
      exact hpow4
    rw [Real.log_mul (by norm_num) (by linarith : T ≠ 0), h4] at h
    linarith [Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT]
  change (∫ t : ℝ in 0..T, f t) ≤ _
  calc
    _ ≤ D*P*(Real.log (2*P))^4 := hmono.trans (hdyadic J)
    _ ≤ D*(2*T)*(3*Real.log T)^4 := by
      apply mul_le_mul (mul_le_mul_of_nonneg_left hJhi hD.le)
        (pow_le_pow_left₀ (Real.log_nonneg (by change (1 : ℝ) ≤ 2*(2 : ℝ)^J; linarith [hJlo]))
          hlogbound 4) (by positivity) (by positivity)
    _ = _ := by ring

/-- The critical-line fourth power is even, so the symmetric interval
has the same logarithmic bound. -/
theorem zeta_fourth_moment_symmetric_log_four :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (∫ t in Icc (-T) T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^4 := by
  obtain ⟨C,hC,hb⟩ := zeta_fourth_moment_log_four
  refine ⟨2*C, by positivity, ?_⟩
  intro T hT
  let f := fun t : ℝ => ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4
  have hsym (t : ℝ) : f (-t) = f t := by
    have hc : (1/2 : ℂ)+((-t : ℝ) : ℂ)*I =
        star ((1/2 : ℂ)+(t : ℂ)*I) := by simp
    rw [Complex.star_def] at hc
    simp only [f, hc, riemannZeta_conj, Complex.norm_conj]
  have h0 : 0 ≤ T := by linarith
  have hInt (a b : ℝ) (ha : -T ≤ a) (hab : a ≤ b) (hb : b ≤ T) :
      IntervalIntegrable f volume a b := by
    apply (intervalIntegrable_iff_integrableOn_Ioc_of_le hab).mpr
    exact IntegrableOn.mono_set (zeta_critical_fourth_integrable T)
      (fun t ht => ⟨ha.trans ht.1.le,ht.2.trans hb⟩)
  have he : (∫ t : ℝ in -T..0, f t) = ∫ t : ℝ in 0..T, f t := by
    have h := intervalIntegral.integral_comp_neg (a := (0 : ℝ)) (b := T) (f := f)
    simpa only [hsym, neg_zero] using h.symm
  change (∫ t in Icc (-T) T, f t) ≤ _
  rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le (by linarith : -T ≤ T),
    ← intervalIntegral.integral_add_adjacent_intervals (hInt (-T) 0 le_rfl (by linarith) h0)
      (hInt 0 T (by linarith) h0 le_rfl), he]
  have h := hb T hT
  change (∫ t in 0..T, f t) ≤ _ at h
  linarith

end Legendre.Zeta
