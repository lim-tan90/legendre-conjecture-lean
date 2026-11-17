/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Layer5
public import Legendre.Layer3
public import Legendre.Layer4

/-!
# Independent literature comparison statements

These are specifications, not assumed theorems. `Progress` records the
conclusion cited in the historical table; it does not assert that an entire
paper is equivalent to prime existence. Stronger source conclusions retain
separate names. Source locators and evidence levels are in
`docs/literature-comparators.md` and `docs/literature-comparators.json`.
No proof of an open historical result is introduced here.
-/

@[expose] public section

namespace Legendre.Literature

open Filter Set Asymptotics
open scoped Topology ArithmeticFunction.Omega

/-- Legendre's open square intervals, independently of `LegendreAt`. -/
def Legendre1808 : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∃ p : ℕ, Nat.Prime p ∧ n*n < p ∧ p < (n+1)*(n+1)

/-- The strict classical Bertrand interval, excluding n=1. -/
def Bertrand1852 : Prop :=
  ∀ n : ℕ, 2 ≤ n → ∃ p : ℕ, Nat.Prime p ∧ n < p ∧ p < 2*n

/-- The strict real interval in Nagura's theorem. -/
def Nagura1952 : Prop :=
  ∀ x : ℝ, 25 ≤ x → ∃ p : ℕ, Nat.Prime p ∧ x < p ∧ (p : ℝ) < 6*x/5

