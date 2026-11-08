/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Literature.Statements
public import Legendre.Bertrand
public import Legendre.Nagura

/-!
# Kernel-checked comparisons with the historical progress table

Equivalence of two open specifications does not prove either specification.
Only `bertrand_comparator` and `nagura_comparator` below supply unconditional
historical prime-interval proofs. The other historical statements stay open.
-/

@[expose] public section
namespace Legendre.Literature
open Filter Set Asymptotics
open scoped Topology ArithmeticFunction.Omega

theorem legendre_comparator_iff : Legendre1808 ↔ Conjecture := by
  constructor
  · intro h n hn
    simpa only [LegendreAt,pow_two] using h n (by omega)
  · intro h n hn
    simpa only [LegendreAt,pow_two] using h n (by omega)

theorem bertrand_comparator : Bertrand1852 := by
  intro n hn
  obtain ⟨p,hp,hlo,hhi⟩ := bertrand n (by omega)
  refine ⟨p,hp,hlo,lt_of_le_of_ne hhi ?_⟩
  intro he
  have hd : n ∣ p := by rw [he]; exact dvd_mul_left n 2
  have h := (Nat.dvd_prime hp).1 hd
  omega

theorem nagura_comparator : Nagura1952 := by
  intro x hx
  obtain ⟨p,hp,hlo,hhi⟩ := nagura_prime_gap ⌊x⌋₊ (Nat.le_floor hx)
  refine ⟨p,hp,?_,?_⟩
  · have ha := Nat.lt_floor_add_one x
    have hb : ((⌊x⌋₊ : ℝ)+1) ≤ p := by exact_mod_cast Nat.succ_le_of_lt hlo
    linarith
  · have ha : (5 : ℝ)*p < 6*(⌊x⌋₊ : ℝ) := by exact_mod_cast hhi
    have hb := Nat.floor_le (by linarith : (0 : ℝ) ≤ x)
    linarith

theorem nagura_comparator_implies_repository (h : Nagura1952) :
    ∀ x : ℝ, 25 ≤ x → HasPrimeIn x (x/5) := by
  intro x hx
  obtain ⟨p,hp,hlo,hhi⟩ := h x hx
  exact ⟨p,hp,hlo,by linarith⟩

theorem forwardProgress_iff (θ : ℝ) : ForwardProgress θ ↔ ShortIntervalStatement θ := by
  simp only [ForwardProgress,ShortIntervalStatement,HasPrimeInShortInterval,
    HasPrimeIn,one_mul]

theorem gapProgress_iff (θ : ℝ) : GapProgress θ ↔ ShortIntervalExponent θ := by
  unfold GapProgress ShortIntervalExponent EventuallyGapBound
  simp only [eventually_atTop]

/-- Statement correspondence only; neither side is asserted. -/
theorem hoheisel_comparator_iff : Hoheisel1930Progress ↔ Hoheisel := by
  exact (forwardProgress_iff (32999/33000)).trans
    (shortIntervalStatement_iff_exponentLimit (by norm_num))

/-- Statement correspondence only; neither side is asserted. -/
theorem ingham_lindelof_comparator_iff : Ingham1937LindelofProgress ↔ Ingham58 := by
  exact (forwardProgress_iff (5/8)).trans
    (shortIntervalStatement_iff_exponentLimit (by norm_num))

/-- Statement correspondence only; neither side is asserted. -/
theorem ingham_density_comparator_iff : Ingham1937DensityProgress ↔ Ingham577 := by
  exact (forwardProgress_iff (577/925)).trans
    (shortIntervalStatement_iff_exponentLimit (by norm_num))

/-- Statement correspondence only; neither side is asserted. -/
theorem huxley_comparator_iff : Huxley1972Progress ↔ Huxley := by
  exact (forwardProgress_iff (7/12)).trans
    (shortIntervalStatement_iff_exponentLimit (by norm_num))

/-- Statement correspondence only; neither side is asserted. -/
theorem heathBrownIwaniec_comparator_iff : HeathBrownIwaniec1979Progress ↔ HeathBrownIwaniec := by
  exact (forwardProgress_iff (11/20)).trans
    (shortIntervalStatement_iff_exponentLimit (by norm_num))

/-- Statement correspondence only; neither side is asserted. -/
theorem iwaniecPintz_comparator_iff : IwaniecPintz1984Progress ↔ IwaniecPintz := by
  exact (forwardProgress_iff (23/42)).trans
    (shortIntervalStatement_iff_exponentLimit (by norm_num))

