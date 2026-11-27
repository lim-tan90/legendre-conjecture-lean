/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.Exponential.InverseSqrtDifferencing
public import Legendre.Layer4.Exponential.WeightedLogBlocks
public import Legendre.Layer4.Exponential.LogFirstDerivative

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set Tools.ExponentialSum

private theorem logarithmic_shift_correlation_lag (U M h H : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (hh : 1 ≤ h) (hhH : h ≤ H) (hHU : H ≤ U) (t : ℝ) (ht : 0 < t) :
    ‖∑ n ∈ Finset.Icc 1 M,
      phase (logarithmicPhase t (((n+h : ℕ) : ℝ)+U))*
        (starRingEnd ℂ) (phase (logarithmicPhase t ((n : ℝ)+U)))‖ ≤
      logarithmicShiftConstant*√(t*H/(U : ℝ))+
        (logarithmicShiftConstant*(U : ℝ)*√((U : ℝ)/t))*(√(h : ℝ))⁻¹ := by
  let u := (U : ℝ)
  let j := (h : ℝ)
  let v := (H : ℝ)
  have hu : 0 < u := by dsimp only [u]; exact_mod_cast (show 0 < U by omega)
  have hj : 0 < j := by dsimp only [j]; exact_mod_cast (show 0 < h by omega)
  have hjv : j ≤ v := by dsimp only [j,v]; exact_mod_cast hhH
  have hπ : (1 : ℝ) ≤ 64*Real.pi := by linarith [Real.pi_gt_three]
  have hp : 0 < t*j/(64*Real.pi*u^3) := by positivity
  have hmain : u*√(t*j/(64*Real.pi*u^3)) ≤ √(t*v/u) := by
    apply (Real.le_sqrt (by positivity) (by positivity)).2
    rw [mul_pow,Real.sq_sqrt hp.le]
    rw [show u^2*(t*j/(64*Real.pi*u^3)) = t*j/(64*Real.pi*u) by field_simp]
    exact div_le_div₀ (by positivity) (mul_le_mul_of_nonneg_left hjv ht.le) hu (by nlinarith only [mul_le_mul_of_nonneg_right hπ hu.le])
  have herror : 1/√(t*j/(64*Real.pi*u^3)) = √(64*Real.pi)*u*√(u/t)*(√j)⁻¹ := by
    apply le_antisymm <;>
      apply (sq_le_sq₀ (by positivity) (by positivity)).mp <;>
      rw [div_pow,one_pow,mul_pow,mul_pow,mul_pow,inv_pow,Real.sq_sqrt hp.le,
        Real.sq_sqrt (by positivity : 0 ≤ 64*Real.pi),
        Real.sq_sqrt (by positivity : 0 ≤ u/t),Real.sq_sqrt hj.le] <;>
      apply le_of_eq <;> field_simp
  have hshift := logarithmic_shift_correlation_second U M h hU hMU hh (hhH.trans hHU) t ht.ne'
  rw [abs_of_pos ht] at hshift
  apply hshift.trans
  change 399*(u*√(t*j/(64*Real.pi*u^3))+1/√(t*j/(64*Real.pi*u^3))) ≤
    logarithmicShiftConstant*√(t*v/u)+(logarithmicShiftConstant*u*√(u/t))*(√j)⁻¹
  rw [herror]
  have h₁ : 399 ≤ logarithmicShiftConstant := by
    unfold logarithmicShiftConstant
    linarith only [Real.sqrt_nonneg (64*Real.pi)]
  have h₂ : 399*√(64*Real.pi) ≤ logarithmicShiftConstant := by
    unfold logarithmicShiftConstant
    linarith
  calc
    _ = 399*(u*√(t*j/(64*Real.pi*u^3)))+(399*√(64*Real.pi))*(u*√(u/t)*(√j)⁻¹) := by ring
    _ ≤ logarithmicShiftConstant*√(t*v/u)+logarithmicShiftConstant*(u*√(u/t)*(√j)⁻¹) :=
      add_le_add (mul_le_mul h₁ hmain (by positivity) logarithmicShiftConstant_pos.le)
        (mul_le_mul_of_nonneg_right h₂ (by positivity))
    _ = _ := by ring

private theorem logarithmic_prefix_weyl_two_thirds_sq (U M : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (t r : ℝ) (ht : 1 ≤ t) (hr : 1 ≤ r) (htr : t = r^3)
    (hUr : (U : ℝ) ≤ r^2) :
    ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))‖^2 ≤
      (4+18*logarithmicShiftConstant)*(U : ℝ)*r := by
  let u := (U : ℝ)
  let c := logarithmicShiftConstant
  let S := ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))‖
  have hMp : (0 : ℝ) ≤ M := Nat.cast_nonneg M
  have hMu : (M : ℝ) ≤ u := by dsimp only [u]; exact_mod_cast hMU
  have hu : 0 < u := by dsimp only [u]; exact_mod_cast (show 0 < U by omega)
  have hrp : 0 < r := by linarith
  have htp : 0 < t := by linarith
  have hc := logarithmicShiftConstant_pos
  have hS : 0 ≤ S := norm_nonneg _
  have hSM : S ≤ (M : ℝ) := by
    apply (norm_sum_le _ _).trans_eq
    simp [phase_norm,Nat.card_Icc]
  have hSM2 : S^2 ≤ (M : ℝ)^2 := pow_le_pow_left₀ hS hSM 2
  change S^2 ≤ (4+18*c)*u*r
  have hcoef : 0 ≤ 18*c*u*r := by positivity
  by_cases hlarge : 2 ≤ u/r
  · let H := ⌊u/r⌋₊
    have hH : 1 ≤ H := Nat.floor_pos.mpr (by linarith)
    have hHp : (0 : ℝ) < H := by exact_mod_cast (show 0 < H by omega)
    have hHhi : (H : ℝ) ≤ u/r := Nat.floor_le (by positivity)
    have hfloor : u/r < (H : ℝ)+1 := Nat.lt_floor_add_one _
    have hHlo : u ≤ 2*(H : ℝ)*r := by
      apply (div_le_iff₀ hrp).1
      have hHone : (1 : ℝ) ≤ H := by exact_mod_cast hH
      linarith only [hfloor,hHone]
    by_cases hHM : H ≤ M
    · have hb := Tools.van_der_corput_nat_interval_inverse_sqrt
        (fun n => phase (logarithmicPhase t ((n : ℝ)+U))) M H hH hHM
        (c*√(t*H/u)) (c*u*√(u/t)) (by positivity) (by positivity)
        (fun n _ => (phase_norm _).le)
        (fun h hh hhH => logarithmic_shift_correlation_lag U (M-h) h H hU
          ((Nat.sub_le M h).trans hMU) hh hhH.le (hHM.trans hMU) t htp)
      have hroot₁ : √(t*H/u) ≤ r := by
        apply Real.sqrt_le_iff.mpr ⟨hrp.le,?_⟩
        apply (div_le_iff₀ hu).2
        have hh := (le_div_iff₀ hrp).1 hHhi
        have hm := mul_le_mul_of_nonneg_right hh (sq_nonneg r)
        rw [htr]
        nlinarith only [hm]
      have hroot₂ : u*√(u/t)*(√(H : ℝ))⁻¹ ≤ 2*r := by
        apply (sq_le_sq₀ (by positivity) (by positivity)).1
        rw [mul_pow,mul_pow,inv_pow,Real.sq_sqrt (by positivity : 0 ≤ u/t),Real.sq_sqrt hHp.le]
        rw [show u^2*(u/t)*(H : ℝ)⁻¹ = u^3/(t*H) by ring]
        apply (div_le_iff₀ (by positivity : 0 < t*(H : ℝ))).2
        rw [htr]
        have h₁ := mul_le_mul_of_nonneg_left hHlo (sq_nonneg u)
        have h₂ := mul_le_mul_of_nonneg_right
          (pow_le_pow_left₀ hu.le hUr 2) (show 0 ≤ 2*(H : ℝ)*r by positivity)
        have h₃ : 0 ≤ 2*(H : ℝ)*r^5 := by positivity
        nlinarith only [h₁,h₂,h₃]
      have hdiag : 2*(M : ℝ)^2/H ≤ 4*u*r := by
        apply (div_le_iff₀ hHp).2
        have h₁ := pow_le_pow_left₀ hMp hMu 2
        have h₂ := mul_le_mul_of_nonneg_left hHlo hu.le
        nlinarith only [h₁,h₂]
      have hcorr : c*√(t*H/u)+4*(c*u*√(u/t))*(√(H : ℝ))⁻¹ ≤ 9*c*r := by
        have h₁ := mul_le_mul_of_nonneg_left hroot₁ hc.le
        have h₂ := mul_le_mul_of_nonneg_left hroot₂ (show 0 ≤ 4*c by positivity)
        nlinarith only [h₁,h₂]
      have hrest : 2*(M : ℝ)*(c*√(t*H/u)+4*(c*u*√(u/t))*(√(H : ℝ))⁻¹) ≤
          2*u*(9*c*r) := by
        apply mul_le_mul (by linarith only [hMu]) hcorr <;> positivity
      change S^2 ≤ _ at hb
      exact (hb.trans (add_le_add hdiag hrest)).trans_eq (by ring)
    · have hMH : (M : ℝ) ≤ H := by exact_mod_cast (le_of_not_ge hHM)
      have hMr : (M : ℝ) ≤ r := hMH.trans (hHhi.trans ((div_le_iff₀ hrp).2 (by simpa only [pow_two] using hUr)))
      have hh := mul_le_mul hMu hMr hMp hu.le
      nlinarith only [hSM2,hh,hcoef,show 0 ≤ u*r by positivity]
  · have htiny : u ≤ 2*r := (div_le_iff₀ hrp).mp (le_of_not_ge hlarge)
    have hh := mul_le_mul hMu (hMu.trans htiny) hMp hu.le
    nlinarith only [hSM2,hh,hcoef,show 0 ≤ u*r by positivity]

