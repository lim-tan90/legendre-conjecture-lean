/-
Copyright (c) 2026 S. McColm.
Released under the MIT-0 license retained in licenses/smccolm-Lean-MIT-0.txt.
Adapted from smccolm/Lean commit 4c8fb7f7816508825089230e3730b69165e5e303,
GuthMaynard/LargeValuesS2.lean: conjugation/cyclic and diagonal identities,
ordered difference moment, and the two off-diagonal decay theorems only.
Mapping: docs/smccolm-guth-provenance.md.
Lean 4.35.0: modern modules, local namespace/imports, current ite lemmas.
The Heath--Brown moment estimate and Proposition 6.1 assembly are not ported.
-/
module
public import Legendre.Layer4.GuthMaynard.QuantitativeReflection
@[expose] public section
open Complex Finset Filter MeasureTheory Real Set
open scoped BigOperators
namespace Legendre.Density.GuthMaynard

/-- Reversing an ordinate difference conjugates the complete scaled
nonzero-frequency series.  The proof reindexes the complete integer sum by
`m ↦ -m`; no truncation or triangle inequality is involved. -/
theorem gmTraceNonzeroTailAt_neg_eq_star
    (cutoff : GMSmoothCutoff) (N : ℕ) (t : ℝ) :
    gmTraceNonzeroTailAt cutoff N (-t) =
      star (gmTraceNonzeroTailAt cutoff N t) := by
  unfold gmTraceNonzeroTailAt
  rw [← Equiv.tsum_eq (Equiv.neg ℤ), tsum_star]
  apply tsum_congr
  intro m
  by_cases hm : m = 0
  · subst m
    simp
  · have hNeg : -m ≠ 0 := neg_ne_zero.mpr hm
    change (if -m = 0 then 0 else
        (N : ℂ) * gmTraceFourier cutoff (-t) ((N : ℝ) * ((-m : ℤ) : ℝ))) =
      star (if m = 0 then 0 else
        (N : ℂ) * gmTraceFourier cutoff t ((N : ℝ) * (m : ℝ)))
    rw [ite_eq_right hNeg, ite_eq_right hm]
    have hFreq : (N : ℝ) * ((-m : ℤ) : ℝ) =
        -((N : ℝ) * (m : ℝ)) := by push_cast; ring
    rw [hFreq, gmTraceFourier_neg_eq_conj cutoff (-t), neg_neg]
    simp

/-- Norm form of the exact reversal identity. -/
theorem norm_gmTraceNonzeroTailAt_neg
    (cutoff : GMSmoothCutoff) (N : ℕ) (t : ℝ) :
    ‖gmTraceNonzeroTailAt cutoff N (-t)‖ =
      ‖gmTraceNonzeroTailAt cutoff N t‖ := by
  rw [gmTraceNonzeroTailAt_neg_eq_star cutoff N, norm_star]

/-- The second `S₂` summand is the first one after the cyclic permutation
`(t,u,v) ↦ (v,t,u)`. -/
theorem gmCubicS2SecondSummand_eq_first_cyclic
    (cutoff : GMSmoothCutoff) (N : ℕ) {W : Finset ℝ}
    (t u v : GMRow W) :
    gmCubicS2SecondSummand cutoff N t u v =
      gmCubicS2FirstSummand cutoff N v t u := by
  unfold gmCubicS2SecondSummand gmCubicS2FirstSummand
  ring

/-- The third `S₂` summand is the first one after the cyclic permutation
`(t,u,v) ↦ (u,v,t)`. -/
theorem gmCubicS2ThirdSummand_eq_first_cyclic
    (cutoff : GMSmoothCutoff) (N : ℕ) {W : Finset ℝ}
    (t u v : GMRow W) :
    gmCubicS2ThirdSummand cutoff N t u v =
      gmCubicS2FirstSummand cutoff N u v t := by
  unfold gmCubicS2ThirdSummand gmCubicS2FirstSummand
  ring

/-- On the diagonal selected by the zero mode, the first cyclic product has
exactly the squared norm of one complete nonzero tail. -/
theorem norm_gmCubicS2FirstSummand_diagonal
    (cutoff : GMSmoothCutoff) (N : ℕ)
    {W : Finset ℝ} (t u : GMRow W) :
    ‖gmCubicS2FirstSummand cutoff N t u t‖ =
      ‖gmTraceZeroMode cutoff N 0‖ *
        ‖gmTraceNonzeroTailAt cutoff N ((t : ℝ) - (u : ℝ))‖ ^ 2 := by
  unfold gmCubicS2FirstSummand
  simp only [sub_self, norm_mul]
  have hReverse : (u : ℝ) - (t : ℝ) = -((t : ℝ) - (u : ℝ)) := by ring
  rw [hReverse, norm_gmTraceNonzeroTailAt_neg cutoff N]
  ring

