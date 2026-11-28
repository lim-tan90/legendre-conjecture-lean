/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.HarmonicConvolution
public import Mathlib.NumberTheory.ArithmeticFunction.Misc

@[expose] public section
namespace Legendre.Density.Moment
open ArithmeticFunction
open scoped ArithmeticFunction.zeta ArithmeticFunction.sigma
open scoped Classical

/-- The real-valued indicator of positive squares as an arithmetic function. -/
noncomputable def positiveSquareIndicator : ArithmeticFunction ℝ :=
  ⟨fun n => if n ≠ 0 ∧ IsSquare n then 1 else 0, by simp⟩

theorem positiveSquareIndicator_apply (n : ℕ) :
    positiveSquareIndicator n = if n ≠ 0 ∧ IsSquare n then 1 else 0 := rfl

private theorem isSquare_mul_iff_of_coprime {m n : ℕ} (hcop : m.Coprime n) :
    IsSquare (m*n) ↔ IsSquare m ∧ IsSquare n := by
  simp only [Nat.isSquare_iff_even_factorization,Nat.factorization_mul_apply_of_coprime hcop]
  have hdisjoint (p : ℕ) (hp : p.Prime) : m.factorization p = 0 ∨ n.factorization p = 0 := by
    by_contra! h
    have hm : p ∣ m := Nat.dvd_of_factorization_pos h.1
    have hn : p ∣ n := Nat.dvd_of_factorization_pos h.2
    have hd := Nat.dvd_gcd hm hn
    rw [hcop.gcd_eq_one] at hd
    exact hp.not_dvd_one hd
  constructor
  · intro h
    constructor
    · intro p hp
      rcases hdisjoint p hp with hm|hn
      · rw [hm]
        decide
      · simpa [hn] using h p hp
    · intro p hp
      rcases hdisjoint p hp with hm|hn
      · simpa [hm] using h p hp
      · rw [hn]
        decide
  · rintro ⟨hm,hn⟩ p hp
    exact (hm p hp).add (hn p hp)

theorem isMultiplicative_positiveSquareIndicator :
    positiveSquareIndicator.IsMultiplicative := by
  apply ArithmeticFunction.IsMultiplicative.iff_ne_zero.2
  have h1 : IsSquare (1 : ℕ) := ⟨1,rfl⟩
  refine ⟨by simp [positiveSquareIndicator_apply,h1],?_⟩
  intro m n hm hn hcop
  by_cases h₁ : IsSquare m <;> by_cases h₂ : IsSquare n <;>
    simp [positiveSquareIndicator_apply,isSquare_mul_iff_of_coprime hcop,hm,hn,h₁,h₂]

private theorem positiveSquareIndicator_prime_pow {p : ℕ} (hp : p.Prime) (i : ℕ) :
    positiveSquareIndicator (p^i) = if Even i then 1 else 0 := by
  have h : IsSquare (p^i) ↔ Even i := by
    rw [Nat.isSquare_iff_even_factorization,hp.factorization_pow]
    constructor
    · intro h
      simpa using h p hp
    · intro h q hq
      rcases eq_or_ne p q with rfl|he
      · simpa using h
      · rw [Finsupp.single_eq_of_ne (Ne.symm he)]
        exact ⟨0,rfl⟩
  simp [positiveSquareIndicator_apply,hp.ne_zero,h]

/-- The arithmetic function whose values are the squares of divisor counts. -/
noncomputable def divisorCountSquare : ArithmeticFunction ℝ :=
  let d : ArithmeticFunction ℝ := (σ 0 : ArithmeticFunction ℕ)
  d.pmul d

theorem divisorCountSquare_apply (n : ℕ) :
    divisorCountSquare n = (n.divisors.card : ℝ)^2 := by
  simp [divisorCountSquare,ArithmeticFunction.pmul_apply,ArithmeticFunction.natCoe_apply,
    sigma_zero_apply,pow_two]

private theorem zeta_pow_two_apply (n : ℕ) :
    ((ζ : ArithmeticFunction ℝ)^2) n = (n.divisors.card : ℝ) := by
  rw [pow_two,coe_mul_zeta_apply]
  simp only [ArithmeticFunction.natCoe_apply]
  calc
    _ = ∑ d ∈ n.divisors, (1 : ℝ) := by
      apply Finset.sum_congr rfl
      intro d hd
      simp [zeta_apply_ne (Nat.pos_of_mem_divisors hd).ne']
    _ = _ := by simp

private theorem sum_range_cast_add_one (k : ℕ) :
    (∑ i ∈ Finset.range k, ((i : ℝ)+1)) = (k : ℝ)*((k : ℝ)+1)/2 := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ,ih,Nat.cast_succ]
    ring

private theorem sum_range_consecutive_product (k : ℕ) :
    (∑ i ∈ Finset.range k, ((i : ℝ)+1)*((k : ℝ)-(i : ℝ))) =
      (k : ℝ)*((k : ℝ)+1)*((k : ℝ)+2)/6 := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ,Nat.cast_succ]
    have h (i : ℕ) : ((i : ℝ)+1)*((k : ℝ)+1-(i : ℝ)) =
        ((i : ℝ)+1)*((k : ℝ)-(i : ℝ))+((i : ℝ)+1) := by ring
    simp_rw [h]
    rw [Finset.sum_add_distrib,ih,sum_range_cast_add_one]
    ring

