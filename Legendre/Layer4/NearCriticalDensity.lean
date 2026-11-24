/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions: unit separation handles the near-critical band uniformly,
including sigma=1/2. The curved analytic count is used outside that band.
-/
module
public import Legendre.Layer4.SeparatedShellDensity

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

universe u

theorem indexed_separated_card {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (T : ℝ) (hT : 0 ≤ T) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) : (S.card : ℝ) ≤ 2*(T+1) := by
  classical
  have hinj : Set.InjOn t S := by
    intro i hi j hj he
    by_contra hij
    have hh := hsep i hi j hj hij
    rw [he,sub_self,abs_zero] at hh
    norm_num at hh
  have hc := moment_separated_card (S.image t) T hT
    (by intro x hx; obtain ⟨i,hi,rfl⟩ := Finset.mem_image.mp hx; exact ht i hi)
    (by
      intro x hx y hy hxy
      obtain ⟨i,hi,rfl⟩ := Finset.mem_image.mp hx
      obtain ⟨j,hj,rfl⟩ := Finset.mem_image.mp hy
      exact hsep i hi j hj (fun he => hxy (congrArg t he)))
  rwa [Finset.card_image_of_injOn hinj] at hc

theorem near_critical_height_power (T σ : ℝ) (hT : 2 ≤ T) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1)
    (hgap : σ-1/2 ≤ 1/Real.log T) : T ≤ Real.exp 4*T^balancedDensityExponent σ := by
  have hTp : 0 < T := by linarith
  have hL : 0 < Real.log T := Real.log_pos (by linarith)
  have hmul := mul_le_mul_of_nonneg_right hgap hL.le
  rw [div_mul_cancel₀ _ hL.ne'] at hmul
  have he : 1-balancedDensityExponent σ = (2*σ-1)/(2-σ) := by
    unfold balancedDensityExponent
    have hd : 2-σ ≠ 0 := by linarith
    field_simp [hd]
    ring
  have hb : 1-balancedDensityExponent σ ≤ 2*(σ-1/2) := by
    rw [he]
    apply (div_le_iff₀ (by linarith : 0 < 2-σ)).mpr
    nlinarith [mul_nonneg (show 0 ≤ σ-1/2 by linarith) (show 0 ≤ 1-σ by linarith)]
  have hp : T^(1-balancedDensityExponent σ) ≤ Real.exp 4 := by
    rw [Real.rpow_def_of_pos hTp]
    apply Real.exp_le_exp.mpr
    have hh := mul_le_mul_of_nonneg_right hb hL.le
    nlinarith
  calc
    T = T^balancedDensityExponent σ*T^(1-balancedDensityExponent σ) := by
      rw [← Real.rpow_add hTp]
      simp
    _ ≤ T^balancedDensityExponent σ*Real.exp 4 :=
      mul_le_mul_of_nonneg_left hp (Real.rpow_nonneg hTp.le _)
    _ = _ := by ring

theorem log_nat_pow_unit (k : ℕ) (T : ℝ) (hT : 2 ≤ T) :
    1 ≤ (Real.log 2)⁻¹^k*(Real.log T)^k := by
  have hl : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hL := Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT
  have hp := pow_le_pow_left₀ hl.le hL k
  have hh := mul_le_mul_of_nonneg_left hp (show 0 ≤ (Real.log 2)⁻¹^k by positivity)
  simpa only [← mul_pow,inv_mul_cancel₀ hl.ne',one_pow] using hh

theorem log_eight_unit (T : ℝ) (hT : 2 ≤ T) :
    1 ≤ (Real.log 2)⁻¹^8*(Real.log T)^8 :=
  log_nat_pow_unit 8 T hT

theorem near_critical_separated_count_log (k : ℕ) {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (T σ : ℝ) (hT : 2 ≤ T) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1)
    (hgap : σ-1/2 ≤ 1/Real.log T) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (S.card : ℝ) ≤ (3*Real.exp 4*(Real.log 2)⁻¹^k)*T^balancedDensityExponent σ*(Real.log T)^k := by
  have hc := indexed_separated_card S t T (by linarith) ht hsep
  have hp := near_critical_height_power T σ hT hσ hσ1 hgap
  have hu := mul_le_mul_of_nonneg_left (log_nat_pow_unit k T hT)
    (show 0 ≤ 3*Real.exp 4*T^balancedDensityExponent σ by positivity)
  have hh : (S.card : ℝ) ≤ 3*Real.exp 4*T^balancedDensityExponent σ := by nlinarith
  apply hh.trans
  convert hu using 1 <;> ring

theorem near_critical_separated_count {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (T σ : ℝ) (hT : 2 ≤ T) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1)
    (hgap : σ-1/2 ≤ 1/Real.log T) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (S.card : ℝ) ≤ (3*Real.exp 4*(Real.log 2)⁻¹^8)*T^balancedDensityExponent σ*(Real.log T)^8 :=
  near_critical_separated_count_log 8 S t T σ hT hσ hσ1 hgap ht hsep

theorem separated_high_shell_density_uniform_of_gap (k : ℕ)
    (hgapBound : ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 < σ → σ ≤ 1 →
      1/Real.log T ≤ σ-1/2 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^k) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^k := by
  obtain ⟨C,hC,hb⟩ := hgapBound
  let D := 3*Real.exp 4*(Real.log 2)⁻¹^k
  have hD : 0 < D := by dsimp [D]; positivity
  refine ⟨C+D,by positivity,?_⟩
  intro T σ hT hσ hσ1 ι S t β ht hs hz
  have hlog : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  by_cases hgap : 1/Real.log T ≤ σ-1/2
  · have hσ' : 1/2 < σ := by
      have hh : 0 < 1/Real.log T := by apply one_div_pos.mpr; exact Real.log_pos (by linarith)
      linarith
    apply (hb T σ hT hσ' hσ1 hgap S t β ht hs hz).trans
    change _ ≤ (C+D)*T^balancedDensityExponent σ*(Real.log T)^k
    gcongr
    linarith
  · have hc := near_critical_separated_count_log k S t T σ (by linarith) hσ hσ1
      (le_of_lt (lt_of_not_ge hgap)) (fun i hi => (ht i hi).2) hs
    apply hc.trans
    dsimp [D]
    change _ ≤ (C+D)*T^balancedDensityExponent σ*(Real.log T)^k
    gcongr
    linarith

theorem separated_high_shell_density_uniform :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^8 :=
  separated_high_shell_density_uniform_of_gap 8 separated_high_shell_density

theorem separated_high_shell_density_uniform_log_five :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^5 :=
  separated_high_shell_density_uniform_of_gap 5 separated_high_shell_density_log_five

end Legendre.Density.Moment
