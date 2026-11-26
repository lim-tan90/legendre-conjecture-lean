/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.MollifiedZetaMeanSquare
public import Legendre.Layer4.BlockCauchy
public import Legendre.Layer4.DyadicPartition
public import Legendre.ZeroDetector.CoefficientEnergy

@[expose] public section
namespace Legendre.Density.Detector
open Complex Set MeasureTheory

/-- Mean-square bound for one dyadic block of the finite detector. -/
noncomputable def detectorDyadicBlockMeanBound (U : ℕ) (a L : ℝ) : ℝ :=
  (L+4*Real.pi*U) * (2*U*(1+Real.log (2*U))^3*(U : ℝ)^(-2*a))

/-- Weighted bound with each block charged its own frequency scale. -/
noncomputable def detectorDyadicMeanBound (X J : ℕ) (a L : ℝ) (w : ℕ → ℝ) : ℝ :=
  (∑ j ∈ Finset.range J, w j) *
    ∑ j ∈ Finset.range J, detectorDyadicBlockMeanBound (2^j*X) a L / w j

/-- The positive square-root weights give the square of the sum of block norms. -/
theorem detectorDyadicMeanBound_sqrt_weights {X J : ℕ} (hX : 1 ≤ X)
    (a L : ℝ) (hL : 0 ≤ L) :
    let block := fun j => detectorDyadicBlockMeanBound (2^j*X) a L
    (∀ j ∈ Finset.range J, 0 < Real.sqrt (block j)) ∧
      detectorDyadicMeanBound X J a L (fun j => Real.sqrt (block j)) =
        (∑ j ∈ Finset.range J, Real.sqrt (block j))^2 := by
  let block := fun j => detectorDyadicBlockMeanBound (2^j*X) a L
  have hpos (j : ℕ) : 0 < Real.sqrt (block j) := by
    apply Real.sqrt_pos.2
    have hU : 1 ≤ (2^j*X : ℕ) := one_le_mul (one_le_pow₀ (by norm_num)) hX
    have hUR : (1 : ℝ) ≤ (2^j*X : ℕ) := by exact_mod_cast hU
    have hlog : 0 ≤ Real.log (2*(2^j*X : ℕ)) := Real.log_nonneg (by linarith)
    dsimp only [block, detectorDyadicBlockMeanBound]
    positivity
  refine ⟨fun j _ => hpos j, ?_⟩
  change (∑ j ∈ Finset.range J, Real.sqrt (block j)) *
      (∑ j ∈ Finset.range J, block j / Real.sqrt (block j)) = _
  rw [pow_two]
  congr 1
  apply Finset.sum_congr rfl
  intro j _
  exact (div_eq_iff (hpos j).ne').2 ((Real.mul_self_sqrt (Real.sqrt_pos.1 (hpos j)).le).symm)

/-- The second moment of the finite detector uses each block's length in the
off-diagonal term. Positive weights may be chosen independently by block. -/
theorem integral_detectorPolynomial_norm_sq_le_dyadic {X N J : ℕ}
    (hX : 1 ≤ X) (hN : N ≤ 2^J) {a A B : ℝ} (ha : 0 ≤ a) (hAB : A ≤ B)
    (w : ℕ → ℝ) (hw : ∀ j ∈ Finset.range J, 0 < w j) :
    (∫ t in Icc A B, ‖detectorPolynomial X N ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
      detectorDyadicMeanBound X J a (B-A) w := by
  let U := fun j => 2^j*X
  let S := fun j => Finset.Ioc (U j) (2*U j)
  let b := fun n => mollifierCoefficient X N n
  let c := fun j n => if n ∈ S j then b n else 0
  let P := fun j => dirichletPolynomial (2*U j) (verticalCoefficients (c j) a)
  have hU (j : ℕ) : 1 ≤ U j := one_le_mul (one_le_pow₀ (by norm_num)) hX
  have hP (j : ℕ) (t : ℝ) :
      P j t = ∑ n ∈ S j, b n*(n : ℂ)^(-((a : ℂ)+(t : ℂ)*I)) := by
    change dirichletPolynomial _ _ _ = _
    rw [← complexDirichletPolynomial_vertical]
    unfold complexDirichletPolynomial
    have hsub : S j ⊆ Finset.Icc 1 (2*U j) := by
      intro n hn
      have hn' := Finset.mem_Ioc.mp hn
      exact Finset.mem_Icc.mpr ⟨by omega, hn'.2⟩
    symm
    calc
      _ = ∑ n ∈ S j, c j n*(n : ℂ)^(-((a : ℂ)+(t : ℂ)*I)) := by
        exact Finset.sum_congr rfl fun n hn => by simp [c, hn]
      _ = _ := Finset.sum_subset hsub fun n _ hn => by simp [c, hn]
  have hpoly (t : ℝ) : detectorPolynomial X N ((a : ℂ)+(t : ℂ)*I) =
      ∑ j ∈ Finset.range J, P j t := by
    let f := fun n => b n*(n : ℂ)^(-((a : ℂ)+(t : ℂ)*I))
    have hcover : X*N ≤ 2^J*X := by simpa [Nat.mul_comm X] using Nat.mul_le_mul_right X hN
    have hsplit := Moment.moment_dyadic_partition X J hX f
    have hpartition : (∑ n ∈ Finset.Ioc X (2^J*X), f n) =
        ∑ j ∈ Finset.range J, ∑ n ∈ S j, f n := by
      have he : Finset.Icc 1 (2^J*X) = Finset.Icc 1 X ∪ Finset.Ioc X (2^J*X) := by
        ext n
        simp only [Finset.mem_Icc, Finset.mem_union, Finset.mem_Ioc]
        have : X ≤ 2^J*X := by
          exact le_mul_of_one_le_left (Nat.zero_le _) (one_le_pow₀ (by norm_num))
        omega
      have hd : Disjoint (Finset.Icc 1 X) (Finset.Ioc X (2^J*X)) := by
        rw [Finset.disjoint_left]
        intro n hn hn'
        exact (Finset.mem_Ioc.mp hn').1.not_ge (Finset.mem_Icc.mp hn).2
      rw [he, Finset.sum_union hd, add_right_inj] at hsplit
      simpa only [S, U, pow_succ, show ∀ j : ℕ, (2^j*2)*X = 2*(2^j*X) by intro j; ring]
        using hsplit
    simp_rw [hP]
    change (∑ n ∈ Finset.Ioc X (X*N), f n) = ∑ j ∈ Finset.range J, ∑ n ∈ S j, f n
    rw [← hpartition]
    apply Finset.sum_subset (Finset.Ioc_subset_Ioc_right hcover)
    intro n hn hn'
    have hn'' := (Finset.mem_Ioc.mp hn).1
    have hlarge : X*N < n := by
      by_contra! h
      exact hn' (Finset.mem_Ioc.mpr ⟨hn'', h⟩)
    dsimp only [f]
    rw [show b n = 0 from mollifierCoefficient_support hlarge, zero_mul]
  have hcont (j : ℕ) : Continuous (P j) := continuous_dirichletPolynomial _ _
  have hi (j : ℕ) : IntegrableOn (fun t => ‖P j t‖^2 / w j) (Icc A B) :=
    (((hcont j).norm.pow 2).div_const _).continuousOn.integrableOn_compact isCompact_Icc
  have hpoint : (∫ t in Icc A B, ‖∑ j ∈ Finset.range J, P j t‖^2) ≤
      (∑ j ∈ Finset.range J, w j) *
        ∑ j ∈ Finset.range J, (∫ t in Icc A B, ‖P j t‖^2) / w j := by
    have hl : IntegrableOn (fun t => ‖∑ j ∈ Finset.range J, P j t‖^2) (Icc A B) :=
      ((continuous_finsetSum _ (fun j _ => hcont j)).norm.pow 2).continuousOn.integrableOn_compact
        isCompact_Icc
    have hr : IntegrableOn ((fun t => (∑ j ∈ Finset.range J, w j) *
        ∑ j ∈ Finset.range J, ‖P j t‖^2 / w j)) (Icc A B) :=
      (integrable_finsetSum _ (fun j _ => hi j)).const_mul _
    have h := integral_mono hl hr (fun t => Moment.moment_weighted_sum_norm_sq _ _ w hw)
    rw [integral_const_mul, integral_finsetSum _ (fun j _ => hi j)] at h
    simpa only [integral_div] using h
  have hblock (j : ℕ) : (∫ t in Icc A B, ‖P j t‖^2) ≤
      (B-A+4*Real.pi*(U j)) *
        (2*(U j)*(1+Real.log (2*(U j)))^3*((U j : ℕ) : ℝ)^(-2*a)) := by
    rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hAB]
    have henergy : coefficientEnergy (Finset.Icc 1 (2*U j)) (verticalCoefficients (c j) a) =
        ∑ n ∈ S j, ‖b n‖^2*(n : ℝ)^(-2*a) := by
      unfold coefficientEnergy
      have he (n : ℕ) (hn : n ∈ Finset.Icc 1 (2*U j)) :
          ‖verticalCoefficients (c j) a n‖^2 =
            if n ∈ S j then ‖b n‖^2*(n : ℝ)^(-2*a) else 0 := by
        have hn₀ := zero_lt_one.trans_le (Finset.mem_Icc.mp hn).1
        rw [norm_verticalCoefficients _ _ hn₀]
        by_cases hn' : n ∈ S j
        · have hc : c j n = b n := ite_eq_left hn'
          rw [ite_eq_left hn', hc, mul_pow, ← Real.rpow_mul_natCast (by positivity)]
          push_cast
          rw [show (-a)*2 = -2*a by ring]
        · simp [c, hn']
      rw [Finset.sum_congr rfl he, ← Finset.sum_filter]
      congr 1
      ext n
      simp only [S, Finset.mem_filter, Finset.mem_Icc, Finset.mem_Ioc]
      have := hU j
      omega
    have h := integral_dirichletPolynomial_norm_sq_le_linear (2*U j) (verticalCoefficients (c j) a)
      A B
    rw [henergy] at h
    have hlength : B-A+2*Real.pi*(↑(2*U j : ℕ) : ℝ) = B-A+4*Real.pi*(U j) := by push_cast; ring
    rw [hlength] at h
    exact h.trans (mul_le_mul_of_nonneg_left (mollifier_dyadic_energy_le X N ha (hU j))
      (by have := sub_nonneg.mpr hAB; positivity))
  unfold detectorDyadicMeanBound detectorDyadicBlockMeanBound
  simp_rw [hpoly]
  apply hpoint.trans
  apply mul_le_mul_of_nonneg_left _ (Finset.sum_nonneg fun j hj => (hw j hj).le)
  exact Finset.sum_le_sum fun j hj => div_le_div_of_nonneg_right (hblock j) (hw j hj).le

/-- Uniform dyadic vertical second moment on a positive-height rectangle. -/
theorem integral_mollifiedError_norm_sq_le_dyadic {X N J : ℕ}
    (hX : 1 ≤ X) (hXN : X ≤ N) (hN : N ≤ 2^J) {α β A B : ℝ}
    (hα : 0 < α) (hA : 0 < A) (hAB : A ≤ B) {a : ℝ} (ha : a ∈ Icc α β)
    (w : ℕ → ℝ) (hw : ∀ j ∈ Finset.range J, 0 < w j) :
    (∫ t in Icc A B, ‖mollifiedError X ((a : ℂ)+(t : ℂ)*I)‖^2) ≤
      2*detectorDyadicMeanBound X J α (B-A) w +
        2*(B-A)*(mollifiedEulerErrorBound X N α β A B)^2 := by
  have hd := integral_detectorPolynomial_norm_sq_le_dyadic (J := J) hX hN
    (hα.le.trans ha.1) hAB w hw
  have hmono : detectorDyadicMeanBound X J a (B-A) w ≤ detectorDyadicMeanBound X J α (B-A) w := by
    unfold detectorDyadicMeanBound detectorDyadicBlockMeanBound
    apply mul_le_mul_of_nonneg_left _ (Finset.sum_nonneg fun j hj => (hw j hj).le)
    apply Finset.sum_le_sum
    intro j hj
    have hU : 1 ≤ (2^j*X : ℕ) := one_le_mul (one_le_pow₀ (by norm_num)) hX
    have hUR : (1 : ℝ) ≤ (2^j*X : ℕ) := by exact_mod_cast hU
    have hlog : 0 ≤ Real.log (2*(2^j*X : ℕ)) := Real.log_nonneg (by linarith)
    have hL := sub_nonneg.mpr hAB
    apply div_le_div_of_nonneg_right _ (hw j hj).le
    apply mul_le_mul_of_nonneg_left _ (by positivity)
    apply mul_le_mul_of_nonneg_left _ (by positivity)
    exact Real.rpow_le_rpow_of_exponent_le hUR (by linarith [ha.1])
  have hv := integral_mollifiedError_norm_sq_le_detector_and_remainder hX hXN hα hA hAB ha
  linarith only [hv, hd.trans hmono]

end Legendre.Density.Detector

namespace Legendre.Zeta
open Density.Detector

/-- Near-one zero density with a dyadic, weighted bound for the vertical
moment and independent control of the circle center. -/
theorem zeroDensityCount_le_mollified_dyadic_energy {X N J : ℕ}
    (hX : 1 ≤ X) (hXN : X ≤ N) (hN : N ≤ 2^J) {δ η U V : ℝ}
    (hδ : 0 < δ) (hη : 0 < η) (hstrip : δ+2*η < 1) (hU : δ+5*η < U) (hUV : U ≤ V)
    (hscale : 2*(2+η⁻¹)^2 ≤ (X : ℝ)^η)
    (w : ℕ → ℝ) (hw : ∀ j ∈ Finset.range J, 0 < w j) :
    let α := 1-δ-2*η
    let β := 1+δ+6*η
    let A := U-(δ+5*η)
    let B := V+(δ+5*η)
    let M := 2*detectorDyadicMeanBound X J α (B-A) w +
      2*(B-A)*(mollifiedEulerErrorBound X N α β A B)^2
    let C := (V-U+2*η)*((X : ℝ)^(-η)*(2+η⁻¹)^2)^2
    (zeroDensityCount (1-δ) V : ℝ) ≤ (zeroDensityCount (1-δ) U : ℝ) +
      (M + (4/3 : ℝ)*min M C) /
        (2*η*Real.log ((δ+4*η)/(δ+3*η))) := by
  dsimp only
  apply zeroDensityCount_le_mollified_vertical_min_center_offset X hX hδ hη hU hUV hscale
  intro a ha
  exact integral_mollifiedError_norm_sq_le_dyadic hX hXN hN
    (by linarith) (by linarith) (by linarith) ha w hw

end Legendre.Zeta
