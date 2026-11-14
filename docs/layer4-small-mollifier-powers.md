# Small mollifiers and powered short blocks (2026-11-14)

The global Huxley `12/5` theorem remains closed. This checkpoint proves
additional ingredients toward the stronger curved density benchmark; it does
**not** prove that benchmark or a Layer 5 prime-gap theorem.

## Actual Type II zeros

All declarations below are exported by `import Legendre.Layer4` in namespace
`Legendre.Density.Moment`.

`IndividualCriticalFourth.lean` proves, with absolute constants,

```
mass(X,t)^4 <= C X^4 integral w(v-t) abs(zeta(1/2+iv))^4 dv
sum_i mass(X,t_i)^4 <= C X^4 T log(T)^6.
```

The second inequality assumes unit-separated ordinates with `abs(t_i)<=T`,
`T>=2`. The first also covers `X=0`. It uses pointwise mollifier boundedness
and the proved packed fourth moment. Taking powers **before** summation
avoids the extra sample-cardinality factor of a packed-sum estimate.

`TypeIIIntegralCount.lean` applies the actual critical-integral threshold
`1/16`. For independently varying real parts `beta_i in [sigma,1]`,
`sigma>=3/4`, and smoothing length `Y=sqrt(T)`, it proves

```
R <= C X^4 T^(2-2*sigma) log(T)^6.
```

For every `epsilon>0`, the constant in
`integral_alternative_small_cutoff_epsilon` is uniform in `delta>=0`,
`sigma>=3/4`, `T>=2`, and integer cutoffs `X<=2 T^delta`:

```
R <= C_epsilon T^(2-2*sigma+4*delta+epsilon).
```

`SmallMollifierTypeII.lean` connects this bound to actual zeta zeros in
`T/2<=abs(t_i)<=T`, `T>=128`, which fail the literal polynomial alternative.
`actual_typeII_given_cutoff_count` keeps the cutoff explicit, including
`1<=X<=2T`. It proves the principal-pole exclusion from the nonzero ordinate;
no inference from the zeta value at its meromorphic pole is used.
`actual_typeII_small_mollifier_count` chooses `X=ceil(T^delta)` with
`delta=min(epsilon/8,1/2)` and obtains

```
R <= C_epsilon T^(2-2*sigma+epsilon), uniformly sigma in [3/4,1].
```

The cutoff is chosen before sigma and before the zero family. These are
finite-family bounds for one detector branch, not the full density count.
The polynomial branch, height cover and analytic multiplicities cannot be
omitted when proving a new density theorem.

## Exact polynomial powering

`Arithmetic/PolynomialPowers.lean` proves finite-support Dirichlet convolution
and its exact finite-series product identity on **every** complex line.
For coefficients bounded by `d(n)^r`, the k-th convolution power is bounded
by `d(n)^((r+1)k)`. The divisor subpower estimate then gives, for every
`eta>0`, a constant uniform over the coefficient sequence and all `k<=K`.
`Arithmetic/BlockPolynomialPowers.lean` retains both support endpoints and
identifies the arithmetic-function mask with the actual complex block.
`Arithmetic/PoweredBlockDecomposition.lean` decomposes the k-th power of a
block `(U,2U]` into exactly k dyadic blocks above `U^k`, and extracts a piece
of size at least `W^k/k` when the original block has norm at least W.

The two divisor-growth modules are adaptations from **openai/math** at
`4eaee87548250b2682affda7d05d947c05554bae`, Apache-2.0; exact paths and retained
license appear in both READMEs and [the provenance record](openai-math-provenance.md).
All convolution and detector assembly in this checkpoint is local code.

## Power-selection range and remaining work

`HuxleyPowerSelection.lean` proves the bounded integer-power selection for
`3/4<=sigma<=5/6`. If `delta<=u<=1/2` and `delta>0`, some integer
`1<=k<=ceil(1/delta)+2` satisfies

```
A <= k*u <= B, A=1/(3*sigma-1), B=3/(2*(3*sigma-1)).
```

Both actual Halasz length exponents then fit `3(1-sigma)/(3*sigma-1)`.
This is parameter algebra, **not yet a density theorem even on this range**.
For `sigma>5/6`, B drops below one; the same two-case selection argument
cannot be extended there. Additional short-sum analytic input is required
by this route. No defect in the cited paper is asserted.

The mathematical strategy is discussed in Guth–Maynard, *New large value
estimates for Dirichlet polynomials*,
[arXiv:2405.20552v2, Section 13.1](https://arxiv.org/html/2405.20552v2#S13.SS1).
This is a mathematical reference, not a port of Lean code. The remaining
steps are the powered large-value count, its assembly with the detector's
polynomial branch, full height and multiplicity restoration, and the
additional analytic input above sigma=5/6.

## Verification

The new independent consumers check X=0, the empty actual-zero family,
delta=0, the lowest detector height, the convolution square of the n=2
singleton (coefficient one at n=4 and zero at n=2), the zero-th power of an
empty block, the excluded lower support endpoint, uniformity at k=K,
the sigma=5/6 length boundary, bounded power selection and k=1 decomposition.
Full audit results are recorded in both READMEs and the proof map.

Full validation on 2026-11-14: 4,281 build jobs; all 4,351 project theorem
declarations in exact agreement across the two independent inventories,
audit targets and parsed axiom output. Only the three standard axioms occur.
All 283 Lean files are free of executable placeholders. All 139 consumers
pass (94 Layer 4, 9 Layer 3, 36 literature). The deliberate pointwise-power
misuse is rejected for the expected type mismatch, not for a missing import.
