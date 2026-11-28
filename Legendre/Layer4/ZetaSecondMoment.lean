/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.CriticalPolynomialMean
public import Legendre.Layer4.ZetaLinearEuler
public import Legendre.Layer4.ZetaFourthMomentSharp
public import Legendre.Layer4.MomentDyadic

@[expose] public section
namespace Legendre.Density.Moment
open MeasureTheory Set Complex

/-- Cauchy--Schwarz on an ordered interval, with its literal length. -/
theorem integral_Icc_le_sqrt_length_mul_sqrt_square {A B : ℝ} (hAB : A ≤ B)
    {f : ℝ → ℝ} (hf : Continuous f) (hn : ∀ t, 0 ≤ f t) :
    (∫ t in Icc A B, f t) ≤ √(B-A)*√(∫ t in Icc A B, f t^2) := by
  let μ := volume.restrict (Icc A B)
  let g : ℝ → ℝ := fun _ => 1
  have hμ : IsFiniteMeasure μ :=
    ⟨by simp [μ,Real.volume_Icc]⟩
  have hf₂ : MemLp f 2 μ := by
    apply (memLp_two_iff_integrable_sq hf.aestronglyMeasurable).2
    exact (hf.pow 2).continuousOn.integrableOn_Icc
  have hg₂ : MemLp g 2 μ := memLp_const 1
  have h := integral_mul_le_Lp_mul_Lq_of_nonneg
    (by norm_num [Real.holderConjugate_iff] : Real.HolderConjugate 2 2)
    (Filter.Eventually.of_forall hn)
    (Filter.Eventually.of_forall fun t => by simp [g])
    (by simpa using hf₂ : MemLp f (ENNReal.ofReal 2) μ)
    (by simpa using hg₂ : MemLp g (ENNReal.ofReal 2) μ)
  have hlen : (∫ t in Icc A B, g t^2) = B-A := by
    simp [g,measureReal_def,Real.volume_Icc,
      ENNReal.toReal_ofReal (sub_nonneg.mpr hAB)]
  change (∫ t in Icc A B, f t*g t) ≤
    (∫ t in Icc A B, f t^(2:ℝ))^(1/2:ℝ)*(∫ t in Icc A B, g t^(2:ℝ))^(1/2:ℝ) at h
  simp only [← Real.sqrt_eq_rpow,Real.rpow_two,hlen,mul_comm] at h
  simpa only [g,mul_one] using h

/-- A uniform pointwise comparison controls the difference of the
integrated squared norms by the comparison polynomial's first moment. -/
theorem abs_integral_Icc_norm_sq_sub_le_of_pointwise {A B D : ℝ} (hAB : A ≤ B) (hD : 0 ≤ D)
    {f g : ℝ → ℂ} (hf : Continuous f) (hg : Continuous g)
    (h : ∀ t ∈ Icc A B, ‖f t-g t‖ ≤ D) :
    |(∫ t in Icc A B, ‖f t‖^2)-(∫ t in Icc A B, ‖g t‖^2)| ≤
      2*D*(∫ t in Icc A B, ‖g t‖)+D^2*(B-A) := by
  have hpoint (t : ℝ) (ht : t ∈ Icc A B) :
      |‖f t‖^2-‖g t‖^2| ≤ 2*D*‖g t‖+D^2 := by
    have hd := (abs_norm_sub_norm_le (f t) (g t)).trans (h t ht)
    have hnorm : ‖f t‖+‖g t‖ ≤ 2*‖g t‖+D := by linarith only [(abs_le.mp hd).2]
    calc
      _ = |‖f t‖-‖g t‖| *(‖f t‖+‖g t‖) := by
        rw [← abs_of_nonneg (by positivity : 0 ≤ ‖f t‖+‖g t‖),← abs_mul]
        congr 1
        ring
      _ ≤ D*(2*‖g t‖+D) := mul_le_mul hd hnorm (by positivity) hD
      _ = _ := by ring
  have hfi : IntegrableOn (fun t : ℝ => ‖f t‖^2) (Icc A B) := (hf.norm.pow 2).continuousOn.integrableOn_Icc
  have hgi : IntegrableOn (fun t : ℝ => ‖g t‖^2) (Icc A B) := (hg.norm.pow 2).continuousOn.integrableOn_Icc
  have hgj : IntegrableOn (fun t : ℝ => 2*D*‖g t‖) (Icc A B) :=
    (continuous_const.mul hg.norm).continuousOn.integrableOn_Icc
  have hdj : IntegrableOn (fun _ : ℝ => D^2) (Icc A B) :=
    continuous_const.continuousOn.integrableOn_Icc
  rw [← integral_sub hfi hgi]
  apply abs_integral_le_integral_abs.trans
  apply (setIntegral_mono_on (hfi.sub hgi).abs (hgj.add hdj) measurableSet_Icc hpoint).trans_eq
  change (∫ t in Icc A B, 2*D*‖g t‖+D^2) = _
  rw [integral_add hgj hdj,integral_const_mul,setIntegral_const]
  simp [measureReal_def,Real.volume_Icc,ENNReal.toReal_ofReal (sub_nonneg.mpr hAB),mul_comm]

