# Guth–Maynard Theorem 1.1

Let `N ≥ 1` be an integer, `T ≥ 1`, and `V > 0`. For complex
coefficients bounded by one on the integers in `[N,2N]`, suppose the
positive-phase sum `Σ_{N≤n≤2N} bₙ n^(it)` has modulus at least `V` at
every point of a finite one-separated set `W ⊆ [0,T]`. For every
`ε > 0`, the proved count is

```text
|W| ≤ Cε T^ε (N² V⁻² + N^(18/5) V⁻⁴ + T N^(12/5) V⁻⁴).
```

`guthMaynardLargeValues_published_native` proves the closed-sum version.
`GuthMaynardPublishedLargeValuesBenchmark` states the same claim
independently with the literal finite sum. Its checker expands the separation,
coefficient and sampling hypotheses.

The smooth argument combines spectral centering with S₂ and S₃, solves the
resulting inequalities in the sample count and proves the Section 12 estimate.
A finite cover by intervals of length `N^(6/5)` gives the full-height smooth
bound. The sharp half-open block follows by localization and the classical
Montgomery and Halász bounds in the complementary ranges. For the closed sum,
the omitted term has modulus at most one. For `V > 2`, removing it leaves a
threshold of at least `V/2`. For `V ≤ 2`, the separated-set cardinality
bound suffices. The negative-phase half-open form follows by conjugation.

The source adaptations use the existing pinned smccolm/Lean MIT-0 entry.
The exact source files and mapping appear in both READMEs and the provenance
table. The three adapted modules compile from source under Lean 4.35.0.
[Provenance and adaptations](smccolm-guth-provenance.md)

Theorem 1.2 still needs the Section 13 transfer from Dirichlet polynomial
large values to zeta zero counts in the central interval `(7/10,4/5)`.
The existing outer ranges cover the other real parts.

The local checkpoint built all 4,366 jobs and audited all 8,398 theorem
declarations. Module data, environment ownership, audit targets and kernel
output agree on that complete list. The 355 classified Lean files passed
the placeholder scan. The independent endpoint example uses two unit
summands at `N=1` and an off-support coefficient of modulus 100.
