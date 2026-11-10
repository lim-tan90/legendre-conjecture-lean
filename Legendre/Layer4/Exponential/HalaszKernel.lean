/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions: actual logarithmic-phase cancellation and harmonic packing
bound the Gram rows for one-separated Dirichlet samples.
-/
module
public import Legendre.Layer4.Exponential.LogKernel
public import Legendre.Layer4.Exponential.SeparatedReciprocals
public import Legendre.GramLargeValues

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def blockDirichletPolynomial (U V : ℕ) (a : ℕ → ℂ) (t : ℝ) : ℂ :=
  ∑ n ∈ Finset.Ioc U V, a n*(n : ℂ)^(-(t : ℂ)*I)

theorem blockDirichletPolynomial_unit (U V : ℕ) (t : ℝ) :
    blockDirichletPolynomial U V (fun _ => 1) t =
      ∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I) := by
  simp only [blockDirichletPolynomial,one_mul]

theorem indexed_reciprocal_row {ι : Type*} [DecidableEq ι] (S : Finset ι) (t : ι → ℝ)
    (T : ℝ) (hT : 1 ≤ T) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) (i : ι) (hi : i ∈ S) :
    (∑ j ∈ S.erase i, 1/|t i-t j|) ≤ 2*(1+Real.log (2*T)) := by
  classical
  let F := S.erase i
  let r := fun j => t j-t i
  let R := F.image r
  have hinj : Set.InjOn r F := by
    intro j hj k hk he
    by_contra hne
    have hh := hs j (Finset.mem_erase.mp hj).2 k (Finset.mem_erase.mp hk).2 hne
    have hz : t j-t k = 0 := by dsimp [r] at he; linarith
    rw [hz,abs_zero] at hh
    norm_num at hh
  have hh := separated_reciprocals R (2*T) (by linarith)
    (by
      intro x hx
      obtain ⟨j,hj,rfl⟩ := Finset.mem_image.mp hx
      exact hs j (Finset.mem_erase.mp hj).2 i hi (Finset.mem_erase.mp hj).1)
    (by
      intro x hx
      obtain ⟨j,hj,rfl⟩ := Finset.mem_image.mp hx
      dsimp [r]
      have hb := abs_sub (t j) (t i)
      linarith [ht j (Finset.mem_erase.mp hj).2,ht i hi])
    (by
      intro x hx y hy hxy
      obtain ⟨j,hj,rfl⟩ := Finset.mem_image.mp hx
      obtain ⟨k,hk,rfl⟩ := Finset.mem_image.mp hy
      have hb := hs j (Finset.mem_erase.mp hj).2 k (Finset.mem_erase.mp hk).2
        (fun he => hxy (congrArg r he))
      convert hb using 1
      congr 1
      dsimp [r]
      ring)
  rw [Finset.sum_image hinj] at hh
  simpa only [r,F,abs_sub_comm] using hh

/-- A proved row bound: diagonal length, harmonic row, and square-root height. -/
theorem logarithmic_kernel_row {ι : Type*} [DecidableEq ι]
    (S : Finset ι) (t : ι → ℝ) (T : ℝ) (hT : 1 ≤ T)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V) (hV : V ≤ 2*U) (i : ι) (hi : i ∈ S) :
    (∑ j ∈ S, ‖blockDirichletPolynomial U V (fun _ => 1) (t i-t j)‖) ≤
      (U : ℝ)+logarithmicKernelConstant*
        ((S.card : ℝ)*Real.sqrt (2*T)+2*(U : ℝ)*(1+Real.log (2*T))) := by
  classical
  have hC := logarithmicKernelConstant_pos
  have hdiag : ‖blockDirichletPolynomial U V (fun _ => 1) (t i-t i)‖ ≤ (U : ℝ) := by
    simp only [sub_self,blockDirichletPolynomial,Complex.ofReal_zero,neg_zero,zero_mul,
      Complex.cpow_zero,mul_one,Finset.sum_const,Nat.card_Ioc,nsmul_eq_mul,mul_one,
      Complex.norm_natCast]
    exact_mod_cast (show V-U ≤ U by omega)
  have hterm : ∀ j ∈ S.erase i,
      ‖blockDirichletPolynomial U V (fun _ => 1) (t i-t j)‖ ≤
        logarithmicKernelConstant*(Real.sqrt (2*T)+(U : ℝ)/|t i-t j|) := by
    intro j hj
    have hsep := hs i hi j (Finset.mem_erase.mp hj).2 (Finset.mem_erase.mp hj).1.symm
    have hne : t i-t j ≠ 0 := abs_pos.mp (by linarith)
    have hbound : |t i-t j| ≤ 2*T := by
      have hb := abs_sub (t i) (t j)
      linarith [ht i hi,ht j (Finset.mem_erase.mp hj).2]
    rw [blockDirichletPolynomial_unit]
    exact (logarithmic_block_kernel U V hU hUV hV _ hne).trans
      (mul_le_mul_of_nonneg_left (add_le_add (Real.sqrt_le_sqrt hbound) le_rfl) hC.le)
  have hsum := Finset.sum_le_sum hterm
  have hrecip := indexed_reciprocal_row S t T hT ht hs i hi
  have he : (∑ j ∈ S.erase i, logarithmicKernelConstant*
      (Real.sqrt (2*T)+(U : ℝ)/|t i-t j|)) =
      logarithmicKernelConstant*(((S.erase i).card : ℝ)*Real.sqrt (2*T)+
        (U : ℝ)*(∑ j ∈ S.erase i, 1/|t i-t j|)) := by
    simp only [Finset.mul_sum,Finset.sum_add_distrib,Finset.sum_const,nsmul_eq_mul,
      mul_add,div_eq_mul_inv,one_mul,mul_assoc]
    ring
  rw [he] at hsum
  have hc : ((S.erase i).card : ℝ) ≤ S.card := by exact_mod_cast Finset.card_erase_le
  have hb := mul_le_mul_of_nonneg_left
    (add_le_add (mul_le_mul_of_nonneg_right hc (Real.sqrt_nonneg (2*T)))
      (mul_le_mul_of_nonneg_left hrecip (Nat.cast_nonneg U))) hC.le
  rw [←Finset.sum_erase_add _ _ hi]
  have hf := add_le_add (hsum.trans hb) hdiag
  convert hf using 1 <;> ring

end Legendre.Density.Oscillation
