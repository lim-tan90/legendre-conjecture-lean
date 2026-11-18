/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GuthMaynard.CentralShell
public import Legendre.Layer4.HuxleyFullDensity
public import Legendre.Layer4.GuthMaynardOuterRange

@[expose] public section
open Finset Complex
open scoped BigOperators
namespace Legendre.Density.GuthMaynard

/-- Separated samples above an epsilon-dependent cutoff have the central
exponent with one logarithm for the dyadic height cover. -/
theorem gm_central_separated_high_count (ε : ℝ) (hε : 0 < ε) :
    ∃ C U : ℝ, 0 < C ∧ 64 ≤ U ∧
      ∀ T σ : ℝ, 2 ≤ T → 7/10 ≤ σ → σ ≤ 4/5 →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, U < t i ∧ t i ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^(final_exponent σ+ε)*(1+Real.log T) := by
  classical
  obtain ⟨C,A,hC,hA,hShell⟩ := gm_central_separated_shell_count ε hε
  let U := A/2
  have hU : 64 ≤ U := by dsimp [U]; linarith
  have hUp : 0 < U := by linarith
  let K := A^(1+ε)
  have hK : 0 < K := by dsimp [K]; positivity
  refine ⟨C*K*(2/Real.log 2),U,by positivity,hU,?_⟩
  intro T σ hT hσL hσU ι S t β ht hs hz
  have hTp : 0 < T := by linarith
  obtain ⟨J,hJlo,hJhi,hJlog⟩ := Moment.real_height_dyadic_cover T hT
  let F (j : ℕ) := S.filter (fun i => U*2^j < t i ∧ t i ≤ A*2^j)
  have hsub : S ⊆ (range J).biUnion F := by
    intro i hi
    have hscale := (lt_div_iff₀ hUp).2 (show 64*U < 64*t i by linarith [(ht i hi).1])
    have hub : 64*t i/U ≤ 64*(2 : ℝ)^J := by
      apply (div_le_iff₀ hUp).2
      have hti := (ht i hi).2.trans hJlo
      nlinarith [mul_nonneg (by positivity : 0 ≤ (2 : ℝ)^J) (show 0 ≤ U-1 by linarith)]
    obtain ⟨j,hj,hlo,hhi⟩ := Moment.height_shell_mem J (64*t i/U) hscale hub
    have hl := (lt_div_iff₀ hUp).1 hlo
    have hh := (div_le_iff₀ hUp).1 hhi
    refine mem_biUnion.mpr ⟨j,hj,mem_filter.mpr ⟨hi,?_⟩⟩
    have hAeq : A = 2*U := by dsimp [U]; ring
    rw [hAeq]
    constructor <;> nlinarith
  have hCard : (S.card : ℝ) ≤ ∑ j ∈ range J, ((F j).card : ℝ) := by
    exact_mod_cast (Finset.card_le_card hsub).trans Finset.card_biUnion_le
  have hf0 := final_exponent_nonneg σ hσL hσU
  have hf1 : final_exponent σ ≤ 1 := by
    unfold final_exponent
    exact (div_le_one (by linarith : 0 < 3+5*σ)).2 (by linarith)
  have hShellCount (j : ℕ) (hj : j ∈ range J) :
      ((F j).card : ℝ) ≤ C*K*T^(final_exponent σ+ε) := by
    let H := A*(2 : ℝ)^j
    have hH : A ≤ H := by
      have hp : (1 : ℝ) ≤ (2 : ℝ)^j := one_le_pow₀ (by norm_num)
      dsimp [H]; nlinarith
    have hHT : H ≤ A*T := by
      have hp := pow_le_pow_right₀ (by norm_num : (1 : ℝ) ≤ 2)
        (show j+1 ≤ J from mem_range.mp hj)
      rw [pow_succ] at hp
      apply mul_le_mul_of_nonneg_left _ (by linarith)
      linarith
    have hF := hShell H σ hH hσL hσU (F j) t β
      (fun i hi => by
        have h := (mem_filter.mp hi).2
        constructor
        · dsimp [H,U] at *; nlinarith [h.1]
        · exact h.2)
      (fun i hi k hk hik => hs i (mem_filter.mp hi).1 k (mem_filter.mp hk).1 hik)
      (fun i hi => hz i (mem_filter.mp hi).1)
    have hPow : H^(final_exponent σ+ε) ≤ K*T^(final_exponent σ+ε) := by
      calc
        _ ≤ (A*T)^(final_exponent σ+ε) := Real.rpow_le_rpow (by positivity) hHT (by linarith)
        _ = A^(final_exponent σ+ε)*T^(final_exponent σ+ε) :=
          Real.mul_rpow (by linarith) hTp.le
        _ ≤ _ := mul_le_mul_of_nonneg_right
          (Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ A) (by linarith)) (by positivity)
    exact hF.trans (by
      simpa only [mul_assoc] using mul_le_mul_of_nonneg_left hPow hC.le)
  have hbound := hCard.trans (sum_le_sum hShellCount)
  simp only [sum_const,card_range,nsmul_eq_mul] at hbound
  have hJ : (J : ℝ) ≤ (2/Real.log 2)*(1+Real.log T) := hJlog.trans
    (mul_le_mul_of_nonneg_left (by linarith) (by positivity))
  calc
    _ ≤ (J : ℝ)*(C*K*T^(final_exponent σ+ε)) := hbound
    _ ≤ ((2/Real.log 2)*(1+Real.log T))*(C*K*T^(final_exponent σ+ε)) :=
      mul_le_mul_of_nonneg_right hJ (by positivity)
    _ = _ := by ring