/-- The normalized +ε prime-existence consequence, with all quantifiers visible. -/
def ForwardProgress (θ : ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ X : ℝ, 1 ≤ X ∧ ∀ x : ℝ, X ≤ x →
    ∃ p : ℕ, Nat.Prime p ∧ x < p ∧ (p : ℝ) ≤ x+x^(θ+ε)

/-- A closed backward interval with coefficient exactly one, as in BHP Thm 1. -/
def BackwardProgress (θ : ℝ) : Prop :=
  ∃ X : ℝ, 1 ≤ X ∧ ∀ x : ℝ, X ≤ x →
    ∃ p : ℕ, Nat.Prime p ∧ x-x^θ ≤ (p : ℝ) ∧ (p : ℝ) ≤ x

/-- A normalized endpoint gap consequence; the coefficient is existential. -/
def GapProgress (θ : ℝ) : Prop :=
  ∃ C : ℝ, 0 < C ∧ ∃ P : ℕ, ∀ p : ℕ, P ≤ p → Nat.Prime p →
    ∃ q : ℕ, Nat.Prime q ∧ p < q ∧ (q-p : ℝ) ≤ C*(p : ℝ)^θ

/-- A stronger backward prime-count asymptotic, not just prime existence. -/
def ShortPrimeCountAsymptotic (θ : ℝ) : Prop :=
  Tendsto (fun x : ℝ => (PNT.primeCount x-PNT.primeCount (x-x^θ))/(x^θ/Real.log x))
    atTop (𝓝 1)

/-- A positive-proportion lower count, retaining the information lost by existence. -/
def ShortPrimeCountLowerBound (θ : ℝ) : Prop :=
  ∃ c > 0, ∀ᶠ x : ℝ in atTop,
    c*x^θ/Real.log x ≤ PNT.primeCount x-PNT.primeCount (x-x^θ)

/-- Strictly above an infimum exponent, without asserting its endpoint. -/
def ShortPrimeCountLimit (θ : ℝ) : Prop :=
  ∀ η : ℝ, θ < η → η < 1 → ShortPrimeCountAsymptotic η

-- These progress specifications deliberately do not replace the stronger count statements.
def Hoheisel1930Progress : Prop := ForwardProgress (32999/33000)
def Ingham1937LindelofProgress : Prop := ForwardProgress (5/8)
def Ingham1937DensityProgress : Prop := ForwardProgress (577/925)
def Huxley1972Progress : Prop := ForwardProgress (7/12)
def HeathBrownIwaniec1979Progress : Prop := ForwardProgress (11/20)
def IwaniecPintz1984Progress : Prop := ForwardProgress (23/42)
def Mozzochi1986Progress : Prop := ForwardProgress (11/20-1/384)
def BakerHarman1996Progress : Prop := GapProgress (535/1000)
/-- Original BHP Theorem 1's interval and coefficient, not the older gap proxy. -/
def BakerHarmanPintz2001 : Prop := BackwardProgress (525/1000)

/-- The square-root/log consequence, with an explicit real threshold. -/
def RHGapProgress : Prop :=
  ∃ C > 0, ∃ X : ℝ, 2 ≤ X ∧ ∀ x : ℝ, X ≤ x →
    ∃ p : ℕ, Nat.Prime p ∧ x < p ∧ (p : ℝ) ≤ x+C*Real.sqrt x*Real.log x

/-- RH is part of the historical conditional result, not silently assumed. -/
def Cramer1920Progress : Prop := RiemannHypothesis → RHGapProgress

/-- Cramér 1920, Theorem I as quoted in Starichkova Thm 2.2: RH is explicit. -/
def Cramer1920 : Prop :=
  RiemannHypothesis → ∃ c > 0, ∀ x : ℝ, 2 ≤ x →
    Real.sqrt x < PNT.primeCount (x+c*Real.sqrt x*Real.log x)-PNT.primeCount x

/-- The gap conjecture attributed to Cramér, not a proved theorem of the 1936 paper. -/
def Cramer1936Conjecture : Prop :=
  ∃ C > 0, ∃ P : ℕ, ∀ p : ℕ, P ≤ p → Nat.Prime p →
    ∃ q : ℕ, Nat.Prime q ∧ p < q ∧ (q-p : ℝ) ≤ C*(Real.log p)^2

/-- The computational conclusion, not an imported computational certificate. -/
def FiniteLegendre (B : ℕ) : Prop :=
  ∀ n : ℕ, 1 ≤ n → n ≤ B →
    ∃ p : ℕ, Nat.Prime p ∧ n^2 < p ∧ p < (n+1)^2

/-- Oppermann begins at n=2: its first lower half interval is empty at n=1. -/
def FiniteOppermann (B : ℕ) : Prop :=
  ∀ n : ℕ, 2 ≤ n → n ≤ B →
    (∃ p : ℕ, Nat.Prime p ∧ n^2 < p ∧ p < n*(n+1)) ∧
    (∃ q : ℕ, Nat.Prime q ∧ n*(n+1) < q ∧ q < (n+1)^2)

def SorensonWebster2025 : Prop := FiniteOppermann 70500000000000

/-- Omega counts factors with multiplicity; positivity follows from the open interval. -/
def Chen1975Progress : Prop :=
  ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
    ∃ m : ℕ, n^2 < m ∧ m < (n+1)^2 ∧ Ω m ≤ 2

/-- Dudek--Johnston, Theorem 1.2: all positive square indices. -/
def DudekJohnston2026 : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∃ m : ℕ, n^2 < m ∧ m < (n+1)^2 ∧ Ω m ≤ 4

/-- Additive epsilon in the height exponent, uniformly in the real-part cutoff. -/
def DensityPower (f : ℝ → ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C > 0, ∀ σ : ℝ, σ ∈ Icc (1/2) 1 →
    ∀ T : ℝ, 2 ≤ T → (Zeta.zeroDensityCount σ T : ℝ) ≤ C*T^(f σ+ε)

/-- The 1940 density estimate is distinct from Ingham's 1937 prime-gap paper. -/
def Ingham1940Density : Prop := DensityPower (fun σ => 3*(1-σ)/(2-σ))
/-- The classical global 12/5 exponent, independently of the stronger curved target. -/
def HuxleyGlobalDensity : Prop := DensityPower (fun σ => (12/5)*(1-σ))
/-- Curved Huxley comparison target; combine with Ingham for a global exponent. -/
def Huxley1972Density : Prop := DensityPower (fun σ => 3*(1-σ)/(3*σ-1))
/-- Independently stated restricted curved target; this is weaker than Huxley1972Density. -/
def Huxley1972RestrictedDensity : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C > 0, ∀ σ : ℝ, σ ∈ Icc (1/2) (5/6) →
    ∀ T : ℝ, 2 ≤ T → (Zeta.zeroDensityCount σ T : ℝ) ≤ C*T^(3*(1-σ)/(3*σ-1)+ε)
/-- Actual unweighted short-sum cancellation with the finite length restriction retained. -/
def WeylShortSumBenchmark : Prop :=
  ∃ C > 0, ∀ U V : ℕ, 1 ≤ U → U ≤ V → V ≤ 2*U →
    ∀ t : ℝ, 1 ≤ |t| → (U : ℝ)^2 ≤ 4*|t| →
      ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*Complex.I)‖ ≤
        C*Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)
