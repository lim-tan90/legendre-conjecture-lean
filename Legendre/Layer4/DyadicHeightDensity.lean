/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions from the proved compact-detector shell estimate. The real
height cover retains its upper endpoint, so combining shells does not lose a
power of T. No zero-density estimate is assumed.
-/
module
public import Legendre.Layer4.NearCriticalDensity
public import Legendre.Layer4.DyadicHeightShells

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

universe u

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

theorem height_shell_log_le (H T : ℝ) (hH : 128 ≤ H) (hT : 2 ≤ T)
    (hHT : H ≤ 128*T) : Real.log H ≤ 8*Real.log T := by
  have hh := Real.log_le_log (by linarith : 0 < H) hHT
  rw [Real.log_mul (by norm_num : (128 : ℝ) ≠ 0) (by linarith : T ≠ 0)] at hh
  have he : Real.log 128 = 7*Real.log 2 := by
    simpa only [show (2 : ℝ)^7 = 128 by norm_num,Nat.cast_ofNat] using Real.log_pow (2 : ℝ) 7
  rw [he] at hh
  have ht := Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT
  linarith

theorem height_shell_upper (J j : ℕ) (T : ℝ) (hj : j ∈ Finset.range J)
    (hJ : (2 : ℝ)^J ≤ 2*T) : 128*(2 : ℝ)^j ≤ 128*T := by
  have hp : (2 : ℝ)^(j+1) ≤ 2^J :=
    pow_le_pow_right₀ (by norm_num) (Finset.mem_range.mp hj)
  rw [pow_succ] at hp
  nlinarith

theorem height_shell_power_log_nat (k : ℕ) (H T σ : ℝ) (hH : 128 ≤ H) (hT : 2 ≤ T)
    (hHT : H ≤ 128*T) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    H^balancedDensityExponent σ*(Real.log H)^k ≤
      (128*8^k)*T^balancedDensityExponent σ*(Real.log T)^k := by
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
  have hl := height_shell_log_le H T hH hT hHT
  have hlp := pow_le_pow_left₀ (Real.log_nonneg (by linarith : 1 ≤ H)) hl k
  have hh := mul_le_mul hp hlp (pow_nonneg (Real.log_nonneg (by linarith)) k) (by positivity : 0 ≤ 128*T^balancedDensityExponent σ)
  rw [mul_pow] at hh
  convert hh using 1
  ring

theorem height_shell_power_log (H T σ : ℝ) (hH : 128 ≤ H) (hT : 2 ≤ T)
    (hHT : H ≤ 128*T) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    H^balancedDensityExponent σ*(Real.log H)^8 ≤
      (128*8^8)*T^balancedDensityExponent σ*(Real.log T)^8 :=
  height_shell_power_log_nat 8 H T σ hH hT hHT hσ hσ1

theorem separated_high_density_shell_sum_of_count (σ : ℝ) (G : ℝ → ℝ)
    (hc : ∀ T : ℝ, 128 ≤ T →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ G T)
    {ι : Type u} (S : Finset ι) (t β : ι → ℝ) (T : ℝ) (J : ℕ)
    (hJl : T ≤ (2 : ℝ)^J)
    (ht : ∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hz : ∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) :
    (S.card : ℝ) ≤ ∑ j ∈ Finset.range J, G (128*(2 : ℝ)^j) := by
  classical
  have hcard := height_shell_card_le S t J (fun i hi => (ht i hi).1)
    (fun i hi => (ht i hi).2.trans (hJl.trans
      (le_mul_of_one_le_left (by positivity) (by norm_num))))
  apply hcard.trans
  apply Finset.sum_le_sum
  intro j hj
  let F := S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)
  let H := 128*(2 : ℝ)^j
  have hpow : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
  have hH : 128 ≤ H := by dsimp [H]; linarith
  exact hc H hH F t β
    (by
      intro i hi
      have hh := (Finset.mem_filter.mp hi).2
      exact ⟨by dsimp [H]; linarith [hh.1], hh.2⟩)
    (fun i hi j hj hij => hs i (Finset.mem_filter.mp hi).1 j (Finset.mem_filter.mp hj).1 hij)
    (fun i hi => hz i (Finset.mem_filter.mp hi).1)

