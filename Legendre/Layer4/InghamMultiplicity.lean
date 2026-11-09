/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions. Restore actual analytic multiplicities after separated
sampling, retaining a fixed low-height count. The analytic input is the proved
compact-detector estimate, not an assumed density theorem.
-/
module
public import Legendre.Layer4.DyadicHeightDensity
public import Legendre.ZetaDetectedDensity

@[expose] public section
namespace Legendre.Zeta
open Complex Set
open scoped BigOperators

theorem zeroDensityCount_le_of_cutoff_sample_bound (σ U : ℝ) {T B : ℝ} (hT : 7 ≤ T)
    (hsample : ∀ S : Finset ℂ, (∀ ρ ∈ S, ρ ∈ zerosRightOf σ T) →
      (∀ ρ ∈ S, U < ρ.im) →
      (∀ ρ ∈ S, ∀ z ∈ S, ρ ≠ z → 1 ≤ |ρ.im-z.im|) → (S.card : ℝ) ≤ B) :
    (zeroDensityCount σ T : ℝ) ≤ (zeroCount U : ℝ)+2*densitySelectionConstant*Real.log T*B := by
  classical
  let Z := (zerosRightOf_finite σ T).toFinset
  let high := Z.filter (fun ρ => U < ρ.im)
  let low := Z.filter (fun ρ => ρ.im ≤ U)
  have hhigh : ∀ ρ ∈ high, ρ ∈ zerosRightOf σ T := fun ρ hρ =>
    (zerosRightOf_finite σ T).mem_toFinset.1 (Finset.mem_filter.1 hρ).1
  obtain ⟨r,hrs,hsep,hcount⟩ := exists_density_subset_separated_representatives σ hT high hhigh
  have hr := hsample r (fun ρ hρ => hhigh ρ (hrs hρ))
    (fun ρ hρ => (Finset.mem_filter.1 (hrs hρ)).2) hsep
  have hA : 0 ≤ 2*densitySelectionConstant*Real.log T :=
    mul_nonneg (mul_nonneg (by norm_num) densitySelectionConstant_pos.le)
      (Real.log_nonneg (by linarith))
  have hweighted : ((∑ ρ ∈ high, zeroMultiplicity ρ : ℕ) : ℝ) ≤
      2*densitySelectionConstant*Real.log T*B :=
    hcount.trans (mul_le_mul_of_nonneg_left hr hA)
  have hlow : (∑ ρ ∈ low, zeroMultiplicity ρ) ≤ zeroCount U := by
    unfold zeroCount
    apply Finset.sum_le_sum_of_subset
    intro ρ hρ
    have hh := Finset.mem_filter.1 hρ
    have hz := (zerosRightOf_finite σ T).mem_toFinset.1 hh.1
    exact (zerosUpTo_finite U).mem_toFinset.2 ⟨hz.1.1,hz.1.2.1,hh.2⟩
  have hsplit : zeroDensityCount σ T =
      (∑ ρ ∈ high, zeroMultiplicity ρ)+(∑ ρ ∈ low, zeroMultiplicity ρ) := by
    symm
    simpa only [high,low,Z,not_lt,zeroDensityCount] using
      Finset.sum_filter_add_sum_filter_not Z (fun ρ => U < ρ.im) zeroMultiplicity
  have hlowR : ((∑ ρ ∈ low, zeroMultiplicity ρ : ℕ) : ℝ) ≤ (zeroCount U : ℝ) := by exact_mod_cast hlow
  rw [hsplit,Nat.cast_add]
  linarith

end Legendre.Zeta
namespace Legendre.Density.Moment

theorem height_log_unit (k : ℕ) (T σ : ℝ) (hT : 2 ≤ T) (hσ1 : σ ≤ 1) :
    1 ≤ (Real.log 2)⁻¹^k*T^balancedDensityExponent σ*(Real.log T)^k := by
  have hl : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hL := Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT
  have hp := pow_le_pow_left₀ hl.le hL k
  have hh := mul_le_mul_of_nonneg_left hp (show 0 ≤ (Real.log 2)⁻¹^k by positivity)
  have hu : 1 ≤ (Real.log 2)⁻¹^k*(Real.log T)^k := by
    simpa only [←mul_pow,inv_mul_cancel₀ hl.ne',one_pow] using hh
  have ht : 1 ≤ T^balancedDensityExponent σ := Real.one_le_rpow (by linarith)
    (balancedDensityExponent_nonneg σ hσ1)
  have h := mul_le_mul_of_nonneg_left ht (show 0 ≤ (Real.log 2)⁻¹^k*(Real.log T)^k by positivity)
  nlinarith

end Legendre.Density.Moment
namespace Legendre.Zeta
open Density.Moment

theorem ingham_density_log_bound :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Set.Icc (1/2 : ℝ) 1, ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^10 := by
  classical
  obtain ⟨C,hC,hc⟩ := separated_high_density
  let D := ((zeroCount 128 : ℝ)+1)*(Real.log 2)⁻¹^10
  let A := 2*densitySelectionConstant*C
  have hD : 0 < D := by dsimp [D]; positivity
  have hA : 0 < A := by
    have hd := densitySelectionConstant_pos
    dsimp [A]
    positivity
  refine ⟨D+A,by positivity,?_⟩
  intro σ hσ T hT
  have hunit := height_log_unit 10 T σ hT hσ.2
  have hlow : (zeroCount 128 : ℝ) ≤ D*T^balancedDensityExponent σ*(Real.log T)^10 := by
    have hh := mul_le_mul_of_nonneg_left hunit (show 0 ≤ (zeroCount 128 : ℝ)+1 by positivity)
    dsimp [D]
    nlinarith
  by_cases hlarge : 128 ≤ T
  · have hcount := zeroDensityCount_le_of_cutoff_sample_bound σ 64 (by linarith : 7 ≤ T)
      (B := C*T^balancedDensityExponent σ*(Real.log T)^9) (by
        intro S hS hheight hsep
        apply hc T σ hlarge hσ.1 hσ.2 S Complex.im Complex.re
        · intro ρ hρ
          rw [abs_of_pos (hS ρ hρ).1.2.1]
          exact ⟨hheight ρ hρ,(hS ρ hρ).1.2.2⟩
        · exact hsep
        · intro ρ hρ
          have hz := hS ρ hρ
          exact ⟨hz.2,hz.1.1.2.2.le,by simpa only [Complex.re_add_im] using hz.1.1.1⟩)
    have hlown : (zeroCount 64 : ℝ) ≤ (zeroCount 128 : ℝ) := by
      exact_mod_cast zeroCount_mono (show (64 : ℝ) ≤ 128 by norm_num)
    have he : 2*densitySelectionConstant*Real.log T*
        (C*T^balancedDensityExponent σ*(Real.log T)^9) = A*T^balancedDensityExponent σ*(Real.log T)^10 := by
      dsimp [A]; ring
    rw [he] at hcount
    nlinarith
  · have hn : (zeroDensityCount σ T : ℝ) ≤ (zeroCount 128 : ℝ) := by
      exact_mod_cast (zeroDensityCount_le σ T).trans (zeroCount_mono (le_of_not_ge hlarge))
    have ha : 0 ≤ A*T^balancedDensityExponent σ*(Real.log T)^10 := by positivity
    nlinarith

end Legendre.Zeta
