/-
Copyright (c) 2026 S. McColm.
Released under MIT-0; retained license: licenses/smccolm-Lean-MIT-0.txt. Adapted from smccolm/Lean commit
4c8fb7f7816508825089230e3730b69165e5e303, GuthMaynard/PolynomialPowers.lean (selected tuple/block lemmas), ArithmeticCoefficients.lean
(selected factorization proof), ClassicalPowering.lean (finite coefficient core).
Lean 4.35.0 module/import/namespace adaptation; source directory and mapping in docs/smccolm-guth-provenance.md.
-/
module
public import Legendre.Layer4.GuthMaynard.Polynomial
public import Legendre.Layer4.Arithmetic.DivisorGrowth
public import Mathlib.Tactic
@[expose] public section
open Complex Finset Filter
open scoped BigOperators
namespace Legendre.Density.GuthMaynard

/-- Source-faithful general factorization-count input. The constant may depend
    on `k` and `ε`, but is uniform in the positive target `m`. -/
def FactorizationCountBoundProp : Prop :=
  ∀ (k : ℕ) (ε : ℝ), 0 < ε →
    ∃ C : ℝ, 0 < C ∧ ∀ m : ℕ, 0 < m →
      (((Fintype.piFinset (fun (_ : Fin k) => Finset.Ioc 1 m)).filter
        (fun p => (∏ x : Fin k, p x) = m)).card : ℝ) ≤ C * (m : ℝ) ^ ε

lemma pow_coeff_subset (N k m : ℕ) (hm : 0 < m) :
  (Fintype.piFinset (fun (_ : Fin k) => Finset.Ioc N (2 * N))).filter (fun p => (∏ x : Fin k, p x) = m) ⊆
  (Fintype.piFinset (fun (_ : Fin k) => Finset.Ioc 1 m)).filter (fun p => (∏ x : Fin k, p x) = m) := by
  intro p hp
  rw [mem_filter] at hp ⊢
  rcases hp with ⟨hp_pi, hp_prod⟩
  refine ⟨?_, hp_prod⟩
  rw [Fintype.mem_piFinset] at hp_pi ⊢
  intro x
  have hpx := hp_pi x
  rw [mem_Ioc] at hpx ⊢
  rcases hpx with ⟨hpx1, hpx2⟩
  constructor
  · by_cases hN : N = 0
    · rw [hN] at hpx1 hpx2
      linarith
    · have hN_pos : N ≥ 1 := Nat.pos_of_ne_zero hN
      linarith
  · have hdvd : p x ∣ ∏ y : Fin k, p y := dvd_prod_of_mem (fun y => p y) (mem_univ x)
    rw [hp_prod] at hdvd
    exact Nat.le_of_dvd hm hdvd

/-- Complex powers of a finite product of natural numbers factor coordinatewise. -/
lemma prod_natCast_cpow_eq {k : ℕ} (p : Fin k → ℕ) (s : ℂ) :
    (∏ x : Fin k, (p x : ℂ) ^ s) = ((∏ x : Fin k, p x : ℕ) : ℂ) ^ s := by
  classical
  induction (Finset.univ : Finset (Fin k)) using Finset.induction_on with
  | empty => simp
  | @insert a u ha ih =>
      rw [Finset.prod_insert ha, Finset.prod_insert ha, Nat.cast_mul,
        Complex.natCast_mul_natCast_cpow, ih]

/-- A tuple supported on `(N, 2N]` has product supported on `[N^k, (2N)^k]`.
    This includes the empty-product case `k = 0`. -/
lemma powCoeff_product_mem_support (N k : ℕ) (p : Fin k → ℕ)
    (hp : p ∈ Fintype.piFinset (fun (_ : Fin k) => Finset.Ioc N (2 * N))) :
    (∏ x : Fin k, p x) ∈ Finset.Icc (N ^ k) ((2 * N) ^ k) := by
  rw [Fintype.mem_piFinset] at hp
  rw [Finset.mem_Icc]
  constructor
  · calc
      N ^ k = ∏ _x : Fin k, N := by simp
      _ ≤ ∏ x : Fin k, p x := by
        apply Finset.prod_le_prod
        intro x _
        exact (Finset.mem_Ioc.mp (hp x)).1.le
  · calc
      ∏ x : Fin k, p x ≤ ∏ _x : Fin k, 2 * N := by
        apply Finset.prod_le_prod
        intro x _
        exact (Finset.mem_Ioc.mp (hp x)).2
      _ = (2 * N) ^ k := by simp

