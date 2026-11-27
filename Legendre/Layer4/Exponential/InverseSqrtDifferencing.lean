/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The finite column and interval arguments adapt VanDerCorput.lean in openai/math
(lean/OAI/NumberTheory/EgyptianFractions/, pinned commit
4eaee87548250b2682affda7d05d947c05554bae, Apache-2.0). The inverse-square-root
lag summation is proved locally. Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.Exponential.NaturalDifferencing

@[expose] public section
namespace Legendre.Density.Oscillation.Tools
open Complex ComplexConjugate

private theorem sum_inverse_sqrt_le (H : ℕ) :
    (∑ h ∈ Finset.range H, (√((h : ℝ)+1))⁻¹) ≤ 2*√(H : ℝ) := by
  induction H with
  | zero => simp
  | succ H ih =>
    rw [Finset.sum_range_succ, Nat.cast_succ]
    have hpos : 0 < √((H : ℝ)+1) := Real.sqrt_pos.2 (by positivity)
    have hmono := Real.sqrt_le_sqrt (show (H : ℝ) ≤ H+1 by linarith)
    have h1 : (√((H : ℝ)+1))⁻¹ ≤ 2*(√((H : ℝ)+1)-√(H : ℝ)) := by
      rw [← one_div]
      apply (div_le_iff₀ hpos).2
      nlinarith only [Real.sq_sqrt (show 0 ≤ (H : ℝ)+1 by positivity),
        Real.sq_sqrt (Nat.cast_nonneg H : (0 : ℝ) ≤ H),sq_nonneg (√((H : ℝ)+1)-√(H : ℝ))]
    linarith only [ih,h1]

private theorem sum_lag_inverse_sqrt_le (H t : ℕ) (ht : t < H) :
    (∑ s ∈ (Finset.range H).erase t, (√(((t : ℤ)-s).natAbs : ℝ))⁻¹) ≤ 4*√(H : ℝ) := by
  classical
  let S := (Finset.range H).erase t
  let A := S.filter (· < t)
  let B := S.filter (t < ·)
  let f := fun s : ℕ => (√(((t : ℤ)-s).natAbs : ℝ))⁻¹
  let g := fun h : ℕ => (√((h : ℝ)+1))⁻¹
  have hS : A ∪ B = S := by
    ext s
    simp only [A,B,S,Finset.mem_union,Finset.mem_filter,Finset.mem_erase,Finset.mem_range]
    omega
  have hAB : Disjoint A B := Finset.disjoint_left.mpr (by
    intro s hs hs'
    exact (Finset.mem_filter.mp hs).2.asymm (Finset.mem_filter.mp hs').2)
  have hA : ∑ s ∈ A, f s ≤ ∑ h ∈ Finset.range H, g h := by
    refine Finset.sum_le_sum_of_injOn (fun s => t-s-1) ?_ ?_ ?_ ?_
    · intro s hs s' hs' he
      have hst := (Finset.mem_filter.mp hs).2
      have hst' := (Finset.mem_filter.mp hs').2
      dsimp only at he
      omega
    · intro h hh
      obtain ⟨s,hs,rfl⟩ := Finset.mem_image.mp hh
      have hst := (Finset.mem_filter.mp hs).2
      exact Finset.mem_range.mpr (by omega)
    · intro s hs
      have hst := (Finset.mem_filter.mp hs).2
      have hh : ((t : ℤ)-s).natAbs = t-s-1+1 := by omega
      simp only [f,g,hh,Nat.cast_add,Nat.cast_one,le_refl]
    · intro h _ _
      dsimp [g]
      positivity
  have hB : ∑ s ∈ B, f s ≤ ∑ h ∈ Finset.range H, g h := by
    refine Finset.sum_le_sum_of_injOn (fun s => s-t-1) ?_ ?_ ?_ ?_
    · intro s hs s' hs' he
      have hst := (Finset.mem_filter.mp hs).2
      have hst' := (Finset.mem_filter.mp hs').2
      dsimp only at he
      omega
    · intro h hh
      obtain ⟨s,hs,rfl⟩ := Finset.mem_image.mp hh
      have hh := Finset.mem_filter.mp hs
      have hsh := Finset.mem_range.mp (Finset.mem_erase.mp hh.1).2
      exact Finset.mem_range.mpr (by omega)
    · intro s hs
      have hst := (Finset.mem_filter.mp hs).2
      have hh : ((t : ℤ)-s).natAbs = s-t-1+1 := by omega
      simp only [f,g,hh,Nat.cast_add,Nat.cast_one,le_refl]
    · intro h _ _
      dsimp [g]
      positivity
  change ∑ s ∈ S, f s ≤ _
  rw [← hS, Finset.sum_union hAB]
  have h := sum_inverse_sqrt_le H
  change (∑ h ∈ Finset.range H, g h) ≤ _ at h
  linarith only [h,hA,hB]

