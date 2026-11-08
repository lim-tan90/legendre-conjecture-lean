/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaSecondEuler
public import Legendre.PNT.EulerMaclaurin
public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

/-!
# Finite Euler summation for zeta in Re(s)>0

The pole contribution is retained explicitly. This formula is intended for
zero detection; finite truncation cannot discard the principal pole term.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Set

/-- The centered fractional part has its sharp elementary half-unit bound. -/
theorem norm_zetaCenteredFractionalPart_le_half (t : ℝ) :
    ‖zetaCenteredFractionalPart t‖ ≤ 1/2 := by
  rw [zetaCenteredFractionalPart,norm_real,Real.norm_eq_abs,abs_le]
  have h0 := Int.fract_nonneg t
  have h1 := Int.fract_lt_one t
  constructor <;> linarith

/-- Complex-valued first Bernoulli convention on the nonnegative axis. -/
theorem ofReal_B1_eq_zetaCenteredFractionalPart {t : ℝ} (ht : 0 ≤ t) :
    (B1 t : ℂ) = zetaCenteredFractionalPart t := by
  rw [zetaCenteredFractionalPart_eq ht]
  unfold B1
  push_cast
  ring

/-- Centered remainder after a positive real cutoff. -/
noncomputable def zetaEulerTail (a : ℝ) (s : ℂ) : ℂ :=
  ∫ t : ℝ in Ioi a, zetaCenteredFractionalPart t*(t : ℂ)^(-s-1)

/-- Absolute convergence at every positive cutoff. -/
theorem zetaEulerTail_integrable {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 0 < s.re) :
    IntegrableOn (fun t : ℝ => zetaCenteredFractionalPart t*(t : ℂ)^(-s-1)) (Ioi a) := by
  have hp := integrableOn_Ioi_cpow_of_lt (a := -s-1)
    (by simp only [sub_re,neg_re,one_re]; linarith) ha
  apply (hp.const_mul (1/2 : ℂ)).mono
    ((zetaCenteredFractionalPart_measurable.aestronglyMeasurable.restrict).mul
      hp.aestronglyMeasurable)
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  simp only [Pi.mul_apply,norm_mul,norm_div,norm_one,norm_ofNat]
  exact mul_le_mul_of_nonneg_right (norm_zetaCenteredFractionalPart_le_half t) (norm_nonneg ((t : ℂ)^(-s-1)))

/-- Explicit decaying tail bound, without a hidden height-dependent constant. -/
theorem norm_zetaEulerTail_le {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 0 < s.re) :
    ‖zetaEulerTail a s‖ ≤ a^(-s.re)/(2*s.re) := by
  have hp := integrableOn_Ioi_rpow_of_lt (a := -s.re-1) (by linarith) ha
  have hb : ‖zetaEulerTail a s‖ ≤ ∫ t : ℝ in Ioi a, (1/2 : ℝ)*t^(-s.re-1) := by
    apply norm_integral_le_of_norm_le (hp.const_mul (1/2 : ℝ))
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    rw [norm_mul,norm_cpow_eq_rpow_re_of_pos (ha.trans ht)]
    simp only [sub_re,neg_re,one_re]
    exact mul_le_mul_of_nonneg_right (norm_zetaCenteredFractionalPart_le_half t)
      (Real.rpow_nonneg (ha.trans ht).le _)
  apply hb.trans_eq
  rw [integral_const_mul,integral_Ioi_rpow_of_lt (by linarith) ha]
  rw [show -s.re-1+1 = -s.re by ring]
  ring

/-- A finite Euler identity before the infinite tail is reattached. -/
theorem finite_sum_cpow_euler {N : ℕ} (hN : 1 ≤ N) {s : ℂ} (hs : 0 < s.re)
    (hs1 : s ≠ 1) :
    (∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s)) =
      (1/2 : ℂ)+(1/2 : ℂ)*(N : ℂ)^(-s)+
        ((N : ℂ)^(1-s)-1)/(1-s)-
          s*(∫ t : ℝ in (1 : ℝ)..(N : ℝ),
            zetaCenteredFractionalPart t*(t : ℂ)^(-s-1)) := by
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hs0 : s ≠ 0 := by intro he; simp only [he,zero_re,lt_self_iff_false] at hs
  let f : ℝ → ℂ := fun t => (t : ℂ)^(-s)
  have hd (t : ℝ) (ht : 0 < t) : HasDerivAt f ((-s)*(t : ℂ)^(-s-1)) t :=
    hasDerivAt_ofReal_cpow_const ht.ne' (neg_ne_zero.2 hs0)
  have hder : ∀ t ∈ Icc (1 : ℝ) N, deriv f t = (-s)*(t : ℂ)^(-s-1) :=
    fun t ht => (hd t (zero_lt_one.trans_le ht.1)).deriv
  have hcont : ContinuousOn (fun t : ℝ => (-s)*(t : ℂ)^(-s-1)) (Icc (1 : ℝ) N) :=
    continuousOn_const.mul (continuous_ofReal.continuousOn.cpow_const
      (fun t ht => ofReal_mem_slitPlane.2 (zero_lt_one.trans_le ht.1)))
  have he : (∑ n ∈ Finset.Ioc 1 N, f n) =
      f 1*(B1 1 : ℂ)-f N*(B1 (N : ℝ) : ℂ)+(∫ t : ℝ in (1 : ℝ)..(N : ℝ), f t)+
        ∫ t : ℝ in (1 : ℝ)..(N : ℝ), deriv f t*(B1 t : ℂ) := by
    simpa only [Nat.floor_one,Nat.floor_natCast] using!
      sum_eq_integral_add_integral_deriv (f := f) (by norm_num : (0 : ℝ) ≤ 1) hNR
        (fun t ht => (hd t (zero_lt_one.trans_le ht.1)).differentiableAt)
        (by rw [uIcc_of_le hNR]; exact hcont.congr hder)
  have hi : (∫ t : ℝ in (1 : ℝ)..(N : ℝ), deriv f t*(B1 t : ℂ)) =
      -s*(∫ t : ℝ in (1 : ℝ)..(N : ℝ),
        zetaCenteredFractionalPart t*(t : ℂ)^(-s-1)) := by
    rw [← intervalIntegral.integral_const_mul]
    apply intervalIntegral.integral_congr
    intro t ht
    rw [uIcc_of_le hNR] at ht
    dsimp only
    rw [hder t ht,ofReal_B1_eq_zetaCenteredFractionalPart (zero_le_one.trans ht.1)]
    ring
  rw [hi] at he
  have hint : (∫ t : ℝ in (1 : ℝ)..(N : ℝ), f t) = ((N : ℂ)^(1-s)-1)/(1-s) := by
    have hr : -s ≠ -1 := fun he => hs1 (neg_injective he)
    have hz : (0 : ℝ) ∉ uIcc (1 : ℝ) N := by rw [uIcc_of_le hNR]; simp
    simpa only [f,ofReal_natCast,ofReal_one,one_cpow,show -s+1 = 1-s by ring] using
      integral_cpow (a := 1) (b := (N : ℝ)) (r := -s) (Or.inr ⟨hr,hz⟩)
  rw [hint] at he
  have hsum : (∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s)) =
      1+∑ n ∈ Finset.Ioc 1 N, (n : ℂ)^(-s) := by
    rw [Finset.Icc_eq_cons_Ioc hN,Finset.sum_cons]
    simp
  rw [hsum]
  change 1+(∑ n ∈ Finset.Ioc 1 N, f n) = _
  rw [he]
  simp only [f,B1,Nat.floor_natCast,Nat.floor_one,ofReal_one,one_cpow]
  push_cast
  ring

