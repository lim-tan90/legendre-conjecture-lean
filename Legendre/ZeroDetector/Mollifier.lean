/-
Adapted from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae.
Original: lean/OAI/NumberTheory/Ostmann/ZeroDensity/Mollifier.lean.
Apache-2.0; license retained in licenses/openai-math-Apache-2.0.txt.
Changes: retain the character-independent coefficient slice, local namespace,
and Lean/mathlib v4.35.0 public module visibility.
-/
module

public import Mathlib.NumberTheory.ArithmeticFunction.Moebius
public import Mathlib.NumberTheory.LSeries.Convolution
public import Mathlib.Tactic

/-!
# Finite Möbius mollifiers and their exact cancellation range

The low coefficients cancel by Möbius inversion. This is arithmetic input
for an analytic zero detector; no zero-density statement is assumed.
-/

@[expose] public section

namespace Legendre.Density.Detector

open scoped ArithmeticFunction.Moebius ArithmeticFunction.zeta

noncomputable def truncate (N : ℕ) (f : ArithmeticFunction ℂ) : ArithmeticFunction ℂ :=
  ⟨fun n => if n ≤ N then f n else 0, by simp⟩

@[simp] theorem truncate_apply (N : ℕ) (f : ArithmeticFunction ℂ) (n : ℕ) :
    truncate N f n = if n ≤ N then f n else 0 := rfl

noncomputable def mollifierCoefficient (X N : ℕ) : ArithmeticFunction ℂ :=
  truncate X (μ : ArithmeticFunction ℂ) * truncate N (ζ : ArithmeticFunction ℂ)

theorem mollifierCoefficient_initial {X N n : ℕ} (hnX : n ≤ X) (hnN : n ≤ N) :
    mollifierCoefficient X N n = (1 : ArithmeticFunction ℂ) n := by
  calc
    mollifierCoefficient X N n =
        ((μ : ArithmeticFunction ℂ) * (ζ : ArithmeticFunction ℂ)) n := by
      rw [mollifierCoefficient, ArithmeticFunction.mul_apply, ArithmeticFunction.mul_apply]
      apply Finset.sum_congr rfl
      intro p hp
      have hp1 := Nat.divisor_le (Nat.fst_mem_divisors_of_mem_antidiagonal hp)
      have hp2 := Nat.divisor_le (Nat.snd_mem_divisors_of_mem_antidiagonal hp)
      simp [hp1.trans hnX, hp2.trans hnN]
    _ = _ := by rw [ArithmeticFunction.coe_moebius_mul_coe_zeta]

@[simp] theorem mollifierCoefficient_one {X N : ℕ} (hX : 1 ≤ X) (hN : 1 ≤ N) :
    mollifierCoefficient X N 1 = 1 := by
  simpa using mollifierCoefficient_initial hX hN

theorem mollifierCoefficient_vanish {X N n : ℕ} (hX : X ≤ N)
    (hn : 2 ≤ n) (hnX : n ≤ X) : mollifierCoefficient X N n = 0 := by
  rw [mollifierCoefficient_initial hnX (hnX.trans hX)]
  exact ArithmeticFunction.one_apply_ne (by omega)

theorem mollifierCoefficient_support {X N n : ℕ} (hn : X*N < n) :
    mollifierCoefficient X N n = 0 := by
  rw [mollifierCoefficient,ArithmeticFunction.mul_apply]
  apply Finset.sum_eq_zero
  intro p hp
  have hprod := (Nat.mem_divisorsAntidiagonal.mp hp).1
  by_cases hx : p.1 ≤ X
  · have hn' : ¬p.2 ≤ N := by
      intro hN
      have := Nat.mul_le_mul hx hN
      omega
    simp [hx,hn']
  · simp [hx]

theorem norm_mollifierCoefficient_le (X N n : ℕ) :
    ‖mollifierCoefficient X N n‖ ≤ (n.divisors.card : ℝ) := by
  rw [mollifierCoefficient,ArithmeticFunction.mul_apply]
  calc
    ‖∑ p ∈ n.divisorsAntidiagonal,
      truncate X (μ : ArithmeticFunction ℂ) p.1 *
        truncate N (ζ : ArithmeticFunction ℂ) p.2‖ ≤
        ∑ p ∈ n.divisorsAntidiagonal,
          ‖truncate X (μ : ArithmeticFunction ℂ) p.1 *
            truncate N (ζ : ArithmeticFunction ℂ) p.2‖ := norm_sum_le _ _
    _ ≤ ∑ _p ∈ n.divisorsAntidiagonal, (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro p hp
      have hp2 := Nat.right_ne_zero_of_mem_divisorsAntidiagonal hp
      by_cases hx : p.1 ≤ X <;> by_cases hn : p.2 ≤ N
      · rcases ArithmeticFunction.moebius_eq_or p.1 with hm | hm | hm <;>
          simp [hx,hn,ArithmeticFunction.natCoe_apply,
            ArithmeticFunction.intCoe_apply,ArithmeticFunction.zeta_apply_ne hp2,hm]
      · simp [hn]
      · simp [hx]
      · simp [hx]
    _ = (n.divisors.card : ℝ) := by
      rw [← Nat.map_div_right_divisors]
      simp

end Legendre.Density.Detector