/-- The complete first cyclic contribution to `S₂`. -/
noncomputable def gmCubicS2First (cutoff : GMSmoothCutoff) (N : ℕ)
    (W : Finset ℝ) : ℂ :=
  ∑ t : GMRow W, ∑ u : GMRow W, ∑ v : GMRow W,
    gmCubicS2FirstSummand cutoff N t u v

/-- The complete second cyclic sum equals the first one by a literal cyclic
reindexing of the three finite row variables. -/
theorem gmCubicS2Second_sum_eq_first
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    (∑ t : GMRow W, ∑ u : GMRow W, ∑ v : GMRow W,
        gmCubicS2SecondSummand cutoff N t u v) =
      gmCubicS2First cutoff N W := by
  simp_rw [gmCubicS2SecondSummand_eq_first_cyclic]
  unfold gmCubicS2First
  calc
    (∑ t : GMRow W, ∑ u : GMRow W, ∑ v : GMRow W,
        gmCubicS2FirstSummand cutoff N v t u) =
        ∑ t : GMRow W, ∑ v : GMRow W, ∑ u : GMRow W,
          gmCubicS2FirstSummand cutoff N v t u := by
      apply Finset.sum_congr rfl
      intro t ht
      rw [Finset.sum_comm]
    _ = ∑ v : GMRow W, ∑ t : GMRow W, ∑ u : GMRow W,
          gmCubicS2FirstSummand cutoff N v t u := by
      rw [Finset.sum_comm]
    _ = _ := by rfl

/-- The complete third cyclic sum equals the first one. -/
theorem gmCubicS2Third_sum_eq_first
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    (∑ t : GMRow W, ∑ u : GMRow W, ∑ v : GMRow W,
        gmCubicS2ThirdSummand cutoff N t u v) =
      gmCubicS2First cutoff N W := by
  simp_rw [gmCubicS2ThirdSummand_eq_first_cyclic]
  unfold gmCubicS2First
  calc
    (∑ t : GMRow W, ∑ u : GMRow W, ∑ v : GMRow W,
        gmCubicS2FirstSummand cutoff N u v t) =
        ∑ u : GMRow W, ∑ t : GMRow W, ∑ v : GMRow W,
          gmCubicS2FirstSummand cutoff N u v t := by
      rw [Finset.sum_comm]
    _ = ∑ u : GMRow W, ∑ v : GMRow W, ∑ t : GMRow W,
          gmCubicS2FirstSummand cutoff N u v t := by
      apply Finset.sum_congr rfl
      intro u hu
      rw [Finset.sum_comm]
    _ = _ := by rfl

/-- Exact cyclic symmetry identity used at the start of the proof of
Guth--Maynard Proposition 6.1. -/
theorem gmCubicS2_eq_three_mul_first
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    gmCubicS2 cutoff N W = 3 * gmCubicS2First cutoff N W := by
  unfold gmCubicS2 gmCubicS2Summand
  simp_rw [Finset.sum_add_distrib]
  rw [gmCubicS2Second_sum_eq_first, gmCubicS2Third_sum_eq_first]
  unfold gmCubicS2First
  ring

/-- Diagonal part of the first cyclic contribution (`v=t`). -/
noncomputable def gmCubicS2FirstDiagonal
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) : ℂ :=
  ∑ t : GMRow W, ∑ u : GMRow W,
    gmCubicS2FirstSummand cutoff N t u t

/-- Complement of the `v=t` diagonal in the first cyclic contribution. -/
noncomputable def gmCubicS2FirstOffDiagonal
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) : ℂ :=
  ∑ t : GMRow W, ∑ u : GMRow W,
    ∑ v ∈ (Finset.univ.erase t : Finset (GMRow W)),
      gmCubicS2FirstSummand cutoff N t u v

