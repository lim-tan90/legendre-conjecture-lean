/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PNT.StrongPNT
public import Mathlib.NumberTheory.Chebyshev
public import Mathlib.Analysis.SpecialFunctions.Sqrt
public import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
public import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics

@[expose] public section

open Filter Topology Asymptotics Real MeasureTheory Set intervalIntegral

namespace Legendre.PNT

/-- The classical de la Vallée Poussin error scale. -/
noncomputable def classicalError (c x : ℝ) : ℝ := x * exp (-c * sqrt (log x))

/-- Prime counting on real arguments uses the natural floor. -/
noncomputable def primeCount (x : ℝ) : ℝ := Nat.primeCounting ⌊x⌋₊

/-- Offset logarithmic integral; its lower endpoint is 2. -/
noncomputable def logarithmicIntegral (x : ℝ) : ℝ := ∫ t in 2..x, 1 / log t

noncomputable def classicalErrorDeriv (c x : ℝ) : ℝ :=
  exp (-c * sqrt (log x)) * (1 - c / (2 * sqrt (log x)))

theorem classicalError_hasDerivAt (c : ℝ) {x : ℝ} (hx : 1 < x) :
    HasDerivAt (classicalError c) (classicalErrorDeriv c x) x := by
  have hl := Real.log_pos hx
  have h := (hasDerivAt_id x).mul
    ((((Real.hasDerivAt_sqrt hl.ne').comp x (Real.hasDerivAt_log (by linarith))).const_mul (-c)).exp)
  convert h using 1
  · rfl
  · dsimp [classicalErrorDeriv]
    field_simp
    ring

theorem sqrt_le_classicalError {c x : ℝ} (hx : 1 < x)
    (hc : 2 * c ≤ sqrt (log x)) : sqrt x ≤ classicalError c x := by
  have hl : 0 ≤ log x := (log_pos hx).le
  have hs := mul_le_mul_of_nonneg_right hc (sqrt_nonneg (log x))
  rw [mul_assoc, mul_self_sqrt hl] at hs
  rw [classicalError, ← exp_log (by linarith : 0 < x), ← exp_add]
  rw [sqrt_eq_rpow, rpow_def_of_pos (exp_pos _), log_exp]
  apply exp_le_exp.mpr
  nlinarith

theorem exp_le_two_mul_classicalErrorDeriv {c x : ℝ} (hx : 1 < x)
    (hc : 2 * c ≤ sqrt (log x)) :
    exp (-c * sqrt (log x)) ≤ 2 * classicalErrorDeriv c x := by
  have hs : 0 < sqrt (log x) := sqrt_pos.2 (log_pos hx)
  have hdiv : c / (2 * sqrt (log x)) ≤ 1 / 2 := by
    rw [div_le_div_iff₀ (by positivity) (by norm_num)]
    linarith
  dsimp [classicalErrorDeriv]
  nlinarith [exp_pos (-c * sqrt (log x))]

theorem eventually_classicalError_bounds (c : ℝ) :
    ∀ᶠ x : ℝ in atTop, 2 ≤ x ∧ 1 ≤ log x ∧ 2 * c ≤ sqrt (log x) := by
  have hs : Tendsto (fun x : ℝ => sqrt (log x)) atTop atTop :=
    tendsto_sqrt_atTop.comp tendsto_log_atTop
  filter_upwards [eventually_ge_atTop 2, tendsto_log_atTop.eventually_ge_atTop 1,
    hs.eventually_ge_atTop (2*c)] with x hx hl hs
  exact ⟨hx, hl, hs⟩

theorem classicalError_eventually_ge_one (c : ℝ) :
    ∀ᶠ x : ℝ in atTop, 1 ≤ classicalError c x := by
  filter_upwards [eventually_classicalError_bounds c] with x hx
  exact (Real.one_le_sqrt.2 (by linarith)).trans
    (sqrt_le_classicalError (by linarith) hx.2.2)

theorem logarithmicIntegral_eq {x : ℝ} (hx : 2 ≤ x) :
    logarithmicIntegral x = x / log x - 2 / log 2 + ∫ t in 2..x, 1 / log t ^ 2 := by
  have hn {t : ℝ} (ht : t ∈ uIcc 2 x) : t ≠ 0 := by
    rw [uIcc_of_le hx] at ht
    linarith [ht.1]
  have hi : IntervalIntegrable (fun t : ℝ => -(1 / t) / log t ^ 2) volume 2 x := by
    apply ContinuousOn.intervalIntegrable
    intro t ht
    rw [uIcc_of_le hx] at ht
    have : log t ≠ 0 := (log_pos (by linarith [ht.1] : 1 < t)).ne'
    exact ((continuousAt_const.div continuousAt_id (hn (by rwa [uIcc_of_le hx]))).neg.div
      ((Real.continuousAt_log (hn (by rwa [uIcc_of_le hx]))).pow 2) (pow_ne_zero 2 this)).continuousWithinAt
  rw [logarithmicIntegral, funext fun t => (mul_one (1 / log t)).symm,
    intervalIntegral.integral_mul_deriv_eq_deriv_mul (u := fun t => 1 / log t)
      (u' := fun t => -(1 / t) / log t ^ 2) _ (fun t _ => hasDerivAt_id' t) hi
      intervalIntegrable_const]
  · have he : (∫ t in 2..x, -(1 / t) / log t ^ 2 * t) =
        ∫ t in 2..x, -(1 / log t ^ 2) := by
      apply intervalIntegral.integral_congr
      intro t ht
      field_simp [hn ht]
    rw [he, intervalIntegral.integral_neg]
    ring
  · intro t ht
    simpa using! (HasDerivAt.inv (Real.hasDerivAt_log (hn ht))
      ((log_pos (by rw [uIcc_of_le hx] at ht; linarith [ht.1] : 1 < t)).ne'))


/-- The exact Abel-summation identity for the prime-counting error. -/
theorem primeCount_sub_logarithmicIntegral {x : ℝ} (hx : 2 ≤ x) :
    primeCount x - logarithmicIntegral x = (Chebyshev.theta x - x) / log x +
      2 / log 2 + ∫ t in 2..x, (Chebyshev.theta t - t) / (t * log t ^ 2) := by
  have hi : IntervalIntegrable (fun t : ℝ => t / (t * log t ^ 2)) volume 2 x := by
    apply ContinuousOn.intervalIntegrable
    intro t ht
    rw [uIcc_of_le hx] at ht
    have hn : t ≠ 0 := by linarith [ht.1]
    have hl : log t ≠ 0 := (log_pos (by linarith [ht.1])).ne'
    exact (continuousAt_id.div (continuousAt_id.mul ((continuousAt_log hn).pow 2))
      (mul_ne_zero hn (pow_ne_zero 2 hl))).continuousWithinAt
  have hθ : IntervalIntegrable (fun t : ℝ => Chebyshev.theta t / (t * log t ^ 2))
      volume 2 x := by
    rw [intervalIntegrable_iff_integrableOn_Icc_of_le hx]
    exact Chebyshev.integrableOn_theta_div_id_mul_log_sq x
  rw [primeCount, Chebyshev.primeCounting_eq_theta_div_log_add_integral hx,
    logarithmicIntegral_eq hx]
  simp_rw [sub_div]
  rw [intervalIntegral.integral_sub hθ hi]
  have he : (∫ t in 2..x, t / (t * log t ^ 2)) = ∫ t in 2..x, 1 / log t ^ 2 := by
    apply intervalIntegral.integral_congr
    intro t ht
    rw [uIcc_of_le hx] at ht
    field_simp [show t ≠ 0 by linarith [ht.1]]
  rw [he]
  ring

theorem theta_error_intervalIntegrable {a b : ℝ} (ha : 2 ≤ a) (hab : a ≤ b) :
    IntervalIntegrable (fun t : ℝ => (Chebyshev.theta t - t) / (t * log t ^ 2))
      volume a b := by
  have hc : ContinuousOn (fun t : ℝ => (t * log t ^ 2)⁻¹) (uIcc a b) := by
    intro t ht
    rw [uIcc_of_le hab] at ht
    have hn : t ≠ 0 := by linarith [ht.1]
    have hl : log t ≠ 0 := (log_pos (by linarith [ht.1])).ne'
    exact ((continuousAt_id.mul ((continuousAt_log hn).pow 2)).inv₀
      (mul_ne_zero hn (pow_ne_zero 2 hl))).continuousWithinAt
  simpa only [div_eq_mul_inv] using
    (Chebyshev.theta_mono.intervalIntegrable.sub intervalIntegral.intervalIntegrable_id).mul_continuousOn hc

/-- Partial summation preserves the classical exponential error scale. -/
theorem primeCount_error_of_theta {c : ℝ}
    (hθ : (fun x : ℝ => Chebyshev.theta x - x) =O[atTop] classicalError c) :
    (fun x : ℝ => primeCount x - logarithmicIntegral x) =O[atTop] classicalError c := by
  obtain ⟨C, hC, hbound⟩ := isBigO_iff'.1 hθ
  obtain ⟨a, ha⟩ := eventually_atTop.1 (hbound.and (eventually_classicalError_bounds c))
  have ha2 : 2 ≤ a := (ha a le_rfl).2.1
  let K : ℝ := |2 / log 2 + ∫ t in 2..a, (Chebyshev.theta t - t) / (t * log t ^ 2)|
  refine IsBigO.of_bound (3*C + K) ?_
  filter_upwards [eventually_ge_atTop a] with x hax
  have hx2 : 2 ≤ x := ha2.trans hax
  have hdata := (ha x hax).2
  have hfx : 1 ≤ classicalError c x :=
    (one_le_sqrt.2 (by linarith)).trans (sqrt_le_classicalError (by linarith) hdata.2.2)
  have hfpos : 0 ≤ classicalError c x := by linarith
  have hterminal : |(Chebyshev.theta x - x) / log x| ≤ C * classicalError c x := by
    rw [abs_div, abs_of_pos (log_pos (by linarith : 1 < x))]
    apply (div_le_self (abs_nonneg _) hdata.2.1).trans
    simpa only [Real.norm_eq_abs, abs_of_nonneg hfpos] using (ha x hax).1
  have hderiv : ∀ t ∈ uIcc a x, HasDerivAt (classicalError c) (classicalErrorDeriv c t) t := by
    intro t ht
    rw [uIcc_of_le hax] at ht
    exact classicalError_hasDerivAt c (by linarith [ht.1])
  have hderivInt : IntervalIntegrable (classicalErrorDeriv c) volume a x := by
    apply ContinuousOn.intervalIntegrable
    intro t ht
    rw [uIcc_of_le hax] at ht
    have ht1 : 1 < t := by linarith [ht.1]
    have hs : sqrt (log t) ≠ 0 := (sqrt_pos.2 (log_pos ht1)).ne'
    unfold classicalErrorDeriv
    have hn : t ≠ 0 := by linarith
    have hden : 2 * sqrt (log t) ≠ 0 := mul_ne_zero (by norm_num) hs
    have hscont : ContinuousAt (fun t : ℝ => sqrt (log t)) t :=
      continuous_sqrt.continuousAt.comp (continuousAt_log hn)
    have hccont : ContinuousAt (fun t : ℝ => exp (-c * sqrt (log t))) t :=
      Real.continuous_exp.continuousAt.comp (continuousAt_const.mul hscont)
    exact (hccont.mul (continuousAt_const.sub
      (continuousAt_const.div (continuousAt_const.mul hscont) hden))).continuousWithinAt
  have hint : |∫ t in a..x, (Chebyshev.theta t - t) / (t * log t ^ 2)| ≤
      2*C * classicalError c x := by
    calc
      _ ≤ ∫ t in a..x, |(Chebyshev.theta t - t) / (t * log t ^ 2)| :=
        intervalIntegral.abs_integral_le_integral_abs hax
      _ ≤ ∫ t in a..x, 2*C * classicalErrorDeriv c t := by
        apply intervalIntegral.integral_mono_on hax (theta_error_intervalIntegrable ha2 hax).abs
          (hderivInt.const_mul _) ?_
        intro t ht
        have hd := ha t ht.1
        have htpos : 0 < t := by linarith [ht.1]
        have hft : 0 ≤ classicalError c t := by unfold classicalError; positivity
        have hb : |Chebyshev.theta t - t| ≤ C * classicalError c t := by
          simpa only [Real.norm_eq_abs, abs_of_nonneg hft] using hd.1
        have hl : 1 ≤ log t ^ 2 := one_le_pow₀ hd.2.2.1
        have hdpos : 0 < t * log t ^ 2 := by positivity
        rw [abs_div, abs_of_pos hdpos]
        calc
          _ ≤ C * classicalError c t / (t * log t ^ 2) := div_le_div_of_nonneg_right hb hdpos.le
          _ = C * exp (-c * sqrt (log t)) / log t ^ 2 := by unfold classicalError; field_simp
          _ ≤ C * exp (-c * sqrt (log t)) := div_le_self (by positivity) hl
          _ ≤ 2*C * classicalErrorDeriv c t := by
            have := mul_le_mul_of_nonneg_left (exp_le_two_mul_classicalErrorDeriv
              (by linarith [ht.1] : 1 < t) hd.2.2.2) hC.le
            linarith
      _ = 2*C * (classicalError c x - classicalError c a) := by
        rw [intervalIntegral.integral_const_mul,
          intervalIntegral.integral_eq_sub_of_hasDerivAt hderiv hderivInt]
      _ ≤ 2*C * classicalError c x := by
        have : 0 ≤ classicalError c a := by unfold classicalError; positivity
        nlinarith
  rw [primeCount_sub_logarithmicIntegral hx2,
    ← intervalIntegral.integral_add_adjacent_intervals
      (theta_error_intervalIntegrable (by norm_num) ha2) (theta_error_intervalIntegrable ha2 hax)]
  rw [Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg hfpos]
  calc
    _ ≤ |(Chebyshev.theta x - x) / log x| + K +
        |∫ t in a..x, (Chebyshev.theta t - t) / (t * log t ^ 2)| := by
      dsimp [K]
      rw [show (Chebyshev.theta x - x) / log x + 2 / log 2 +
          ((∫ t in 2..a, (Chebyshev.theta t - t) / (t * log t ^ 2)) +
          ∫ t in a..x, (Chebyshev.theta t - t) / (t * log t ^ 2)) =
          ((Chebyshev.theta x - x) / log x +
          (2 / log 2 + ∫ t in 2..a, (Chebyshev.theta t - t) / (t * log t ^ 2))) +
          ∫ t in a..x, (Chebyshev.theta t - t) / (t * log t ^ 2) by ring]
      exact (abs_add_le _ _).trans (add_le_add (abs_add_le _ _) le_rfl)
    _ ≤ (3*C + K) * classicalError c x := by
      have hK : 0 ≤ K := abs_nonneg _
      nlinarith [mul_le_mul_of_nonneg_left hfx hK]


/-- The main analytic input, ported from PNT+ at the revision recorded in each source file. -/
theorem psi_classical_error : ∃ c > 0,
    (fun x : ℝ => Chebyshev.psi x - x) =O[atTop] classicalError c := by
  obtain ⟨c, hc, h⟩ := _root_.StrongPNT
  refine ⟨c, hc, ?_⟩
  convert! h using 1
  ext x
  simp [classicalError, sqrt_eq_rpow]

/-- The elementary prime-power contribution is absorbed in the classical error. -/
theorem sqrt_isBigO_classicalError (c : ℝ) : sqrt =O[atTop] classicalError c := by
  apply IsBigO.of_bound 1
  filter_upwards [eventually_classicalError_bounds c] with x hx
  rw [one_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg (sqrt_nonneg x),
    abs_of_nonneg (show 0 ≤ classicalError c x by unfold classicalError; exact mul_nonneg (by linarith [hx.1]) (exp_pos _).le)]
  exact sqrt_le_classicalError (by linarith) hx.2.2

/-- ψ, θ and π have a common classical de la Vallée Poussin error scale. -/
theorem pnt_classical_error : ∃ c > 0,
    ((fun x : ℝ => Chebyshev.psi x - x) =O[atTop] classicalError c) ∧
    ((fun x : ℝ => Chebyshev.theta x - x) =O[atTop] classicalError c) ∧
    ((fun x : ℝ => primeCount x - logarithmicIntegral x) =O[atTop] classicalError c) := by
  obtain ⟨c, hc, hψ⟩ := psi_classical_error
  have hθ : (fun x : ℝ => Chebyshev.theta x - x) =O[atTop] classicalError c := by
    have h := hψ.sub (Chebyshev.isBigO_psi_sub_theta_sqrt.trans (sqrt_isBigO_classicalError c))
    convert h using 1
    ext x
    simp only [Pi.sub_apply]
    ring
  exact ⟨c, hc, hψ, hθ, primeCount_error_of_theta hθ⟩

/-- An equivalent eventual inequality, with one positive coefficient for ψ and π.
The decay constant and threshold are existential, not numerically certified. -/
theorem pnt_eventual_bound : ∃ c > 0, ∃ C > 0, ∃ x₀ : ℝ, ∀ x ≥ x₀,
    |Chebyshev.psi x - x| ≤ C * classicalError c x ∧
    |primeCount x - logarithmicIntegral x| ≤ C * classicalError c x := by
  obtain ⟨c, hc, hψ, _, hπ⟩ := pnt_classical_error
  obtain ⟨Cψ, hCψ, hbψ⟩ := isBigO_iff'.1 hψ
  obtain ⟨Cπ, hCπ, hbπ⟩ := isBigO_iff'.1 hπ
  obtain ⟨x₀, hx₀⟩ := eventually_atTop.1
    (hbψ.and (hbπ.and (classicalError_eventually_ge_one c)))
  refine ⟨c, hc, Cψ+Cπ, by linarith, x₀, fun x hx => ?_⟩
  have h := hx₀ x hx
  have hf : 0 ≤ classicalError c x := by linarith [h.2.2]
  rw [Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg hf] at h
  constructor
  · exact h.1.trans (by nlinarith)
  · exact h.2.1.trans (by nlinarith)


/-- The classical error is sublinear, so these are prime number theorems. -/
theorem classicalError_isLittleO {c : ℝ} (hc : 0 < c) :
    classicalError c =o[atTop] (fun x : ℝ => x) := by
  apply (isLittleO_iff_tendsto' (by filter_upwards [] with x hx; simp [hx, classicalError])).2
  have he : Tendsto (fun x : ℝ => exp (-c * sqrt (log x))) atTop (𝓝 0) :=
    Real.tendsto_exp_atBot.comp
      ((tendsto_sqrt_atTop.comp tendsto_log_atTop).const_mul_atTop_of_neg (by linarith : -c < 0))
  apply he.congr'
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
  dsimp [classicalError]
  field_simp

/-- The finite-height contour formula uses a proved logarithmic zero-free strip.
The five contour/tail terms are kept exactly; no zero-sum formula is asserted here. -/
theorem exists_smoothed_truncated_formula : ∃ A ∈ Ioc (0 : ℝ) (1/2),
    ∀ (T : ℝ), 3 ≤ T → ∀ (SmoothingF : ℝ → ℝ) (ε X : ℝ),
      0 < ε → ε < 1 → 3 < X →
      Function.support SmoothingF ⊆ Icc (1/2) 2 →
      (∀ x > 0, 0 ≤ SmoothingF x) →
      (∫ x in Ioi 0, SmoothingF x / x) = 1 →
      ContDiff ℝ 1 SmoothingF →
      SmoothedChebyshev SmoothingF ε X =
        mellin (fun x => (Smooth1 SmoothingF ε x : ℂ)) 1 * X +
        (I₁ SmoothingF ε X T - I₂ SmoothingF ε T X (1-A/log T) +
        I₃₇ SmoothingF ε T X (1-A/log T) +
        I₈ SmoothingF ε T X (1-A/log T) + I₉ SmoothingF ε X T) := by
  obtain ⟨A, C, _, hA, _, hholo⟩ := LogDerivZetaBoundedAndHolo12
  refine ⟨A, hA, fun T hT SmoothingF ε X hε hε1 hX hs hn hm hd => ?_⟩
  have hl : 1 < log T := logt_gt_one hT
  have hquot : 0 < A / log T := div_pos hA.1 (by linarith)
  have hquot1 : A / log T < 1 := (div_lt_one (by linarith)).2 (by linarith [hA.2])
  have hh : HolomorphicOn (deriv riemannZeta / riemannZeta)
      ((Icc (1-A/log T) 2) ×ℂ (Icc (-T) T) \ {1}) := by
    simpa only [rpow_one, Pi.div_apply] using! hholo T hT
  have h := SmoothedChebyshevPull1 hε hε1 X hX (by linarith : 0 < T)
    (by linarith : 0 < 1-A/log T) (by linarith : 1-A/log T < 1) hh hs hn hm hd
  rw [h]
  ring

end Legendre.PNT
