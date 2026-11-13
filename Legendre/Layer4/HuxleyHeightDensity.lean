/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The finite height assembly reuses DyadicHeightDensity.lean in this repository.
Local Huxley bounds retain all dyadic upper endpoints and a uniform sigma cost.
-/
module
public import Legendre.Layer4.HuxleyShellDensity
public import Legendre.Layer4.DyadicHeightDensity

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem huxley_height_shell_power_log (H T σ : ℝ) (hH : 128 ≤ H) (hT : 2 ≤ T)
    (hHT : H ≤ 128*T) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    H^huxleyBookExponent σ*(1+Real.log H)^36 ≤
      (128*8^36)*T^huxleyBookExponent σ*(1+Real.log T)^36 := by
  have hb := (huxley_book_exponent_bounds σ hσ hσ1).1
  have hb1 := huxley_book_exponent_le_one σ hσ hσ1
  have hp : H^huxleyBookExponent σ ≤ 128*T^huxleyBookExponent σ := by
    calc
      _ ≤ (128*T)^huxleyBookExponent σ := Real.rpow_le_rpow (by linarith) hHT hb
      _ = (128 : ℝ)^huxleyBookExponent σ*T^huxleyBookExponent σ :=
        Real.mul_rpow (by norm_num) (by linarith)
      _ ≤ (128 : ℝ)^(1 : ℝ)*T^huxleyBookExponent σ :=
        mul_le_mul_of_nonneg_right (Real.rpow_le_rpow_of_exponent_le (by norm_num) hb1) (by positivity)
      _ = _ := by rw [Real.rpow_one]
  have hl : 1+Real.log H ≤ 8*(1+Real.log T) := by
    have hh := Real.log_le_log (show 0 < H by linarith) hHT
    rw [Real.log_mul (by norm_num : (128 : ℝ) ≠ 0) (by linarith : T ≠ 0)] at hh
    have he : Real.log 128 = 7*Real.log 2 := by
      simpa only [show (2 : ℝ)^7 = 128 by norm_num,Nat.cast_ofNat] using Real.log_pow (2 : ℝ) 7
    rw [he] at hh
    have h2 := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
    have ht := Real.log_nonneg (show 1 ≤ T by linarith)
    linarith
  have hHlog : 0 ≤ 1+Real.log H := by linarith [Real.log_nonneg (show 1 ≤ H by linarith)]
  have hlp := pow_le_pow_left₀ hHlog hl 36
  have hh := mul_le_mul hp hlp (by positivity) (by positivity)
  convert hh using 1 <;> ring

theorem huxley_separated_high_density :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 3/4 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^huxleyBookExponent σ*(1+Real.log T)^37 := by
  classical
  obtain ⟨C,hC,hc⟩ := huxley_separated_high_shell_density
  refine ⟨C*(128*8^36)*(2/Real.log 2),by positivity,?_⟩
  intro T σ hT hσ hσ1 ι S t β ht hs hz
  obtain ⟨J,hJl,hJu,hJlog⟩ := real_height_dyadic_cover T (by linarith)
  have hcard := height_shell_card_le S t J (fun i hi => (ht i hi).1)
    (by intro i hi; exact (ht i hi).2.trans (by nlinarith))
  have hsum : ∀ j ∈ Finset.range J,
      ((S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)).card : ℝ) ≤
        C*(128*8^36)*T^huxleyBookExponent σ*(1+Real.log T)^36 := by
    intro j hj
    let F := S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)
    have hpow : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
    have hupper : 128*(2 : ℝ)^j ≤ 128*T := by
      have hp : (2 : ℝ)^(j+1) ≤ 2^J := pow_le_pow_right₀ (by norm_num) (Finset.mem_range.mp hj)
      rw [pow_succ] at hp
      nlinarith
    have hf := hc (128*(2 : ℝ)^j) σ (by nlinarith) hσ hσ1 F t β
      (by intro i hi; have hh := (Finset.mem_filter.mp hi).2; constructor <;> linarith [hh.1,hh.2])
      (fun i hi k hk hik => hs i (Finset.mem_filter.mp hi).1 k (Finset.mem_filter.mp hk).1 hik)
      (fun i hi => hz i (Finset.mem_filter.mp hi).1)
    have hp := mul_le_mul_of_nonneg_left
      (huxley_height_shell_power_log (128*(2 : ℝ)^j) T σ (by nlinarith) (by linarith) hupper hσ hσ1) hC.le
    exact hf.trans (by convert hp using 1 <;> ring)
  apply (hcard.trans (Finset.sum_le_sum hsum)).trans
  rw [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
  have hJ : (J : ℝ) ≤ (2/Real.log 2)*(1+Real.log T) := by
    apply hJlog.trans
    have hc : 0 ≤ 2/Real.log 2 := by positivity
    exact mul_le_mul_of_nonneg_left (by linarith : Real.log T ≤ 1+Real.log T) hc
  have hh := mul_le_mul_of_nonneg_right hJ
    (show 0 ≤ C*(128*8^36)*T^huxleyBookExponent σ*(1+Real.log T)^36 by positivity)
  convert hh using 1 <;> ring

end Legendre.Density.Moment
