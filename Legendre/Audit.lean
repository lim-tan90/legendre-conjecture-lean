/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Conditional
public import Legendre.Bertrand
public import Legendre.ExplicitBounds
public import Legendre.Layer5
public import Legendre.Nagura
public import Legendre.Zeta

/-!
# Axiom audit

`#print axioms` lists every axiom a theorem depends on.  For this project the
only permitted axioms are Lean's standard classical axioms:

* `propext`
* `Classical.choice`
* `Quot.sound`

In particular, no `sorryAx`, no user `axiom`, and no `False.elim`-style
"explosion" shortcut may appear.  `scripts/audit.py` parses this output and
fails the build if any other axiom is reported.
-/

namespace Legendre

#print axioms legendreAt_one
#print axioms sq_interval_length
#print axioms legendre_of_gap_lt_two_sqrt
#print axioms eventually_const_mul_rpow_lt
#print axioms eventually_legendre_of_gap_exponent_lt_half
#print axioms legendre_eventually_of_shortIntervalExponent_lt_half
#print axioms legendre_eventually_of_shortIntervalExponentLimit_lt_half
#print axioms hoheisel_above_half
#print axioms ingham58_above_half
#print axioms ingham577_above_half
#print axioms huxley_above_half
#print axioms heathBrownIwaniec_above_half
#print axioms iwaniecPintz_above_half
#print axioms mozzochi_above_half
#print axioms bakerHarman_above_half
#print axioms bakerHarmanPintz_above_half
#print axioms bhp_exponent_not_below_half
#print axioms prime_of_isAtMostAlmostPrime_one
#print axioms conjecture_of_almostPrimeSquareAtMost_one
#print axioms almostPrimeSquareAtMost_one_of_conjecture
#print axioms almostPrimeSquareAtMost_one_iff
#print axioms bertrand
#print axioms bertrand_gap_le
#print axioms square_interval_shorter_than_linear_gap
#print axioms hasPrimeIn_self
#print axioms exists_prime_of_theta_lt
#print axioms hasPrimeIn_of_theta_gap
#print axioms theta_upper_explicit
#print axioms theta_lower_explicit
#print axioms psi_upper_explicit
#print axioms psi_lower_explicit
#print axioms pi_lower_explicit
#print axioms pi_upper_explicit
#print axioms primeGapBound_iff_eventuallyGapBound
#print axioms primeGapBound_of_hasPrimeInShortInterval
#print axioms hasPrimeInShortInterval_of_primeGapBound
#print axioms hasPrimeInShortInterval_iff_primeGapBound
#print axioms hasPrimeInShortInterval_mono
#print axioms shortIntervalStatement_mono
#print axioms shortIntervalExponentLimit_of_statement
#print axioms statement_of_shortIntervalExponentLimit
#print axioms shortIntervalStatement_iff_exponentLimit
#print axioms legendre_eventually_of_shortIntervalStatement_lt_half
#print axioms hoheiselPaper_iff
#print axioms ingham58Paper_iff
#print axioms ingham577Paper_iff
#print axioms huxleyPaper_iff
#print axioms heathBrownIwaniecPaper_iff
#print axioms iwaniecPintzPaper_iff
#print axioms mozzochiPaper_iff
#print axioms bakerHarmanPaper_iff
#print axioms bakerHarmanPintzPaper_iff
#print axioms Legendre.Nagura.exists_prime_nagura
#print axioms Legendre.Nagura.exists_prime_nagura_91639_to_16000000
#print axioms Legendre.Nagura.exists_prime_nagura_analytic_tail
#print axioms Legendre.Nagura.psi_nat_lt_1_086_mul
#print axioms Legendre.Nagura.psi_nat_gt_0_916_mul
#print axioms Legendre.Nagura.naguraGeneralUpperCombination_lt_1_0851_mul
#print axioms Legendre.Nagura.naguraGeneralLowerCombination_gt_0_916_mul
#print axioms nagura_prime_gap
#print axioms nagura_hasPrimeIn
#print axioms nagura_hasPrimeIn_nat

end Legendre

#print axioms Legendre.Zeta.series_norm_summable
#print axioms Legendre.Zeta.eq_series
#print axioms Legendre.Zeta.euler_product
#print axioms Legendre.Zeta.euler_product_limit
#print axioms Legendre.Zeta.analytic_off_pole
#print axioms Legendre.Zeta.completed_functional_equation
#print axioms Legendre.Zeta.nonvanishing
#print axioms Legendre.Zeta.finite_zeros_on_compact
#print axioms Legendre.Zeta.exists_zero_free_band
#print axioms Legendre.Zeta.exists_zero_free_strip
