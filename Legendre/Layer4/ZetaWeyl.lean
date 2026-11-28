/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.Exponential.CriticalWeylBlocks
public import Legendre.Layer4.DyadicHeightShells
public import Legendre.Layer4.DyadicPartition
public import Legendre.ZetaFiniteEuler
public import Legendre.ZeroDensity

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex

/-- A critical-line block keeps the Weyl cost up to twice the squared height. -/
theorem critical_block_weyl_through_square :
    ∃ C : ℝ, 0 < C ∧ ∀ t : ℝ, 1 ≤ t → ∀ U V : ℕ, 1 ≤ U → U ≤ V → V ≤ 2*U →
      (U : ℝ) ≤ 2*t^2 →
      ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))‖ ≤ C*t^(1/6 : ℝ) := by
  let Cw := √(4+18*logarithmicShiftConstant)
  let Cs := logarithmicSecondConstant
  let Cl := 24*Real.pi
  have hCw : 0 < Cw := by dsimp [Cw]; exact Real.sqrt_pos.2 (by positivity [logarithmicShiftConstant_pos])
  have hCs : 0 < Cs := logarithmicSecondConstant_pos
  have hCl : 0 < Cl := by dsimp [Cl]; positivity [Real.pi_pos]
  refine ⟨Cw+2*Cs+Cl,by positivity,?_⟩
  intro t ht U V hU hUV hV hUt
  let u := (U : ℝ)
  let q := t^(1/6 : ℝ)
  have hq : 1 ≤ q := Real.one_le_rpow ht (by norm_num)
  have htp : 0 < t := by linarith only [ht]
  have hu : 0 < u := by dsimp [u]; exact_mod_cast (show 0 < U by omega)
  have hsu : 0 < √u := Real.sqrt_pos.2 hu
  have he : u^(-(1/2 : ℝ)) = (√u)⁻¹ := by rw [Real.rpow_neg hu.le, ← Real.sqrt_eq_rpow]
  have hc : (((1/2 : ℝ) : ℂ)) = (1/2 : ℂ) := by norm_num
  change _ ≤ (Cw+2*Cs+Cl)*q
  by_cases hshort : u ≤ t^(2/3 : ℝ)
  · exact (logarithmic_block_weighted_weyl_two_thirds U V hU hUV hV t ht hshort).trans
      (mul_le_mul_of_nonneg_right (by linarith only [hCs,hCl]) (by positivity))
  by_cases hmid : u ≤ t
  · have h := logarithmic_block_second_weighted U V hU hUV hV (1/2) t (by norm_num) htp.ne'
    rw [abs_of_pos htp,hc] at h
    change _ ≤ (Cs*(√t+u/√t))*u^(-(1/2 : ℝ)) at h
    rw [he] at h
    have hsu_lower : t^(1/3 : ℝ) ≤ √u := by
      have heq : t^(1/3 : ℝ) = √(t^(2/3 : ℝ)) := by
        rw [Real.sqrt_eq_rpow, ← Real.rpow_mul htp.le]
        congr 1
        ring
      rw [heq]
      exact Real.sqrt_le_sqrt (le_of_not_ge hshort)
    have htroot : √t = t^(1/3 : ℝ)*q := by
      dsimp only [q]
      rw [Real.sqrt_eq_rpow, ← Real.rpow_add htp]
      congr 1
      ring
    have hleft : √t/√u ≤ q := by
      apply (div_le_iff₀ hsu).2
      rw [htroot,mul_comm q]
      exact mul_le_mul_of_nonneg_right hsu_lower (by positivity)
    have hright : (u/√t)/√u ≤ q := by
      have hs : √u/√t ≤ 1 := (div_le_one (Real.sqrt_pos.2 htp)).2 (Real.sqrt_le_sqrt hmid)
      have heq : (u/√t)/√u = √u/√t := by
        field_simp [hsu.ne',(Real.sqrt_pos.2 htp).ne']
        rw [Real.sq_sqrt hu.le]
      rw [heq]
      exact hs.trans hq
    apply h.trans
    rw [← div_eq_mul_inv,mul_div_assoc,add_div]
    have hb := mul_le_mul_of_nonneg_left (add_le_add hleft hright) hCs.le
    nlinarith only [hb, mul_nonneg hCw.le (show 0 ≤ q by positivity),
      mul_nonneg hCl.le (show 0 ≤ q by positivity)]
  · have h := critical_block_first_derivative U V hU hUV hV t htp (le_of_not_ge hmid)
    have hs : √u ≤ 2*t := by
      apply Real.sqrt_le_iff.mpr ⟨by positivity,?_⟩
      change u ≤ 2*t^2 at hUt
      nlinarith only [hUt,sq_nonneg t]
    have hbound : √u/t ≤ 2 := (div_le_iff₀ htp).2 (by linarith only [hs])
    calc
      _ ≤ 12*Real.pi*√u/t := h
      _ = 12*Real.pi*(√u/t) := by ring
      _ ≤ Cl := (mul_le_mul_of_nonneg_left hbound (by positivity)).trans_eq (by dsimp [Cl]; ring)
      _ ≤ Cl*q := le_mul_of_one_le_right hCl.le hq
      _ ≤ _ := mul_le_mul_of_nonneg_right (by linarith only [hCw,hCs]) (by positivity)

