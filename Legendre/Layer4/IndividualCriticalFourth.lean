/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions. Taking fourth powers before summing critical masses avoids
an unnecessary sample-cardinality factor when the mollifier cutoff is small.
-/
module
public import Legendre.Layer4.PackedCriticalMass

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory
open scoped BigOperators ArithmeticFunction.Moebius

noncomputable def criticalWeightMassMajorant : ℝ :=
  1+∫ u : ℝ, Detector.Smooth.criticalWeight u

theorem criticalWeightMassMajorant_pos : 0 < criticalWeightMassMajorant := by
  have hh : 0 ≤ ∫ u : ℝ, Detector.Smooth.criticalWeight u :=
    integral_nonneg Detector.Smooth.criticalWeight_nonneg
  unfold criticalWeightMassMajorant
  linarith

/-- Pointwise bounded mollification gives an individual, rather than packed-sum, fourth moment. -/
theorem critical_mass_individual_fourth (X : ℕ) (t : ℝ)
    (h4 : Integrable (fun v => Detector.Smooth.criticalWeight (v-t)*
      ‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖^4)) :
    (Detector.Smooth.criticalMass X t)^4 ≤
      criticalWeightMassMajorant^3*(X : ℝ)^4*
        ∫ v : ℝ, Detector.Smooth.criticalWeight (v-t)*‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖^4 := by
  let w := fun v : ℝ => Detector.Smooth.criticalWeight (v-t)
  let f := fun v : ℝ => ‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖
  let g := fun v : ℝ => ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖
  have hw : ∀ v, 0 ≤ w v := fun v => Detector.Smooth.criticalWeight_nonneg _
  have hwc : Continuous w := Detector.Smooth.criticalWeight_continuous.comp
    (continuous_id.sub continuous_const)
  have hfc : Continuous f := zeta_critical_continuous.norm
  have hgc : Continuous g := (mollifier_critical_continuous X).norm
  have hgb (v : ℝ) : g v ≤ (X : ℝ) :=
    Detector.norm_mollifier_finiteSeries_le X (by norm_num)
  have hgsq (v : ℝ) : (g v)^2 ≤ (X : ℝ)^2 :=
    pow_le_pow_left₀ (norm_nonneg _) (hgb v) 2
  have hgi : Integrable (fun v => w v*g v^2) := by
    apply ((criticalWeight_shift_integrable t).mul_const ((X : ℝ)^2)).mono'
      (hwc.mul (hgc.pow 2)).aestronglyMeasurable
    filter_upwards with v
    change ‖w v*g v^2‖ ≤ w v*(X : ℝ)^2
    rw [Real.norm_eq_abs,abs_of_nonneg (mul_nonneg (hw v) (sq_nonneg _))]
    exact mul_le_mul_of_nonneg_left (hgsq v) (hw v)
  have hmixed := moment_cubic_mixed_integrable f g hfc hgc
    (fun _ => norm_nonneg _) (fun _ => norm_nonneg _) t h4 hgi
  have hpow := moment_finite_product_fourth ({0} : Finset ℕ) (fun _ => w)
    (fun _ => f) (fun _ => g) (fun _ _ => hw)
    (fun _ _ => criticalWeight_shift_integrable t)
    (fun _ _ => hmixed.1) (fun _ _ => h4) (fun _ _ => hgi) (fun _ _ => hmixed.2)
  simp only [Finset.sum_singleton] at hpow
  have hK := criticalWeightMassMajorant_pos
  have hwint : (∫ v : ℝ, w v) ≤ criticalWeightMassMajorant := by
    dsimp [w]
    rw [criticalWeight_shift_integral]
    unfold criticalWeightMassMajorant
    linarith
  have hM : (∫ v : ℝ, w v*g v^2) ≤ criticalWeightMassMajorant*(X : ℝ)^2 := by
    calc
      _ ≤ ∫ v : ℝ, w v*(X : ℝ)^2 := integral_mono hgi
        ((criticalWeight_shift_integrable t).mul_const _) (fun v =>
          mul_le_mul_of_nonneg_left (hgsq v) (hw v))
      _ = (∫ v : ℝ, w v)*(X : ℝ)^2 := integral_mul_const _ _
      _ ≤ _ := mul_le_mul_of_nonneg_right hwint (sq_nonneg _)
  have hf0 : 0 ≤ ∫ v : ℝ, w v*f v^4 := integral_nonneg
    (fun v => mul_nonneg (hw v) (by positivity))
  have hg0 : 0 ≤ ∫ v : ℝ, w v*g v^2 := integral_nonneg
    (fun v => mul_nonneg (hw v) (sq_nonneg _))
  have hMsq := pow_le_pow_left₀ hg0 hM 2
  have hprod := mul_le_mul (mul_le_mul_of_nonneg_right hwint hf0) hMsq
    (sq_nonneg _) (show 0 ≤ criticalWeightMassMajorant*∫ v : ℝ, w v*f v^4 by positivity)
  rw [criticalMass_eq_shift]
  apply hpow.trans
  convert hprod using 1 <;> dsimp [w,f,g] <;> ring

/-- Summing the individual fourth powers uses the proved packed zeta fourth moment only once. -/
theorem sum_critical_mass_fourth :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, ∀ T : ℝ, 2 ≤ T →
      ∀ {ι : Type*} (S : Finset ι) (t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, (Detector.Smooth.criticalMass X (t i))^4) ≤
        C*(X : ℝ)^4*T*(Real.log T)^6 := by
  obtain ⟨C,hC,hfourth⟩ := packed_zeta_fourth_moment
  have hK := criticalWeightMassMajorant_pos
  refine ⟨criticalWeightMassMajorant^3*C,by positivity,?_⟩
  intro X T hT ι S t ht hs
  obtain ⟨hi,hb⟩ := hfourth T hT S t ht hs
  have hh := Finset.sum_le_sum (fun i hiS => critical_mass_individual_fourth X (t i) (hi i hiS))
  rw [←Finset.mul_sum] at hh
  have hp := mul_le_mul_of_nonneg_left hb
    (show 0 ≤ criticalWeightMassMajorant^3*(X : ℝ)^4 by positivity)
  apply hh.trans
  convert hp using 1 <;> ring

end Legendre.Density.Moment
