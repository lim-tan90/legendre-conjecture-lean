/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.FourthMomentApproximation
public import Legendre.Layer4.FourthMoment.DivisorEnergyLower

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set Density Density.Moment Filter

private theorem norm_weighted_pairing_sq_le {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) :
    ‖∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*f x^2*star (g x)‖^2 ≤
      (∫ x : ℝ in 1..2, ‖f x‖^4)*(∫ x : ℝ in 1..2, ‖g x‖^2) := by
  have hab : (1 : ℝ) ≤ 2 := by norm_num
  let μ := volume.restrict (Icc (1 : ℝ) 2)
  let p := fun x : ℝ => ‖f x‖^2
  let q := fun x : ℝ => ‖g x‖
  have hp : Continuous p := hf.norm.pow 2
  have hq : Continuous q := hg.norm
  have hp₂ : MemLp p 2 μ := (memLp_two_iff_integrable_sq hp.aestronglyMeasurable).2
    (hp.pow 2).continuousOn.integrableOn_Icc
  have hq₂ : MemLp q 2 μ := (memLp_two_iff_integrable_sq hq.aestronglyMeasurable).2
    (hq.pow 2).continuousOn.integrableOn_Icc
  have hCS := integral_mul_le_Lp_mul_Lq_of_nonneg
    (by norm_num [Real.holderConjugate_iff] : Real.HolderConjugate 2 2)
    (Filter.Eventually.of_forall fun x => show 0 ≤ p x from sq_nonneg _)
    (Filter.Eventually.of_forall fun x => show 0 ≤ q x from norm_nonneg _)
    (by simpa using hp₂ : MemLp p (ENNReal.ofReal 2) μ)
    (by simpa using hq₂ : MemLp q (ENNReal.ofReal 2) μ)
  change (∫ x in Icc (1 : ℝ) 2, p x*q x) ≤
    (∫ x in Icc (1 : ℝ) 2, p x^(2:ℝ))^(1/2:ℝ)*(∫ x in Icc (1 : ℝ) 2, q x^(2:ℝ))^(1/2:ℝ) at hCS
  simp only [← Real.sqrt_eq_rpow,Real.rpow_two,integral_Icc_eq_integral_Ioc,
    ← intervalIntegral.integral_of_le hab] at hCS
  have hpair : ‖∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*f x^2*star (g x)‖ ≤
      ∫ x : ℝ in 1..2, p x*q x := by
    apply (intervalIntegral.norm_integral_le_integral_norm hab).trans
    have hz : Continuous (fun x : ℝ => (fourthMomentWeight x : ℂ)*f x^2*star (g x)) :=
      ((continuous_ofReal.comp continuous_fourthMomentWeight).mul (hf.pow 2)).mul hg.star
    apply intervalIntegral.integral_mono_on hab (hz.norm.intervalIntegrable 1 2)
      ((hp.mul hq).intervalIntegrable 1 2)
    intro x hx
    simp only [norm_mul,norm_pow,norm_star,norm_real,Real.norm_eq_abs,
      abs_of_nonneg (fourthMomentWeight_nonneg x),p,q]
    exact mul_le_mul_of_nonneg_right
      (mul_le_of_le_one_left (sq_nonneg _) (fourthMomentWeight_le_one hx)) (norm_nonneg _)
  have hsq := pow_le_pow_left₀ (norm_nonneg _) (hpair.trans hCS) 2
  rw [mul_pow,Real.sq_sqrt (intervalIntegral.integral_nonneg_of_forall hab fun _ => sq_nonneg _),
    Real.sq_sqrt (intervalIntegral.integral_nonneg_of_forall hab fun _ => sq_nonneg _)] at hsq
  simpa only [p,q,← pow_mul,show (2 : ℕ)*2 = 4 by decide] using hsq