/-- Exact diagonal/off-diagonal split of the first cyclic contribution. -/
theorem gmCubicS2First_eq_diagonal_add_offDiagonal
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    gmCubicS2First cutoff N W =
      gmCubicS2FirstDiagonal cutoff N W +
        gmCubicS2FirstOffDiagonal cutoff N W := by
  unfold gmCubicS2First gmCubicS2FirstDiagonal gmCubicS2FirstOffDiagonal
  calc
    (∑ t : GMRow W, ∑ u : GMRow W, ∑ v : GMRow W,
        gmCubicS2FirstSummand cutoff N t u v) =
      ∑ t : GMRow W, ∑ u : GMRow W,
        (gmCubicS2FirstSummand cutoff N t u t +
          ∑ v ∈ (Finset.univ.erase t : Finset (GMRow W)),
            gmCubicS2FirstSummand cutoff N t u v) := by
      apply Finset.sum_congr rfl
      intro t ht
      apply Finset.sum_congr rfl
      intro u hu
      exact (Finset.add_sum_erase Finset.univ
        (fun v : GMRow W => gmCubicS2FirstSummand cutoff N t u v)
        (Finset.mem_univ t)).symm
    _ = _ := by
      simp_rw [Finset.sum_add_distrib]

/-- Ordered difference moment of the literal complete nonzero Poisson tail
which remains on the `v = t` diagonal of the first cyclic contribution. -/
noncomputable def gmTraceNonzeroDifferenceMoment
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) : ℝ :=
  ∑ t : GMRow W, ∑ u : GMRow W,
    ‖gmTraceNonzeroTailAt cutoff N ((t : ℝ) - (u : ℝ))‖ ^ 2

/-- Source-finset presentation of the same ordered moment. -/
theorem gmTraceNonzeroDifferenceMoment_eq_source
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    gmTraceNonzeroDifferenceMoment cutoff N W =
      ∑ t ∈ W, ∑ u ∈ W,
        ‖gmTraceNonzeroTailAt cutoff N (t - u)‖ ^ 2 := by
  unfold gmTraceNonzeroDifferenceMoment
  have hInner (t : GMRow W) :
      (∑ u : GMRow W,
          ‖gmTraceNonzeroTailAt cutoff N ((t : ℝ) - (u : ℝ))‖ ^ 2) =
        ∑ u ∈ W,
          ‖gmTraceNonzeroTailAt cutoff N ((t : ℝ) - u)‖ ^ 2 := by
    conv_rhs => rw [← Finset.sum_attach]
    rw [Finset.univ_eq_attach W]
  calc
    (∑ t : GMRow W, ∑ u : GMRow W,
        ‖gmTraceNonzeroTailAt cutoff N ((t : ℝ) - (u : ℝ))‖ ^ 2) =
      ∑ t : GMRow W, ∑ u ∈ W,
        ‖gmTraceNonzeroTailAt cutoff N ((t : ℝ) - u)‖ ^ 2 := by
          apply Finset.sum_congr rfl
          intro t ht
          exact hInner t
    _ = _ := by
      conv_rhs => rw [← Finset.sum_attach]
      rw [Finset.univ_eq_attach W]

/-- The first cyclic diagonal is exactly controlled by the zero mode at the
origin times the ordered nonzero-tail moment.  This is the finite triangle
inequality step at the start of Guth--Maynard Proposition 6.1. -/
theorem norm_gmCubicS2FirstDiagonal_le
    (cutoff : GMSmoothCutoff) (N : ℕ) (W : Finset ℝ) :
    ‖gmCubicS2FirstDiagonal cutoff N W‖ ≤
      ‖gmTraceZeroMode cutoff N 0‖ *
        gmTraceNonzeroDifferenceMoment cutoff N W := by
  unfold gmCubicS2FirstDiagonal gmTraceNonzeroDifferenceMoment
  calc
    ‖∑ t : GMRow W, ∑ u : GMRow W,
        gmCubicS2FirstSummand cutoff N t u t‖ ≤
        ∑ t : GMRow W, ‖∑ u : GMRow W,
          gmCubicS2FirstSummand cutoff N t u t‖ := norm_sum_le _ _
    _ ≤ ∑ t : GMRow W, ∑ u : GMRow W,
        ‖gmCubicS2FirstSummand cutoff N t u t‖ := by
      apply Finset.sum_le_sum
      intro t ht
      exact norm_sum_le _ _
    _ = ∑ t : GMRow W, ∑ u : GMRow W,
        ‖gmTraceZeroMode cutoff N 0‖ *
          ‖gmTraceNonzeroTailAt cutoff N
            ((t : ℝ) - (u : ℝ))‖ ^ 2 := by
      apply Finset.sum_congr rfl
      intro t ht
      apply Finset.sum_congr rfl
      intro u hu
      exact norm_gmCubicS2FirstSummand_diagonal cutoff N t u
    _ = ‖gmTraceZeroMode cutoff N 0‖ *
        (∑ t : GMRow W, ∑ u : GMRow W,
          ‖gmTraceNonzeroTailAt cutoff N
            ((t : ℝ) - (u : ℝ))‖ ^ 2) := by
      simp_rw [Finset.mul_sum]

