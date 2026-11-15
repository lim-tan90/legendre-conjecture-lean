/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local floor-endpoint control for the actual divisor-expanded detector.
The potential extra endpoint above twice the divided lower cutoff is retained.
-/
module
public import Legendre.Layer4.DetectorDivisorBlocks

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex Set
open scoped BigOperators

theorem divided_block_endpoints (d U V : ℕ) (hd : 0 < d) (hdU : d ≤ U) (hV : V ≤ 2*U) :
    1 ≤ U/d ∧ V/d ≤ 2*(U/d)+1 ∧ U ≤ 2*(d*(U/d)) := by
  have hm : 1 ≤ U/d := (Nat.le_div_iff_mul_le hd).mpr (by simpa using hdU)
  have hr := Nat.mod_lt U hd
  have he := Nat.mod_add_div U d
  have hdM : d ≤ d*(U/d) := by nlinarith
  have hlast : (2*U)/d < 2*(U/d)+2 := by
    apply (Nat.div_lt_iff_lt_mul hd).mpr
    nlinarith
  exact ⟨hm,(Nat.div_le_div_right hV).trans (by omega),by nlinarith⟩

theorem complex_block_norm_term (n : ℕ) (hn : 0 < n) (β t : ℝ) :
    ‖(n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ = (n : ℝ)^(-β) := by
  rw [Complex.norm_natCast_cpow_of_pos hn]
  simp

/-- Prefix bounds up to 2m also control the possible endpoint 2m+1. -/
theorem complex_prefix_extra_endpoint (m W : ℕ) (hm : 1 ≤ m) (hmW : m ≤ W)
    (hW : W ≤ 2*m+1) (β t B : ℝ) (hβ : 0 ≤ β) (hB : 0 ≤ B)
    (hb : ∀ K : ℕ, m ≤ K → K ≤ 2*m →
      ‖∑ n ∈ Finset.Ioc m K, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤ B*(m : ℝ)^(-β)) :
    ‖∑ n ∈ Finset.Ioc m W, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤ (B+1)*(m : ℝ)^(-β) := by
  have hmp : (0 : ℝ) < m := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hm)
  by_cases hshort : W ≤ 2*m
  · have hh := hb W hmW hshort
    have hp : 0 ≤ (m : ℝ)^(-β) := by positivity
    nlinarith
  · have hWeq : W = 2*m+1 := by omega
    rw [hWeq,Finset.sum_Ioc_succ_top (by omega : m ≤ 2*m)]
    have hend : ‖((2*m+1 : ℕ) : ℂ) ^ (-((β : ℂ)+(t : ℂ)*I))‖ ≤ (m : ℝ)^(-β) := by
      rw [complex_block_norm_term (2*m+1) (by omega)]
      apply Real.rpow_le_rpow_of_nonpos hmp (by norm_cast; omega) (by linarith)
    have hh := (norm_add_le _ _).trans (add_le_add (hb (2*m) (by omega) le_rfl) hend)
    convert hh using 1 <;> ring

/-- Dilating the actual smoothing argument only changes its positive scale. -/
theorem norm_dilated_smoothed_block (d m W : ℕ) (hd : 0 < d) (hmW : m ≤ W)
    (Y B : ℝ) (hY : 0 < Y) (hB : 0 ≤ B) (a : ℕ → ℂ)
    (hb : ∀ K : ℕ, m ≤ K → K ≤ W → ‖∑ n ∈ Finset.Ioc m K, a n‖ ≤ B) :
    ‖∑ n ∈ Finset.Ioc m W, detectorWeight (((d*n : ℕ) : ℝ)/Y)*a n‖ ≤ B := by
  have hdr : (0 : ℝ) < d := by exact_mod_cast hd
  have he (n : ℕ) : (((d*n : ℕ) : ℝ)/Y) = (n : ℝ)/(Y/d) := by push_cast; field_simp
  have hsum : (∑ n ∈ Finset.Ioc m W, detectorWeight (((d*n : ℕ) : ℝ)/Y)*a n) =
      ∑ n ∈ Finset.Ioc m W, detectorWeight ((n : ℝ)/(Y/d))*a n := by
    exact Finset.sum_congr rfl (fun n hn => by rw [he])
  rw [hsum]
  exact norm_smoothed_block_of_prefix m W hmW (Y/d) B (div_pos hY hdr) hB a hb

/-- The arithmetic loss from the divided lower cutoff is uniformly at most two. -/
theorem divided_real_part_weight (d U : ℕ) (hd : 0 < d) (hdU : d ≤ U)
    (β : ℝ) (hβ : 0 ≤ β) (hβ1 : β ≤ 1) :
    (d : ℝ)^(-β)*((U/d : ℕ) : ℝ)^(-β) ≤ 2*(U : ℝ)^(-β) := by
  have hm := divided_block_endpoints d U U hd hdU (by omega)
  have hUp : (0 : ℝ) < U := by exact_mod_cast (hd.trans_le hdU)
  have hdp : (0 : ℝ) < d := by exact_mod_cast hd
  have hmp : (0 : ℝ) < ((U/d : ℕ) : ℝ) := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hm.1)
  have hhalf : (U : ℝ)/2 ≤ (d : ℝ)*((U/d : ℕ) : ℝ) := by
    apply (div_le_iff₀ (by norm_num : (0 : ℝ) < 2)).mpr
    exact_mod_cast (show U ≤ d*(U/d)*2 by nlinarith [hm.2.2])
  have hh := Real.rpow_le_rpow_of_nonpos (show 0 < (U : ℝ)/2 by positivity) hhalf
    (show -β ≤ 0 by linarith)
  rw [Real.mul_rpow hdp.le hmp.le,Real.div_rpow hUp.le (by norm_num : (0 : ℝ) ≤ 2),
    Real.rpow_neg (by norm_num : (0 : ℝ) ≤ 2),div_inv_eq_mul] at hh
  have htwo : (2 : ℝ)^β ≤ 2 := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2) hβ1
  exact hh.trans (by nlinarith [mul_le_mul_of_nonneg_left htwo (show 0 ≤ (U : ℝ)^(-β) by positivity)])

end Legendre.Density.Detector.Smooth
