/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.PolynomialAlternativeSplit
public import Legendre.Layer4.InghamMultiplicity
public import Legendre.ZetaGlobalCounting

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem separated_high_shell_density_split (τ : ℝ) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ τ →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*(T^balancedDensityExponent σ*(Real.log T)^4+
        T^(2-2*σ)*(Real.log T)^5) := by
  obtain ⟨CP,hCP,hpoly⟩ := polynomial_alternative_balanced_split τ hτ
  obtain ⟨CI,hCI,hgapBound⟩ := separated_high_shell_density_of_branches τ hτ.le
    (fun T σ => CP*(T^balancedDensityExponent σ*(Real.log T)^3+T^(2-2*σ)*(Real.log T)^5))
    hpoly
  let D := 3*Real.exp 4*(Real.log 2)⁻¹^4
  let A := CP*((Real.log 2)⁻¹+1)+CI+D
  have hD : 0 < D := by dsimp [D]; positivity
  have hA : 0 < A := by dsimp [A]; positivity
  refine ⟨A,hA,?_⟩
  intro T σ hT hσ hστ ι S t β ht hs hz
  have hT₀ : 2 ≤ T := by linarith
  have hσ1 : σ ≤ 1 := hστ.trans hτ.le
  have hL : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have hunit := log_nat_pow_unit 1 T hT₀
  simp only [pow_one] at hunit
  have hlog : (Real.log T)^3 ≤ (Real.log 2)⁻¹*(Real.log T)^4 := by
    have h := mul_le_mul_of_nonneg_right hunit (show 0 ≤ (Real.log T)^3 by positivity)
    nlinarith
  let U := T^balancedDensityExponent σ*(Real.log T)^4
  let V := T^(2-2*σ)*(Real.log T)^5
  have hU : 0 ≤ U := by dsimp [U]; positivity
  have hV : 0 ≤ V := by dsimp [V]; positivity
  by_cases hgap : 1/Real.log T ≤ σ-1/2
  · have hg := hgapBound T σ hT (by
        have := one_div_pos.mpr (Real.log_pos (show 1 < T by linarith))
        linarith) hστ hgap S t β ht hs hz
    calc
      _ ≤ CP*(T^balancedDensityExponent σ*(Real.log T)^3+V)+CI*U := by simpa only [U,V,mul_assoc] using hg
      _ ≤ CP*((Real.log 2)⁻¹*U+V)+CI*U := by
        apply add_le_add _ le_rfl
        apply mul_le_mul_of_nonneg_left _ hCP.le
        apply add_le_add _ le_rfl
        have h := mul_le_mul_of_nonneg_left hlog (show 0 ≤ T^balancedDensityExponent σ by positivity)
        simpa only [U,mul_left_comm] using h
      _ ≤ A*(U+V) := by
        have h₀ : 0 ≤ (CP+ D)*U := mul_nonneg (by positivity) hU
        have h₁ : 0 ≤ (CP*(Real.log 2)⁻¹+CI+D)*V := mul_nonneg (by positivity) hV
        dsimp only [A]
        nlinarith
  · have h := near_critical_separated_count_log 4 S t T σ hT₀ hσ hσ1
      (le_of_lt (lt_of_not_ge hgap)) (fun i hi => (ht i hi).2) hs
    have h' : (S.card : ℝ) ≤ D*U := by simpa only [D,U,mul_assoc] using h
    exact h'.trans (mul_le_mul (by dsimp [A]; exact le_add_of_nonneg_left (by positivity)) (le_add_of_nonneg_right hV) hU hA.le)