/-- Quantitative zero-mode insertion in the cyclic diagonal. -/
theorem gmCubicS2FirstDiagonal_le_zeroModeConstant
    (cutoff : GMSmoothCutoff) :
    ∃ B : ℝ, 0 < B ∧ ∀ (N : ℕ) (W : Finset ℝ),
      ‖gmCubicS2FirstDiagonal cutoff N W‖ ≤
        B * (N : ℝ) * gmTraceNonzeroDifferenceMoment cutoff N W := by
  obtain ⟨B, hB, hZero⟩ := gmTraceZeroMode_bound cutoff
  refine ⟨B, hB, ?_⟩
  intro N W
  calc
    ‖gmCubicS2FirstDiagonal cutoff N W‖ ≤
        ‖gmTraceZeroMode cutoff N 0‖ *
          gmTraceNonzeroDifferenceMoment cutoff N W :=
      norm_gmCubicS2FirstDiagonal_le cutoff N W
    _ ≤ (B * (N : ℝ)) * gmTraceNonzeroDifferenceMoment cutoff N W := by
      apply mul_le_mul_of_nonneg_right
      · simpa [mul_comm] using hZero N 0
      · unfold gmTraceNonzeroDifferenceMoment
        positivity
    _ = B * (N : ℝ) * gmTraceNonzeroDifferenceMoment cutoff N W := by ring

