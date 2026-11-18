/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GaussianMellinPole
public import Legendre.Layer4.XiMellinRemainder
public import Legendre.Layer4.XiHeadMean

/-! Fourth-log mean for the small-index part of the xi series. -/

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set
open Density Density.Moment

noncomputable def gaussianPoleCoefficient (c x : ℝ) : ℂ :=
  ∫ u : ℝ, Complex.exp (((c : ℂ)+(u : ℂ)*I)^2+
    ((c : ℂ)+(u : ℂ)*I)*(x : ℂ))/((c : ℂ)+(u : ℂ)*I)

theorem xiGaussianPole_div_cpow {N : ℝ} (hN : 0 < N) {n : ℕ} (hn : 1 ≤ n)
    (w : ℂ) :
    xiGaussianPole N w/(n : ℂ)^w =
      Complex.exp (w^2+w*(Real.log (N/n) : ℂ))/w := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hnC : (n : ℂ) ≠ 0 := by exact_mod_cast (show n ≠ 0 by omega)
  have hNC : (N : ℂ) ≠ 0 := by exact_mod_cast hN.ne'
  rw [xiGaussianPole, Complex.cpow_def_of_ne_zero hNC, Complex.cpow_def_of_ne_zero hnC]
  rw [Real.log_div hN.ne' hnR.ne', Complex.ofReal_sub, Complex.ofReal_log hN.le,
    Complex.ofReal_log hnR.le, Complex.ofReal_natCast]
  rw [div_div, mul_comm w (Complex.exp _), ← div_div, mul_div_assoc,
    ← Complex.exp_sub, ← Complex.exp_add]
  congr 2
  ring

theorem xiGaussianPole_vertical_continuous {N c : ℝ} (hN : 0 < N) (hc : 0 < c) :
    Continuous (fun u : ℝ => xiGaussianPole N ((c : ℂ)+(u : ℂ)*I)) := by
  let w := fun u : ℝ => (c : ℂ)+(u : ℂ)*I
  have hw : Continuous w := by dsimp [w]; fun_prop
  have hN₀ : (N : ℂ) ≠ 0 := by exact_mod_cast hN.ne'
  have hpow : Continuous (fun u => (N : ℂ)^(w u)) := by
    simp_rw [Complex.cpow_def_of_ne_zero hN₀]
    exact (continuous_const.mul hw).cexp
  apply (hpow.mul (hw.pow 2).cexp).div hw
  intro u h
  have h0 := congrArg Complex.re h
  exact hc.ne' (by simpa [w] using h0)

theorem xiGaussianPole_polynomial_integral (N : ℝ) (hN : 0 < N)
    (S : Finset ℕ) (hS : ∀ n ∈ S, 1 ≤ n) (c t : ℝ) (hc : 0 < c) :
    let s : ℂ := 1/2+(t : ℂ)*I
    let w := fun u : ℝ => (c : ℂ)+(u : ℂ)*I
    (Integrable (fun u => xiGaussianPole N (w u)*
      finiteMellin S (LSeries.term zetaSquareCoefficient s) (w u))) ∧
    (∫ u : ℝ, xiGaussianPole N (w u)*
      finiteMellin S (LSeries.term zetaSquareCoefficient s) (w u)) =
        subsetPolynomial S (fun n => gaussianPoleCoefficient c (Real.log (N/n))*
          verticalCoefficients zetaSquareCoefficient (1/2) n) t := by
  dsimp only
  simp_rw [finiteMellin, Finset.mul_sum, ← mul_div_assoc,
    mul_comm (xiGaussianPole _ _) (LSeries.term _ _ _), mul_div_assoc]
  have hterm (n : ℕ) (hn : n ∈ S) :
      Integrable (fun u : ℝ => LSeries.term zetaSquareCoefficient ((1/2 : ℂ)+(t : ℂ)*I) n*
        (xiGaussianPole N ((c : ℂ)+(u : ℂ)*I)/(n : ℂ)^((c : ℂ)+(u : ℂ)*I))) := by
    simp_rw [xiGaussianPole_div_cpow hN (hS n hn)]
    exact (gaussian_pole_line_integrable c _ hc).const_mul _
  refine ⟨integrable_finsetSum S hterm, ?_⟩
  rw [integral_finsetSum S hterm]
  unfold subsetPolynomial exponentialSum
  apply Finset.sum_congr rfl
  intro n hn
  simp_rw [xiGaussianPole_div_cpow hN (hS n hn), integral_const_mul]
  rw [← gaussianPoleCoefficient]
  rw [show (1/2 : ℂ)+(t : ℂ)*I = ((1/2 : ℝ) : ℂ)+(t : ℂ)*I by push_cast; rfl,
    LSeries_term_vertical _ _ _ (Nat.zero_lt_one.trans_le (hS n hn))]
  ring