noncomputable def wideDirichletPoly (Q k : ℕ) (a : ℕ → ℂ) (t : ℝ) : ℂ :=
  ∑ m ∈ Finset.Ioc Q (2 ^ k * Q), a m * (m : ℂ) ^ (-t * I)

/-- The wide powered support is the disjoint union of exactly `k` ordinary
dyadic blocks. -/
theorem wideDirichletPoly_eq_sum_blocks (Q k : ℕ) (a : ℕ → ℂ) (t : ℝ) :
    wideDirichletPoly Q k a t =
      ∑ r ∈ Finset.range k, dirichletPoly (2 ^ r * Q) a t := by
  induction k with
  | zero => simp [wideDirichletPoly]
  | succ k ih =>
      rw [wideDirichletPoly]
      have hQ : Q ≤ 2 ^ k * Q := by
        exact Nat.le_mul_of_pos_left Q (pow_pos (by omega : 0 < 2) k)
      have hBlock : 2 ^ k * Q ≤ 2 ^ (k + 1) * Q := by
        calc
          2 ^ k * Q ≤ 2 * (2 ^ k * Q) :=
            Nat.le_mul_of_pos_left (2 ^ k * Q) (by omega)
          _ = 2 ^ (k + 1) * Q := by rw [pow_succ]; ring
      rw [← Finset.Ioc_union_Ioc_eq_Ioc hQ hBlock,
        Finset.sum_union (Finset.Ioc_disjoint_Ioc_of_le le_rfl)]
      change wideDirichletPoly Q k a t + _ = _
      rw [ih]
      rw [Finset.sum_range_succ, dirichletPoly, dyadicInterval]
      congr 1
      ring_nf

/-- Local reuse of the already proved divisor bound; no detector input. -/
theorem divisorCountBound_native : ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, 0 < C ∧ ∀ n : ℕ, 0 < n →
      (n.divisors.card : ℝ) ≤ C*(n : ℝ)^ε :=
  Legendre.Density.Moment.DivisorGrowth.divisors_card_le_rpow