/-- The finite critical-line series is continuous in the height. -/
theorem continuous_critical_euler_sum (N : ℕ) :
    Continuous (fun t : ℝ => ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))) := by
  apply continuous_finsetSum
  intro n hn
  have hn₀ : (n : ℂ) ≠ 0 := by exact_mod_cast (show n ≠ 0 by have := (Finset.mem_Icc.mp hn).1; omega)
  have hc : Differentiable ℂ (fun w : ℂ => (n : ℂ)^w) := differentiable_id.const_cpow (.inl hn₀)
  exact hc.continuous.comp (by fun_prop : Continuous fun t : ℝ => -((1/2 : ℂ)+(t : ℂ)*I))

end Legendre.Density.Moment

namespace Legendre.Zeta

open Complex MeasureTheory Set Filter Density Density.Moment
open scoped Topology

private theorem log_sq_le_sixteen_sqrt {T : ℝ} (hT : 1 ≤ T) :
    (Real.log T)^2 ≤ 16*√T := by
  let U := T^(1/4 : ℝ)
  have hp : 0 < T := by linarith only [hT]
  have hU : 0 < U := by dsimp [U]; positivity
  have hlog : Real.log T ≤ 4*U := by
    have h := Real.log_le_sub_one_of_pos hU
    rw [show Real.log U = (1/4)*Real.log T by exact Real.log_rpow hp _] at h
    linarith only [h]
  have hU2 : U^2 = √T := by
    dsimp only [U]
    rw [Real.sqrt_eq_rpow, ← Real.rpow_mul_natCast hp.le, Nat.cast_ofNat]
    norm_num
  exact (pow_le_pow_left₀ (Real.log_nonneg hT) hlog 2).trans_eq (by rw [mul_pow,hU2]; ring)

