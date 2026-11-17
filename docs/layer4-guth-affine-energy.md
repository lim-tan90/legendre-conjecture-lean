# Guth--Maynard affine iteration and physical energy estimates (2026-11-17)

Write R=card(W), and let E be the number of ordered quadruples in W with
absolute additive defect <=1. All results below are proved from the actual
finite polynomials, affine sums and cubic S3 object. The final large-values
theorem and central zero-density assembly on (7/10,4/5) remain open.

## Affine functional and uniformity

The finite functional J(f,M) is the maximum of the squared affine-sum
integrals over positive integer scales M1,M2,M3<=M. Its actual summands are
f((m1*u+m3)/m2), with signed shell M1<=|m1|<=2M1, positive shell
M2<=m2<=2M2 and central shell |m3|<=8M3. Proposition9.1 proves

```
J(f,M) <= C*T^epsilon*(M^6*(integral f)^2+M^4*integral f^2).
```

For a fixed nonnegative Schwartz function supported in [1/2,2], C,T0 may
depend on f and epsilon, and the estimate holds for T>=T0 and 0<M<=T^4.
The literal affine benchmark expands the finite sums and integrals, independently
of the J abbreviation. Lemma9.2 includes all three Fourier regions and their
tails; an explicit finite descent on natural numbers closes the recurrence.

Applying a fixed-function theorem separately to height-dependent functions
would not supply a uniform constant. The height-family theorem instead fixes
one nonnegative coefficient family D(delta,n) before choosing C,T0. For every
source f in the family and each delta>0 and n>=0, it retains the condition

```
seminorm(n,0, Fourier(complexify f))
  <= D(delta,n)*T^delta*T^(n+2)*integral f.
```

Here f is nonnegative and supported in [1/4,9/4]. The corrected finite descent
works uniformly over heights and sources, with a factor 2 per smoothing in
the mass-normalized profile. The complete normalized smoothed R-square source
actually constructed from W satisfies this profile. Its reflected centers and
ratio ranges are retained when it is passed into Proposition9.1.

## Physical S3 and energy estimates

For every epsilon>0 there are C>0 and a common T0, before all physical
scales, sets and coefficients. For one-separated W in [0,T], T>=T0 and
T^(2/3)<=N<=T, Proposition10.1 gives

```
norm(S3) <= C*(T^(2+epsilon)*R^(3/2)
              +T^(1+epsilon)*N*sqrt(R)*sqrt(E))+C/T^90.
```

With the stronger window T^(3/4)<=N<=T and coefficients bounded by one
on (N,2N], assume the actual positive-phase polynomial has magnitude at
least N^sigma at every t in W. Proposition11.1 then gives

```
E <= C*T^epsilon*(R*N^(4-4*sigma)
                  +R^(21/8)*T^(1/4)*N^(1-2*sigma)
                  +R^3*N^(1-2*sigma)).
```

Substitution into the physical S3 bound proves Proposition11.2:

```
norm(S3) <= C*T^epsilon*(T^2*R^(3/2)
                        +T*R*N^(3-2*sigma)
                        +T*R^2*N^(3/2-sigma)
                        +T^(9/8)*R^(29/16)*N^(3/2-sigma))+C/T^90.
```

The energy proof uses coefficient-preserving Fourier reflection, exact
difference-bin and gcd decompositions, and the proved Heath--Brown mean square.
Replacing a real quotient by natural N/d requires the possible endpoint
2*(N/d)+1; the corrected finite support includes it before estimating its
two rows and corner. It is not dropped by an informal dyadic approximation.

E is the source's closed energy. The independently proved comparison
E_strict<=E<=3*E_strict controls the paper's strict convention up to absolute
constants. These definitions are not equated: at W={0,1} they are 6 and14.
No new prime-gap exponent or central-density proof is claimed.

## Independent specifications and sources

The following five benchmarks have closed comparison witnesses in
`Legendre/Literature/LayerCoverage.lean` and are part of the generated Layer4
coverage conjunction:

- `GuthMaynardAffineBenchmark`
- `GuthMaynardAffineHeightFamilyBenchmark`
- `GuthMaynardRefinedS3Benchmark`
- `GuthMaynardLargeValuesEnergyBenchmark`
- `GuthMaynardEnergyS3Benchmark`

The energy definitions use a literal quadruple filter. Sample assumptions use
literal finite polynomials and support-only coefficient bounds. Every scale,
separation and remainder condition stays in the independent specification.

All seven new adapted modules use existing source **#5 smccolm/Lean**, pinned
commit `4c8fb7f7816508825089230e3730b69165e5e303`, MIT-0. Both READMEs retain
the prominent repository heading and its independently collapsible, default-open
details with the uniform commit/license/local-path/adaptation fields.

| Upstream file | Local file in `Legendre/Layer4/GuthMaynard/` |
|---|---|
| `LargeValuesLanguage.lean` | `AffineLanguage.lean` |
| `LargeValuesAffine.lean` | `AffineTransform.lean` |
| `LargeValuesAffineIteration.lean` | `AffineIteration.lean` |
| `LargeValuesAffineHeight.lean` | `AffineHeight.lean` |
| `LargeValuesS3Refined.lean` | `CubicThreeTailRefined.lean` |
| `LargeValuesEnergy.lean` | `EnergyDecomposition.lean` |
| `LargeValuesEnergyFinal.lean` | `EnergyFinal.lean` |

All original source blobs match the pinned upstream Git tree. Every local
module is compiled from source under **Lean4.35.0**; no upstream compiled
artifacts are used. Headers and the retained MIT-0 license preserve attribution.
[Detailed mapping and compatibility changes](smccolm-guth-provenance.md).


Affine/energy validation (2026-11-17): Lean4.35.0 full build passes 4,362 jobs.
All 8,268 project theorem declarations, including private/generated declarations,
agree exactly between module-data enumeration, independent environment ownership,
Audit targets and parsed axiom output. Only propext, Classical.choice and
Quot.sound occur. All 351 classified Lean files, including Layers 0--4, contain
no executable placeholders/prohibited shortcuts; no PDFs are present.
All 218 independent consumers pass (173 Layer 4, nine Layer 3, 24 generated
literature and 12 literature regressions). Eight new consumers check negative
scaling, translated boundary energy, zero source, exact smoothing mass,
natural-division endpoints, singleton refined S3 and sigma=3/4 energy/S3 powers.
Six negative contract checks reject deleting coefficient, separation, T^(3/4)
window, Fourier-family or T^-90 remainder conditions, or confusing the affine
bound with central density. All 29 adapted modules retain the exact source pin
and MIT-0 metadata; the license blob is unchanged. The seven new original
source blobs match the pinned Git tree. Both READMEs retain the same five
prominent numbered repository headings and individual default-open details.