/-- Finite differencing with an explicit sum of the off-diagonal column bounds. -/
private theorem averaged_columns_row_bound {α β : Type*} [DecidableEq β]
    (U : Finset α) (T : Finset β) (z : α → β → ℂ)
    (S : ℂ) (D E : ℝ)
    (hcol : ∀ t ∈ T, ∑ u ∈ U, z u t = S)
    (hdiag : ∀ t ∈ T, ∑ u ∈ U, ‖z u t‖ ^ 2 ≤ D)
    (hrow : ∀ t ∈ T, ∑ s ∈ T.erase t, ‖∑ u ∈ U, z u t * conj (z u s)‖ ≤ E) :
    (T.card : ℝ)^2*‖S‖^2 ≤ (U.card : ℝ)*((T.card : ℝ)*(D+E)) := by
  have havg : (∑ u ∈ U, ∑ t ∈ T, z u t) = (T.card : ℂ)*S := by
    rw [Finset.sum_comm]
    simp_rw [Finset.sum_congr rfl hcol]
    simp
  have hcs := norm_sum_sq_le_card_mul_sum_norm_sq U (fun u => ∑ t ∈ T, z u t)
  rw [havg,norm_mul,Complex.norm_natCast,mul_pow] at hcs
  apply hcs.trans
  apply mul_le_mul_of_nonneg_left _ (Nat.cast_nonneg _)
  rw [finite_complex_second_moment_identity]
  have hentry (t : β) (ht : t ∈ T) :
      (∑ s ∈ T, (∑ u ∈ U, z u t*conj (z u s)).re) ≤ D+E := by
    rw [← Finset.sum_erase_add _ _ ht]
    have hd := hdiag t ht
    have hnorm := Finset.sum_le_sum (s := T.erase t)
      (fun s _ => Complex.re_le_norm (∑ u ∈ U, z u t*conj (z u s)))
    simp only [re_finset_sum,Complex.mul_conj,Complex.ofReal_re,Complex.normSq_eq_norm_sq]
    simpa only [re_finset_sum] using (add_le_add (hnorm.trans (hrow t ht)) hd).trans_eq (add_comm E D)
  exact (Finset.sum_le_sum hentry).trans_eq (by simp [Finset.sum_const,nsmul_eq_mul,mul_add])

