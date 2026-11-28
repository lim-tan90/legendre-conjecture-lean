/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.DivisorSquareScale
public import Legendre.Layer4.FourthMoment.CoprimeHarmonic

@[expose] public section
namespace Legendre.Density.Moment
open Filter
open scoped Topology

/-- The harmonic divisor-square sum has leading coefficient 1/(4π²),
with at most three logarithms in the remainder. -/
theorem abs_harmonicDivisorSquare_sub_log_main_le :
    ∃ C : ℝ, 0 < C ∧ ∀ x : ℝ, 1 ≤ x →
      |harmonicDivisorSquare x-(Real.log x)^4/(4*Real.pi^2)| ≤ C*(1+Real.log x)^3 := by
  obtain ⟨B,hB,hBasel⟩ := abs_square_scaled_log_four_sub_basel_le
  let a : ℝ := (4*Real.pi^2)⁻¹
  let C := 4*(4+a*B)
  have ha : 0 < a := by dsimp [a]; positivity
  have hC : 0 < C := by dsimp [C]; positivity
  have hconst : a*(Real.pi^2/6) = 1/24 := by
    dsimp [a]
    field_simp [Real.pi_pos.ne']
    ring
  refine ⟨C,hC,?_⟩
  have haux : ∀ N : ℕ, ∀ x : ℝ, ⌊x⌋₊ = N → 1 ≤ x →
      |harmonicDivisorSquare x-a*(Real.log x)^4| ≤ C*(1+Real.log x)^3 := by
    intro N
    induction N using Nat.strong_induction_on with
    | h N ih =>
      intro x hxN hx
      let M := ⌊√x⌋₊
      let S := Finset.Icc 1 M
      let R := Finset.Icc 2 M
      let L := Real.log x
      let e := fun d : ℕ =>
        (harmonicDivisorSquare (x/(d : ℝ)^2)-a*(Real.log (x/(d : ℝ)^2))^4)/(d : ℝ)^2
      have hx₀ : 0 < x := zero_lt_one.trans_le hx
      have hL : 0 ≤ L := Real.log_nonneg hx
      have hLg : 0 ≤ 1+L := by linarith only [hL]
      have h1M : 1 ≤ M := (Nat.le_floor_iff (Real.sqrt_nonneg _)).2 (by
        simpa only [Nat.cast_one] using (Real.one_le_sqrt.2 hx))
      have hN : 0 < N := by
        rw [← hxN]
        exact (Nat.le_floor_iff hx₀.le).2 (by simpa using hx)
      have heS : S = insert 1 R := by
        ext d
        simp only [S,R,Finset.mem_insert,Finset.mem_Icc]
        omega
      have hE :
          (∑ d ∈ S, e d) = harmonicFactorTuples 4 x -
            a*(∑ d ∈ S, (Real.log (x/(d : ℝ)^2))^4/(d : ℝ)^2) := by
        simp only [e,sub_div,mul_div_assoc,Finset.sum_sub_distrib,← Finset.mul_sum,
          harmonicFactorTuples_four_eq_square_sum hx]
        rfl
      have hMain : |∑ d ∈ S, e d| ≤ (4+a*B)*(1+L)^3 := by
        rw [hE]
        let v := ∑ d ∈ S, (Real.log (x/(d : ℝ)^2))^4/(d : ℝ)^2
        change |harmonicFactorTuples 4 x-a*v| ≤ _
        have he : harmonicFactorTuples 4 x-a*v =
            (harmonicFactorTuples 4 x-L^4/24)-a*(v-(Real.pi^2/6)*L^4) := by
          rw [mul_sub,← mul_assoc,hconst]
          ring
        rw [he]
        have hTuple : |harmonicFactorTuples 4 x-L^4/24| ≤ 4*(1+L)^3 := by
          simpa [L,Nat.factorial_succ] using abs_harmonicFactorTuples_sub_log_main_le 3 hx
        have hu := abs_sub_le (harmonicFactorTuples 4 x-L^4/24) 0 (a*(v-(Real.pi^2/6)*L^4))
        rw [sub_zero,zero_sub,abs_neg,abs_mul,abs_of_pos ha] at hu
        exact hu.trans ((add_le_add hTuple (mul_le_mul_of_nonneg_left (hBasel x hx) ha.le)).trans_eq
          (by ring))
      have hPoint (d : ℕ) (hd : d ∈ R) : |e d| ≤ C*(1+L)^3*((d : ℝ)⁻¹)^2 := by
        obtain ⟨hd₂,hdM⟩ := Finset.mem_Icc.mp hd
        have hdR : (d : ℝ) ≤ √x := ((by exact_mod_cast hdM : (d : ℝ) ≤ M)).trans
          (Nat.floor_le (Real.sqrt_nonneg _))
        have hd₀ : (0 : ℝ) < d := by exact_mod_cast (show 0 < d by omega)
        have hden : 0 < (d : ℝ)^2 := sq_pos_of_pos hd₀
        have hxden : (d : ℝ)^2 ≤ x := (pow_le_pow_left₀ hd₀.le hdR 2).trans_eq (Real.sq_sqrt hx₀.le)
        let y := x/(d : ℝ)^2
        have hy : 1 ≤ y := (one_le_div hden).2 hxden
        have hfloor : ⌊y⌋₊ < N := by
          dsimp only [y]
          rw [← Nat.cast_pow,Nat.floor_div_natCast,hxN]
          exact Nat.div_lt_self hN (by nlinarith only [hd₂] : 1 < d^2)
        have hyx : y ≤ x := div_le_self hx₀.le (show 1 ≤ (d : ℝ)^2 from
          one_le_pow₀ (by exact_mod_cast (show 1 ≤ d by omega)))
        have hlog := Real.log_le_log (zero_lt_one.trans_le hy) hyx
        have hpow : (1+Real.log y)^3 ≤ (1+L)^3 :=
          pow_le_pow_left₀ (by linarith only [Real.log_nonneg hy]) (add_le_add_right hlog 1) _
        have hh := (ih ⌊y⌋₊ hfloor y rfl hy).trans (mul_le_mul_of_nonneg_left hpow hC.le)
        change |(harmonicDivisorSquare y-a*(Real.log y)^4)/(d : ℝ)^2| ≤ _
        rw [abs_div,abs_of_pos hden,div_eq_mul_inv,← inv_pow]
        exact mul_le_mul_of_nonneg_right hh (by positivity)
      have hTail : |∑ d ∈ R, e d| ≤ C*(1+L)^3*(3/4) := by
        apply (Finset.abs_sum_le_sum_abs _ _).trans
        apply (Finset.sum_le_sum hPoint).trans
        rw [← Finset.mul_sum]
        exact mul_le_mul_of_nonneg_left (sum_inv_square_from_two_le M) (by positivity)
      rw [heS,Finset.sum_insert (by simp [R])] at hMain
      have hfirst : e 1 = harmonicDivisorSquare x-a*L^4 := by simp [e,L]
      rw [← hfirst,show e 1 = (e 1+∑ d ∈ R, e d)-(∑ d ∈ R, e d) by ring]
      have h := abs_sub_le (e 1+∑ d ∈ R, e d) 0 (∑ d ∈ R, e d)
      rw [sub_zero,zero_sub,abs_neg] at h
      exact h.trans ((add_le_add hMain hTail).trans_eq (by dsimp only [C]; ring))
  intro x hx
  rw [div_eq_mul_inv,mul_comm ((Real.log x)^4)]
  exact haux ⌊x⌋₊ x rfl hx

/-- Normalizing by four logarithms leaves the divisor energy coefficient. -/
theorem harmonicDivisorSquare_tendsto_log_four :
    Tendsto (fun x : ℝ => harmonicDivisorSquare x/(Real.log x)^4) atTop
      (𝓝 (1/(4*Real.pi^2))) := by
  obtain ⟨C,hC,h⟩ := abs_harmonicDivisorSquare_sub_log_main_le
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hlim : Tendsto (fun x : ℝ => (8*C)*(Real.log x)⁻¹) atTop (𝓝 0) := by
    simpa only [Function.comp_apply,mul_zero] using
      (tendsto_const_nhds (x := 8*C)).mul (tendsto_inv_atTop_zero.comp Real.tendsto_log_atTop)
  apply squeeze_zero' (Eventually.of_forall (fun _ => norm_nonneg _)) _ hlim
  filter_upwards [eventually_ge_atTop (1 : ℝ), (tendsto_atTop.1 Real.tendsto_log_atTop) 1] with x hx hlog
  have hl : 0 < Real.log x := zero_lt_one.trans_le hlog
  have hp : 0 < (Real.log x)^4 := pow_pos hl _
  rw [Real.norm_eq_abs]
  have he : harmonicDivisorSquare x/(Real.log x)^4 - 1/(4*Real.pi^2) =
      (harmonicDivisorSquare x-(Real.log x)^4/(4*Real.pi^2))/(Real.log x)^4 := by
    field_simp [hp.ne',Real.pi_pos.ne']
  rw [he,abs_div,abs_of_pos hp]
  apply (div_le_div_of_nonneg_right (h x hx) hp.le).trans
  have hpow : (1+Real.log x)^3 ≤ (2*Real.log x)^3 := pow_le_pow_left₀
    (by linarith only [hlog]) (by linarith only [hlog]) _
  apply (div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hpow hC.le) hp.le).trans_eq
  field_simp [hl.ne']
  ring

end Legendre.Density.Moment
