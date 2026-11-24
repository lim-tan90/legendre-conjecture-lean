/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.InghamSharpLogarithms

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem polynomial_alternative_balanced_middle (α τ : ℝ) (hα : 1/2 < α) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → α ≤ σ → σ ≤ τ →
      ∀ X : ℕ, 1 ≤ X → T ≤ X → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I)
        (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^3 := by
  obtain ⟨C,hC,hb⟩ := polynomial_alternative_balanced_split τ hτ
  let δ := (1-τ)*(α-1/2)
  have hδ : 0 < δ := mul_pos (sub_pos.mpr hτ) (sub_pos.mpr hα)
  obtain ⟨D,hD,hlog⟩ := Zeta.exists_log_pow_le_rpow 2 hδ
  refine ⟨C*(1+D),by positivity,?_⟩
  intro T σ hT hασ hστ X hX hTX ι S t β ht hs hβ hlarge
  have hσ := hα.le.trans hασ
  have hσ1 := hστ.trans hτ.le
  have hT₀ : 0 < T := by linarith
  have hL : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  let E := balancedDensityExponent σ
  have he : 1-E = (2*σ-1)/(2-σ) := by
    dsimp [E]
    unfold balancedDensityExponent
    have hd : 2-σ ≠ 0 := by linarith
    field_simp [hd]
    ring
  have hdef : α-1/2 ≤ 1-E := by
    rw [he]
    apply (le_div_iff₀ (by linarith : 0 < 2-σ)).mpr
    have hp := mul_le_mul_of_nonneg_right (show α-1/2 ≤ σ-1/2 by linarith)
      (show 0 ≤ 2-σ by linarith)
    nlinarith [mul_nonneg (show 0 ≤ σ-1/2 by linarith) (show 0 ≤ σ by linarith)]
  have hgap : δ ≤ E-(2-2*σ) := by
    rw [show E-(2-2*σ) = (1-σ)*(1-E) from balanced_exponent_defect_relation σ hσ1]
    exact mul_le_mul (by linarith : 1-τ ≤ 1-σ) hdef (sub_nonneg.mpr hα.le) (by linarith)
  have htail : T^(2-2*σ)*(Real.log T)^5 ≤ D*T^E*(Real.log T)^3 := by
    calc
      _ = T^(2-2*σ)*(Real.log T)^2*(Real.log T)^3 := by ring
      _ ≤ T^(2-2*σ)*(D*T^δ)*(Real.log T)^3 := by
        exact mul_le_mul_of_nonneg_right
          (mul_le_mul_of_nonneg_left (hlog T hT) (by positivity)) (by positivity)
      _ = D*T^(2-2*σ+δ)*(Real.log T)^3 := by rw [Real.rpow_add hT₀]; ring
      _ ≤ _ := by
        apply mul_le_mul_of_nonneg_right _ (by positivity)
        exact mul_le_mul_of_nonneg_left
          (Real.rpow_le_rpow_of_exponent_le (by linarith) (by linarith)) hD.le
  calc
    _ ≤ C*(T^E*(Real.log T)^3+T^(2-2*σ)*(Real.log T)^5) :=
      hb T σ hT hσ hστ X hX hTX S t β ht hs hβ hlarge
    _ ≤ C*(T^E*(Real.log T)^3+D*T^E*(Real.log T)^3) :=
      mul_le_mul_of_nonneg_left (add_le_add le_rfl htail) hC.le
    _ = _ := by dsimp [E]; ring

theorem separated_high_shell_density_log_three_middle (α τ : ℝ) (hα : 1/2 < α) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → α ≤ σ → σ ≤ τ →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^3 := by
  obtain ⟨CP,hCP,hp⟩ := polynomial_alternative_balanced_middle α τ hα hτ
  obtain ⟨CI,hCI,hi⟩ := integral_alternative_balanced_fourth_moment_by_gap
  let B := (1/(α-1/2))^(4/3 : ℝ)
  have hB : 0 < B := Real.rpow_pos_of_pos (one_div_pos.mpr (by linarith)) _
  refine ⟨CP+CI*B*(Real.log 2)⁻¹,by positivity,?_⟩
  intro T σ hT hασ hστ ι S t β ht hs hz
  have hσ := hα.trans_le hασ
  have hσ1 := hστ.trans hτ.le
  have hT₀ : 2 ≤ T := by linarith
  obtain ⟨X,hX,hTX,hX2,hbX⟩ := hi T σ hT₀ hσ hσ1
  have hlog : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have hu := log_nat_pow_unit 1 T hT₀
  simp only [pow_one] at hu
  have hL : (Real.log T)^2 ≤ (Real.log 2)⁻¹*(Real.log T)^3 := by
    have h := mul_le_mul_of_nonneg_right hu (sq_nonneg (Real.log T))
    nlinarith
  have hg : (1/(σ-1/2))^(4/3 : ℝ) ≤ B := by
    apply Real.rpow_le_rpow (by have := sub_pos.mpr hσ; positivity) _ (by norm_num)
    exact div_le_div_of_nonneg_left zero_le_one (by linarith) (by linarith)
  have h := count_high_shell_of_detector_counts T σ X _ _ hT hσ hσ1 hX hX2
    (hp T σ hT₀ hασ hστ X hX hTX) hbX S t β ht hs hz
  apply h.trans
  calc
    _ ≤ CP*T^balancedDensityExponent σ*(Real.log T)^3+
        CI*T^balancedDensityExponent σ*B*((Real.log 2)⁻¹*(Real.log T)^3) := by
      apply add_le_add le_rfl
      exact mul_le_mul (mul_le_mul_of_nonneg_left hg (by positivity)) hL (by positivity) (by positivity)
    _ = _ := by ring

theorem separated_high_density_log_three_middle (α τ : ℝ) (hα : 1/2 < α) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → α ≤ σ → σ ≤ τ →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^3 := by
  obtain ⟨C,hC,hc⟩ := separated_high_shell_density_log_three_middle α τ hα hτ
  let η := 2*(1-τ)
  have hη : 0 < η := by dsimp [η]; linarith
  have hden : 0 < (2 : ℝ)^η-1 := sub_pos.mpr (Real.one_lt_rpow (by norm_num) hη)
  refine ⟨C*8^3*(256/((2 : ℝ)^η-1)),by positivity,?_⟩
  intro T σ hT hασ hστ ι S t β ht hs hz
  have hσ := hα.le.trans hασ
  have hσ1 := hστ.trans hτ.le
  have hT₀ : 2 ≤ T := by linarith
  have hL : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  let E := balancedDensityExponent σ
  have hηe : η ≤ E := by
    dsimp [E,η]
    linarith [balancedDensityExponent_ge_two_defect σ hσ hσ1]
  obtain ⟨J,hJl,hJu,_⟩ := real_height_dyadic_cover T hT₀
  let H := fun j : ℕ => 128*(2 : ℝ)^j
  have hcount := separated_high_density_shell_sum_of_count σ (fun U => C*U^E*(Real.log U)^3)
    (fun U hU {ι} S t β ht hs hz => hc U σ hU hασ hστ S t β ht hs hz)
    S t β T J hJl ht hs hz
  calc
    _ ≤ ∑ j ∈ Finset.range J, C*(H j)^E*(Real.log (H j))^3 := hcount
    _ ≤ ∑ j ∈ Finset.range J, C*(8*Real.log T)^3*(H j)^E := by
      apply Finset.sum_le_sum
      intro j hj
      have hpow : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
      have hh : 128 ≤ H j := by dsimp [H]; linarith
      have hl := height_shell_log_le (H j) T hh hT₀ (height_shell_upper J j T hj hJu)
      have h := mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (Real.log_nonneg (by linarith)) hl 3)
        (show 0 ≤ C*(H j)^E by positivity)
      convert h using 1
      ring
    _ = C*(8*Real.log T)^3*(∑ j ∈ Finset.range J, (H j)^E) := by rw [Finset.mul_sum]
    _ ≤ C*(8*Real.log T)^3*((256/((2 : ℝ)^η-1))*T^E) :=
      mul_le_mul_of_nonneg_left
        (height_shell_rpow_geometric J T E η hT₀ hη hηe
          (balancedDensityExponent_le_one σ hσ hσ1) hJu) (by positivity)
    _ = _ := by dsimp [E]; ring

end Legendre.Density.Moment

namespace Legendre.Zeta
open Density.Moment

/-- Four logarithms in the cumulative count on fixed strips away from
both ends of the critical strip. -/
theorem ingham_density_log_four_middle (α τ : ℝ) (hα : 1/2 < α) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Set.Icc α τ, ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^4 :=
  ingham_density_log_bound_of_samples 3 α τ hτ.le
    (separated_high_density_log_three_middle α τ hα hτ)

end Legendre.Zeta
