/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local upper-range power selection and strict pointwise exponent margins.
The useful short-block cutoff is B/2, not a fixed square-root length.
-/
module
public import Legendre.Layer4.HuxleyPowerSelection

@[expose] public section
namespace Legendre.Density.Moment

noncomputable def huxleyShortCutoff (σ : ℝ) : ℝ := huxleyPowerUpper σ/2

theorem huxley_general_window_bounds (σ : ℝ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    0 < huxleyPowerLower σ ∧ huxleyPowerLower σ ≤ 1 ∧
      huxleyPowerLower σ ≤ huxleyPowerUpper σ ∧
        huxleyPowerUpper σ = (3/2)*huxleyPowerLower σ := by
  have hd : 0 < 3*σ-1 := by linarith
  have he : huxleyPowerUpper σ = (3/2)*huxleyPowerLower σ := by
    unfold huxleyPowerUpper huxleyPowerLower
    field_simp
  have hA : 0 < huxleyPowerLower σ := by unfold huxleyPowerLower; positivity
  refine ⟨hA,?_,?_,he⟩
  · unfold huxleyPowerLower
    apply (div_le_one hd).mpr
    linarith
  · rw [he]
    linarith

/-- The varying short cutoff permits bounded powers throughout sigma in [3/4,1]. -/
theorem huxley_general_short_power (δ u σ : ℝ) (hδ : 0 < δ) (hδu : δ ≤ u)
    (hu : u ≤ huxleyShortCutoff σ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    ∃ k : ℕ, 1 ≤ k ∧ k ≤ huxleyPowerBudget δ ∧
      huxleyPowerLower σ ≤ (k : ℝ)*u ∧ (k : ℝ)*u ≤ huxleyPowerUpper σ := by
  have hup : 0 < u := hδ.trans_le hδu
  obtain ⟨hA,hA1,hAB,hBA⟩ := huxley_general_window_bounds σ hσ hσ1
  by_cases hsmall : u ≤ huxleyPowerLower σ/2
  · let k := ⌈huxleyPowerLower σ/u⌉₊
    have hkl : huxleyPowerLower σ/u ≤ k := Nat.le_ceil _
    have hku : (k : ℝ) < huxleyPowerLower σ/u+1 := Nat.ceil_lt_add_one (by positivity)
    have hkp : 0 < (k : ℝ) := (div_pos hA hup).trans_le hkl
    have hk1 : 1 ≤ k := by exact_mod_cast hkp
    have hlow : huxleyPowerLower σ ≤ (k : ℝ)*u := (div_le_iff₀ hup).mp hkl
    have hhigh : (k : ℝ)*u ≤ huxleyPowerUpper σ := by
      have hh := (lt_div_iff₀ hup).mp (show (k : ℝ)-1 < huxleyPowerLower σ/u by linarith)
      rw [hBA]
      nlinarith
    have hratio : huxleyPowerLower σ/u ≤ 1/δ :=
      div_le_div₀ (by positivity) hA1 hδ hδu
    have hkK : k ≤ huxleyPowerBudget δ := by
      have hh : 1/δ ≤ (⌈1/δ⌉₊ : ℝ) := Nat.le_ceil _
      have huK : (k : ℝ) ≤ (⌈1/δ⌉₊ : ℝ)+2 := by linarith
      exact_mod_cast huK
    exact ⟨k,hk1,hkK,hlow,hhigh⟩
  · refine ⟨2,by norm_num,?_,?_,?_⟩
    · unfold huxleyPowerBudget
      omega
    · norm_num only [Nat.cast_ofNat]
      linarith
    · norm_num only [Nat.cast_ofNat]
      unfold huxleyShortCutoff at hu
      linarith

theorem huxley_short_cutoff_eq (σ : ℝ) : huxleyShortCutoff σ = 3/(4*(3*σ-1)) := by
  unfold huxleyShortCutoff huxleyPowerUpper
  field_simp <;> norm_num

theorem huxley_short_cutoff_bounds (σ : ℝ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    3/8 ≤ huxleyShortCutoff σ ∧ huxleyShortCutoff σ ≤ 3/5 := by
  rw [huxley_short_cutoff_eq]
  have hd : 0 < 4*(3*σ-1) := by linarith
  constructor
  · apply (le_div_iff₀ hd).mpr
    linarith
  · apply (div_le_iff₀ hd).mpr
    linarith

/-- The upper real-part range gives a uniform negative exponent for all long-block costs. -/
theorem huxley_upper_exponent_margins (η σ : ℝ) (hη : 0 ≤ η)
    (hσ : 5/6+η ≤ σ) (hσ1 : σ ≤ 1) :
    1/6+(1/2-σ)*huxleyShortCutoff σ ≤ -η/8 ∧
      -1/4+(5/4-σ)*(3/5) ≤ -η/8 ∧
      -1/3+(1-σ)*(3/5) ≤ -η/8 ∧
      -σ*huxleyShortCutoff σ ≤ -η/8 ∧ 1/2-σ ≤ -η/8 := by
  have hσ0 : 3/4 ≤ σ := by linarith
  have hηu : η ≤ 1/6 := by linarith
  have hd : 0 < 3*σ-1 := by linarith
  have hc := huxley_short_cutoff_bounds σ hσ0 hσ1
  have he : 1/6+(1/2-σ)*huxleyShortCutoff σ = (5-6*σ)/(24*(3*σ-1)) := by
    rw [huxley_short_cutoff_eq]
    have hd0 : 3*σ-1 ≠ 0 := hd.ne'
    ring_nf at hd0
    field_simp [hd0] <;> ring_nf <;> field_simp [hd0] <;> ring
  refine ⟨?_,by linarith,by linarith,?_,by linarith⟩
  · rw [he]
    apply (div_le_iff₀ (show 0 < 24*(3*σ-1) by positivity)).mpr
    nlinarith [mul_nonneg hη (show 0 ≤ 2-(3*σ-1) by linarith)]
  · have hh := mul_le_mul_of_nonneg_left hc.1 (show 0 ≤ σ by linarith)
    nlinarith

end Legendre.Density.Moment