/-- The zeta second moment has leading term (T log T) on the critical line. -/
theorem zeta_second_moment_main_term :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      |(∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^2)-T*Real.log T| ≤
        C*T*√(1+Real.log T) := by
  obtain ⟨Q,hQ,hquarter⟩ := zeta_fourth_moment_log_four
  let z := fun t : ℝ => riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)
  have hz : Continuous z := zeta_critical_continuous
  let Z := fun x : ℝ => ∫ t in Icc 0 x, ‖z t‖^2
  have hZ₀ (x : ℝ) : 0 ≤ Z x := integral_nonneg (fun _ => sq_nonneg _)
  let D := 4+72*Real.pi
  let K := 4*(Real.pi+4)
  let B := 16*√Q+2*D*√(K+2)+D^2+K+6
  let F := Z 4+4*Real.log 4
  let C := B+F
  have hD : 0 ≤ D := by dsimp [D]; positivity
  have hK : 0 ≤ K := by dsimp [K]; positivity
  have hB : 0 < B := by dsimp only [B]; positivity
  have hF : 0 ≤ F := by dsimp only [F]; positivity [hZ₀ 4, Real.log_nonneg (by norm_num : (1:ℝ) ≤ 4)]
  refine ⟨C,by dsimp only [C]; positivity,?_⟩
  intro T hT
  let L := 1+Real.log T
  have hT₀ : 0 < T := by linarith only [hT]
  have hT₁ : 1 ≤ T := by linarith only [hT]
  have hlogT : 0 ≤ Real.log T := Real.log_nonneg hT₁
  have hL : 1 ≤ L := by dsimp only [L]; linarith only [hlogT]
  have hLs : 1 ≤ √L := Real.one_le_sqrt.2 hL
  have hTL : T ≤ T*√L := le_mul_of_one_le_right hT₀.le hLs
  have hTL₁ : 1 ≤ T*√L := hT₁.trans hTL
  have hZ : (∫ t : ℝ in 0..T, ‖z t‖^2) = Z T := by
    rw [intervalIntegral.integral_of_le hT₀.le,← integral_Icc_eq_integral_Ioc]
  change |(∫ t : ℝ in 0..T, ‖z t‖^2)-T*Real.log T| ≤ C*T*√L
  rw [hZ]
  by_cases htlarge : 4 ≤ T
  · let A := √T
    let N := ⌈T⌉₊
    let H := (harmonic N : ℝ)
    let p := fun t : ℝ => ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))
    let Ip := ∫ t in Icc A T, ‖p t‖^2
    let Iz := ∫ t in Icc A T, ‖z t‖^2
    have hA : 2 ≤ A := (Real.le_sqrt (by norm_num) hT₀.le).2 (by norm_num; exact htlarge)
    have hA₀ : 0 ≤ A := by linarith only [hA]
    have hAsq : A^2 = T := Real.sq_sqrt hT₀.le
    have hAT : A ≤ T := by
      have h := (Real.sqrt_le_iff).2 ⟨hT₀.le,by nlinarith only [hT₁,mul_nonneg hT₀.le (sub_nonneg.mpr hT₁)]⟩
      exact h
    have hNlo : T ≤ N := Nat.le_ceil _
    have hNhi : (N : ℝ) ≤ 2*T := (Nat.ceil_lt_add_one hT₀.le).le.trans (by linarith only [hT₁])
    have hN₀ : (0 : ℝ) < N := hT₀.trans_le hNlo
    have hHlo : Real.log T ≤ H := by
      have h := log_add_one_le_harmonic N
      exact (Real.log_le_log hT₀ (by push_cast; linarith only [hNlo])).trans h
    have hHhi : H ≤ Real.log T+2 := by
      have h := (Real.log_le_log hN₀ hNhi)
      rw [Real.log_mul (by norm_num) hT₀.ne'] at h
      have hh := harmonic_le_one_add_log N
      dsimp only [H]
      linarith only [h,hh,Real.log_le_sub_one_of_pos (by norm_num : 0 < (2:ℝ))]
    have hH : 0 ≤ H := hlogT.trans hHlo
    have hp : Continuous p := continuous_critical_euler_sum N
    have hpoly : |Ip-(T-A)*H| ≤ K*T := by
      have h := abs_integral_critical_euler_sum_sub_harmonic N A T
      rw [intervalIntegral.integral_of_le hAT,← integral_Icc_eq_integral_Ioc] at h
      apply h.trans
      have hh := mul_le_mul_of_nonneg_left hNhi (show 0 ≤ 2*(Real.pi+4) by positivity)
      exact hh.trans_eq (by dsimp only [K]; ring)
    have hIp : Ip ≤ (K+2)*T*L := by
      have hlen : T-A ≤ T := by linarith only [hA]
      have hh : H ≤ 2*L := by dsimp only [L]; linarith only [hHhi,hlogT]
      have h := mul_le_mul hlen hh hH hT₀.le
      have hn := mul_le_mul_of_nonneg_left hL (show 0 ≤ K*T by positivity)
      have habs := (abs_le.mp hpoly).2
      nlinarith only [h,hn,habs]
    have hfirst : (∫ t in Icc A T, ‖p t‖) ≤ √(K+2)*T*√L := by
      apply (integral_Icc_le_sqrt_length_mul_sqrt_square hAT hp.norm (fun _ => norm_nonneg _)).trans
      have h₁ := Real.sqrt_le_sqrt (show T-A ≤ T by linarith only [hA])
      have h₂ := Real.sqrt_le_sqrt hIp
      apply (mul_le_mul h₁ h₂ (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)).trans_eq
      rw [Real.sqrt_mul (show 0 ≤ (K+2)*T by positivity),Real.sqrt_mul (show 0 ≤ K+2 by positivity)]
      dsimp only [A] at hAsq
      nlinarith only [congrArg (fun x : ℝ => x*(√(K+2)*√L)) hAsq]
    have hcmp : |Iz-Ip| ≤ (2*D*√(K+2)+D^2)*(T*√L) := by
      have hpoint (t : ℝ) (ht : t ∈ Icc A T) : ‖z t-p t‖ ≤ D := by
        have ht₂ : 2 ≤ t := hA.trans ht.1
        have hts : T ≤ t^2 := hAsq ▸ pow_le_pow_left₀ hA₀ ht.1 2
        exact zeta_critical_finite_euler_linear_error N t ht₂ (ht.2.trans hNlo)
          (hNhi.trans (by linarith only [hts]))
      have h := abs_integral_Icc_norm_sq_sub_le_of_pointwise hAT hD hz hp hpoint
      apply h.trans
      have h₁ := mul_le_mul_of_nonneg_left hfirst (show 0 ≤ 2*D by positivity)
      have h₂ := mul_le_mul_of_nonneg_left
        (show T-A ≤ T*√L by linarith only [hTL,hA]) (sq_nonneg D)
      exact (add_le_add h₁ h₂).trans_eq (by ring)
    have hζlow : Z A ≤ 16*√Q*T := by
      have hlogA : 0 ≤ Real.log A := Real.log_nonneg (by linarith only [hA])
      have hf := hquarter A hA
      rw [intervalIntegral.integral_of_le hA₀,← integral_Icc_eq_integral_Ioc] at hf
      have hc := integral_Icc_le_sqrt_length_mul_sqrt_square hA₀ (hz.norm.pow 2)
        (fun _ => sq_nonneg _)
      simp only [sub_zero,Pi.pow_apply,← pow_mul,show (2 : ℕ)*2 = 4 by norm_num] at hc
      change Z A ≤ _ at hc
      apply hc.trans
      have hq := mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt hf) (Real.sqrt_nonneg A)
      apply hq.trans
      have hx : √A*√(Q*A*(Real.log A)^4) = √Q*A*(Real.log A)^2 := by
        rw [Real.sqrt_mul (show 0 ≤ Q*A by positivity),Real.sqrt_mul hQ.le,
          show (Real.log A)^4 = ((Real.log A)^2)^2 by ring,Real.sqrt_sq (by positivity)]
        have h := congrArg (fun x : ℝ => √Q*x*(Real.log A)^2) (Real.sq_sqrt hA₀)
        nlinarith only [h]
      rw [hx]
      have hsq := (pow_le_pow_left₀ hlogA (Real.log_le_log (by linarith only [hA]) hAT) 2).trans
        (log_sq_le_sixteen_sqrt hT₁)
      exact (mul_le_mul_of_nonneg_left hsq (show 0 ≤ √Q*A by positivity)).trans_eq
        (by nlinarith only [congrArg (fun x : ℝ => 16*√Q*x) hAsq])
    have hdiag : |(T-A)*H-T*Real.log T| ≤ 6*T := by
      have hlog : Real.log T ≤ 2*A := by
        have h := Real.log_le_sub_one_of_pos (show 0 < A by linarith only [hA])
        have he := Real.log_pow A 2
        rw [hAsq, Nat.cast_ofNat] at he
        linarith only [h,he]
      have hTdif : 0 ≤ T*(H-Real.log T) := mul_nonneg hT₀.le (sub_nonneg.mpr hHlo)
      have hAH : 0 ≤ A*H := mul_nonneg hA₀ hH
      have h₁ := mul_le_mul_of_nonneg_left (show H-Real.log T ≤ 2 by linarith only [hHhi]) hT₀.le
      have h₂ := mul_le_mul_of_nonneg_left (show H ≤ 2*A+2 by linarith only [hlog,hHhi]) hA₀
      rw [show (T-A)*H-T*Real.log T = T*(H-Real.log T)-A*H by ring]
      apply abs_le.mpr
      constructor <;> nlinarith only [hTdif,hAH,h₁,h₂,hAsq,hAT,hT₀]
    have hsplit : Z T = Z A+Iz := by
      have h := intervalIntegral.integral_add_adjacent_intervals
        ((hz.norm.pow 2).intervalIntegrable (μ := volume) 0 A) ((hz.norm.pow 2).intervalIntegrable (μ := volume) A T)
      rw [intervalIntegral.integral_of_le hA₀,intervalIntegral.integral_of_le hAT,intervalIntegral.integral_of_le hT₀.le,
        ← integral_Icc_eq_integral_Ioc,← integral_Icc_eq_integral_Ioc,← integral_Icc_eq_integral_Ioc] at h
      exact h.symm
    rw [hsplit,show Z A+Iz-T*Real.log T =
      ((Z A+(Iz-Ip))+(Ip-(T-A)*H))+((T-A)*H-T*Real.log T) by ring]
    have hb := (abs_add_le _ _).trans (add_le_add
      ((abs_add_le _ _).trans (add_le_add
        ((abs_add_le _ _).trans (add_le_add ((abs_of_nonneg (hZ₀ A)).trans_le hζlow) hcmp)) hpoly))
      hdiag)
    apply hb.trans
    have h₁ := mul_le_mul_of_nonneg_left hTL (show 0 ≤ 16*√Q by positivity)
    have h₂ := mul_le_mul_of_nonneg_left hTL hK
    have h₃ := mul_le_mul_of_nonneg_left hTL (by norm_num : (0 : ℝ) ≤ 6)
    have h₄ := mul_nonneg hF (show 0 ≤ T*√L by positivity)
    dsimp only [C,B]
    nlinarith only [h₁,h₂,h₃,h₄]
  · have hZmono : Z T ≤ Z 4 :=
      setIntegral_mono_set ((hz.norm.pow 2).continuousOn.integrableOn_Icc)
        (Filter.Eventually.of_forall fun _ => sq_nonneg _)
        (Icc_subset_Icc le_rfl (le_of_not_ge htlarge)).eventuallySubset
    have hsmall : T*Real.log T ≤ 4*Real.log 4 :=
      mul_le_mul (le_of_not_ge htlarge) (Real.log_le_log hT₀ (le_of_not_ge htlarge)) hlogT (by norm_num)
    have h : |Z T-T*Real.log T| ≤ |Z T| + |T*Real.log T| := by
      simpa only [sub_eq_add_neg,abs_neg] using abs_add_le (Z T) (-(T*Real.log T))
    rw [abs_of_nonneg (hZ₀ T),abs_of_nonneg (mul_nonneg hT₀.le hlogT)] at h
    apply (h.trans (add_le_add hZmono hsmall)).trans
    change F ≤ _
    rw [mul_assoc]
    exact (le_mul_of_one_le_right hF hTL₁).trans
      (mul_le_mul_of_nonneg_right (show F ≤ C by dsimp only [C]; linarith only [hB]) (by positivity))

