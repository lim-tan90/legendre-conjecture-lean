/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronFullRectangle
public import Legendre.PerronUniformBounds
public import Legendre.ZetaOriginValue

/-!
# A full-strip truncated explicit formula with a uniform contour remainder

The left edge is fixed at -1/8 and all critical-strip zeros are included,
with analytic multiplicity. The origin correction is retained exactly.
The contour coefficient is absolute: it is chosen before H,T,x and σ.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology MeasureTheory Set

/-- The full finite Perron identity, including the residue at the origin. -/
theorem truncatedPerron_full_explicit {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ) (hT : 0 < T)
    (hgood : ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T) :
    truncatedPerron x σ T = (x : ℂ)-truncatedZeroSum x T-logDeriv riemannZeta 0+
      perronContourRemainder x (-(1/8)) σ T := by
  have heq := fullPerronRectangle_integral_eq hx hσ hT hgood
  norm_num [RectangleIntegral',RectangleIntegral] at heq
  rw [← VIntegral'_eq_truncatedPerron]
  norm_num [perronContourRemainder,HIntegral',VIntegral',smul_eq_mul]
  linear_combination heq

/-- The full finite zero-sum formula for the half-weighted summatory von Mangoldt function. -/
theorem halfWeightedPsi_full_explicit {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ) (hT : 0 < T)
    (hgood : ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T) :
    halfWeightedPsi x = (x : ℂ)-truncatedZeroSum x T-logDeriv riemannZeta 0+
      truncatedExplicitError x (-(1/8)) σ T := by
  rw [truncatedExplicitError,truncatedPerron_full_explicit hx hσ hT hgood]
  ring

/-- All contour dependence is bounded by one height-independent coefficient. -/
theorem norm_fullExplicitError_le_uniform {C H T x σ : ℝ} (hC : 0 ≤ C)
    (hb : ∀ t : ℝ, ‖logDeriv riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*I)‖ ≤ C*Real.log (|t|+5))
    (hH : 7 ≤ H) (hT : T ∈ Ioo H (H+1)) (hx : 0 < x) (hσ : 1 < σ)
    (hgood : ∀ ρ : ℂ, NontrivialZero ρ → goodHeightSeparationConstant/Real.log H ≤ abs (T-|ρ.im|)) :
    ‖truncatedExplicitError x (-(1/8)) σ T‖ ≤ perronErrorUpper x σ/T+
      (9*C/Real.pi+fullGoodHeightLogDerivativeConstant/Real.pi+1)*(Real.log (H+6))^2*
        (x^(-(1/8 : ℝ))+(σ+1/8)*max (x^(-(1/8 : ℝ))) (x^σ)/T) := by
  have hTpos : 0 < T := by linarith [hT.1]
  have hπ := Real.pi_pos
  have hfull := fullGoodHeightLogDerivativeConstant_pos
  have hlogH : 0 ≤ Real.log H := Real.log_nonneg (by linarith)
  have hlogT : 0 ≤ Real.log (T+5) := Real.log_nonneg (by linarith)
  have hlogcap : 0 ≤ Real.log (H+6) := Real.log_nonneg (by linarith)
  have hlogsT : Real.log (T+5) ≤ Real.log (H+6) :=
    Real.log_le_log (by linarith) (by linarith [hT.2])
  have hlogsH : Real.log H ≤ Real.log (H+6) := Real.log_le_log (by linarith) (by linarith)
  have hsT := (sq_le_sq₀ hlogT hlogcap).2 hlogsT
  have hsH := (sq_le_sq₀ hlogH hlogcap).2 hlogsH
  let Q := 9*C/Real.pi+fullGoodHeightLogDerivativeConstant/Real.pi+1
  let B := (σ+1/8)*max (x^(-(1/8 : ℝ))) (x^σ)/T
  have hB : 0 ≤ B := by dsimp [B]; positivity
  have hxp : 0 ≤ x^(-(1/8 : ℝ)) := Real.rpow_nonneg hx.le _
  have hQleft : 9*C/Real.pi ≤ Q := by
    dsimp [Q]
    have hh := div_nonneg hfull.le hπ.le
    linarith
  have hQhor : fullGoodHeightLogDerivativeConstant/Real.pi ≤ Q := by
    dsimp [Q]
    have hh := div_nonneg (mul_nonneg (by norm_num : (0 : ℝ) ≤ 9) hC) hπ.le
    linarith
  have hv := norm_perron_left_uniform hx hTpos.le hC hb
  have hu := norm_perron_full_horizontal_le hH hT (.inl rfl) hx hσ hgood
  have hl := norm_perron_full_horizontal_le hH hT (.inr rfl) hx hσ hgood
  have he := norm_truncatedExplicitError_le (a := -(1/8)) hx hσ hTpos
  have hv' : ‖VIntegral' (perronIntegrand x) (-(1/8)) (-T) T‖ ≤
      Q*(Real.log (H+6))^2*x^(-(1/8 : ℝ)) := by
    apply hv.trans
    exact mul_le_mul_of_nonneg_right
      (mul_le_mul hQleft hsT (sq_nonneg _) (by dsimp [Q]; positivity)) hxp
  have hh : ‖HIntegral' (perronIntegrand x) (-(1/8)) σ T‖+
      ‖HIntegral' (perronIntegrand x) (-(1/8)) σ (-T)‖ ≤ Q*(Real.log (H+6))^2*B := by
    calc
      _ ≤ 2*(fullGoodHeightLogDerivativeConstant*(Real.log H)^2*(σ+1/8)/(2*Real.pi*T)*
          max (x^(-(1/8 : ℝ))) (x^σ)) := by linarith
      _ = (fullGoodHeightLogDerivativeConstant/Real.pi)*(Real.log H)^2*B := by dsimp [B]; ring
      _ ≤ _ := mul_le_mul_of_nonneg_right
        (mul_le_mul hQhor hsH (sq_nonneg _) (by dsimp [Q]; positivity)) hB
  calc
    _ ≤ perronErrorUpper x σ/T+
        Q*(Real.log (H+6))^2*x^(-(1/8 : ℝ))+Q*(Real.log (H+6))^2*B := by linarith
    _ = _ := by dsimp [Q,B]; ring

/-- A complete finite explicit formula with a fixed negative edge and an absolute contour coefficient.
The height is selected before both x and the right endpoint σ. -/
theorem exists_full_truncated_explicit_formula : ∃ C > 0, ∀ H : ℝ, 7 ≤ H →
    ∃ T ∈ Ioo H (H+1), ∀ σ : ℝ, 1 < σ → ∀ x : ℝ, 0 < x → ∃ E : ℂ,
      halfWeightedPsi x = (x : ℂ)-truncatedZeroSum x T-log (2*(Real.pi : ℂ))+E ∧
      ‖E‖ ≤ perronErrorUpper x σ/T+C*(Real.log (H+6))^2*
        (x^(-(1/8 : ℝ))+(σ+1/8)*max (x^(-(1/8 : ℝ))) (x^σ)/T) := by
  obtain ⟨C,hC,hb⟩ := exists_uniform_perron_left_bound
  have hπ := Real.pi_pos
  have hfull := fullGoodHeightLogDerivativeConstant_pos
  refine ⟨9*C/Real.pi+fullGoodHeightLogDerivativeConstant/Real.pi+1,by positivity,fun H hH => ?_⟩
  obtain ⟨T,hT,hsep⟩ := exists_good_height_log_separation hH
  have hTpos : 0 < T := by linarith [hT.1]
  have hδ := div_pos goodHeightSeparationConstant_pos (Real.log_pos (by linarith : 1 < H))
  have hgood (ρ : ℂ) (hρ : NontrivialZero ρ) : |ρ.im| ≠ T := by
    intro he
    have hs := hsep ρ hρ
    rw [he,sub_self,abs_zero] at hs
    linarith
  refine ⟨T,hT,fun σ hσ x hx => ?_⟩
  exact ⟨truncatedExplicitError x (-(1/8)) σ T,
    (by simpa only [logDeriv_riemannZeta_origin] using halfWeightedPsi_full_explicit hx hσ hTpos hgood),
    norm_fullExplicitError_le_uniform hC.le hb hH hT hx hσ hsep⟩

end Legendre.Zeta
