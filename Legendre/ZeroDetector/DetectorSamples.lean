/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZeroDetector.ActualZetaDetector
public import Legendre.ComplexDirichletSampling
public import Legendre.ZeroDetector.CoefficientEnergy

/-!
# Connecting the actual two-branch detector to separated zero samples

The two detector energies are explicit. Neither branch is omitted, and the
real parts of the sampled zeros may vary throughout the strip.
-/

@[expose] public section

namespace Legendre.Density.Detector

open Complex Set
open scoped ArithmeticFunction.Moebius ArithmeticFunction.zeta

/-- Coefficients with the cancellation range removed. -/
noncomputable def detectorTailCoefficients (X N n : ℕ) : ℂ :=
  if X < n then mollifierCoefficient X N n else 0

theorem detectorPolynomial_eq_complexDirichlet (X N : ℕ) (s : ℂ) :
    detectorPolynomial X N s = complexDirichletPolynomial (X*N) (detectorTailCoefficients X N) s := by
  classical
  unfold detectorPolynomial complexDirichletPolynomial detectorTailCoefficients
  simp only [ite_mul,zero_mul]
  rw [← Finset.sum_filter]
  congr 1
  ext n
  simp only [Finset.mem_filter,Finset.mem_Icc,Finset.mem_Ioc]
  omega

theorem norm_detectorTailCoefficients_le (X N n : ℕ) :
    ‖detectorTailCoefficients X N n‖ ≤ (n.divisors.card : ℝ) := by
  unfold detectorTailCoefficients
  split_ifs
  · exact norm_mollifierCoefficient_le X N n
  · simp

/-- The polar branch is controlled away from height zero, with its full N weight. -/
theorem norm_poleCompensation_le {X N : ℕ} (hN : 1 ≤ N) {s : ℂ} {σ h : ℝ}
    (hσ : σ ≤ s.re) (hh : 0 < h) (hheight : h ≤ |s.im|) :
    ‖poleCompensation X N s‖ ≤
      ((N : ℝ)^(1-σ)/h)*‖finiteSeries (μ : ArithmeticFunction ℂ) X s‖ := by
  have hnp : 0 < N := Nat.zero_lt_one.trans_le hN
  have hden : h ≤ ‖s-1‖ := hheight.trans (by simpa using abs_im_le_norm (s-1))
  have hpow : ‖(N : ℂ)^(1-s)‖ ≤ (N : ℝ)^(1-σ) := by
    rw [norm_natCast_cpow_of_pos hnp]
    simp only [sub_re,one_re]
    exact Real.rpow_le_rpow_of_exponent_le (by exact_mod_cast hN) (by linarith)
  rw [poleCompensation,norm_mul,norm_div,mul_comm]
  apply mul_le_mul_of_nonneg_right _ (norm_nonneg _)
  exact (div_le_div_of_nonneg_right hpow (norm_nonneg _)).trans
    (div_le_div_of_nonneg_left (Real.rpow_nonneg (Nat.cast_nonneg _) _) hh hden)

/-- The exact sample coefficient from the varying-real-part sampling theorem. -/
noncomputable def complexSampleCoefficient (N H : ℕ) : ℝ :=
  (2+(Real.log N)^2)*(1+2*Real.log N)*((H : ℝ)+1+2*Real.pi*(N : ℝ))

