# Hardy–Littlewood second moment on the critical line

For every (Tge 2), one absolute constant satisfies

[
left|int_0^T |zeta(1/2+it)|^2,dt-Tlog T
ight|
le C Tsqrt{1+log T}.
]

The normalized integral therefore tends to one. The independent comparators
state the limit, the linear error and the pole-compensated finite Euler bound.
[Proof](../Legendre/Layer4/ZetaSecondMoment.lean)
[Comparator](../Legendre/Literature/LayerCoverage.lean)
[Hardy and Littlewood, Acta Mathematica](https://doi.org/10.1007/BF02422942)

## Finite inputs

For (tge 2) and (tle Nle 2t^2), the truncation error of the
critical-line Dirichlet series is bounded by (4+72pi). A dyadic multiple
of (N) lies between (t^2) and (2t^2), where the earlier finite Euler
formula has error at most four. The first-derivative estimate bounds each
intervening block by (12pisqrt U/t). The square roots sum geometrically.
[Linear-height cutoff](../Legendre/Layer4/ZetaLinearEuler.lean)

On every ordered or reversed finite interval ([A,B]), the critical-line
Dirichlet polynomial of length (N) has diagonal ((B-A)H_N) and an
absolute error at most (2(pi+4)N). For (x,y>0), the term

[
rac{1}{log x-log y}-rac{sqrt{xy}}{x-y}
]

has absolute value at most one, with both reciprocal terms zero on the
diagonal in Lean. The (sqrt{xy}) factor cancels the critical-line
coefficients in the second term. Hilbert's inequality then bounds its
contribution by (pi N) at each endpoint. The first term's bounded
residual contributes at most ((sum_{nle N}n^{-1/2})^2le 4N).
[Harmonic diagonal and kernel comparison](../Legendre/Layer4/CriticalPolynomialMean.lean)

## Initial assembly

Use the single cutoff (N=lceil T
ceil) on ([sqrt T,T]).
The harmonic mean square and Cauchy–Schwarz give a first moment
(O(Tsqrt{1+log T})) for this polynomial. The pointwise truncation error
therefore changes the second moment by at most that order. The sharp
fourth-moment bound controls the initial interval ([0,sqrt T]) with
an (O(T)) contribution. The harmonic number differs from (log T) by
at most two, and the missing initial length changes the diagonal by (O(T)).


## Fourier refinement and linear remainder

At every integer cutoff (N\ge\max(1,|\operatorname{Im}s|)) in
(0<\operatorname{Re}s\le1), the finite Euler error after subtracting
the explicit pole term is (O(N^{-\operatorname{Re}s})). Integrating the
centered fractional part by parts gives the periodic quadratic Bernoulli
primitive. Mathlib's absolutely convergent Bernoulli series separates its
constant Fourier term. For a nonzero mode with exponent (u=-s-2),
divide the integrand by (2\pi ik+u/x) and differentiate. This
denominator has norm at least one for (x\ge N). The boundary term and
the remaining integral are both (O(N^{\operatorname{Re}u})), uniformly
in the nonzero index. The constant Fourier term is integrated exactly.
[Mode estimate](../Legendre/Layer4/ZetaEulerFourierMode.lean)
[Bernoulli series](../Legendre/Layer4/ZetaEulerBernoulli.lean)
[Finite Euler remainder](../Legendre/Layer4/ZetaEulerSharpTail.lean)

Use (N=\lceil Tceil) on ([T^{2/3},T]). The explicit pole term
is (O(T^{-1/6})) there, and the compensated error is (O(T^{-1/2})).
Multiplying the pointwise error by the polynomial's first moment preserves
an (O(T)) bound. Cauchy–Schwarz and the fourth moment also give (O(T))
on ([0,T^{2/3}]) after absorbing two logarithms. The finite harmonic
diagonal then gives (T\log T+O(T)) for every (T\ge2).
[Second-moment assembly](../Legendre/Layer4/ZetaSecondMoment.lean)