theorem xiFiniteSquare_head_pointwise :
    ∃ K : ℝ, 0 < K ∧ ∀ (N T c t : ℝ), 1 ≤ T → 10*T ≤ N → N ≤ 16*T →
      0 < c → c ≤ 1 → T/2 ≤ |t| → |t| ≤ T →
      ∀ (S : Finset ℕ), (∀ n ∈ S, 1 ≤ n) →
      ‖∑ n ∈ S, xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2 ≤
        2*‖subsetPolynomial S (fun n => gaussianPoleCoefficient c (Real.log (N/n))*
          verticalCoefficients zetaSquareCoefficient (1/2) n) t‖^2+
        2*(K*N^c)^2*(∫ u : ℝ, momentGaussian u)*
          ∫ u : ℝ, momentGaussian u*
            ‖subsetPolynomial S (verticalCoefficients zetaSquareCoefficient (1/2+c)) (t+u)‖^2 := by
  obtain ⟨K,hK,hbound⟩ := xiPoleRemainder_gaussian_bound
  refine ⟨K,hK,?_⟩
  intro N T c t hT hNlo hNhi hc hc1 ht₁ ht₂ S hS
  have hN : 0 < N := by linarith
  let s : ℂ := 1/2+(t : ℂ)*I
  let w := fun u : ℝ => (c : ℂ)+(u : ℂ)*I
  let a := verticalCoefficients zetaSquareCoefficient (1/2+c)
  let p := fun u : ℝ => subsetPolynomial S a (t+u)
  let f := fun u => xiPoleRemainder N s (w u)*p u
  let g := fun u => xiGaussianPole N (w u)*finiteMellin S (LSeries.term zetaSquareCoefficient s) (w u)
  have hs : s.re = 1/2 := by simp [s]
  have hp : Continuous p := (subsetPolynomial_continuous S a).comp (continuous_const.add continuous_id)
  have hf : Continuous f :=
    (((xiMellinKernel_vertical_continuous c hc).comp (continuous_const.prodMk continuous_id)).sub
      (xiGaussianPole_vertical_continuous hN hc)).mul hp
  have hb (u : ℝ) : ‖f u‖ ≤ (K*N^c)*momentGaussian u*‖p u‖ := by
    rw [show f u = xiPoleRemainder N s (w u)*p u from rfl, norm_mul]
    exact mul_le_mul_of_nonneg_right (hbound N T c t u hT hNlo hNhi hc hc1 ht₁ ht₂) (norm_nonneg _)
  have hfi : Integrable f := by
    apply (momentGaussian_integrable.const_mul ((K*N^c)*∑ n ∈ S, ‖a n‖)).mono'
      hf.aestronglyMeasurable
    filter_upwards with u
    calc
      _ ≤ (K*N^c)*momentGaussian u*(∑ n ∈ S, ‖a n‖) :=
        (hb u).trans (mul_le_mul_of_nonneg_left (subsetPolynomial_norm S a (t+u))
          (by have := momentGaussian_pos u; positivity))
      _ = _ := by ring
  have hfe := gaussian_integral_cauchy f (fun u => ‖p u‖) (K*N^c) (∑ n ∈ S, ‖a n‖)
    hp.norm (fun _ => norm_nonneg _) (fun u => subsetPolynomial_norm S a (t+u)) hb
  obtain ⟨hgi,hge⟩ := xiGaussianPole_polynomial_integral N hN S hS c t hc
  have he :
      (∫ u : ℝ, xiFiniteKernel s S (LSeries.term zetaSquareCoefficient s) (w u)) =
        (∫ u : ℝ, g u)+(∫ u : ℝ, f u) := by
    rw [← integral_add hgi hfi]
    apply integral_congr_ae
    filter_upwards with u
    dsimp only [g, f, p, a, s, w]
    rw [← finiteMellin_original_polynomial S hS c t u, xiFiniteKernel, xiPoleRemainder]
    ring
  change ‖∑ n ∈ S, xiSquareIntegralTerm s n‖^2 ≤ _
  rw [xiSquareIntegralTerm_sum_shift hs S hS c hc hc1]
  change ‖(2*(Real.pi : ℂ))⁻¹*
    (∫ u : ℝ, xiFiniteKernel s S (LSeries.term zetaSquareCoefficient s) (w u))‖^2 ≤ _
  rw [he,norm_mul]
  calc
    _ ≤ ‖(∫ u : ℝ, g u)+(∫ u : ℝ, f u)‖^2 :=
      pow_le_pow_left₀ (by positivity) (mul_le_of_le_one_left (norm_nonneg _) norm_two_pi_inv_le_one) 2
    _ ≤ 2*‖∫ u : ℝ, g u‖^2+2*‖∫ u : ℝ, f u‖^2 := by
      have h := pow_le_pow_left₀ (norm_nonneg _) (norm_add_le (∫ u, g u) (∫ u, f u)) 2
      nlinarith [sq_nonneg (‖∫ u, g u‖-‖∫ u, f u‖)]
    _ ≤ _ := by
      rw [show (∫ u : ℝ, g u) = _ from hge]
      apply add_le_add_right
      simpa only [p, a, mul_assoc] using mul_le_mul_of_nonneg_left hfe (by norm_num : (0 : ℝ) ≤ 2)

