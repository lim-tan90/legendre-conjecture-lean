/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.InghamSharpLogarithms
public import Legendre.Layer4.HuxleyDensity

@[expose] public section
namespace Legendre.Density.Moment

/-- A uniform slope gap between the two curves in the upper tenth of the strip. -/
theorem three_fifths_defect_le_balanced_sub_huxley_book {σ : ℝ}
    (hσ : 9/10 ≤ σ) (hσ₁ : σ ≤ 1) :
    (3/5)*(1-σ) ≤ balancedDensityExponent σ-huxleyBookExponent σ := by
  have hδ : 0 ≤ 1-σ := by linarith
  have hd : 0 < σ^2+σ-1 := by nlinarith [sq_nonneg (σ-9/10)]
  have hb : (30/11 : ℝ) ≤ 3/(2-σ) := by
    apply (le_div_iff₀ (by linarith : 0 < 2-σ)).2
    linarith
  have hh : (5*σ-3)/(σ^2+σ-1) ≤ (17/8 : ℝ) := by
    apply (div_le_iff₀ hd).2
    nlinarith [sq_nonneg (σ-9/10)]
  have hdif : (3/5 : ℝ) ≤ 3/(2-σ)-(5*σ-3)/(σ^2+σ-1) := by
    linarith
  have h := mul_le_mul_of_nonneg_right hdif hδ
  unfold balancedDensityExponent huxleyBookExponent
  convert h using 1; ring

end Legendre.Density.Moment

namespace Legendre.Zeta
open Set Density.Moment

/-- The uniform fifth-log Ingham bound reaches a shrinking strip near one.
The existing zero-free region also supplies a compact bound at the top edge. -/
theorem ingham_density_log_five_shrinking_strip :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (1/2 : ℝ) 1, ∀ T : ℝ, 2 ≤ T →
      (σ ≤ 9/10 ∨ 55*Real.log (1+Real.log T) ≤ (1-σ)*Real.log T ∨
        (1-σ)*Real.log T ≤ 1/4000000) →
      (zeroDensityCount σ T : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^5 := by
  obtain ⟨A,hA,hfixed⟩ := ingham_density_log_five_away_one (9/10) (by norm_num)
  obtain ⟨B,hB,hcurved⟩ := huxley_book_density_log_bound
  let D := (1+(Real.log 2)⁻¹)^5
  let K := ((zeroCount 3 : ℝ)+1)*(Real.log 2)⁻¹^5
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hD : 0 < D := by dsimp [D]; positivity
  have hK : 0 < K := by dsimp [K]; positivity
  refine ⟨A+B*D+K, by positivity, ?_⟩
  intro σ hσ T hT hcase
  let E := balancedDensityExponent σ
  let H := huxleyBookExponent σ
  let L := Real.log T
  have hT₀ : 0 < T := by linarith
  have hL : 0 < L := Real.log_pos (by linarith)
  have hLE : 0 ≤ T^E*L^5 := by positivity
  change _ ≤ (A+B*D+K)*T^E*L^5
  by_cases hupper : σ ≤ 9/10
  · exact (hfixed σ ⟨hσ.1,hupper⟩ T hT).trans
      (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right (by linarith [mul_pos hB hD])
        (by positivity)) (by positivity))
  have hσ₀ : 9/10 ≤ σ := (lt_of_not_ge hupper).le
  have hnorm : (1+L)^5 ≤ D*L^5 := by
    have hL₂ : Real.log 2 ≤ L := Real.log_le_log (by norm_num) hT
    have hinv := mul_le_mul_of_nonneg_left hL₂ (inv_nonneg.mpr hlog2.le)
    rw [inv_mul_cancel₀ hlog2.ne'] at hinv
    have h := pow_le_pow_left₀ (show 0 ≤ 1+L by positivity)
      (show 1+L ≤ (1+(Real.log 2)⁻¹)*L by nlinarith) 5
    simpa only [D, mul_pow] using h
  rcases hcase.resolve_left hupper with hwide | hfree
  · have hcoef := three_fifths_defect_le_balanced_sub_huxley_book hσ₀ hσ.2
    have habs : (1+L)^33 ≤ T^(E-H) := by
      rw [← Real.rpow_natCast, Real.rpow_def_of_pos (by positivity : 0 < 1+L),
        Real.rpow_def_of_pos hT₀, Real.exp_le_exp, Nat.cast_ofNat]
      have hb := mul_le_mul_of_nonneg_right hcoef hL.le
      change _ ≤ L*(E-H)
      change 55*Real.log (1+L) ≤ (1-σ)*L at hwide
      nlinarith
    have hc := hcurved σ ⟨by linarith, hσ.2⟩ T hT
    change _ ≤ B*T^H*(1+L)^38 at hc
    have hfac : T^H*T^(E-H) = T^E := by
      rw [← Real.rpow_add hT₀]
      congr 1
      ring
    calc
      _ ≤ B*T^H*((1+L)^33*(1+L)^5) := by rw [← pow_add]; exact hc
      _ ≤ B*T^H*(T^(E-H)*(D*L^5)) :=
        mul_le_mul_of_nonneg_left (mul_le_mul habs hnorm (by positivity) (by positivity)) (by positivity)
      _ = B*D*T^E*L^5 := by rw [← hfac]; ring
      _ ≤ _ := by gcongr; linarith
  · have hsmall : zeroDensityCount σ T ≤ zeroCount 3 := by
      by_cases hlarge : 3 ≤ T
      · refine (zeroDensityCount_antitone T ?_).trans (zeroDensityCount_rational_near_one hlarge)
        rw [sub_le_comm]
        apply (le_div_iff₀ (by positivity : 0 < 4000000*L)).2
        change (1-σ)*L ≤ 1/4000000 at hfree
        nlinarith
      · exact (zeroDensityCount_le σ T).trans (zeroCount_mono (le_of_not_ge hlarge))
    have hunit := height_log_unit 5 T σ hT hσ.2
    have hZ : (zeroCount 3 : ℝ) ≤ K*(T^E*L^5) := by
      have h := mul_le_mul_of_nonneg_left hunit (show 0 ≤ (zeroCount 3 : ℝ)+1 by positivity)
      dsimp only [K,E,L]
      nlinarith
    calc
      _ ≤ (zeroCount 3 : ℝ) := by exact_mod_cast hsmall
      _ ≤ K*(T^E*L^5) := hZ
      _ ≤ (A+B*D+K)*(T^E*L^5) := mul_le_mul_of_nonneg_right (by linarith [mul_pos hB hD]) hLE
      _ = _ := by ring

end Legendre.Zeta
