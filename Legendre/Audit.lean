/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Conditional
public import Legendre.Bertrand

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

end Legendre
