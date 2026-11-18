# Guth--Maynard: proved outer ranges and the remaining input (2026-11-15)

The full Guth–Maynard benchmark is now proved. [Central-range proof](layer4-guth-central-density.md).

The earlier outer-range checkpoint is recorded below. The project's proved
Ingham and full Huxley curves now give its exponent on both outer intervals:

```
for every epsilon>0, one C>0 works for
sigma in [1/2,7/10] union [4/5,1], all T>=2:
N(sigma,T) <= C*T^(15*(1-sigma)/(3+5*sigma)+epsilon).
```

Both joining endpoints are included, and N retains all analytic
multiplicities. `Zeta.guth_maynard_outer_density_epsilon` proves this statement;
`Literature.layer4_guth_maynard_outer_comparator` supplies the closed witness
for the independent `GuthMaynard2024OuterDensity` specification.

## Proved comparisons

On sigma<=7/10, Ingham gives

```
3*(1-sigma)/(2-sigma) <= 15*(1-sigma)/(3+5*sigma).
```

On sigma>=4/5, full curved Huxley gives

```
3*(1-sigma)/(3*sigma-1) <= 15*(1-sigma)/(3+5*sigma).
```

`GuthMaynardOuterRange.lean` proves both inequalities with their positive
denominators and nonnegative factors explicit. The sum of the two density
coefficients works on the union. It is chosen before sigma and T.

## Exactly the remaining interval

`GuthMaynard2024CentralDensity` independently states the same uniform exponent
on the **open** interval (7/10,4/5). The closed equivalence

```
guthMaynard_density_iff_central :
  GuthMaynard2024Density <-> GuthMaynard2024CentralDensity
```

restricts the full target in one direction and combines the central input
with the proved outer ranges in the other. It preserves one coefficient,
all T>=2, analytic multiplicities and every positive epsilon. It is not a
proof of the central input. Both the full and central Props are explicitly
listed as open in the catalog; the outer comparator is proved.

At sigma=3/4 the desired exponent is 5/9, while both classical curves give
3/5. Thus a smaller epsilon alone cannot turn the existing classical bounds
into the target for every positive epsilon. A stronger large-value/density
estimate on the middle interval remains necessary. The conditional global
30/13 comparison and its prime-gap consequences have not been closed here.

This is a local deduction with no additional external ports. The underlying
source is Guth--Maynard, arXiv:2405.20552; this step does not claim to formalize
their genuinely stronger middle-range argument.

Guth--Maynard outer-range validation (2026-11-15): full build 4,319 jobs;
all 4,667 theorem declarations, including private/generated declarations,
match both independent inventories, audit targets and actual axiom output
exactly. Only propext, Classical.choice and Quot.sound occur. All 321
classified Lean files have no executable placeholders or prohibited
shortcuts. All 182 consumers pass (137 Layer 4, nine Layer 3, 36 literature).
The two joining endpoints share a coefficient; the middle-range strict gap
is checked independently. Lean rejects treating the outer count as the
full target or treating the central equivalence as its missing input.
