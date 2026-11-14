/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local general-length logarithmic Weyl bound. The extra long-length terms
are retained explicitly rather than assuming the square-root range.
-/
module
public import Legendre.Layer4.Exponential.WeightedLogWeyl

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set Tools.ExponentialSum
open scoped BigOperators

/-- The actual square bound is valid at every block length. -/
theorem logarithmic_prefix_general_weyl_square (U M : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (t : ℝ) (ht : 1 ≤ |t|) :
    ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))‖^2 ≤
      (4+2*logarithmicShiftConstant)*(U : ℝ)*|t|^(1/3 : ℝ)+
        2*logarithmicShiftConstant*(U : ℝ)^2*Real.sqrt ((U : ℝ)/|t|)+
          ((U : ℝ)/|t|^(1/3 : ℝ))^2 := by
  have htp : 0 < |t| := by linarith
  have hs3 : (|t|^(1/3 : ℝ))^3 = |t| := by
    rw [←Real.rpow_natCast (|t|^(1/3 : ℝ)) 3,←Real.rpow_mul htp.le]
    norm_num
  have hnorm : ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))‖ ≤ (M : ℝ) := by
    calc
      _ ≤ ∑ n ∈ Finset.Icc 1 M, ‖phase (logarithmicPhase t ((n : ℝ)+U))‖ := norm_sum_le _ _
      _ = _ := by simp only [phase_norm,Finset.sum_const,nsmul_eq_mul,mul_one,Nat.card_Icc]; norm_num
  exact logarithmic_weyl_general_square_budget U M |t| (|t|^(1/3 : ℝ)) logarithmicShiftConstant _
    hU hMU ht (by positivity) (Real.one_le_rpow ht (by norm_num)) hs3
    logarithmicShiftConstant_pos.le (norm_nonneg _) hnorm
    (fun H hH hHM => logarithmic_prefix_vdc_square U M H hU hMU hH hHM t (abs_pos.mp htp))

/-- A general block bound displays all three differencing costs. -/
theorem logarithmic_block_general_weyl (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V)
    (hV : V ≤ 2*U) (t : ℝ) (ht : 1 ≤ |t|) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)‖ ≤ logarithmicWeylConstant*
      (Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)+(U : ℝ)*((U : ℝ)/|t|)^(1/4 : ℝ)+
        (U : ℝ)/|t|^(1/3 : ℝ)) := by
  have htp : 0 < |t| := by linarith
  have hC := logarithmicShiftConstant_pos
  have hK := logarithmicWeylConstant_pos
  let p := Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)
  let q := (U : ℝ)*((U : ℝ)/|t|)^(1/4 : ℝ)
  let r := (U : ℝ)/|t|^(1/3 : ℝ)
  have hp0 : 0 ≤ p := by dsimp [p]; positivity
  have hq0 : 0 ≤ q := by dsimp [q]; positivity
  have hr0 : 0 ≤ r := by dsimp [r]; positivity
  have hp2 : p^2 = (U : ℝ)*|t|^(1/3 : ℝ) := by
    dsimp [p]
    rw [mul_pow,Real.sq_sqrt (Nat.cast_nonneg U),←Real.rpow_natCast (|t|^(1/6 : ℝ)) 2,
      ←Real.rpow_mul htp.le]
    norm_num
  have hq2 : q^2 = (U : ℝ)^2*Real.sqrt ((U : ℝ)/|t|) := by
    dsimp [q]
    rw [mul_pow,←Real.rpow_natCast (((U : ℝ)/|t|)^(1/4 : ℝ)) 2,
      ←Real.rpow_mul (by positivity : 0 ≤ (U : ℝ)/|t|),Real.sqrt_eq_rpow]
    norm_num
  have hK2 : logarithmicWeylConstant^2 = 4+8*logarithmicShiftConstant := by
    unfold logarithmicWeylConstant
    exact Real.sq_sqrt (by positivity)
  have hb := logarithmic_prefix_general_weyl_square U (V-U) hU (by omega) t ht
  rw [logarithmic_prefix_eq_block U (V-U) hU t,Nat.add_sub_of_le hUV] at hb
  have he : (4+2*logarithmicShiftConstant)*(U : ℝ)*|t|^(1/3 : ℝ)+
      2*logarithmicShiftConstant*(U : ℝ)^2*Real.sqrt ((U : ℝ)/|t|)+
        ((U : ℝ)/|t|^(1/3 : ℝ))^2 =
      (4+2*logarithmicShiftConstant)*p^2+2*logarithmicShiftConstant*q^2+r^2 := by
    rw [hp2,hq2]
    dsimp [r]
    ring
  rw [he] at hb
  apply (sq_le_sq₀ (norm_nonneg _) (by positivity)).mp
  change _ ≤ (logarithmicWeylConstant*(p+q+r))^2
  rw [mul_pow,hK2]
  have hdiag : (4+2*logarithmicShiftConstant)*p^2+2*logarithmicShiftConstant*q^2+r^2 ≤
      (4+8*logarithmicShiftConstant)*(p^2+q^2+r^2) := by
    nlinarith [mul_nonneg hC.le (sq_nonneg p),mul_nonneg hC.le (sq_nonneg q),mul_nonneg hC.le (sq_nonneg r)]
  have hsum : p^2+q^2+r^2 ≤ (p+q+r)^2 := by nlinarith [mul_nonneg hp0 hq0,mul_nonneg hp0 hr0,mul_nonneg hq0 hr0]
  exact hb.trans (hdiag.trans (mul_le_mul_of_nonneg_left hsum (by positivity)))

end Legendre.Density.Oscillation
