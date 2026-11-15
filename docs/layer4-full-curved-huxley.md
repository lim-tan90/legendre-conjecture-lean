# Full curved Huxley zero-density exponent (2026-11-15)

`Legendre.Zeta.huxley_curved_density_epsilon` now proves the full independent
`Literature.Huxley1972Density` benchmark. For every epsilon>0 there is one
C>0 such that, simultaneously for sigma in [1/2,1] and every T>=2,

```
N(sigma,T) <= C*T^(3*(1-sigma)/(3*sigma-1)+epsilon).
```

`N` is the project's actual zero-density count with analytic multiplicities.
The coefficient is chosen before sigma and T. Both real-part endpoints and
the finite-height range are included. This is the exponent formulation with
arbitrary positive epsilon; a sharp logarithmic loss is not asserted.
The closed independent witness is `Literature.layer4_huxley_comparator`.
All proof modules are exported through `import Legendre.Layer4`.

## Common cutoff and both actual detector branches

`UpperHuxleyShell.lean` proves the shell count for each fixed eta>0,
sigma in [5/6+eta,1] and T>=128. Choose the same integer cutoff

```
delta = min(eta/16, min(epsilon/16,1/2)),
T^delta <= X <= 2*T^delta,  X <= 2*T.
```

Filter the actual zero family according to whether its actual compact
polynomial tail at Y=T has norm at least 1/16. The proved upper Type I count
bounds the first filter. The proved actual Type II count bounds its
complement by C*T^(3-4*sigma+4*delta+epsilon/2), which is bounded by the
curved target with epsilon. The cardinalities add exactly; no branch is
assumed empty. Principal-pole exclusion is supplied by the actual positive
height shell in the Type II detector theorem.

## Uniformity at the transition

`HuxleyFullShell.lean` proves

```
1/3 - 3*(1-sigma)/(3*sigma-1) <= (8/3)*(sigma-5/6)
```

for sigma>=5/6. For the final shell epsilon choose eta=epsilon/16 and
apply the proved restricted and upper shell counts with epsilon/2.
For sigma<=5/6 use the restricted count; for sigma>=5/6+eta use the upper
count. In the band between them use the proved count at sigma=5/6 for the
same zero family. Its exponent 1/3+epsilon/2 is at most the desired
curved exponent plus epsilon by the displayed inequality. The sum of the
two coefficients works for all sigma in [3/4,1]. In particular, eta is
chosen from epsilon before sigma; no pointwise-in-sigma constant is passed
into a uniform benchmark.

## Heights, multiplicities and lower real parts

`HuxleyFullDensity.lean` uses the already proved finite dyadic height cover
to count all separated ordinates with 64<abs(t)<=T. It keeps the logarithmic
cover cost and uses the nonnegative curved exponent to bound shell powers
uniformly. The proved cutoff selection theorem restores actual analytic
multiplicities, with one further logarithmic cost. Both are absorbed into
an epsilon allowance. Heights below 128 use the actual finite zero count
at 128. Thus the upper density theorem holds for every T>=2 and sigma in
[3/4,1]. Ingham's proved exponent is at most the Huxley curve for sigma in
[1/2,3/4], completing the full stated real-part interval.

## Scope and sources

No open analytic estimate is a hypothesis of the proof. The result closes
an exponent-level analytic benchmark associated with Huxley 1972, rather
than the paper's 7/12 prime-gap conclusion. The latter still needs a Layer 5
transmission proof. Guth--Maynard's stronger density benchmark and the sharp
log^4 fourth moment remain open.

This step is a local deduction from the already attributed formalizations.
It adds no external ports. The actual-detector and oscillatory inputs retain
their existing provenance in both READMEs and `docs/openai-math-provenance.md`.

Full curved Huxley validation (2026-11-15): full build 4,318 jobs. All
4,659 project theorem declarations, including private/generated declarations,
match the module-data inventory, independent environment inventory, audit
targets and actual axiom output exactly. Only the three standard axioms occur.
All 320 classified Lean sources are free of executable placeholders and
prohibited shortcuts. All 180 consumers pass (135 Layer 4, nine Layer 3,
36 literature). New consumers share one coefficient at sigma=1/2,5/6,9/10,1,
throughout the transition band and at T=2. Lean rejects zero epsilon and
confusion with Guth--Maynard density or the 7/12 prime-gap claim.
