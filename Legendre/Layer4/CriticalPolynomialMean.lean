/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.DirichletMeanValueSharp
public import Legendre.Layer4.Exponential.InverseSqrtDifferencing
public import Legendre.Layer4.Exponential.WeightedLogWeyl

@[expose] public section
namespace Legendre.Density
open Complex MeasureTheory
open Oscillation Oscillation.Tools

private theorem ordered_log_kernel_comparison {x y : ℝ} (hy : 0 < y) (hyx : y < x) :
    |(Real.log x-Real.log y)⁻¹-√(x*y)*(x-y)⁻¹| ≤ 1 := by
  have hx : 0 < x := hy.trans hyx
  have hd : 0 < x-y := sub_pos.mpr hyx
  let L := Real.log x-Real.log y
  have hL : 0 < L := sub_pos.mpr (Real.strictMonoOn_log hy hx hyx)
  have hLlo : (x-y)/x ≤ L := log_gap_lower hy hx
  have hLhi : L ≤ (x-y)/y := by
    have h := Real.log_le_sub_one_of_pos (div_pos hx hy)
    rw [Real.log_div hx.ne' hy.ne'] at h
    convert h using 1
    field_simp
  have hqlo : y ≤ (x-y)/L := (le_div_iff₀ hL).2 (by
    have h := (le_div_iff₀ hy).1 hLhi
    simpa only [mul_comm] using h)
  have hqhi : (x-y)/L ≤ x := (div_le_iff₀ hL).2 (by
    have h := (div_le_iff₀ hx).1 hLlo
    simpa only [mul_comm] using h)
  have hslo : y ≤ √(x*y) := by
    have h := Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_right hyx.le hy.le)
    simpa only [← pow_two y, Real.sqrt_sq hy.le] using h
  have hshi : √(x*y) ≤ x := by
    have h := Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left hyx.le hx.le)
    simpa only [← pow_two x, Real.sqrt_sq hx.le] using h
  have he : L⁻¹-√(x*y)*(x-y)⁻¹ = ((x-y)/L-√(x*y))/(x-y) := by
    field_simp
  change |L⁻¹-√(x*y)*(x-y)⁻¹| ≤ _
  rw [he, abs_div, abs_of_pos hd, div_le_one hd]
  apply abs_le.mpr
  exact ⟨by linarith only [hqlo,hshi],by linarith only [hqhi,hslo]⟩

