/-
Adapted from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae.
Original: lean/OAI/NumberTheory/Ostmann/ZeroDensity/CharacterGammaShift.lean.
Apache-2.0; retained license: licenses/openai-math-Apache-2.0.txt.
Changes: select the scalar Gaussian estimate and specialize the square weight
to the real Gamma factor, with no character or conductor parameter.
-/
module

public import Legendre.GammaBounds.SharpGammaRealShift

@[expose] public section

namespace Legendre.Density.GammaBounds

open Complex

theorem gaussian_linear_abs_bound (C σ u : ℝ) (hσ : 0 ≤ σ) (hσ2 : σ ≤ 2) :
    Real.exp (2*C*(1+|u|)+σ^2-u^2) ≤
      Real.exp (2*C+4+2*C^2)*Real.exp (-(u^2)/2) := by
  rw [← Real.exp_add]
  apply Real.exp_le_exp.mpr
  nlinarith [sq_nonneg (|u|-2*C),sq_abs u]

noncomputable def gammaGaussianConstant : ℝ :=
  Real.exp (2*(59+|Real.eulerMascheroniConstant|)+4+
    2*(59+|Real.eulerMascheroniConstant|)^2)

noncomputable def gammaSquareGaussianWeight (s w : ℂ) : ℂ :=
  (Gammaℝ (s+w)/Gammaℝ s)^2*Complex.exp (w^2)

/-- The horizontal height exponent is exactly Re(w), as needed for length O(T). -/
theorem gammaSquareGaussianWeight_bound (s w : ℂ) (hs : s.re = 1/2)
    (hw : 0 ≤ w.re) (hw2 : w.re ≤ 2) :
    ‖gammaSquareGaussianWeight s w‖ ≤
      gammaGaussianConstant*(|s.im|+2)^w.re*Real.exp (-(w.im^2)/2) := by
  let C : ℝ := 59+|Real.eulerMascheroniConstant|
  have hG := sharp_gammaReal_shift s w (by linarith) (by linarith) hw hw2
  have hsq := pow_le_pow_left₀ (norm_nonneg _) hG 2
  have he : ‖Complex.exp (w^2)‖ = Real.exp (w.re^2-w.im^2) := by
    rw [Complex.norm_exp]
    congr 1
    simp [pow_two,Complex.mul_re]
  have hsquare : (Real.exp (C*(1+|w.im|))*(|s.im|+2)^(w.re/2))^2 =
      Real.exp (2*C*(1+|w.im|))*(|s.im|+2)^w.re := by
    rw [mul_pow,← Real.exp_nat_mul,← Real.rpow_natCast,
      ← Real.rpow_mul (by positivity : 0 ≤ |s.im|+2)]
    congr 1
    · congr 1
      norm_num
      ring
    · congr 1
      norm_num
  calc
    _ ≤ (Real.exp (C*(1+|w.im|))*(|s.im|+2)^(w.re/2))^2*
        Real.exp (w.re^2-w.im^2) := by
      simpa only [gammaSquareGaussianWeight,norm_mul,norm_pow,he] using
        mul_le_mul_of_nonneg_right hsq (Real.exp_nonneg (w.re^2-w.im^2))
    _ = (|s.im|+2)^w.re*Real.exp (2*C*(1+|w.im|)+w.re^2-w.im^2) := by
      rw [hsquare,show 2*C*(1+|w.im|)+w.re^2-w.im^2 =
        2*C*(1+|w.im|)+(w.re^2-w.im^2) by ring,Real.exp_add]
      ring
    _ ≤ _ := by
      have h := mul_le_mul_of_nonneg_left (gaussian_linear_abs_bound C w.re w.im hw hw2)
        (Real.rpow_nonneg (by positivity : 0 ≤ |s.im|+2) w.re)
      simpa only [C,gammaGaussianConstant,mul_assoc,mul_left_comm] using h

end Legendre.Density.GammaBounds