theorem factorizationCountBound_native : FactorizationCountBoundProp := by
  intro k eps heps
  let delta : ℝ := eps / (k + 1 : ℕ)
  have hkOnePos : (0 : ℝ) < (k + 1 : ℕ) := by positivity
  have hdelta : 0 < delta := by
    dsimp [delta]
    exact div_pos heps hkOnePos
  obtain ⟨C, hC, hDivisor⟩ := divisorCountBound_native delta hdelta
  refine ⟨C ^ k, pow_pos hC k, ?_⟩
  intro m hm
  let tuples :=
    (Fintype.piFinset (fun (_ : Fin k) => Finset.Ioc 1 m)).filter
      (fun p => (∏ x : Fin k, p x) = m)
  have htupleSubset : tuples ⊆ Fintype.piFinset (fun (_ : Fin k) => m.divisors) := by
    intro p hp
    have hpProduct := (Finset.mem_filter.mp hp).2
    rw [Fintype.mem_piFinset]
    intro i
    rw [Nat.mem_divisors]
    constructor
    · have hi : p i ∣ ∏ j : Fin k, p j :=
        dvd_prod_of_mem (fun j => p j) (Finset.mem_univ i)
      simpa [hpProduct] using hi
    · exact Nat.ne_of_gt hm
  have hcardNat : tuples.card ≤ m.divisors.card ^ k := by
    calc
      tuples.card ≤ (Fintype.piFinset (fun (_ : Fin k) => m.divisors)).card :=
        Finset.card_le_card htupleSubset
      _ = m.divisors.card ^ k := Fintype.card_piFinset_const m.divisors k
  have hcardReal : (tuples.card : ℝ) ≤ (m.divisors.card : ℝ) ^ k := by
    exact_mod_cast hcardNat
  have hdivisorReal : (m.divisors.card : ℝ) ≤ C * (m : ℝ) ^ delta :=
    hDivisor m hm
  have hpowBound : (m.divisors.card : ℝ) ^ k ≤
      (C * (m : ℝ) ^ delta) ^ k := by
    gcongr
  have hdeltaK : delta * (k : ℝ) ≤ eps := by
    have hkLe : (k : ℝ) ≤ (k + 1 : ℕ) := by norm_num
    have hratio : (k : ℝ) / (k + 1 : ℕ) ≤ 1 :=
      (div_le_one hkOnePos).mpr hkLe
    calc
      delta * (k : ℝ) = eps * ((k : ℝ) / (k + 1 : ℕ)) := by
        dsimp [delta]
        field_simp
      _ ≤ eps * 1 := mul_le_mul_of_nonneg_left hratio heps.le
      _ = eps := mul_one eps
  have hmOne : (1 : ℝ) ≤ m := by exact_mod_cast hm
  have hrpow : (m : ℝ) ^ (delta * (k : ℝ)) ≤ (m : ℝ) ^ eps :=
    Real.rpow_le_rpow_of_exponent_le hmOne hdeltaK
  change (tuples.card : ℝ) ≤ C ^ k * (m : ℝ) ^ eps
  calc
    (tuples.card : ℝ) ≤ (m.divisors.card : ℝ) ^ k := hcardReal
    _ ≤ (C * (m : ℝ) ^ delta) ^ k := hpowBound
    _ = C ^ k * (m : ℝ) ^ (delta * (k : ℝ)) := by
      rw [mul_pow, ← Real.rpow_mul_natCast (Nat.cast_nonneg m)]
    _ ≤ C ^ k * (m : ℝ) ^ eps :=
      mul_le_mul_of_nonneg_left hrpow (pow_nonneg hC.le k)

/-- Coefficients obtained by taking the `k`-th power of an arbitrary finite
Dirichlet polynomial on `(N,2N]`. -/
noncomputable def finitePowCoeff
    (N k : ℕ) (a : ℕ → ℂ) (m : ℕ) : ℂ :=
  ∑ p ∈ (Fintype.piFinset (fun (_ : Fin k) => Ioc N (2 * N))).filter
      (fun p => (∏ x : Fin k, p x) = m),
    ∏ x : Fin k, a (p x)

/-- Structural form of the powered finite Dirichlet polynomial. -/
noncomputable def finitePowPoly
    (N k : ℕ) (a : ℕ → ℂ) (s : ℂ) : ℂ :=
  (∑ n ∈ Ioc N (2 * N), a n * (n : ℂ) ^ (-s)) ^ k