end Legendre.Density.Oscillation

namespace Legendre.Zeta
open Complex Density.Moment Density.Oscillation

/-- Finite Euler summation at a squared-height cutoff has a bounded error. -/
theorem zeta_critical_finite_euler_square_error {N : ℕ} (hN : 1 ≤ N)
    (t : ℝ) (ht : 1 ≤ t) (hNr : t^2 ≤ (N : ℝ)) (hNr' : (N : ℝ) ≤ 2*t^2) :
    ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)-
      ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))‖ ≤ 4 := by
  let s := (1/2 : ℂ)+(t : ℂ)*I
  let u := (N : ℝ)
  let P := ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s)
  let Q := (N : ℂ)^(1-s)/(s-1)
  have htr : 0 < t := by linarith only [ht]
  have hu : 0 < u := by dsimp [u]; exact_mod_cast (show 0 < N by omega)
  have hsre : s.re = 1/2 := by norm_num [s]
  have hsim : s.im = t := by norm_num [s]
  have hs : s ≠ 1 := by
    intro h
    have hh := congrArg Complex.re h
    rw [hsre,one_re] at hh
    norm_num at hh
  have hsNorm : ‖s‖ ≤ 1/2+t := by
    dsimp only [s]
    apply (norm_add_le _ _).trans_eq
    rw [norm_mul,Complex.norm_real,Real.norm_eq_abs,abs_of_pos htr,norm_I,mul_one]
    norm_num
  have hden : t ≤ ‖s-1‖ := by
    simpa only [sub_im,hsim,one_im,sub_zero,abs_of_pos htr] using Complex.abs_im_le_norm (s-1)
  have hl : t ≤ √u := by
    have h := Real.sqrt_le_sqrt hNr
    rwa [Real.sqrt_sq htr.le] at h
  have hh : √u ≤ 2*t := (Real.sqrt_le_iff).2 ⟨by positivity,by
    change u ≤ 2*t^2 at hNr'
    nlinarith only [hNr',sq_nonneg t]⟩
  have hpow : ‖(N : ℂ)^(1-s)‖ = √u := by
    rw [norm_natCast_cpow_of_pos (show 0 < N by omega),sub_re,one_re,hsre,
      show (1 : ℝ)-1/2 = 1/2 by norm_num, ← Real.sqrt_eq_rpow]
  have hQ : ‖Q‖ ≤ 2 := by
    dsimp only [Q]
    rw [norm_div,hpow]
    exact (div_le_div₀ (by positivity) hh htr hden).trans_eq (by field_simp)
  have h := norm_riemannZeta_sub_finite_euler_le hN (show 0 < s.re by rw [hsre]; norm_num) hs
  change ‖riemannZeta s-P-Q‖ ≤ _ at h
  rw [hsre,show 2*(1/2 : ℝ) = 1 by norm_num,div_one,Real.rpow_neg hu.le, ← Real.sqrt_eq_rpow] at h
  have hE : ‖riemannZeta s-P-Q‖ ≤ 2 := by
    apply h.trans
    rw [← div_eq_mul_inv]
    apply (div_le_iff₀ (Real.sqrt_pos.2 hu)).2
    linarith only [hl,ht,hsNorm]
  change ‖riemannZeta s-P‖ ≤ _
  rw [show riemannZeta s-P = (riemannZeta s-P-Q)+Q by ring]
  exact (norm_add_le _ _).trans ((add_le_add hE hQ).trans_eq (by norm_num))

/-- Weyl's critical-line exponent, with one logarithm and an absolute constant. -/
theorem riemannZeta_critical_weyl_bound :
    ∃ C : ℝ, 0 < C ∧ ∀ t : ℝ, 2 ≤ |t| →
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖ ≤ C*|t|^(1/6 : ℝ)*(1+Real.log |t|) := by
  obtain ⟨P,hP,hb⟩ := critical_block_weyl_through_square
  let D := 4/Real.log 2
  have hD : 0 < D := by dsimp [D]; positivity
  let C := 5+D*P
  have hC : 0 < C := by dsimp [C]; positivity
  refine ⟨C,hC,?_⟩
  have hpos (t : ℝ) (ht : 2 ≤ t) :
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖ ≤ C*t^(1/6 : ℝ)*(1+Real.log t) := by
    have htp : 0 < t := by linarith only [ht]
    have ht1 : 1 ≤ t := by linarith only [ht]
    obtain ⟨J,hJlo,hJhi,hJl⟩ := real_height_dyadic_cover (t^2) (by nlinarith only [ht,sq_nonneg (t-2)])
    let N := (2 : ℕ)^J
    let q := t^(1/6 : ℝ)
    let f := fun n : ℕ => (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))
    let S := ∑ n ∈ Finset.Icc 1 N, f n
    have hq₁ : 1 ≤ q := Real.one_le_rpow ht1 (by norm_num)
    have hq : 0 ≤ q := zero_le_one.trans hq₁
    have hlog : 0 ≤ Real.log t := Real.log_nonneg ht1
    have hJl' : (J : ℝ) ≤ D*Real.log t := by
      rw [Real.log_pow,Nat.cast_ofNat] at hJl
      dsimp only [D]
      convert hJl using 1
      ring
    have hN : 1 ≤ N := one_le_pow₀ (by norm_num)
    have hNr : t^2 ≤ (N : ℝ) := by simpa [N] using hJlo
    have hNr' : (N : ℝ) ≤ 2*t^2 := by simpa [N] using hJhi
    have hsum : S = 1+∑ j ∈ Finset.range J, ∑ n ∈ Finset.Ioc (2^j) (2^(j+1)), f n := by
      simpa [S,N,f] using moment_dyadic_partition 1 J le_rfl f
    have hB (j : ℕ) (hj : j ∈ Finset.range J) :
        ‖∑ n ∈ Finset.Ioc (2^j) (2^(j+1)), f n‖ ≤ P*q := by
      have hu : 1 ≤ (2 : ℕ)^j := one_le_pow₀ (by norm_num)
      have hupper : ((2^j : ℕ) : ℝ) ≤ 2*t^2 := by
        push_cast
        exact (pow_le_pow_right₀ (by norm_num : (1 : ℝ) ≤ 2) (Finset.mem_range.mp hj).le).trans hJhi
      exact hb t ht1 (2^j) (2^(j+1)) hu (by rw [pow_succ]; omega)
        (by rw [pow_succ,mul_comm]) hupper
    have hS : ‖S‖ ≤ 1+(D*Real.log t)*(P*q) := by
      rw [hsum]
      refine (norm_add_le _ _).trans (add_le_add (by simp) ?_)
      refine (norm_sum_le _ _).trans ((Finset.sum_le_sum hB).trans ?_)
      rw [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
      exact mul_le_mul_of_nonneg_right hJl' (by positivity)
    obtain h := zeta_critical_finite_euler_square_error hN t ht1 hNr hNr'
    let z := riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)
    change ‖z-S‖ ≤ 4 at h
    change ‖z‖ ≤ C*q*(1+Real.log t)
    rw [show z = (z-S)+S by ring]
    calc
      _ ≤ _ := norm_add_le _ _
      _ ≤ 4+(1+(D*Real.log t)*(P*q)) := add_le_add h hS
      _ ≤ _ := by
        dsimp only [C]
        nlinarith only [hq₁, mul_nonneg hq hlog,mul_nonneg (mul_nonneg hD.le hP.le) hq]
  intro t ht
  by_cases h : 0 ≤ t
  · rw [abs_of_nonneg h] at ht ⊢
    exact hpos t ht
  · have ht' : 2 ≤ -t := by rwa [abs_of_neg (lt_of_not_ge h)] at ht
    have he : (1/2 : ℂ)+(t : ℂ)*I = star ((1/2 : ℂ)+((-t : ℝ) : ℂ)*I) := by simp
    rw [Complex.star_def] at he
    rw [abs_of_neg (lt_of_not_ge h), he,riemannZeta_conj, Complex.norm_conj]
    exact hpos (-t) ht'