end Legendre.Density.GuthMaynard

namespace Legendre.Zeta
open Density.GuthMaynard Set

/-- Central zero density with analytic multiplicities, one constant across
the whole central range, and all heights T ≥ 2. -/
theorem guth_maynard_central_density_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (7/10 : ℝ) (4/5),
      ∀ T ≥ (2 : ℝ), (zeroDensityCount σ T : ℝ) ≤ C*T^(15*(1-σ)/(3+5*σ)+ε) := by
  intro ε hε
  obtain ⟨C,U,hC,hU,hSample⟩ := gm_central_separated_high_count (ε/2) (by linarith)
  obtain ⟨E,hE,hlog⟩ := Density.Moment.exists_one_add_log_pow_le_rpow 2 (ε/2) (by linarith)
  let A := 2*densitySelectionConstant*C
  have hA : 0 < A := by
    have := densitySelectionConstant_pos
    dsimp [A]
    positivity
  let D : ℝ := (zeroCount U : ℝ)+1
  have hD : 0 < D := by dsimp [D]; positivity
  refine ⟨D+A*E,by positivity,?_⟩
  intro σ hσ T hT
  change (zeroDensityCount σ T : ℝ) ≤ (D+A*E)*T^(final_exponent σ+ε)
  have hTp : 0 < T := by linarith
  have hLog0 : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have hExp := final_exponent_nonneg σ hσ.1 hσ.2
  have hOne : 1 ≤ T^(final_exponent σ+ε) := Real.one_le_rpow (by linarith) (by linarith)
  have hLow : (zeroCount U : ℝ) ≤ D*T^(final_exponent σ+ε) := by
    have hh := mul_le_mul_of_nonneg_left hOne hD.le
    dsimp [D] at hh ⊢
    nlinarith
  by_cases hTh : 7 ≤ T
  · have hcount := zeroDensityCount_le_of_cutoff_sample_bound σ U hTh
      (B := C*T^(final_exponent σ+ε/2)*(1+Real.log T)) (by
        intro S hS ht hsep
        apply hSample T σ hT hσ.1 hσ.2 S Complex.im Complex.re
        · exact fun z hz => ⟨ht z hz,(hS z hz).1.2.2⟩
        · exact hsep
        · intro z hz
          have h := hS z hz
          exact ⟨h.2,h.1.1.2.2.le,by simpa only [Complex.re_add_im] using h.1.1.1⟩)
    have hH : 2*densitySelectionConstant*Real.log T*
        (C*T^(final_exponent σ+ε/2)*(1+Real.log T)) ≤ A*E*T^(final_exponent σ+ε) := by
      calc
        _ ≤ (A*T^(final_exponent σ+ε/2))*(1+Real.log T)^2 := by
          have hh := mul_le_mul_of_nonneg_left (show Real.log T ≤ 1+Real.log T by linarith)
            (show 0 ≤ A*T^(final_exponent σ+ε/2)*(1+Real.log T) by positivity)
          convert hh using 1 <;> (try dsimp [A]) <;> ring
        _ ≤ (A*T^(final_exponent σ+ε/2))*(E*T^(ε/2)) :=
          mul_le_mul_of_nonneg_left (hlog T hT) (by positivity)
        _ = _ := by
          have he : T^(final_exponent σ+ε) =
              T^(final_exponent σ+ε/2)*T^(ε/2) := by
            rw [← Real.rpow_add hTp]
            congr 1
            ring
          rw [he]
          ring
    have hh := hcount.trans (add_le_add hLow hH)
    simpa only [add_mul] using hh
  · have hn : (zeroDensityCount σ T : ℝ) ≤ (zeroCount U : ℝ) := by
      exact_mod_cast (zeroDensityCount_le σ T).trans (zeroCount_mono (by linarith : T ≤ U))
    exact hn.trans (hLow.trans (by gcongr; exact le_add_of_nonneg_right (by positivity)))

/-- Guth–Maynard Theorem 1.2 over all real parts in [1/2,1]. -/
theorem guth_maynard_density_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (1/2 : ℝ) 1,
      ∀ T ≥ (2 : ℝ), (zeroDensityCount σ T : ℝ) ≤ C*T^(15*(1-σ)/(3+5*σ)+ε) := by
  intro ε hε
  obtain ⟨A,hA,ha⟩ := guth_maynard_outer_density_epsilon ε hε
  obtain ⟨B,hB,hb⟩ := guth_maynard_central_density_epsilon ε hε
  refine ⟨A+B,by positivity,?_⟩
  intro σ hσ T hT
  by_cases ho : σ ≤ 7/10 ∨ 4/5 ≤ σ
  · exact (ha σ hσ ho T hT).trans (by gcongr; linarith)
  · exact (hb σ ⟨(not_le.mp (not_or.mp ho).1).le,(not_le.mp (not_or.mp ho).2).le⟩ T hT).trans
      (by gcongr; linarith)

end Legendre.Zeta
