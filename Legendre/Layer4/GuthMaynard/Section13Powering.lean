/-
Copyright (c) 2026 S. McColm.
Released under the MIT-0 license; retained verbatim in
licenses/smccolm-Lean-MIT-0.txt.

Adapted for Lean 4.35.0 from smccolm/Lean,
commit 4c8fb7f7816508825089230e3730b69165e5e303,
Riemann Zeta/9. Zero Density, Large Values and Prime Transfer/
71 Guth-Maynard, 2026/GuthMaynard/Pigeonhole.lean, GuthMaynard/PolynomialPowers.lean
and GuthMaynard/CentralTypeI.lean (finite dyadic selection helpers).
The fixed-line count is a local extension using the existing finite tuple
coefficients and the native large-values theorem.
See docs/smccolm-guth-provenance.md.
-/
module
public import Legendre.Layer4.GuthMaynard.Section13Exponent
public import Legendre.Layer4.GuthMaynard.FinitePowers

@[expose] public section
open Finset
open scoped BigOperators
namespace Legendre.Density.GuthMaynard

private theorem pigeonhole_real_sum (n : ℕ) (a : ℕ → ℝ) (S : ℝ) (hS : S ≤ ∑ i ∈ range n, a i) (hn : 0 < n) :
  ∃ i ∈ range n, S / n ≤ a i := by
  by_contra h
  push Not at h
  have h_sum : ∑ i ∈ range n, a i < ∑ i ∈ range n, (S / n) := by
    apply Finset.sum_lt_sum
    · intro i _
      exact le_of_lt (h i (by assumption))
    · exists 0
      constructor
      · exact Finset.mem_range.mpr hn
      · exact h 0 (Finset.mem_range.mpr hn)
  have h_sum_eq : ∑ i ∈ range n, (S / n) = S := by
    rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul]
    have hn_real : (n : ℝ) ≠ 0 := by exact_mod_cast ne_of_gt hn
    exact mul_div_cancel₀ S hn_real
  rw [h_sum_eq] at h_sum
  linarith

/-- One dyadic block carries at least the average of the sum of block norms. -/
theorem exists_large_dyadic_block (Q k : ℕ) (a : ℕ → ℂ) (t V : ℝ)
    (hk : 0 < k) (hV : V ≤ ‖wideDirichletPoly Q k a t‖) :
    ∃ r ∈ Finset.range k,
      V / k ≤ ‖dirichletPoly (2 ^ r * Q) a t‖ := by
  have hTriangle : ‖wideDirichletPoly Q k a t‖ ≤
      ∑ r ∈ Finset.range k, ‖dirichletPoly (2 ^ r * Q) a t‖ := by
    rw [wideDirichletPoly_eq_sum_blocks]
    exact norm_sum_le _ _
  exact pigeonhole_real_sum k
    (fun r => ‖dirichletPoly (2 ^ r * Q) a t‖) V
    (hV.trans hTriangle) hk


