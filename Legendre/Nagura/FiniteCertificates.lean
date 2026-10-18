/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

This file is adapted from the MIT-licensed Lean project
https://github.com/ShouqiaoW/erdos, commit d28713ac8245ca86a686b8c67370a8d19d81b242
(2026-08-02), files
`Erdos390/WholePaper/Nagura*.lean`, which formalizes J. Nagura's 1952 proof.
The original MIT license text is in `Legendre/Nagura/LICENSE`.
-/
module

public import Mathlib.NumberTheory.Bertrand
public import Mathlib.Tactic

/-!
# Finite certification of Nagura's interval below sixteen million

This module proves the strict Nagura statement `HasNaguraPrime n` — there is a prime `p` with `n < p` and `5 * p < 6 * n` — on the finite range `25 ≤ n < 16000000`.  The proof is a kernel-checked chain of explicit prime witnesses; each successive pair `a, b` satisfies `5 * b < 6 * a`, so the intervals cover the whole range.

The finite certificate is combined in `Legendre.Nagura.Theorem` with the
analytic tail `n ≥ 16000000`, which follows Nagura's explicit `ψ` estimates
proved in `Legendre.Nagura.PsiBounds`.
-/

@[expose] public section

namespace Legendre.Nagura

/-- The exact natural-number form of the prime interval used in Section 4. -/
def HasNaguraPrime (n : ℕ) : Prop :=
  ∃ p : ℕ, p.Prime ∧ n < p ∧ 5 * p < 6 * n

/-- A kernel-checked finite Nagura certificate.  The upper endpoint exceeds
the cutoff `2103` in Nagura's original analytic proof. -/
theorem exists_prime_nagura_finite {n : ℕ} (hnLower : 25 ≤ n)
    (hnUpper : n < 2423) : HasNaguraPrime n := by
  by_cases h29 : n < 29
  · exact ⟨29, by norm_num, h29, by omega⟩
  by_cases h31 : n < 31
  · exact ⟨31, by norm_num, h31, by omega⟩
  by_cases h37 : n < 37
  · exact ⟨37, by norm_num, h37, by omega⟩
  by_cases h43 : n < 43
  · exact ⟨43, by norm_num, h43, by omega⟩
  by_cases h47 : n < 47
  · exact ⟨47, by norm_num, h47, by omega⟩
  by_cases h53 : n < 53
  · exact ⟨53, by norm_num, h53, by omega⟩
  by_cases h61 : n < 61
  · exact ⟨61, by norm_num, h61, by omega⟩
  by_cases h73 : n < 73
  · exact ⟨73, by norm_num, h73, by omega⟩
  by_cases h83 : n < 83
  · exact ⟨83, by norm_num, h83, by omega⟩
  by_cases h97 : n < 97
  · exact ⟨97, by norm_num, h97, by omega⟩
  by_cases h113 : n < 113
  · exact ⟨113, by norm_num, h113, by omega⟩
  by_cases h131 : n < 131
  · exact ⟨131, by norm_num, h131, by omega⟩
  by_cases h157 : n < 157
  · exact ⟨157, by norm_num, h157, by omega⟩
  by_cases h181 : n < 181
  · exact ⟨181, by norm_num, h181, by omega⟩
  by_cases h211 : n < 211
  · exact ⟨211, by norm_num, h211, by omega⟩
  by_cases h251 : n < 251
  · exact ⟨251, by norm_num, h251, by omega⟩
  by_cases h293 : n < 293
  · exact ⟨293, by norm_num, h293, by omega⟩
  by_cases h349 : n < 349
  · exact ⟨349, by norm_num, h349, by omega⟩
  by_cases h409 : n < 409
  · exact ⟨409, by norm_num, h409, by omega⟩
  by_cases h487 : n < 487
  · exact ⟨487, by norm_num, h487, by omega⟩
  by_cases h577 : n < 577
  · exact ⟨577, by norm_num, h577, by omega⟩
  by_cases h691 : n < 691
  · exact ⟨691, by norm_num, h691, by omega⟩
  by_cases h829 : n < 829
  · exact ⟨829, by norm_num, h829, by omega⟩
  by_cases h991 : n < 991
  · exact ⟨991, by norm_num, h991, by omega⟩
  by_cases h1187 : n < 1187
  · exact ⟨1187, by norm_num, h1187, by omega⟩
  by_cases h1423 : n < 1423
  · exact ⟨1423, by norm_num, h1423, by omega⟩
  by_cases h1699 : n < 1699
  · exact ⟨1699, by norm_num, h1699, by omega⟩
  by_cases h2029 : n < 2029
  · exact ⟨2029, by norm_num, h2029, by omega⟩
  exact ⟨2423, by norm_num, hnUpper, by omega⟩