/-- Finite Euler summation with the principal pole term displayed explicitly. -/
theorem riemannZeta_eq_finite_euler {N : ℕ} (hN : 1 ≤ N) {s : ℂ}
    (hs : 0 < s.re) (hs1 : s ≠ 1) :
    riemannZeta s = (∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s))+
      (N : ℂ)^(1-s)/(s-1)-(1/2 : ℂ)*(N : ℂ)^(-s)-s*zetaEulerTail N s := by
  have hs0 : s ≠ 0 := by intro he; simp only [he,zero_re,lt_self_iff_false] at hs
  have hc : zetaEulerTail 1 s = zetaMellinRemainder s-(1/2 : ℂ)/s := centeredEuler_integral hs
  have hz : riemannZeta s = 1/(s-1)+(1/2 : ℂ)-s*zetaEulerTail 1 s := by
    rw [riemannZeta_eq_euler_sum hs hs1,hc]
    field_simp
    ring
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hi : zetaEulerTail 1 s =
      (∫ t : ℝ in (1 : ℝ)..(N : ℝ), zetaCenteredFractionalPart t*(t : ℂ)^(-s-1))+
        zetaEulerTail N s := by
    exact (intervalIntegral.integral_interval_add_Ioi
      (zetaEulerTail_integrable zero_lt_one hs)
      (zetaEulerTail_integrable (zero_lt_one.trans_le hNR) hs)).symm
  rw [hz,finite_sum_cpow_euler hN hs hs1,hi]
  rw [show (1 : ℂ)-s = -(s-1) by ring,div_neg]
  field_simp
  ring

/-- The error after removing the pole contribution has an explicit power decay. -/
theorem norm_riemannZeta_sub_finite_euler_le {N : ℕ} (hN : 1 ≤ N) {s : ℂ}
    (hs : 0 < s.re) (hs1 : s ≠ 1) :
    ‖riemannZeta s-(∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s))-
      (N : ℂ)^(1-s)/(s-1)‖ ≤ (1/2+‖s‖/(2*s.re))*(N : ℝ)^(-s.re) := by
  have hNpos : 0 < N := Nat.zero_lt_one.trans_le hN
  have hNR : (0 : ℝ) < N := by exact_mod_cast hNpos
  have hpow : ‖(N : ℂ)^(-s)‖ = (N : ℝ)^(-s.re) := by
    simpa only [neg_re] using! norm_natCast_cpow_of_pos hNpos (-s)
  have he : riemannZeta s-(∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s))-
      (N : ℂ)^(1-s)/(s-1) = -((1/2 : ℂ)*(N : ℂ)^(-s)+s*zetaEulerTail N s) := by
    rw [riemannZeta_eq_finite_euler hN hs hs1]
    ring
  rw [he,norm_neg]
  calc
    _ ≤ ‖(1/2 : ℂ)*(N : ℂ)^(-s)‖+‖s*zetaEulerTail N s‖ := norm_add_le _ _
    _ = (1/2 : ℝ)*(N : ℝ)^(-s.re)+‖s‖*‖zetaEulerTail N s‖ := by
      rw [norm_mul,norm_mul,hpow]
      norm_num
    _ ≤ (1/2 : ℝ)*(N : ℝ)^(-s.re)+‖s‖*((N : ℝ)^(-s.re)/(2*s.re)) :=
      add_le_add le_rfl (mul_le_mul_of_nonneg_left (norm_zetaEulerTail_le hNR hs) (norm_nonneg s))
    _ = _ := by ring

end Legendre.Zeta
