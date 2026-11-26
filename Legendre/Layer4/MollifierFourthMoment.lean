/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.DirichletMeanValueWeighted
public import Legendre.Layer4.WeightedZetaMoment
public import Legendre.Layer4.DivisorEnergy
public import Mathlib.MeasureTheory.Function.L2Space

@[expose] public section
namespace Legendre.Density.Detector
open Complex MeasureTheory Set
open scoped ArithmeticFunction.Moebius

/-- Dirichlet-convolution coefficients of the squared finite mollifier. -/
noncomputable def mollifierSquareCoefficient (X : ℕ) : ArithmeticFunction ℂ :=
  truncate X (μ : ArithmeticFunction ℂ) * truncate X (μ : ArithmeticFunction ℂ)

private theorem mollifierSquareCoefficient_support (X n : ℕ) (hn : X*X < n) :
    mollifierSquareCoefficient X n = 0 := by
  rw [mollifierSquareCoefficient, ArithmeticFunction.mul_apply]
  apply Finset.sum_eq_zero
  intro p hp
  have hprod := (Nat.mem_divisorsAntidiagonal.mp hp).1
  by_cases h₁ : p.1 ≤ X
  · have h₂ : ¬ p.2 ≤ X := by
      intro he
      have h := Nat.mul_le_mul h₁ he
      omega
    simp [h₂]
  · simp [h₁]