/-- The critical-line fourth moment has a matching four-log lower bound
on every sufficiently high dyadic height interval. -/
theorem zeta_fourth_moment_log_four_lower_dyadic :
    ∃ c T₀ : ℝ, 0 < c ∧ 2 ≤ T₀ ∧ ∀ T : ℝ, T₀ ≤ T →
      c*T*(Real.log T)^4 ≤ ∫ t : ℝ in T..2*T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4 := by
  obtain ⟨C,hC,hApprox⟩ := norm_weighted_zeta_square_sub_euler_pairing_le
  let a : ℝ := 1/(120*32^4)
  have ha : 0 < a := by norm_num [a]
  have hLarge : ∀ᶠ T : ℝ in atTop, max 1 (2*(C+288)/a) ≤ Real.log T :=
    (tendsto_atTop.1 Real.tendsto_log_atTop) _
  obtain ⟨T₀,hT₀⟩ := eventually_atTop.1 hLarge
  refine ⟨(a/2)^2/(16*(1+2*Real.pi)),max 2 T₀,by positivity,le_max_left _ _,?_⟩
  intro T hT
  have hT₂ := (le_max_left 2 T₀).trans hT
  have hT₁ : 1 ≤ T := by linarith only [hT₂]
  have hTp : 0 < T := zero_lt_one.trans_le hT₁
  have hlog := hT₀ T ((le_max_right 2 T₀).trans hT)
  have hlog₁ : 1 ≤ Real.log T := (le_max_left _ _).trans hlog
  have hlogc : 2*(C+288)/a ≤ Real.log T := (le_max_right _ _).trans hlog
  let r := T^(1/32 : ℝ)
  let K := ⌊r⌋₊
  let M := K^4
  let N := ⌈2*T⌉₊
  have hr : 0 ≤ r := by dsimp [r]; positivity
  have hK₁ : 1 ≤ K := (Nat.le_floor_iff hr).2 (by
    simpa [r] using (Real.one_le_rpow hT₁ (show (0 : ℝ) ≤ 1/32 by norm_num)))
  have hM₁ : 1 ≤ M := by dsimp [M]; exact Nat.one_le_pow _ _ hK₁
  have hMr : (M : ℝ) ≤ T^(1/8 : ℝ) := by
    have hh := pow_le_pow_left₀ (Nat.cast_nonneg K) (Nat.floor_le hr) 4
    change (K : ℝ)^4 ≤ r^4 at hh
    rw [show (M : ℝ) = (K : ℝ)^4 by simp [M]]
    apply hh.trans_eq
    dsimp only [r]
    rw [← Real.rpow_mul_natCast hTp.le]
    norm_num
  have hMtwo : (M : ℝ)^2 ≤ T^(1/4 : ℝ) := by
    apply (pow_le_pow_left₀ (Nat.cast_nonneg M) hMr 2).trans_eq
    rw [← Real.rpow_mul_natCast hTp.le]
    norm_num
  have hMfour : (M : ℝ)^4 ≤ T := by
    apply (pow_le_pow_left₀ (Nat.cast_nonneg M) hMr 4).trans
    rw [← Real.rpow_mul_natCast hTp.le,show (1/8 : ℝ)*(4 : ℕ) = 1/2 by norm_num]
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le hT₁
      (show (1/2 : ℝ) ≤ 1 by norm_num)
  have hMT : (M : ℝ) ≤ T := hMr.trans (by
    conv_rhs => rw [← Real.rpow_one T]
    exact Real.rpow_le_rpow_of_exponent_le hT₁ (by norm_num))
  have hNlo : 2*T ≤ (N : ℝ) := Nat.le_ceil _
  have hNhi : (N : ℝ) ≤ 3*T := (Nat.ceil_lt_add_one (by positivity : 0 ≤ 2*T)).le.trans
    (by linarith only [hT₁])
  have hMN : M ≤ N := by exact_mod_cast (hMT.trans (show T ≤ (N : ℝ) by linarith only [hNlo,hTp]))
  let z := fun t : ℝ => riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)
  let e := fun t : ℝ => ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))
  let b := subsetPolynomial (Finset.Icc 1 M) criticalDivisorCoefficient
  let F := fun f : ℝ → ℂ => ∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*f (T*x)^2*star (b (T*x))
  let E := ∑ m ∈ Finset.Icc 1 M, (m.divisors.card : ℝ)^2/m
  have hdiag : a*(Real.log T)^4 ≤ E/30 := by
    have hh := log_le_harmonic_floor r hr
    dsimp only [r] at hh
    rw [Real.log_rpow hTp] at hh
    have he := divisor_square_harmonic_fourth_lower K
    change (harmonic K : ℝ)^4/4 ≤ E at he
    have hpow := pow_le_pow_left₀ (show 0 ≤ (1/32 : ℝ)*Real.log T by
      exact mul_nonneg (by norm_num) (Real.log_nonneg hT₁)) hh 4
    dsimp [a]
    nlinarith only [hpow,he]
  have hE : ‖F e-↑(E/30)‖ ≤ 288 := by
    have hh := norm_weighted_euler_square_sub_divisor_diagonal_le N M hMN hTp
    change ‖F e-↑((1/30 : ℝ)*E)‖ ≤ (24*((M : ℝ)/T)^2)*(4*N)*(M : ℝ)^2 at hh
    rw [show (1/30 : ℝ)*E = E/30 by ring] at hh
    apply hh.trans
    calc
      _ ≤ (24*((M : ℝ)/T)^2)*(4*(3*T))*(M : ℝ)^2 := by gcongr
      _ = 288*((M : ℝ)^4/T) := by field_simp [hTp.ne']; ring
      _ ≤ _ := by
        have h : (M : ℝ)^4/T ≤ 1 := (div_le_iff₀ hTp).2 (by simpa only [one_mul] using hMfour)
        linarith only [h]
  have hZ : ‖F z-↑(E/30)‖ ≤ C+288 := by
    rw [show F z-↑(E/30) = (F z-F e)+(F e-↑(E/30)) by ring]
    exact (norm_add_le _ _).trans (add_le_add (hApprox T hT₂ M hMtwo) hE)
  have hElow : E/30 ≤ ‖F z‖+(C+288) := by
    have hn : 0 ≤ E/30 := (mul_nonneg ha.le (pow_nonneg (by linarith only [hlog₁]) _)).trans hdiag
    have h := abs_norm_sub_norm_le (F z) (↑(E/30) : ℂ)
    rw [norm_real,Real.norm_eq_abs,abs_of_nonneg hn] at h
    have hp := (abs_le.mp (h.trans hZ)).1
    linarith only [hp]
  have hmass : (a/2)*(Real.log T)^4 ≤ ‖F z‖ := by
    have hh : Real.log T ≤ (Real.log T)^4 := by
      simpa only [pow_one] using pow_le_pow_right₀ hlog₁ (show (1 : ℕ) ≤ 4 by decide)
    have hx := (div_le_iff₀ ha).1 (hlogc.trans hh)
    rw [mul_comm ((Real.log T)^4) a] at hx
    have herror : C+288 ≤ a*(Real.log T)^4/2 :=
      (le_div_iff₀ (by norm_num : (0 : ℝ) < 2)).2 (by simpa only [mul_comm (C+288) 2] using hx)
    calc
      _ = a*(Real.log T)^4-a*(Real.log T)^4/2 := by ring
      _ ≤ a*(Real.log T)^4-(C+288) := sub_le_sub_left herror _
      _ ≤ E/30-(C+288) := sub_le_sub_right hdiag _
      _ ≤ _ := (sub_le_iff_le_add).2 hElow
  let A := ∫ x : ℝ in 1..2, ‖z (T*x)‖^4
  let B := ∫ x : ℝ in 1..2, ‖b (T*x)‖^2
  have hAc : 0 ≤ A := intervalIntegral.integral_nonneg_of_forall (by norm_num) (fun _ => by positivity)
  have hTc : Continuous fun x : ℝ => T*x := by fun_prop
  have hCS : ‖F z‖^2 ≤ A*B := norm_weighted_pairing_sq_le
    (zeta_critical_continuous.comp hTc) ((subsetPolynomial_continuous _ _).comp hTc)
  have hB : B ≤ (16*(1+2*Real.pi))*(Real.log T)^4 := by
    apply (integral_scaled_criticalDivisorPolynomial_norm_sq_le M hT₁ hM₁ hMT).trans
    have hp := pow_le_pow_left₀ (show 0 ≤ 1+Real.log T by linarith only [hlog₁])
      (show 1+Real.log T ≤ 2*Real.log T by linarith only [hlog₁]) 4
    have h := mul_le_mul_of_nonneg_left hp (show 0 ≤ 1+2*Real.pi by positivity)
    nlinarith only [h]
  have hpow := pow_le_pow_left₀ (show 0 ≤ (a/2)*(Real.log T)^4 by positivity) hmass 2
  have hbound := hpow.trans (hCS.trans (mul_le_mul_of_nonneg_left hB hAc))
  have hlogpow : 0 < (Real.log T)^4 := pow_pos (by linarith only [hlog₁]) _
  have hA : ((a/2)^2/(16*(1+2*Real.pi)))*(Real.log T)^4 ≤ A := by
    rw [div_mul_eq_mul_div]
    apply (div_le_iff₀ (by positivity : 0 < 16*(1+2*Real.pi))).2
    apply (mul_le_mul_iff_right₀ hlogpow).1
    convert hbound using 1
    · ring
    · ring
  have hScale : T*A = ∫ t : ℝ in T..2*T, ‖z t‖^4 := by
    simpa only [A,smul_eq_mul,mul_one,mul_comm T 2] using
      intervalIntegral.smul_integral_comp_mul_left (a := (1 : ℝ)) (b := (2 : ℝ))
        (fun t => ‖z t‖^4) T
  rw [← hScale]
  convert mul_le_mul_of_nonneg_left hA hTp.le using 1
  ring

/-- The cumulative critical-line fourth moment is bounded below by
a positive constant times (T log^4 T) at all sufficiently large heights. -/
theorem zeta_fourth_moment_log_four_lower :
    ∃ c T₀ : ℝ, 0 < c ∧ 2 ≤ T₀ ∧ ∀ T : ℝ, T₀ ≤ T →
      c*T*(Real.log T)^4 ≤ ∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4 := by
  obtain ⟨c,T₀,hc,hT₀,h⟩ := zeta_fourth_moment_log_four_lower_dyadic
  refine ⟨c/32,2*T₀,by positivity,by linarith only [hT₀],?_⟩
  intro T hT
  have hhalf : T₀ ≤ T/2 := by linarith only [hT]
  have hT₄ : 4 ≤ T := by linarith only [hT,hT₀]
  have ht₂ : 2 ≤ T/2 := by linarith only [hT₄]
  have hlog : (1/2)*Real.log T ≤ Real.log (T/2) := by
    rw [Real.log_div (by linarith only [hT₄] : T ≠ 0) (by norm_num : (2 : ℝ) ≠ 0)]
    have hh := Real.log_le_log (by norm_num : (0 : ℝ) < 2) ht₂
    rw [Real.log_div (by linarith only [hT₄] : T ≠ 0) (by norm_num : (2 : ℝ) ≠ 0)] at hh
    linarith only [hh]
  have hp := pow_le_pow_left₀ (show 0 ≤ (1/2 : ℝ)*Real.log T by
    exact mul_nonneg (by norm_num) (Real.log_nonneg (by linarith only [hT₄]))) hlog 4
  have hdy := h (T/2) hhalf
  rw [show 2*(T/2) = T by ring] at hdy
  let f := fun t : ℝ => ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4
  have hf : Continuous f := zeta_critical_continuous.norm.pow _
  calc
    _ ≤ c*(T/2)*(Real.log (T/2))^4 := by
      convert mul_le_mul_of_nonneg_left hp (by positivity : 0 ≤ c*(T/2)) using 1
      ring
    _ ≤ ∫ t in T/2..T, f t := hdy
    _ ≤ ∫ t in 0..T, f t := intervalIntegral.integral_mono_interval
      (by linarith only [hT₄]) (by linarith only [hT₄]) le_rfl
      (Filter.Eventually.of_forall fun _ => by positivity) (hf.intervalIntegrable 0 T)

/-- The cumulative critical-line fourth moment has order (T log^4 T). -/
theorem zeta_fourth_moment_order :
    ∃ c C T₀ : ℝ, 0 < c ∧ 0 < C ∧ 2 ≤ T₀ ∧ ∀ T : ℝ, T₀ ≤ T →
      c*T*(Real.log T)^4 ≤ (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ∧
      (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤ C*T*(Real.log T)^4 := by
  obtain ⟨c,T₀,hc,hT₀,hlo⟩ := zeta_fourth_moment_log_four_lower
  obtain ⟨C,hC,hhi⟩ := zeta_fourth_moment_log_four
  exact ⟨c,C,T₀,hc,hC,hT₀,fun T hT => ⟨hlo T hT,hhi T (hT₀.trans hT)⟩⟩

end Legendre.Zeta