theorem separated_high_density_split (τ : ℝ) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ τ →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*(T^balancedDensityExponent σ*(Real.log T)^4+
        T^(2-2*σ)*(Real.log T)^5) := by
  obtain ⟨C,hC,hc⟩ := separated_high_shell_density_split τ hτ
  let η := 2*(1-τ)
  let A := 256/((2 : ℝ)^η-1)
  have hη : 0 < η := by dsimp [η]; linarith
  have hA : 0 < A := div_pos (by norm_num) (sub_pos.mpr (Real.one_lt_rpow (by norm_num) hη))
  refine ⟨C*A*8^5,by positivity,?_⟩
  intro T σ hT hσ hστ ι S t β ht hs hz
  let e := balancedDensityExponent σ
  let b := 2-2*σ
  let L := Real.log T
  have hL : 0 ≤ L := Real.log_nonneg (by linarith)
  have hσ1 : σ ≤ 1 := hστ.trans hτ.le
  have hT₀ : 2 ≤ T := by linarith
  have hb : η ≤ b := by dsimp [η,b]; linarith
  have he : η ≤ e := hb.trans (balancedDensityExponent_ge_two_defect σ hσ hσ1)
  obtain ⟨J,hJl,hJu,_⟩ := real_height_dyadic_cover T hT₀
  let H := fun j : ℕ => 128*(2 : ℝ)^j
  let G := fun U : ℝ => C*(U^e*(Real.log U)^4+U^b*(Real.log U)^5)
  have hcount' := separated_high_density_shell_sum_of_count σ G
    (fun U hU {ι} S t β ht hs hz => hc U σ hU hσ hστ S t β ht hs hz)
    S t β T J hJl ht hs hz
  have hGE := height_shell_rpow_geometric J T e η hT₀ hη he
    (balancedDensityExponent_le_one σ hσ hσ1) hJu
  have hGB := height_shell_rpow_geometric J T b η hT₀ hη hb (by dsimp [b]; linarith) hJu
  calc
    _ ≤ ∑ j ∈ Finset.range J, G (H j) := hcount'
    _ ≤ ∑ j ∈ Finset.range J, C*((8*L)^4*(H j)^e+(8*L)^5*(H j)^b) := by
      apply Finset.sum_le_sum
      intro j hj
      have hpow : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
      have hh : 128 ≤ H j := by dsimp [H]; linarith
      have hl := height_shell_log_le (H j) T hh hT₀ (height_shell_upper J j T hj hJu)
      have hLj : 0 ≤ Real.log (H j) := Real.log_nonneg (by linarith)
      have h1 := mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hLj hl 4)
        (show 0 ≤ (H j)^e by positivity)
      have h2 := mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hLj hl 5)
        (show 0 ≤ (H j)^b by positivity)
      simpa only [G,mul_comm ((H j)^e),mul_comm ((H j)^b)] using
        mul_le_mul_of_nonneg_left (add_le_add h1 h2) hC.le
    _ = C*((8*L)^4*(∑ j ∈ Finset.range J, (H j)^e)+(8*L)^5*∑ j ∈ Finset.range J, (H j)^b) := by
      calc
        _ = C*(∑ j ∈ Finset.range J, ((8*L)^4*(H j)^e+(8*L)^5*(H j)^b)) := by
          rw [Finset.mul_sum]
        _ = _ := by rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum]
    _ ≤ C*((8*L)^4*(A*T^e)+(8*L)^5*(A*T^b)) := by
      exact mul_le_mul_of_nonneg_left
        (add_le_add (mul_le_mul_of_nonneg_left hGE (by positivity))
          (mul_le_mul_of_nonneg_left hGB (by positivity))) hC.le
    _ ≤ _ := by
      have hpos : 0 ≤ C*A*T^e*L^4 := by positivity
      change C*((8*L)^4*(A*T^e)+(8*L)^5*(A*T^b)) ≤ C*A*8^5*(T^e*L^4+T^b*L^5)
      nlinarith