/-- The normalized critical-line zeta second moment tends to one. -/
theorem zeta_second_moment_tendsto_one :
    Tendsto (fun T : ℝ => (∫ t : ℝ in 0..T,
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^2)/(T*Real.log T)) atTop (𝓝 1) := by
  obtain ⟨C,hC,hb⟩ := zeta_second_moment_main_term
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hs := Real.tendsto_sqrt_atTop.comp Real.tendsto_log_atTop
  have hl := tendsto_inv_atTop_zero.comp hs
  have hlim : Tendsto (fun T : ℝ => (2*C)*(√(Real.log T))⁻¹) atTop (𝓝 0) := by
    simpa only [Function.comp_apply,mul_zero] using
      (tendsto_const_nhds (x := 2*C)).mul hl
  apply squeeze_zero' (Eventually.of_forall (fun _ => norm_nonneg _)) _ hlim
  filter_upwards [eventually_ge_atTop (2 : ℝ),eventually_ge_atTop (Real.exp 1)] with T hT hT'
  have ht : 0 < T := by linarith only [hT]
  have hl₁ : 1 ≤ Real.log T := by
    simpa only [Real.log_exp] using Real.log_le_log (Real.exp_pos 1) hT'
  have hlog : 0 < Real.log T := by linarith only [hl₁]
  have hroot : √(1+Real.log T) ≤ 2*√(Real.log T) := by
    apply (Real.sqrt_le_iff).2 ⟨by positivity,?_⟩
    rw [mul_pow,Real.sq_sqrt hlog.le]
    linarith only [hl₁]
  rw [Real.norm_eq_abs,div_sub_one (mul_pos ht hlog).ne',abs_div,
    abs_of_pos (mul_pos ht hlog)]
  have h := div_le_div_of_nonneg_right (hb T hT) (mul_nonneg ht.le hlog.le)
  apply h.trans
  have hu := div_le_div_of_nonneg_right
    (mul_le_mul_of_nonneg_left hroot (show 0 ≤ C*T by positivity)) (mul_nonneg ht.le hlog.le)
  apply hu.trans_eq
  rw [← div_eq_mul_inv]
  field_simp [ht.ne',hlog.ne',(Real.sqrt_pos.2 hlog).ne']
  ring_nf
  rw [Real.sq_sqrt hlog.le]

end Legendre.Zeta
