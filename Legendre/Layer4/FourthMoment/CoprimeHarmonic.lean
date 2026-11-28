/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.DivisorEnergy

@[expose] public section
namespace Legendre.Density.Moment
open scoped BigOperators

private theorem sum_inv_square_from_two_le (N : ℕ) :
    (∑ k ∈ Finset.Icc 2 N, ((k : ℝ)⁻¹)^2) ≤ 3/4 := by
  suffices h : ∀ N : ℕ, 2 ≤ N →
      (∑ k ∈ Finset.Icc 2 N, ((k : ℝ)⁻¹)^2) ≤ 3/4-(N : ℝ)⁻¹ by
    by_cases hN : 2 ≤ N
    · exact (h N hN).trans (sub_le_self _ (by positivity))
    · rw [Finset.Icc_eq_empty_of_lt (lt_of_not_ge hN),Finset.sum_empty]
      norm_num
  intro N hN
  induction N, hN using Nat.le_induction with
  | base => norm_num [Finset.Icc_self]
  | succ N hN ih =>
    rw [Finset.sum_Icc_succ_top (by omega),Nat.cast_succ]
    have hp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
    have hp' : 0 < (N : ℝ)+1 := by positivity
    have hb : (((N : ℝ)+1)⁻¹)^2 ≤ (N : ℝ)⁻¹-((N : ℝ)+1)⁻¹ := by
      rw [show (N : ℝ)⁻¹-((N : ℝ)+1)⁻¹ = (N : ℝ)⁻¹*((N : ℝ)+1)⁻¹ by field_simp [hp.ne',hp'.ne']; ring,
        pow_two]
      exact mul_le_mul_of_nonneg_right (inv_anti₀ hp (by linarith)) (by positivity)
    linarith only [ih,hb]

/-- Coprime pairs retain at least one quarter of the full harmonic weight. -/
theorem coprime_harmonic_pairs_lower (N : ℕ) :
    (harmonic N : ℝ)^2/4 ≤
      ∑ b ∈ Finset.Icc 1 N, ∑ c ∈ Finset.Icc 1 N,
        if b.Coprime c then (b : ℝ)⁻¹*(c : ℝ)⁻¹ else 0 := by
  let S := Finset.Icc 1 N
  let Q := Finset.Icc 2 N
  let w : ℕ → ℝ := fun n => (n : ℝ)⁻¹
  let H := ∑ n ∈ S, w n
  let A := ∑ b ∈ S, ∑ c ∈ S, if b.Coprime c then w b*w c else 0
  let B := ∑ b ∈ S, ∑ c ∈ S, if b.Coprime c then 0 else w b*w c
  have hHharm : H = (harmonic N : ℝ) := by
    simp [H,w,S,harmonic_eq_sum_Icc,Rat.cast_sum,Rat.cast_inv,Rat.cast_natCast]
  have hsum : A+B = H^2 := by
    dsimp only [A,B,H]
    rw [← Finset.sum_add_distrib]
    simp_rw [← Finset.sum_add_distrib]
    have he (b c : ℕ) : (if b.Coprime c then w b*w c else 0)+
        (if b.Coprime c then 0 else w b*w c) = w b*w c := by split <;> simp
    simp_rw [he,← Finset.mul_sum,← Finset.sum_mul,pow_two]
  have hb (b : ℕ) (hb : b ∈ S) (c : ℕ) (hc : c ∈ S) :
      (if b.Coprime c then 0 else w b*w c) ≤
        ∑ k ∈ Q, if k ∣ b ∧ k ∣ c then w b*w c else 0 := by
    by_cases h : b.Coprime c
    · rw [ite_eq_left h]
      exact Finset.sum_nonneg (fun _ _ => by split <;> positivity)
    rw [ite_eq_right h]
    let d := b.gcd c
    have hne : d ≠ 1 := h
    have hdvd : d ∣ b ∧ d ∣ c := ⟨Nat.gcd_dvd_left _ _,Nat.gcd_dvd_right _ _⟩
    have hdb : d ≤ b := Nat.le_of_dvd (Finset.mem_Icc.mp hb).1 hdvd.1
    have hd₀ : 0 < d := Nat.pos_of_dvd_of_pos hdvd.1 (Finset.mem_Icc.mp hb).1
    have hd : d ∈ Q := Finset.mem_Icc.mpr ⟨by omega,hdb.trans (Finset.mem_Icc.mp hb).2⟩
    have hl := Finset.single_le_sum (s := Q) (f := fun k => if k ∣ b ∧ k ∣ c then w b*w c else 0)
      (fun k _ => by split <;> positivity) hd
    rwa [ite_eq_left hdvd] at hl
  have hBupper : B ≤ (3/4)*H^2 := by
    have hB₁ : B ≤ ∑ b ∈ S, ∑ c ∈ S, ∑ k ∈ Q, if k ∣ b ∧ k ∣ c then w b*w c else 0 :=
      Finset.sum_le_sum (fun b hb₀ => Finset.sum_le_sum (fun c hc₀ => hb b hb₀ c hc₀))
    apply hB₁.trans
    have hswap : (∑ b ∈ S, ∑ c ∈ S, ∑ k ∈ Q, if k ∣ b ∧ k ∣ c then w b*w c else 0) =
        ∑ k ∈ Q, ∑ b ∈ S, ∑ c ∈ S, if k ∣ b ∧ k ∣ c then w b*w c else 0 := by
      calc
        _ = ∑ b ∈ S, ∑ k ∈ Q, ∑ c ∈ S, if k ∣ b ∧ k ∣ c then w b*w c else 0 :=
          Finset.sum_congr rfl (fun _ _ => Finset.sum_comm)
        _ = _ := Finset.sum_comm
    rw [hswap]
    have hrow (k : ℕ) (hk : k ∈ Q) :
        (∑ b ∈ S, ∑ c ∈ S, if k ∣ b ∧ k ∣ c then w b*w c else 0) ≤ H^2*(w k)^2 := by
      let M := S.filter (k ∣ ·)
      have hfactor : (∑ b ∈ S, ∑ c ∈ S, if k ∣ b ∧ k ∣ c then w b*w c else 0) =
          (∑ b ∈ M, w b)^2 := by
        rw [pow_two,Finset.sum_mul]
        simp_rw [Finset.mul_sum]
        dsimp only [M]
        rw [Finset.sum_filter]
        apply Finset.sum_congr rfl
        intro b _
        rw [Finset.sum_filter]
        by_cases h : k ∣ b <;> simp [h]
      rw [hfactor]
      have hK : 0 < k := by have := (Finset.mem_Icc.mp hk).1; omega
      have hd := harmonic_multiples_le N k hK
      change (∑ b ∈ M, w b) ≤ w k*H at hd
      exact (pow_le_pow_left₀ (Finset.sum_nonneg (fun _ _ => by dsimp [w]; positivity)) hd 2).trans_eq
        (by ring)
    apply (Finset.sum_le_sum hrow).trans
    rw [← Finset.mul_sum]
    exact (mul_le_mul_of_nonneg_left (sum_inv_square_from_two_le N) (sq_nonneg H)).trans_eq (by ring)
  rw [← hHharm]
  change H^2/4 ≤ A
  linarith only [hsum,hBupper]

end Legendre.Density.Moment