theorem lower_strip_absorb_tail_log (T σ : ℝ) (hT : 0 < T) (hL : 1 ≤ Real.log T)
    (hσ : σ ≤ 3/4)
    (hgap : (Real.log T)^4 ≤ T^(1-balancedDensityExponent σ)) :
    T^(2-2*σ)*Real.log T ≤ T^balancedDensityExponent σ := by
  have hL₀ : 0 ≤ Real.log T := by linarith
  have h₁ : Real.log T ≤ ((Real.log T)^4)^(1-σ) := by
    calc
      _ = (Real.log T)^(1 : ℝ) := (Real.rpow_one _).symm
      _ ≤ (Real.log T)^((4 : ℝ)*(1-σ)) := Real.rpow_le_rpow_of_exponent_le hL (by linarith)
      _ = _ := by simpa only [Nat.cast_ofNat] using Real.rpow_natCast_mul hL₀ 4 (1-σ)
  have h₂ := Real.rpow_le_rpow (show 0 ≤ (Real.log T)^4 by positivity) hgap
    (show 0 ≤ 1-σ by linarith)
  rw [← Real.rpow_mul hT.le, mul_comm (1-balancedDensityExponent σ),
    ← balanced_exponent_defect_relation σ (by linarith)] at h₂
  have hb := mul_le_mul_of_nonneg_left (h₁.trans h₂)
    (show 0 ≤ T^(2-2*σ) by positivity)
  rwa [← Real.rpow_add hT, show 2-2*σ+(balancedDensityExponent σ-(2-2*σ)) =
    balancedDensityExponent σ by ring] at hb

end Legendre.Density.Moment

namespace Legendre.Zeta
open Complex Set Density.Moment

