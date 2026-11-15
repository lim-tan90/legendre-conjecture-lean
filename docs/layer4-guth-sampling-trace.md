# Guth--Maynard finite sampling and cubic dispersion (2026-11-15)

The finite matrix stage of Guth--Maynard's large-value method is now proved
for the actual smoothed Dirichlet polynomial. Write M for its sampling
matrix, G=M M* for the row Gram matrix, R for the number of sample points,
E=sum |b_n|^2 for the actual coefficient energy, and

```
D = Re(trace(G^3)) - Re(trace(G))^3/R^2.
```

For a nonempty finite sample set and V>=0, if each actual sampled polynomial
has norm at least V, the new interface proves

```
D>=0,
R^3 V^6 <= E^3 (4D+8N^3).
```

The core finite inequalities are Guth--Maynard Lemmas 4.1--4.2; there is no
assumed analytic bound for D. The spectral proof uses positivity of the
actual Gram matrix, an explicit L2 operator norm and a finite Jensen
inequality. Its average branch is retained: a flat nonzero spectrum has
zero dispersion, so dispersion alone cannot bound its coordinates.

The literal finite-polynomial/coefficient-energy/trace statement is the
independent `Literature.GuthMaynardSamplingTraceBenchmark`; the closed witness
is `layer4_guth_sampling_trace_comparator`. This is exported through
`import Legendre.Layer4` together with the five adapted modules.
The arbitrary-energy extension is local; the bounded-coefficient raw count
from the source is also retained.

The actual positive-phase polynomial, exact closed/half-open endpoint
relation and negative-argument reciprocal/conjugation identity are proved.
A nonzero matrix entry on the cutoff plateau is checked independently, as
are the explicit left-endpoint contribution and the flat-spectrum case.

This stage does not yet prove the analytic off-diagonal/Poisson estimates
needed to bound D, or the remaining zero-density input on (7/10,4/5).
The full Guth--Maynard target therefore remains open. The completed full
Huxley curve and the Guth--Maynard outer intervals remain proved.

[Fixed sources, license and Lean 4.35.0 adaptations](smccolm-guth-provenance.md).

Sampling-trace validation (2026-11-15): all five ported modules and their
consumers compile from source under Lean 4.35.0 (commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc).
The full build passes 4,324 jobs. All 4,787 project theorem declarations,
including private/generated declarations from every port, match the two
independent inventories, audit targets and actual axiom output exactly.
Only propext, Classical.choice and Quot.sound occur. All 326 classified
Lean sources have no executable placeholders or prohibited shortcuts.
All 186 consumers pass (141 Layer 4, nine Layer 3, 36 literature). New
consumers cover a nonzero matrix plateau, the literal left endpoint, a flat
spectrum and negative reciprocal arguments. Lean rejects dropping the
average branch or using the finite count as the open central density input.
The retained MIT-0 license has the exact upstream Git blob hash
34f468585a9582c8a1d0f9440b6c0f8b5f98f2e8.
