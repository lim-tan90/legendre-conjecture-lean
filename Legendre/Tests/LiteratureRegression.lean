/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
import Legendre.Literature

/-! # Guards for the exponent, endpoint and scope errors found by literature comparison -/
namespace Legendre.Tests.Literature
open Legendre.Literature Filter Asymptotics
open scoped Topology

/-- This value belongs to Heath-Brown--Iwaniec; 13/23 is a weaker, different row. -/
theorem corrected_heathBrownIwaniec_value :
    HeathBrownIwaniec1979Progress ↔ Legendre.ShortIntervalExponentLimit (11/20) :=
  heathBrownIwaniec_comparator_iff

/-- The unsupported old number is strictly stronger than the source's 23/42. -/
theorem corrected_iwaniecPintz_value :
    (11/20-1/406 : ℝ) < 23/42 ∧
    (IwaniecPintz1984Progress ↔ Legendre.ShortIntervalExponentLimit (23/42)) := by
  exact ⟨by norm_num,iwaniecPintz_comparator_iff⟩

/-- A change of orientation and a harmless coefficient do not lose the BHP exponent. -/
theorem bhp_epsilon_consumer (h : BakerHarmanPintz2001) : ForwardProgress (525/1000) :=
  forwardProgress_of_gap (by norm_num)
    (gapProgress_of_backward (by norm_num) (by norm_num) h)

/-- The strict original Nagura endpoint survives the real-endpoint conversion. -/
theorem strict_nagura_consumer : ∃ p : ℕ, p.Prime ∧ (25 : ℝ) < p ∧ (p : ℝ) < 30 := by
  convert! nagura_comparator 25 (by norm_num) using 1; norm_num

/-- Starting the lower Oppermann half at n=1 would make the specification impossible. -/
theorem oppermann_origin_guard : ¬∃ p : ℕ, p.Prime ∧ 1^2 < p ∧ p < 1*(1+1) := by
  rintro ⟨p,_hp,hlo,hhi⟩
  omega

/-- A P4 witness may be composite; the count of factors is not a primality proof. -/
theorem almost_prime_scope_guard :
    2^2 < (6 : ℕ) ∧ 6 < (2+1)^2 ∧ Nat.IsAtMostAlmostPrime 4 6 ∧ ¬Nat.Prime 6 := by
  refine ⟨by decide,by decide,?_,by decide⟩
  simpa using (Nat.prime_two.isAlmostPrime_one.mul Nat.prime_three.isAlmostPrime_one).isAtMost
    (by norm_num : 1+1 ≤ 4)

/-- The final journal computation's bound is 7.05e13, larger than arXiv v1's bound. -/
theorem computation_version_guard :
    33300000000000 < (70500000000000 : ℕ) ∧
    (FiniteOppermann 70500000000000 → FiniteLegendre 33300000000000) := by
  refine ⟨by norm_num,fun h => ?_⟩
  exact finiteLegendre_mono (by norm_num) (finiteOppermann_implies_legendre h)

/-- Cramer's hypothesis is retained when deriving the square-interval consequence. -/
theorem cramer_bridge_consumer (h : Legendre.CramerGapBound) :
    ∀ᶠ n : ℕ in atTop, Legendre.LegendreAt n := cramer_implies_eventual_legendre h

/-- RH's logarithmic gap consequence has exponent 1/2+epsilon, still conditional. -/
theorem rh_exponent_consumer (h : Legendre.RHGapBound) : ForwardProgress (1/2) :=
  rhGap_exponent_comparator h

/-- A classical PNT error estimate cannot simply be renamed a 0.525 power bound. -/
theorem layer3_power_guard (c : ℝ) :
    ¬Legendre.PNT.classicalError c =O[atTop] (fun x : ℝ => x^(525/1000 : ℝ)) :=
  layer3_no_fixed_power_comparator c _ (by norm_num)

/-- The 12/5 comparison uses proved Ingham and retains the open Huxley input. -/
theorem density_12_5_consumer (hh : Huxley1972Density) :
    Legendre.Zeta.HasZeroDensityEstimate (12/5) := huxley_global_comparator layer4_ingham_comparator hh

/-- The Guth--Maynard comparison consumes its own open curved estimate. -/
theorem density_30_13_consumer (hg : GuthMaynard2024Density) :
    Legendre.Zeta.HasZeroDensityEstimate (30/13) := guthMaynard_global_comparator layer4_ingham_comparator hg

end Legendre.Tests.Literature