/-- The cumulative fifth-log Ingham density bound on every fixed strip
ending below one, with every height T ≥ 2 and analytic multiplicities. -/
theorem ingham_density_log_five_away_one (τ : ℝ) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Set.Icc (1/2 : ℝ) τ, ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^5 := by
  obtain ⟨C,hC,hc⟩ := separated_high_density_split τ hτ
  let ε := (1-τ)/4
  have hε : 0 < ε := by dsimp [ε]; linarith
  obtain ⟨K,hK,hKbound⟩ := exists_log_pow_le_rpow 1 hε
  let B := max 1 K
  have hB : 0 < B := lt_of_lt_of_le zero_lt_one (le_max_left _ _)
  let A := 2*densitySelectionConstant*C
  let D := ((zeroCount 128 : ℝ)+1)*(Real.log 2)⁻¹^5
  have hA : 0 < A := by dsimp [A]; have := densitySelectionConstant_pos; positivity
  have hD : 0 < D := by dsimp [D]; positivity
  have hG := globalZeroCountConstant_pos
  have hAB : 0 ≤ A*(1+B) := by positivity
  refine ⟨D+A*(1+B)+globalZeroCountConstant,by positivity,?_⟩
  intro σ hσ T hT
  let E := balancedDensityExponent σ
  let L := Real.log T
  let M := T^E*L^5
  have hσ1 : σ ≤ 1 := hσ.2.trans hτ.le
  have hT₀ : 0 < T := by linarith
  have hL₀ : 0 ≤ L := Real.log_nonneg (by linarith)
  have hM : 0 ≤ M := by dsimp [M]; positivity
  rw [mul_assoc]
  change _ ≤ (D+A*(1+B)+globalZeroCountConstant)*M
  have hunit := height_log_unit 5 T σ hT hσ1
  have hlow : (zeroCount 128 : ℝ) ≤ D*M := by
    have h := mul_le_mul_of_nonneg_left hunit (show 0 ≤ (zeroCount 128 : ℝ)+1 by positivity)
    dsimp only [D,M,E,L]
    nlinarith
  by_cases hlarge : 128 ≤ T
  · by_cases hcritical : T^(1-E) ≤ L^4
    · have hz := zeroDensityCount_le_mul_log σ (by linarith : 7 ≤ T)
      have hpower : T = T^E*T^(1-E) := by
        rw [← Real.rpow_add hT₀]
        simp
      have hTbound : T*L ≤ M := by
        calc
          _ = T^E*T^(1-E)*L := congrArg (·*L) hpower
          _ ≤ T^E*L^4*L :=
            mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hcritical (by positivity)) hL₀
          _ = _ := by dsimp [M]; ring
      have hh := (by simpa only [L,mul_assoc] using hz :
        (zeroDensityCount σ T : ℝ) ≤ globalZeroCountConstant*(T*L)).trans
        (mul_le_mul_of_nonneg_left hTbound hG.le)
      exact hh.trans (mul_le_mul_of_nonneg_right (by linarith) hM)
    · have hL : 1 ≤ L := by
        have h := Real.log_le_log (by norm_num : (0 : ℝ) < 4) (by linarith : 4 ≤ T)
        rw [show Real.log 4 = 2*Real.log 2 by
          simpa only [show (2 : ℝ)^2 = 4 by norm_num, Nat.cast_ofNat] using
            Real.log_pow (2 : ℝ) 2] at h
        exact (one_le_two_log 2 (by norm_num)).trans h
      have habs : T^(2-2*σ)*L ≤ B*T^E := by
        by_cases hlowσ : σ ≤ 3/4
        · have hs := lower_strip_absorb_tail_log T σ hT₀ hL hlowσ (le_of_lt (lt_of_not_ge hcritical))
          exact hs.trans (le_mul_of_one_le_left (by positivity) (le_max_left _ _))
        · have hdef : (1/4 : ℝ) ≤ 1-E := by
            have hE : E ≤ 3*(1-σ) := by
              dsimp [E]
              unfold balancedDensityExponent
              apply (div_le_iff₀ (by linarith : 0 < 2-σ)).mpr
              nlinarith [mul_nonneg (show 0 ≤ 1-σ by linarith) (show 0 ≤ 1-σ by linarith)]
            linarith
          have hdelta : ε ≤ E-(2-2*σ) := by
            rw [show E-(2-2*σ) = (1-σ)*(1-E) from balanced_exponent_defect_relation σ hσ1]
            have hσle := hσ.2
            have hgap := mul_le_mul (show 1-τ ≤ 1-σ by linarith) hdef (by norm_num)
              (show 0 ≤ 1-σ by linarith)
            dsimp [ε]
            linarith
          have hKlog : L ≤ K*T^ε := by simpa only [L,pow_one] using hKbound T hT
          calc
            _ ≤ T^(2-2*σ)*(K*T^ε) := mul_le_mul_of_nonneg_left hKlog (by positivity)
            _ = K*T^(2-2*σ+ε) := by rw [Real.rpow_add hT₀]; ring
            _ ≤ K*T^E := mul_le_mul_of_nonneg_left
              (Real.rpow_le_rpow_of_exponent_le (by linarith) (by linarith)) hK.le
            _ ≤ _ := mul_le_mul_of_nonneg_right (le_max_right _ _) (by positivity)
      let Q := T^(2-2*σ)*L^5
      have hQ : Q*L ≤ B*M := by
        have h := mul_le_mul_of_nonneg_right habs (show 0 ≤ L^5 by positivity)
        convert h using 1 <;> dsimp only [Q,M,E,L] <;> ring
      have hz := zeroDensityCount_le_of_high_separated_count σ T
        (C*(T^E*L^4+Q)) (by linarith) (by
          intro S ht hsep hs
          apply hc T σ hlarge hσ.1 hσ.2 S Complex.im Complex.re ht hsep
          intro ρ hρ
          have h := hs ρ hρ
          exact ⟨h.1,h.2.1,by simpa only [Complex.re_add_im] using h.2.2⟩)
      have hZ : (zeroCount 64 : ℝ) ≤ D*M :=
        (Nat.cast_le.mpr (zeroCount_mono (show (64 : ℝ) ≤ 128 by norm_num))).trans hlow
      have he : 2*densitySelectionConstant*Real.log T*(C*(T^E*L^4+Q)) =
          A*(M+Q*L) := by dsimp only [A,M,L]; ring
      rw [he] at hz
      have h := (mul_le_mul_of_nonneg_left (add_le_add (le_refl M) hQ) hA.le)
      have hh : A*(M+B*M) = A*(1+B)*M := by ring
      rw [hh] at h
      nlinarith [mul_nonneg hG.le hM]
  · have hz : (zeroDensityCount σ T : ℝ) ≤ zeroCount 128 := by
      exact_mod_cast (zeroDensityCount_le σ T).trans (zeroCount_mono (le_of_not_ge hlarge))
    exact (hz.trans hlow).trans (mul_le_mul_of_nonneg_right (by linarith) hM)

/-- The absolute fifth-log bound on the closed strip through real part 3/4. -/
theorem ingham_density_log_five_up_to_three_quarters :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Set.Icc (1/2 : ℝ) (3/4), ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^5 :=
  ingham_density_log_five_away_one (3/4) (by norm_num)

end Legendre.Zeta
