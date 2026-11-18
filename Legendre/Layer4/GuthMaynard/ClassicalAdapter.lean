/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GuthMaynard.SamplingMeanSquare
public import Legendre.Layer4.Exponential.HalaszTwoTermCount

@[expose] public section

/-! # Classical bounds from the existing Montgomery and Halász estimates -/

open Complex Finset
open Legendre.Density.Oscillation
open scoped BigOperators
namespace Legendre.Density.GuthMaynard

theorem adapter_dyadic_energy_le_length (N : ℕ) (a : ℕ → ℂ)
    (ha : ∀ n ∈ dyadicInterval N, ‖a n‖ ≤ 1) :
    (∑ n ∈ Finset.Ioc N (2*N), ‖a n‖^2) ≤ (N : ℝ) := by
  calc
    _ ≤ ∑ n ∈ Finset.Ioc N (2*N), (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro n hn
      exact pow_le_one₀ (norm_nonneg _) (ha n hn)
    _ = _ := by simp [Nat.card_Ioc, show 2 * N - N = N by omega]

theorem classical_large_values_second_branch_unrestricted :
    ∃ C : ℝ, 0 < C ∧
      ∀ (N : ℕ) (T V : ℝ) (W : Finset ℝ) (a : ℕ → ℂ),
        0 < N → 1 ≤ T → 0 < V →
        (∀ n ∈ dyadicInterval N, ‖a n‖ ≤ 1) →
        IsSeparated 1 W → InBaseInterval T W →
        (∀ t ∈ W, V ≤ ‖dirichletPoly N a t‖) →
        (W.card : ℝ) ≤
          C * ((N : ℝ)^2/V^2+T*(N : ℝ)/V^2) := by
  let C : ℝ := 3*(2+2*(5*Real.pi+1))
  have hC : 0 < C := by dsimp [C]; positivity
  refine ⟨C,hC,?_⟩
  intro N T V W a hN hT hV ha hs hi hv
  have hlo : (W.card : ℝ)*V^2 ≤
      ∑ t ∈ W, ‖∑ n ∈ Finset.Ioc N (2*N), a n*(n : ℂ)^(-(t : ℂ)*I)‖^2 := by
    calc
      _ = ∑ _t ∈ W, V^2 := by simp
      _ ≤ _ := by
        apply Finset.sum_le_sum
        intro t ht
        apply pow_le_pow_left₀ hV.le
        simpa only [dirichletPoly,dyadicInterval,ofReal_neg,ofReal_mul] using hv t ht
  have hhi := montgomery_mean_value_estimate N T W a hN hT hs hi
  have hE := adapter_dyadic_energy_le_length N a ha
  have hsum : (W.card : ℝ)*V^2 ≤ C*(T+N)*N :=
    hlo.trans (hhi.trans (mul_le_mul_of_nonneg_left hE (by positivity)))
  calc
    _ ≤ (C*(T+N)*N)/V^2 := (le_div_iff₀ (sq_pos_of_pos hV)).2 hsum
    _ = _ := by ring

theorem adapter_log_factor {ε : ℝ} (hε : 0 < ε) :
    ∃ C > 0, ∀ T : ℝ, 1 ≤ T →
      (1+Real.log (2*T))^7 ≤ C*T^ε := by
  let δ := ε/7
  have hδ : 0 < δ := by dsimp [δ]; positivity
  refine ⟨(1+1/δ)^7*2^ε,by positivity,?_⟩
  intro T hT
  have h2T : 1 ≤ 2*T := by linarith
  have hp : 1 ≤ (2*T)^δ := Real.one_le_rpow h2T hδ.le
  have hl := Real.log_le_rpow_div (by linarith : 0 ≤ 2*T) hδ
  have hb : 1+Real.log (2*T) ≤ (1+1/δ)*(2*T)^δ := by
    calc
      _ ≤ (2*T)^δ + (2*T)^δ/δ := add_le_add hp hl
      _ = _ := by ring
  have hlog0 := Real.log_nonneg h2T
  calc
    _ ≤ ((1+1/δ)*(2*T)^δ)^7 :=
      pow_le_pow_left₀ (by positivity) hb _
    _ = (1+1/δ)^7*((2*T)^δ)^7 := mul_pow _ _ _
    _ = (1+1/δ)^7*(2*T)^ε := by
      rw [← Real.rpow_natCast ((2*T)^δ) 7, ← Real.rpow_mul (by linarith : 0 ≤ 2*T)]
      congr 2
      dsimp [δ]
      ring
    _ = _ := by rw [Real.mul_rpow (by norm_num : (0 : ℝ) ≤ 2) (by linarith : 0 ≤ T)]; ring

theorem classical_large_values_sixth_branch :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧
      ∀ (N : ℕ) (T V : ℝ) (W : Finset ℝ) (a : ℕ → ℂ),
        0 < N → 1 ≤ T → (N : ℝ) ≤ T → 0 < V →
        (∀ n ∈ dyadicInterval N, ‖a n‖ ≤ 1) →
        IsSeparated 1 W → InBaseInterval T W →
        (∀ t ∈ W, V ≤ ‖dirichletPoly N a t‖) →
        (W.card : ℝ) ≤ C*T^ε*((N : ℝ)^2/V^2+T*(N : ℝ)^4/V^6) := by
  intro ε hε
  obtain ⟨L, hL, hLog⟩ := adapter_log_factor hε
  refine ⟨halaszCountConstant*L, mul_pos halaszCountConstant_pos hL, ?_⟩
  intro N T V W a hN hT hNT hV ha hs hi hv
  have hN1 : 1 ≤ N := hN
  have hT0 : 0 ≤ T := by linarith
  have hNreal : (1 : ℝ) ≤ N := by exact_mod_cast hN1
  have hphase (t : ℝ) :
      (∑ n ∈ Finset.Ioc N (2*N), a n*(n : ℂ)^(-((0 : ℂ)+(t : ℂ)*I))) =
        dirichletPoly N a t := by
    simp [dirichletPoly, dyadicInterval, neg_mul]
  have hh := halasz_complex_large_values_two_term W id (fun _ => 0)
    N hN1 a T 0 0 V hT hV le_rfl (by norm_num) (by simp)
    (fun t ht => by
      change |t| ≤ T
      exact abs_le.mpr ⟨by linarith [(hi t ht).1], (hi t ht).2⟩)
    (fun t ht u hu hne => by simpa [Real.dist_eq] using hs t ht u hu hne)
    (fun t ht => by simpa only [id_eq, Complex.ofReal_zero, hphase] using hv t ht)
  let E := coefficientEnergy (Finset.Ioc N (2*N)) (verticalCoefficients a 0)
  have hE : E ≤ (N : ℝ) := by
    simpa [E, coefficientEnergy, verticalCoefficients] using adapter_dyadic_energy_le_length N a ha
  have hE0 : 0 ≤ E := coefficientEnergy_nonneg _ _
  have hlN : 0 ≤ Real.log (2*(N : ℝ)) := Real.log_nonneg (by linarith)
  have hlT : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
  have hlNT : Real.log (2*(N : ℝ)) ≤ Real.log (2*T) :=
    Real.log_le_log (by positivity) (by linarith)
  calc
    _ ≤ halaszCountConstant*(1+Real.log (2*(N : ℝ)))^6*(1+Real.log (2*T))*
        ((N : ℝ)*E/V^2+(N : ℝ)*T*E^3/V^6) := hh
    _ ≤ halaszCountConstant*(1+Real.log (2*T))^6*(1+Real.log (2*T))*
        ((N : ℝ)*(N : ℝ)/V^2+(N : ℝ)*T*(N : ℝ)^3/V^6) := by
      have := halaszCountConstant_pos
      gcongr
    _ = halaszCountConstant*(1+Real.log (2*T))^7*
        ((N : ℝ)^2/V^2+T*(N : ℝ)^4/V^6) := by ring
    _ ≤ _ := by
      have := mul_le_mul_of_nonneg_left (hLog T hT) halaszCountConstant_pos.le
      exact mul_le_mul_of_nonneg_right (by simpa [mul_assoc] using this) (by positivity)

theorem classical_montgomery_halasz_huxley_native :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧
      ∀ (N : ℕ) (T V : ℝ) (W : Finset ℝ) (a : ℕ → ℂ),
        0 < N → 1 ≤ T → (N : ℝ) ≤ T → 0 < V →
        (∀ n ∈ dyadicInterval N, ‖a n‖ ≤ 1) →
        IsSeparated 1 W → InBaseInterval T W →
        (∀ t ∈ W, V ≤ ‖dirichletPoly N a t‖) →
        (W.card : ℝ) ≤ C*T^ε*
          ((N : ℝ)^2/V^2+T*min ((N : ℝ)/V^2) ((N : ℝ)^4/V^6)) := by
  intro ε hε
  obtain ⟨A, hA, h2⟩ := classical_large_values_second_branch_unrestricted
  obtain ⟨B, hB, h6⟩ := classical_large_values_sixth_branch ε hε
  refine ⟨A+B, by positivity, ?_⟩
  intro N T V W a hN hT hNT hV ha hs hi hv
  have hT0 : 0 ≤ T := by linarith
  have hTe : 1 ≤ T^ε := Real.one_le_rpow hT hε.le
  by_cases h : (N : ℝ)/V^2 ≤ (N : ℝ)^4/V^6
  · rw [min_eq_left h]
    calc
      _ ≤ A*((N : ℝ)^2/V^2+T*(N : ℝ)/V^2) := h2 N T V W a hN hT hV ha hs hi hv
      _ = A*1*((N : ℝ)^2/V^2+T*((N : ℝ)/V^2)) := by ring
      _ ≤ _ := by gcongr; linarith
  · rw [min_eq_right (le_of_not_ge h)]
    calc
      _ ≤ B*T^ε*((N : ℝ)^2/V^2+T*(N : ℝ)^4/V^6) := h6 N T V W a hN hT hNT hV ha hs hi hv
      _ = B*T^ε*((N : ℝ)^2/V^2+T*((N : ℝ)^4/V^6)) := by ring
      _ ≤ _ := by gcongr; linarith

end Legendre.Density.GuthMaynard
