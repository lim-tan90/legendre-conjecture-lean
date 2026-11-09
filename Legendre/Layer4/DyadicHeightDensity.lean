/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions from the proved compact-detector shell estimate. The real
height cover retains its upper endpoint, so combining shells does not lose a
power of T. No zero-density estimate is assumed.
-/
module
public import Legendre.Layer4.NearCriticalDensity

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem real_height_dyadic_cover (T : ℝ) (hT : 2 ≤ T) :
    ∃ J : ℕ, T ≤ (2 : ℝ)^J ∧ (2 : ℝ)^J ≤ 2*T ∧
      (J : ℝ) ≤ (2/Real.log 2)*Real.log T := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hlog := Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT
  let J := ⌈Real.log T/Real.log 2⌉₊
  have hl : Real.log T/Real.log 2 ≤ J := Nat.le_ceil _
  have hu : (J : ℝ) < Real.log T/Real.log 2+1 := Nat.ceil_lt_add_one
    (div_nonneg (Real.log_nonneg (by linarith)) h2.le)
  have hp : T ≤ (2 : ℝ)^J := by
    apply (Real.log_le_log_iff (by linarith : 0 < T) (by positivity)).mp
    simpa only [Real.log_pow] using (div_le_iff₀ h2).mp hl
  have hq : (2 : ℝ)^J ≤ 2*T := by
    apply (Real.log_le_log_iff (by positivity) (by positivity : 0 < 2*T)).mp
    rw [Real.log_pow, Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) (by linarith : T ≠ 0)]
    have hh := (lt_div_iff₀ h2).mp (show (J : ℝ)-1 < Real.log T/Real.log 2 by linarith)
    nlinarith
  refine ⟨J,hp,hq,?_⟩
  have hh : 1 ≤ Real.log T/Real.log 2 := (le_div_iff₀ h2).mpr (by simpa using hlog)
  have he : (2/Real.log 2)*Real.log T = 2*(Real.log T/Real.log 2) := by ring
  rw [he]
  linarith

theorem height_shell_mem (J : ℕ) (x : ℝ) (hx : 64 < x) (hu : x ≤ 64*(2 : ℝ)^J) :
    ∃ j ∈ Finset.range J, 64*(2 : ℝ)^j < x ∧ x ≤ 128*(2 : ℝ)^j := by
  induction J with
  | zero => norm_num at hu; linarith
  | succ J ih =>
    by_cases h : x ≤ 64*(2 : ℝ)^J
    · obtain ⟨j,hj,hlo,hhi⟩ := ih h
      exact ⟨j,Finset.mem_range.mpr (Nat.lt_succ_of_lt (Finset.mem_range.mp hj)),hlo,hhi⟩
    · refine ⟨J,Finset.mem_range.mpr (Nat.lt_succ_self J),lt_of_not_ge h,?_⟩
      rw [pow_succ] at hu
      nlinarith

theorem height_shell_card_le {ι : Type*} (S : Finset ι) (t : ι → ℝ) (J : ℕ)
    (hlo : ∀ i ∈ S, 64 < |t i|) (hhi : ∀ i ∈ S, |t i| ≤ 64*(2 : ℝ)^J) :
    (S.card : ℝ) ≤ ∑ j ∈ Finset.range J,
      ((S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)).card : ℝ) := by
  classical
  have hsub : S ⊆ (Finset.range J).biUnion (fun j =>
      S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)) := by
    intro i hi
    obtain ⟨j,hj,hjl,hju⟩ := height_shell_mem J _ (hlo i hi) (hhi i hi)
    exact Finset.mem_biUnion.mpr ⟨j,hj,Finset.mem_filter.mpr ⟨hi,hjl,hju⟩⟩
  exact_mod_cast (Finset.card_le_card hsub).trans Finset.card_biUnion_le