/-- Real-part weighted short sums, uniform for every beta>=0. -/
def WeightedWeylBenchmark : Prop :=
  ∃ C > 0, ∀ U V : ℕ, 1 ≤ U → U ≤ V → V ≤ 2*U →
    ∀ β t : ℝ, 0 ≤ β → 1 ≤ |t| → (U : ℝ)^2 ≤ 4*|t| →
      ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*Complex.I))‖ ≤
        C*(U : ℝ)^(1/2-β)*|t|^(1/6 : ℝ)

/-- Every dyadic length is allowed when all three differencing terms are retained. -/
def GeneralWeylBenchmark : Prop :=
  ∃ C > 0, ∀ U V : ℕ, 1 ≤ U → U ≤ V → V ≤ 2*U →
    ∀ t : ℝ, 1 ≤ |t| →
      ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*Complex.I)‖ ≤
        C*(Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)+(U : ℝ)*((U : ℝ)/|t|)^(1/4 : ℝ)+
          (U : ℝ)/|t|^(1/3 : ℝ))

/-- Pointwise cancellation of the actual Mobius and compact-weight detector coefficients. -/
def ActualMobiusPointwiseBenchmark : Prop :=
  ∃ C > 0, ∀ X U V : ℕ, 1 ≤ U → X ≤ U → U ≤ V → V ≤ 2*U →
    ∀ β t Y : ℝ, 0 ≤ β → β ≤ 1 → 1 ≤ |t| → 0 < Y →
      (‖∑ n ∈ Finset.Ioc U V, Density.Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β : ℂ)+(t : ℂ)*Complex.I))‖ ≤
        C*(X : ℝ)*(U : ℝ)^(-β)*(1+Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)+
          (U : ℝ)*((U : ℝ)/|t|)^(1/4 : ℝ)+(U : ℝ)/|t|^(1/3 : ℝ))) ∧
      (‖∑ n ∈ Finset.Ioc U V, Density.Detector.Smooth.polynomialCoefficient X Y n*
        (n : ℂ)^(-((β : ℂ)+(t : ℂ)*Complex.I))‖ ≤
        C*(X : ℝ)*(U : ℝ)^(-β)*(1+Real.sqrt |t|+(U : ℝ)/Real.sqrt |t|))

/-- The proved upper-range Type I branch at Y=T, with all uniformity explicit. -/
def UpperHuxleyTypeIBenchmark : Prop :=
  ∀ η δ ε : ℝ, 0 < η → 0 < δ → δ ≤ η/16 → 0 < ε →
    ∃ C > 0, ∀ T σ : ℝ, 128 ≤ T → 5/6+η ≤ σ → σ ≤ 1 →
      ∀ X : ℕ, T^δ ≤ (X : ℝ) → (X : ℝ) ≤ 2*T^δ →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Density.Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*Complex.I) T‖) →
      (S.card : ℝ) ≤ C*T^(3*(1-σ)/(3*σ-1)+ε)

/-- Guth--Maynard Theorem 1.2, retaining the curved exponent. -/
def GuthMaynard2024Density : Prop := DensityPower (fun σ => 15*(1-σ)/(3+5*σ))

/-- The already proved outer real parts of the Guth--Maynard density target. -/
def GuthMaynard2024OuterDensity : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C > 0, ∀ σ ∈ Icc (1/2 : ℝ) 1,
    (σ ≤ 7/10 ∨ 4/5 ≤ σ) → ∀ T : ℝ, 2 ≤ T →
    (Zeta.zeroDensityCount σ T : ℝ) ≤ C*T^(15*(1-σ)/(3+5*σ)+ε)

/-- The remaining open Guth--Maynard input, strictly between the proved endpoints. -/
def GuthMaynard2024CentralDensity : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C > 0, ∀ σ ∈ Ioo (7/10 : ℝ) (4/5),
    ∀ T : ℝ, 2 ≤ T →
    (Zeta.zeroDensityCount σ T : ℝ) ≤ C*T^(15*(1-σ)/(3+5*σ)+ε)

/-- Actual finite sampling counts are controlled by centered cubic Gram traces. -/
def GuthMaynardSamplingTraceBenchmark : Prop :=
  ∀ (cutoff : Density.GuthMaynard.GMSmoothCutoff) (N : ℕ) (W : Finset ℝ),
    W.Nonempty → ∀ (b : ℕ → ℂ) (V : ℝ), 0 ≤ V →
    (∀ t ∈ W, V ≤ ‖∑ n ∈ Finset.Ioc N (2*N),
      (cutoff ((n : ℝ)/N) : ℂ)*b n*(n : ℂ)^((t : ℂ)*Complex.I)‖) →
    (W.card : ℝ)^3*V^6 ≤ (∑ n ∈ Finset.Ioc N (2*N), ‖b n‖^2)^3*
      (4*((Matrix.trace ((Density.GuthMaynard.gmMatrix cutoff N W*
          (Density.GuthMaynard.gmMatrix cutoff N W).conjTranspose)^3)).re-
        (Matrix.trace (Density.GuthMaynard.gmMatrix cutoff N W*
          (Density.GuthMaynard.gmMatrix cutoff N W).conjTranspose)).re^3/(W.card : ℝ)^2)+
        8*(N : ℝ)^3)

