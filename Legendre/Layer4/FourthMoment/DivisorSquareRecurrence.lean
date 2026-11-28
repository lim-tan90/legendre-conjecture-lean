/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.DivisorSquareEuler

@[expose] public section
namespace Legendre.Density.Moment

/-- The reciprocal-weighted divisor-square sum up to a real cutoff. -/
noncomputable def harmonicDivisorSquare (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (n.divisors.card : ℝ)^2/(n : ℝ)

/-- The four-factor harmonic sum is the convolution of harmonic divisor
square sums at square-scaled cutoffs. -/
theorem harmonicFactorTuples_four_eq_square_sum {x : ℝ} (hx : 1 ≤ x) :
    harmonicFactorTuples 4 x =
      ∑ d ∈ Finset.Icc 1 ⌊√x⌋₊, harmonicDivisorSquare (x/(d : ℝ)^2)/(d : ℝ)^2 := by
  rw [harmonicFactorTuples_eq_zeta_pow 4 hx,
    zeta_pow_four_eq_divisorCountSquare_mul_positiveSquareIndicator,sum_harmonic_convolution]
  let S := Finset.Icc 1 ⌊x⌋₊
  let R := Finset.Icc 1 ⌊√x⌋₊
  let w := fun a : ℕ => harmonicDivisorSquare (x/a)/(a : ℝ)
  have he : (∑ a ∈ S, (positiveSquareIndicator a/(a : ℝ))*
      ∑ b ∈ Finset.Icc 1 (⌊x⌋₊/a), divisorCountSquare b/(b : ℝ)) =
      ∑ a ∈ S.filter IsSquare, w a := by
    rw [Finset.sum_filter]
    apply Finset.sum_congr rfl
    intro a ha
    have ha₀ : a ≠ 0 := Nat.ne_of_gt (Finset.mem_Icc.mp ha).1
    by_cases hs : IsSquare a
    · dsimp only [w]
      rw [harmonicDivisorSquare,Nat.floor_div_natCast]
      simp [positiveSquareIndicator_apply,ha₀,hs,divisorCountSquare_apply,div_eq_mul_inv,mul_comm]
    · simp [positiveSquareIndicator_apply,hs]
  rw [he]
  symm
  apply Finset.sum_bij (fun d _ => d^2)
  · intro d hd
    obtain ⟨hd₁,hdx⟩ := Finset.mem_Icc.mp hd
    have hdR : (d : ℝ) ≤ √x := ((by exact_mod_cast hdx : (d : ℝ) ≤ ⌊√x⌋₊)).trans
      (Nat.floor_le (Real.sqrt_nonneg _))
    have hsq : (d : ℝ)^2 ≤ x := (pow_le_pow_left₀ (Nat.cast_nonneg d) hdR 2).trans_eq
      (Real.sq_sqrt (zero_le_one.trans hx))
    exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr ⟨Nat.one_le_pow _ _ hd₁,
      (Nat.le_floor_iff (zero_le_one.trans hx)).2 (by exact_mod_cast hsq)⟩, ⟨d,pow_two _⟩⟩
  · intro a ha b hb he
    exact Nat.pow_left_injective (n := 2) (by decide) he
  · intro a ha
    obtain ⟨ha,⟨d,hd⟩⟩ := Finset.mem_filter.mp ha
    have he : a = d^2 := hd.trans (pow_two d).symm
    have hd₁ : 1 ≤ d := by
      by_contra! hh
      have hz : d = 0 := by omega
      have hn := (Finset.mem_Icc.mp ha).1
      simp [he,hz] at hn
    have hsq : (d : ℝ)^2 ≤ x := by
      have h := (Nat.le_floor_iff (zero_le_one.trans hx)).1 (Finset.mem_Icc.mp ha).2
      simpa only [he,Nat.cast_pow] using h
    have hdR : (d : ℝ) ≤ √x := (Real.le_sqrt (Nat.cast_nonneg _) (zero_le_one.trans hx)).2 hsq
    exact ⟨d,Finset.mem_Icc.mpr ⟨hd₁,(Nat.le_floor_iff (Real.sqrt_nonneg _)).2 hdR⟩,he.symm⟩
  · intro d hd
    simp only [w,Nat.cast_pow]

end Legendre.Density.Moment
