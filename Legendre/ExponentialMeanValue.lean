/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ExponentialKernel
public import Mathlib.Analysis.Asymptotics.SpecificAsymptotics

/-!
# Finite exponential sums: diagonal mean value and explicit off-diagonal error

The frequencies may be arbitrary real numbers. Distinctness is required only
for the cancellation estimate, never silently assumed for an integral identity.
-/

@[expose] public section

open scoped ComplexConjugate

namespace Legendre.Density

open Complex MeasureTheory Filter Topology

variable {ι : Type*}

/-- A finite exponential sum with arbitrary complex coefficients and real frequencies. -/
noncomputable def exponentialSum (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) (t : ℝ) : ℂ :=
  ∑ n ∈ S, a n * realPhase (ν n) t

/-- The coefficient energy in the mean-value diagonal. -/
noncomputable def coefficientEnergy (S : Finset ι) (a : ι → ℂ) : ℝ :=
  ∑ n ∈ S, ‖a n‖^2

/-- Finite sums have genuine integrability on every compact interval. -/
theorem continuous_exponentialSum (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) :
    Continuous (exponentialSum S a ν) := by
  unfold exponentialSum
  exact continuous_finsetSum S (fun n _hn => continuous_const.mul (continuous_realPhase _))

/-- Squared modulus is the double sum of phase differences. -/
theorem exponentialSum_norm_sq (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) (t : ℝ) :
    Complex.ofReal (‖exponentialSum S a ν t‖^2) =
      ∑ m ∈ S, ∑ n ∈ S, a m * star (a n) * realPhase (ν m-ν n) t := by
  rw [ofReal_pow, ← mul_conj']
  simp only [exponentialSum, map_sum]
  rw [Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro m hm
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro n hn
  simp only [map_mul]
  rw [← realPhase_mul_conj]
  change a m * realPhase (ν m) t * (star (a n) * star (realPhase (ν n) t)) = _
  ring

/-- Exact finite Gram-matrix identity, valid even when frequencies coincide. -/
theorem integral_exponentialSum_norm_sq (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) (A B : ℝ) :
    Complex.ofReal (∫ t : ℝ in A..B, ‖exponentialSum S a ν t‖^2) =
      ∑ m ∈ S, ∑ n ∈ S, a m * star (a n) * oscillatoryKernel (ν m-ν n) A B := by
  rw [← intervalIntegral.integral_ofReal]
  simp_rw [exponentialSum_norm_sq]
  rw [intervalIntegral.integral_finsetSum]
  · apply Finset.sum_congr rfl
    intro m hm
    rw [intervalIntegral.integral_finsetSum]
    · apply Finset.sum_congr rfl
      intro n hn
      exact intervalIntegral.integral_const_mul _ _
    · intro n hn
      exact (continuous_const.mul (continuous_realPhase _)).intervalIntegrable _ _
  · intro m hm
    exact (continuous_finsetSum S (fun n _hn =>
      continuous_const.mul (continuous_realPhase _))).intervalIntegrable _ _

/-- The error after removing the energy diagonal, retaining the actual oscillatory integrals. -/
noncomputable def meanValueOffDiagonal [DecidableEq ι]
    (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) (A B : ℝ) : ℂ :=
  ∑ m ∈ S, ∑ n ∈ S.erase m, a m * star (a n) * oscillatoryKernel (ν m-ν n) A B

/-- The diagonal is exactly interval length times coefficient energy. -/
theorem integral_exponentialSum_diagonal [DecidableEq ι]
    (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) (A B : ℝ) :
    Complex.ofReal (∫ t : ℝ in A..B, ‖exponentialSum S a ν t‖^2) =
      Complex.ofReal ((B-A)*coefficientEnergy S a) + meanValueOffDiagonal S a ν A B := by
  rw [integral_exponentialSum_norm_sq]
  have hsplit (m : ι) (hm : m ∈ S) :
      (∑ n ∈ S, a m*star (a n)*oscillatoryKernel (ν m-ν n) A B) =
        (‖a m‖^2 : ℂ)*(B-A : ℝ)+
          ∑ n ∈ S.erase m, a m*star (a n)*oscillatoryKernel (ν m-ν n) A B := by
    rw [← Finset.sum_erase_add _ _ hm]
    simp only [sub_self, oscillatoryKernel_zero]
    rw [show a m*star (a m) = (‖a m‖^2 : ℂ) by exact mul_conj' _]
    ring
  rw [Finset.sum_congr rfl hsplit, Finset.sum_add_distrib]
  congr 1
  simp only [coefficientEnergy, ofReal_mul, ofReal_sum, ofReal_pow, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro m hm
  ring

/-- An explicit finite off-diagonal majorant, independent of both endpoints. -/
noncomputable def meanValueError [DecidableEq ι] (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) : ℝ :=
  ∑ m ∈ S, ∑ n ∈ S.erase m, 2*‖a m‖*‖a n‖/|ν m-ν n|

/-- Pairwise frequency separation gives a uniform off-diagonal estimate. -/
theorem norm_meanValueOffDiagonal_le [DecidableEq ι]
    (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) (hν : Set.InjOn ν (S : Set ι)) (A B : ℝ) :
    ‖meanValueOffDiagonal S a ν A B‖ ≤ meanValueError S a ν := by
  unfold meanValueOffDiagonal meanValueError
  apply (norm_sum_le _ _).trans
  apply Finset.sum_le_sum
  intro m hm
  apply (norm_sum_le _ _).trans
  apply Finset.sum_le_sum
  intro n hn
  have hne : ν m-ν n ≠ 0 := by
    intro he
    exact (Finset.mem_erase.1 hn).1 (hν (Finset.mem_erase.1 hn).2 hm (sub_eq_zero.1 he).symm)
  rw [norm_mul, norm_mul, norm_star]
  calc
    _ ≤ (‖a m‖*‖a n‖)*(2/|ν m-ν n|) :=
      mul_le_mul_of_nonneg_left (norm_oscillatoryKernel_le hne A B) (by positivity)
    _ = _ := by ring

/-- Mean-square deviation from the diagonal is bounded independently of interval length/location. -/
theorem abs_integral_exponentialSum_sub_diagonal_le [DecidableEq ι]
    (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) (hν : Set.InjOn ν (S : Set ι)) (A B : ℝ) :
    |(∫ t : ℝ in A..B, (‖exponentialSum S a ν t‖^2 : ℝ))-(B-A)*coefficientEnergy S a| ≤
      meanValueError S a ν := by
  have he := integral_exponentialSum_diagonal S a ν A B
  have hn := norm_meanValueOffDiagonal_le S a ν hν A B
  have hc : Complex.ofReal ((∫ t : ℝ in A..B, ‖exponentialSum S a ν t‖^2)-
      (B-A)*coefficientEnergy S a) = meanValueOffDiagonal S a ν A B := by
    rw [ofReal_sub, he]
    ring
  rw [← hc, norm_real, Real.norm_eq_abs] at hn
  exact hn


/-- Reinsert the vanishing diagonal into the explicit error sum. -/
theorem meanValueError_eq_sum [DecidableEq ι]
    (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) :
    meanValueError S a ν = ∑ m ∈ S, ∑ n ∈ S, 2*‖a m‖*‖a n‖/|ν m-ν n| := by
  unfold meanValueError
  apply Finset.sum_congr rfl
  intro m hm
  rw [← Finset.sum_erase_add _ _ hm]
  simp

/-- A bound on each reciprocal-frequency row yields an energy bound for the entire error. -/
theorem meanValueError_le_energy [DecidableEq ι]
    (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) {R : ℝ}
    (hR : ∀ m ∈ S, ∑ n ∈ S, 1/|ν m-ν n| ≤ R) :
    meanValueError S a ν ≤ 2*R*coefficientEnergy S a := by
  rw [meanValueError_eq_sum]
  have hswap : (∑ m ∈ S, ∑ n ∈ S, ‖a n‖^2/|ν m-ν n|) =
      ∑ m ∈ S, ∑ n ∈ S, ‖a m‖^2/|ν m-ν n| := by
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro m hm
    apply Finset.sum_congr rfl
    intro n hn
    rw [abs_sub_comm]
  have hrow : (∑ m ∈ S, ∑ n ∈ S, ‖a m‖^2/|ν m-ν n|) ≤ R*coefficientEnergy S a := by
    calc
      _ = ∑ m ∈ S, ‖a m‖^2*(∑ n ∈ S, 1/|ν m-ν n|) := by
        apply Finset.sum_congr rfl
        intro m hm
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro n hn
        ring
      _ ≤ ∑ m ∈ S, ‖a m‖^2*R :=
        Finset.sum_le_sum (fun m hm => mul_le_mul_of_nonneg_left (hR m hm) (sq_nonneg _))
      _ = _ := by simp only [coefficientEnergy, Finset.mul_sum]; congr 1; funext m; ring
  calc
    _ ≤ ∑ m ∈ S, ∑ n ∈ S, (‖a m‖^2+‖a n‖^2)/|ν m-ν n| := by
      apply Finset.sum_le_sum
      intro m hm
      apply Finset.sum_le_sum
      intro n hn
      apply div_le_div_of_nonneg_right _ (abs_nonneg _)
      nlinarith [sq_nonneg (‖a m‖-‖a n‖)]
    _ = (∑ m ∈ S, ∑ n ∈ S, ‖a m‖^2/|ν m-ν n|)+
        (∑ m ∈ S, ∑ n ∈ S, ‖a n‖^2/|ν m-ν n|) := by
      simp_rw [add_div, Finset.sum_add_distrib]
    _ ≤ _ := by rw [hswap]; linarith

/-- Fixed finite sums have their exact coefficient energy as the long-interval average. -/
theorem tendsto_exponentialSum_mean_square [DecidableEq ι]
    (S : Finset ι) (a : ι → ℂ) (ν : ι → ℝ) (hν : Set.InjOn ν (S : Set ι)) :
    Tendsto (fun T : ℝ => (∫ t : ℝ in 0..T, ‖exponentialSum S a ν t‖^2)/T)
      atTop (𝓝 (coefficientEnergy S a)) := by
  apply tendsto_iff_norm_sub_tendsto_zero.2
  apply squeeze_zero' (Filter.Eventually.of_forall (fun _ => norm_nonneg _)) ?_
    (tendsto_id.const_div_atTop (meanValueError S a ν))
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
  have hb := abs_integral_exponentialSum_sub_diagonal_le S a ν hν 0 T
  rw [sub_zero] at hb
  rw [Real.norm_eq_abs, show (∫ t : ℝ in 0..T, ‖exponentialSum S a ν t‖^2)/T-
    coefficientEnergy S a = ((∫ t : ℝ in 0..T, ‖exponentialSum S a ν t‖^2)-
      T*coefficientEnergy S a)/T by field_simp, abs_div, abs_of_pos hT]
  exact div_le_div_of_nonneg_right hb hT.le

end Legendre.Density
