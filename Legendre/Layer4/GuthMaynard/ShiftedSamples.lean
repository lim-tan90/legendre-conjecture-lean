/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GuthMaynard.Section13Powering
public import Legendre.Layer4.GuthMaynard.FixedLineLocalization
public import Legendre.WeightedSeparation
public import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics

@[expose] public section
open Finset Complex Filter
open scoped BigOperators
namespace Legendre.Density.GuthMaynard

/-- Moving each separated sample a distance at most R costs at most 12R
in the cardinality of a one-separated family of shifted ordinates. -/
theorem shifted_separated_image {ι : Type*} (S : Finset ι) (t u : ι → ℝ)
    {R : ℝ} (hR : 1 ≤ R)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hu : ∀ i ∈ S, |u i-t i| ≤ R) :
    ∃ W : Finset ℝ, W ⊆ S.image u ∧ IsSeparated 1 W ∧
      (S.card : ℝ) ≤ 12*R*(W.card : ℝ) := by
  classical
  have htinj : Set.InjOn t (S : Set ι) := by
    intro i hi j hj h
    by_contra hn
    have hh := hs i hi j hj hn
    rw [h, sub_self, abs_zero] at hh
    linarith
  have htsep : ∀ x ∈ S.image t, ∀ y ∈ S.image t, x ≠ y → 1 ≤ |x-y| := by
    intro x hx y hy hne
    obtain ⟨i, hi, rfl⟩ := mem_image.mp hx
    obtain ⟨j, hj, rfl⟩ := mem_image.mp hy
    exact hs i hi j hj (fun h => hne (congrArg t h))
  have hlocal (v : ℝ) :
      ((∑ _i ∈ S.filter (fun i => |u i-v| ≤ 1/2), (1 : ℕ) : ℕ) : ℝ) ≤ 6*R := by
    let F := S.filter (fun i => |u i-v| ≤ 1/2)
    have hsub : F.image t ⊆ (S.image t).filter (fun x => |x-v| ≤ R+1/2) := by
      intro x hx
      obtain ⟨i, hi, rfl⟩ := mem_image.mp hx
      obtain ⟨hiS, hiv⟩ := mem_filter.mp hi
      refine mem_filter.mpr ⟨mem_image.mpr ⟨i, hiS, rfl⟩, ?_⟩
      calc
        _ = |(t i-u i)+(u i-v)| := by congr 1; ring
        _ ≤ |t i-u i|+|u i-v| := abs_add_le _ _
        _ ≤ _ := add_le_add (by simpa only [abs_sub_comm] using hu i hiS) hiv
    have hcard := (card_le_card hsub).trans
      (card_filter_abs_sub_le_two_mul_ceil_add_one (S.image t) (δ := 1)
        one_pos htsep v (R+1/2) (by linarith))
    rw [card_image_iff.mpr (htinj.mono (by exact filter_subset _ _)), div_one] at hcard
    have hcard' : (F.card : ℝ) ≤ 2*(Nat.ceil (R+1/2) : ℝ)+1 := by exact_mod_cast hcard
    have hceil := Nat.ceil_lt_add_one (show 0 ≤ R+1/2 by linarith)
    simpa [F] using (show (F.card : ℝ) ≤ 6*R by linarith)
  obtain ⟨U, hUS, hUsep, hcount⟩ :=
    Legendre.Density.exists_weighted_separated_representatives S u (fun _ => 1) hlocal
  have huinj : Set.InjOn u (U : Set ι) := by
    intro i hi j hj h
    by_contra hn
    have hh := hUsep i hi j hj hn
    rw [h, sub_self, abs_zero] at hh
    linarith
  refine ⟨U.image u, image_subset_image hUS, ?_, ?_⟩
  · intro x hx y hy hne
    obtain ⟨i, hi, rfl⟩ := mem_image.mp hx
    obtain ⟨j, hj, rfl⟩ := mem_image.mp hy
    simpa only [Real.dist_eq] using hUsep i hi j hj (fun h => hne (congrArg u h))
  · rw [card_image_iff.mpr huinj]
    simpa only [sum_const, nsmul_eq_mul, mul_one, Nat.cast_id, show (2 : ℝ)* (6*R) = 12*R by ring] using hcount