/-- Guth--Maynard Lemma 4.4 with literal real cutoff mass and uniform constants.
The polynomial cardinality bound is explicit, rather than hidden in O-notation. -/
def GuthMaynardFirstTraceBenchmark : Prop :=
  ∀ (cutoff : Density.GuthMaynard.GMSmoothCutoff) (A J : ℕ), 1 ≤ J →
    ∃ K : ℝ, 0 < K ∧ ∀ (N : ℕ) (W : Finset ℝ), 0 < N →
      (W.card : ℝ) ≤ (N : ℝ)^A →
      ‖Matrix.trace (Density.GuthMaynard.gmMatrix cutoff N W*
          (Density.GuthMaynard.gmMatrix cutoff N W).conjTranspose)-
        (N : ℂ)*(W.card : ℂ)*(((∫ x : ℝ, cutoff x^2) : ℝ) : ℂ)‖ ≤
        K/(N : ℝ)^J

/-- Uniform Fourier decay retains the full dependence on the Mellin ordinate. -/
def GuthMaynardUniformFourierBenchmark : Prop :=
  ∀ (cutoff : Density.GuthMaynard.GMSmoothCutoff) (q : ℕ),
    ∃ C : ℝ, 0 ≤ C ∧ ∀ t ξ : ℝ,
      |ξ|^q*‖Density.GuthMaynard.gmTraceFourier cutoff t ξ‖ ≤ C*(1+|t|)^q

/-- The actual cubic trace has only its two- and three-tail pieces left,
with a literal cutoff-integral main term and the source scale/separation window. -/
def GuthMaynardCubicRemainderBenchmark : Prop :=
  ∀ (cutoff : Density.GuthMaynard.GMSmoothCutoff) (ε : ℝ), 0 < ε →
    ∃ K : ℝ, 0 < K ∧ ∀ (N : ℕ) (W : Finset ℝ) (T : ℝ),
      0 < N → 1 ≤ T → (N : ℝ) ≤ T → T ≤ (N : ℝ)^2 →
      (∀ x ∈ W, ∀ y ∈ W, x ≠ y → T^ε ≤ dist x y) →
      (∀ x ∈ W, x ∈ Set.Icc 0 T) →
      ‖Matrix.trace ((Density.GuthMaynard.gmMatrix cutoff N W*
          (Density.GuthMaynard.gmMatrix cutoff N W).conjTranspose)^3)-
        (N : ℂ)^3*(W.card : ℂ)*((((∫ x : ℝ, cutoff x^2) : ℝ) : ℂ))^3-
          Density.GuthMaynard.gmCubicS2 cutoff N W-
            Density.GuthMaynard.gmCubicS3 cutoff N W‖ ≤ K/T^10

/-- Complete-frequency smooth reflection for the actual scaled cubic-trace tail.
The finite polynomial, smoothing reserve, ceiling length and quantifiers are literal. -/
def GuthMaynardCompleteReflectionBenchmark : Prop :=
  ∀ (cutoff : Density.GuthMaynard.GMSmoothCutoff) (A ε : ℝ), 0 < A → 0 < ε →
    ∃ C T_min : ℝ, 0 < C ∧ 1 ≤ T_min ∧
      ∀ (T T₀ t : ℝ) (N : ℕ),
        T_min ≤ T → 0 < N → (N : ℝ) ≤ T →
        T^ε ≤ T₀ → T₀ ≤ |t| → |t| ≤ 2*T₀ → |t| ≤ T →
        ‖Density.GuthMaynard.gmTraceNonzeroTailAt cutoff N t‖ ≤
          (N : ℝ)*C/Real.sqrt T₀*
            (∫ u in -(T^(min (ε/16) (1/16)))..(T^(min (ε/16) (1/16))),
              ‖∑ m ∈ Finset.Icc 1 (Nat.ceil (((1+|t|)*T^(min (ε/16) (1/16)))/(N : ℝ))),
                (m : ℂ)^(-(((t+u : ℝ) : ℂ)*Complex.I))‖)+C/T^A

