/-
Copyright (c) 2026 S. McColm.
Released under MIT-0; retained license: licenses/smccolm-Lean-MIT-0.txt. Adapted from smccolm/Lean commit
4c8fb7f7816508825089230e3730b69165e5e303: GuthMaynard/VanDerCorput.lean
(Kusmin--Landau core), TerminalTypeI.lean (logarithmic prefix bound only),
ClassicalLargeValues.lean (unit-annulus packing and its private helper only).
Lean 4.35.0 module/import/namespace adaptation. No classical zero-detector or
terminal zeta input is imported.
-/
module
public import Mathlib.Analysis.Calculus.Deriv.MeanValue
public import Mathlib.Analysis.SpecialFunctions.Complex.Log
public import Mathlib.Analysis.SpecialFunctions.Pow.Complex
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Cotangent
public import Mathlib.Algebra.Order.Chebyshev
public import Mathlib.Analysis.InnerProductSpace.Basic
public import Legendre.Layer4.GuthMaynard.HeathBrown
public import Mathlib.Analysis.Real.Pi.Bounds
@[expose] public section
open Complex Finset Set
open scoped BigOperators InnerProductSpace
namespace Legendre.Density.GuthMaynard

noncomputable def unitaryPhase (x : ℝ) : ℂ := Complex.exp (Complex.I * x)

/-- The resolvent appearing in summation by parts for a unitary phase. -/
noncomputable def phaseResolvent (x : ℝ) : ℂ := (1 - unitaryPhase x)⁻¹

@[simp] theorem norm_unitaryPhase (x : ℝ) : ‖unitaryPhase x‖ = 1 := by
  simp [unitaryPhase]

theorem unitaryPhase_add (x y : ℝ) :
    unitaryPhase (x + y) = unitaryPhase x * unitaryPhase y := by
  simp only [unitaryPhase, ofReal_add, mul_add, Complex.exp_add]

theorem unitaryPhase_sub (x y : ℝ) :
    unitaryPhase (x - y) = unitaryPhase x * starRingEnd ℂ (unitaryPhase y) := by
  rw [sub_eq_add_neg, unitaryPhase_add]
  simp only [unitaryPhase, ofReal_neg, mul_neg]
  rw [← Complex.exp_conj]
  congr 1
  simp

/-- A finite exponential sum on the half-open integer interval `[A, B)`. -/
noncomputable def phaseSum (f : ℝ → ℝ) (A B : ℕ) : ℂ :=
  ∑ n ∈ Ico A B, unitaryPhase (f n)

/-- The logarithmic phase occurring in `n ^ (-it)`. -/
noncomputable def logarithmicPhase (t x : ℝ) : ℝ := -t * Real.log x

/-- The unweighted logarithmic exponential sum on `[A, B)`. -/
noncomputable def logarithmicSum (t : ℝ) (A B : ℕ) : ℂ :=
  phaseSum (logarithmicPhase t) A B

theorem unitaryPhase_logarithmicPhase_eq_cpow (t : ℝ) (n : ℕ) (hn : 0 < n) :
    unitaryPhase (logarithmicPhase t n) = (n : ℂ) ^ (-(t : ℂ) * I) := by
  rw [Complex.cpow_def_of_ne_zero (by exact_mod_cast Nat.ne_of_gt hn)]
  simp only [unitaryPhase, logarithmicPhase, Complex.natCast_log, ofReal_neg,
    ofReal_mul]
  congr 1
  ring

theorem logarithmicSum_eq_cpow (t : ℝ) (A B : ℕ) (hA : 0 < A) :
    logarithmicSum t A B = ∑ n ∈ Ico A B, (n : ℂ) ^ (-(t : ℂ) * I) := by
  unfold logarithmicSum phaseSum
  apply Finset.sum_congr rfl
  intro n hn
  exact unitaryPhase_logarithmicPhase_eq_cpow t n (hA.trans_le (mem_Ico.mp hn).1)

theorem norm_phaseSum_le_card (f : ℝ → ℝ) (A B : ℕ) :
    ‖phaseSum f A B‖ ≤ (Finset.Ico A B).card := by
  calc
    ‖phaseSum f A B‖ ≤ ∑ n ∈ Finset.Ico A B, ‖unitaryPhase (f n)‖ := norm_sum_le _ _
    _ = (Finset.Ico A B).card := by simp

theorem norm_logarithmicSum_le_length (t : ℝ) (A B : ℕ) :
    ‖logarithmicSum t A B‖ ≤ ((B - A : ℕ) : ℝ) := by
  simpa [logarithmicSum, Nat.card_Ico] using norm_phaseSum_le_card (logarithmicPhase t) A B

/-! ## Kusmin--Landau cancellation -/