/-- Statement correspondence only; neither side is asserted. -/
theorem mozzochi_comparator_iff : Mozzochi1986Progress ↔ Mozzochi := by
  exact (forwardProgress_iff (11/20-1/384)).trans
    (shortIntervalStatement_iff_exponentLimit (by norm_num))

theorem bakerHarman_comparator_iff : BakerHarman1996Progress ↔ BakerHarman :=
  gapProgress_iff _

/-- Preserve the exponent when changing backward intervals into forward gaps.
The coefficient 3 is harmless for exponent comparison. -/
theorem gapProgress_of_backward {θ : ℝ} (hθ0 : 0 ≤ θ) (hθ1 : θ < 1)
    (h : BackwardProgress θ) : GapProgress θ := by
  obtain ⟨X,_hX,hX⟩ := h
  obtain ⟨P,hP⟩ := exists_nat_ge X
  have hs := eventually_const_mul_rpow_lt (θ := θ/2) (C := 6) (by linarith)
  obtain ⟨Q,hQ⟩ := eventually_atTop.1 hs
  refine ⟨3,by norm_num,max 1 (max P Q),fun p hp _hp => ?_⟩
  have hp1 : 1 ≤ p := (le_max_left _ _).trans hp
  have hpP : P ≤ p := (le_max_left _ _).trans ((le_max_right _ _).trans hp)
  have hpQ : Q ≤ p := (le_max_right _ _).trans ((le_max_right _ _).trans hp)
  have hppos : (0 : ℝ) < p := by exact_mod_cast hp1
  have hpow : 0 < (p : ℝ)^θ := Real.rpow_pos_of_pos hppos θ
  have hsmall : 3*(p : ℝ)^θ ≤ p := by
    have hh := hQ p hpQ
    rw [show 2*(θ/2) = θ by ring] at hh
    linarith
  let x : ℝ := p+3*(p : ℝ)^θ
  have hpx : (p : ℝ) ≤ x := by dsimp [x]; linarith
  have hx : X ≤ x := hP.trans ((by exact_mod_cast hpP : (P : ℝ) ≤ p).trans hpx)
  have hxhi : x ≤ 2*(p : ℝ) := by dsimp [x]; linarith
  have hxpow : x^θ ≤ 2*(p : ℝ)^θ := by
    calc
      _ ≤ (2*(p : ℝ))^θ := Real.rpow_le_rpow (hppos.le.trans hpx) hxhi hθ0
      _ = (2 : ℝ)^θ*(p : ℝ)^θ := Real.mul_rpow (by norm_num) hppos.le
      _ ≤ 2*(p : ℝ)^θ := by
        gcongr
        simpa using Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2) hθ1.le
  obtain ⟨q,hq,hlo,hhi⟩ := hX x hx
  have hpq : (p : ℝ) < q := by dsimp [x] at hlo; linarith
  exact ⟨q,hq,by exact_mod_cast hpq,by dsimp [x] at hhi; linarith⟩

/-- BHP's original Theorem 1 implies the existing normalized gap statement. -/
theorem bakerHarmanPintz_comparator (h : BakerHarmanPintz2001) : BakerHarmanPintz :=
  (gapProgress_iff _).1 (gapProgress_of_backward (by norm_num) (by norm_num) h)

/-- Endpoint gap bounds also match an exponent comparator allowing +epsilon. -/
theorem forwardProgress_of_gap {θ : ℝ} (hθ : 0 ≤ θ) (h : GapProgress θ) :
    ForwardProgress θ := by
  apply (forwardProgress_iff θ).2
  apply statement_of_shortIntervalExponentLimit hθ
  obtain ⟨C,hC,hgap⟩ := (gapProgress_iff θ).1 h
  intro ε hε
  refine ⟨C,hC,?_⟩
  filter_upwards [hgap,eventually_ge_atTop (1 : ℕ)] with p hp hp1 hprime
  obtain ⟨q,hq,hlo,hhi⟩ := hp hprime
  refine ⟨q,hq,hlo,hhi.trans ?_⟩
  apply mul_le_mul_of_nonneg_left _ hC.le
  exact Real.rpow_le_rpow_of_exponent_le (by exact_mod_cast hp1) (by linarith)

theorem cramer_comparator_iff : Cramer1936Conjecture ↔ CramerGapBound := by
  unfold Cramer1936Conjecture CramerGapBound
  simp only [eventually_atTop]

theorem finiteOppermann_implies_legendre {B : ℕ} (h : FiniteOppermann B) :
    FiniteLegendre B := by
  intro n hn hnB
  by_cases h1 : n = 1
  · subst n
    exact legendreAt_one
  obtain ⟨p,hp,hlo,hhi⟩ := (h n (by omega) hnB).1
  exact ⟨p,hp,hlo,by nlinarith⟩

