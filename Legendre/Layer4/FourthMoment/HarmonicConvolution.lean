/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.HarmonicFactorTuples
public import Mathlib.Algebra.Order.Floor.Semifield

@[expose] public section
namespace Legendre.Density.Moment
open scoped ArithmeticFunction.zeta

/-- A harmonic partial sum of a Dirichlet convolution can be summed by one
factor and a shortened harmonic sum in the other. -/
theorem sum_harmonic_convolution (f g : ArithmeticFunction ℝ) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, (f*g) n/(n : ℝ)) =
      ∑ a ∈ Finset.Icc 1 N, (f a/(a : ℝ))*(∑ b ∈ Finset.Icc 1 (N/a), g b/(b : ℝ)) := by
  let S := Finset.Icc 1 N
  let A := S.sigma Nat.divisorsAntidiagonal
  let B := S.sigma (fun a => Finset.Icc 1 (N/a))
  let w := fun p : Σ _a : ℕ, ℕ => (f p.1/(p.1 : ℝ))*(g p.2/(p.2 : ℝ))
  have hR : (∑ a ∈ S, (f a/(a : ℝ))*(∑ b ∈ Finset.Icc 1 (N/a), g b/(b : ℝ))) =
      ∑ p ∈ B, w p := by
    simp [B,w,Finset.sum_sigma,Finset.mul_sum]
  have hL : (∑ n ∈ S, (f*g) n/(n : ℝ)) =
      ∑ p ∈ A, f p.2.1*g p.2.2/(p.1 : ℝ) := by
    simp [A,Finset.sum_sigma,ArithmeticFunction.mul_apply,Finset.sum_div]
  rw [hL,hR]
  apply Finset.sum_bij (fun p _ => ⟨p.2.1,p.2.2⟩)
  · intro p hp
    obtain ⟨hn,hfac⟩ := Finset.mem_sigma.mp hp
    obtain ⟨he,hn₀⟩ := Nat.mem_divisorsAntidiagonal.mp hfac
    have h₁ : 0 < p.2.1 := by
      apply Nat.pos_of_ne_zero
      intro hh
      simp [hh] at he
      exact hn₀ he.symm
    have h₂ : 0 < p.2.2 := by
      apply Nat.pos_of_ne_zero
      intro hh
      simp [hh] at he
      exact hn₀ he.symm
    have hnN := (Finset.mem_Icc.mp hn).2
    have hmul : p.2.1*p.2.2 ≤ N := he ▸ hnN
    have ha : p.2.1 ≤ N := (Nat.le_mul_of_pos_right _ h₂).trans hmul
    have hb : p.2.2 ≤ N/p.2.1 := (Nat.le_div_iff_mul_le h₁).2 (by simpa only [mul_comm] using hmul)
    exact Finset.mem_sigma.mpr ⟨Finset.mem_Icc.mpr ⟨h₁,ha⟩,Finset.mem_Icc.mpr ⟨h₂,hb⟩⟩
  · intro p hp q hq he
    have hp' := (Nat.mem_divisorsAntidiagonal.mp (Finset.mem_sigma.mp hp).2).1
    have hq' := (Nat.mem_divisorsAntidiagonal.mp (Finset.mem_sigma.mp hq).2).1
    have h₁ : p.2.1 = q.2.1 := congrArg Sigma.fst he
    have h₂ : p.2.2 = q.2.2 := congrArg (fun p : Σ _a : ℕ, ℕ => p.2) he
    have hn : p.1 = q.1 := by rw [← hp',← hq',h₁,h₂]
    exact Sigma.ext hn (heq_of_eq (Prod.ext h₁ h₂))
  · intro p hp
    obtain ⟨ha,hb⟩ := Finset.mem_sigma.mp hp
    have ha₀ := (Finset.mem_Icc.mp ha).1
    obtain ⟨hb₀,hbN⟩ := Finset.mem_Icc.mp hb
    have hn : 0 < p.1*p.2 := Nat.mul_pos ha₀ hb₀
    have hmul := (Nat.le_div_iff_mul_le ha₀).1 hbN
    exact ⟨⟨p.1*p.2,p.1,p.2⟩,Finset.mem_sigma.mpr
      ⟨Finset.mem_Icc.mpr ⟨hn,by simpa only [mul_comm] using hmul⟩,
        Nat.mem_divisorsAntidiagonal.mpr ⟨rfl,hn.ne'⟩⟩,rfl⟩
  · intro p hp
    have he := (Nat.mem_divisorsAntidiagonal.mp (Finset.mem_sigma.mp hp).2).1
    dsimp only [w]
    rw [← he,Nat.cast_mul]
    ring

/-- The tuple sum is the reciprocal-weighted sum of the coefficients
of the k-fold Dirichlet convolution of the constant-one arithmetic function. -/
theorem harmonicFactorTuples_eq_zeta_pow (k : ℕ) {x : ℝ} (hx : 1 ≤ x) :
    harmonicFactorTuples k x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, ((ζ : ArithmeticFunction ℝ)^k) n/(n : ℝ) := by
  induction k generalizing x with
  | zero =>
    have hN : 1 ≤ ⌊x⌋₊ := (Nat.le_floor_iff (zero_le_one.trans hx)).2 (by exact_mod_cast hx)
    rw [harmonicFactorTuples,pow_zero,Finset.sum_eq_single 1]
    · simp
    · intro n hn hne
      rw [ArithmeticFunction.one_apply_ne hne,zero_div]
    · exact fun hn => (hn (Finset.mem_Icc.mpr ⟨le_rfl,hN⟩)).elim
  | succ k ih =>
    rw [harmonicFactorTuples,pow_succ',sum_harmonic_convolution]
    apply Finset.sum_congr rfl
    intro n hn
    obtain ⟨hn₁,hnx⟩ := Finset.mem_Icc.mp hn
    have hn₀ : (0 : ℝ) < n := by exact_mod_cast hn₁
    have hnr : (n : ℝ) ≤ x := (by exact_mod_cast hnx : (n : ℝ) ≤ ⌊x⌋₊).trans
      (Nat.floor_le (zero_le_one.trans hx))
    rw [ih ((one_le_div hn₀).2 hnr),Nat.floor_div_natCast,
      ArithmeticFunction.natCoe_apply,ArithmeticFunction.zeta_apply_ne (Nat.ne_of_gt hn₁),
      Nat.cast_one,one_div,div_eq_mul_inv,mul_comm]

end Legendre.Density.Moment
