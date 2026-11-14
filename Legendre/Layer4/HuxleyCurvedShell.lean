/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local assembly of the powered Type I and small-mollifier Type II counts.
The finite branch-splitting structure follows HuxleyShellDensity.lean,
which adapts DensitySeparatedCount.lean from openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.HuxleyShortTail

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- Both actual detector branches give the curved exponent on the stated middle range. -/
theorem huxley_curved_separated_high_shell_density (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 3/4 ≤ σ → σ ≤ 5/6 →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^(huxleyCurvedExponent σ+ε) := by
  classical
  let δ := min (ε/16) (1/2)
  have hδ : 0 < δ := lt_min (by linarith) (by norm_num)
  have hδ1 : δ ≤ 1 := (min_le_right _ _).trans (by norm_num)
  have hδε : 4*δ+ε/2 ≤ ε := by have hh : δ ≤ ε/16 := min_le_left _ _; linarith
  obtain ⟨CP,hCP,hp⟩ := huxley_actual_tail_epsilon_count δ ε hδ hε
  obtain ⟨CI,hCI,hi⟩ := actual_typeII_given_cutoff_count (ε/2) (by linarith)
  refine ⟨CP+CI,by positivity,?_⟩
  intro T σ hT hσ hσu ι S t β ht hs hz
  obtain ⟨X,hX,hXlo,hXhi,hX2⟩ := small_integer_mollifier T δ (by linarith) hδ.le hδ1
  let p : ι → Prop := fun i => (1/16 : ℝ) ≤
    ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) (T^(1/2 : ℝ))‖
  let P := S.filter p
  let Q := S.filter (fun i => ¬p i)
  have hP := hp T σ hT hσ hσu X hXlo P t β
    (fun i hi => (ht i (Finset.mem_filter.mp hi).1).2)
    (fun i hi => ⟨(hz i (Finset.mem_filter.mp hi).1).1,(hz i (Finset.mem_filter.mp hi).1).2.1⟩)
    (fun i hi j hj => hs i (Finset.mem_filter.mp hi).1 j (Finset.mem_filter.mp hj).1)
    (fun _ hi => (Finset.mem_filter.mp hi).2)
  have hQ := hi δ T σ hδ.le hT hσ X hX hX2 hXhi Q β t
    (fun i hi => ht i (Finset.mem_filter.mp hi).1)
    (fun i hi j hj => hs i (Finset.mem_filter.mp hi).1 j (Finset.mem_filter.mp hj).1)
    (fun i hi => hz i (Finset.mem_filter.mp hi).1)
    (fun _ hi => (Finset.mem_filter.mp hi).2)
  have hcurved : 2-2*σ ≤ huxleyCurvedExponent σ := by
    unfold huxleyCurvedExponent
    apply (le_div_iff₀ (show 0 < 3*σ-1 by linarith)).mpr
    have ha : 0 ≤ 1-σ := by linarith
    have hb : 0 ≤ 5-6*σ := by linarith
    nlinarith [mul_nonneg ha hb]
  have hQ' : (Q.card : ℝ) ≤ CI*T^(huxleyCurvedExponent σ+ε) := by
    apply hQ.trans
    apply mul_le_mul_of_nonneg_left _ hCI.le
    exact Real.rpow_le_rpow_of_exponent_le (by linarith) (by linarith)
  have hcard : (S.card : ℝ) = (P.card : ℝ)+(Q.card : ℝ) := by
    exact_mod_cast (Finset.card_filter_add_card_filter_not (s := S) (p := p)).symm
  rw [hcard]
  have hh := add_le_add hP hQ'
  convert hh using 1
  ring

end Legendre.Density.Moment
