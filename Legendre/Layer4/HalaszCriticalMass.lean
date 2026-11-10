/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local combination of the proved analytic Halasz mollifier moment and zeta
fourth moment in the actual compact zero detector.
-/
module
public import Legendre.Layer4.HalaszMollifierMoment

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory
open scoped BigOperators ArithmeticFunction.Moebius

/-- The actual critical mass now has the improved, cardinality-sensitive moment. -/
theorem packed_critical_mass_halasz :
    ∃ C : ℝ, 0 < C ∧ ∀ X J : ℕ, 1 ≤ X → X ≤ 2^J → ∀ T : ℝ, 2 ≤ T →
      ∀ {ι : Type*} (S : Finset ι) (t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, Detector.Smooth.criticalMass X (t i))^4 ≤
        C*(S.card : ℝ)*T*(Real.log T)^6*(halaszMollifierMomentBound X J T S.card)^2 := by
  obtain ⟨C4,hC4,hfourth⟩ := packed_zeta_fourth_moment
  let K := 1+∫ u : ℝ, Detector.Smooth.criticalWeight u
  have hK : 0 < K := by
    have hn : 0 ≤ ∫ u : ℝ, Detector.Smooth.criticalWeight u :=
      integral_nonneg Detector.Smooth.criticalWeight_nonneg
    dsimp [K]
    linarith
  refine ⟨K^3*C4,by positivity,?_⟩
  intro X J hX hcover T hT ι S t ht hs
  obtain ⟨hi4,hb4⟩ := hfourth T hT S t ht hs
  obtain ⟨hiM,hbM⟩ := packed_mollifier_halasz S t X J hX hcover T hT ht hs
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
  have hweight : (∑ i ∈ S, ∫ v : ℝ, w i v) ≤ (S.card : ℝ)*K := by
    dsimp [w]
    simp_rw [criticalWeight_shift_integral]
    simp only [Finset.sum_const,nsmul_eq_mul]
    apply mul_le_mul_of_nonneg_left _ (Nat.cast_nonneg _)
    dsimp [K]
    linarith
  have hf0 : 0 ≤ ∑ i ∈ S, ∫ v : ℝ, w i v*f v^4 :=
    Finset.sum_nonneg (fun i _ => integral_nonneg (fun v =>
      mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (by positivity)))
  have hg0 : 0 ≤ ∑ i ∈ S, ∫ v : ℝ, w i v*g v^2 :=
    Finset.sum_nonneg (fun i _ => integral_nonneg (fun v =>
      mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (sq_nonneg _)))
  have hM0 := halaszMollifierMomentBound_nonneg X J hX T (S.card : ℝ) (by linarith) (Nat.cast_nonneg _)
  have hM : (∑ i ∈ S, ∫ v : ℝ, w i v*g v^2) ≤ K*halaszMollifierMomentBound X J T S.card := by
    apply hbM.trans
    apply mul_le_mul_of_nonneg_right _ hM0
    dsimp [K]
    linarith
  have hWM := mul_le_mul hweight hb4 hf0 (show 0 ≤ (S.card : ℝ)*K by positivity)
  have hMsq := pow_le_pow_left₀ hg0 hM 2
  simp_rw [criticalMass_eq_shift]
  apply hpow.trans
  calc
    _ ≤ ((S.card : ℝ)*K)*(C4*T*(Real.log T)^6)*
        (K*halaszMollifierMomentBound X J T S.card)^2 :=
      mul_le_mul hWM hMsq (sq_nonneg _) (by positivity)
    _ = _ := by ring

end Legendre.Density.Moment