/-- A second kernel-checked prime chain bridges the original finite
certificate past `89693`, the threshold in Dusart's explicit interval
estimate.  No result from the incomplete Dusart module is imported. -/
theorem exists_prime_nagura_medium {n : ℕ} (hnLower : 2423 ≤ n)
    (hnUpper : n < 91639) : HasNaguraPrime n := by
  by_cases h2903 : n < 2903
  · exact ⟨2903, by norm_num, h2903, by omega⟩
  by_cases h3469 : n < 3469
  · exact ⟨3469, by norm_num, h3469, by omega⟩
  by_cases h4159 : n < 4159
  · exact ⟨4159, by norm_num, h4159, by omega⟩
  by_cases h4987 : n < 4987
  · exact ⟨4987, by norm_num, h4987, by omega⟩
  by_cases h5981 : n < 5981
  · exact ⟨5981, by norm_num, h5981, by omega⟩
  by_cases h7177 : n < 7177
  · exact ⟨7177, by norm_num, h7177, by omega⟩
  by_cases h8609 : n < 8609
  · exact ⟨8609, by norm_num, h8609, by omega⟩
  by_cases h10321 : n < 10321
  · exact ⟨10321, by norm_num, h10321, by omega⟩
  by_cases h12379 : n < 12379
  · exact ⟨12379, by norm_num, h12379, by omega⟩
  by_cases h14851 : n < 14851
  · exact ⟨14851, by norm_num, h14851, by omega⟩
  by_cases h17807 : n < 17807
  · exact ⟨17807, by norm_num, h17807, by omega⟩
  by_cases h21347 : n < 21347
  · exact ⟨21347, by norm_num, h21347, by omega⟩
  by_cases h25609 : n < 25609
  · exact ⟨25609, by norm_num, h25609, by omega⟩
  by_cases h30727 : n < 30727
  · exact ⟨30727, by norm_num, h30727, by omega⟩
  by_cases h36871 : n < 36871
  · exact ⟨36871, by norm_num, h36871, by omega⟩
  by_cases h44221 : n < 44221
  · exact ⟨44221, by norm_num, h44221, by omega⟩
  by_cases h53051 : n < 53051
  · exact ⟨53051, by norm_num, h53051, by omega⟩
  by_cases h63659 : n < 63659
  · exact ⟨63659, by norm_num, h63659, by omega⟩
  by_cases h76387 : n < 76387
  · exact ⟨76387, by norm_num, h76387, by omega⟩
  exact ⟨91639, by norm_num, hnUpper, by omega⟩

/-- Combined unconditional certificate through the explicit-estimate
threshold. -/
theorem exists_prime_nagura_below_91639 {n : ℕ} (hnLower : 25 ≤ n)
    (hnUpper : n < 91639) : HasNaguraPrime n := by
  by_cases h : n < 2423
  · exact exists_prime_nagura_finite hnLower h
  · exact exists_prime_nagura_medium (by omega) hnUpper