private theorem sum_range_even_squares (k : ℕ) :
    (∑ i ∈ Finset.range (k+1), if Even i then ((k : ℝ)+1-(i : ℝ))^2 else 0) =
      ((k : ℝ)+1)*((k : ℝ)+2)*((k : ℝ)+3)/6 := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    rcases k with _|k
    · norm_num
    rcases k with _|k
    · norm_num [Finset.sum_range_succ]
    rw [Finset.sum_range_succ',Finset.sum_range_succ']
    have he (i : ℕ) : (if Even (i+1+1) then ((↑(k+1+1) : ℝ)+1-↑(i+1+1))^2 else 0) =
        if Even i then ((k : ℝ)+1-i)^2 else 0 := by
      have hh : Even (i+1+1) ↔ Even i := by
        rw [even_iff_two_dvd,even_iff_two_dvd]
        omega
      simp only [hh,Nat.cast_add,Nat.cast_one]
      split
      · congr 1
        ring
      · rfl
    simp_rw [he]
    rw [ih k (by omega)]
    norm_num
    ring

/-- The fourth convolution power of the constant-one arithmetic function
is the convolution of the squared divisor count with the square indicator. -/
theorem zeta_pow_four_eq_divisorCountSquare_mul_positiveSquareIndicator :
    (ζ : ArithmeticFunction ℝ)^4 = positiveSquareIndicator*divisorCountSquare := by
  let hζ : ((ζ : ArithmeticFunction ℝ)^4).IsMultiplicative :=
    isMultiplicative_zeta.natCast.pow
  let hd : divisorCountSquare.IsMultiplicative :=
    (isMultiplicative_sigma.natCast.pmul isMultiplicative_sigma.natCast)
  apply (ArithmeticFunction.IsMultiplicative.eq_iff_eq_on_prime_powers _ hζ _
    (isMultiplicative_positiveSquareIndicator.mul hd)).2
  intro p k hp
  have hζ₂ : (ζ : ArithmeticFunction ℝ)^4 =
      (ζ : ArithmeticFunction ℝ)^2*(ζ : ArithmeticFunction ℝ)^2 := by
    rw [← pow_add]
  rw [hζ₂,ArithmeticFunction.mul_apply,ArithmeticFunction.mul_apply]
  rw [Nat.sum_divisorsAntidiagonal (fun i j => ((ζ : ArithmeticFunction ℝ)^2) i*((ζ : ArithmeticFunction ℝ)^2) j),
    Nat.sum_divisorsAntidiagonal (fun i j => positiveSquareIndicator i*divisorCountSquare j)]
  rw [Nat.sum_divisors_prime_pow hp,Nat.sum_divisors_prime_pow hp]
  have hquot (i : ℕ) (hi : i ∈ Finset.range (k+1)) : p^k/p^i = p^(k-i) := by
    have hi' : i ≤ k := by have := Finset.mem_range.mp hi; omega
    have he : p^k = p^(k-i)*p^i := by rw [← pow_add,Nat.sub_add_cancel hi']
    rw [he,Nat.mul_div_cancel _ (pow_pos hp.pos i)]
  have h₁ :
      (∑ i ∈ Finset.range (k+1), ((ζ : ArithmeticFunction ℝ)^2) (p^i)*
        ((ζ : ArithmeticFunction ℝ)^2) (p^k/p^i)) =
      ∑ i ∈ Finset.range (k+1), ((i : ℝ)+1)*((↑(k+1) : ℝ)-i) := by
    apply Finset.sum_congr rfl
    intro i hi
    have hi' : i ≤ k := by have := Finset.mem_range.mp hi; omega
    rw [hquot i hi,zeta_pow_two_apply,zeta_pow_two_apply,← sigma_zero_apply,← sigma_zero_apply,
      sigma_zero_apply_prime_pow hp,sigma_zero_apply_prime_pow hp,Nat.cast_add,Nat.cast_add,
      Nat.cast_sub hi',Nat.cast_add,Nat.cast_one]
    ring
  have h₂ :
      (∑ i ∈ Finset.range (k+1), positiveSquareIndicator (p^i)*divisorCountSquare (p^k/p^i)) =
      ∑ i ∈ Finset.range (k+1), if Even i then ((k : ℝ)+1-i)^2 else 0 := by
    apply Finset.sum_congr rfl
    intro i hi
    have hi' : i ≤ k := by have := Finset.mem_range.mp hi; omega
    rw [hquot i hi,positiveSquareIndicator_prime_pow hp,divisorCountSquare_apply,
      ← sigma_zero_apply,sigma_zero_apply_prime_pow hp,Nat.cast_add,Nat.cast_sub hi',Nat.cast_one,
      show (k : ℝ)-i+1 = (k : ℝ)+1-i by ring]
    split <;> simp
  rw [h₁,h₂,sum_range_consecutive_product,sum_range_even_squares]
  push_cast
  ring

end Legendre.Density.Moment
