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
/-- Guth--Maynard Theorem 1.2, retaining the curved exponent. -/
def GuthMaynard2024Density : Prop := DensityPower (fun σ => 15*(1-σ)/(3+5*σ))

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
