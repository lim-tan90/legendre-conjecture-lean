/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaGlobalCounting
public import Legendre.ZetaZeroFree
public import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics

/-!
# Layer 4: zero-density exponents and an unconditional near-one count

N(σ,T) retains the analytic multiplicities and endpoint conventions of Layer 2.
The exponent interface is a Prop, not an assumed zero-density theorem. Its
coefficient is uniform in σ∈[1/2,1], and its ε is additive in the exponent of T.
The proved near-one estimate uses only the existing effective zero-free region.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology Set

/-- A density exponent b, allowing T^ε with a coefficient uniform in σ.
No particular value of b is asserted by this definition. -/
def HasZeroDensityEstimate (b : ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C > 0, ∀ σ : ℝ, σ ∈ Icc (1/2) 1 →
    ∀ T : ℝ, 2 ≤ T → (zeroDensityCount σ T : ℝ) ≤ C*T^(b*(1-σ)+ε)

/-- A proved density exponent can always be weakened to a larger one. -/
theorem HasZeroDensityEstimate.mono {b d : ℝ} (hb : HasZeroDensityEstimate b) (hbd : b ≤ d) :
    HasZeroDensityEstimate d := by
  intro ε hε
  obtain ⟨C,hC,hbound⟩ := hb ε hε
  refine ⟨C,hC,fun σ hσ T hT => (hbound σ hσ T hT).trans ?_⟩
  apply mul_le_mul_of_nonneg_left _ hC.le
  apply Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
  nlinarith [mul_nonneg (sub_nonneg.2 hbd) (sub_nonneg.2 hσ.2)]

/-- A zero in the effective near-one strip and below T must have height less than 3. -/
theorem zero_height_lt_three_of_near_one {σ T : ℝ} (_hT : 3 ≤ T)
    (hσ : 1-zetaZeroFreeConstant/Real.log T < σ) {ρ : ℂ} (hρ : ρ ∈ zerosRightOf σ T) :
    ρ.im < 3 := by
  by_contra h
  have hi : 3 ≤ ρ.im := not_lt.1 h
  have hlogρ : 0 < Real.log ρ.im := Real.log_pos (by linarith)
  have hlogT : Real.log ρ.im ≤ Real.log T := Real.log_le_log (by linarith) hρ.1.2.2
  have hfrac : zetaZeroFreeConstant/Real.log T ≤ zetaZeroFreeConstant/Real.log ρ.im :=
    div_le_div_of_nonneg_left zetaZeroFreeConstant_pos.le hlogρ hlogT
  apply riemannZeta_ne_zero_of_log_region (s := ρ) (by rwa [abs_of_pos (by linarith : 0 < ρ.im)])
    (by rw [abs_of_pos (by linarith : 0 < ρ.im)]; linarith [hρ.2])
  exact hρ.1.1.1

/-- In the effective near-one strip the count is bounded by a fixed compact low-height count. -/
theorem zeroDensityCount_le_low_of_near_one {σ T : ℝ} (hT : 3 ≤ T)
    (hσ : 1-zetaZeroFreeConstant/Real.log T < σ) :
    zeroDensityCount σ T ≤ zeroDensityCount σ 3 := by
  apply Finset.sum_le_sum_of_subset
  intro ρ hρ
  have hρ' : ρ ∈ zerosRightOf σ T := by simpa using hρ
  have hheight := zero_height_lt_three_of_near_one hT hσ hρ'
  have hmem : ρ ∈ zerosRightOf σ 3 := ⟨⟨hρ'.1.1,hρ'.1.2.1,hheight.le⟩,hρ'.2⟩
  simpa using hmem

/-- Fully rational near-one cutoff: the only remaining contribution is below height 3. -/
theorem zeroDensityCount_rational_near_one {T : ℝ} (hT : 3 ≤ T) :
    zeroDensityCount (1-1/(4000000*Real.log T)) T ≤ zeroCount 3 := by
  apply (zeroDensityCount_le_low_of_near_one hT ?_).trans (zeroDensityCount_le _ _)
  have hlog : 0 < Real.log T := Real.log_pos (by linarith)
  have hf := div_le_div_of_nonneg_right rational_le_zetaZeroFreeConstant hlog.le
  have hpos : 0 < 1/(4000000*Real.log T) := by positivity
  have he : (1/2000000 : ℝ)/Real.log T = 2*(1/(4000000*Real.log T)) := by ring
  rw [he] at hf
  linarith


/-- Fixed logarithmic losses are absorbed into T^ε uniformly for all T≥2. -/
theorem exists_log_pow_le_rpow (k : ℕ) {ε : ℝ} (hε : 0 < ε) :
    ∃ D > 0, ∀ T : ℝ, 2 ≤ T → (Real.log T)^k ≤ D*T^ε := by
  by_cases hk : k = 0
  · subst k
    refine ⟨1,by norm_num,fun T hT => ?_⟩
    simpa only [pow_zero,one_mul] using
      Real.one_le_rpow (by linarith : 1 ≤ T) hε.le
  have hkpos : (0 : ℝ) < k := by exact_mod_cast Nat.pos_of_ne_zero hk
  let δ := ε/(k : ℝ)
  have hδ : 0 < δ := div_pos hε hkpos
  refine ⟨(δ^k)⁻¹,by positivity,fun T hT => ?_⟩
  have hTpos : 0 < T := by linarith
  have hlog := Real.log_le_sub_one_of_pos (Real.rpow_pos_of_pos hTpos δ)
  rw [Real.log_rpow hTpos] at hlog
  have hb : Real.log T ≤ T^δ/δ := (le_div_iff₀ hδ).2 (by nlinarith)
  have hpow := pow_le_pow_left₀ (Real.log_nonneg (by linarith : 1 ≤ T)) hb k
  have hexp : δ*(k : ℝ) = ε := by dsimp [δ]; field_simp
  calc
    _ ≤ (T^δ/δ)^k := hpow
    _ = (δ^k)⁻¹*T^ε := by
      rw [div_pow, ← Real.rpow_natCast (T^δ) k, ← Real.rpow_mul hTpos.le, hexp]
      ring

/-- A uniform power-and-log density bound implies the exponent interface.
This is conditional: the analytic density estimate is an explicit hypothesis. -/
theorem hasZeroDensityEstimate_of_log_bound {b C : ℝ} (hC : 0 < C) (k : ℕ)
    (hbound : ∀ σ : ℝ, σ ∈ Icc (1/2) 1 → ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^(b*(1-σ))*(Real.log T)^k) :
    HasZeroDensityEstimate b := by
  intro ε hε
  obtain ⟨D,hD,hlog⟩ := exists_log_pow_le_rpow k hε
  refine ⟨C*D,mul_pos hC hD,fun σ hσ T hT => ?_⟩
  calc
    _ ≤ C*T^(b*(1-σ))*(Real.log T)^k := hbound σ hσ T hT
    _ ≤ C*T^(b*(1-σ))*(D*T^ε) :=
      mul_le_mul_of_nonneg_left (hlog T hT) (by positivity)
    _ = (C*D)*T^(b*(1-σ)+ε) := by
      rw [Real.rpow_add (by linarith : 0 < T)]
      ring

end Legendre.Zeta