theorem finiteLegendre_mono {A B : ℕ} (hAB : A ≤ B) (h : FiniteLegendre B) :
    FiniteLegendre A := fun n hn hnA => h n hn (hnA.trans hAB)

theorem sorensonWebster_comparator (h : SorensonWebster2025) :
    ∀ n : ℕ, 1 ≤ n → n ≤ 70500000000000 → LegendreAt n :=
  finiteOppermann_implies_legendre h

theorem chen_comparator_iff : Chen1975Progress ↔ AlmostPrimeSquareEventually 2 := by
  constructor
  · rintro ⟨N,hN,h⟩
    apply eventually_atTop.2
    refine ⟨N,fun n hn => ?_⟩
    obtain ⟨m,hlo,hhi,hm⟩ := h n hn
    exact ⟨m,hlo,hhi,by constructor; nlinarith; exact hm⟩
  · intro h
    obtain ⟨N,h⟩ := eventually_atTop.1 h
    refine ⟨max 1 N,le_max_left _ _,fun n hn => ?_⟩
    obtain ⟨m,hlo,hhi,hm⟩ := h n ((le_max_right _ _).trans hn)
    exact ⟨m,hlo,hhi,hm.2⟩

theorem dudekJohnston_comparator_iff : DudekJohnston2026 ↔ AlmostPrimeSquareAtMost 4 := by
  constructor
  · intro h n hn
    obtain ⟨m,hlo,hhi,hm⟩ := h n (by omega)
    exact ⟨m,hlo,hhi,by constructor; nlinarith; exact hm⟩
  · intro h n hn
    obtain ⟨m,hlo,hhi,hm⟩ := h n (by omega)
    exact ⟨m,hlo,hhi,hm.2⟩

/-- Recover an actual prime from a strict increase in the real prime count. -/
theorem exists_prime_of_count_lt {a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b)
    (h : PNT.primeCount a < PNT.primeCount b) :
    ∃ p : ℕ, p.Prime ∧ a < p ∧ (p : ℝ) ≤ b := by
  classical
  unfold PNT.primeCount at h
  have hc : (Nat.primesLE ⌊a⌋₊).card < (Nat.primesLE ⌊b⌋₊).card := by
    simpa only [Nat.primesLE_card_eq_primeCounting] using
      (show Nat.primeCounting ⌊a⌋₊ < Nat.primeCounting ⌊b⌋₊ from by
        exact_mod_cast h)
  obtain ⟨p,hp,hnot⟩ := Finset.exists_mem_notMem_of_card_lt_card hc
  obtain ⟨hpb,hprime⟩ := Nat.mem_primesLE.1 hp
  have hpa : ⌊a⌋₊ < p := by
    by_contra hn
    exact hnot (Nat.mem_primesLE.2 ⟨by omega,hprime⟩)
  exact ⟨p,hprime,(Nat.floor_lt ha).1 hpa,
    (by exact_mod_cast hpb : (p : ℝ) ≤ ⌊b⌋₊).trans (Nat.floor_le hb)⟩

theorem rhGap_comparator_iff : RHGapProgress ↔ RHGapBound := by
  constructor
  · rintro ⟨C,hC,X,_hX,h⟩
    exact ⟨C,hC,eventually_atTop.2 ⟨X,h⟩⟩
  · rintro ⟨C,hC,h⟩
    obtain ⟨X,hX⟩ := eventually_atTop.1 h
    exact ⟨C,hC,max X 2,le_max_right _ _,fun x hx => hX x ((le_max_left _ _).trans hx)⟩

/-- The stronger source count supplies the coarse RH consequence. -/
theorem cramer1920_count_comparator (h : Cramer1920) : Cramer1920Progress := by
  intro hRH
  obtain ⟨c,hc,h⟩ := h hRH
  refine ⟨c,hc,2,le_rfl,fun x hx => ?_⟩
  have hb : 0 ≤ x+c*Real.sqrt x*Real.log x := by
    have hl := Real.log_nonneg (by linarith : (1 : ℝ) ≤ x)
    have hc' := mul_nonneg (mul_nonneg hc.le (Real.sqrt_nonneg x)) hl
    linarith
  have hp : PNT.primeCount x < PNT.primeCount (x+c*Real.sqrt x*Real.log x) := by
    have hs := Real.sqrt_nonneg x
    linarith [h x hx]
  exact exists_prime_of_count_lt (by linarith) hb hp

end Legendre.Literature