set_option maxHeartbeats 400000 in
/-- Quantitative off-diagonal bound for the first cyclic `S₂` term.  The
two complete nonzero tails use Lemma 4.3 with order two, while the zero
mode on `v ≠ t` uses arbitrary-order separation decay. -/
theorem gmCubicS2FirstOffDiagonal_quantitative
    (cutoff : GMSmoothCutoff) (q : ℕ) :
    ∃ K : ℝ, 0 < K ∧
      ∀ {N : ℕ} {T δ : ℝ} (W : Finset ℝ),
        0 < N → 1 ≤ T → (N : ℝ) ≤ T → 0 < δ →
        IsSeparated δ W → InBaseInterval T W →
        ‖gmCubicS2FirstOffDiagonal cutoff N W‖ ≤
          K * (W.card : ℝ) ^ 3 * T ^ 5 / δ ^ q := by
  obtain ⟨B, hB, hTail⟩ := gmTraceNonzeroTailAt_bound cutoff 2 (by norm_num)
  obtain ⟨C, hC, hZero⟩ := gmTraceZeroMode_separated_bound cutoff q
  let K : ℝ := 16 * B ^ 2 * C
  refine ⟨K, by dsimp only [K]; positivity, ?_⟩
  intro N T δ W hN hT hNT hδ hSep hBase
  have hTPos : 0 < T := zero_lt_one.trans_le hT
  have hNOne : (1 : ℝ) ≤ N := by exact_mod_cast hN
  let major : ℝ := K * T ^ 5 / δ ^ q
  have hMajorNonneg : 0 ≤ major := by dsimp only [major, K]; positivity
  have hTerm : ∀ (t u v : GMRow W), v ≠ t →
      ‖gmCubicS2FirstSummand cutoff N t u v‖ ≤ major := by
    intro t u v hvt
    have htu := abs_sub_le_height_of_mem_baseInterval hBase
      t.property u.property
    have huv := abs_sub_le_height_of_mem_baseInterval hBase
      u.property v.property
    have hOneTu : 1 + |(t : ℝ) - (u : ℝ)| ≤ 2 * T := by linarith
    have hOneUv : 1 + |(u : ℝ) - (v : ℝ)| ≤ 2 * T := by linarith
    have hTuSq : (1 + |(t : ℝ) - (u : ℝ)|) ^ 2 ≤ 4 * T ^ 2 := by
      calc
        _ ≤ (2 * T) ^ 2 := pow_le_pow_left₀ (by positivity) hOneTu 2
        _ = 4 * T ^ 2 := by ring
    have hUvSq : (1 + |(u : ℝ) - (v : ℝ)|) ^ 2 ≤ 4 * T ^ 2 := by
      calc
        _ ≤ (2 * T) ^ 2 := pow_le_pow_left₀ (by positivity) hOneUv 2
        _ = 4 * T ^ 2 := by ring
    have hTailTuRaw := hTail N hN ((t : ℝ) - (u : ℝ))
    have hTailUvRaw := hTail N hN ((u : ℝ) - (v : ℝ))
    have hTailTu : ‖gmTraceNonzeroTailAt cutoff N ((t : ℝ) - (u : ℝ))‖ ≤
        4 * B * T ^ 2 := by
      calc
        _ ≤ B * (1 + |(t : ℝ) - (u : ℝ)|) ^ 2 /
            (N : ℝ) ^ (2 - 1) := hTailTuRaw
        _ = B * (1 + |(t : ℝ) - (u : ℝ)|) ^ 2 / (N : ℝ) := by norm_num
        _ ≤ B * (4 * T ^ 2) / (N : ℝ) := by gcongr
        _ ≤ B * (4 * T ^ 2) / 1 := by
          exact div_le_div_of_nonneg_left (by positivity) (by norm_num) hNOne
        _ = 4 * B * T ^ 2 := by ring
    have hTailUv : ‖gmTraceNonzeroTailAt cutoff N ((u : ℝ) - (v : ℝ))‖ ≤
        4 * B * T ^ 2 := by
      calc
        _ ≤ B * (1 + |(u : ℝ) - (v : ℝ)|) ^ 2 /
            (N : ℝ) ^ (2 - 1) := hTailUvRaw
        _ = B * (1 + |(u : ℝ) - (v : ℝ)|) ^ 2 / (N : ℝ) := by norm_num
        _ ≤ B * (4 * T ^ 2) / (N : ℝ) := by gcongr
        _ ≤ B * (4 * T ^ 2) / 1 := by
          exact div_le_div_of_nonneg_left (by positivity) (by norm_num) hNOne
        _ = 4 * B * T ^ 2 := by ring
    have htvSep : δ ≤ |(v : ℝ) - (t : ℝ)| := by
      have hvtReal : (v : ℝ) ≠ (t : ℝ) := by
        intro h
        exact hvt (Subtype.ext h)
      simpa only [Real.dist_eq] using hSep v v.property t t.property hvtReal
    have hZeroVt := hZero N hδ htvSep
    have hZeroVt' : ‖gmTraceZeroMode cutoff N ((v : ℝ) - (t : ℝ))‖ ≤
        T * C / δ ^ q := by
      calc
        _ ≤ (N : ℝ) * C / δ ^ q := hZeroVt
        _ ≤ T * C / δ ^ q := by gcongr
    unfold gmCubicS2FirstSummand
    simp only [norm_mul]
    calc
      _ ≤ (4 * B * T ^ 2) * (4 * B * T ^ 2) *
          (T * C / δ ^ q) := by gcongr
      _ = major := by
        dsimp only [major, K]
        ring
  unfold gmCubicS2FirstOffDiagonal
  calc
    ‖∑ t : GMRow W, ∑ u : GMRow W,
        ∑ v ∈ (Finset.univ.erase t : Finset (GMRow W)),
          gmCubicS2FirstSummand cutoff N t u v‖ ≤
        ∑ t : GMRow W, ‖∑ u : GMRow W,
          ∑ v ∈ (Finset.univ.erase t : Finset (GMRow W)),
            gmCubicS2FirstSummand cutoff N t u v‖ := norm_sum_le _ _
    _ ≤ ∑ t : GMRow W, ∑ u : GMRow W,
        ‖∑ v ∈ (Finset.univ.erase t : Finset (GMRow W)),
          gmCubicS2FirstSummand cutoff N t u v‖ := by
      apply Finset.sum_le_sum
      intro t ht
      exact norm_sum_le _ _
    _ ≤ ∑ t : GMRow W, ∑ u : GMRow W,
        ∑ v ∈ (Finset.univ.erase t : Finset (GMRow W)),
          ‖gmCubicS2FirstSummand cutoff N t u v‖ := by
      apply Finset.sum_le_sum
      intro t ht
      apply Finset.sum_le_sum
      intro u hu
      exact norm_sum_le _ _
    _ ≤ ∑ _t : GMRow W, ∑ _u : GMRow W,
        ∑ _v : GMRow W, major := by
      apply Finset.sum_le_sum
      intro t ht
      apply Finset.sum_le_sum
      intro u hu
      calc
        (∑ v ∈ (Finset.univ.erase t : Finset (GMRow W)),
            ‖gmCubicS2FirstSummand cutoff N t u v‖) ≤
            ∑ _v ∈ (Finset.univ.erase t : Finset (GMRow W)), major := by
          apply Finset.sum_le_sum
          intro v hv
          exact hTerm t u v (Finset.ne_of_mem_erase hv)
        _ ≤ ∑ _v : GMRow W, major := by
          exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.erase_subset _ _)
            (fun _ _ _ => hMajorNonneg)
    _ = (W.card : ℝ) ^ 3 * major := by
      simp only [Finset.sum_const, Finset.card_univ, Fintype.card_coe,
        nsmul_eq_mul]
      ring
    _ = K * (W.card : ℝ) ^ 3 * T ^ 5 / δ ^ q := by
      dsimp only [major]
      ring