theorem xiFiniteSquare_head_log_four :
    ∃ C : ℝ, 0 < C ∧ ∀ N : ℕ, ∀ T : ℝ, 1 ≤ T →
      1 ≤ Real.log N → 10*T ≤ N → (N : ℝ) ≤ 16*T →
      (∫ t in Icc (T/2) T, ‖∑ n ∈ Finset.Icc 1 N,
        xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2) ≤
          C*((N : ℝ)+T)*(Real.log N)^4 := by
  obtain ⟨K,hK,hpoint⟩ := xiFiniteSquare_head_pointwise
  let B := ‖(Real.pi : ℂ)^(1/2 : ℂ)‖ * Real.sqrt (Real.pi/(1/4))
  let G := ∫ u : ℝ, momentGaussian u
  let R := (K*Real.exp 1)^2
  have hG : 0 < G := momentGaussian_integral_pos
  refine ⟨32*(2+2*Real.pi)*(B^2+R*G^2), by
    dsimp only [R]; have := Real.pi_pos; positivity, ?_⟩
  intro N T hT hL hNlo hNhi
  let S := Finset.Icc 1 N
  let c := 1/Real.log N
  let a := verticalCoefficients zetaSquareCoefficient (1/2+c)
  let b := fun (n : ℕ) => gaussianPoleCoefficient c (Real.log ((N : ℝ)/n))*
    verticalCoefficients zetaSquareCoefficient (1/2) n
  have hc : 0 < c := div_pos zero_lt_one (by linarith)
  have hc1 : c ≤ 1 := (div_le_one (by linarith)).mpr hL
  have hN : (0 : ℝ) < N := by linarith
  have hpow : (N : ℝ)^c = Real.exp 1 := by
    rw [Real.rpow_def_of_pos hN]
    congr 1
    dsimp [c]
    field_simp
  have hS : ∀ n ∈ S, 1 ≤ n := fun n hn => (Finset.mem_Icc.mp hn).1
  have hsub : Icc (T/2) T ⊆ Icc (-T) T :=
    fun t ht => ⟨by linarith [ht.1], ht.2⟩
  let main := fun t => ‖subsetPolynomial S b t‖^2
  let rest := fun t => ∫ u : ℝ, momentGaussian u*‖subsetPolynomial S a (t+u)‖^2
  have hm : IntegrableOn main (Icc (-T) T) :=
    ((subsetPolynomial_continuous S b).norm.pow 2).continuousOn.integrableOn_Icc
  have hr : IntegrableOn rest (Icc (-T) T) :=
    (gaussian_subset_integrable S a T).integral_prod_left
  have hmi := hm.mono_set hsub
  have hri := hr.mono_set hsub
  have he : (∫ t in Icc (T/2) T, ‖∑ n ∈ S,
      xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2) ≤
      2*(∫ t in Icc (T/2) T, main t)+2*R*G*(∫ t in Icc (T/2) T, rest t) := by
    rw [← integral_const_mul, ← integral_const_mul, ← integral_add (hmi.const_mul 2) (hri.const_mul _)]
    apply integral_mono_ae (((xiFiniteSquare_continuousOn S hS T hT).norm.pow 2).integrableOn_Icc.mono_set hsub)
      ((hmi.const_mul 2).add (hri.const_mul _))
    filter_upwards [ae_restrict_mem measurableSet_Icc] with t ht
    have ht0 : 0 ≤ t := by linarith [ht.1]
    have h := hpoint N T c t hT hNlo hNhi hc hc1
      (by simpa only [abs_of_nonneg ht0] using ht.1)
      (by simpa only [abs_of_nonneg ht0] using ht.2) S hS
    rw [hpow] at h
    exact h
  have hmr : (∫ t in Icc (T/2) T, main t) ≤
      (2*T+2*Real.pi*(N : ℝ))*coefficientEnergy S b := by
    apply (setIntegral_mono_set hm (Filter.Eventually.of_forall fun _ => sq_nonneg _)
      (Filter.Eventually.of_forall hsub)).trans
    simpa only [main, add_zero] using subsetPolynomial_shifted_mean S b N (Subset.rfl) T 0 (by linarith)
  have hrr : (∫ t in Icc (T/2) T, rest t) ≤
      G*(2*T+2*Real.pi*(N : ℝ))*coefficientEnergy S a := by
    apply (setIntegral_mono_set hr (Filter.Eventually.of_forall fun t =>
      integral_nonneg fun u => mul_nonneg (momentGaussian_pos u).le (sq_nonneg _))
      (Filter.Eventually.of_forall hsub)).trans
    exact gaussian_subset_mean S a N (Subset.rfl) T (by linarith)
  have h0 : coefficientEnergy S (verticalCoefficients zetaSquareCoefficient (1/2+0)) ≤
      (1+Real.log N)^4 := divisor_shifted_head N 0 le_rfl
  rw [add_zero] at h0
  have hb : coefficientEnergy S b ≤ B^2*(1+Real.log N)^4 := by
    calc
      _ ≤ B^2*coefficientEnergy S (verticalCoefficients zetaSquareCoefficient (1/2)) := by
        unfold coefficientEnergy
        rw [Finset.mul_sum]
        apply Finset.sum_le_sum
        intro n _
        dsimp [b]
        rw [norm_mul, mul_pow]
        exact mul_le_mul_of_nonneg_right
          (pow_le_pow_left₀ (norm_nonneg _) (gaussian_pole_line_uniform c _ hc) 2) (sq_nonneg _)
      _ ≤ _ := mul_le_mul_of_nonneg_left
        h0 (sq_nonneg _)
  have ha : coefficientEnergy S a ≤ (1+Real.log N)^4 := divisor_shifted_head N c hc.le
  have hscale : 2*T+2*Real.pi*(N : ℝ) ≤ (2+2*Real.pi)*((N : ℝ)+T) := by
    nlinarith [Real.pi_pos]
  have hlog : (1+Real.log N)^4 ≤ 16*(Real.log N)^4 := by
    have h := pow_le_pow_left₀ (by linarith : 0 ≤ 1+Real.log N)
      (by linarith : 1+Real.log N ≤ 2*Real.log N) 4
    nlinarith
  have hQ : 0 ≤ 2*T+2*Real.pi*(N : ℝ) := by have := Real.pi_pos; positivity
  calc
    _ ≤ 2*(∫ t in Icc (T/2) T, main t)+2*R*G*(∫ t in Icc (T/2) T, rest t) := he
    _ ≤ 2*((2*T+2*Real.pi*(N : ℝ))*(B^2*(1+Real.log N)^4))+
        2*R*G*(G*(2*T+2*Real.pi*(N : ℝ))*(1+Real.log N)^4) :=
      add_le_add (mul_le_mul_of_nonneg_left (hmr.trans (mul_le_mul_of_nonneg_left hb hQ)) (by norm_num))
        (mul_le_mul_of_nonneg_left (hrr.trans
          (mul_le_mul_of_nonneg_left ha (mul_nonneg hG.le hQ))) (by positivity))
    _ = (2*T+2*Real.pi*(N : ℝ))*(1+Real.log N)^4*(2*(B^2+R*G^2)) := by ring
    _ ≤ ((2+2*Real.pi)*((N : ℝ)+T))*(16*(Real.log N)^4)*(2*(B^2+R*G^2)) :=
      mul_le_mul_of_nonneg_right (mul_le_mul hscale hlog (by positivity)
        (by have := Real.pi_pos; positivity)) (by positivity)
    _ = _ := by ring

end Legendre.Zeta