/-- Simultaneous block-and-ordinate pigeonholing. The chosen block is fixed on
the output subset, which is essential before invoking a large-values or
mean-value estimate. -/
theorem exists_dyadic_block_and_subset
    (Q k : ℕ) (a : ℕ → ℂ) (W : Finset ℝ) (V : ℝ)
    (hk : 0 < k)
    (hWide : ∀ t ∈ W, V ≤ ‖wideDirichletPoly Q k a t‖) :
    ∃ r ∈ Finset.range k, ∃ W' ⊆ W,
      (W.card : ℝ) ≤ k * (W'.card : ℝ) ∧
      ∀ t ∈ W', V / k ≤ ‖dirichletPoly (2 ^ r * Q) a t‖ := by
  classical
  have hEach : ∀ t ∈ W, ∃ r ∈ Finset.range k,
      V / k ≤ ‖dirichletPoly (2 ^ r * Q) a t‖ := by
    intro t ht
    exact exists_large_dyadic_block Q k a t V hk (hWide t ht)
  let index (t : ℝ) : ℕ :=
    if ht : t ∈ W then Classical.choose (hEach t ht) else 0
  have hIndexMem : ∀ t ∈ W, index t ∈ Finset.range k := by
    intro t ht
    simp only [index, dite_eq_left ht]
    exact (Classical.choose_spec (hEach t ht)).1
  have hIndexLarge : ∀ t ∈ W,
      V / k ≤ ‖dirichletPoly (2 ^ index t * Q) a t‖ := by
    intro t ht
    simp only [index, dite_eq_left ht]
    exact (Classical.choose_spec (hEach t ht)).2
  have hCard : W.card = ∑ r ∈ Finset.range k,
      (W.filter fun t => index t = r).card := by
    exact Finset.card_eq_sum_card_fiberwise hIndexMem
  have hCardReal : (W.card : ℝ) = ∑ r ∈ Finset.range k,
      ((W.filter fun t => index t = r).card : ℝ) := by
    exact_mod_cast hCard
  obtain ⟨r, hr, hrLarge⟩ := pigeonhole_real_sum k
    (fun r => ((W.filter fun t => index t = r).card : ℝ))
    (W.card : ℝ) (by rw [hCardReal]) hk
  refine ⟨r, hr, W.filter fun t => index t = r, Finset.filter_subset _ _, ?_, ?_⟩
  · have hkReal : (0 : ℝ) < k := by exact_mod_cast hk
    calc
      (W.card : ℝ) = k * ((W.card : ℝ) / k) := by field_simp
      _ ≤ k * ((W.filter fun t => index t = r).card : ℝ) := by gcongr
  · intro t ht
    rw [Finset.mem_filter] at ht
    simpa [ht.2] using hIndexLarge t ht.1


theorem dyadic_block_subset_powered_support
    (N k r n : ℕ) (hr : r < k)
    (hn : n ∈ Finset.Ioc (2 ^ r * N ^ k) (2 * (2 ^ r * N ^ k))) :
    n ∈ Finset.Ioc (N ^ k) (2 ^ k * N ^ k) := by
  rw [Finset.mem_Ioc] at hn ⊢
  constructor
  · exact lt_of_le_of_lt (Nat.le_mul_of_pos_left _ (pow_pos (by omega) r)) hn.1
  · have hrSucc : r + 1 ≤ k := by omega
    have hPow : 2 ^ (r + 1) ≤ (2 : ℕ) ^ k :=
      pow_le_pow_right₀ (by omega : (1 : ℕ) ≤ 2) hrSucc
    calc
      n ≤ 2 * (2 ^ r * N ^ k) := hn.2
      _ = 2 ^ (r + 1) * N ^ k := by rw [pow_succ]; ring
      _ ≤ 2 ^ k * N ^ k := Nat.mul_le_mul_right _ hPow


/-- A fixed-line polynomial whose length admits the Section 13 power
selection. The loss L^(-804) is explicit for a threshold 0 < L ≤ 1. -/
theorem gm_section13_fixed_line_count (ε : ℝ) (hε : 0 < ε) :
    ∃ C T₀ : ℝ, 0 < C ∧ 2 ≤ T₀ ∧
      ∀ (σ T L : ℝ) (N : ℕ) (W : Finset ℝ) (a : ℕ → ℂ),
        7/10 ≤ σ → σ ≤ 4/5 → T₀ ≤ T → 1 < N → 0 < L → L ≤ 1 →
        T^(1/200 : ℝ) ≤ (N : ℝ) →
        (N : ℝ)^2 ≤ T^(15/(6+10*σ)) →
        IsSeparated 1 W → InBaseInterval (3*T) W →
        (∀ n ∈ dyadicInterval N, ‖a n‖ ≤ 1) →
        (∀ t ∈ W, L ≤ ‖∑ n ∈ dyadicInterval N,
          a n * (n : ℂ)^(-((σ : ℂ) + Complex.I*(t : ℂ)))‖) →
        (W.card : ℝ) ≤ C/L^804 * T^(final_exponent σ+ε) := by
  classical
  let η := ε/2
  let δ := ε/16
  have hη : 0 < η := by dsimp [η]; positivity
  have hδ : 0 < δ := by dsimp [δ]; positivity
  obtain ⟨C, T₁, hC, hT₁, hcount⟩ := gm_section13_selected_block_count η hη
  let coeff (k : ℕ) := (finitePowCoeff_bound_uniform k δ hδ).choose
  have hcoeff (k : ℕ) := (finitePowCoeff_bound_uniform k δ hδ).choose_spec
  let A : ℝ := 1 + ∑ k ∈ range 202, coeff k
  let B : ℝ := 201*A*((2 : ℝ)^201)^δ
  have hA : 1 ≤ A := by
    dsimp [A]
    exact le_add_of_nonneg_right (sum_nonneg fun k _ => (hcoeff k).1.le)
  have hB : 0 < B := by dsimp [B]; positivity
  refine ⟨201*C*B^4,max 2 T₁,by positivity,le_max_left _ _,?_⟩
  intro σ T L N W a hσL hσU hT hN hL hL1 hlow hhigh hs hi ha hval
  have hT2 : 2 ≤ T := (le_max_left _ _).trans hT
  have hT1' : T₁ ≤ T := (le_max_right _ _).trans hT
  have hT0 : 0 < T := by linarith
  have hTge : 1 ≤ T := by linarith
  have hN0 : 0 < N := by omega
  obtain ⟨k, hk2, hk201, hklo, hkhi⟩ := k_selection N T σ
    (by exact_mod_cast hN) (by linarith) hσL hlow (by simpa only [Real.rpow_two] using hhigh)
  have hk : 0 < k := by omega
  have hkr : (0 : ℝ) < k := by exact_mod_cast hk
  have hk201' : (k : ℝ) ≤ 201 := by exact_mod_cast hk201
  let Q : ℕ := N^k
  have hQn : 0 < Q := pow_pos hN0 _
  have hQ : (0 : ℝ) < Q := by exact_mod_cast hQn
  have hQr : (Q : ℝ) = (N : ℝ)^(k : ℝ) := by simp [Q]
  have hQlo : T^(10/(6+10*σ)) ≤ (Q : ℝ) := by simpa only [hQr] using hklo
  have hQhi : (Q : ℝ) ≤ T^(15/(6+10*σ)) := by simpa only [hQr] using hkhi
  have hQT : (Q : ℝ) ≤ T^2 := by
    apply hQhi.trans
    rw [← Real.rpow_two]
    apply Real.rpow_le_rpow_of_exponent_le hTge
    exact (div_le_iff₀ (denom_pos σ hσL)).mpr (by linarith)
  let c := finitePoweredLineCoeffs N k a σ
  have hWide (t : ℝ) (ht : t ∈ W) :
      (Q : ℝ)^σ * L^k ≤ ‖wideDirichletPoly Q k c t‖ := by
    rw [wideDirichletPoly_finitePoweredLineCoeffs N k a σ t hN0 hk, norm_mul,
      Complex.norm_cpow_eq_rpow_re_of_pos hQ, Complex.ofReal_re, finitePowPoly, norm_pow]
    exact mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hL.le (hval t ht) _)
      (Real.rpow_nonneg hQ.le _)
  obtain ⟨r, hr, U, hUW, hcard, hv⟩ :=
    exists_dyadic_block_and_subset Q k c W ((Q : ℝ)^σ * L^k) hk hWide
  have hrk := Finset.mem_range.mp hr
  let M : ℕ := 2^r*Q
  have hM : 0 < M := Nat.mul_pos (by positivity) hQn
  have hMQ : (M : ℝ) ≤ (2 : ℝ)^201*(Q : ℝ) := by
    dsimp [M]
    push_cast
    exact mul_le_mul_of_nonneg_right
      (pow_le_pow_right₀ (by norm_num : (1 : ℝ) ≤ 2) (hrk.le.trans hk201)) hQ.le
  let F := A * (((2^k*Q : ℕ) : ℝ)^δ)
  have hF1 : 1 ≤ F := by
    have hm : (1 : ℝ) ≤ (2^k*Q : ℕ) := by exact_mod_cast Nat.mul_pos (by positivity : 0 < (2 : ℕ)^k) hQn
    have := Real.one_le_rpow hm hδ.le
    dsimp [F]
    nlinarith
  have hFp : 0 < F := by linarith
  let b (n : ℕ) : ℂ := if n ∈ dyadicInterval M then c n/(F : ℂ) else 0
  have hb (n : ℕ) : ‖b n‖ ≤ 1 := by
    by_cases hn : n ∈ dyadicInterval M
    · have hn' := dyadic_block_subset_powered_support N k r n hrk hn
      have hn0 : 0 < n := hQn.trans (Finset.mem_Ioc.mp hn').1
      have hCk : coeff k ≤ A := by
        have hsum := Finset.single_le_sum (fun i _ => (hcoeff i).1.le)
          (show k ∈ range 202 from mem_range.mpr (by omega))
        dsimp [A]
        linarith
      have hnorm := (norm_finitePoweredLineCoeffs_le N k n a σ hN0 (by linarith) hn').trans
        ((hcoeff k).2 N a ha n hn0)
      have hnormF : ‖c n‖ ≤ F := by
        refine hnorm.trans ?_
        dsimp [F]
        gcongr
        exact_mod_cast (Finset.mem_Ioc.mp hn').2
      simpa [b, hn, norm_div, Complex.norm_real, abs_of_pos hFp] using
        (div_le_one hFp).2 hnormF
    · simp [b, hn]
  have hbpoly (t : ℝ) : dirichletPoly M b t = dirichletPoly M c t / (F : ℂ) := by
    unfold dirichletPoly
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro n hn
    dsimp only [b]
    rw [ite_eq_left hn]
    ring
  let D := (k : ℝ)*F/L^k
  have hLk := pow_le_one₀ hL.le hL1 (n := k)
  have hLkp := pow_pos hL k
  have hkge : (1 : ℝ) ≤ k := by exact_mod_cast hk
  have hD : 1 ≤ D := by
    apply (le_div_iff₀ hLkp).2
    nlinarith
  have hbval (t : ℝ) (ht : t ∈ U) :
      (Q : ℝ)^σ/D ≤ ‖dirichletPoly M b t‖ := by
    rw [hbpoly, norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hFp]
    have hh := div_le_div_of_nonneg_right (hv t ht) hFp.le
    convert hh using 1
    dsimp [D]
    field_simp
  have hUcount := hcount σ T Q D M U b hσL hσU hT1' hM hD
    hQlo hQhi hMQ (fun x hx y hy hxy => hs x (hUW hx) y (hUW hy) hxy)
    (fun x hx => hi x (hUW hx)) hb hbval
  have hF : F ≤ A*((2 : ℝ)^201)^δ*T^(2*δ) := by
    have hm : (((2^k*Q : ℕ) : ℝ)) ≤ (2 : ℝ)^201*T^2 := by
      push_cast
      exact mul_le_mul (pow_le_pow_right₀ (by norm_num : (1 : ℝ) ≤ 2) hk201) hQT
        hQ.le (by positivity)
    have h := Real.rpow_le_rpow (by positivity) hm hδ.le
    rw [Real.mul_rpow (by positivity) (by positivity),
      ← Real.rpow_natCast T 2, ← Real.rpow_mul hT0.le] at h
    simpa [F, mul_assoc] using mul_le_mul_of_nonneg_left h (by positivity : 0 ≤ A)
  have hDwide : D ≤ B*T^(2*δ)/L^201 := by
    dsimp [D, B]
    have hLmono : L^201 ≤ L^k := pow_le_pow_of_le_one hL.le hL1 hk201
    have hm : (k : ℝ)*F ≤ 201*(A*((2 : ℝ)^201)^δ*T^(2*δ)) :=
      mul_le_mul hk201' hF hFp.le (by norm_num)
    calc
      _ ≤ 201*(A*((2 : ℝ)^201)^δ*T^(2*δ))/L^k :=
        div_le_div_of_nonneg_right hm hLkp.le
      _ ≤ 201*(A*((2 : ℝ)^201)^δ*T^(2*δ))/L^201 :=
        div_le_div_of_nonneg_left (by positivity) (pow_pos hL _) hLmono
      _ = _ := by ring
  have hDp : 0 ≤ D := by linarith
  calc
    _ ≤ (k : ℝ)*(U.card : ℝ) := hcard
    _ ≤ 201*(C*(B*T^(2*δ)/L^201)^4*T^(final_exponent σ+η)) := by
      gcongr
      exact hUcount.trans (by gcongr)
    _ = _ := by
      rw [div_pow, mul_pow, ← pow_mul, ← Real.rpow_natCast (T^(2*δ)) 4,
        ← Real.rpow_mul hT0.le]
      norm_num
      rw [show 2*δ*4 = ε/2 by dsimp [δ]; ring]
      have hExp : T^(ε/2)*T^(final_exponent σ+η) = T^(final_exponent σ+ε) := by
        rw [← Real.rpow_add hT0]
        congr 1
        dsimp [η]
        ring
      rw [← hExp]
      ring

end Legendre.Density.GuthMaynard
