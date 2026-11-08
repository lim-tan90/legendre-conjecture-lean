/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorWeight.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
This is a compact Mellin kernel; the zeta pole must be treated separately.
-/
module
public import Mathlib.Analysis.MellinInversion
public import Mathlib.Tactic

@[expose] public section
namespace Legendre.Density.Detector.Smooth

open Complex MeasureTheory Set

noncomputable def detectorWeight (x : ℝ) : ℂ :=
  (max (1 - x) 0 : ℝ) ^ 2 / 2

noncomputable def detectorKernel (s : ℂ) : ℂ :=
  1 / (s * (s + 1) * (s + 2))

 theorem detectorWeight_continuous : Continuous detectorWeight := by
  unfold detectorWeight
  fun_prop

 theorem detectorWeight_nonneg (x : ℝ) : 0 ≤ (detectorWeight x).re := by
  simp only [detectorWeight, div_ofNat_re, pow_two, mul_re, ofReal_re, ofReal_im,
    mul_zero, sub_zero]
  positivity

 theorem detectorWeight_zero (x : ℝ) (hx : 1 ≤ x) : detectorWeight x = 0 := by
  simp [detectorWeight, max_eq_right (by linarith : 1 - x ≤ 0)]

 theorem detectorWeight_eq (x : ℝ) (hx : x ≤ 1) :
    detectorWeight x = ((1 - x) ^ 2 / 2 : ℝ) := by
  simp only [detectorWeight, max_eq_left (by linarith : 0 ≤ 1 - x),
    ofReal_div, ofReal_pow, ofReal_ofNat]

 theorem detectorWeight_at_one_div (Y : ℝ) (hY : 4 ≤ Y) :
    1 / 4 ≤ (detectorWeight (1 / Y)).re := by
  have hYp : 0 < Y := by linarith
  rw [detectorWeight_eq _ (by exact (div_le_one hYp).mpr (by linarith))]
  simp only [ofReal_re]
  have hy : 0 ≤ 1 / Y := by positivity
  have hy4 : 1 / Y ≤ (1 / 4 : ℝ) := (div_le_div_iff₀ hYp (by norm_num)).mpr (by linarith)
  nlinarith


open Complex MeasureTheory Set

 theorem detectorWeight_hasMellin (s : ℂ) (hs : 0 < s.re) :
    HasMellin detectorWeight s (detectorKernel s) := by
  let f0 : ℝ → ℂ := indicator (Ioc 0 1) (fun _ => 1)
  let f1 : ℝ → ℂ := indicator (Ioc 0 1) (fun u => (u : ℂ) ^ (1 : ℂ))
  let f2 : ℝ → ℂ := indicator (Ioc 0 1) (fun u => (u : ℂ) ^ (2 : ℂ))
  have h0 : HasMellin f0 s (1 / s) := hasMellin_one_Ioc hs
  have h1 : HasMellin f1 s (1 / (s + 1)) := hasMellin_cpow_Ioc 1 (by simp; linarith)
  have h2 : HasMellin f2 s (1 / (s + 2)) := hasMellin_cpow_Ioc 2 (by simp; linarith)
  have h21 := hasMellin_const_smul h1.1 (2 : ℂ)
  have hsub := hasMellin_sub h0.1 h21.1
  have hadd := hasMellin_add hsub.1 h2.1
  have hhalf := hasMellin_const_smul hadd.1 (1 / 2 : ℂ)
  rw [hadd.2, hsub.2, h21.2, h0.2, h1.2, h2.2] at hhalf
  let f : ℝ → ℂ := fun u => (1 / 2 : ℂ) • ((f0 u - (2 : ℂ) • f1 u) + f2 u)
  have he : EqOn f detectorWeight (Ioi 0) := by
    intro u hu
    change 0 < u at hu
    by_cases hle : u ≤ 1
    · have hm : u ∈ Ioc (0 : ℝ) 1 := ⟨hu, hle⟩
      simp only [f, f0, f1, f2, indicator_of_mem hm, cpow_one, cpow_ofNat, smul_eq_mul,
        detectorWeight, max_eq_left (sub_nonneg.mpr hle)]
      push_cast
      ring
    · have hn : u ∉ Ioc (0 : ℝ) 1 := fun h => hle h.2
      simp [f, f0, f1, f2, hn, detectorWeight, max_eq_right (by linarith : 1 - u ≤ 0)]
  refine ⟨hhalf.1.congr_fun (fun u hu => congrArg (fun a : ℂ => (u : ℂ) ^ (s - 1) • a)
    (he hu)) measurableSet_Ioi, ?_⟩
  have hi : mellin detectorWeight s = mellin f s := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro u hu
    exact congrArg (fun a : ℂ => (u : ℂ) ^ (s - 1) • a) (he hu).symm
  rw [hi, hhalf.2]
  have hsn : s ≠ 0 := by intro h; simp [h] at hs
  have hs1 : s + 1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp only [add_re, one_re, zero_re] at this
    linarith
  have hs2 : s + 2 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    norm_num at this
    linarith
  unfold detectorKernel
  simp only [smul_eq_mul]
  field_simp
  ring

end Legendre.Density.Detector.Smooth