/-- Exact cotangent expression for the phase resolvent. -/
theorem phaseResolvent_eq (x : ℝ) (hs : Real.sin (x / 2) ≠ 0) :
    phaseResolvent x = (1 : ℂ) / 2 + Complex.I * (Real.cot (x / 2) / 2 : ℝ) := by
  have hden : (1 - unitaryPhase x : ℂ) ≠ 0 := by
    intro h
    have hn : ‖(1 - unitaryPhase x : ℂ)‖ = ‖(2 * Real.sin (x / 2) : ℝ)‖ := by
      rw [← norm_neg, neg_sub]
      exact Complex.norm_exp_I_mul_ofReal_sub_one x
    rw [h, norm_zero] at hn
    have : (2 * Real.sin (x / 2) : ℝ) = 0 := norm_eq_zero.mp hn.symm
    exact hs (by linarith)
  rw [phaseResolvent]
  apply (mul_eq_one_iff_inv_eq₀ hden).mp
  have hcot := Complex.cot_eq_exp_ratio ((x / 2 : ℝ) : ℂ)
  rw [← Complex.ofReal_cot] at hcot
  simp only [Complex.ofReal_div, Complex.ofReal_ofNat] at hcot
  rw [show (2 : ℂ) * Complex.I * ((x : ℂ) / 2) = Complex.I * x by ring_nf] at hcot
  have hdenexp : (1 - Complex.exp (Complex.I * x) : ℂ) ≠ 0 := by
    simpa only [unitaryPhase] using hden
  rw [eq_div_iff (mul_ne_zero Complex.I_ne_zero hdenexp)] at hcot
  rw [unitaryPhase]
  push_cast at hcot ⊢
  ring_nf at hcot ⊢
  linear_combination (1 / 2 : ℂ) * hcot

/-- Derivative of real cotangent on its fundamental open interval. -/
theorem hasDerivAt_real_cot {x : ℝ} (hx : x ∈ Set.Ioo 0 Real.pi) :
    HasDerivAt Real.cot (-(1 / Real.sin x ^ 2)) x := by
  have hsin : Real.sin x ≠ 0 := (Real.sin_pos_of_pos_of_lt_pi hx.1 hx.2).ne'
  have hquot := (Real.hasDerivAt_cos x).div (Real.hasDerivAt_sin x) hsin
  convert hquot using 1
  · funext y
    simp [Real.cot_eq_cos_div_sin]
  · field_simp [hsin]
    nlinarith [Real.sin_sq_add_cos_sq x]

/-- Cotangent is strictly decreasing between its consecutive poles at `0` and `π`. -/
theorem strictAntiOn_real_cot : StrictAntiOn Real.cot (Set.Ioo 0 Real.pi) := by
  apply strictAntiOn_of_deriv_neg (convex_Ioo (0 : ℝ) Real.pi)
  · intro x hx
    exact (hasDerivAt_real_cot hx).continuousAt.continuousWithinAt
  · intro x hx
    rw [interior_Ioo] at hx
    rw [(hasDerivAt_real_cot hx).deriv]
    have hs : 0 < Real.sin x := Real.sin_pos_of_pos_of_lt_pi hx.1 hx.2
    have : 0 < 1 / Real.sin x ^ 2 := by positivity
    linarith

/-- Jordan's inequality, reflected about `π / 2`, in the form needed to stay
away from both endpoints of a full phase period. -/
theorem sin_half_lower {δ θ : ℝ} (hδ : 0 ≤ δ) (hθlow : δ ≤ θ)
    (hθhigh : θ ≤ 2 * Real.pi - δ) :
    δ / Real.pi ≤ Real.sin (θ / 2) := by
  by_cases hθ : θ ≤ Real.pi
  · have harg0 : 0 ≤ θ / 2 := by linarith
    have harg1 : θ / 2 ≤ Real.pi / 2 := by linarith
    have hJ := Real.mul_le_sin harg0 harg1
    calc
      δ / Real.pi ≤ θ / Real.pi :=
        (div_le_div_iff_of_pos_right Real.pi_pos).mpr hθlow
      _ = 2 / Real.pi * (θ / 2) := by ring_nf
      _ ≤ Real.sin (θ / 2) := hJ
  · have hθpi : Real.pi ≤ θ := le_of_not_ge hθ
    have harg0 : 0 ≤ Real.pi - θ / 2 := by linarith
    have harg1 : Real.pi - θ / 2 ≤ Real.pi / 2 := by linarith
    have hJ := Real.mul_le_sin harg0 harg1
    rw [Real.sin_pi_sub] at hJ
    calc
      δ / Real.pi ≤ (2 * Real.pi - θ) / Real.pi :=
        (div_le_div_iff_of_pos_right Real.pi_pos).mpr (by linarith)
      _ = 2 / Real.pi * (Real.pi - θ / 2) := by ring_nf
      _ ≤ Real.sin (θ / 2) := hJ

/-- Quantitative norm bound for the phase resolvent away from the endpoints
of a full period. -/
theorem norm_phaseResolvent_le {δ θ : ℝ} (hδ : 0 < δ) (hθlow : δ ≤ θ)
    (hθhigh : θ ≤ 2 * Real.pi - δ) :
    ‖phaseResolvent θ‖ ≤ Real.pi / (2 * δ) := by
  have hsin := sin_half_lower hδ.le hθlow hθhigh
  have hsinPos : 0 < Real.sin (θ / 2) := lt_of_lt_of_le (div_pos hδ Real.pi_pos) hsin
  have hden : 2 * δ / Real.pi ≤ ‖(1 - unitaryPhase θ : ℂ)‖ := by
    rw [← norm_neg, neg_sub, unitaryPhase,
      Complex.norm_exp_I_mul_ofReal_sub_one, Real.norm_eq_abs,
      abs_of_pos (mul_pos zero_lt_two hsinPos)]
    convert mul_le_mul_of_nonneg_left hsin zero_le_two using 1
    ring_nf
  rw [phaseResolvent, norm_inv, ← one_div]
  calc
    1 / ‖(1 - unitaryPhase θ : ℂ)‖ ≤ 1 / (2 * δ / Real.pi) :=
      one_div_le_one_div_of_le (div_pos (mul_pos zero_lt_two hδ) Real.pi_pos) hden
    _ = Real.pi / (2 * δ) := by field_simp

