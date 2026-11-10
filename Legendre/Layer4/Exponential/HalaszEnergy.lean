/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions: finite Gram duality now has a proved analytic correlation
kernel. No off-diagonal kernel or zero-density estimate is assumed.
-/
module
public import Legendre.Layer4.Exponential.HalaszKernel

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def halaszBlockCoefficient (U : ℕ) (T R : ℝ) : ℝ :=
  (U : ℝ)+logarithmicKernelConstant*(R*Real.sqrt (2*T)+2*(U : ℝ)*(1+Real.log (2*T)))

theorem halaszBlockCoefficient_nonneg (U : ℕ) (T R : ℝ) (hT : 1 ≤ T) (hR : 0 ≤ R) :
    0 ≤ halaszBlockCoefficient U T R := by
  have hc := logarithmicKernelConstant_pos
  have hl : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
  unfold halaszBlockCoefficient
  positivity

/-- Unconditional Halasz--Montgomery energy on a dyadic coefficient block. -/
theorem halasz_block_energy {ι : Type*} [Fintype ι] (t : ι → ℝ)
    (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V) (hV : V ≤ 2*U)
    (a : ℕ → ℂ) (T : ℝ) (hT : 1 ≤ T)
    (ht : ∀ i, |t i| ≤ T) (hs : ∀ i j, i ≠ j → 1 ≤ |t i-t j|) :
    (∑ i, ‖blockDirichletPolynomial U V a (t i)‖^2) ≤
      halaszBlockCoefficient U T (Fintype.card ι)*coefficientEnergy (Finset.Ioc U V) a := by
  classical
  let F := Finset.Ioc U V
  have hsum (f : ℕ → ℂ) : (∑ n : F, f n.val) = ∑ n ∈ F, f n := Finset.sum_coe_sort F f
  have hpoly (b : ℕ → ℂ) (u : ℝ) :
      (∑ n : F, b n.val*realPhase (-Real.log (n.val : ℝ)) u) =
        blockDirichletPolynomial U V b u := by
    rw [hsum (fun n : ℕ => b n*realPhase (-Real.log (n : ℝ)) u)]
    apply Finset.sum_congr rfl
    intro n hn
    rw [realPhase_neg_log_eq_cpow (by exact_mod_cast (lt_of_le_of_lt (Nat.zero_le U)
      (Finset.mem_Ioc.mp hn).1)),Complex.ofReal_natCast]
  have hkernel (u : ℝ) : (∑ n : F, realPhase (-Real.log (n.val : ℝ)) u) =
      blockDirichletPolynomial U V (fun _ => 1) u := by
    simpa only [one_mul] using hpoly (fun _ => 1) u
  have hE : (∑ n : F, ‖a n.val‖^2) = coefficientEnergy (Finset.Ioc U V) a :=
    Finset.sum_coe_sort F (fun n => ‖a n‖^2)
  have h := exponential_samples_le_gram_rows (κ := F) t
    (fun n => -Real.log (n.val : ℝ)) (fun n => a n.val)
    (halaszBlockCoefficient_nonneg U T (Fintype.card ι) hT (by positivity)) (by
      intro i
      simp only [hkernel]
      have hr := logarithmic_kernel_row Finset.univ t T hT (fun i _ => ht i)
        (fun i _ j _ hij => hs i j hij) U V hU hUV hV i (Finset.mem_univ i)
      simpa only [halaszBlockCoefficient,Finset.card_univ] using hr)
  simpa only [hpoly,hE] using h

/-- The cardinality-sensitive term is isolated for later interval subdivision. -/
theorem halasz_block_large_values {ι : Type*} [Fintype ι] (t : ι → ℝ)
    (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V) (hV : V ≤ 2*U)
    (a : ℕ → ℂ) (T W : ℝ) (hT : 1 ≤ T) (hW : 0 ≤ W)
    (ht : ∀ i, |t i| ≤ T) (hs : ∀ i j, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i, W ≤ ‖blockDirichletPolynomial U V a (t i)‖) :
    (Fintype.card ι : ℝ)*(W^2-logarithmicKernelConstant*Real.sqrt (2*T)*
        coefficientEnergy (Finset.Ioc U V) a) ≤
      (U : ℝ)*(1+2*logarithmicKernelConstant*(1+Real.log (2*T)))*
        coefficientEnergy (Finset.Ioc U V) a := by
  have he := halasz_block_energy t U V hU hUV hV a T hT ht hs
  have hl : (Fintype.card ι : ℝ)*W^2 ≤ ∑ i, ‖blockDirichletPolynomial U V a (t i)‖^2 := by
    have hh := Finset.sum_le_sum (s := Finset.univ) (fun i _ => pow_le_pow_left₀ hW (hw i) 2)
    simpa only [Finset.sum_const,Finset.card_univ,nsmul_eq_mul] using hh
  unfold halaszBlockCoefficient at he
  nlinarith

/-- When its denominator is positive, the actual large-value count is bounded. -/
theorem halasz_block_card_le {ι : Type*} [Fintype ι] (t : ι → ℝ)
    (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V) (hV : V ≤ 2*U)
    (a : ℕ → ℂ) (T W : ℝ) (hT : 1 ≤ T) (hW : 0 ≤ W)
    (ht : ∀ i, |t i| ≤ T) (hs : ∀ i j, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i, W ≤ ‖blockDirichletPolynomial U V a (t i)‖)
    (hpositive : logarithmicKernelConstant*Real.sqrt (2*T)*
      coefficientEnergy (Finset.Ioc U V) a < W^2) :
    (Fintype.card ι : ℝ) ≤
      ((U : ℝ)*(1+2*logarithmicKernelConstant*(1+Real.log (2*T)))*
        coefficientEnergy (Finset.Ioc U V) a)/
      (W^2-logarithmicKernelConstant*Real.sqrt (2*T)*coefficientEnergy (Finset.Ioc U V) a) := by
  apply (le_div_iff₀ (sub_pos.mpr hpositive)).mpr
  exact halasz_block_large_values t U V hU hUV hV a T W hT hW ht hs hw

end Legendre.Density.Oscillation
