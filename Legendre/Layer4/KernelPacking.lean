/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityKernelPacking.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Reuses the already credited separated inverse-square proof.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.HeightWeight
public import Legendre.LargeSieve.SeparatedSetSquares

@[expose] public section
namespace Legendre.Density.Moment
open scoped BigOperators
 theorem criticalWeight_le_inverse_square (u : ℝ) (hu : u ≠ 0) :
    Detector.Smooth.criticalWeight u ≤ 1 / u ^ 2 := by
  unfold Detector.Smooth.criticalWeight
  apply one_div_le_one_div_of_le (sq_pos_of_ne_zero hu)
  have he : u ^ 2 = |u| ^ 2 := (sq_abs u).symm
  rw [he]
  nlinarith [abs_nonneg u, sq_nonneg |u|]

 theorem criticalWeight_separated_sum (S : Finset ℝ)
    (hsep : ∀ x ∈ S, ∀ y ∈ S, x ≠ y → 1 ≤ |x - y|) (v : ℝ) :
    (∑ x ∈ S, Detector.Smooth.criticalWeight (v - x)) ≤ 1 + 4 * Real.pi ^ 2 / 3 := by
  classical
  let A := S.filter (fun x => |v - x| < 1 / 2)
  let B := S.filter (fun x => ¬ |v - x| < 1 / 2)
  have hA : A.card ≤ 1 := by
    apply Finset.card_le_one.mpr
    intro x hx y hy
    by_contra hxy
    have hx' := Finset.mem_filter.mp hx
    have hy' := Finset.mem_filter.mp hy
    have hd := hsep x hx'.1 y hy'.1 hxy
    have ht : |x - y| ≤ |v - x| + |v - y| := by
      calc
        _ = |(v - y) - (v - x)| := by congr 1; ring
        _ ≤ |v - y| + |v - x| := by
          simpa only [sub_eq_add_neg, abs_neg] using abs_add_le (v - y) (-(v - x))
        _ = _ := by ring
    linarith
  have hnear : (∑ x ∈ A, Detector.Smooth.criticalWeight (v - x)) ≤ 1 := by
    calc
      _ ≤ ∑ _x ∈ A, (1 : ℝ) := Finset.sum_le_sum (fun x _ => criticalWeight_le_one (v - x))
      _ = (A.card : ℝ) := by simp
      _ ≤ 1 := by exact_mod_cast hA
  let R := B.image (fun x => v - x)
  have hinj : Function.Injective (fun x : ℝ => v - x) := by
    intro x y h
    linarith
  have hRfirst : ∀ x ∈ R, (1 / 2 : ℝ) ≤ |x| := by
    intro x hx
    obtain ⟨y, hy, rfl⟩ := Finset.mem_image.mp hx
    exact le_of_not_gt (Finset.mem_filter.mp hy).2
  have hRsep : ∀ x ∈ R, ∀ y ∈ R, x ≠ y → (1 / 2 : ℝ) ≤ |x - y| := by
    intro x hx y hy hxy
    obtain ⟨a, ha, rfl⟩ := Finset.mem_image.mp hx
    obtain ⟨b, hb, rfl⟩ := Finset.mem_image.mp hy
    have hab : a ≠ b := fun h => hxy (congrArg (fun z => v - z) h)
    have h := hsep a (Finset.mem_filter.mp ha).1 b (Finset.mem_filter.mp hb).1 hab
    have he : |(v - a) - (v - b)| = |a - b| := by
      rw [show (v - a) - (v - b) = -(a - b) by ring, abs_neg]
    rw [he]
    linarith
  have hfar := LargeSieve.separated_set_inverse_squares R (1 / 2) (by norm_num) hRfirst hRsep
  have hsumR : (∑ x ∈ B, 1 / (v - x) ^ 2) = ∑ x ∈ R, 1 / x ^ 2 := by
    rw [Finset.sum_image]
    exact fun x _ y _ h => hinj h
  have hB : (∑ x ∈ B, Detector.Smooth.criticalWeight (v - x)) ≤ 4 * Real.pi ^ 2 / 3 := by
    calc
      _ ≤ ∑ x ∈ B, 1 / (v - x) ^ 2 := by
        apply Finset.sum_le_sum
        intro x hx
        apply criticalWeight_le_inverse_square
        intro he
        have h := (Finset.mem_filter.mp hx).2
        simp only [he, abs_zero] at h
        norm_num at h
      _ = ∑ x ∈ R, 1 / x ^ 2 := hsumR
      _ ≤ Real.pi ^ 2 / (3 * (1 / 2) ^ 2) := hfar
      _ = _ := by ring
  have hsplit := Finset.sum_filter_add_sum_filter_not S
    (fun x => |v - x| < 1 / 2) (fun x => Detector.Smooth.criticalWeight (v - x))
  change (∑ x ∈ A, Detector.Smooth.criticalWeight (v - x)) +
    (∑ x ∈ B, Detector.Smooth.criticalWeight (v - x)) = _ at hsplit
  linarith

end Legendre.Density.Moment