/-- With the source `T^ε` separation, the off-diagonal zero-mode terms are
`O(T⁻¹⁰)`. -/
theorem gmCubicS2FirstOffDiagonal_power_decay
    (cutoff : GMSmoothCutoff) (ε : ℝ) (hε : 0 < ε) :
    ∃ K : ℝ, 0 < K ∧
      ∀ {N : ℕ} {T : ℝ} (W : Finset ℝ),
        0 < N → 1 ≤ T → (N : ℝ) ≤ T →
        IsSeparated (T ^ ε) W → InBaseInterval T W →
        ‖gmCubicS2FirstOffDiagonal cutoff N W‖ ≤ K / T ^ 10 := by
  obtain ⟨q, hq⟩ := exists_nat_gt (18 / ε)
  have hqPos : 0 < q := by
    have : 0 < (q : ℝ) := (div_pos (by norm_num) hε).trans hq
    exact_mod_cast this
  obtain ⟨K₀, hK₀, hRaw⟩ :=
    gmCubicS2FirstOffDiagonal_quantitative cutoff q
  refine ⟨8 * K₀, by positivity, ?_⟩
  intro N T W hN hT hNT hSep hBase
  have hTPos : 0 < T := zero_lt_one.trans_le hT
  have hScalePos : 0 < T ^ ε := Real.rpow_pos_of_pos hTPos ε
  have hScaleOne : 1 ≤ T ^ ε := Real.one_le_rpow hT hε.le
  have hOneSep : IsSeparated 1 W := by
    intro x hx y hy hxy
    exact hScaleOne.trans (hSep x hx y hy hxy)
  have hCard := gmSeparated_card_le_two_height hT hOneSep hBase
  have hCardCube : (W.card : ℝ) ^ 3 ≤ 8 * T ^ 3 := by
    calc
      (W.card : ℝ) ^ 3 ≤ (2 * T) ^ 3 :=
        pow_le_pow_left₀ (by positivity) hCard 3
      _ = 8 * T ^ 3 := by ring
  have hExponent : 18 < ε * (q : ℝ) := by
    rw [div_lt_iff₀ hε] at hq
    nlinarith
  have hDeltaPow : (T ^ ε) ^ q = T ^ (ε * (q : ℝ)) := by
    rw [← Real.rpow_natCast, Real.rpow_mul hTPos.le]
  have hPowCompare : T ^ 8 * T ^ 10 ≤ T ^ (ε * (q : ℝ)) := by
    calc
      T ^ 8 * T ^ 10 = T ^ 18 := by ring
      _ = T ^ (18 : ℝ) := by norm_num
      _ ≤ T ^ (ε * (q : ℝ)) :=
        Real.rpow_le_rpow_of_exponent_le hT hExponent.le
  have hApplied := hRaw W hN hT hNT hScalePos hSep hBase
  calc
    _ ≤ K₀ * (W.card : ℝ) ^ 3 * T ^ 5 / (T ^ ε) ^ q := hApplied
    _ ≤ K₀ * (8 * T ^ 3) * T ^ 5 / (T ^ ε) ^ q := by gcongr
    _ ≤ 8 * K₀ / T ^ 10 := by
      rw [hDeltaPow]
      have hDenPos : 0 < T ^ (ε * (q : ℝ)) :=
        Real.rpow_pos_of_pos hTPos _
      rw [div_le_iff₀ hDenPos]
      have hT10Pos : 0 < T ^ 10 := pow_pos hTPos 10
      rw [div_mul_eq_mul_div, le_div_iff₀ hT10Pos]
      calc
        K₀ * (8 * T ^ 3) * T ^ 5 * T ^ 10 =
            8 * K₀ * (T ^ 8 * T ^ 10) := by ring
        _ ≤ 8 * K₀ * T ^ (ε * (q : ℝ)) := by gcongr
    _ = _ := by rfl


end Legendre.Density.GuthMaynard
