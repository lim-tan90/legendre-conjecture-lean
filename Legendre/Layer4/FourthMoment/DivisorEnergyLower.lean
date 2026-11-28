/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.CoprimeHarmonic

@[expose] public section
namespace Legendre.Density.Moment
open scoped BigOperators

/-- Coprime quadruples embed into ordered pairs of divisors of their product. -/
theorem divisor_square_harmonic_fourth_lower (N : ℕ) :
    (harmonic N : ℝ)^4/4 ≤ ∑ n ∈ Finset.Icc 1 (N^4), (n.divisors.card : ℝ)^2/n := by
  classical
  let S := Finset.Icc 1 N
  let T := (S.product (S.product (S.product S))).filter (fun p => p.2.1.Coprime p.2.2.1)
  let U := (Finset.Icc 1 (N^4)).sigma (fun n => n.divisors.product n.divisors)
  let w : ℕ → ℝ := fun n => (n : ℝ)⁻¹
  let a : ℕ × ℕ × ℕ × ℕ → ℕ := Prod.fst
  let b : ℕ × ℕ × ℕ × ℕ → ℕ := fun p => p.2.1
  let c : ℕ × ℕ × ℕ × ℕ → ℕ := fun p => p.2.2.1
  let d : ℕ × ℕ × ℕ × ℕ → ℕ := fun p => p.2.2.2
  let m := fun p => a p*b p*c p*d p
  let e : ℕ × ℕ × ℕ × ℕ → (Σ _ : ℕ, ℕ×ℕ) :=
    fun p => ⟨m p,(a p*b p,a p*c p)⟩
  have hmem (p : ℕ × ℕ × ℕ × ℕ) (hp : p ∈ T) :
      a p ∈ S ∧ b p ∈ S ∧ c p ∈ S ∧ d p ∈ S ∧ (b p).Coprime (c p) := by
    obtain ⟨hh,hcop⟩ := Finset.mem_filter.mp hp
    obtain ⟨hi,hjk⟩ := Finset.mem_product.mp hh
    obtain ⟨hj,hkl⟩ := Finset.mem_product.mp hjk
    obtain ⟨hk,hl⟩ := Finset.mem_product.mp hkl
    exact ⟨hi,hj,hk,hl,hcop⟩
  have hpos (n : ℕ) (hn : n ∈ S) : 0 < n := (Finset.mem_Icc.mp hn).1
  have hhi (n : ℕ) (hn : n ∈ S) : n ≤ N := (Finset.mem_Icc.mp hn).2
  have hU (p : ℕ × ℕ × ℕ × ℕ) (hp : p ∈ T) : e p ∈ U := by
    obtain ⟨ha,hb,hc,hd,_⟩ := hmem p hp
    have hm : 0 < m p := Nat.mul_pos (Nat.mul_pos (Nat.mul_pos (hpos _ ha) (hpos _ hb)) (hpos _ hc)) (hpos _ hd)
    have hmhi : m p ≤ N^4 := by
      have hh := Nat.mul_le_mul (Nat.mul_le_mul (Nat.mul_le_mul (hhi _ ha) (hhi _ hb)) (hhi _ hc)) (hhi _ hd)
      convert hh using 1
      ring
    have h₁ : a p*b p ∣ m p := ⟨c p*d p,by dsimp only [m]; ring⟩
    have h₂ : a p*c p ∣ m p := ⟨b p*d p,by dsimp only [m]; ring⟩
    exact Finset.mem_sigma.mpr ⟨Finset.mem_Icc.mpr ⟨hm,hmhi⟩,Finset.mem_product.mpr
      ⟨Nat.mem_divisors.mpr ⟨h₁,hm.ne'⟩,Nat.mem_divisors.mpr ⟨h₂,hm.ne'⟩⟩⟩
  have hinj : Set.InjOn e T := by
    intro p hp q hq he
    obtain ⟨ha,hb,hc,_,hcop⟩ := hmem p hp
    have hcop' := (hmem q hq).2.2.2.2
    have hm : m p = m q := congrArg Sigma.fst he
    have h₁ : a p*b p = a q*b q := congrArg (fun z : Σ _ : ℕ, ℕ×ℕ => z.2.1) he
    have h₂ : a p*c p = a q*c q := congrArg (fun z : Σ _ : ℕ, ℕ×ℕ => z.2.2) he
    have hA : a p = a q := by
      have hh := congrArg₂ Nat.gcd h₁ h₂
      rw [Nat.gcd_mul_left,Nat.gcd_mul_left,hcop.gcd_eq_one,hcop'.gcd_eq_one,mul_one,mul_one] at hh
      exact hh
    have hB : b p = b q := Nat.eq_of_mul_eq_mul_left (hpos _ ha) (by rwa [← hA] at h₁)
    have hC : c p = c q := Nat.eq_of_mul_eq_mul_left (hpos _ ha) (by rwa [← hA] at h₂)
    have hD : d p = d q := Nat.eq_of_mul_eq_mul_left (Nat.mul_pos (Nat.mul_pos (hpos _ ha) (hpos _ hb)) (hpos _ hc))
      (by simpa only [m,← hA,← hB,← hC] using hm)
    exact Prod.ext hA (Prod.ext hB (Prod.ext hC hD))
  have hb : (∑ p ∈ T, w (m p)) ≤ ∑ p ∈ U, w p.1 :=
    Finset.sum_le_sum_of_injOn e hinj
      (by intro p hp; obtain ⟨q,hq,rfl⟩ := Finset.mem_image.mp hp; exact hU q hq)
      (fun _ _ => le_rfl) (by intro p _ _; dsimp [w]; positivity)
  have hr : (∑ p ∈ U, w p.1) = ∑ n ∈ Finset.Icc 1 (N^4), (n.divisors.card : ℝ)^2/n := by
    dsimp only [U]
    rw [Finset.sum_sigma]
    apply Finset.sum_congr rfl
    intro n _
    simp [Finset.card_product,nsmul_eq_mul,pow_two,div_eq_mul_inv,w]
  let H := ∑ k ∈ S, w k
  let W := ∑ j ∈ S, ∑ k ∈ S, if j.Coprime k then w j*w k else 0
  have hHharm : H = (harmonic N : ℝ) := by
    simp [H,w,S,harmonic_eq_sum_Icc,Rat.cast_sum,Rat.cast_inv,Rat.cast_natCast]
  have hw : (∑ p ∈ T, w (m p)) = H^2*W := by
    unfold T
    rw [Finset.sum_filter]
    have he :
        (∑ p ∈ S.product (S.product (S.product S)),
          if (b p).Coprime (c p) then w (m p) else 0) =
        ∑ i ∈ S, ∑ j ∈ S, ∑ k ∈ S, ∑ l ∈ S, if j.Coprime k then w (i*j*k*l) else 0 := by
      calc
        _ = ∑ i ∈ S, ∑ p ∈ S.product (S.product S),
            if p.1.Coprime p.2.1 then w (i*p.1*p.2.1*p.2.2) else 0 :=
          Finset.sum_product _ _ _
        _ = _ := by
          apply Finset.sum_congr rfl
          intro i _
          calc
            _ = ∑ j ∈ S, ∑ q ∈ S.product S, if j.Coprime q.1 then w (i*j*q.1*q.2) else 0 :=
              Finset.sum_product _ _ _
            _ = _ := Finset.sum_congr rfl (fun _ _ => Finset.sum_product _ _ _)
    rw [he]
    have hprod (i j k l : ℕ) : (if j.Coprime k then w (i*j*k*l) else 0) =
        w i*(if j.Coprime k then w j*w k else 0)*w l := by
      split
      · simp only [w,Nat.cast_mul,mul_inv_rev]
        ring
      · simp
    simp_rw [hprod,← Finset.mul_sum]
    change (∑ i ∈ S, ∑ j ∈ S, ∑ k ∈ S, w i*(if j.Coprime k then w j*w k else 0)*H) = _
    simp_rw [show ∀ i j k : ℕ,
      w i*(if j.Coprime k then w j*w k else 0)*H = (w i*H)*(if j.Coprime k then w j*w k else 0)
      by intro i j k; ring, ← Finset.mul_sum]
    change (∑ i ∈ S, (w i*H)*W) = H^2*W
    rw [← Finset.sum_mul,← Finset.sum_mul,pow_two]
  rw [← hHharm,← hr]
  have hW : H^2/4 ≤ W := by rw [hHharm]; exact coprime_harmonic_pairs_lower N
  have hh := mul_le_mul_of_nonneg_left hW (sq_nonneg H)
  have hleft : H^4/4 ≤ H^2*W := by nlinarith only [hh]
  rw [hw] at hb
  exact hleft.trans hb

/-- Harmonic divisor-square energy has at least four logarithms. -/
theorem divisor_square_harmonic_log_four_lower (N : ℕ) (hN : 1 ≤ N) :
    (Real.log N)^4/1024 ≤ ∑ n ∈ Finset.Icc 1 N, (n.divisors.card : ℝ)^2/n := by
  let r := (N : ℝ)^(1/4 : ℝ)
  let M := ⌊r⌋₊
  have hN₁ : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hNp : (0 : ℝ) < N := zero_lt_one.trans_le hN₁
  have hr : 0 ≤ r := by dsimp [r]; positivity
  have hM : M^4 ≤ N := by
    have hh := pow_le_pow_left₀ (Nat.cast_nonneg M) (Nat.floor_le hr) 4
    have he : r^4 = (N : ℝ) := by
      dsimp only [r]
      rw [← Real.rpow_mul_natCast hNp.le,Nat.cast_ofNat]
      norm_num
    rw [he] at hh
    exact_mod_cast hh
  have hlog : (1/4)*Real.log N ≤ (harmonic M : ℝ) := by
    have hh := log_le_harmonic_floor r hr
    rw [Real.log_rpow hNp] at hh
    exact hh
  apply le_trans _ ((divisor_square_harmonic_fourth_lower M).trans
    (Finset.sum_le_sum_of_subset_of_nonneg (Finset.Icc_subset_Icc_right hM) (fun _ _ _ => by positivity)))
  have hp := pow_le_pow_left₀ (show 0 ≤ (1/4:ℝ)*Real.log N by positivity [Real.log_nonneg hN₁]) hlog 4
  nlinarith only [hp]

end Legendre.Density.Moment