private theorem norm_mollifierSquareCoefficient_le (X n : ℕ) :
    ‖mollifierSquareCoefficient X n‖ ≤ (n.divisors.card : ℝ) := by
  have hμ (m : ℕ) : ‖truncate X (μ : ArithmeticFunction ℂ) m‖ ≤ 1 := by
    rw [truncate_apply]
    split_ifs
    · simpa only [ArithmeticFunction.intCoe_apply] using norm_moebius_le_one m
    · simp
  unfold mollifierSquareCoefficient
  rw [ArithmeticFunction.mul_apply]
  calc
    _ ≤ ∑ p ∈ n.divisorsAntidiagonal,
        ‖truncate X (μ : ArithmeticFunction ℂ) p.1 * truncate X (μ : ArithmeticFunction ℂ) p.2‖ :=
      norm_sum_le _ _
    _ ≤ ∑ _p ∈ n.divisorsAntidiagonal, (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro p hp
      rw [norm_mul]
      exact (mul_le_mul (hμ p.1) (hμ p.2) (norm_nonneg _) zero_le_one).trans_eq (one_mul _)
    _ = _ := by rw [← Nat.map_div_right_divisors]; simp

/-- Squaring the mollifier produces one finite polynomial through (X^2). -/
theorem mollifier_sq_eq_finiteSeries (X : ℕ) (s : ℂ) :
    finiteSeries (μ : ArithmeticFunction ℂ) X s ^ 2 =
      finiteSeries (mollifierSquareCoefficient X) (X*X) s := by
  rw [← LSeries_eq_finiteSeries_of_support _ _ s (mollifierSquareCoefficient_support X),
    mollifierSquareCoefficient,
    ArithmeticFunction.LSeries_mul' (truncated_summable X _ s) (truncated_summable X _ s),
    LSeries_truncate_eq_finiteSeries, sq]

end Legendre.Density.Detector

namespace Legendre.Density.Moment
open Complex MeasureTheory Set
open scoped ArithmeticFunction.Moebius
open Detector Detector.Smooth

/-- The weighted local-length mean value separates the four-log diagonal
from the three-log off-diagonal term in the critical mollifier fourth moment. -/
theorem critical_mollifier_fourth_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 1 ≤ T →
      (∫ t in Icc (-T) T, ‖finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*(T*(1+Real.log (X*X : ℕ))^4+(X*X : ℕ)*(1+Real.log (X*X : ℕ))^3) := by
  obtain ⟨C,hC,hb⟩ := integral_subsetPolynomial_norm_sq_weighted
  refine ⟨C,hC, ?_⟩
  intro X hX T hT
  let N := X*X
  let c := mollifierSquareCoefficient X
  let S := Finset.Icc 1 N
  have hpoly (t : ℝ) : ‖finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^4 =
      ‖subsetPolynomial S (verticalCoefficients c (1/2)) t‖^2 := by
    have he : finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)^2 =
        subsetPolynomial S (verticalCoefficients c (1/2)) t := by
      rw [mollifier_sq_eq_finiteSeries X, show (1/2 : ℂ) = ((1/2 : ℝ) : ℂ) by norm_num]
      change complexDirichletPolynomial N c _ = _
      rw [complexDirichletPolynomial_vertical]
      rfl
    rw [← he, norm_pow, ← pow_mul]
  simp_rw [hpoly]
  have h := hb T 0 hT S (verticalCoefficients c (1/2)) (fun n hn => (Finset.mem_Icc.mp hn).1)
  rw [zero_sub, zero_add] at h
  apply h.trans
  apply mul_le_mul_of_nonneg_left _ hC.le
  have hpoint (n : ℕ) (hn : n ∈ S) :
      (T+(n : ℝ))*‖verticalCoefficients c (1/2) n‖^2 ≤
        T*((n.divisors.card : ℝ)^2/n)+(n.divisors.card : ℝ)^2 := by
    have hn₀ : 0 < n := (Finset.mem_Icc.mp hn).1
    have hnr : (0 : ℝ) < n := by exact_mod_cast hn₀
    rw [norm_verticalCoefficients _ _ hn₀, mul_pow, ← Real.rpow_mul_natCast hnr.le,
      Nat.cast_ofNat, show (-(1/2 : ℝ))*2 = -1 by norm_num, Real.rpow_neg_one]
    have hs := pow_le_pow_left₀ (norm_nonneg _) (norm_mollifierSquareCoefficient_le X n) 2
    calc
      _ ≤ (T+(n : ℝ))*((n.divisors.card : ℝ)^2*(n : ℝ)⁻¹) :=
        mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_right hs (by positivity)) (by positivity)
      _ = _ := by field_simp [hnr.ne']
  calc
    _ ≤ ∑ n ∈ S, (T*((n.divisors.card : ℝ)^2/n)+(n.divisors.card : ℝ)^2) :=
      Finset.sum_le_sum hpoint
    _ = T*(∑ n ∈ S, (n.divisors.card : ℝ)^2/n)+(∑ n ∈ S, (n.divisors.card : ℝ)^2) := by
      rw [Finset.sum_add_distrib, Finset.mul_sum]
    _ ≤ _ := add_le_add (mul_le_mul_of_nonneg_left (divisor_square_harmonic N) (by linarith))
      (Arithmetic.DivisorSquareMean.divisor_square_mean N)

/-- Whole-line weighted fourth moment with the same logarithmic losses. -/
theorem weighted_mollifier_fourth_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 2 ≤ T →
      Integrable (fun t : ℝ => momentHeightWeight T t*
        ‖finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ∧
      (∫ t : ℝ, momentHeightWeight T t*
        ‖finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*(T*(1+Real.log (X*X : ℕ))^4+(X*X : ℕ)*(1+Real.log (X*X : ℕ))^3) := by
  obtain ⟨C,hC,hb⟩ := critical_mollifier_fourth_moment
  refine ⟨C*momentHeightEnergyConstant 0,mul_pos hC (momentHeightEnergyConstant_pos 0),?_⟩
  intro X hX T hT
  let N := X*X
  let L := 1+Real.log N
  have hL : 0 ≤ L := by
    have hN : (1 : ℝ) ≤ N := by exact_mod_cast (one_le_mul hX hX)
    dsimp [L]
    linarith [Real.log_nonneg hN]
  let A := C*(T*L^4+(N : ℝ)*L^3)
  have hball (j : ℕ) : (∫ t in momentHeightBall T j,
      ‖finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        A*(2 : ℝ)^j*(j+1 : ℝ)^0 := by
    have hp : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
    have hH : 1 ≤ (2 : ℝ)^j*T := by nlinarith
    apply (hb X hX ((2 : ℝ)^j*T) hH).trans
    dsimp only [A,L,N]
    simp only [pow_zero, mul_one]
    have h' := mul_le_mul_of_nonneg_right hp
      (show 0 ≤ C*(N : ℝ)*L^3 from mul_nonneg (by positivity) (pow_nonneg hL 3))
    change C*((2 : ℝ)^j*T*L^4+(N : ℝ)*L^3) ≤ C*(T*L^4+(N : ℝ)*L^3)*(2 : ℝ)^j
    nlinarith
  obtain ⟨hi,hm⟩ := moment_weighted_moment
    (fun t : ℝ => ‖finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t : ℂ)*I)‖^4)
    ((mollifier_critical_continuous X).norm.pow 4) (fun _ => by positivity)
    T (by linarith) A (by dsimp [A]; positivity) 0 hball
  refine ⟨hi,hm.trans_eq ?_⟩
  dsimp [A,L,N]
  ring

/-- Whole-line second moment of the critical product, from the two proved
fourth moments. The (X^2) part keeps the three-log mollifier factor. -/
theorem weighted_criticalProduct_second_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 2 ≤ T →
      let L := 1+Real.log (X*X : ℕ)
      Integrable (fun v : ℝ => momentHeightWeight T v*‖criticalProduct X 0 v‖^2) ∧
      (∫ v : ℝ, momentHeightWeight T v*‖criticalProduct X 0 v‖^2) ≤
        C*Real.sqrt (T*(Real.log T)^4 * (T*L^4+(X*X : ℕ)*L^3)) := by
  obtain ⟨A,hA,hz⟩ := weighted_zeta_fourth_moment_log_four
  obtain ⟨B,hB,hm⟩ := weighted_mollifier_fourth_moment
  refine ⟨Real.sqrt (A*B), Real.sqrt_pos.2 (mul_pos hA hB), ?_⟩
  intro X hX T hT
  dsimp only
  let w := momentHeightWeight T
  let z := fun v : ℝ => ‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖
  let m := fun v : ℝ => ‖finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖
  let F := fun v => Real.sqrt (w v)*z v^2
  let G := fun v => Real.sqrt (w v)*m v^2
  have hF (v : ℝ) : F v^2 = w v*z v^4 := by
    dsimp [F]
    rw [mul_pow, Real.sq_sqrt (momentHeightWeight_nonneg T v), ← pow_mul]
  have hG (v : ℝ) : G v^2 = w v*m v^4 := by
    dsimp [G]
    rw [mul_pow, Real.sq_sqrt (momentHeightWeight_nonneg T v), ← pow_mul]
  have hFG (v : ℝ) : F v*G v = momentHeightWeight T v*‖criticalProduct X 0 v‖^2 := by
    dsimp [F, G, w, z, m]
    simp only [criticalProduct, zero_add, norm_mul, mul_pow]
    rw [show √(momentHeightWeight T v) * ‖riemannZeta (1/2+↑v*I)‖^2 *
          (√(momentHeightWeight T v) * ‖finiteSeries (↑μ) X (1/2+↑v*I)‖^2) =
        (√(momentHeightWeight T v))^2 *
          (‖riemannZeta (1/2+↑v*I)‖^2 * ‖finiteSeries (↑μ) X (1/2+↑v*I)‖^2) by ring,
      Real.sq_sqrt (momentHeightWeight_nonneg T v)]
  have hFi : MemLp F 2 volume := by
    have hc : Continuous F :=
      (Real.continuous_sqrt.comp (momentHeightWeight_continuous T)).mul (zeta_critical_continuous.norm.pow 2)
    apply (memLp_two_iff_integrable_sq hc.aestronglyMeasurable).2
    simpa only [hF] using (hz T hT).1
  have hGi : MemLp G 2 volume := by
    have hc : Continuous G :=
      (Real.continuous_sqrt.comp (momentHeightWeight_continuous T)).mul ((mollifier_critical_continuous X).norm.pow 2)
    apply (memLp_two_iff_integrable_sq hc.aestronglyMeasurable).2
    simpa only [hG] using (hm X hX T hT).1
  constructor
  · have he : F*G = fun v => momentHeightWeight T v*‖criticalProduct X 0 v‖^2 :=
      funext hFG
    rw [← he]
    exact hFi.integrable_mul hGi
  · have hh := integral_mul_le_Lp_mul_Lq_of_nonneg
      (by norm_num [Real.holderConjugate_iff] : Real.HolderConjugate 2 2)
      (Filter.Eventually.of_forall fun v => by dsimp [F]; positivity)
      (Filter.Eventually.of_forall fun v => by dsimp [G]; positivity)
      (by simpa : MemLp F (ENNReal.ofReal 2) volume) (by simpa : MemLp G (ENNReal.ofReal 2) volume)
    simp only [hFG, Real.rpow_ofNat, ← Real.sqrt_eq_rpow, hF, hG] at hh
    apply hh.trans
    let Z := T*(Real.log T)^4
    let L := 1+Real.log (X*X : ℕ)
    let M := T*L^4+(X*X : ℕ)*L^3
    have hL : 0 ≤ L := by
      have hN : (1 : ℝ) ≤ (X*X : ℕ) := by exact_mod_cast (one_le_mul hX hX)
      dsimp [L]
      linarith [Real.log_nonneg hN]
    calc
      _ ≤ Real.sqrt (A*Z)*Real.sqrt (B*M) :=
        mul_le_mul (Real.sqrt_le_sqrt (by simpa only [Z, mul_assoc] using (hz T hT).2)) (Real.sqrt_le_sqrt (hm X hX T hT).2)
          (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)
      _ = _ := by
        rw [← Real.sqrt_mul (by positivity : 0 ≤ A*Z), ← Real.sqrt_mul (by positivity : 0 ≤ A*B)]
        congr 1
        ring

end Legendre.Density.Moment
