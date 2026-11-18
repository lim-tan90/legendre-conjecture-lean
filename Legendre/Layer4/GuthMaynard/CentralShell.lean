/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GuthMaynard.ActualTypeI
public import Legendre.Layer4.SmallMollifierTypeII

@[expose] public section
open Finset Set Complex
namespace Legendre.Density.GuthMaynard

/-- A cutoff at T^(1/200) fits the residual branch's exponent margin
uniformly for 7/10 ≤ σ ≤ 4/5. -/
theorem gm_residual_with_cutoff_le (σ : ℝ) (hσL : 7/10 ≤ σ) (hσU : σ ≤ 4/5) :
    2-2*σ+4*(1/200 : ℝ) ≤ final_exponent σ := by
  unfold final_exponent
  rw [le_div_iff₀ (show 0 < 3+5*σ by linarith)]
  have hprod : (1/5 : ℝ) ≤ (1-σ)*(9-10*σ) := by
    have h := mul_le_mul (show (1/5 : ℝ) ≤ 1-σ by linarith)
      (show (1 : ℝ) ≤ 9-10*σ by linarith) (by norm_num) (by linarith)
    linarith
  have hcost : (4/200 : ℝ)*(3+5*σ) ≤ 1/5 := by linarith
  nlinarith

/-- Both actual detector branches obey the central Guth–Maynard exponent
for a separated positive-height shell of zeta zeros. -/
theorem gm_central_separated_shell_count (ε : ℝ) (hε : 0 < ε) :
    ∃ C T₀ : ℝ, 0 < C ∧ 128 ≤ T₀ ∧
      ∀ T σ : ℝ, T₀ ≤ T → 7/10 ≤ σ → σ ≤ 4/5 →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ t i ∧ t i ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^(final_exponent σ+ε) := by
  classical
  obtain ⟨CP,T₀,hCP,hT₀,hp⟩ := gm_actual_typeI_count ε hε
  obtain ⟨CQ,hCQ,hq⟩ := Moment.actual_typeII_given_cutoff_count_central ε hε
  refine ⟨CP+CQ,T₀,by positivity,hT₀,?_⟩
  intro T σ hT hσL hσU ι S t β ht hs hz
  have h128 := hT₀.trans hT
  obtain ⟨X,hX,hXlo,hXhi,hX2⟩ :=
    Moment.small_integer_mollifier T (1/200) (by linarith) (by norm_num) (by norm_num)
  let p : ι → Prop := fun i => (1/16 : ℝ) ≤
    ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖
  let P := S.filter p
  let Q := S.filter (fun i => ¬p i)
  have hP := hp T σ hT hσL hσU X hXlo P t β
    (fun i hi => ⟨by linarith [(ht i (mem_filter.mp hi).1).1],(ht i (mem_filter.mp hi).1).2⟩)
    (fun i hi => ⟨(hz i (mem_filter.mp hi).1).1,(hz i (mem_filter.mp hi).1).2.1⟩)
    (fun i hi j hj => hs i (mem_filter.mp hi).1 j (mem_filter.mp hj).1)
    (fun _ hi => (mem_filter.mp hi).2)
  have hQ := hq (1/200) T σ (by norm_num) h128 hσL X hX hX2 hXhi Q β t
    (fun i hi => by
      have h := ht i (mem_filter.mp hi).1
      simpa only [abs_of_nonneg (show 0 ≤ t i by linarith [h.1])] using h)
    (fun i hi j hj => hs i (mem_filter.mp hi).1 j (mem_filter.mp hj).1)
    (fun i hi => hz i (mem_filter.mp hi).1)
    (fun _ hi => (mem_filter.mp hi).2)
  have hQ' := hQ.trans (mul_le_mul_of_nonneg_left
    (Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
      (add_le_add (gm_residual_with_cutoff_le σ hσL hσU) (le_rfl : ε ≤ ε))) hCQ.le)
  have hcard : (S.card : ℝ) = (P.card : ℝ)+(Q.card : ℝ) := by
    exact_mod_cast (Finset.card_filter_add_card_filter_not (s := S) (p := p)).symm
  rw [hcard, add_mul]
  exact add_le_add hP hQ'

end Legendre.Density.GuthMaynard