/-- A Nagura witness above `pPrev`, together with the assertion that `p` is
the least prime above `pPrev`, gives the scalar inequality used in the
allocation tail. -/
theorem consecutivePrime_ratio_of_naguraWitness {pPrev p : ℕ}
    (hLeast : ∀ q : ℕ, q.Prime → pPrev < q → p ≤ q)
    (hNagura : HasNaguraPrime pPrev) :
    5 * p < 6 * pPrev := by
  obtain ⟨q, hqPrime, hPrevQ, hqRatio⟩ := hNagura
  have hpq : p ≤ q := hLeast q hqPrime hPrevQ
  omega

/-- Exact consecutive-prime consequence on the certified finite range.
The hypotheses say literally that `pPrev < p` are consecutive primes. -/
theorem consecutivePrimes_ratio_finite {pPrev p : ℕ}
    (hConsecutive : pPrev.Prime ∧ p.Prime ∧ pPrev < p ∧
      ∀ q : ℕ, q.Prime → pPrev < q → q < p → False)
    (hpLower : 401 < p) (hpUpper : p ≤ 91639) :
    5 * p < 6 * pPrev := by
  obtain ⟨_hPrevPrime, _hpPrime, hPrevLt, hNoBetween⟩ := hConsecutive
  have hLeast : ∀ q : ℕ, q.Prime → pPrev < q → p ≤ q := by
    intro q hqPrime hPrevQ
    have hnqp : ¬q < p := fun hqp ↦ hNoBetween q hqPrime hPrevQ hqp
    omega
  have hPrevLower : 401 ≤ pPrev := by
    by_cases h : 401 ≤ pPrev
    · exact h
    · have hp401 : p ≤ 401 := hLeast 401 (by norm_num) (by omega)
      omega
  have hPrevUpper : pPrev < 91639 := hPrevLt.trans_le hpUpper
  exact consecutivePrime_ratio_of_naguraWitness hLeast
    (exists_prime_nagura_below_91639 (by omega) hPrevUpper)

theorem exists_prime_nagura_91639_to_218737 {n : ℕ}
    (hnLower : 91639 ≤ n) (hnUpper : n < 218737) : HasNaguraPrime n := by
  by_cases h109063 : n < 109063
  · exact ⟨109063, by norm_num, h109063, by omega⟩
  by_cases h129793 : n < 129793
  · exact ⟨129793, by norm_num, h129793, by omega⟩
  by_cases h154459 : n < 154459
  · exact ⟨154459, by norm_num, h154459, by omega⟩
  by_cases h183809 : n < 183809
  · exact ⟨183809, by norm_num, h183809, by omega⟩
  exact ⟨218737, by norm_num, hnUpper, by omega⟩

theorem exists_prime_nagura_218737_to_522059 {n : ℕ}
    (hnLower : 218737 ≤ n) (hnUpper : n < 522059) : HasNaguraPrime n := by
  by_cases h260317 : n < 260317
  · exact ⟨260317, by norm_num, h260317, by omega⟩
  by_cases h309779 : n < 309779
  · exact ⟨309779, by norm_num, h309779, by omega⟩
  by_cases h368647 : n < 368647
  · exact ⟨368647, by norm_num, h368647, by omega⟩
  by_cases h438701 : n < 438701
  · exact ⟨438701, by norm_num, h438701, by omega⟩
  exact ⟨522059, by norm_num, hnUpper, by omega⟩

theorem exists_prime_nagura_522059_to_1046959 {n : ℕ}
    (hnLower : 522059 ≤ n) (hnUpper : n < 1046959) : HasNaguraPrime n := by
  by_cases h621259 : n < 621259
  · exact ⟨621259, by norm_num, h621259, by omega⟩
  by_cases h739301 : n < 739301
  · exact ⟨739301, by norm_num, h739301, by omega⟩
  by_cases h879797 : n < 879797
  · exact ⟨879797, by norm_num, h879797, by omega⟩
  exact ⟨1046959, by norm_num, hnUpper, by omega⟩