/-- Interval differencing preserves the saving from inverse-square-root lag costs. -/
theorem van_der_corput_nat_interval_inverse_sqrt (a : ℕ → ℂ) (N H : ℕ)
    (hH : 1 ≤ H) (hHN : H ≤ N) (A B : ℝ) (hA : 0 ≤ A) (hB : 0 ≤ B)
    (hnorm : ∀ n ∈ Finset.Icc 1 N, ‖a n‖ ≤ 1)
    (hcorr : ∀ h : ℕ, 1 ≤ h → h < H →
      ‖∑ n ∈ Finset.Icc 1 (N-h), a (n+h)*conj (a n)‖ ≤ A+B*(√(h : ℝ))⁻¹) :
    ‖∑ n ∈ Finset.Icc 1 N, a n‖^2 ≤
      2*(N : ℝ)^2/H+2*(N : ℝ)*(A+4*B*(√(H : ℝ))⁻¹) := by
  classical
  let b := intervalZeroExtension a N
  let U := Finset.Icc (1-(H : ℤ)) (N : ℤ)
  let T := Finset.range H
  let z : ℤ → ℕ → ℂ := fun n t => b (n+t)
  have hsupp (n : ℤ) (hn : n ∉ Finset.Icc (1 : ℤ) N) : b n = 0 := by
    simp [b,intervalZeroExtension,hn]
  have hsup (n : ℤ) : ‖b n‖ ≤ 1 := by
    by_cases hn : n ∈ Finset.Icc (1 : ℤ) N
    · have hh := Finset.mem_Icc.mp hn
      simpa [b,intervalZeroExtension,hn] using hnorm n.toNat (Finset.mem_Icc.mpr ⟨by omega,by omega⟩)
    · simp [hsupp n hn]
  have hcardU : (U.card : ℝ) = (N : ℝ)+H := by
    dsimp only [U]
    rw [Int.card_Icc]
    rw [show (N : ℤ)+1-(1-(H : ℤ)) = ((N+H : ℕ) : ℤ) by omega]
    norm_cast
  have hcol (t : ℕ) (ht : t ∈ T) :
      (∑ n ∈ U, z n t) = ∑ n ∈ Finset.Icc (1 : ℤ) N, b n :=
    sum_shift_supported b N H t (by omega) (by have := Finset.mem_range.mp ht; omega) hsupp
  have hdiag (t : ℕ) (ht : t ∈ T) : (∑ n ∈ U, ‖z n t‖^2) ≤ (N : ℝ) := by
    change (∑ n ∈ U, ‖b (n+t)‖^2) ≤ _
    rw [sum_shift_supported (fun n => ‖b n‖^2) N H t (by omega) (by have := Finset.mem_range.mp ht; omega)
      (fun n hn => by simp [hsupp n hn])]
    calc
      _ ≤ ∑ n ∈ Finset.Icc (1 : ℤ) N, (1 : ℝ) := Finset.sum_le_sum (fun n _ => by
        simpa using pow_le_pow_left₀ (norm_nonneg _) (hsup n) 2)
      _ = _ := by simp [Int.card_Icc]
  have hpair (t s : ℕ) (ht : t ∈ T) (hs : s ∈ T) (hne : s ≠ t) :
      ‖∑ n ∈ U, z n t*conj (z n s)‖ ≤ A+B*(√(((t : ℤ)-s).natAbs : ℝ))⁻¹ := by
    let d := (t : ℤ)-s
    let c := fun n : ℤ => b (n+d)*conj (b n)
    have hh (n : ℤ) (hn : n ∉ Finset.Icc (1 : ℤ) N) : c n = 0 := by
      simp [c,hsupp n hn]
    have he : (∑ n ∈ U, z n t*conj (z n s)) = ∑ n ∈ U, c (n+s) := by
      apply Finset.sum_congr rfl
      intro n _
      simp [z,c,d]
    have htH := Finset.mem_range.mp ht
    have hsH := Finset.mem_range.mp hs
    rw [he, sum_shift_supported c N H s (by omega) (by omega) hh]
    change ‖∑ n ∈ Finset.Icc (1 : ℤ) N, b (n+d)*conj (b n)‖ ≤ A+B*(√(d.natAbs : ℝ))⁻¹
    have hp (j : ℤ) (hj : 0 < j) (hjH : j < H) :
        ‖∑ n ∈ Finset.Icc (1 : ℤ) N, b (n+j)*conj (b n)‖ ≤ A+B*(√(j.natAbs : ℝ))⁻¹ := by
      have hjn : (j.toNat : ℤ) = j := Int.toNat_of_nonneg hj.le
      rw [← hjn,intervalZeroExtension_correlation a N j.toNat (by omega)]
      simpa only [Int.natAbs_natCast] using hcorr j.toNat (by omega) (by omega)
    by_cases hd : 0 < d
    · exact hp d hd (by dsimp only [d]; omega)
    · have ho := interval_correlation_neg b N (-d) hsupp
      rw [neg_neg] at ho
      rw [ho,Complex.norm_conj, ← Int.natAbs_neg]
      exact hp (-d) (by dsimp only [d] at hd ⊢; omega) (by dsimp only [d]; omega)
  have hrow (t : ℕ) (ht : t ∈ T) :
      (∑ s ∈ T.erase t, ‖∑ n ∈ U, z n t*conj (z n s)‖) ≤ (H : ℝ)*A+4*B*√(H : ℝ) := by
    calc
      _ ≤ ∑ s ∈ T.erase t, (A+B*(√(((t : ℤ)-s).natAbs : ℝ))⁻¹) :=
        Finset.sum_le_sum (fun s hs => hpair t s ht (Finset.mem_of_mem_erase hs) (Finset.ne_of_mem_erase hs))
      _ ≤ _ := by
        rw [Finset.sum_add_distrib, Finset.sum_const, nsmul_eq_mul, ← Finset.mul_sum]
        have hcard : ((T.erase t).card : ℝ) ≤ H := by
          exact_mod_cast (show (T.erase t).card ≤ H by
            simpa only [T,Finset.card_range] using Finset.card_erase_le (s := T) (a := t))
        have h₁ := mul_le_mul_of_nonneg_right hcard hA
        have h₂ := mul_le_mul_of_nonneg_left (sum_lag_inverse_sqrt_le H t (Finset.mem_range.mp ht)) hB
        change B*(∑ s ∈ T.erase t, (√(((t : ℤ)-s).natAbs : ℝ))⁻¹) ≤ _ at h₂
        nlinarith only [h₁,h₂]
  have hb := averaged_columns_row_bound U T z _ (N : ℝ) _ hcol hdiag hrow
  simp only [T, Finset.card_range, hcardU, b, intervalZeroExtension_sum] at hb
  have hHp : (0 : ℝ) < H := by exact_mod_cast (show 0 < H by omega)
  have hHN' : (H : ℝ) ≤ N := by exact_mod_cast hHN
  have hr : (0 : ℝ) < √(H : ℝ) := Real.sqrt_pos.2 hHp
  apply (mul_le_mul_iff_right₀ (sq_pos_of_pos hHp)).mp
  have he : (H : ℝ)^2*(2*(N : ℝ)^2/H+2*(N : ℝ)*(A+4*B*(√(H : ℝ))⁻¹)) =
      (2*(N : ℝ))*((H : ℝ)*((N : ℝ)+((H : ℝ)*A+4*B*√(H : ℝ)))) := by
    field_simp [hHp.ne',hr.ne']
    ring_nf
    rw [Real.sq_sqrt hHp.le]
  rw [he]
  exact hb.trans (mul_le_mul_of_nonneg_right (by linarith only [hHN']) (by positivity))

end Legendre.Density.Oscillation.Tools
