/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.DivisorSquareRecurrence
public import Legendre.ZeroDensity
public import Mathlib.NumberTheory.ZetaValues

@[expose] public section
namespace Legendre.Density.Moment

private theorem summable_log_div_sq : Summable (fun d : ℕ => Real.log d/(d : ℝ)^2) := by
  obtain ⟨C,hC,hb⟩ := Legendre.Zeta.exists_log_pow_le_rpow 1 (show (0 : ℝ) < 1/2 by norm_num)
  have hs := (Real.summable_nat_rpow (p := -(3/2 : ℝ))).2 (by norm_num)
  refine Summable.of_nonneg_of_le ?_ ?_ (hs.mul_left C)
  · intro d
    rcases d with _|d
    · simp
    exact div_nonneg (Real.log_nonneg (by exact_mod_cast Nat.succ_pos d)) (sq_nonneg _)
  · intro d
    by_cases hd : 2 ≤ d
    · have hp : (0 : ℝ) < d := by exact_mod_cast (show 0 < d by omega)
      have h := hb (d : ℝ) (by exact_mod_cast hd)
      rw [pow_one] at h
      calc
        _ ≤ (C*(d : ℝ)^(1/2 : ℝ))/(d : ℝ)^2 := div_le_div_of_nonneg_right h (sq_nonneg _)
        _ = _ := by
          rw [mul_div_assoc,← Real.rpow_two,← Real.rpow_sub hp]
          norm_num
    · have he : d = 0 ∨ d = 1 := by omega
      rcases he with rfl|rfl <;> simp [hC.le]

