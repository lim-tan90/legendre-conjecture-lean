/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.SmoothedDivisorMoment
public import Legendre.Layer4.MollifiedZetaJensen
public import Legendre.Layer4.DirichletMeanValueWeighted
public import Legendre.Layer4.PositiveLimit

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set Filter
open Detector Detector.Smooth
open scoped Topology

private theorem mollifiedError_right_tendsto (X : ℕ) (hX : 1 ≤ X) {a : ℝ}
    (ha : 1 < a) (t : ℝ) :
    Tendsto (fun N : ℕ => subsetPolynomial (Finset.Ioc X N)
      (verticalCoefficients (detectorCoefficient X) a) t) atTop
      (𝓝 (mollifiedError X ((a : ℂ)+(t : ℂ)*I))) := by
  classical
  let s := (a : ℂ)+(t : ℂ)*I
  have hs : 1 < s.re := by simpa [s] using ha
  let f := LSeries.term (detectorCoefficient X) s
  let g := fun n => if X < n then f n else 0
  let k := fun n : ℕ => if n = 1 then (1 : ℂ) else 0
  have hf : Summable f := detectorCoefficient_summable X hs
  have hk : Summable k := by
    exact (hasSum_single 1 (f := k) (fun n hn => by simp [k, hn])).summable
  have he (n : ℕ) : f n = k n+g n := by
    rcases eq_or_ne n 0 with rfl|hn
    · simp [f,g,k]
    by_cases h1 : n = 1
    · subst n
      simp [f,g,k, detectorCoefficient_one hX, not_lt_of_ge hX]
    by_cases hnX : X < n
    · simp [g,k,hnX,h1]
    · simp only [g,k,h1,hnX,ite_false,zero_add]
      dsimp only [f]
      rw [LSeries.term_of_ne_zero hn, detectorCoefficient_small (by omega) (by omega), zero_div]
  have hg : Summable g := by
    convert hf.sub hk using 1
    funext n
    change g n = f n-k n
    rw [he n,add_sub_cancel_left]
  have htsum : mollifiedError X s = ∑' n, g n := by
    rw [mollifiedError, ← mollifier_zeta_product X hs, LSeries]
    change (∑' n, f n)-1 = _
    simp_rw [he]
    rw [hk.tsum_add hg]
    simp [k]
  rw [show ((a : ℂ)+(t : ℂ)*I) = s from rfl,htsum]
  have hsum (N : ℕ) :
      subsetPolynomial (Finset.Ioc X N) (verticalCoefficients (detectorCoefficient X) a) t =
        ∑ n ∈ Finset.range (N+1), g n := by
    have hm : Finset.Ioc X N = (Finset.range (N+1)).filter (fun n => X < n) := by
      ext n
      simp only [Finset.mem_filter, Finset.mem_Ioc, Finset.mem_range]
      omega
    rw [show (∑ n ∈ Finset.range (N+1), g n) =
        ∑ n ∈ (Finset.range (N+1)).filter (fun n => X < n), f n from (Finset.sum_filter _ _).symm, ← hm]
    unfold subsetPolynomial exponentialSum
    apply Finset.sum_congr rfl
    intro n hn
    have hnN : 0 < n := zero_lt_one.trans_le (show 1 ≤ n by have := (Finset.mem_Ioc.mp hn).1; omega)
    have hnpos : (0 : ℝ) < n := by exact_mod_cast hnN
    have hn0 : (n : ℂ) ≠ 0 := by exact_mod_cast hnN.ne'
    rw [realPhase_neg_log_eq_cpow hnpos t, ofReal_natCast]
    unfold verticalCoefficients
    dsimp only [f]
    rw [LSeries.term_of_ne_zero hnN.ne', div_eq_mul_inv, ← Complex.cpow_neg, mul_assoc, ← cpow_add _ _ hn0]
    congr 2
    dsimp [s]
    ring
  simp_rw [hsum]
  exact hg.hasSum.tendsto_sum_nat.comp (tendsto_add_atTop_nat 1)

/-- To the right of the compact-contour strip, the absolutely convergent
tail gives a uniform moment with the same mollifier and no upper limit on the real part. -/
theorem mollifiedError_right_second_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 1 ≤ T → T ≤ X →
      ∀ a : ℝ, 7/6 ≤ a →
      (∫ t in Icc (-T) T, ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
        C*(1+Real.log X)^3 := by
  obtain ⟨P,hP,hp⟩ := integral_subsetPolynomial_norm_sq_weighted
  obtain ⟨Q,hQ,hq⟩ := uniform_divisor_square_tail
  refine ⟨2*P*Q,by positivity,?_⟩
  intro X hX T hT hTX a ha
  let J := Icc (-T) T
  let L := 1+Real.log X
  let c := verticalCoefficients (detectorCoefficient X) a
  let g := fun N t => ‖subsetPolynomial (Finset.Ioc X N) c t‖^2
  let f := fun t : ℝ => ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2
  have hL : 0 ≤ L := by dsimp [L]; linarith [Real.log_nonneg (show (1:ℝ) ≤ X by exact_mod_cast hX)]
  have hXr : (1 : ℝ) ≤ X := by exact_mod_cast hX
  have hg (N : ℕ) : Integrable (g N) (volume.restrict J) :=
    ((subsetPolynomial_continuous _ _).norm.pow 2).continuousOn.integrableOn_Icc
  have hlim (t : ℝ) : Tendsto (fun N => g N t) atTop (𝓝 (f t)) :=
    ((mollifiedError_right_tendsto X hX (by linarith : 1 < a) t).norm).pow 2
  have hcoef (n : ℕ) (hn : X < n) :
      ‖c n‖^2 ≤ (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a) := by
    have hn₀ : 0 < n := by omega
    dsimp only [c]
    rw [norm_verticalCoefficients_sq _ _ hn₀]
    exact mul_le_mul_of_nonneg_right
      (pow_le_pow_left₀ (norm_nonneg _) (detectorCoefficient_norm X n) 2) (by positivity)
  have hdiag : T*(X : ℝ)^(1-2*a) ≤ 1 := by
    have hx := mul_le_mul_of_nonneg_right hTX (show 0 ≤ (X : ℝ)^(1-2*a) by positivity)
    have he : (X : ℝ)*(X : ℝ)^(1-2*a) = (X : ℝ)^(2-2*a) := by
      rw [mul_comm, ← Real.rpow_add_one (by positivity : (X : ℝ) ≠ 0),
        show 1-2*a+1 = 2-2*a by ring]
    rw [he] at hx
    exact hx.trans (Real.rpow_le_one_of_one_le_of_nonpos hXr (by linarith))
  have hoff : (X : ℝ)^(1-2*(a-1/2)) ≤ 1 :=
    Real.rpow_le_one_of_one_le_of_nonpos hXr (by linarith)
  have hb (N : ℕ) : (∫ t in J, g N t) ≤ 2*P*Q*L^3 := by
    let S := Finset.Ioc X N
    have hh := hp T 0 hT S c (fun n hn => by
      have := (Finset.mem_Ioc.mp hn).1
      omega)
    rw [zero_sub,zero_add] at hh
    apply hh.trans
    have h2 (n : ℕ) (hn : n ∈ S) :
        (T+(n : ℝ))*‖c n‖^2 ≤
          T*((n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a))+
            (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*(a-1/2)) := by
      have hnX := (Finset.mem_Ioc.mp hn).1
      have hnpos : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
      apply le_trans (mul_le_mul_of_nonneg_left (hcoef n hnX) (by positivity))
      apply le_of_eq
      rw [show -2*(a-1/2) = 1+(-2*a) by ring, Real.rpow_add hnpos, Real.rpow_one]
      ring
    have hfirst := mul_le_mul_of_nonneg_left (hq X N hX a (by linarith)) (show 0 ≤ T by linarith)
    have hsecond := hq X N hX (a-1/2) (by linarith)
    have hsum : (∑ n ∈ S, (T+(n : ℝ))*‖c n‖^2) ≤ 2*Q*L^3 := by
      apply (Finset.sum_le_sum h2).trans
      rw [Finset.sum_add_distrib, ← Finset.mul_sum]
      have hd : T*(∑ n ∈ S, (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*a)) ≤ Q*L^3 := by
        apply hfirst.trans
        have h := mul_le_mul_of_nonneg_right hdiag (show 0 ≤ Q*L^3 by positivity)
        convert h using 1 <;> ring
      have ho : (∑ n ∈ S, (n.divisors.card : ℝ)^2*(n : ℝ)^(-2*(a-1/2))) ≤ Q*L^3 := by
        apply hsecond.trans
        have h := mul_le_mul_of_nonneg_right hoff (show 0 ≤ Q*L^3 by positivity)
        convert h using 1 <;> ring
      exact (add_le_add hd ho).trans_eq (by ring)
    exact (mul_le_mul_of_nonneg_left hsum hP.le).trans_eq (by ring)
  exact (moment_integral_limit_bound g f (volume.restrict J) (2*P*Q*L^3)
    (by positivity) hg (fun _ _ => sq_nonneg _) hlim hb).2

end Legendre.Density.Moment
