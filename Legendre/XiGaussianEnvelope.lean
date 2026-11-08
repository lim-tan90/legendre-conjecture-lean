/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The Gaussian-envelope organization generalizes DensityGaussianEnvelope.lean
from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Here the polynomial removal of zeta's poles requires a sixth-degree envelope.
The source license is retained in licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.XiSquareKernel
public import Legendre.GammaBounds.GammaStripBound
public import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral

/-!
# Polynomial growth and an integrable envelope for the entire xi square

The reflection equation transfers a positive-strip Gamma bound to the full
contour band. No Stirling asymptotic is needed for this unnormalized envelope.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Set
open scoped Topology

theorem gammaReal_positive_strip_bound : ∃ C : ℝ, 0 < C ∧ ∀ s : ℂ,
    1/2 ≤ s.re → s.re ≤ 3/2 → ‖Gammaℝ s‖ ≤ C := by
  obtain ⟨C,hC,hbound⟩ := Density.GammaBounds.gamma_positive_strip_bound
    (1/4) (3/4) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro s hs hs'
  have hg := hbound (s/2) (by simp only [div_ofNat_re]; linarith)
    (by simp only [div_ofNat_re]; linarith)
  have hp : ‖(Real.pi : ℂ)^(-s/2)‖ ≤ 1 := by
    rw [norm_cpow_eq_rpow_re_of_pos Real.pi_pos]
    apply Real.rpow_le_one_of_one_le_of_nonpos (by linarith [Real.pi_gt_three])
    simp only [div_ofNat_re,neg_re]
    linarith
  rw [Gammaℝ_def,norm_mul]
  simpa only [one_mul] using mul_le_mul hp hg (norm_nonneg _) zero_le_one