/-- A separated set of actual zeros is controlled by the energies of both detector terms. -/
theorem actual_zero_sample_card_le (S : Finset ℂ) {H X : ℕ} (hH : 1 ≤ H) (hX : 1 < X)
    {σ : ℝ} (hσ : σ ∈ Icc (1/2) 1)
    (hzero : ∀ ρ ∈ S, Zeta.NontrivialZero ρ)
    (hre : ∀ ρ ∈ S, σ ≤ ρ.re)
    (hheight : ∀ ρ ∈ S, 1 ≤ ρ.im ∧ ρ.im ≤ (H : ℝ))
    (hsep : ∀ ρ ∈ S, ∀ z ∈ S, ρ ≠ z → 1 ≤ |ρ.im-z.im|) :
    (S.card : ℝ) ≤ (64/9 : ℝ)*(
      complexSampleCoefficient (X*zetaDetectorLength H X) H*
        coefficientEnergy (Finset.Icc 1 (X*zetaDetectorLength H X))
          (verticalCoefficients (detectorTailCoefficients X (zetaDetectorLength H X)) σ)+
      ((zetaDetectorLength H X : ℝ)^(1-σ))^2*complexSampleCoefficient X H*
        coefficientEnergy (Finset.Icc 1 X)
          (verticalCoefficients (μ : ArithmeticFunction ℂ) σ)) := by
  let N := zetaDetectorLength H X
  let W := (N : ℝ)^(1-σ)
  have hX1 : 1 ≤ X := hX.le
  have hN : X ≤ N := zetaDetectorLength_ge hH hX1
  have hNX : 1 < X*N := by nlinarith
  have hpoint (ρ : ℂ) (hρ : ρ ∈ S) : (3/8 : ℝ)^2 ≤
      ‖detectorPolynomial X N ρ‖^2+
        W^2*‖finiteSeries (μ : ArithmeticFunction ℂ) X ρ‖^2 := by
    have hz := hzero ρ hρ
    have hρ1 : ρ ≠ 1 := by intro he; have hh := hz.2.2; simp only [he,one_re,lt_self_iff_false] at hh
    have hβ := hσ.1.trans (hre ρ hρ)
    have hhi : |ρ.im| ≤ (H : ℝ) := by rw [abs_of_nonneg (by linarith [(hheight ρ hρ).1])]; exact (hheight ρ hρ).2
    have ha := actual_zero_detector_alternative hH hX1 hz.1 hρ1 hβ hz.2.2.le hhi
    have hp := norm_poleCompensation_le (X := X) (hX1.trans hN) (hre ρ hρ) zero_lt_one
      (by rw [abs_of_nonneg (by linarith [(hheight ρ hρ).1])]; exact (hheight ρ hρ).1)
    simp only [div_one] at hp
    have hW : 0 ≤ W := Real.rpow_nonneg (Nat.cast_nonneg N) _
    rcases ha with ha | ha
    · have hs := pow_le_pow_left₀ (by norm_num : (0 : ℝ) ≤ 3/8) ha 2
      nlinarith [mul_nonneg (sq_nonneg W) (sq_nonneg ‖finiteSeries (μ : ArithmeticFunction ℂ) X ρ‖)]
    · have hs := pow_le_pow_left₀ (by norm_num : (0 : ℝ) ≤ 3/8) (ha.trans hp) 2
      simpa only [mul_pow] using hs.trans (le_add_of_nonneg_left (sq_nonneg ‖detectorPolynomial X N ρ‖))
  have hbound (K : ℕ) (a : ℕ → ℂ) (hK : 1 < K) :
      (∑ ρ ∈ S, ‖complexDirichletPolynomial K a ρ‖^2) ≤
        complexSampleCoefficient K H*coefficientEnergy (Finset.Icc 1 K) (verticalCoefficients a σ) := by
    have h := sum_complexDirichletPolynomial_samples_le S Complex.im Complex.re K a hK
      (δ := 1) (L := 0) (U := (H : ℝ)+1) (σ := σ) (b := 1)
      (by norm_num) (by positivity) hσ.2 (by linarith [hσ.1])
      (fun ρ hρ => ⟨hre ρ hρ,(hzero ρ hρ).2.2.le⟩)
      (fun ρ hρ => ⟨by linarith [(hheight ρ hρ).1],by linarith [(hheight ρ hρ).2]⟩) hsep
    simpa only [re_add_im,inv_one,sub_zero,complexSampleCoefficient] using! h
  have hd := hbound (X*N) (detectorTailCoefficients X N) hNX
  have hm := hbound X (μ : ArithmeticFunction ℂ) hX
  simp_rw [← detectorPolynomial_eq_complexDirichlet] at hd
  have hmu (ρ : ℂ) : complexDirichletPolynomial X (μ : ArithmeticFunction ℂ) ρ =
      finiteSeries (μ : ArithmeticFunction ℂ) X ρ := rfl
  simp_rw [hmu] at hm
  have he : (S.card : ℝ)*(3/8 : ℝ)^2 = ∑ _ρ ∈ S, (3/8 : ℝ)^2 := by simp
  have hsum := Finset.sum_le_sum hpoint
  rw [← he,Finset.sum_add_distrib,← Finset.mul_sum] at hsum
  have hupper := hsum.trans (add_le_add hd (mul_le_mul_of_nonneg_left hm (sq_nonneg W)))
  dsimp [N,W] at hupper
  nlinarith

end Legendre.Density.Detector
