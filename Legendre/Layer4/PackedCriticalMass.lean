/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityCriticalMass.lean and DensityPackedProduct.lean in
openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The literal zeta critical mass uses raw ordinates and retains actual integrals.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.CubicIntegrability

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory
open scoped BigOperators ArithmeticFunction.Moebius

theorem criticalMass_eq_shift (X : ℕ) (t : ℝ) : Detector.Smooth.criticalMass X t =
    ∫ v : ℝ, Detector.Smooth.criticalWeight (v-t)*‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖*
      ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖ := by
  have he := integral_add_right_eq_self («μ» := volume)
    (fun v : ℝ => Detector.Smooth.criticalWeight (v-t)*‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖*
      ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖) t
  unfold Detector.Smooth.criticalMass
  convert he using 1
  apply integral_congr_ae
  filter_upwards with u
  simp only [add_sub_cancel_right,Detector.Smooth.criticalProduct,norm_mul]
  rw [add_comm u t]
  ring

theorem packed_critical_mass_fourth :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 2 ≤ T →
      ∀ {ι : Type*} (S : Finset ι) (t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, Detector.Smooth.criticalMass X (t i))^4 ≤
        C*(S.card : ℝ)*T*((X : ℝ)+T)^2*(Real.log T)^6*(1+Real.log X)^2 := by
  obtain ⟨C4,hC4,hfourth⟩ := packed_zeta_fourth_moment
  obtain ⟨C2,hC2,hsecond⟩ := packed_mollifier_mean
  let W0 := 1+∫ v : ℝ, Detector.Smooth.criticalWeight v
  have hW0 : 0 < W0 := by
    have hn : 0 ≤ ∫ v : ℝ, Detector.Smooth.criticalWeight v :=
      integral_nonneg Detector.Smooth.criticalWeight_nonneg
    dsimp [W0]
    linarith
  refine ⟨W0*C4*C2^2,by positivity,?_⟩
  intro X hX T hT ι S t ht hs
  simp_rw [criticalMass_eq_shift]
  obtain ⟨hi4,hb4⟩ := hfourth T hT S t ht hs
  obtain ⟨hiM,hbM⟩ := hsecond X hX T hT S t ht hs
  let f := fun v : ℝ => ‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖
  let g := fun v : ℝ => ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖
  let w := fun i v => Detector.Smooth.criticalWeight (v-t i)
  have hfc : Continuous f := zeta_critical_continuous.norm
  have hgc : Continuous g := (mollifier_critical_continuous X).norm
  have hmixed (i : ι) (hi : i ∈ S) := moment_cubic_mixed_integrable f g hfc hgc
    (fun _ => norm_nonneg _) (fun _ => norm_nonneg _) (t i) (hi4 i hi) (hiM i hi)
  have hpow := moment_finite_product_fourth S w (fun _ => f) (fun _ => g)
    (fun _ _ _ => Detector.Smooth.criticalWeight_nonneg _)
    (fun i _ => criticalWeight_shift_integrable (t i))
    (fun i hi => (hmixed i hi).1) hi4 hiM (fun i hi => (hmixed i hi).2)
  have hweight : (∑ i ∈ S, ∫ v : ℝ, w i v) ≤ (S.card : ℝ)*W0 := by
    dsimp [w]
    simp_rw [criticalWeight_shift_integral]
    simp only [Finset.sum_const,nsmul_eq_mul]
    apply mul_le_mul_of_nonneg_left _ (Nat.cast_nonneg _)
    dsimp [W0]
    linarith
  have hf4non : 0 ≤ ∑ i ∈ S, ∫ v : ℝ, w i v*f v^4 :=
    Finset.sum_nonneg (fun i _ => integral_nonneg (fun v =>
      mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (by positivity)))
  have hmnon : 0 ≤ ∑ i ∈ S, ∫ v : ℝ, w i v*g v^2 :=
    Finset.sum_nonneg (fun i _ => integral_nonneg (fun v =>
      mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (sq_nonneg _)))
  have hWM := mul_le_mul hweight hb4 hf4non (show 0 ≤ (S.card : ℝ)*W0 by positivity)
  have hMsq := pow_le_pow_left₀ hmnon hbM 2
  apply hpow.trans
  calc
    _ ≤ ((S.card : ℝ)*W0)*(C4*T*(Real.log T)^6)*
        (C2*((X : ℝ)+T)*(1+Real.log X))^2 :=
      mul_le_mul hWM hMsq (sq_nonneg _) (by positivity)
    _ = _ := by ring

end Legendre.Density.Moment