/-- A logarithmic reciprocal kernel differs from the scaled linear kernel
by a bounded term, including the zero diagonal. -/
theorem abs_log_reciprocal_sub_scaled_linear_le {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    |(Real.log x-Real.log y)⁻¹-√(x*y)*(x-y)⁻¹| ≤ 1 := by
  rcases lt_trichotomy y x with h|h|h
  · exact ordered_log_kernel_comparison hy h
  · subst y
    simp
  · have hb := ordered_log_kernel_comparison hx h
    rwa [show Real.log y-Real.log x = -(Real.log x-Real.log y) by ring,
      show y-x = -(x-y) by ring,inv_neg,inv_neg,mul_comm y x,mul_neg,neg_sub_neg,abs_sub_comm] at hb

/-- Reciprocal square roots up to the cutoff total at most twice its square root. -/
theorem sum_inv_sqrt_Icc_le (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, (√(n : ℝ))⁻¹) ≤ 2*√(N : ℝ) := by
  have h := sum_range_offset_eq_Ioc 0 N (fun n => (√(n : ℝ))⁻¹)
  rw [show Finset.Ioc (0 : ℕ) (0+N) = Finset.Icc 1 N by
    ext n
    simp only [Finset.mem_Ioc,Finset.mem_Icc,zero_add]
    omega] at h
  rw [← h]
  simpa only [zero_add,Nat.cast_add,Nat.cast_one,add_comm] using sum_inverse_sqrt_le N

private theorem critical_half_weight_mul_sqrt {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    (√x)⁻¹*(√y)⁻¹*√(y*x) = 1 := by
  rw [Real.sqrt_mul hy.le]
  field_simp [(Real.sqrt_pos.2 hx).ne',(Real.sqrt_pos.2 hy).ne']

private theorem norm_critical_hilbertPhaseSum_le (N : ℕ) (t : ℝ) :
    let S := Finset.Icc 1 N
    let ν : S → ℝ := fun n => -Real.log (n.val : ℝ)
    let a : S → ℂ := fun n => (((√(n.val : ℝ))⁻¹ : ℝ) : ℂ)
    ‖hilbertPhaseSum ν a t‖ ≤ (Real.pi+4)*(N : ℝ) := by
  dsimp only
  let S := Finset.Icc 1 N
  let ν : S → ℝ := fun n => -Real.log (n.val : ℝ)
  let ξ : S → ℝ := fun n => -(n.val : ℝ)
  let a : S → ℂ := fun n => (((√(n.val : ℝ))⁻¹ : ℝ) : ℂ)
  let u : S → ℂ := fun n => star (realPhase (ν n) t)
  let R : S → S → ℝ := fun m n =>
    LargeSieve.reciprocalKernel (ν m) (ν n)-
      √((n.val : ℝ)*(m.val : ℝ))*LargeSieve.reciprocalKernel (ξ m) (ξ n)
  have hn (n : S) : 0 < (n.val : ℝ) := by exact_mod_cast (Finset.mem_Icc.mp n.property).1
  have hR (m n : S) : |R m n| ≤ 1 := by
    dsimp only [R,ν,ξ,LargeSieve.reciprocalKernel]
    simp only [neg_sub_neg]
    exact abs_log_reciprocal_sub_scaled_linear_le (hn n) (hn m)
  have hξ : LargeSieve.LineSeparated ξ 1 := by
    intro m n hne
    have hmne : m.val ≠ n.val := fun he => hne (Subtype.ext he)
    dsimp only [ξ]
    rw [neg_sub_neg]
    rcases lt_or_gt_of_ne hmne with h|h
    · have hmn : (m.val : ℝ)+1 ≤ n.val := by exact_mod_cast (show m.val+1 ≤ n.val by omega)
      rw [abs_of_nonneg (by linarith only [hmn])]
      linarith only [hmn]
    · have hnm : (n.val : ℝ)+1 ≤ m.val := by exact_mod_cast (show n.val+1 ≤ m.val by omega)
      rw [abs_of_nonpos (by linarith only [hnm])]
      linarith only [hnm]
  let H := ∑ m : S, ∑ n : S, star (u m)*(LargeSieve.reciprocalKernel (ξ m) (ξ n) : ℂ)*u n
  let E := ∑ m : S, ∑ n : S, a m*star (a n)*realPhase (ν m-ν n) t*(R m n : ℂ)
  have hsplit : hilbertPhaseSum ν a t = H+E := by
    dsimp only [hilbertPhaseSum,H,E]
    simp only [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro m _
    apply Finset.sum_congr rfl
    intro n _
    have hweight : a m*star (a n)*(√((n.val : ℝ)*(m.val : ℝ)) : ℝ) = (1 : ℂ) := by
      dsimp only [a]
      rw [star_def,conj_ofReal,← Complex.ofReal_mul,← Complex.ofReal_mul]
      rw [critical_half_weight_mul_sqrt (hn m) (hn n),Complex.ofReal_one]
    have hphase : realPhase (ν m-ν n) t = realPhase (ν m) t * star (realPhase (ν n) t) :=
      (realPhase_mul_conj _ _ _).symm
    have he : (LargeSieve.reciprocalKernel (ν m) (ν n) : ℂ) =
        (√((n.val : ℝ)*(m.val : ℝ)) : ℂ) *
          (LargeSieve.reciprocalKernel (ξ m) (ξ n) : ℂ)+(R m n : ℂ) := by
      dsimp only [R]
      push_cast
      ring
    rw [he, mul_add]
    congr 1
    dsimp only [u]
    rw [star_star,hphase]
    calc
      _ = (a m*star (a n)*(√((n.val : ℝ)*(m.val : ℝ)) : ℂ))*
          (realPhase (ν m) t*(LargeSieve.reciprocalKernel (ξ m) (ξ n) : ℂ)*
            star (realPhase (ν n) t)) := by ring
      _ = _ := by rw [hweight,one_mul]
  have hH : ‖H‖ ≤ Real.pi*(N : ℝ) := by
    have h := LargeSieve.reciprocal_hilbert_bound ξ (by norm_num : (0 : ℝ) < 1) hξ u
    simpa [H,u,norm_star,norm_realPhase,S,Nat.card_Icc] using h
  have hs : (∑ n : S, ‖a n‖) ≤ 2*√(N : ℝ) := by
    have h' (n : S) : ‖a n‖ = (√(n.val : ℝ))⁻¹ := by
      rw [show a n = (((√(n.val : ℝ))⁻¹ : ℝ) : ℂ) from rfl,Complex.norm_real,Real.norm_eq_abs,abs_of_nonneg (by positivity)]
    simp_rw [h']
    exact (Finset.sum_coe_sort S (fun n : ℕ => (√(n : ℝ))⁻¹)).trans_le
      (sum_inv_sqrt_Icc_le N)
  have he : ‖E‖ ≤ 4*(N : ℝ) := by
    apply (norm_sum_le _ _).trans
    have h' (m n : S) :
        ‖a m*star (a n)*realPhase (ν m-ν n) t*(R m n : ℂ)‖ ≤ ‖a m‖*‖a n‖ := by
      simp only [norm_mul,norm_star,norm_realPhase,mul_one,Complex.norm_real,Real.norm_eq_abs]
      exact mul_le_of_le_one_right (by positivity) (hR m n)
    have hsum : (∑ m : S, ‖∑ n : S, a m*star (a n)*realPhase (ν m-ν n) t*(R m n : ℂ)‖) ≤
        ∑ m : S, ∑ n : S, ‖a m‖*‖a n‖ :=
      Finset.sum_le_sum fun m _ => (norm_sum_le _ _).trans (Finset.sum_le_sum fun n _ => h' m n)
    apply hsum.trans
    simp only [← Finset.mul_sum,← Finset.sum_mul,← pow_two]
    have h := pow_le_pow_left₀ (Finset.sum_nonneg (fun n _ => norm_nonneg (a n))) hs 2
    rwa [mul_pow,Real.sq_sqrt (Nat.cast_nonneg N),show (2 : ℝ)^2 = 4 by norm_num] at h
  change ‖hilbertPhaseSum ν a t‖ ≤ _
  rw [hsplit]
  exact (norm_add_le _ _).trans ((add_le_add hH he).trans_eq (by ring))

/-- The critical-line Dirichlet sum has harmonic diagonal and an O(N)
interval error with an absolute coefficient, independently of the endpoints. -/
theorem abs_integral_critical_euler_sum_sub_harmonic (N : ℕ) (A B : ℝ) :
    |(∫ t : ℝ in A..B, ‖∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))‖^2)-
        (B-A)*(harmonic N : ℝ)| ≤ 2*(Real.pi+4)*(N : ℝ) := by
  by_cases hN : N = 0
  · subst N
    simp
  let S := Finset.Icc 1 N
  let ν : S → ℝ := fun n => -Real.log (n.val : ℝ)
  let a : S → ℂ := fun n => (((√(n.val : ℝ))⁻¹ : ℝ) : ℂ)
  have hNp : (0 : ℝ) < N := Nat.cast_pos.mpr (Nat.pos_of_ne_zero hN)
  have hn (n : S) : 0 < (n.val : ℝ) := by exact_mod_cast (Finset.mem_Icc.mp n.property).1
  have hpoly (t : ℝ) : exponentialSum Finset.univ a ν t =
      ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I)) := by
    unfold exponentialSum
    dsimp [ν,a]
    rw [← Finset.sum_coe_sort S (fun n : ℕ => (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I)))]
    apply Finset.sum_congr rfl
    intro n _
    rw [realPhase_neg_log_eq_cpow (hn n),Complex.ofReal_natCast]
    have h := real_weight_cpow n.val (by exact_mod_cast hn n) (1/2) t
    rw [Complex.real_smul,Real.rpow_neg (hn n).le,← Real.sqrt_eq_rpow] at h
    have hc : (((1/2 : ℝ) : ℂ)) = (1/2 : ℂ) := by norm_num
    rwa [hc] at h
  have henergy : coefficientEnergy Finset.univ a = (harmonic N : ℝ) := by
    rw [harmonic_eq_sum_Icc,Rat.cast_sum]
    unfold coefficientEnergy
    rw [← Finset.sum_coe_sort S (fun n : ℕ => (((n : ℚ)⁻¹ : ℚ) : ℝ))]
    apply Finset.sum_congr rfl
    intro n _
    dsimp only [a]
    rw [Complex.norm_real,Real.norm_eq_abs,abs_of_nonneg (by positivity),inv_pow,
      Real.sq_sqrt (hn n).le,Rat.cast_inv,Rat.cast_natCast]
  have hdecomp := integral_exponentialSum_hilbert_decomposition ν a (one_div_pos.mpr hNp)
    (dirichlet_frequencies_separated N) A B
  simp_rw [hpoly,henergy] at hdecomp
  have hc : Complex.ofReal ((∫ t : ℝ in A..B,
        ‖∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))‖^2)-
        (B-A)*(harmonic N : ℝ)) = I⁻¹*(hilbertPhaseSum ν a B-hilbertPhaseSum ν a A) := by
    rw [Complex.ofReal_sub,hdecomp]
    ring
  have h := norm_sub_le (hilbertPhaseSum ν a B) (hilbertPhaseSum ν a A)
  have hh : ‖I⁻¹*(hilbertPhaseSum ν a B-hilbertPhaseSum ν a A)‖ ≤ 2*(Real.pi+4)*(N : ℝ) := by
    rw [norm_mul,norm_inv,norm_I,inv_one,one_mul]
    exact (h.trans (add_le_add (norm_critical_hilbertPhaseSum_le N B)
      (norm_critical_hilbertPhaseSum_le N A))).trans_eq (by ring)
  rwa [← hc,Complex.norm_real,Real.norm_eq_abs] at hh

end Legendre.Density