theorem exists_prime_nagura_1046959_to_1482617 {n : ℕ}
    (hnLower : 1046959 ≤ n) (hnUpper : n < 1482617) : HasNaguraPrime n := by
  by_cases h1245883 : n < 1245883
  · exact ⟨1245883, by norm_num, h1245883, by omega⟩
  exact ⟨1482617, by norm_num, hnUpper, by omega⟩

theorem exists_prime_nagura_to_1482617 {n : ℕ}
    (hnLower : 91639 ≤ n) (hnUpper : n < 1482617) : HasNaguraPrime n := by
  by_cases h1 : n < 218737
  · exact exists_prime_nagura_91639_to_218737 hnLower h1
  by_cases h2 : n < 522059
  · exact exists_prime_nagura_218737_to_522059 (by omega) h2
  by_cases h3 : n < 1046959
  · exact exists_prime_nagura_522059_to_1046959 (by omega) h3
  · exact exists_prime_nagura_1046959_to_1482617 (by omega) hnUpper

theorem exists_prime_nagura_1482617_to_3538187 {n : ℕ}
    (hnLower : 1482617 ≤ n) (hnUpper : n < 3538187) : HasNaguraPrime n := by
  by_cases h1764319 : n < 1764319
  · exact ⟨1764319, by norm_num, h1764319, by omega⟩
  by_cases h2099543 : n < 2099543
  · exact ⟨2099543, by norm_num, h2099543, by omega⟩
  by_cases h2498521 : n < 2498521
  · exact ⟨2498521, by norm_num, h2498521, by omega⟩
  by_cases h2973251 : n < 2973251
  · exact ⟨2973251, by norm_num, h2973251, by omega⟩
  exact ⟨3538187, by norm_num, hnUpper, by omega⟩

theorem exists_prime_nagura_3538187_to_8443433 {n : ℕ}
    (hnLower : 3538187 ≤ n) (hnUpper : n < 8443433) : HasNaguraPrime n := by
  by_cases h4210447 : n < 4210447
  · exact ⟨4210447, by norm_num, h4210447, by omega⟩
  by_cases h5010449 : n < 5010449
  · exact ⟨5010449, by norm_num, h5010449, by omega⟩
  by_cases h5962441 : n < 5962441
  · exact ⟨5962441, by norm_num, h5962441, by omega⟩
  by_cases h7095313 : n < 7095313
  · exact ⟨7095313, by norm_num, h7095313, by omega⟩
  exact ⟨8443433, by norm_num, hnUpper, by omega⟩

theorem exists_prime_nagura_8443433_to_16000000 {n : ℕ}
    (hnLower : 8443433 ≤ n) (hnUpper : n < 16000000) : HasNaguraPrime n := by
  by_cases h10047703 : n < 10047703
  · exact ⟨10047703, by norm_num, h10047703, by omega⟩
  by_cases h11956801 : n < 11956801
  · exact ⟨11956801, by norm_num, h11956801, by omega⟩
  by_cases h14228623 : n < 14228623
  · exact ⟨14228623, by norm_num, h14228623, by omega⟩
  exact ⟨16932073, by norm_num, by omega, by omega⟩

theorem exists_prime_nagura_1482617_to_16000000 {n : ℕ}
    (hnLower : 1482617 ≤ n) (hnUpper : n < 16000000) :
    HasNaguraPrime n := by
  by_cases h1 : n < 3538187
  · exact exists_prime_nagura_1482617_to_3538187 hnLower h1
  by_cases h2 : n < 8443433
  · exact exists_prime_nagura_3538187_to_8443433 (by omega) h2
  · exact exists_prime_nagura_8443433_to_16000000 (by omega) hnUpper

theorem exists_prime_nagura_91639_to_16000000 {n : ℕ}
    (hnLower : 91639 ≤ n) (hnUpper : n < 16000000) :
    HasNaguraPrime n := by
  by_cases h : n < 1482617
  · exact exists_prime_nagura_to_1482617 hnLower h
  · exact exists_prime_nagura_1482617_to_16000000 (by omega) hnUpper


end Legendre.Nagura

end
