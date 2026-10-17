/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ExplicitBounds
public import Legendre.Nagura.FiniteCertificates
public import Legendre.Nagura.PsiBounds
public import Legendre.Nagura.Theorem

/-!
# Nagura's explicit short-interval theorem

For every real number `x ≥ 25` there is a prime `p` with

`x < p ≤ 6x/5 = x + x/5`,

i.e. `HasPrimeIn x (x/5)`.  Equivalently, for every natural number `n ≥ 25`
there is a prime `p` with `n < p` and `5p < 6n`.

This is the sharpening of Bertrand's postulate due to J. Nagura,
*On the interval containing at least one prime number*, Proc. Japan Acad.
**28** (1952), 177--181, [DOI 10.3792/pja/1195570997](https://doi.org/10.3792/pja/1195570997).
The proof follows Nagura's argument: explicit Chebyshev function estimates
(`0.916 n < ψ(n) < 1.086 n`) obtained from Stirling's formula and Ramanujan's
divisor-sum identities, together with a finite kernel-checked certificate for
`25 ≤ n < 16000000`.

The code in `Legendre/Nagura/` is adapted from the MIT-licensed project
<https://github.com/ShouqiaoW/erdos> at commit
`d28713ac8245ca86a686b8c67370a8d19d81b242`; see `Legendre/Nagura/LICENSE`.
-/

@[expose] public section

namespace Legendre

/-- **Nagura's theorem, natural-number form.**  For every `n ≥ 25` there is a
prime `p` with `n < p` and `5p < 6n`, i.e. `p < 6n/5`. -/
theorem nagura_prime_gap (n : ℕ) (hn : 25 ≤ n) :
    ∃ p : ℕ, p.Prime ∧ n < p ∧ 5 * p < 6 * n :=
  Nagura.exists_prime_nagura hn

/-- **Nagura's theorem, real interval form.**  For every real `x ≥ 25` the
half-open interval `(x, x + x/5]` contains a prime.

This is the explicit short-interval statement of Layer 1 with the named
constant `6/5`, strengthening `hasPrimeIn_self` (`(x, 2x]`). -/
theorem nagura_hasPrimeIn (x : ℝ) (hx : 25 ≤ x) : HasPrimeIn x (x / 5) := by
  have hn : 25 ≤ ⌊x⌋₊ := Nat.le_floor hx
  obtain ⟨p, hp, hnp, h5p⟩ := nagura_prime_gap ⌊x⌋₊ hn
  have hxp : x < (p : ℝ) := by
    have hxlt : x < ((⌊x⌋₊ : ℝ) + 1) := Nat.lt_floor_add_one x
    have hsucc : ((⌊x⌋₊ : ℝ) + 1) ≤ (p : ℝ) := by
      exact_mod_cast Nat.succ_le_of_lt hnp
    linarith
  have hple : (p : ℝ) ≤ x + x / 5 := by
    have h5pR : (5 : ℝ) * (p : ℝ) < 6 * ((⌊x⌋₊ : ℝ)) := by
      exact_mod_cast h5p
    have hnle : ((⌊x⌋₊ : ℝ)) ≤ x := Nat.floor_le (by linarith)
    nlinarith
  exact ⟨p, hp, hxp, hple⟩

/-- Nagura's theorem in interval form at natural endpoints. -/
theorem nagura_hasPrimeIn_nat (n : ℕ) (hn : 25 ≤ n) :
    HasPrimeIn (n : ℝ) ((n : ℝ) / 5) :=
  nagura_hasPrimeIn (n : ℝ) (by exact_mod_cast hn)

end Legendre

end
