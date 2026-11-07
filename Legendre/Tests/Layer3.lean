/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

import Legendre.Layer3

/-!
# Independent consumer checks for the Layer 3 public interface

Only the normal Layer3 import is available here. These checks exercise
real/natural endpoints, a concrete relative interval, a power close to one,
the common decay constant and the independently re-exported explicit formula.
-/

namespace Legendre.Tests

open Filter Topology Asymptotics Real PNT

/-- A consumer can use the common theta error and prime interval with the same c. -/
theorem common_constant_consumer : ∃ c > 0,
    ((fun x : ℝ => Chebyshev.theta x-x) =O[atTop] classicalError c) ∧
    ∃ X ≥ (1 : ℝ), ∀ x : ℝ, X ≤ x →
      ∃ p : ℕ, p.Prime ∧ x < (p : ℝ) ∧ (p : ℝ) ≤ x+classicalError c x := by
  obtain ⟨c,hc,_hψ,hθ,_hπ,_hsub,_hpower,X,hX1,hX⟩ := layer3_pnt_package
  exact ⟨c,hc,hθ,X,hX1,fun x hx => hX x hx⟩

/-- The relative-interval API gives a prime below 1.01x, with strict lower endpoint. -/
theorem one_percent_interval_consumer : ∀ᶠ x : ℝ in atTop,
    ∃ p : ℕ, p.Prime ∧ x < (p : ℝ) ∧ (p : ℝ) ≤ (101/100)*x := by
  filter_upwards [eventually_hasPrimeIn_relative (by norm_num : (0 : ℝ) < 1/100)] with x hx
  obtain ⟨p,hp,hxp,hpx⟩ := hx
  refine ⟨p,hp,hxp,?_⟩
  linarith

/-- Natural-number ordering and real upper bounds can be consumed together. -/
theorem natural_gap_consumer : ∃ c > 0, ∃ P : ℕ, ∀ p : ℕ, P ≤ p → p.Prime →
    ∃ q : ℕ, q.Prime ∧ p < q ∧ (q : ℝ) ≤ (p : ℝ)+classicalError c p := by
  obtain ⟨c,hc,P,hP⟩ := pnt_prime_gap_classical
  refine ⟨c,hc,P,fun p hp hprime => ?_⟩
  obtain ⟨q,hq,hpq,hbound⟩ := hP p hp hprime
  exact ⟨q,hq,hpq,by linarith⟩

/-- A power arbitrarily near one is still smaller than the sublinear error scale. -/
theorem near_one_power_consumer {c : ℝ} (hc : 0 < c) :
    classicalError c =o[atTop] (fun x : ℝ => x) ∧
    (fun x : ℝ => x^((9999 : ℝ)/10000)) =o[atTop] classicalError c ∧
    ¬classicalError c =O[atTop] (fun x : ℝ => x^((9999 : ℝ)/10000)) := by
  exact ⟨classicalError_isLittleO hc,rpow_isLittleO_classicalError c (by norm_num),
    classicalError_not_isBigO_rpow c (by norm_num)⟩

/-- The same import exposes the finite explicit formula, independently of the PNT package. -/
theorem finite_explicit_formula_consumer {H : ℝ} (hH : 0 ≤ H) :
    ∃ T ∈ Set.Ioo H (H+1), ∀ x : ℝ, 0 < x → ∃ E : ℂ,
      Zeta.halfWeightedPsi x = (x : ℂ)-Zeta.truncatedZeroSum x T+E := by
  obtain ⟨T,hT,a,_ha,M,_hM,hformula⟩ :=
    Zeta.exists_truncated_explicit_formula (σ := 2) hH (by norm_num)
  refine ⟨T,hT,fun x hx => ?_⟩
  obtain ⟨E,hE,_hbound⟩ := hformula x hx
  exact ⟨E,hE⟩

/-- One absolute coefficient and one selected height work simultaneously at x=1 and x=1/2. -/
theorem full_formula_shared_height_consumer : ∃ C > 0, ∀ H : ℝ, 7 ≤ H →
    ∃ T ∈ Set.Ioo H (H+1),
      (∃ E : ℂ, Zeta.halfWeightedPsi 1 = 1-Zeta.truncatedZeroSum 1 T-Complex.log (2*(Real.pi : ℂ))+E ∧
        ‖E‖ ≤ Zeta.perronErrorUpper 1 2/T+C*(Real.log (H+6))^2*(1+(2+1/8)/T)) ∧
      (∃ E : ℂ, Zeta.halfWeightedPsi (1/2) = (1/2 : ℂ)-Zeta.truncatedZeroSum (1/2) T-
          Complex.log (2*(Real.pi : ℂ))+E ∧
        ‖E‖ ≤ Zeta.perronErrorUpper (1/2) 2/T+C*(Real.log (H+6))^2*
          ((1/2 : ℝ)^(-(1/8 : ℝ))+(2+1/8)*max ((1/2 : ℝ)^(-(1/8 : ℝ))) ((1/2 : ℝ)^2)/T)) := by
  obtain ⟨C,hC,hfull⟩ := Zeta.exists_full_truncated_explicit_formula
  refine ⟨C,hC,fun H hH => ?_⟩
  obtain ⟨T,hT,hTformula⟩ := hfull H hH
  refine ⟨T,hT,?_,?_⟩
  · simpa only [Complex.ofReal_one,Real.one_rpow,max_self,mul_one] using
      hTformula 2 (by norm_num) 1 (by norm_num)
  · simpa only [Complex.ofReal_div,Complex.ofReal_one,Complex.ofReal_ofNat,Real.rpow_two] using
      hTformula 2 (by norm_num) (1/2) (by norm_num)

/-- Crossing zero contributes the evaluated constant independently of the Perron weight. -/
theorem evaluated_origin_residue_consumer {x : ℝ} (hx : 0 < x) :
    residue (Zeta.perronIntegrand x) 0 = -Complex.log (2*(Real.pi : ℂ)) := by
  rw [Zeta.residue_perronIntegrand_origin hx,Zeta.logDeriv_riemannZeta_origin]

/-- The complete fixed negative line is integrable also for x below one. -/
theorem small_x_left_integrability_consumer (T : ℝ) :
    IntervalIntegrable
      (fun t : ℝ => Zeta.perronIntegrand (1/2) ((-(1/8) : ℂ)+(t : ℂ)*Complex.I))
      MeasureTheory.volume (-T) T := by
  exact (Zeta.continuous_perronIntegrand_left (by norm_num : (0 : ℝ) < 1/2)).intervalIntegrable (-T) T

/-- Both selected horizontal lines include the fixed negative endpoint. -/
theorem full_negative_horizontal_consumer : ∃ T ∈ Set.Ioo (7 : ℝ) 8,
    ∀ t : ℝ, (t = T ∨ t = -T) →
      riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*Complex.I) ≠ 0 ∧
      ‖logDeriv riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*Complex.I)‖ ≤
        Zeta.fullGoodHeightLogDerivativeConstant*(Real.log 7)^2 := by
  obtain ⟨T,hT,hbound⟩ := Zeta.exists_full_good_height_logDeriv_bound (by norm_num : (7 : ℝ) ≤ 7)
  refine ⟨T,by convert! hT using 1; norm_num,fun t ht => ?_⟩
  simpa only [Complex.ofReal_neg,Complex.ofReal_div,Complex.ofReal_one,Complex.ofReal_ofNat] using!
    hbound t ht (-(1/8)) le_rfl

end Legendre.Tests
