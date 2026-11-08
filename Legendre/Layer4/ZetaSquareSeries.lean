/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The self-convolution argument specializes DensitySquareSeries.lean from
openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The specialization uses the actual untwisted zeta series, including its zero
coefficient convention. Upstream license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Mathlib.NumberTheory.LSeries.Convolution
public import Mathlib.NumberTheory.LSeries.Dirichlet
public import Mathlib.Tactic

/-! # The absolutely convergent divisor series for zeta squared -/
@[expose] public section
namespace Legendre.Zeta

noncomputable def zetaSquareCoefficient (n : ℕ) : ℂ := n.divisors.card

@[simp] theorem zetaSquareCoefficient_zero : zetaSquareCoefficient 0 = 0 := by
  simp [zetaSquareCoefficient]

@[simp] theorem zetaSquareCoefficient_one : zetaSquareCoefficient 1 = 1 := by
  simp [zetaSquareCoefficient]

theorem divisor_self_convolution :
    LSeries.convolution (1 : ℕ → ℂ) 1 =
      zetaSquareCoefficient := by
  funext n
  rw [LSeries.convolution_def]
  simp only [Pi.one_apply,one_mul]
  rw [Nat.sum_divisorsAntidiagonal' (fun _ _ => (1 : ℂ))]
  simp [zetaSquareCoefficient]

theorem zeta_square_LSeries {s : ℂ} (hs : 1 < s.re) :
    LSeries zetaSquareCoefficient s = riemannZeta s^2 := by
  rw [← divisor_self_convolution,LSeries_convolution'
    (LSeriesSummable_one_iff.2 hs) (LSeriesSummable_one_iff.2 hs),
    LSeries_one_eq_riemannZeta hs]
  ring

theorem zetaSquareCoefficient_summable {s : ℂ} (hs : 1 < s.re) :
    LSeriesSummable zetaSquareCoefficient s := by
  rw [← divisor_self_convolution]
  exact (LSeriesSummable_one_iff.2 hs).convolution (LSeriesSummable_one_iff.2 hs)

end Legendre.Zeta
