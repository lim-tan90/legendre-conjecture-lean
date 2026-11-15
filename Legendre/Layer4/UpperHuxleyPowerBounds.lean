/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local real-power bounds turning upper-range exponent margins into uniform
height decay. No polynomial, zeta or zero-density hypothesis is used.
-/
module
public import Legendre.Layer4.UpperHuxleyParameters

@[expose] public section
namespace Legendre.Density.Moment

/-- Evaluate a monomial after one useful power bound on its block length. -/
theorem height_monomial_le (T U a b v e : ℝ) (hT : 1 ≤ T)
    (hb : U^b ≤ (T^v)^b) (he : a+b*v ≤ e) : T^a*U^b ≤ T^e := by
  have hTp : 0 < T := by linarith
  calc
    _ ≤ T^a*(T^v)^b := mul_le_mul_of_nonneg_left hb (by positivity)
    _ = T^(a+b*v) := by
      rw [←Real.rpow_mul hTp.le,←Real.rpow_add hTp]
      congr 1
      ring
    _ ≤ _ := Real.rpow_le_rpow_of_exponent_le hT he

/-- All four medium-length pointwise terms have the same strict upper-range saving. -/
theorem huxley_medium_power_bounds (T U η σ : ℝ) (hT : 2 ≤ T) (hη : 0 ≤ η)
    (hσ : 5/6+η ≤ σ) (hσ1 : σ ≤ 1)
    (hUlo : T^huxleyShortCutoff σ ≤ U) (hUhi : U ≤ T^(3/5 : ℝ)) :
    T^(1/6 : ℝ)*U^(1/2-σ) ≤ T^(-η/8) ∧
      T^(-1/4 : ℝ)*U^(5/4-σ) ≤ T^(-η/8) ∧
      T^(-1/3 : ℝ)*U^(1-σ) ≤ T^(-η/8) ∧ U^(-σ) ≤ T^(-η/8) := by
  have hTp : 0 < T := by linarith
  have hUp : 0 < U := (Real.rpow_pos_of_pos hTp _).trans_le hUlo
  have hm := huxley_upper_exponent_margins η σ hη hσ hσ1
  refine ⟨?_,?_,?_,?_⟩
  · exact height_monomial_le T U (1/6) (1/2-σ) (huxleyShortCutoff σ) (-η/8)
      (by linarith) (Real.rpow_le_rpow_of_nonpos (Real.rpow_pos_of_pos hTp _) hUlo (by linarith)) hm.1
  · exact height_monomial_le T U (-1/4) (5/4-σ) (3/5) (-η/8)
      (by linarith) (Real.rpow_le_rpow hUp.le hUhi (by linarith)) hm.2.1
  · exact height_monomial_le T U (-1/3) (1-σ) (3/5) (-η/8)
      (by linarith) (Real.rpow_le_rpow hUp.le hUhi (by linarith)) hm.2.2.1
  · have hh := height_monomial_le T U 0 (-σ) (huxleyShortCutoff σ) (-η/8)
      (by linarith) (Real.rpow_le_rpow_of_nonpos (Real.rpow_pos_of_pos hTp _) hUlo (by linarith))
      (by linarith [hm.2.2.2.1])
    simpa only [Real.rpow_zero,one_mul] using hh

/-- Beyond T^(3/5) the second-derivative terms have the same uniform saving. -/
theorem huxley_long_power_bounds (T U η σ : ℝ) (hT : 2 ≤ T) (hη : 0 ≤ η)
    (hσ : 5/6+η ≤ σ) (hσ1 : σ ≤ 1)
    (hUlo : T^(3/5 : ℝ) ≤ U) (hUhi : U ≤ T) :
    T^(1/2 : ℝ)*U^(-σ) ≤ T^(-η/8) ∧
      T^(-1/2 : ℝ)*U^(1-σ) ≤ T^(-η/8) ∧ U^(-σ) ≤ T^(-η/8) := by
  have hTp : 0 < T := by linarith
  have hUp : 0 < U := (Real.rpow_pos_of_pos hTp _).trans_le hUlo
  have hm := huxley_upper_exponent_margins η σ hη hσ hσ1
  have hc := huxley_short_cutoff_bounds σ (by linarith) hσ1
  refine ⟨?_,?_,?_⟩
  · exact height_monomial_le T U (1/2) (-σ) (3/5) (-η/8)
      (by linarith) (Real.rpow_le_rpow_of_nonpos (Real.rpow_pos_of_pos hTp _) hUlo (by linarith))
      (by linarith [hm.2.1])
  · exact height_monomial_le T U (-1/2) (1-σ) 1 (-η/8)
      (by linarith) (by simpa only [Real.rpow_one] using Real.rpow_le_rpow hUp.le hUhi (show 0 ≤ 1-σ by linarith))
      (by linarith [hm.2.2.2.2])
  · have he : -σ*(3/5) ≤ -η/8 := by
      have hh := mul_le_mul_of_nonpos_left hc.2 (show -σ ≤ 0 by linarith)
      exact hh.trans hm.2.2.2.1
    have hh := height_monomial_le T U 0 (-σ) (3/5) (-η/8)
      (by linarith) (Real.rpow_le_rpow_of_nonpos (Real.rpow_pos_of_pos hTp _) hUlo (by linarith)) (by linarith)
    simpa only [Real.rpow_zero,one_mul] using hh

/-- Reciprocals at a shell ordinate cost at most a fixed factor two. -/
theorem shell_negative_power (T a q : ℝ) (hT : 0 < T) (ha : T/2 ≤ a)
    (hq : 0 ≤ q) (hq1 : q ≤ 1) : a^(-q) ≤ 2*T^(-q) := by
  have hhalf : 0 < T/2 := by positivity
  have hh := Real.rpow_le_rpow_of_nonpos hhalf ha (show -q ≤ 0 by linarith)
  have he : (T/2)^(-q) = T^(-q)*(2 : ℝ)^q := by
    rw [Real.div_rpow hT.le (by norm_num : (0 : ℝ) ≤ 2),
      Real.rpow_neg (by norm_num : (0 : ℝ) ≤ 2),div_inv_eq_mul]
  rw [he] at hh
  have htwo : (2 : ℝ)^q ≤ 2 := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2) hq1
  exact hh.trans (by nlinarith [mul_le_mul_of_nonneg_left htwo (show 0 ≤ T^(-q) by positivity)])

theorem shell_reciprocal_power (T a q : ℝ) (hT : 0 < T) (ha : T/2 ≤ a)
    (hq : 0 ≤ q) (hq1 : q ≤ 1) : 1/a^q ≤ 2*T^(-q) := by
  have hap : 0 < a := (show 0 < T/2 by positivity).trans_le ha
  rw [one_div,←Real.rpow_neg hap.le q]
  exact shell_negative_power T a q hT ha hq hq1

theorem shell_ratio_power (T a U q : ℝ) (hT : 0 < T) (ha : T/2 ≤ a)
    (hU : 0 ≤ U) (hq : 0 ≤ q) (hq1 : q ≤ 1) :
    (U/a)^q ≤ 2*U^q*T^(-q) := by
  have hap : 0 < a := (show 0 < T/2 by positivity).trans_le ha
  have he : (U/a)^q = U^q*(1/a^q) := by rw [Real.div_rpow hU hap.le]; ring
  rw [he]
  have hh := mul_le_mul_of_nonneg_left (shell_reciprocal_power T a q hT ha hq hq1)
    (Real.rpow_nonneg hU q)
  convert hh using 1 <;> ring

end Legendre.Density.Moment