/-- Only the literal ordered difference moment and the three-tail term remain
in the cubic trace; the finite-set moment is independent of its implementation name. -/
def GuthMaynardCubicMomentBenchmark : Prop :=
  ∀ (cutoff : Density.GuthMaynard.GMSmoothCutoff) (ε : ℝ), 0 < ε →
    ∃ K : ℝ, 0 < K ∧ ∀ (N : ℕ) (W : Finset ℝ) (T : ℝ),
      0 < N → 1 ≤ T → (N : ℝ) ≤ T → T ≤ (N : ℝ)^2 →
      (∀ x ∈ W, ∀ y ∈ W, x ≠ y → T^ε ≤ dist x y) →
      (∀ x ∈ W, x ∈ Set.Icc 0 T) →
      ‖Matrix.trace ((Density.GuthMaynard.gmMatrix cutoff N W*
          (Density.GuthMaynard.gmMatrix cutoff N W).conjTranspose)^3)-
        (N : ℂ)^3*(W.card : ℂ)*((((∫ x : ℝ, cutoff x^2) : ℝ) : ℂ))^3-
          3*(N : ℂ)*(((∫ x : ℝ, cutoff x^2) : ℝ) : ℂ)*
            (((∑ t ∈ W, ∑ u ∈ W,
              ‖Density.GuthMaynard.gmTraceNonzeroTailAt cutoff N (t-u)‖^2) : ℝ) : ℂ)-
                Density.GuthMaynard.gmCubicS3 cutoff N W‖ ≤ K/T^10

/-- Heath--Brown's actual ordered difference-set mean square, with arbitrary
unit-bounded coefficients and one epsilon-dependent constant/threshold. -/
def HeathBrownDifferenceMeanSquareBenchmark : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C T₀ : ℝ, 0 < C ∧ 1 ≤ T₀ ∧
    ∀ (N : ℕ) (T : ℝ) (W : Finset ℝ) (a : ℕ → ℂ),
      0 < N → T₀ ≤ T →
      (∀ x ∈ W, ∀ y ∈ W, x ≠ y → 1 ≤ dist x y) →
      (∀ x ∈ W, x ∈ Set.Icc 0 T) →
      (∀ n ∈ Finset.Ioc N (2*N), ‖a n‖ ≤ 1) →
      (∑ t ∈ W, ∑ u ∈ W,
        ‖∑ n ∈ Finset.Ioc N (2*N), a n*(n : ℂ)^(((t-u : ℝ) : ℂ)*Complex.I)‖^2) ≤
          C*T^ε*((W.card : ℝ)^2*(N : ℝ)+(W.card : ℝ)*(N : ℝ)^2+
            (W.card : ℝ)^(5/4 : ℝ)*T^(1/2 : ℝ)*(N : ℝ))

/-- Literal complete Poisson-tail difference moment, with the source
separation exponent and all three physical powers retained. -/
def GuthMaynardPoissonTailMomentBenchmark : Prop :=
  ∀ (cutoff : Density.GuthMaynard.GMSmoothCutoff) (k : ℕ), 0 < k →
    ∀ ε : ℝ, 0 < ε → ∃ C T₀ : ℝ, 0 < C ∧ 2 ≤ T₀ ∧
      ∀ (N : ℕ) (T : ℝ) (W : Finset ℝ),
        0 < N → T₀ ≤ T → (N : ℝ) ≤ T → W.Nonempty →
        (∀ x ∈ W, ∀ y ∈ W, x ≠ y → T^ε ≤ dist x y) →
        (∀ x ∈ W, x ∈ Set.Icc 0 T) →
        (∑ t ∈ W, ∑ u ∈ W,
          ‖Density.GuthMaynard.gmTraceNonzeroTailAt cutoff N (t-u)‖^2) ≤
            C*T^ε*((N : ℝ)*(W.card : ℝ)^2+
              T*(W.card : ℝ)^(2-1/(k : ℝ))+
              (N : ℝ)*(W.card : ℝ)^(2-3/(4*(k : ℝ)))*T^(1/(2*(k : ℝ))))

