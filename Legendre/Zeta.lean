/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.NumberTheory.EulerProduct.DirichletLSeries
public import Mathlib.NumberTheory.LSeries.ZetaZeros
public import Mathlib.Topology.MetricSpace.Thickening
public import Mathlib.Analysis.PSeriesComplex

/-!
# Layer 2: zeta foundations and a qualitative zero-free strip

Reuses mathlib v4.35.0, commit 56a005855ea17e0b0958f73ec801ae140b0a1679
(Apache-2.0): EulerProduct/DirichletLSeries (Michael Stoll),
LSeries/RiemannZeta (David Loeffler), LSeries/Nonvanishing (Michael Stoll,
David Loeffler), and LSeries/ZetaZeros (Huanyu Zheng). The namespace wrappers
below preserve the upstream hypotheses and conventions; they are not new
proofs of these classical results. The compact-height strip deduction is new
here, using the upstream closed zero set and nonvanishing theorem.

The value of mathlib's total function at the pole 1 is a nonzero junk value,
not a holomorphic extension through the pole. No quantitative zero-free
region, zero-counting asymptotic, Perron formula, or PNT is claimed.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology

/-- Absolute convergence of the defining series in the open right half-plane. -/
theorem series_norm_summable {s : ℂ} (hs : 1 < s.re) :
    Summable (fun n : ℕ ↦ ‖1 / (n : ℂ) ^ s‖) := by
  exact (Complex.summable_one_div_nat_cpow.mpr hs).norm

/-- The continuation agrees with the convergent Dirichlet series. -/
theorem eq_series {s : ℂ} (hs : 1 < s.re) :
    riemannZeta s = ∑' n : ℕ, 1 / (n + 1 : ℂ) ^ s :=
  zeta_eq_tsum_one_div_nat_add_one_cpow hs

/-- Euler product, including the convergence assertion. -/
theorem euler_product {s : ℂ} (hs : 1 < s.re) :
    HasProd (fun p : Nat.Primes ↦ (1 - (p : ℂ) ^ (-s))⁻¹) (riemannZeta s) :=
  riemannZeta_eulerProduct_hasProd hs

/-- Convergence of Euler products over primes below a natural cutoff. -/
theorem euler_product_limit {s : ℂ} (hs : 1 < s.re) :
    Tendsto (fun n : ℕ ↦ ∏ p ∈ Nat.primesBelow n, (1 - (p : ℂ) ^ (-s))⁻¹)
      atTop (𝓝 (riemannZeta s)) :=
  riemannZeta_eulerProduct hs

/-- Analytic continuation away from the pole. -/
theorem analytic_off_pole : AnalyticOnNhd ℂ riemannZeta ({1}ᶜ : Set ℂ) :=
  analyticOn_riemannZeta

/-- Symmetry of the completed zeta function, in mathlib's convention. -/
theorem completed_functional_equation (s : ℂ) :
    completedRiemannZeta (1 - s) = completedRiemannZeta s :=
  completedRiemannZeta_one_sub s

/-- Nonvanishing on and to the right of Re(s)=1, excluding the pole. -/
theorem nonvanishing {s : ℂ} (hs : 1 ≤ s.re) (_hpole : s ≠ 1) :
    riemannZeta s ≠ 0 :=
  riemannZeta_ne_zero_of_one_le_re hs

/-- Only finitely many distinct zeros lie in any compact subset of the plane.
This statement does not count multiplicities. -/
theorem finite_zeros_on_compact {K : Set ℂ} (hK : IsCompact K) :
    (K ∩ riemannZetaZeros).Finite :=
  hK.inter_riemannZetaZeros_finite

/-- At each fixed height a uniform positive-width band about Re(s)=1 is
zero-free. The width is non-effective and may depend on T; this is not a
classical logarithmic zero-free region. At the pole, mathlib's junk value
is nonzero; the corollary below explicitly excludes that point. -/
theorem exists_zero_free_band (T : ℝ) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ s : ℂ,
      |s.re - 1| < δ → |s.im| ≤ T → riemannZeta s ≠ 0 := by
  let K : Set ℂ := ({1} : Set ℝ) ×ℂ Set.Icc (-T) T
  have hK : IsCompact K := isCompact_singleton.reProdIm isCompact_Icc
  have hsub : K ⊆ riemannZetaZerosᶜ := by
    intro s hs
    have hre : s.re = 1 := hs.1
    exact fun hz ↦ riemannZeta_ne_zero_of_one_le_re (by simp [hre]) hz
  obtain ⟨δ, hδ, hband⟩ := hK.exists_thickening_subset_open
    isClosed_riemannZetaZeros.isOpen_compl hsub
  refine ⟨δ, hδ, ?_⟩
  intro s hre him
  apply hband
  apply Metric.mem_thickening_iff.mpr
  refine ⟨1 + (s.im : ℂ) * I, ?_, ?_⟩
  · change (1 + (s.im : ℂ) * I).re ∈ ({1} : Set ℝ) ∧
      (1 + (s.im : ℂ) * I).im ∈ Set.Icc (-T) T
    simpa using (show (1 : ℝ) = 1 ∧ -T ≤ s.im ∧ s.im ≤ T from
      ⟨rfl, (abs_le.mp him).1, (abs_le.mp him).2⟩)
  · have heq : s - (1 + (s.im : ℂ) * I) = ((s.re - 1 : ℝ) : ℂ) := by
      apply Complex.ext <;> simp
    rw [dist_eq_norm, heq, Complex.norm_real, Real.norm_eq_abs]
    exact hre

/-- Usable left-hand zero-free strip, with the pole explicitly removed. -/
theorem exists_zero_free_strip (T : ℝ) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ s : ℂ,
      1 - δ < s.re → |s.im| ≤ T → s ≠ 1 → riemannZeta s ≠ 0 := by
  obtain ⟨δ, hδ, hband⟩ := exists_zero_free_band T
  refine ⟨δ, hδ, ?_⟩
  intro s hre him hpole
  by_cases hs : 1 ≤ s.re
  · exact nonvanishing hs hpole
  · apply hband s _ him
    rw [abs_lt]
    constructor <;> linarith

end Legendre.Zeta
