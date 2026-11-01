/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronExplicitBounds
public import Legendre.ZetaGoodHeightBounds

/-!
# Quantitative horizontal pieces of the Perron contour

At a common height in (H,H+1), both horizontal integrals over any interval
[α,σ] with 7/8≤α≤σ exist and have an explicit log-squared bound. The left
part of the contour, needed to enclose every zero in the explicit formula,
is not estimated by this result.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Set MeasureTheory

/-- A bound on the horizontal segment alone suffices to estimate its integral. -/
theorem norm_perron_horizontal_le_of_segment_bound {x a σ t M : ℝ}
    (hx : 0 < x) (haσ : a ≤ σ) (ht : t ≠ 0) (hM : 0 ≤ M)
    (hb : ∀ u ∈ Icc a σ, ‖logDeriv riemannZeta ((u : ℂ)+(t : ℂ)*I)‖ ≤ M) :
    ‖HIntegral' (perronIntegrand x) a σ t‖ ≤
      M*(σ-a)/(2*Real.pi*|t|)*max (x^a) (x^σ) := by
  have hi : ‖∫ u : ℝ in a..σ, perronIntegrand x ((u : ℂ)+(t : ℂ)*I)‖ ≤
      (M*max (x^a) (x^σ)/|t|)*|σ-a| := by
    apply intervalIntegral.norm_integral_le_of_norm_le_const
    intro u hu
    have hu' := uIoc_subset_uIcc hu
    rw [uIcc_of_le haσ] at hu'
    rw [perronIntegrand,norm_mul,norm_neg]
    calc
      _ ≤ M*(max (x^a) (x^σ)/|t|) :=
        mul_le_mul (hb u hu') (norm_perronWeight_horizontal_le hx hu' ht)
          (norm_nonneg _) hM
      _ = _ := by ring
  simp only [HIntegral',HIntegral,smul_eq_mul,norm_mul,norm_perron_normalization]
  calc
    _ ≤ (1/(2*Real.pi))*((M*max (x^a) (x^σ)/|t|)*|σ-a|) :=
      mul_le_mul_of_nonneg_left hi (by positivity)
    _ = _ := by rw [abs_of_nonneg (sub_nonneg.2 haσ)]; ring

/-- Nonvanishing on a nonreal horizontal segment gives genuine integrability. -/
theorem perron_horizontal_intervalIntegrable {x a σ t : ℝ} (hx : 0 < x) (haσ : a ≤ σ)
    (ht : t ≠ 0) (hz : ∀ u ∈ Icc a σ, riemannZeta ((u : ℂ)+(t : ℂ)*I) ≠ 0) :
    IntervalIntegrable (fun u : ℝ => perronIntegrand x ((u : ℂ)+(t : ℂ)*I)) volume a σ := by
  apply ContinuousOn.intervalIntegrable_of_Icc haσ
  intro u hu
  have hs0 : (u : ℂ)+(t : ℂ)*I ≠ 0 := by
    intro he
    have hi := congrArg Complex.im he
    apply ht
    simpa using hi
  have hs1 : (u : ℂ)+(t : ℂ)*I ≠ 1 := by
    intro he
    have hi := congrArg Complex.im he
    apply ht
    simpa using hi
  have hc : ContinuousAt (fun v : ℝ => (v : ℂ)+(t : ℂ)*I) u :=
    continuous_ofReal.continuousAt.add continuousAt_const
  exact ((perronIntegrand_analyticAt hx hs0 hs1 (hz u hu)).continuousAt.comp (f := fun v : ℝ => (v : ℂ)+(t : ℂ)*I) hc).continuousWithinAt

/-- Common good heights control both horizontal Perron pieces uniformly in x and endpoints. -/
theorem exists_good_height_perron_horizontal_bound {H : ℝ} (hH : 7 ≤ H) :
    ∃ T ∈ Ioo H (H+1), ∀ t : ℝ, (t = T ∨ t = -T) →
      ∀ x a σ : ℝ, 0 < x → 7/8 ≤ a → a ≤ σ →
        IntervalIntegrable (fun u : ℝ => perronIntegrand x ((u : ℂ)+(t : ℂ)*I)) volume a σ ∧
        ‖HIntegral' (perronIntegrand x) a σ t‖ ≤
          goodHeightLogDerivativeConstant*(Real.log H)^2*(σ-a)/(2*Real.pi*T)*
            max (x^a) (x^σ) := by
  obtain ⟨T,hT,hgood⟩ := exists_good_height_logDeriv_bound hH
  refine ⟨T,hT,fun t ht x a σ hx ha haσ => ?_⟩
  have hTpos : 0 < T := by linarith [hT.1]
  have htabs : |t| = T := by rcases ht with rfl|rfl <;> simp [abs_of_pos hTpos]
  have ht0 : t ≠ 0 := by intro he; rw [he,abs_zero] at htabs; linarith
  have hz (u : ℝ) (hu : u ∈ Icc a σ) := hgood t ht u (ha.trans hu.1)
  refine ⟨perron_horizontal_intervalIntegrable hx haσ ht0 (fun u hu => (hz u hu).1),?_⟩
  have hb := norm_perron_horizontal_le_of_segment_bound hx haσ ht0
    (mul_nonneg goodHeightLogDerivativeConstant_pos.le (sq_nonneg (Real.log H)))
    (fun u hu => (hz u hu).2)
  simpa only [htabs] using hb

/-- Quantitatively separated heights can also be used for the full finite zero-sum identity.
The residual boundary constant M is retained for the left portion of the contour. -/
theorem exists_truncated_explicit_formula_good_height {H σ : ℝ} (hH : 7 ≤ H) (hσ : 1 < σ) :
    ∃ T ∈ Ioo H (H+1),
      (∀ ρ : ℂ, NontrivialZero ρ →
        goodHeightSeparationConstant/Real.log H ≤ abs (T - |ρ.im|)) ∧
      ∃ a ∈ Ioo (0 : ℝ) 1, ∃ M ≥ 0, ∀ x : ℝ, 0 < x →
        ∃ E : ℂ, halfWeightedPsi x = (x : ℂ)-truncatedZeroSum x T+E ∧
        ‖E‖ ≤ perronErrorUpper x σ/T + M*T/(Real.pi*a)*x^a +
          M*(σ-a)/(Real.pi*T)*max (x^a) (x^σ) := by
  obtain ⟨T,hT,hsep⟩ := exists_good_height_log_separation hH
  have hTpos : 0 < T := by linarith [hT.1]
  have hδ := div_pos goodHeightSeparationConstant_pos (Real.log_pos (by linarith : 1 < H))
  have hgood (ρ : ℂ) (hρ : NontrivialZero ρ) : |ρ.im| ≠ T := by
    intro he
    have hs := hsep ρ hρ
    rw [he,sub_self,abs_zero] at hs
    linarith
  obtain ⟨a,ha,hcut⟩ := exists_symmetricZeroCutoff T
  have hz := perronRectangleBorder_nonvanishing ha.1 ha.2 hσ hTpos hcut hgood
  obtain ⟨M,hM,hb⟩ := exists_perron_boundary_bound ha.2 hσ hTpos hz
  refine ⟨T,hT,hsep,a,ha,M,hM,fun x hx => ?_⟩
  exact ⟨truncatedExplicitError x a σ T,
    halfWeightedPsi_explicit hx ha.1 ha.2 hσ hTpos hcut hgood,
    norm_truncatedExplicitError_le_boundary_bound hx ha.1 ha.2 hσ hTpos hM hb⟩

end Legendre.Zeta