/-- On each admissible finite block the Section 13 exponent also bounds
samples with individually varying real parts. -/
theorem gm_section13_varying_line_count (ε : ℝ) (hε : 0 < ε) :
    ∃ C T₀ : ℝ, 0 < C ∧ 2 ≤ T₀ ∧
      ∀ (σ T L : ℝ) (N : ℕ) (a : ℕ → ℂ),
        7/10 ≤ σ → σ ≤ 4/5 → T₀ ≤ T → 1 < N → 0 < L → L ≤ 1 →
        T^(-2 : ℝ) ≤ L → T^(1/200 : ℝ) ≤ (N : ℝ) →
        (N : ℝ) ≤ T^(1/2 : ℝ) → (N : ℝ)^2 ≤ T^(15/(6+10*σ)) →
        (∀ n ∈ dyadicInterval N, ‖a n‖ ≤ 1) →
        ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
          (∀ i ∈ S, t i ∈ Set.Icc 0 T) →
          (∀ i ∈ S, β i ∈ Set.Icc σ 1) →
          (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
          (∀ i ∈ S, L ≤ ‖finiteDirichletSeries (dyadicInterval N) a
            ((β i : ℂ)+(t i : ℂ)*I)‖) →
          (S.card : ℝ) ≤ C/L^804 * T^(final_exponent σ+ε) := by
  classical
  let γ := min (ε/2) 1
  have hγ : 0 < γ := lt_min (by linarith) zero_lt_one
  have hγ1 : γ ≤ 1 := min_le_right _ _
  have hγε : γ ≤ ε/2 := min_le_left _ _
  let k := ⌈10/γ⌉₊
  have hk : 10 ≤ γ*(k : ℝ) := by
    have h := (div_le_iff₀ hγ).mp (Nat.le_ceil (10/γ))
    simpa only [mul_comm] using h
  obtain ⟨H₀, hH₀⟩ := Filter.eventually_atTop.mp
    ((tendsto_rpow_atTop (show 0 < γ/2 by positivity)).eventually_gt_atTop (4*(k : ℝ)))
  obtain ⟨C, T₁, hC, hT₁, hcount⟩ := gm_section13_fixed_line_count (ε/2) (by linarith)
  refine ⟨12*C/(3/4 : ℝ)^804, max T₁ H₀,by positivity, hT₁.trans (le_max_left _ _),?_⟩
  intro σ T L N a hσL hσU hT hN hL hL1 hLlo hNlo hNhi hN2 ha ι S t β ht hβ hs hv
  have hT' : T₁ ≤ T := (le_max_left _ _).trans hT
  have hT2 := hT₁.trans hT'
  have hTp : 0 < T := by linarith
  have hTge : 1 ≤ T := by linarith
  let R := T^γ
  let H := T^(γ/2)
  have hR : 1 ≤ R := Real.one_le_rpow hTge hγ.le
  have hRT : R ≤ T := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le hTge hγ1
  have hHp : 0 < H := by dsimp [H]; positivity
  have hHk : 4*(k : ℝ) < H := hH₀ T ((le_max_right _ _).trans hT)
  have hMass : finiteDirichletMass (dyadicInterval N) a ≤ T := by
    calc
      _ ≤ ∑ _n ∈ dyadicInterval N, (1 : ℝ) := sum_le_sum ha
      _ = (N : ℝ) := by simp [gmDyadicInterval_card]
      _ ≤ T^(1/2 : ℝ) := hNhi
      _ ≤ T := by
        simpa only [Real.rpow_one] using
          Real.rpow_le_rpow_of_exponent_le hTge (by norm_num : (1/2 : ℝ) ≤ 1)
  have hExterior : finiteDirichletMass (dyadicInterval N) a*(H/R)^k < (3/4)*L := by
    have hratio : T*(H/R)^k ≤ T^(-4 : ℝ) := by
      dsimp [H,R]
      rw [← Real.rpow_sub hTp, ← Real.rpow_natCast, ← Real.rpow_mul hTp.le]
      conv_lhs => lhs; rw [← Real.rpow_one T]
      rw [← Real.rpow_add hTp]
      apply Real.rpow_le_rpow_of_exponent_le hTge
      nlinarith
    have hsmall : T^(-4 : ℝ) < (3/4)*T^(-2 : ℝ) := by
      rw [gm_inv_rpow_four hTp, gm_inv_rpow_two hTp]
      have hT2p : 0 < T^2 := by positivity
      have h : 1/T^2 < (3/4 : ℝ) := by
        rw [div_lt_iff₀ hT2p]
        nlinarith
      have hm := mul_lt_mul_of_pos_right h (show 0 < 1/T^2 by positivity)
      convert hm using 1 <;> ring
    exact ((mul_le_mul_of_nonneg_right hMass (by positivity)).trans hratio).trans_lt
      (hsmall.trans_le (mul_le_mul_of_nonneg_left hLlo (by norm_num)))
  have heach (i : ι) (hi : i ∈ S) :
      ∃ y : ℝ, |y| ≤ R ∧ (3/4)*L ≤ ‖finiteDirichletSeries (dyadicInterval N) a
        ((σ : ℂ)+((t i+y : ℝ) : ℂ)*I)‖ := by
    let z : ℂ := (σ : ℂ)+(t i : ℂ)*I
    let d := β i-σ
    have hd : 0 ≤ d := sub_nonneg.mpr (hβ i hi).1
    have hd1 : d ≤ 1 := by dsimp [d]; linarith [(hβ i hi).2]
    obtain ⟨y, hy, hval⟩ := exists_nearby_large_value_finiteDirichlet
      (dyadicInterval N) a k z H R L d
      (fun n hn => (Nat.zero_le N).trans_lt (Finset.mem_Ioc.mp hn).1)
      hHp (by linarith) hL (by dsimp [z]; simp; linarith) hd
      (by have h : z+(d : ℂ) = (β i : ℂ)+(t i : ℂ)*I := by dsimp [z,d]; push_cast; ring
          rw [h]; exact hv i hi)
      (localizer_factor_gt_three_fourths k H d hHp hd hd1 hHk) hExterior
    refine ⟨y,hy,?_⟩
    convert hval using 2 <;> dsimp [z] <;> push_cast <;> ring
  let y (i : ι) : ℝ := if hi : i ∈ S then (heach i hi).choose else 0
  have hy (i : ι) (hi : i ∈ S) := (heach i hi).choose_spec
  let u := fun i => t i+y i
  have huv : ∀ i ∈ S, |u i-t i| ≤ R := by
    intro i hi
    dsimp only [u]
    rw [add_sub_cancel_left]
    simpa only [y, dite_eq_left hi] using (hy i hi).1
  obtain ⟨W,hWS,hWsep,hcard⟩ := shifted_separated_image S t u hR hs huv
  let W' := W.image (fun v => v+R)
  have hWcard : W'.card = W.card := Finset.card_image_of_injective _ (fun _ _ h => add_right_cancel h)
  have hW'sep : IsSeparated 1 W' := by
    intro x hx v hv' hne
    obtain ⟨x₀, hx₀, rfl⟩ := mem_image.mp hx
    obtain ⟨v₀, hv₀, rfl⟩ := mem_image.mp hv'
    rw [Real.dist_eq, add_sub_add_right_eq_sub, ← Real.dist_eq]
    exact hWsep x₀ hx₀ v₀ hv₀ (fun h => hne (congrArg (fun z : ℝ => z+R) h))
  let b := fun n => a n*(n : ℂ)^((R : ℂ)*I)
  have hb : ∀ n ∈ dyadicInterval N, ‖b n‖ ≤ 1 := by
    intro n hn
    have hn0 : 0 < n := (Nat.zero_le N).trans_lt (Finset.mem_Ioc.mp hn).1
    simpa [b, norm_mul, Complex.norm_natCast_cpow_of_pos hn0] using ha n hn
  have hWint : InBaseInterval (3*T) W' := by
    intro v hv'
    obtain ⟨w, hw, rfl⟩ := mem_image.mp hv'
    obtain ⟨i, hi, rfl⟩ := mem_image.mp (hWS hw)
    have hdy := abs_le.mp (huv i hi)
    exact ⟨by linarith [(ht i hi).1,hdy.1], by linarith [(ht i hi).2,hdy.2]⟩
  have hWval (v : ℝ) (hv' : v ∈ W') :
      (3/4)*L ≤ ‖∑ n ∈ dyadicInterval N, b n*(n : ℂ)^(-((σ : ℂ)+I*(v : ℂ)))‖ := by
    obtain ⟨w, hw, rfl⟩ := mem_image.mp hv'
    obtain ⟨i, hi, rfl⟩ := mem_image.mp (hWS hw)
    have hraw := (hy i hi).2
    rw [← show y i = (heach i hi).choose by simp [y, hi]] at hraw
    refine hraw.trans_eq (congrArg norm ?_)
    unfold finiteDirichletSeries
    apply sum_congr rfl
    intro n hn
    have hn0 : 0 < n := (Nat.zero_le N).trans_lt (Finset.mem_Ioc.mp hn).1
    dsimp only [b,u]
    rw [mul_assoc, ← Complex.cpow_add _ _ (by exact_mod_cast hn0.ne'), Complex.ofReal_add]
    congr 2
    push_cast
    ring
  have h := hcount σ T ((3/4)*L) N W' b hσL hσU hT' hN
    (by positivity) (by linarith) hNlo hN2 hW'sep hWint hb hWval
  rw [hWcard] at h
  calc
    _ ≤ 12*R*(W.card : ℝ) := hcard
    _ ≤ 12*R*(C/((3/4)*L)^804*T^(final_exponent σ+ε/2)) :=
      mul_le_mul_of_nonneg_left h (by positivity)
    _ = 12*C/(3/4 : ℝ)^804/L^804*(T^γ*T^(final_exponent σ+ε/2)) := by
      dsimp [R]; rw [mul_pow]; ring
    _ ≤ _ := by
      rw [← Real.rpow_add hTp]
      apply mul_le_mul_of_nonneg_left _ (by positivity)
      exact Real.rpow_le_rpow_of_exponent_le hTge (by linarith)

end Legendre.Density.GuthMaynard