/-- Weighted Weyl cancellation is uniform through block length t^(2/3). -/
theorem logarithmic_block_weighted_weyl_two_thirds (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V)
    (hV : V ≤ 2*U) (t : ℝ) (ht : 1 ≤ t) (hUt : (U : ℝ) ≤ t^(2/3 : ℝ)) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))‖ ≤
      √(4+18*logarithmicShiftConstant)*t^(1/6 : ℝ) := by
  let r := t^(1/3 : ℝ)
  let w := t^(1/6 : ℝ)
  let K := √(4+18*logarithmicShiftConstant)
  let u := (U : ℝ)
  have hu : 0 < u := by dsimp only [u]; exact_mod_cast (show 0 < U by omega)
  have htp : 0 < t := by linarith
  have hr : 1 ≤ r := Real.one_le_rpow ht (by norm_num)
  have htr : t = r^3 := by
    dsimp only [r]
    rw [← Real.rpow_mul_natCast htp.le, Nat.cast_ofNat]
    norm_num
  have hr2 : r^2 = t^(2/3 : ℝ) := by
    dsimp only [r]
    rw [← Real.rpow_mul_natCast htp.le, Nat.cast_ofNat]
    congr 1
    ring
  have hw2 : w^2 = r := by
    dsimp only [w,r]
    rw [← Real.rpow_mul_natCast htp.le, Nat.cast_ofNat]
    congr 1
    ring
  have hK2 : K^2 = 4+18*logarithmicShiftConstant := Real.sq_sqrt (by positivity [logarithmicShiftConstant_pos])
  have hpre (W : ℕ) (hUW : U ≤ W) (hWV : W ≤ V) :
      ‖∑ n ∈ Finset.Ioc U W, (n : ℂ)^(-(t : ℂ)*I)‖ ≤ K*√u*w := by
    have hs := logarithmic_prefix_weyl_two_thirds_sq U (W-U) hU (by omega) t r ht hr htr (hr2 ▸ hUt)
    rw [logarithmic_prefix_eq_block U (W-U) hU t, Nat.add_sub_of_le hUW] at hs
    apply (sq_le_sq₀ (norm_nonneg _) (by positivity)).1
    rw [mul_pow,mul_pow,hK2,Real.sq_sqrt hu.le,hw2]
    exact hs
  have hb := norm_complex_block_of_prefix U V hU hUV (1/2) t (K*√u*w)
    (by norm_num) (by positivity) hpre
  have he : K*√u*w*u^(-(1/2 : ℝ)) = K*w := by
    rw [Real.rpow_neg hu.le, ← Real.sqrt_eq_rpow, ← div_eq_mul_inv]
    field_simp
  change _ ≤ K*w
  have ht' : (((1/2 : ℝ) : ℂ)) = (1/2 : ℂ) := by norm_num
  rw [ht',he] at hb
  exact hb

end Legendre.Density.Oscillation