/-- The height exponent in the Weyl bound is (1/6 + epsilon) for every
positive epsilon, with a constant uniform in both signs of the ordinate. -/
theorem riemannZeta_critical_weyl_epsilon (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ t : ℝ, 2 ≤ |t| →
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖ ≤ C*|t|^(1/6+ε) := by
  obtain ⟨P,hP,hb⟩ := riemannZeta_critical_weyl_bound
  obtain ⟨Q,hQ,hlog⟩ := exists_log_pow_le_rpow 1 hε
  refine ⟨P*(1+Q),by positivity,?_⟩
  intro t ht
  have hp : 0 < |t| := by linarith
  have hs : 1 ≤ |t|^ε := Real.one_le_rpow (by linarith) hε.le
  have hlog' : 1+Real.log |t| ≤ (1+Q)*|t|^ε := by
    have h := hlog |t| ht
    rw [pow_one] at h
    linarith only [hs,h]
  apply (hb t ht).trans
  calc
    _ ≤ (P*|t|^(1/6 : ℝ))*((1+Q)*|t|^ε) := mul_le_mul_of_nonneg_left hlog' (by positivity)
    _ = P*(1+Q)*(|t|^(1/6 : ℝ)*|t|^ε) := by ring
    _ = _ := by rw [← Real.rpow_add hp]

end Legendre.Zeta