/-- Sum a uniform shell count, keeping each height power before bounding
the resulting sum. -/
theorem separated_high_density_shell_sum (k : ℕ) (C : ℝ) (hC : 0 ≤ C)
    (hc : ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^k)
    {ι : Type u} (S : Finset ι) (t β : ι → ℝ) (T σ : ℝ) (J : ℕ)
    (hT : 2 ≤ T) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) (hJl : T ≤ (2 : ℝ)^J)
    (hJu : (2 : ℝ)^J ≤ 2*T)
    (ht : ∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hz : ∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) :
    (S.card : ℝ) ≤ C*(8*Real.log T)^k *
      ∑ j ∈ Finset.range J, (128*(2 : ℝ)^j)^balancedDensityExponent σ := by
  have hcard := separated_high_density_shell_sum_of_count σ
    (fun H => C*H^balancedDensityExponent σ*(Real.log H)^k)
    (fun H hH {ι} S t β ht hs hz => hc H σ hH hσ hσ1 S t β ht hs hz)
    S t β T J hJl ht hs hz
  rw [Finset.mul_sum]
  apply hcard.trans
  apply Finset.sum_le_sum
  intro j hj
  let H := 128*(2 : ℝ)^j
  have hpow : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
  have hH : 128 ≤ H := by dsimp [H]; linarith
  have hl := height_shell_log_le H T hH hT (height_shell_upper J j T hj hJu)
  calc
    _ ≤ C*H^balancedDensityExponent σ*(8*Real.log T)^k :=
      mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (Real.log_nonneg (by linarith)) hl k)
        (by positivity)
    _ = _ := by dsimp [H]; ring

theorem separated_high_density_of_shell (k : ℕ)
    (hshell : ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^k) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^(k+1) := by
  obtain ⟨C,hC,hc⟩ := hshell
  refine ⟨C*(128*8^k)*(2/Real.log 2),by positivity,?_⟩
  intro T σ hT hσ hσ1 ι S t β ht hs hz
  have hT₀ : 2 ≤ T := by linarith
  have hL : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  obtain ⟨J,hJl,hJu,hJlog⟩ := real_height_dyadic_cover T hT₀
  have hcard := separated_high_density_shell_sum k C hC.le hc S t β T σ J
    hT₀ hσ hσ1 hJl hJu ht hs hz
  have hsum : (∑ j ∈ Finset.range J, (128*(2 : ℝ)^j)^balancedDensityExponent σ) ≤
      (J : ℝ)*(128*T^balancedDensityExponent σ) := by
    apply (Finset.sum_le_sum (g := fun _ => 128*T^balancedDensityExponent σ) ?_).trans
    · rw [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
    · intro j hj
      have hp : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
      simpa only [pow_zero,mul_one] using
        height_shell_power_log_nat 0 (128*(2 : ℝ)^j) T σ (by linarith) hT₀
          (height_shell_upper J j T hj hJu) hσ hσ1
  calc
    _ ≤ C*(8*Real.log T)^k*((J : ℝ)*(128*T^balancedDensityExponent σ)) :=
      hcard.trans (mul_le_mul_of_nonneg_left hsum (by positivity))
    _ ≤ C*(8*Real.log T)^k*((2/Real.log 2)*Real.log T*(128*T^balancedDensityExponent σ)) :=
      mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_right hJlog (by positivity)) (by positivity)
    _ = _ := by rw [mul_pow,pow_succ]; ring

theorem separated_high_density :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^9 :=
  separated_high_density_of_shell 8 separated_high_shell_density_uniform

theorem separated_high_density_log_six :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^6 :=
  separated_high_density_of_shell 5 separated_high_shell_density_uniform_log_five

end Legendre.Density.Moment