/-- A uniform cubic growth bound on the band used by the xi square contour. -/
theorem zetaXi_strip_bound : ∃ C : ℝ, 0 < C ∧ ∀ s : ℂ,
    -(1/2) ≤ s.re → s.re ≤ 3/2 → ‖zetaXi s‖ ≤ C*(1+|s.im|)^3 := by
  obtain ⟨G,hG,hGamma⟩ := gammaReal_positive_strip_bound
  have hpositive (s : ℂ) (hs : 1/2 ≤ s.re) (hs' : s.re ≤ 3/2) :
      ‖zetaXi s‖ ≤ (81*G)*(1+|s.im|)^3 := by
    have hspos : 0 < s.re := by linarith
    have hR : ‖zetaMellinRemainder s‖ ≤ 2 := by
      apply (norm_zetaMellinRemainder_le hspos).trans
      apply (div_le_iff₀ hspos).2
      linarith
    have hsub : ‖s-1‖ ≤ ‖s‖+1 := by simpa using norm_sub_le s 1
    have hP : ‖poleRemovedZeta s‖ ≤ 3*(‖s‖+1)^2 := by
      rw [poleRemovedZeta_eq_euler_sum hspos]
      have hn := norm_sub_le s (s*(s-1)*zetaMellinRemainder s)
      rw [norm_mul,norm_mul] at hn
      have hprod := mul_le_mul_of_nonneg_left
        (mul_le_mul hsub hR (norm_nonneg _) (by positivity : 0 ≤ ‖s‖+1)) (norm_nonneg s)
      nlinarith [norm_nonneg s]
    have hraw : ‖zetaXi s‖ ≤ 3*G*(‖s‖+1)^3 := by
      rw [zetaXi_eq_gamma_poleRemoved hspos,norm_mul,norm_mul]
      have hh := mul_le_mul
        (mul_le_mul_of_nonneg_left (hGamma s hs hs') (norm_nonneg s)) hP
        (norm_nonneg _) (by positivity : 0 ≤ ‖s‖*G)
      apply hh.trans
      have hp : ‖s‖*(‖s‖+1)^2 ≤ (‖s‖+1)^3 := by nlinarith [sq_nonneg (‖s‖+1)]
      convert! mul_le_mul_of_nonneg_left hp (by positivity : 0 ≤ 3*G) using 1
      ring
    have hnorm : ‖s‖+1 ≤ 3*(1+|s.im|) := by
      have hn := norm_le_abs_re_add_abs_im s
      rw [abs_of_pos hspos] at hn
      linarith [abs_nonneg s.im]
    calc
      _ ≤ 3*G*(‖s‖+1)^3 := hraw
      _ ≤ 3*G*(3*(1+|s.im|))^3 :=
        mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (by positivity) hnorm 3) (by positivity)
      _ = _ := by ring
  refine ⟨81*G,by positivity,?_⟩
  intro s hs hs'
  by_cases hsp : 1/2 ≤ s.re
  · exact hpositive s hsp hs'
  · have hr := hpositive (1-s) (by simp only [sub_re,one_re]; linarith)
      (by simp only [sub_re,one_re]; linarith)
    simpa only [zetaXi_one_sub,sub_im,one_im,zero_sub,abs_neg] using hr

noncomputable def xiGaussianEnvelope (u : ℝ) : ℝ := (1+u^2)^3*Real.exp (-(u^2))

theorem xiGaussianEnvelope_nonneg (u : ℝ) : 0 ≤ xiGaussianEnvelope u := by
  unfold xiGaussianEnvelope
  positivity

theorem xiGaussianEnvelope_integrable : Integrable xiGaussianEnvelope := by
  have hi (k : ℕ) : Integrable (fun u : ℝ => u^(2*k)*Real.exp (-(u^2))) := by
    simpa only [Real.rpow_natCast,neg_mul,one_mul] using
      (integrable_rpow_mul_exp_neg_mul_sq (b := (1 : ℝ)) (by norm_num)
        (s := ((2*k : ℕ) : ℝ)) (by
          have h : (0 : ℝ) ≤ ((2*k : ℕ) : ℝ) := Nat.cast_nonneg _
          linarith))
  convert! ((hi 0).add ((hi 1).const_mul 3)).add (((hi 2).const_mul 3).add (hi 3)) using 1
  funext u
  dsimp [xiGaussianEnvelope]
  ring

theorem xiGaussianEnvelope_tendsto : Tendsto xiGaussianEnvelope atTop (𝓝 0) := by
  have hp : Tendsto (fun u : ℝ => u^2) atTop atTop := tendsto_pow_atTop (by norm_num)
  have ht (k : ℕ) := (Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero k).comp hp
  have h := ((ht 0).add ((ht 1).const_mul 3)).add (((ht 2).const_mul 3).add (ht 3))
  convert! h using 1
  · funext u
    dsimp [xiGaussianEnvelope]
    ring
  · norm_num

/-- Both vertical lines and horizontal edges have one integrable Gaussian majorant. -/
theorem xiSquareGaussian_band_bound (s : ℂ) (hs : s.re = 1/2) :
    ∃ K : ℝ, 0 < K ∧ ∀ x u : ℝ, |x| ≤ 1 →
      ‖xiSquareGaussian s ((x : ℂ)+(u : ℂ)*I)‖ ≤ K*xiGaussianEnvelope u := by
  obtain ⟨C,hC,hbound⟩ := zetaXi_strip_bound
  let a := |s.im|+2
  let K := C^2*8*a^6*Real.exp 1
  have ha : 2 ≤ a := by dsimp [a]; linarith [abs_nonneg s.im]
  refine ⟨K,by dsimp [K]; positivity,?_⟩
  intro x u hx
  have hre : -(1/2 : ℝ) ≤ (s+((x : ℂ)+(u : ℂ)*I)).re ∧
      (s+((x : ℂ)+(u : ℂ)*I)).re ≤ 3/2 := by
    simp only [add_re,ofReal_re,mul_re,I_re,I_im,ofReal_im,mul_zero,zero_mul,sub_self,add_zero,hs]
    exact ⟨by linarith [(abs_le.1 hx).1],by linarith [(abs_le.1 hx).2]⟩
  have him : 1+|(s+((x : ℂ)+(u : ℂ)*I)).im| ≤ a+|u| := by
    simp only [add_im,ofReal_im,mul_im,I_re,I_im,ofReal_re,mul_one,zero_mul,add_zero,zero_add]
    dsimp [a]
    linarith [abs_add_le s.im u]
  have hpoly : (1+|(s+((x : ℂ)+(u : ℂ)*I)).im|)^2 ≤ 2*a^2*(1+u^2) := by
    have hp := pow_le_pow_left₀ (by positivity : 0 ≤ 1+|(s+((x : ℂ)+(u : ℂ)*I)).im|) him 2
    have haa : 1 ≤ a^2 := by nlinarith
    nlinarith [sq_nonneg (a-|u|),sq_abs u,mul_nonneg (sub_nonneg.2 haa) (sq_nonneg u)]
  have hpoly6 : (1+|(s+((x : ℂ)+(u : ℂ)*I)).im|)^6 ≤ 8*a^6*(1+u^2)^3 := by
    have h := pow_le_pow_left₀ (sq_nonneg _) hpoly 3
    convert! h using 1 <;> ring
  have he : ‖Complex.exp (((x : ℂ)+(u : ℂ)*I)^2)‖ ≤ Real.exp 1*Real.exp (-(u^2)) := by
    rw [Complex.norm_exp,← Real.exp_add]
    apply Real.exp_le_exp.mpr
    have hxx : x^2 ≤ 1 := by nlinarith [(abs_le.1 hx).1,(abs_le.1 hx).2]
    have hr : (((x : ℂ)+(u : ℂ)*I)^2).re = x^2-u^2 := by simp [pow_two,mul_re,mul_im]
    rw [hr]
    linarith
  rw [xiSquareGaussian,norm_mul,norm_pow]
  have hxi := pow_le_pow_left₀ (norm_nonneg _) (hbound _ hre.1 hre.2) 2
  have hp : (C*(1+|(s+((x : ℂ)+(u : ℂ)*I)).im|)^3)^2 ≤ C^2*(8*a^6*(1+u^2)^3) := by
    rw [mul_pow,← pow_mul]
    exact mul_le_mul_of_nonneg_left hpoly6 (sq_nonneg C)
  calc
    _ ≤ (C^2*(8*a^6*(1+u^2)^3))*(Real.exp 1*Real.exp (-(u^2))) :=
      mul_le_mul (hxi.trans hp) he (norm_nonneg _) (by positivity)
    _ = _ := by dsimp [K,xiGaussianEnvelope]; ring

end Legendre.Zeta
