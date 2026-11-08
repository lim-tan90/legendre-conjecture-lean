/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaDensitySelection
public import Legendre.ZeroDetector.TailEnergy

/-!
# Multiplicity-weighted density from actual compensated zero detection

The finite detector length and both branch energies remain explicit. The
result below is unconditional, with no named Ingham/Huxley exponent asserted.
A fixed low-height count is retained when excluding height zero from sampling.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Set

/-- Every density subset admits weighted separated representatives with the same local bound. -/
theorem exists_density_subset_separated_representatives (σ : ℝ) {T : ℝ} (hT : 7 ≤ T)
    (S : Finset ℂ) (hS : ∀ ρ ∈ S, ρ ∈ zerosRightOf σ T) :
    ∃ r : Finset ℂ, r ⊆ S ∧
      (∀ ρ ∈ r, ∀ z ∈ r, ρ ≠ z → 1 ≤ |ρ.im-z.im|) ∧
      ((∑ ρ ∈ S, zeroMultiplicity ρ : ℕ) : ℝ) ≤
        2*densitySelectionConstant*Real.log T*r.card := by
  classical
  have hlocal (t : ℝ) :
      ((∑ ρ ∈ S.filter (fun ρ => |ρ.im-t| ≤ 1/2), zeroMultiplicity ρ : ℕ) : ℝ) ≤
        densitySelectionConstant*Real.log T := by
    have hsub : S.filter (fun ρ => |ρ.im-t| ≤ 1/2) ⊆
        (zerosRightOf_finite σ T).toFinset.filter (fun ρ => |ρ.im-t| ≤ 1/2) := by
      intro ρ hρ
      have hh := Finset.mem_filter.1 hρ
      exact Finset.mem_filter.2 ⟨(zerosRightOf_finite σ T).mem_toFinset.2 (hS ρ hh.1),hh.2⟩
    have hn := Finset.sum_le_sum_of_subset hsub (f := zeroMultiplicity)
    have hr : ((∑ ρ ∈ S.filter (fun ρ => |ρ.im-t| ≤ 1/2), zeroMultiplicity ρ : ℕ) : ℝ) ≤
        ((∑ ρ ∈ (zerosRightOf_finite σ T).toFinset.filter (fun ρ => |ρ.im-t| ≤ 1/2),
          zeroMultiplicity ρ : ℕ) : ℝ) := by exact_mod_cast hn
    exact hr.trans ((density_window_mass_le σ hT t).trans (densityLocalMassBound_le_log hT))
  obtain ⟨r,hrs,hsep,hcount⟩ := Density.exists_weighted_separated_representatives
    S Complex.im zeroMultiplicity hlocal
  exact ⟨r,hrs,hsep,by simpa only [mul_assoc] using hcount⟩

/-- A proved bound for separated high samples restores all analytic multiplicities.
The sample estimate is an explicit analytic input, not a density conclusion. -/
theorem zeroDensityCount_le_of_high_sample_bound (σ : ℝ) {T B : ℝ} (hT : 7 ≤ T)
    (hsample : ∀ S : Finset ℂ, (∀ ρ ∈ S, ρ ∈ zerosRightOf σ T) →
      (∀ ρ ∈ S, 1 ≤ ρ.im) →
      (∀ ρ ∈ S, ∀ z ∈ S, ρ ≠ z → 1 ≤ |ρ.im-z.im|) → (S.card : ℝ) ≤ B) :
    (zeroDensityCount σ T : ℝ) ≤ (zeroCount 1 : ℝ)+2*densitySelectionConstant*Real.log T*B := by
  classical
  let Z := (zerosRightOf_finite σ T).toFinset
  let high := Z.filter (fun ρ => 1 ≤ ρ.im)
  let low := Z.filter (fun ρ => ρ.im < 1)
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
  have hlow : (∑ ρ ∈ low, zeroMultiplicity ρ) ≤ zeroCount 1 := by
    unfold zeroCount
    apply Finset.sum_le_sum_of_subset
    intro ρ hρ
    have hh := Finset.mem_filter.1 hρ
    have hz := (zerosRightOf_finite σ T).mem_toFinset.1 hh.1
    exact (zerosUpTo_finite 1).mem_toFinset.2 ⟨hz.1.1,hz.1.2.1,hh.2.le⟩
  have hsplit : zeroDensityCount σ T =
      (∑ ρ ∈ high, zeroMultiplicity ρ)+(∑ ρ ∈ low, zeroMultiplicity ρ) := by
    symm
    simpa only [high,low,Z,not_le,zeroDensityCount] using
      Finset.sum_filter_add_sum_filter_not Z (fun ρ => 1 ≤ ρ.im) zeroMultiplicity
  have hlowR : ((∑ ρ ∈ low, zeroMultiplicity ρ : ℕ) : ℝ) ≤ (zeroCount 1 : ℝ) := by exact_mod_cast hlow
  rw [hsplit,Nat.cast_add]
  linarith

end Legendre.Zeta

namespace Legendre.Density.Detector

/-- The fully displayed two-branch sample majorant. -/
noncomputable def actualDetectorSampleBound (H X : ℕ) (σ : ℝ) : ℝ :=
  (64/9 : ℝ)*(
    complexSampleCoefficient (X*zetaDetectorLength H X) H*
      detectorTailEnergyBound X (zetaDetectorLength H X) σ+
    ((zetaDetectorLength H X : ℝ)^(1-σ))^2*complexSampleCoefficient X H*(1+Real.log X))

end Legendre.Density.Detector

namespace Legendre.Zeta

/-- Actual finite detection and sampling bound the complete multiplicity-weighted zero count.
The large height exponent resulting from the present detector length remains explicit. -/
theorem zeroDensityCount_le_actual_detector {H X : ℕ} (hH : 7 ≤ H) (hX : 1 < X)
    {σ : ℝ} (hσ : 1/2 < σ) (hσ1 : σ ≤ 1) :
    (zeroDensityCount σ H : ℝ) ≤ (zeroCount 1 : ℝ)+
      2*densitySelectionConstant*Real.log H*Density.Detector.actualDetectorSampleBound H X σ := by
  apply zeroDensityCount_le_of_high_sample_bound σ (by exact_mod_cast hH)
  intro S hS hheight hsep
  exact Density.Detector.actual_zero_sample_card_le_explicit S (by omega) hX hσ hσ1
    (fun ρ hρ => (hS ρ hρ).1.1) (fun ρ hρ => (hS ρ hρ).2)
    (fun ρ hρ => ⟨hheight ρ hρ,(hS ρ hρ).1.2.2⟩) hsep

end Legendre.Zeta