/-- Exact variation of the phase resolvent between two ordered angles in one period. -/
theorem norm_phaseResolvent_sub_eq {x y : ℝ}
    (hx0 : 0 < x) (hy2pi : y < 2 * Real.pi) (hxy : x ≤ y) :
    ‖phaseResolvent y - phaseResolvent x‖ =
      (Real.cot (x / 2) - Real.cot (y / 2)) / 2 := by
  have hxmem : x / 2 ∈ Set.Ioo (0 : ℝ) Real.pi := by constructor <;> linarith
  have hymem : y / 2 ∈ Set.Ioo (0 : ℝ) Real.pi := by constructor <;> linarith
  have hsinx : Real.sin (x / 2) ≠ 0 :=
    (Real.sin_pos_of_pos_of_lt_pi hxmem.1 hxmem.2).ne'
  have hsiny : Real.sin (y / 2) ≠ 0 :=
    (Real.sin_pos_of_pos_of_lt_pi hymem.1 hymem.2).ne'
  have hcot : Real.cot (y / 2) ≤ Real.cot (x / 2) :=
    strictAntiOn_real_cot.antitoneOn hxmem hymem (by linarith)
  rw [phaseResolvent_eq y hsiny, phaseResolvent_eq x hsinx]
  have heq :
      (1 / 2 + Complex.I * (Real.cot (y / 2) / 2 : ℝ) : ℂ) -
          (1 / 2 + Complex.I * (Real.cot (x / 2) / 2 : ℝ) : ℂ) =
        Complex.I * ((Real.cot (y / 2) - Real.cot (x / 2)) / 2 : ℝ) := by
    push_cast
    ring_nf
  rw [heq, norm_mul, norm_I, one_mul, norm_real, Real.norm_eq_abs,
    abs_of_nonpos (by linarith)]
  ring_nf

