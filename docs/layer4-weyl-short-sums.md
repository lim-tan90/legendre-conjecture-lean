# Weyl cancellation for actual short logarithmic sums (2026-11-14)

`import Legendre.Layer4` now exports the proved short-sum estimate
`Legendre.Density.Oscillation.logarithmic_block_weyl`:

```
1<=U, U<=V<=2U, 1<=abs(t), U^2<=4 abs(t)
  => norm(sum_{U<n<=V} n^(-it)) <= C sqrt(U) abs(t)^(1/6).
```

C is one explicit positive constant, independent of U, V and t. Empty
subintervals and either sign of t are included. This is a statement about
the actual complex powers, not an assumed correlation kernel. Its
independent specification `WeylShortSumBenchmark` and closed comparator
`layer4_weyl_short_sum_comparator` retain the exact length restrictions.

## Proof chain

The finite complex correlation identity and interval van der Corput bound
are adapted from the two pinned **openai/math** files listed below. The
remaining modules are local deductions.

| Module in `Legendre/Layer4/Exponential/` | Role |
|---|---|
| `FourierSecondMoment.lean` | Exact finite complex second-moment expansion |
| `VanDerCorput.lean` | Zero-supported finite interval differencing, with endpoint losses |
| `NaturalDifferencing.lean` | Natural-index interface; the overlap is exactly `[1,N-h]` |
| `LogShiftDerivatives.lean` | Actual derivatives and scale of the shifted logarithmic phase |
| `LogShiftCorrelation.lean` | Apply the already proved second-derivative test to actual correlations |
| `LogShiftBudget.lean` | Uniform positive-shift correlation budget |
| `LogDifferencing.lean` | Actual finite differencing square bound and exact complex-power identity |
| `WeylBudget.lean` | Optimize the integer shift, including empty and short prefixes |
| `LogWeyl.lean` | The resulting actual block estimate |

For phase `phi(t,x)=-t log(x)/(2 pi)`, the second derivative of
`phi(t,x+h)-phi(t,x)` has absolute value between
`abs(t) h/(64 pi U^3)` and 64 times that scale on the relevant closure.
This uses the actual third derivative and the mean value theorem. The
second-derivative test gives each positive-shift correlation the uniform bound

```
C0 (sqrt(abs(t) H/U) + U sqrt(U/abs(t))).
```

Van der Corput then gives the square bound

```
2 U^2/H + 2 U C0 (sqrt(abs(t) H/U) + U sqrt(U/abs(t))).
```

The integer choice `H=floor(U/abs(t)^(1/3))`, when the ratio is at least
two and H fits the prefix length, gives at most
`(4+8 C0) U abs(t)^(1/3)`. The other two cases use the trivial unit-phase
bound: a ratio below two, or a prefix shorter than H. All cases are proved;
no endpoint is silently discarded. Taking a square root yields the theorem.

## Provenance

The two adapted files are
`lean/OAI/NumberTheory/EgyptianFractions/FourierSecondMoment.lean` and
`lean/OAI/NumberTheory/EgyptianFractions/VanDerCorput.lean`, from openai/math
at `4eaee87548250b2682affda7d05d947c05554bae`, Apache-2.0. Imports,
namespace and public-module visibility are adapted. Exact links and
destinations are in both READMEs; the license is retained at
`licenses/openai-math-Apache-2.0.txt`.

## Remaining density work

The restricted curved Huxley density remains proved on sigma in [1/2,5/6].
The result here supplies short logarithmic cancellation needed for the
remaining real parts, but does not by itself prove zeta subconvexity,
weighted Mobius detector bounds or density above sigma=5/6. Those analytic
connections remain to be constructed and audited. Guth–Maynard density,
the sharp fourth moment and Layer 5 prime-gap proofs also remain open.

## Verification

Independent consumers cover empty zero extension, the entire-length shift,
zero-length exact differencing, H=1, the shifted derivative at t=0,
empty Weyl blocks, negative ordinates, equality U^2=4 abs(t), and empty
shifted overlaps. The derivative identity at t=0 is separate from the
positive-height hypotheses of the sum theorem. Full audit counts appear in
the READMEs and proof map.

Full verification: 4,298 build jobs; all 4,496 project theorem declarations
(including private/generated ones) in exact four-way agreement between both
independent inventories, Audit targets and parsed output. Only the three
standard axioms occur. All 300 Lean files have zero executable proof
placeholders. All 156 standalone consumers pass (111 Layer 4, 9 Layer 3,
36 literature). Removing the Weyl height/length hypotheses is rejected for
the expected type mismatch.
