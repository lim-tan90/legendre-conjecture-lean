/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaLogDerivativeLocal
public import Legendre.ZetaPoleBounds
public import Legendre.ZetaPositivity

/-!
# An explicit logarithmic zero-free region

Original deductions using mathlib v4.35.0 (Apache-2.0). The constants are
deliberately coarse. The real-axis pole estimate, local zero removal and
3–4–1 positivity yield a positive explicit c and height threshold 3.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric

/-- Constant from the Jensen/Borel-Carathéodory estimate. -/
noncomputable def zetaZeroFreeK : ℝ := 1 + Real.log 5 / Real.log (6 / 5)

/-- An explicit coefficient dominating the three error terms in the 3–4–1 argument. -/
noncomputable def zetaZeroFreeCost : ℝ := 4320 * zetaZeroFreeK + 18 / Real.log 2

/-- Positive explicit width coefficient in the logarithmic zero-free region. -/
noncomputable def zetaZeroFreeConstant : ℝ := 1 / (32 * zetaZeroFreeCost)

/-- Positivity of the Jensen/Borel-Carathéodory coefficient. -/
theorem zetaZeroFreeK_pos : 0 < zetaZeroFreeK := by
  have h5 : 0 < Real.log 5 := Real.log_pos (by norm_num)
  have h65 : 0 < Real.log (6 / 5) := Real.log_pos (by norm_num)
  unfold zetaZeroFreeK
  positivity

/-- Positivity of the combined coefficient. -/
theorem zetaZeroFreeCost_pos : 0 < zetaZeroFreeCost := by
  have hK := zetaZeroFreeK_pos
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  unfold zetaZeroFreeCost
  positivity

/-- The logarithmic zero-free width is strictly positive. -/
theorem zetaZeroFreeConstant_pos : 0 < zetaZeroFreeConstant := by
  have h := zetaZeroFreeCost_pos
  unfold zetaZeroFreeConstant
  positivity

/-- The logarithm in the local bound is at most five times log |t| for |t|≥3. -/
theorem zeta_local_log_le {t : ℝ} (ht : 3 ≤ |t|) :
    Real.log (24 * (|t| + 2)) ≤ 5 * Real.log |t| := by
  have hp : (81 : ℝ) ≤ |t| ^ 4 := by
    have h := pow_le_pow_left₀ (by norm_num : (0 : ℝ) ≤ 3) ht 4
    norm_num at h
    exact h
  have hnum : 24 * (|t| + 2) ≤ |t| ^ 5 := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hp) (abs_nonneg t)]
  have hlog := Real.log_le_log (by positivity : (0 : ℝ) < 24 * (|t| + 2)) hnum
  simpa only [Real.log_pow, Nat.cast_ofNat] using hlog

/-- Explicit local logarithmic bound at height t. -/
theorem localZetaLogBound_le_five_log {t : ℝ} (ht : 3 ≤ |t|) :
    localZetaLogBound t ≤ 5 * zetaZeroFreeK * Real.log |t| := by
  have h := mul_le_mul_of_nonneg_left (zeta_local_log_le ht) zetaZeroFreeK_pos.le
  dsimp [localZetaLogBound, zetaZeroFreeK] at h ⊢
  nlinarith

/-- Explicit local logarithmic bound at the doubled height. -/
theorem localZetaLogBound_two_mul_le {t : ℝ} (ht : 3 ≤ |t|) :
    localZetaLogBound (2 * t) ≤ 10 * zetaZeroFreeK * Real.log |t| := by
  have ht2 : 3 ≤ |2 * t| := by rw [abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2)]; linarith
  have hlog2 : Real.log 2 ≤ Real.log |t| := Real.log_le_log (by norm_num) (by linarith)
  have hlog : Real.log |2 * t| ≤ 2 * Real.log |t| := by
    rw [abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2),
      Real.log_mul (by norm_num) (by linarith : |t| ≠ 0)]
    linarith
  have h := localZetaLogBound_le_five_log ht2
  have hm := mul_le_mul_of_nonneg_left hlog (show 0 ≤ 5 * zetaZeroFreeK by positivity [zetaZeroFreeK_pos])
  nlinarith