/-- Total variation of resolvents for an increasing sequence of angles in one period. -/
theorem phaseResolvent_variation (θ : ℕ → ℝ) (N : ℕ) (δ : ℝ)
    (hδ : 0 < δ)
    (hlow : ∀ n ≤ N, δ ≤ θ n)
    (hhigh : ∀ n ≤ N, θ n ≤ 2 * Real.pi - δ)
    (hmono : ∀ n < N, θ n ≤ θ (n + 1)) :
    ∑ n ∈ Finset.range N, ‖phaseResolvent (θ (n + 1)) - phaseResolvent (θ n)‖ =
      (Real.cot (θ 0 / 2) - Real.cot (θ N / 2)) / 2 := by
  calc
    ∑ n ∈ Finset.range N, ‖phaseResolvent (θ (n + 1)) - phaseResolvent (θ n)‖ =
        ∑ n ∈ Finset.range N,
          (Real.cot (θ n / 2) - Real.cot (θ (n + 1) / 2)) / 2 := by
      apply Finset.sum_congr rfl
      intro n hn
      have hnlt := Finset.mem_range.mp hn
      apply norm_phaseResolvent_sub_eq
      · exact hδ.trans_le (hlow n (by omega))
      · linarith [hhigh (n + 1) (by omega)]
      · exact hmono n hnlt
    _ = (Real.cot (θ 0 / 2) - Real.cot (θ N / 2)) / 2 := by
      rw [← Finset.sum_div, Finset.sum_range_sub']

/-- The cotangent component of the resolvent is controlled by its complex norm. -/
theorem abs_cot_half_le_norm_phaseResolvent {θ : ℝ}
    (hθ0 : 0 < θ) (hθ2pi : θ < 2 * Real.pi) :
    |Real.cot (θ / 2) / 2| ≤ ‖phaseResolvent θ‖ := by
  have hmem : θ / 2 ∈ Set.Ioo (0 : ℝ) Real.pi := by constructor <;> linarith
  have hsin : Real.sin (θ / 2) ≠ 0 :=
    (Real.sin_pos_of_pos_of_lt_pi hmem.1 hmem.2).ne'
  rw [phaseResolvent_eq θ hsin]
  let z : ℂ := (1 : ℂ) / 2 + Complex.I * (Real.cot (θ / 2) / 2 : ℝ)
  have him : z.im = Real.cot (θ / 2) / 2 := by
    dsimp only [z]
    rw [show (1 : ℂ) / 2 = ((1 / 2 : ℝ) : ℂ) by norm_num]
    simp only [Complex.add_im, Complex.ofReal_im, Complex.mul_im, Complex.I_re,
      Complex.I_im, zero_mul, one_mul, zero_add, Complex.ofReal_re]
  calc
    |Real.cot (θ / 2) / 2| = |z.im| := congrArg abs him.symm
    _ ≤ ‖z‖ := Complex.abs_im_le_norm z

/-- A single phase term written as a resolvent times a forward difference. -/
theorem unitaryPhase_resolvent_step (f : ℕ → ℝ) (n : ℕ)
    (hsin : Real.sin ((f (n + 1) - f n) / 2) ≠ 0) :
    unitaryPhase (f n) = phaseResolvent (f (n + 1) - f n) *
      (unitaryPhase (f n) - unitaryPhase (f (n + 1))) := by
  have hden : (1 - unitaryPhase (f (n + 1) - f n) : ℂ) ≠ 0 := by
    intro h
    have hn : ‖(1 - unitaryPhase (f (n + 1) - f n) : ℂ)‖ =
        ‖(2 * Real.sin ((f (n + 1) - f n) / 2) : ℝ)‖ := by
      rw [← norm_neg, neg_sub]
      exact Complex.norm_exp_I_mul_ofReal_sub_one (f (n + 1) - f n)
    rw [h, norm_zero] at hn
    have hz : (2 * Real.sin ((f (n + 1) - f n) / 2) : ℝ) = 0 :=
      norm_eq_zero.mp hn.symm
    exact hsin (by linarith)
  rw [show f (n + 1) = f n + (f (n + 1) - f n) by ring_nf,
    unitaryPhase_add, phaseResolvent]
  field_simp [hden]
  ring_nf

/-- Exact finite summation by parts for resolvents. -/
theorem finite_resolvent_telescoping (z q : ℕ → ℂ) (N : ℕ)
    (hrec : ∀ n ≤ N, z n = q n * (z n - z (n + 1))) :
    ∑ n ∈ Finset.range (N + 1), z n =
      q 0 * z 0 - q N * z (N + 1) +
        ∑ n ∈ Finset.range N, (q (n + 1) - q n) * z (n + 1) := by
  induction N with
  | zero =>
      simpa [mul_sub] using hrec 0 le_rfl
  | succ N ih =>
      calc
        ∑ n ∈ Finset.range (N + 1 + 1), z n =
            (∑ n ∈ Finset.range (N + 1), z n) + z (N + 1) := by
              rw [Finset.sum_range_succ]
        _ = (q 0 * z 0 - q N * z (N + 1) +
              ∑ n ∈ Finset.range N, (q (n + 1) - q n) * z (n + 1)) +
              z (N + 1) := by
                rw [ih (fun n hn => hrec n (hn.trans (Nat.le_succ N)))]
        _ = q 0 * z 0 - q (N + 1) * z (N + 1 + 1) +
              ∑ n ∈ Finset.range (N + 1), (q (n + 1) - q n) * z (n + 1) := by
                rw [Finset.sum_range_succ]
                linear_combination hrec (N + 1) le_rfl

/-- Norm form of finite resolvent summation by parts. -/
theorem norm_sum_le_resolvent_variation (z q : ℕ → ℂ) (N : ℕ)
    (hz : ∀ n ≤ N + 1, ‖z n‖ = 1)
    (hrec : ∀ n ≤ N, z n = q n * (z n - z (n + 1))) :
    ‖∑ n ∈ Finset.range (N + 1), z n‖ ≤
      ‖q 0‖ + ‖q N‖ + ∑ n ∈ Finset.range N, ‖q (n + 1) - q n‖ := by
  rw [finite_resolvent_telescoping z q N hrec]
  calc
    ‖q 0 * z 0 - q N * z (N + 1) +
        ∑ n ∈ Finset.range N, (q (n + 1) - q n) * z (n + 1)‖ ≤
        ‖q 0 * z 0 - q N * z (N + 1)‖ +
          ‖∑ n ∈ Finset.range N, (q (n + 1) - q n) * z (n + 1)‖ := norm_add_le _ _
    _ ≤ (‖q 0 * z 0‖ + ‖q N * z (N + 1)‖) +
          ∑ n ∈ Finset.range N, ‖(q (n + 1) - q n) * z (n + 1)‖ := by
      gcongr
      · exact norm_sub_le _ _
      · exact norm_sum_le _ _
    _ = ‖q 0‖ + ‖q N‖ + ∑ n ∈ Finset.range N, ‖q (n + 1) - q n‖ := by
      simp only [norm_mul]
      rw [hz 0 (by omega), hz (N + 1) (by omega), mul_one, mul_one]
      congr 1
      apply Finset.sum_congr rfl
      intro n hn
      rw [hz (n + 1) (by have := Finset.mem_range.mp hn; omega), mul_one]

/-- Kusmin--Landau cancellation while all phase increments remain in one
period and a fixed positive distance from its endpoints. -/
theorem kusminLandau_one_period (f : ℕ → ℝ) (N : ℕ) (δ : ℝ)
    (hδ : 0 < δ)
    (hlow : ∀ n ≤ N, δ ≤ f (n + 1) - f n)
    (hhigh : ∀ n ≤ N, f (n + 1) - f n ≤ 2 * Real.pi - δ)
    (hmono : ∀ n < N, f (n + 1) - f n ≤ f (n + 2) - f (n + 1)) :
    ‖∑ n ∈ Finset.range (N + 1), unitaryPhase (f n)‖ ≤
      2 * Real.pi / δ := by
  let θ : ℕ → ℝ := fun n => f (n + 1) - f n
  have hθlow : ∀ n ≤ N, δ ≤ θ n := hlow
  have hθhigh : ∀ n ≤ N, θ n ≤ 2 * Real.pi - δ := hhigh
  have hθmono : ∀ n < N, θ n ≤ θ (n + 1) := hmono
  have hθpos : ∀ n ≤ N, 0 < θ n := fun n hn => hδ.trans_le (hθlow n hn)
  have hθlt : ∀ n ≤ N, θ n < 2 * Real.pi := fun n hn => by
    linarith [hθhigh n hn]
  have hsin : ∀ n ≤ N, Real.sin (θ n / 2) ≠ 0 := fun n hn => by
    exact (Real.sin_pos_of_pos_of_lt_pi (by linarith [hθpos n hn])
      (by linarith [hθlt n hn])).ne'
  have hbase := norm_sum_le_resolvent_variation
    (fun n => unitaryPhase (f n)) (fun n => phaseResolvent (θ n)) N
    (fun n _hn => norm_unitaryPhase (f n))
    (fun n hn => unitaryPhase_resolvent_step f n (hsin n hn))
  rw [phaseResolvent_variation θ N δ hδ hθlow hθhigh hθmono] at hbase
  have hvar : (Real.cot (θ 0 / 2) - Real.cot (θ N / 2)) / 2 ≤
      ‖phaseResolvent (θ 0)‖ + ‖phaseResolvent (θ N)‖ := by
    have h0 := abs_cot_half_le_norm_phaseResolvent (hθpos 0 (by omega))
      (hθlt 0 (by omega))
    have hN := abs_cot_half_le_norm_phaseResolvent (hθpos N le_rfl) (hθlt N le_rfl)
    have hleft : Real.cot (θ 0 / 2) / 2 ≤ ‖phaseResolvent (θ 0)‖ :=
      (le_abs_self _).trans h0
    have hright : -(Real.cot (θ N / 2) / 2) ≤ ‖phaseResolvent (θ N)‖ :=
      (neg_le_abs _).trans hN
    linarith
  have hq0 := norm_phaseResolvent_le hδ (hθlow 0 (by omega)) (hθhigh 0 (by omega))
  have hqN := norm_phaseResolvent_le hδ (hθlow N le_rfl) (hθhigh N le_rfl)
  calc
    ‖∑ n ∈ Finset.range (N + 1), unitaryPhase (f n)‖ ≤
        ‖phaseResolvent (θ 0)‖ + ‖phaseResolvent (θ N)‖ +
          (Real.cot (θ 0 / 2) - Real.cot (θ N / 2)) / 2 := hbase
    _ ≤ 2 * (‖phaseResolvent (θ 0)‖ + ‖phaseResolvent (θ N)‖) := by linarith
    _ ≤ 2 * Real.pi / δ := by
      calc
        2 * (‖phaseResolvent (θ 0)‖ + ‖phaseResolvent (θ N)‖) ≤
            2 * (Real.pi / (2 * δ) + Real.pi / (2 * δ)) := by gcongr
        _ = 2 * Real.pi / δ := by
          field_simp
          norm_num

/-- A phase is unchanged by adding an integral multiple of its full period. -/
theorem unitaryPhase_int_mul_two_pi (k : ℤ) :
    unitaryPhase ((k : ℝ) * (2 * Real.pi)) = 1 := by
  rw [unitaryPhase]
  convert Complex.exp_int_mul_two_pi_mul_I k using 1
  push_cast
  ring_nf

/-- Subtracting an integral multiple of `2π` does not change a unitary phase. -/
theorem unitaryPhase_sub_int_mul_two_pi (x : ℝ) (k : ℤ) :
    unitaryPhase (x - (k : ℝ) * (2 * Real.pi)) = unitaryPhase x := by
  rw [unitaryPhase_sub, unitaryPhase_int_mul_two_pi]
  simp

/-- Decreasing-increment form of one-period Kusmin--Landau cancellation. -/
theorem kusminLandau_one_period_decreasing (f : ℕ → ℝ) (N : ℕ) (δ : ℝ)
    (hδ : 0 < δ)
    (hlow : ∀ n ≤ N, δ ≤ f (n + 1) - f n)
    (hhigh : ∀ n ≤ N, f (n + 1) - f n ≤ 2 * Real.pi - δ)
    (hmono : ∀ n < N, f (n + 2) - f (n + 1) ≤ f (n + 1) - f n) :
    ‖∑ n ∈ Finset.range (N + 1), unitaryPhase (f n)‖ ≤
      2 * Real.pi / δ := by
  let g : ℕ → ℝ := fun n => -f n + (n : ℝ) * (2 * Real.pi)
  have hdiff (n : ℕ) :
      g (n + 1) - g n = 2 * Real.pi - (f (n + 1) - f n) := by
    dsimp only [g]
    push_cast
    ring_nf
  have hphase (n : ℕ) :
      unitaryPhase (g n) = starRingEnd ℂ (unitaryPhase (f n)) := by
    rw [show g n = (n : ℝ) * (2 * Real.pi) - f n by dsimp only [g]; ring_nf]
    rw [unitaryPhase_sub]
    rw [show unitaryPhase ((n : ℝ) * (2 * Real.pi)) = 1 by
      simpa only [Int.cast_natCast] using unitaryPhase_int_mul_two_pi (n : ℤ)]
    simp
  have hKL := kusminLandau_one_period g N δ hδ
    (fun n hn => by rw [hdiff]; linarith [hhigh n hn])
    (fun n hn => by rw [hdiff]; linarith [hlow n hn])
    (fun n hn => by rw [hdiff, hdiff]; linarith [hmono n hn])
  have hsum :
      (∑ n ∈ Finset.range (N + 1), unitaryPhase (g n)) =
        starRingEnd ℂ (∑ n ∈ Finset.range (N + 1), unitaryPhase (f n)) := by
    simp_rw [hphase]
    exact (map_sum (starRingEnd ℂ) _ _).symm
  rw [hsum] at hKL
  change ‖star (∑ n ∈ Finset.range (N + 1), unitaryPhase (f n))‖ ≤ _ at hKL
  rw [norm_star] at hKL
  exact hKL

/-- Shifted-index and shifted-period form of Kusmin--Landau cancellation. -/
theorem kusminLandau_interval (f : ℕ → ℝ) (A N : ℕ) (k : ℤ) (δ : ℝ)
    (hδ : 0 < δ)
    (hlow : ∀ n ≤ N, δ ≤
      f (A + n + 1) - f (A + n) - (k : ℝ) * (2 * Real.pi))
    (hhigh : ∀ n ≤ N,
      f (A + n + 1) - f (A + n) - (k : ℝ) * (2 * Real.pi) ≤
        2 * Real.pi - δ)
    (hmono : ∀ n < N,
      f (A + n + 1) - f (A + n) ≤ f (A + n + 2) - f (A + n + 1)) :
    ‖∑ n ∈ Finset.range (N + 1), unitaryPhase (f (A + n))‖ ≤
      2 * Real.pi / δ := by
  let g : ℕ → ℝ := fun n =>
    f (A + n) - (((k * (n : ℤ) : ℤ) : ℝ) * (2 * Real.pi))
  have hdiff (n : ℕ) :
      g (n + 1) - g n =
        f (A + n + 1) - f (A + n) - (k : ℝ) * (2 * Real.pi) := by
    dsimp only [g]
    push_cast
    rw [show A + (n + 1) = A + n + 1 by omega]
    ring_nf
  have hphase (n : ℕ) : unitaryPhase (g n) = unitaryPhase (f (A + n)) := by
    dsimp only [g]
    simpa only [Int.cast_mul, Int.cast_natCast] using
      unitaryPhase_sub_int_mul_two_pi (f (A + n)) (k * (n : ℤ))
  have hKL := kusminLandau_one_period g N δ hδ
    (fun n hn => by rw [hdiff]; exact hlow n hn)
    (fun n hn => by rw [hdiff]; exact hhigh n hn)
    (fun n hn => by
      rw [hdiff, hdiff]
      simpa only [Nat.add_assoc] using
        sub_le_sub_right (hmono n hn) ((k : ℝ) * (2 * Real.pi)))
  simpa only [hphase] using hKL

theorem norm_logarithmicPhase_prefix_le_div
    (A L : ℕ) (t : ℝ) (hA : 0 < A) (hL : L ≤ A)
    (htOne : 1 ≤ t) (htA : t ≤ (A : ℝ)) :
    ‖∑ n ∈ Finset.range L,
        unitaryPhase (logarithmicPhase t (A + 1 + n))‖ ≤
      6 * Real.pi * (A : ℝ) / t := by
  by_cases hL0 : L = 0
  · subst L
    simp only [Finset.range_zero, Finset.sum_empty, norm_zero]
    positivity
  have hLpos : 0 < L := Nat.pos_of_ne_zero hL0
  have hAReal : 0 < (A : ℝ) := by exact_mod_cast hA
  let δ : ℝ := t / (3 * (A : ℝ))
  have hδ : 0 < δ := by
    dsimp only [δ]
    positivity
  have hinc (n : ℕ) (hn : n ≤ L - 1) :
      let m := A + 1 + n
      δ ≤ logarithmicPhase t (m + 1) - logarithmicPhase t m + 2 * Real.pi ∧
        logarithmicPhase t (m + 1) - logarithmicPhase t m + 2 * Real.pi ≤
          2 * Real.pi - δ := by
    dsimp only
    let m := A + 1 + n
    have hm : 0 < m := by dsimp only [m]; omega
    have hmLower : A ≤ m := by dsimp only [m]; omega
    have hmUpper : m + 1 ≤ 3 * A := by
      dsimp only [m]
      omega
    have hlogs :
        1 / ((m : ℝ) + 1) ≤
            Real.log ((m + 1 : ℕ) : ℝ) - Real.log (m : ℝ) ∧
          Real.log ((m + 1 : ℕ) : ℝ) - Real.log (m : ℝ) ≤
            1 / (m : ℝ) := by
      have hmReal : 0 < (m : ℝ) := by exact_mod_cast hm
      have hsuccReal : 0 < ((m + 1 : ℕ) : ℝ) := by positivity
      have hratio : 0 < (((m + 1 : ℕ) : ℝ) / (m : ℝ)) := by positivity
      have hlog :
          Real.log (((m + 1 : ℕ) : ℝ) / (m : ℝ)) =
            Real.log ((m + 1 : ℕ) : ℝ) - Real.log (m : ℝ) :=
        Real.log_div hsuccReal.ne' hmReal.ne'
      constructor
      · calc
          1 / ((m : ℝ) + 1) =
              1 - ((((m + 1 : ℕ) : ℝ) / (m : ℝ))⁻¹) := by
                push_cast
                field_simp [hmReal.ne']
                ring
          _ ≤ Real.log (((m + 1 : ℕ) : ℝ) / (m : ℝ)) :=
            Real.one_sub_inv_le_log_of_pos hratio
          _ = Real.log ((m + 1 : ℕ) : ℝ) - Real.log (m : ℝ) := hlog
      · rw [← hlog]
        calc
          Real.log (((m + 1 : ℕ) : ℝ) / (m : ℝ)) ≤
              ((m + 1 : ℕ) : ℝ) / (m : ℝ) - 1 :=
            Real.log_le_sub_one_of_pos hratio
          _ = 1 / (m : ℝ) := by
            push_cast
            field_simp [hmReal.ne']
            ring
    have hphase :
        logarithmicPhase t (m + 1) - logarithmicPhase t m =
          -t * (Real.log ((m + 1 : ℕ) : ℝ) - Real.log (m : ℝ)) := by
      simp only [logarithmicPhase, Nat.cast_add, Nat.cast_one]
      ring
    rw [hphase]
    have hmReal : 0 < (m : ℝ) := by exact_mod_cast hm
    have hmLowerReal : (A : ℝ) ≤ (m : ℝ) := by exact_mod_cast hmLower
    have hmUpperReal : ((m : ℝ) + 1) ≤ 3 * (A : ℝ) := by
      exact_mod_cast hmUpper
    have htOverM : t / (m : ℝ) ≤ 1 := by
      rw [div_le_one hmReal]
      exact htA.trans hmLowerReal
    have hdeltaLeThird : δ ≤ 1 / 3 := by
      dsimp only [δ]
      rw [div_le_iff₀ (by positivity : 0 < 3 * (A : ℝ))]
      nlinarith
    have hdeltaLog : δ ≤ t *
        (Real.log ((m + 1 : ℕ) : ℝ) - Real.log (m : ℝ)) := by
      have hrecip : 1 / (3 * (A : ℝ)) ≤ 1 / ((m : ℝ) + 1) :=
        one_div_le_one_div_of_le (by positivity) hmUpperReal
      dsimp only [δ]
      simpa only [div_eq_mul_inv, one_mul] using
        (mul_le_mul_of_nonneg_left hrecip (zero_le_one.trans htOne)).trans
          (mul_le_mul_of_nonneg_left hlogs.1 (zero_le_one.trans htOne))
    constructor
    · have hlogUpper : t *
          (Real.log ((m + 1 : ℕ) : ℝ) - Real.log (m : ℝ)) ≤ 1 := by
        exact (mul_le_mul_of_nonneg_left hlogs.2 (zero_le_one.trans htOne)).trans (by
          simpa only [div_eq_mul_inv, one_mul] using htOverM)
      nlinarith [Real.pi_gt_three]
    · linarith
  have hmono : ∀ n < L - 1,
      logarithmicPhase t (A + 1 + n + 1) - logarithmicPhase t (A + 1 + n) ≤
        logarithmicPhase t (A + 1 + n + 2) -
          logarithmicPhase t (A + 1 + n + 1) := by
    intro n hn
    let m := A + 1 + n
    have hm : 0 < m := by dsimp only [m]; omega
    have hmReal : 0 < (m : ℝ) := by exact_mod_cast hm
    have hmOneReal : 0 < ((m + 1 : ℕ) : ℝ) := by positivity
    have hratioLe :
        ((m + 2 : ℕ) : ℝ) / ((m + 1 : ℕ) : ℝ) ≤
          ((m + 1 : ℕ) : ℝ) / (m : ℝ) := by
      rw [div_le_div_iff₀ hmOneReal hmReal]
      push_cast
      nlinarith
    have hlogLe := Real.strictMonoOn_log.monotoneOn
      (by show 0 < ((m + 2 : ℕ) : ℝ) / ((m + 1 : ℕ) : ℝ); positivity)
      (by show 0 < ((m + 1 : ℕ) : ℝ) / (m : ℝ); positivity) hratioLe
    have hphaseOne :
        logarithmicPhase t (m + 1) - logarithmicPhase t m =
          -t * Real.log (((m + 1 : ℕ) : ℝ) / (m : ℝ)) := by
      rw [Real.log_div (by positivity) hmReal.ne']
      simp only [logarithmicPhase, Nat.cast_add, Nat.cast_one]
      ring
    have hphaseTwo :
        logarithmicPhase t (m + 2) - logarithmicPhase t (m + 1) =
          -t * Real.log (((m + 2 : ℕ) : ℝ) / ((m + 1 : ℕ) : ℝ)) := by
      rw [Real.log_div (by positivity) hmOneReal.ne']
      simp only [logarithmicPhase, Nat.cast_add, Nat.cast_ofNat]
      ring_nf
    have hfinal := mul_le_mul_of_nonpos_left hlogLe (by linarith : -t ≤ 0)
    rw [← hphaseOne, ← hphaseTwo] at hfinal
    simpa only [m, Nat.cast_add, Nat.cast_one, Nat.cast_ofNat, add_assoc] using hfinal
  have hKL := kusminLandau_interval (fun n : ℕ => logarithmicPhase t n)
    (A + 1) (L - 1) (-1) δ hδ
    (fun n hn => by
      simpa only [Int.cast_neg, Int.cast_one, neg_mul, one_mul, sub_neg_eq_add,
        Nat.cast_add, Nat.cast_one, Nat.cast_ofNat, add_assoc] using (hinc n hn).1)
    (fun n hn => by
      simpa only [Int.cast_neg, Int.cast_one, neg_mul, one_mul, sub_neg_eq_add,
        Nat.cast_add, Nat.cast_one, Nat.cast_ofNat, add_assoc] using (hinc n hn).2)
    (fun n hn => by
      simpa only [Nat.cast_add, Nat.cast_one, Nat.cast_ofNat, add_assoc] using hmono n hn)
  have hpred : L - 1 + 1 = L := by omega
  rw [hpred] at hKL
  calc
    ‖∑ n ∈ Finset.range L,
        unitaryPhase (logarithmicPhase t (A + 1 + n))‖ ≤
        2 * Real.pi / δ := by
          simpa only [Nat.cast_add, Nat.cast_one, Nat.cast_ofNat, add_assoc] using hKL
    _ = 6 * Real.pi * (A : ℝ) / t := by
      dsimp only [δ]
      field_simp [show t ≠ 0 by linarith, hAReal.ne']
      ring

private theorem separated_subset_card_le_one_of_diameter
    (W S : Finset ℝ) (hSep : IsSeparated 1 W) (hSW : S ⊆ W)
    (hdiam : ∀ x ∈ S, ∀ y ∈ S, |x - y| < 1) :
    S.card ≤ 1 := by
  rw [Finset.card_le_one]
  intro x hx y hy
  by_contra hxy
  have hlarge := hSep x (hSW hx) y (hSW hy) hxy
  exact (not_lt_of_ge hlarge) (hdiam x hx y hy)

/-- A unit-width annulus about a point contains at most one separated point on
each side. -/
theorem separated_annulus_card_le_two
    (W : Finset ℝ) (t : ℝ) (k : ℕ) (hSep : IsSeparated 1 W) :
    ({u ∈ W | u ≠ t ∧ (k : ℝ) ≤ |u - t| ∧ |u - t| < (k : ℝ) + 1}).card ≤ 2 := by
  let S := {u ∈ W | u ≠ t ∧ (k : ℝ) ≤ |u - t| ∧ |u - t| < (k : ℝ) + 1}
  let P : ℝ → Prop := fun u => t ≤ u
  have hpos : (S.filter P).card ≤ 1 := by
    apply separated_subset_card_le_one_of_diameter W (S.filter P) hSep
    · intro u hu
      exact (Finset.mem_filter.mp hu).1 |> Finset.mem_filter.mp |>.1
    · intro x hx y hy
      have hxData := Finset.mem_filter.mp hx
      have hyData := Finset.mem_filter.mp hy
      have hxS := Finset.mem_filter.mp hxData.1
      have hyS := Finset.mem_filter.mp hyData.1
      rw [abs_of_nonneg (sub_nonneg.mpr hxData.2)] at hxS
      rw [abs_of_nonneg (sub_nonneg.mpr hyData.2)] at hyS
      rw [abs_lt]
      constructor <;> linarith [hxS.2.2, hyS.2.2]
  have hneg : (S.filter (fun u => ¬ P u)).card ≤ 1 := by
    apply separated_subset_card_le_one_of_diameter W (S.filter (fun u => ¬ P u)) hSep
    · intro u hu
      exact (Finset.mem_filter.mp hu).1 |> Finset.mem_filter.mp |>.1
    · intro x hx y hy
      have hxData := Finset.mem_filter.mp hx
      have hyData := Finset.mem_filter.mp hy
      have hxS := Finset.mem_filter.mp hxData.1
      have hyS := Finset.mem_filter.mp hyData.1
      have hxt : x - t ≤ 0 := by linarith
      have hyt : y - t ≤ 0 := by linarith
      rw [abs_of_nonpos hxt] at hxS
      rw [abs_of_nonpos hyt] at hyS
      rw [abs_lt]
      constructor <;> linarith [hxS.2.2, hyS.2.2]
  have hsplit := Finset.card_filter_add_card_filter_not (s := S) P
  change S.card ≤ 2
  omega


end Legendre.Density.GuthMaynard
