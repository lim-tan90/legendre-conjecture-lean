/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local harmonic analogue of the existing separated inverse-square bound.
The ordered-point lower bound is reused from LargeSieve; the finite harmonic
sum is retained instead of being replaced by a convergent zeta value.
-/
module
public import Legendre.LargeSieve.SeparatedInverseSquares
public import Legendre.DirichletSpacing

@[expose] public section
namespace Legendre.Density.Oscillation
open scoped BigOperators

theorem finite_positive_inverses (n : ℕ) :
    (∑ i : Fin n, 1/((i.val : ℝ)+1)) = (harmonic n : ℝ) := by
  rw [Fin.sum_univ_eq_sum_range (fun j : ℕ => 1/((j : ℝ)+1)) n]
  simp only [harmonic,Rat.cast_sum,Rat.cast_inv,Rat.cast_add,Rat.cast_one,Rat.cast_natCast,Nat.cast_add,Nat.cast_one,one_div]

theorem positive_separated_reciprocals (S : Finset ℝ) (H : ℝ) (hH : 1 ≤ H)
    (hfirst : ∀ x ∈ S, 1 ≤ x) (hupper : ∀ x ∈ S, x ≤ H)
    (hsep : ∀ x ∈ S, ∀ y ∈ S, x ≠ y → 1 ≤ |x-y|) :
    (∑ x ∈ S, 1/x) ≤ 1+Real.log H := by
  classical
  by_cases hs : S.Nonempty
  · let e := S.orderEmbOfFin rfl
    have he (i : Fin S.card) : e i ∈ S := S.orderEmbOfFin_mem rfl i
    have hg (i j : Fin S.card) (hij : i < j) : 1 ≤ e j-e i := by
      have hij' := e.strictMono hij
      have hh := hsep (e j) (he j) (e i) (he i) (ne_of_gt hij')
      rwa [abs_of_pos (sub_pos.mpr hij')] at hh
    have hl := LargeSieve.ordered_separated_lower (fun i => e i) 1
      (fun i => hfirst _ (he i)) hg
    have hcardp : 0 < S.card := Finset.card_pos.mpr hs
    let last : Fin S.card := ⟨S.card-1,by omega⟩
    have hcard : (S.card : ℝ) ≤ H := by
      have hh := (hl last).trans (hupper _ (he last))
      have heq : ((S.card-1 : ℕ) : ℝ)+1 = S.card := by
        exact_mod_cast (Nat.sub_add_cancel (show 1 ≤ S.card by omega))
      simpa only [last,one_mul,heq] using hh
    have hsum : (∑ x ∈ S, 1/x) = ∑ i : Fin S.card, 1/(e i) := by
      conv_lhs => rw [←S.image_orderEmbOfFin_univ rfl]
      rw [Finset.sum_image]
      exact fun i _ j _ hij => e.injective hij
    calc
      _ = ∑ i : Fin S.card, 1/(e i) := hsum
      _ ≤ ∑ i : Fin S.card, 1/((i.val : ℝ)+1) := by
        apply Finset.sum_le_sum
        intro i hi
        exact one_div_le_one_div_of_le (by positivity) (by simpa only [one_mul] using hl i)
      _ = (harmonic S.card : ℝ) := finite_positive_inverses _
      _ ≤ 1+Real.log S.card := harmonic_le_one_add_log _
      _ ≤ _ := by gcongr
  · have he : S = ∅ := Finset.not_nonempty_iff_eq_empty.mp hs
    simp only [he,Finset.sum_empty]
    have hh := Real.log_nonneg hH
    linarith

/-- Both sides of a separated set contribute at most one harmonic row. -/
theorem separated_reciprocals (S : Finset ℝ) (H : ℝ) (hH : 1 ≤ H)
    (hfirst : ∀ x ∈ S, 1 ≤ |x|) (hupper : ∀ x ∈ S, |x| ≤ H)
    (hsep : ∀ x ∈ S, ∀ y ∈ S, x ≠ y → 1 ≤ |x-y|) :
    (∑ x ∈ S, 1/|x|) ≤ 2*(1+Real.log H) := by
  classical
  let P := S.filter (fun x => 0 < x)
  let N := S.filter (fun x => ¬0 < x)
  let R := N.image (fun x => -x)
  have hP := positive_separated_reciprocals P H hH
    (by intro x hx; have hh := Finset.mem_filter.mp hx
        simpa only [abs_of_pos hh.2] using hfirst x hh.1)
    (fun x hx => (le_abs_self x).trans (hupper x (Finset.mem_filter.mp hx).1))
    (fun x hx y hy hxy => hsep x (Finset.mem_filter.mp hx).1 y (Finset.mem_filter.mp hy).1 hxy)
  have hR := positive_separated_reciprocals R H hH
    (by
      intro x hx
      obtain ⟨y,hy,rfl⟩ := Finset.mem_image.mp hx
      have hh := Finset.mem_filter.mp hy
      simpa only [abs_of_nonpos (le_of_not_gt hh.2)] using hfirst y hh.1)
    (by
      intro x hx
      obtain ⟨y,hy,rfl⟩ := Finset.mem_image.mp hx
      have hh := Finset.mem_filter.mp hy
      simpa only [abs_of_nonpos (le_of_not_gt hh.2)] using hupper y hh.1)
    (by
      intro x hx y hy hxy
      obtain ⟨a,ha,rfl⟩ := Finset.mem_image.mp hx
      obtain ⟨b,hb,rfl⟩ := Finset.mem_image.mp hy
      have hh := hsep a (Finset.mem_filter.mp ha).1 b (Finset.mem_filter.mp hb).1
        (fun he => hxy (congrArg Neg.neg he))
      simpa only [neg_sub_neg,abs_sub_comm] using hh)
  have heP : (∑ x ∈ P, 1/|x|) = ∑ x ∈ P, 1/x := by
    apply Finset.sum_congr rfl
    intro x hx
    rw [abs_of_pos (Finset.mem_filter.mp hx).2]
  have heR : (∑ x ∈ R, 1/x) = ∑ x ∈ N, 1/|x| := by
    rw [Finset.sum_image]
    · apply Finset.sum_congr rfl
      intro x hx
      rw [abs_of_nonpos (le_of_not_gt (Finset.mem_filter.mp hx).2)]
    · exact fun _ _ _ _ he => neg_injective he
  have hsplit := Finset.sum_filter_add_sum_filter_not S (fun x => 0 < x) (fun x => 1/|x|)
  change (∑ x ∈ P, 1/|x|)+(∑ x ∈ N, 1/|x|) = _ at hsplit
  rw [heP,←heR] at hsplit
  linarith

end Legendre.Density.Oscillation