/-- Guth--Maynard Proposition 6.1 for the actual two-tail cubic trace. -/
def GuthMaynardS2Benchmark : Prop :=
  ∀ (cutoff : Density.GuthMaynard.GMSmoothCutoff) (k : ℕ), 0 < k →
    ∀ ε : ℝ, 0 < ε → ∃ C T₀ : ℝ, 0 < C ∧ 2 ≤ T₀ ∧
      ∀ (N : ℕ) (T : ℝ) (W : Finset ℝ),
        0 < N → T₀ ≤ T → (N : ℝ) ≤ T →
        (∀ x ∈ W, ∀ y ∈ W, x ≠ y → T^ε ≤ dist x y) →
        (∀ x ∈ W, x ∈ Set.Icc 0 T) →
        ‖Density.GuthMaynard.gmCubicS2 cutoff N W‖ ≤
          C*T^ε*((N : ℝ)^2*(W.card : ℝ)^2+
            T*(N : ℝ)*(W.card : ℝ)^(2-1/(k : ℝ))+
            (N : ℝ)^2*(W.card : ℝ)^(2-3/(4*(k : ℝ)))*T^(1/(2*(k : ℝ))))

/-- Proposition 8.1 with literal closed-tolerance energy; the paper's strict
energy convention remains separately documented. -/
def GuthMaynardS3EnergyBenchmark : Prop :=
  ∀ cutoff : Density.GuthMaynard.GMSmoothCutoff,
    ∀ ε : ℝ, 0 < ε → ∃ C T₀ : ℝ, 0 < C ∧ 1 ≤ T₀ ∧
      ∀ (N : ℕ) (T : ℝ) (W : Finset ℝ),
        T₀ ≤ T → 0 < N → (N : ℝ) ≤ T → T^(2/3 : ℝ) ≤ (N : ℝ) →
        (∀ x ∈ W, ∀ y ∈ W, x ≠ y → 1 ≤ dist x y) →
        (∀ x ∈ W, x ∈ Set.Icc 0 T) →
        ‖Density.GuthMaynard.gmCubicS3 cutoff N W‖ ≤
          C*T^(2+ε)*Real.sqrt (W.card : ℝ)*
            Real.sqrt (((((W ×ˢ W) ×ˢ (W ×ˢ W)).filter fun q =>
              |q.1.1+q.1.2-q.2.1-q.2.2| ≤ 1).card : ℝ))+C/T^90

/-- The paper's strict-tolerance Proposition 8.1 energy form, up to constants. -/
def GuthMaynardStrictS3EnergyBenchmark : Prop :=
  ∀ cutoff : Density.GuthMaynard.GMSmoothCutoff,
    ∀ ε : ℝ, 0 < ε → ∃ C T₀ : ℝ, 0 < C ∧ 1 ≤ T₀ ∧
      ∀ (N : ℕ) (T : ℝ) (W : Finset ℝ),
        T₀ ≤ T → 0 < N → (N : ℝ) ≤ T → T^(2/3 : ℝ) ≤ (N : ℝ) →
        (∀ x ∈ W, ∀ y ∈ W, x ≠ y → 1 ≤ dist x y) →
        (∀ x ∈ W, x ∈ Set.Icc 0 T) →
        ‖Density.GuthMaynard.gmCubicS3 cutoff N W‖ ≤
          C*T^(2+ε)*Real.sqrt (W.card : ℝ)*
            Real.sqrt (((((W ×ˢ W) ×ˢ (W ×ˢ W)).filter fun q =>
              |q.1.1+q.1.2-q.2.1-q.2.2| < 1).card : ℝ))+C/T^90

/-- The completed Layer 3 classical PNT benchmark, with existential constants. -/
def ClassicalPNTError : Prop :=
  ∃ c > 0, ∃ C > 0, ∃ X : ℝ, ∀ x ≥ X,
    |Chebyshev.psi x-x| ≤ C*(x*Real.exp (-c*Real.sqrt (Real.log x))) ∧
    |PNT.primeCount x-PNT.logarithmicIntegral x| ≤ C*(x*Real.exp (-c*Real.sqrt (Real.log x)))

/-- The sharp logarithmic fourth-moment target; the sixth-log proof is weaker. -/
def ZetaFourthMoment : Prop :=
  ∃ C > 0, ∀ T : ℝ, 2 ≤ T →
    (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ≤
      C*T*(Real.log T)^4

/-- Proved fourth moment with a sixth logarithmic power. -/
def ZetaFourthMomentLogSix : Prop :=
  ∃ C > 0, ∀ T : ℝ, 2 ≤ T →
    (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ≤
      C*T*(Real.log T)^6

/-- Height exponent benchmark, allowing every positive epsilon loss. -/
def ZetaFourthMomentExponent : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C > 0, ∀ T : ℝ, 2 ≤ T →
    (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ≤ C*T^(1+ε)

end Legendre.Literature