theorem finite_polynomial_power_identity (N k : ℕ) (a : ℕ → ℂ) (s : ℂ) :
    finitePowPoly N k a s =
      ∑ m ∈ Icc (N ^ k) ((2 * N) ^ k),
        finitePowCoeff N k a m * (m : ℂ) ^ (-s) := by
  classical
  let tuples := Fintype.piFinset (fun (_ : Fin k) => Ioc N (2 * N))
  have hsupport : ∀ p ∈ tuples,
      (∏ x : Fin k, p x) ∈ Icc (N ^ k) ((2 * N) ^ k) := by
    intro p hp
    exact powCoeff_product_mem_support N k p hp
  rw [finitePowPoly, Finset.sum_pow']
  change (∑ p ∈ tuples, ∏ x : Fin k, (a (p x) * (p x : ℂ) ^ (-s))) = _
  calc
    (∑ p ∈ tuples, ∏ x : Fin k, (a (p x) * (p x : ℂ) ^ (-s))) =
        ∑ p ∈ tuples, (∏ x : Fin k, a (p x)) *
          ((∏ x : Fin k, p x : ℕ) : ℂ) ^ (-s) := by
      apply Finset.sum_congr rfl
      intro p _
      rw [Finset.prod_mul_distrib, prod_natCast_cpow_eq]
    _ = ∑ m ∈ Icc (N ^ k) ((2 * N) ^ k),
        ∑ p ∈ tuples with (∏ x : Fin k, p x) = m,
          (∏ x : Fin k, a (p x)) *
            ((∏ x : Fin k, p x : ℕ) : ℂ) ^ (-s) := by
      symm
      exact Finset.sum_fiberwise_of_maps_to hsupport _
    _ = ∑ m ∈ Icc (N ^ k) ((2 * N) ^ k),
        finitePowCoeff N k a m * (m : ℂ) ^ (-s) := by
      apply Finset.sum_congr rfl
      intro m _
      rw [finitePowCoeff, Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro p hp
      rw [(Finset.mem_filter.mp hp).2]

theorem finitePowCoeff_lower_endpoint_eq_zero
    (N k : ℕ) (a : ℕ → ℂ) (hN : 0 < N) (hk : 0 < k) :
    finitePowCoeff N k a (N ^ k) = 0 := by
  classical
  rw [finitePowCoeff]
  apply Finset.sum_eq_zero
  intro p hp
  rw [Finset.mem_filter] at hp
  rcases hp with ⟨hpSupport, hpProduct⟩
  rw [Fintype.mem_piFinset] at hpSupport
  have hCoordinate : ∀ x : Fin k, N + 1 ≤ p x := by
    intro x
    have hx := (Finset.mem_Ioc.mp (hpSupport x)).1
    omega
  have hProductLower : (N + 1) ^ k ≤ ∏ x : Fin k, p x := by
    calc
      (N + 1) ^ k = ∏ _x : Fin k, (N + 1) := by simp
      _ ≤ ∏ x : Fin k, p x := by
        apply Finset.prod_le_prod
        intro x _
        exact hCoordinate x
  have hStrict : N ^ k < (N + 1) ^ k :=
    Nat.pow_lt_pow_left (Nat.lt_succ_self N) hk.ne'
  omega

theorem finite_polynomial_power_identity_Ioc
    (N k : ℕ) (a : ℕ → ℂ) (s : ℂ) (hN : 0 < N) (hk : 0 < k) :
    finitePowPoly N k a s =
      ∑ m ∈ Ioc (N ^ k) ((2 * N) ^ k),
        finitePowCoeff N k a m * (m : ℂ) ^ (-s) := by
  rw [finite_polynomial_power_identity]
  rw [Finset.Icc_eq_cons_Ioc]
  · simp [finitePowCoeff_lower_endpoint_eq_zero N k a hN hk]
  · exact Nat.pow_le_pow_left (by omega : N ≤ 2 * N) k

/-- Bounded base coefficients give epsilon-power bounds for every fixed
power.  The constant is uniform in the block length and the target index. -/
theorem finitePowCoeff_bound
    (N k : ℕ) (a : ℕ → ℂ)
    (ha : ∀ n ∈ Ioc N (2 * N), ‖a n‖ ≤ 1) :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧
      ∀ m : ℕ, 0 < m →
        ‖finitePowCoeff N k a m‖ ≤ C * (m : ℝ) ^ ε := by
  intro ε hε
  obtain ⟨C, hC, hFactor⟩ := factorizationCountBound_native k ε hε
  refine ⟨C, hC, ?_⟩
  intro m hm
  let source := (Fintype.piFinset (fun (_ : Fin k) => Ioc N (2 * N))).filter
    (fun p => (∏ x : Fin k, p x) = m)
  let target := (Fintype.piFinset (fun (_ : Fin k) => Ioc 1 m)).filter
    (fun p => (∏ x : Fin k, p x) = m)
  have hsource : source ⊆ target := by
    simpa [source, target] using pow_coeff_subset N k m hm
  have hterm : ∀ p ∈ source, ‖∏ x : Fin k, a (p x)‖ ≤ 1 := by
    intro p hp
    rw [norm_prod]
    suffices (∏ x : Fin k, ‖a (p x)‖) ≤ ∏ _x : Fin k, (1 : ℝ) by
      simpa using this
    apply Finset.prod_le_prod₀
    · intro x _
      exact norm_nonneg _
    · intro x _
      have hpSource := (Finset.mem_filter.mp hp).1
      rw [Fintype.mem_piFinset] at hpSource
      exact ha (p x) (hpSource x)
  calc
    ‖finitePowCoeff N k a m‖
        ≤ ∑ p ∈ source, ‖∏ x : Fin k, a (p x)‖ := by
          simpa only [finitePowCoeff, source] using
            norm_sum_le source (fun p => ∏ x : Fin k, a (p x))
    _ ≤ ∑ _p ∈ source, (1 : ℝ) := Finset.sum_le_sum hterm
    _ = (source.card : ℝ) := by simp
    _ ≤ (target.card : ℝ) := by exact_mod_cast Finset.card_le_card hsource
    _ ≤ C * (m : ℝ) ^ ε := by simpa [target] using hFactor m hm

/-- Quantifier-correct uniform form of `finitePowCoeff_bound`.  For a fixed
power and epsilon, the factorization constant is chosen before the block
length and coefficients, exactly as required by an eventual density bound. -/
theorem finitePowCoeff_bound_uniform
    (k : ℕ) (eps : ℝ) (heps : 0 < eps) :
    ∃ C : ℝ, 0 < C ∧ ∀ (N : ℕ) (a : ℕ → ℂ),
      (∀ n ∈ Ioc N (2 * N), ‖a n‖ ≤ 1) →
      ∀ m : ℕ, 0 < m →
        ‖finitePowCoeff N k a m‖ ≤ C * (m : ℝ) ^ eps := by
  obtain ⟨C, hC, hFactor⟩ := factorizationCountBound_native k eps heps
  refine ⟨C, hC, ?_⟩
  intro N a ha m hm
  let source := (Fintype.piFinset (fun (_ : Fin k) => Ioc N (2 * N))).filter
    (fun p => (∏ x : Fin k, p x) = m)
  let target := (Fintype.piFinset (fun (_ : Fin k) => Ioc 1 m)).filter
    (fun p => (∏ x : Fin k, p x) = m)
  have hsource : source ⊆ target := by
    simpa [source, target] using pow_coeff_subset N k m hm
  have hterm : ∀ p ∈ source, ‖∏ x : Fin k, a (p x)‖ ≤ 1 := by
    intro p hp
    rw [norm_prod]
    suffices (∏ x : Fin k, ‖a (p x)‖) ≤ ∏ _x : Fin k, (1 : ℝ) by
      simpa using this
    apply Finset.prod_le_prod₀
    · intro x _
      exact norm_nonneg _
    · intro x _
      have hpSource := (Finset.mem_filter.mp hp).1
      rw [Fintype.mem_piFinset] at hpSource
      exact ha (p x) (hpSource x)
  calc
    ‖finitePowCoeff N k a m‖
        ≤ ∑ p ∈ source, ‖∏ x : Fin k, a (p x)‖ := by
          simpa only [finitePowCoeff, source] using
            norm_sum_le source (fun p => ∏ x : Fin k, a (p x))
    _ ≤ ∑ _p ∈ source, (1 : ℝ) := Finset.sum_le_sum hterm
    _ = (source.card : ℝ) := by simp
    _ ≤ (target.card : ℝ) := by exact_mod_cast Finset.card_le_card hsource
    _ ≤ C * (m : ℝ) ^ eps := by simpa [target] using hFactor m hm

/-- Fixed-line coefficients of an arbitrary powered block, scaled at the
left endpoint. -/
noncomputable def finitePoweredLineCoeffs
    (N k : ℕ) (a : ℕ → ℂ) (σ : ℝ) (m : ℕ) : ℂ :=
  (((N ^ k : ℕ) : ℝ) : ℂ) ^ (σ : ℂ) *
    (finitePowCoeff N k a m * (m : ℂ) ^ (-(σ : ℂ)))

theorem wideDirichletPoly_finitePoweredLineCoeffs
    (N k : ℕ) (a : ℕ → ℂ) (σ t : ℝ) (hN : 0 < N) (hk : 0 < k) :
    wideDirichletPoly (N ^ k) k (finitePoweredLineCoeffs N k a σ) t =
      (((N ^ k : ℕ) : ℝ) : ℂ) ^ (σ : ℂ) *
        finitePowPoly N k a (σ + I * t) := by
  rw [finite_polynomial_power_identity_Ioc N k a (σ + I * t) hN hk]
  unfold wideDirichletPoly finitePoweredLineCoeffs
  have hUpper : 2 ^ k * N ^ k = (2 * N) ^ k := by rw [mul_pow]
  rw [hUpper, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro m hm
  have hmPos : 0 < m := lt_of_le_of_lt (Nat.zero_le _) (Finset.mem_Ioc.mp hm).1
  have hmNe : (m : ℂ) ≠ 0 := by exact_mod_cast hmPos.ne'
  rw [mul_assoc, mul_assoc, ← Complex.cpow_add _ _ hmNe]
  congr 2
  ring_nf

theorem norm_finitePoweredLineCoeffs_le
    (N k m : ℕ) (a : ℕ → ℂ) (σ : ℝ)
    (hN : 0 < N) (hσ : 0 ≤ σ)
    (hm : m ∈ Ioc (N ^ k) (2 ^ k * N ^ k)) :
    ‖finitePoweredLineCoeffs N k a σ m‖ ≤ ‖finitePowCoeff N k a m‖ := by
  have hQNat : 0 < N ^ k := pow_pos hN k
  have hmNat : 0 < m := lt_of_le_of_lt (Nat.zero_le _) (Finset.mem_Ioc.mp hm).1
  have hQ : (0 : ℝ) < (N ^ k : ℕ) := by exact_mod_cast hQNat
  have hmReal : (0 : ℝ) < m := by exact_mod_cast hmNat
  have hQm : ((N ^ k : ℕ) : ℝ) ≤ (m : ℝ) := by
    exact_mod_cast (Finset.mem_Ioc.mp hm).1.le
  have hPow : (((N ^ k : ℕ) : ℝ)) ^ σ ≤ (m : ℝ) ^ σ :=
    Real.rpow_le_rpow hQ.le hQm hσ
  have hmPowPos : 0 < (m : ℝ) ^ σ := Real.rpow_pos_of_pos hmReal _
  have hScale : (((N ^ k : ℕ) : ℝ)) ^ σ * (m : ℝ) ^ (-σ) ≤ 1 := by
    rw [Real.rpow_neg hmReal.le, ← div_eq_mul_inv]
    exact (div_le_one hmPowPos).2 hPow
  have hQNorm : ‖((((N ^ k : ℕ) : ℝ) : ℂ) ^ (σ : ℂ))‖ =
      (((N ^ k : ℕ) : ℝ)) ^ σ := by
    rw [Complex.norm_cpow_eq_rpow_re_of_pos hQ]
    rfl
  have hmNorm : ‖((m : ℂ) ^ (-(σ : ℂ)))‖ = (m : ℝ) ^ (-σ) := by
    change ‖(((m : ℝ) : ℂ) ^ (-(σ : ℂ)))‖ = _
    rw [Complex.norm_cpow_eq_rpow_re_of_pos hmReal]
    rfl
  rw [finitePoweredLineCoeffs, norm_mul, norm_mul, hQNorm, hmNorm]
  calc
    (((N ^ k : ℕ) : ℝ)) ^ σ *
        (‖finitePowCoeff N k a m‖ * (m : ℝ) ^ (-σ)) =
        ((((N ^ k : ℕ) : ℝ)) ^ σ * (m : ℝ) ^ (-σ)) *
          ‖finitePowCoeff N k a m‖ := by ring
    _ ≤ 1 * ‖finitePowCoeff N k a m‖ := by gcongr
    _ = ‖finitePowCoeff N k a m‖ := one_mul _


end Legendre.Density.GuthMaynard
