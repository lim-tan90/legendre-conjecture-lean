/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityPartialMean.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiHeadMean
public import Legendre.Layer4.XiTailAssembly
public import Legendre.Layer4.DyadicPartition

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set
open Density Density.Moment
open scoped BigOperators

theorem xiFiniteSquare_partial_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ N : ℕ, 1 ≤ N → ∀ T : ℝ,
      1 ≤ T → 1 ≤ Real.log N → 10*T ≤ N → ∀ J : ℕ,
      (∫ t in Icc (-T) T, ‖∑ n ∈ Finset.Icc 1 (2^J*N),
        xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖^2) ≤
          C*((N : ℝ)+T)*(Real.log N)^6 := by
  obtain ⟨CH,hCH,hhead⟩ := xiFiniteSquare_head_mean
  obtain ⟨CT,hCT,htail⟩ := xiFiniteSquare_tail_assembly
  refine ⟨2*CH+16*CT, by positivity, ?_⟩
  intro N hN T hT hL hscale J
  let H := fun t : ℝ => ∑ n ∈ Finset.Icc 1 N,
    xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n
  let R := fun t : ℝ => ∑ j ∈ Finset.range J,
    ∑ n ∈ Finset.Ioc (2^j*N) (2^(j+1)*N),
      xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n
  have hH : ContinuousOn H (Icc (-T) T) :=
    xiFiniteSquare_continuousOn _ (fun n hn => (Finset.mem_Icc.mp hn).1) T hT
  have hR : ContinuousOn R (Icc (-T) T) := by
    apply continuousOn_finsetSum
    intro j _
    apply xiFiniteSquare_continuousOn _ _ T hT
    intro n hn
    have hn' := (Finset.mem_Ioc.mp hn).1
    omega
  have hpoint (t : ℝ) : ‖H t+R t‖^2 ≤ 2*‖H t‖^2+2*‖R t‖^2 := by
    have h := pow_le_pow_left₀ (norm_nonneg _) (norm_add_le (H t) (R t)) 2
    nlinarith [sq_nonneg (‖H t‖-‖R t‖)]
  have hh : Integrable (fun t => ‖H t‖^2) (volume.restrict (Icc (-T) T)) :=
    (hH.norm.pow 2).integrableOn_Icc
  have hr : Integrable (fun t => ‖R t‖^2) (volume.restrict (Icc (-T) T)) :=
    (hR.norm.pow 2).integrableOn_Icc
  have hm := integral_mono ((hH.add hR).norm.pow 2).integrableOn_Icc
    ((hh.const_mul 2).add (hr.const_mul 2)) hpoint
  simp only [Pi.add_apply,Pi.pow_apply] at hm
  rw [integral_add (hh.const_mul 2) (hr.const_mul 2),integral_const_mul,integral_const_mul] at hm
  have hlog : (1+Real.log N)^3 ≤ 8*(Real.log N)^6 := by
    have hbase : 1+Real.log N ≤ 2*(Real.log N)^2 := by nlinarith
    have h := pow_le_pow_left₀ (by linarith : 0 ≤ 1+Real.log N) hbase 3
    nlinarith
  calc
    _ = ∫ t in Icc (-T) T, ‖H t+R t‖^2 := by
      apply integral_congr_ae
      filter_upwards with t
      rw [moment_dyadic_partition N J hN]
    _ ≤ 2*(∫ t in Icc (-T) T, ‖H t‖^2)+2*(∫ t in Icc (-T) T, ‖R t‖^2) := hm
    _ ≤ 2*(CH*((N : ℝ)+T)*(Real.log N)^6)+
        2*(CT*((N : ℝ)+T)*(1+Real.log N)^3) :=
      add_le_add (mul_le_mul_of_nonneg_left (hhead N T hT hL hscale) (by norm_num))
        (mul_le_mul_of_nonneg_left (htail N hN T hT hscale J) (by norm_num))
    _ ≤ _ := by
      have hb := mul_le_mul_of_nonneg_left hlog
        (show 0 ≤ 2*CT*((N : ℝ)+T) by positivity)
      nlinarith

end Legendre.Zeta