/-- The real-axis constant term is absorbed explicitly into log |t|. -/
theorem eighteen_le_log_term {t : ℝ} (ht : 3 ≤ |t|) :
    18 ≤ (18 / Real.log 2) * Real.log |t| := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hlog := Real.log_le_log (by norm_num : (0 : ℝ) < 2) (show 2 ≤ |t| by linarith)
  calc
    18 = (18 / Real.log 2) * Real.log 2 := by field_simp
    _ ≤ _ := mul_le_mul_of_nonneg_left hlog (by positivity)

/-- The comparison line stays uniformly close to 1 at every allowed height. -/
theorem eighteen_le_zeroFreeCost_mul_log {t : ℝ} (ht : 3 ≤ |t|) :
    18 ≤ zetaZeroFreeCost * Real.log |t| := by
  have hlogpos : 0 < Real.log |t| := Real.log_pos (by linarith)
  have hK := zetaZeroFreeK_pos
  have h18 := eighteen_le_log_term ht
  unfold zetaZeroFreeCost
  nlinarith

/-- Effective logarithmic zero-free region, with height threshold 3 and a positive explicit width. -/
theorem riemannZeta_ne_zero_of_log_region {s : ℂ} (ht : 3 ≤ |s.im|)
    (hs : 1 - zetaZeroFreeConstant / Real.log |s.im| < s.re) : riemannZeta s ≠ 0 := by
  by_contra hzero
  have hβ : s.re < 1 := by
    by_contra h
    exact riemannZeta_ne_zero_of_one_le_re (not_lt.mp h) hzero
  let t := s.im
  let L := Real.log |t|
  let C := zetaZeroFreeCost
  let δ := 1 / (4 * C * L)
  let σ := 1 + δ
  let z := (σ : ℂ) + (t : ℂ) * I
  have hL : 0 < L := Real.log_pos (by dsimp [t]; linarith)
  have hC : 0 < C := zetaZeroFreeCost_pos
  have hδ : 0 < δ := by dsimp [δ]; positivity
  have hCL : 18 ≤ C * L := eighteen_le_zeroFreeCost_mul_log ht
  have hδupper : δ ≤ 1 / 8 := by
    dsimp [δ]
    apply (div_le_iff₀ (by positivity : 0 < 4 * C * L)).mpr
    nlinarith
  have hcδ : zetaZeroFreeConstant / L = δ / 8 := by
    dsimp [zetaZeroFreeConstant, δ, C]
    ring
  have hsnear : 1 - δ / 8 < s.re := by simpa only [← hcδ] using hs
  have hσ : 1 < σ := by dsimp [σ]; linarith
  have hσupper : σ ≤ 9 / 8 := by dsimp [σ]; linarith
  have hline (u : ℝ) :
      ‖((σ : ℂ) + (u : ℂ) * I) - ((2 : ℂ) + (u : ℂ) * I)‖ ≤ 1 := by
    have he : ((σ : ℂ) + (u : ℂ) * I) - ((2 : ℂ) + (u : ℂ) * I) =
        ((σ - 2 : ℝ) : ℂ) := by push_cast; ring
    rw [he, norm_real, Real.norm_eq_abs, abs_le]
    constructor <;> linarith
  have hsdisk : s ∈ closedBall ((2 : ℂ) + (t : ℂ) * I) (5 / 4) := by
    have he : s - ((2 : ℂ) + (t : ℂ) * I) = ((s.re - 2 : ℝ) : ℂ) := by
      apply Complex.ext <;> simp [t]
    rw [mem_closedBall, dist_eq_norm, he, norm_real, Real.norm_eq_abs, abs_le]
    constructor <;> linarith
  have hA0 := neg_logDeriv_real_le_pole hσ hσupper
  have hA1 := neg_logDeriv_re_le_local_sub_zero ht (hline t)
    (by simpa only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im,
      mul_zero, zero_mul, sub_self, add_zero] using hσ) hsdisk hzero
  have ht2 : 3 ≤ |2 * t| := by rw [abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2)]; linarith
  have hA2 := neg_logDeriv_re_le_local ht2 (hline (2 * t))
    (by simpa only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im,
      mul_zero, zero_mul, sub_self, add_zero] using hσ)
  have hprincipal : ((1 : ℂ) / (z - s)).re = 1 / (σ - s.re) := by
    have he : z - s = ((σ - s.re : ℝ) : ℂ) := by apply Complex.ext <;> simp [z, t]
    rw [he, ← ofReal_one, ← ofReal_div, ofReal_re]
  change (-logDeriv riemannZeta z).re ≤
    144 * localZetaLogBound t - ((1 : ℂ) / (z - s)).re at hA1
  rw [hprincipal] at hA1
  have hM1 := localZetaLogBound_le_five_log ht
  have hM2 := localZetaLogBound_two_mul_le ht
  have hpos := neg_logDeriv_three_four_one_nonneg hσ t
  have h18 := eighteen_le_log_term ht
  have hA0' : (-logDeriv riemannZeta (σ : ℂ)).re ≤ 1 / δ + 6 := by
    simpa only [σ, add_sub_cancel_left] using hA0
  have hcomb : 4 / (σ - s.re) ≤ 3 / δ + C * L := by
    change localZetaLogBound t ≤ 5 * zetaZeroFreeK * L at hM1
    change localZetaLogBound (2 * t) ≤ 10 * zetaZeroFreeK * L at hM2
    change 18 ≤ (18 / Real.log 2) * L at h18
    have he : C * L = 4320 * zetaZeroFreeK * L + (18 / Real.log 2) * L := by
      dsimp [C, zetaZeroFreeCost]
      ring
    rw [he]
    dsimp only [z] at hA1
    simp only [div_eq_mul_inv, one_mul] at hA0' hA1 h18 ⊢
    linarith only [hA0', hA1, hA2, hpos, hM1, hM2, h18]
  have hD : 0 < σ - s.re := by linarith
  have hgap : σ - s.re < 9 * δ / 8 := by dsimp [σ]; linarith
  have hscale : C * L * δ = 1 / 4 := by dsimp [δ]; field_simp
  have hm := mul_le_mul_of_nonneg_right ((div_le_iff₀ hD).mp hcomb) hδ.le
  have he : (3 / δ + C * L) * (σ - s.re) * δ =
      3 * (σ - s.re) + (C * L * δ) * (σ - s.re) := by field_simp
  rw [he, hscale] at hm
  nlinarith

/-- A small rational upper bound for the local analytic coefficient. -/
theorem zetaZeroFreeK_le_ten : zetaZeroFreeK ≤ 10 := by
  have h65 : 0 < Real.log (6 / 5) := Real.log_pos (by norm_num)
  have hp : (5 : ℝ) ≤ (6 / 5 : ℝ) ^ 9 := by norm_num
  have hlog := Real.log_le_log (by norm_num : (0 : ℝ) < 5) hp
  rw [Real.log_pow] at hlog
  have hdiv : Real.log 5 / Real.log (6 / 5) ≤ 9 := (div_le_iff₀ h65).mpr (by linarith)
  unfold zetaZeroFreeK
  linarith

/-- A rational bound for the combined coefficient, with no numerical approximation to logarithms. -/
theorem zetaZeroFreeCost_le : zetaZeroFreeCost ≤ 43236 := by
  have h2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hlog : (1 / 2 : ℝ) ≤ Real.log 2 := by
    have h := Real.one_sub_inv_le_log_of_pos (show (0 : ℝ) < 2 by norm_num)
    norm_num at h
    linarith
  have hdiv : 18 / Real.log 2 ≤ 36 := (div_le_iff₀ h2).mpr (by linarith)
  have hK := zetaZeroFreeK_le_ten
  unfold zetaZeroFreeCost
  linarith

/-- The explicit logarithmic width admits the simpler rational coefficient 1/2000000. -/
theorem rational_le_zetaZeroFreeConstant : (1 / 2000000 : ℝ) ≤ zetaZeroFreeConstant := by
  unfold zetaZeroFreeConstant
  apply (le_div_iff₀ (by positivity [zetaZeroFreeCost_pos] : 0 < 32 * zetaZeroFreeCost)).mpr
  have h := zetaZeroFreeCost_le
  linarith

/-- Rational-constant version of the effective region: c=1/2000000, height threshold 3. -/
theorem riemannZeta_ne_zero_of_explicit_log_region {s : ℂ} (ht : 3 ≤ |s.im|)
    (hs : 1 - 1 / (2000000 * Real.log |s.im|) < s.re) : riemannZeta s ≠ 0 := by
  have hL : 0 < Real.log |s.im| := Real.log_pos (by linarith)
  apply riemannZeta_ne_zero_of_log_region ht
  have hdiv := div_le_div_of_nonneg_right rational_le_zetaZeroFreeConstant hL.le
  have he : (1 / 2000000 : ℝ) / Real.log |s.im| = 1 / (2000000 * Real.log |s.im|) := by ring
  rw [he] at hdiv
  linarith

end Legendre.Zeta