/-- The square scales contribute the Basel factor to the leading logarithm,
with a uniform error bounded by a cubic logarithm. -/
theorem abs_square_scaled_log_four_sub_basel_le :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : ℝ, 1 ≤ x →
      |(∑ d ∈ Finset.Icc 1 ⌊√x⌋₊, (Real.log (x/(d : ℝ)^2))^4/(d : ℝ)^2)-
        (Real.pi^2/6)*(Real.log x)^4| ≤ C*(1+Real.log x)^3 := by
  let q := fun d : ℕ => Real.log d/(d : ℝ)^2
  have hq : ∀ d : ℕ, 0 ≤ q d := by
    intro d
    rcases d with _|d
    · simp [q]
    exact div_nonneg (Real.log_nonneg (by exact_mod_cast Nat.succ_pos d)) (sq_nonneg _)
  let C := 8*(∑' d : ℕ, q d)
  have hC : 0 ≤ C := mul_nonneg (by norm_num) (tsum_nonneg hq)
  refine ⟨C,hC,?_⟩
  intro x hx
  have hx₀ : 0 < x := zero_lt_one.trans_le hx
  let R := Finset.Icc 1 ⌊√x⌋₊
  let L := Real.log x
  let u := fun d : ℕ => L^4/(d : ℝ)^2
  let v := fun d : ℕ => if d ∈ R then (Real.log (x/(d : ℝ)^2))^4/(d : ℝ)^2 else 0
  have hL : 0 ≤ L := Real.log_nonneg hx
  have hu : HasSum u ((Real.pi^2/6)*L^4) := by
    convert hasSum_zeta_two.mul_left (L^4) using 1
    · funext d
      dsimp [u]
      ring
    · ring
  have hv : HasSum v (∑ d ∈ R, (Real.log (x/(d : ℝ)^2))^4/(d : ℝ)^2) := by
    have hvS : HasSum v (∑ d ∈ R, v d) := hasSum_sum_of_ne_finset_zero (fun d hd => by simp [v,hd])
    have he : (∑ d ∈ R, v d) = ∑ d ∈ R, (Real.log (x/(d : ℝ)^2))^4/(d : ℝ)^2 :=
      Finset.sum_congr rfl (fun d hd => by simp [v,hd])
    rwa [he] at hvS
  have hdiff : ∀ d : ℕ, 0 ≤ u d-v d ∧ u d-v d ≤ (8*(1+L)^3)*q d := by
    intro d
    by_cases hz : d = 0
    · subst d
      simp [u,v,R,q]
    have hd₁ : (1 : ℝ) ≤ d := by exact_mod_cast (show 1 ≤ d by omega)
    have hd₀ : (0 : ℝ) < d := zero_lt_one.trans_le hd₁
    have hdlog : 0 ≤ Real.log d := Real.log_nonneg hd₁
    have hd₂ : 0 < (d : ℝ)^2 := sq_pos_of_pos hd₀
    by_cases hd : d ∈ R
    · have hdn : (d : ℝ) ≤ √x := ((by exact_mod_cast (Finset.mem_Icc.mp hd).2 :
          (d : ℝ) ≤ ⌊√x⌋₊)).trans (Nat.floor_le (Real.sqrt_nonneg _))
      have hdsq : (d : ℝ)^2 ≤ x := (pow_le_pow_left₀ hd₀.le hdn 2).trans_eq (Real.sq_sqrt hx₀.le)
      have hlogEq : Real.log (x/(d : ℝ)^2) = L-2*Real.log d := by
        rw [Real.log_div hx₀.ne' hd₂.ne',Real.log_pow]
        rfl
      have hl : 0 ≤ Real.log (x/(d : ℝ)^2) :=
        Real.log_nonneg ((one_le_div hd₂).2 hdsq)
      have hle : Real.log (x/(d : ℝ)^2) ≤ L := by rw [hlogEq]; linarith only [hdlog]
      have hpow (k : ℕ) : (Real.log (x/(d : ℝ)^2))^k ≤ L^k :=
        pow_le_pow_left₀ hl hle k
      simp only [u,v,hd,ite_true,← sub_div]
      refine ⟨div_nonneg (sub_nonneg.mpr (hpow 4)) hd₂.le,?_⟩
      have hpoly : L^4-(Real.log (x/(d : ℝ)^2))^4 ≤
          8*(1+L)^3*Real.log d := by
        let l := Real.log (x/(d : ℝ)^2)
        have hterm : L^3+L^2*l+L*l^2+l^3 ≤ 4*L^3 := by
          have h1 := mul_le_mul_of_nonneg_left hle (sq_nonneg L)
          have h2 := mul_le_mul_of_nonneg_left (hpow 2) hL
          have h3 := hpow 3
          change L^2*l ≤ L^2*L at h1
          change L*l^2 ≤ L*L^2 at h2
          change l^3 ≤ L^3 at h3
          nlinarith only [h1,h2,h3]
        have hh := mul_le_mul_of_nonneg_right hterm (sub_nonneg.mpr hle)
        change _ ≤ _ at hh
        calc
          _ = (L^3+L^2*l+L*l^2+l^3)*(L-l) := by change L^4-l^4 = _; ring
          _ ≤ 4*L^3*(L-l) := hh
          _ = 8*L^3*Real.log d := by dsimp only [l]; rw [hlogEq]; ring
          _ ≤ _ := by
            have hp := pow_le_pow_left₀ hL (show L ≤ 1+L by linarith) 3
            gcongr
      rw [show (8*(1+L)^3)*q d = (8*(1+L)^3*Real.log d)/(d : ℝ)^2 by
        dsimp only [q]
        rw [mul_div_assoc]]
      exact div_le_div_of_nonneg_right hpoly hd₂.le
    · have hdN : ⌊√x⌋₊ < d := by
        have hh : 1 ≤ d := by omega
        simp only [R,Finset.mem_Icc,hh,true_and,not_le] at hd
        exact hd
      have hroot : √x < (d : ℝ) := (Nat.floor_lt (Real.sqrt_nonneg _)).1 hdN
      have hp : x ≤ (d : ℝ)^2 := by
        rw [← Real.sq_sqrt hx₀.le]
        exact pow_le_pow_left₀ (Real.sqrt_nonneg _) hroot.le 2
      have hlog : L ≤ 2*Real.log d := by
        have hh := Real.log_le_log hx₀ hp
        rw [Real.log_pow] at hh
        exact hh
      simp only [u,v,hd,ite_false,sub_zero]
      refine ⟨div_nonneg (pow_nonneg hL _) hd₂.le,?_⟩
      rw [show (8*(1+L)^3)*q d = (8*(1+L)^3*Real.log d)/(d : ℝ)^2 by
        dsimp only [q]
        rw [mul_div_assoc]]
      apply div_le_div_of_nonneg_right _ hd₂.le
      calc
        L^4 = L^3*L := by ring
        _ ≤ L^3*(2*Real.log d) := mul_le_mul_of_nonneg_left hlog (pow_nonneg hL _)
        _ ≤ _ := by
          have hp := pow_le_pow_left₀ hL (show L ≤ 1+L by linarith) 3
          calc
            _ ≤ (1+L)^3*(2*Real.log d) := mul_le_mul_of_nonneg_right hp (by positivity)
            _ ≤ (8*(1+L)^3)*Real.log d := by
              nlinarith only [mul_nonneg (pow_nonneg (show 0 ≤ 1+L by linarith) 3) hdlog]
  have he := hu.sub hv
  have hdom := summable_log_div_sq.mul_left (8*(1+L)^3)
  have hb := he.summable.tsum_le_tsum (fun d => (hdiff d).2) hdom
  have hn : 0 ≤ ∑' d : ℕ, (u d-v d) := tsum_nonneg fun d => (hdiff d).1
  rw [he.tsum_eq,tsum_mul_left] at hb
  rw [he.tsum_eq] at hn
  change |(∑ d ∈ R, _)-_| ≤ C*(1+L)^3
  rw [abs_sub_comm,abs_of_nonneg hn]
  exact hb.trans_eq (by dsimp only [C]; ring)

end Legendre.Density.Moment