theorem height_shell_power_log (H T σ : ℝ) (hH : 128 ≤ H) (hT : 2 ≤ T)
    (hHT : H ≤ 128*T) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    H^balancedDensityExponent σ*(Real.log H)^8 ≤
      (128*8^8)*T^balancedDensityExponent σ*(Real.log T)^8 := by
  have hb := balancedDensityExponent_nonneg σ hσ1
  have hb1 := balancedDensityExponent_le_one σ hσ hσ1
  have hp : H^balancedDensityExponent σ ≤ 128*T^balancedDensityExponent σ := by
    calc
      _ ≤ (128*T)^balancedDensityExponent σ := Real.rpow_le_rpow (by linarith) hHT hb
      _ = (128 : ℝ)^balancedDensityExponent σ*T^balancedDensityExponent σ :=
        Real.mul_rpow (by norm_num) (by linarith)
      _ ≤ (128 : ℝ)^(1 : ℝ)*T^balancedDensityExponent σ := by
        exact mul_le_mul_of_nonneg_right
          (Real.rpow_le_rpow_of_exponent_le (by norm_num) hb1) (by positivity)
      _ = _ := by rw [Real.rpow_one]
  have hl : Real.log H ≤ 8*Real.log T := by
    have hh := Real.log_le_log (by linarith : 0 < H) hHT
    rw [Real.log_mul (by norm_num : (128 : ℝ) ≠ 0) (by linarith : T ≠ 0)] at hh
    have he : Real.log 128 = 7*Real.log 2 := by
      simpa only [show (2 : ℝ)^7 = 128 by norm_num,Nat.cast_ofNat] using Real.log_pow (2 : ℝ) 7
    rw [he] at hh
    have ht := Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT
    linarith
  have hlp := pow_le_pow_left₀ (Real.log_nonneg (by linarith : 1 ≤ H)) hl 8
  have hh := mul_le_mul hp hlp (by positivity) (by positivity : 0 ≤ 128*T^balancedDensityExponent σ)
  convert hh using 1 <;> ring

theorem separated_high_density :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^9 := by
  classical
  obtain ⟨C,hC,hc⟩ := separated_high_shell_density_uniform
  refine ⟨C*(128*8^8)*(2/Real.log 2),by positivity,?_⟩
  intro T σ hT hσ hσ1 ι S t β ht hs hz
  obtain ⟨J,hJl,hJu,hJlog⟩ := real_height_dyadic_cover T (by linarith)
  have hcard := height_shell_card_le S t J (fun i hi => (ht i hi).1)
    (by intro i hi; exact (ht i hi).2.trans (by nlinarith))
  have hsum : ∀ j ∈ Finset.range J,
      ((S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)).card : ℝ) ≤
        C*(128*8^8)*T^balancedDensityExponent σ*(Real.log T)^8 := by
    intro j hj
    let F := S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)
    have hpow : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
    have hupper : 128*(2 : ℝ)^j ≤ 128*T := by
      have hp : (2 : ℝ)^(j+1) ≤ 2^J := pow_le_pow_right₀ (by norm_num) (Finset.mem_range.mp hj)
      rw [pow_succ] at hp
      nlinarith
    have hf := hc (128*(2 : ℝ)^j) σ (by nlinarith) hσ hσ1 F t β
      (by intro i hi; have hh := (Finset.mem_filter.mp hi).2; constructor <;> linarith [hh.1,hh.2])
      (fun i hi j hj hij => hs i (Finset.mem_filter.mp hi).1 j (Finset.mem_filter.mp hj).1 hij)
      (fun i hi => hz i (Finset.mem_filter.mp hi).1)
    have hp := mul_le_mul_of_nonneg_left
      (height_shell_power_log (128*(2 : ℝ)^j) T σ (by nlinarith) (by linarith) hupper hσ hσ1) hC.le
    exact hf.trans (by convert hp using 1 <;> ring)
  apply (hcard.trans (Finset.sum_le_sum hsum)).trans
  rw [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
  have hh := mul_le_mul_of_nonneg_right hJlog
    (show 0 ≤ C*(128*8^8)*T^balancedDensityExponent σ*(Real.log T)^8 by positivity)
  convert hh using 1 <;> ring

end Legendre.Density.Moment
