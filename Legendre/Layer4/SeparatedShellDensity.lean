/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensitySeparatedCount.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The high-ordinate zeta shell keeps the principal-pole constraints explicit.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.BalancedAlternatives

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

universe u

theorem four_logs_le_eight (L : ℝ) (hL : Real.log 2 ≤ L) :
    L^4 ≤ (Real.log 2)⁻¹^4*L^8 := by
  have hl : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hp := pow_le_pow_left₀ hl.le hL 4
  calc
    _ = (Real.log 2)⁻¹^4*((Real.log 2)^4*L^4) := by
      rw [← mul_assoc,← mul_pow,inv_mul_cancel₀ hl.ne',one_pow,one_mul]
    _ ≤ (Real.log 2)⁻¹^4*(L^4*L^4) := by gcongr
    _ = _ := by ring

theorem four_logs_le_of_le (k : ℕ) (hk : 4 ≤ k) (L : ℝ) (hL : Real.log 2 ≤ L) :
    L^4 ≤ (Real.log 2)⁻¹^(k-4)*L^k := by
  have hl : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hp := pow_le_pow_left₀ hl.le hL (k-4)
  have hout := mul_le_mul_of_nonneg_left hp (by positivity : 0 ≤ (Real.log 2)⁻¹^(k-4))
  rw [← mul_pow, inv_mul_cancel₀ hl.ne', one_pow] at hout
  have hoff : k = 4+(k-4) := by omega
  calc
    L^4 = 1*L^4 := by ring
    _ ≤ ((Real.log 2)⁻¹^(k-4)*L^(k-4))*L^4 := mul_le_mul_of_nonneg_right hout (by positivity)
    _ = _ := by
      conv_rhs => rw [show L^k = L^4*L^(k-4) by rw [←pow_add, ←hoff]]
      ring

/-- Retain the two terms of the detector dichotomy and their constants. -/
theorem separated_high_shell_density_of_branches (τ : ℝ) (hτ : τ ≤ 1)
    (P₀ : ℝ → ℝ → ℝ) (hpoly : ∀ T σ : ℝ, 2 ≤ T → 1/2 ≤ σ → σ ≤ τ →
      ∀ X : ℕ, 1 ≤ X → T ≤ X → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I)
        (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ P₀ T σ) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 < σ → σ ≤ τ →
      1/Real.log T ≤ σ-1/2 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ P₀ T σ+C*T^balancedDensityExponent σ*(Real.log T)^4 := by
  classical
  obtain ⟨CI,hCI,hi⟩ := integral_alternative_balanced
  refine ⟨CI,hCI,?_⟩
  intro T σ hT hσ hστ hgap ι S t β ht hs hz
  have hσ1 := hστ.trans hτ
  obtain ⟨X,hX,hTX,hX2,hiX⟩ := hi T σ (by linarith) hσ hσ1 hgap
  let Y := T^detectorBalanceExponent σ
  let p : ι → Prop := fun i => (1/16 : ℝ) ≤
    ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖
  let P := S.filter p
  let N := S.filter (fun i => ¬p i)
  have hY4 : 4 ≤ Y := by
    have h := Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
      (balance_exponent_ge_one σ hσ.le hσ1)
    rw [Real.rpow_one] at h
    exact (by linarith : 4 ≤ T).trans h
  have hY2 : Y ≤ (T/2)^2 := balanced_scale_below_half_height_square T σ (by linarith) hσ1
  have hP := hpoly T σ (by linarith) hσ.le hστ X hX hTX P t β
    (fun i hi => (ht i (Finset.mem_filter.mp hi).1).2)
    (fun i hi j hj => hs i (Finset.mem_filter.mp hi).1 j (Finset.mem_filter.mp hj).1)
    (fun i hi => ⟨(hz i (Finset.mem_filter.mp hi).1).1,(hz i (Finset.mem_filter.mp hi).1).2.1⟩)
    (fun _ hi => (Finset.mem_filter.mp hi).2)
  have hNlarge (i : ι) (hiN : i ∈ N) :
      (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) Y‖ := by
    obtain ⟨hiS,hn⟩ := Finset.mem_filter.mp hiN
    have hzi := hz i hiS
    have hs1 : (β i : ℂ)+(t i : ℂ)*I ≠ 1 := by
      intro he
      have hh := congrArg Complex.im he
      simp at hh
      have hlower := (ht i hiS).1
      rw [hh,abs_zero] at hlower
      linarith
    have hd := Detector.Smooth.detector_high_zero_dichotomy X hX hs1 hzi.2.2
      (by simpa using hσ.trans_le hzi.1) (by simpa using hzi.2.1)
      (T := T/2) (by linarith) (by simpa using (ht i hiS).1)
      (by linarith : (X : ℝ) ≤ 4*(T/2)) hY4 hY2
    exact hd.resolve_left hn
  have hN := hiX N β t
    (fun i hi => (ht i (Finset.mem_filter.mp hi).1).2)
    (fun i hi j hj => hs i (Finset.mem_filter.mp hi).1 j (Finset.mem_filter.mp hj).1)
    (fun i hi => ⟨(hz i (Finset.mem_filter.mp hi).1).1,(hz i (Finset.mem_filter.mp hi).1).2.1⟩) hNlarge
  have hcard : (S.card : ℝ) = (P.card : ℝ)+(N.card : ℝ) := by
    exact_mod_cast (Finset.card_filter_add_card_filter_not (s := S) (p := p)).symm
  rw [hcard]
  exact add_le_add hP hN

/-- Combine the polynomial count with the fourth-log integral count. -/
theorem separated_high_shell_density_of_polynomial (k : ℕ) (hk : 4 ≤ k)
    (hpoly : ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ X : ℕ, 1 ≤ X → T ≤ X → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I)
        (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^k) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 < σ → σ ≤ 1 →
      1/Real.log T ≤ σ-1/2 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^k := by
  obtain ⟨CP,hCP,hp⟩ := hpoly
  obtain ⟨CI,hCI,hb⟩ := separated_high_shell_density_of_branches 1 le_rfl
    (fun T σ => CP*T^balancedDensityExponent σ*(Real.log T)^k) hp
  refine ⟨CP+CI*(Real.log 2)⁻¹^(k-4),by positivity,?_⟩
  intro T σ hT hσ hσ1 hgap ι S t β ht hs hz
  have hL : Real.log 2 ≤ Real.log T := Real.log_le_log (by norm_num) (by linarith)
  have hN := mul_le_mul_of_nonneg_left (four_logs_le_of_le k hk (Real.log T) hL)
    (show 0 ≤ CI*T^balancedDensityExponent σ by positivity)
  calc
    _ ≤ CP*T^balancedDensityExponent σ*(Real.log T)^k+
        CI*T^balancedDensityExponent σ*(Real.log T)^4 :=
      hb T σ hT hσ hσ1 hgap S t β ht hs hz
    _ ≤ CP*T^balancedDensityExponent σ*(Real.log T)^k+
        CI*T^balancedDensityExponent σ*((Real.log 2)⁻¹^(k-4)*(Real.log T)^k) :=
      add_le_add le_rfl hN
    _ = _ := by ring

theorem separated_high_shell_density :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 < σ → σ ≤ 1 →
      1/Real.log T ≤ σ-1/2 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^8 :=
  separated_high_shell_density_of_polynomial 8 (by norm_num) polynomial_alternative_balanced

theorem separated_high_shell_density_log_five :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 < σ → σ ≤ 1 →
      1/Real.log T ≤ σ-1/2 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^5 :=
  separated_high_shell_density_of_polynomial 5 (by norm_num) polynomial_alternative_balanced_log_five

end Legendre.Density.Moment
