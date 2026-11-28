/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.ZetaEulerBernoulli

@[expose] public section
namespace Legendre.Zeta
open Complex Set MeasureTheory

/-- Integration by parts retains the boundary term at the lower cutoff. -/
theorem zetaEulerTail_eq_eulerPrimitive {a : ℝ} (ha : 1 ≤ a) {s : ℂ} (hs : 0 < s.re) :
    zetaEulerTail a s = -zetaEulerPrimitive a*(a : ℂ)^(-s-1)+
      (s+1)*(∫ x in Ioi a, zetaEulerPrimitive x*(x : ℂ)^(-s-2)) := by
  let G := fun x : ℝ => zetaEulerPrimitive x*(x : ℂ)^(-s-2)
  let F := fun x : ℝ => zetaCenteredFractionalPart x*(x : ℂ)^(-s-1)
  let D := fun x : ℝ => F x-(s+1)*G x
  let P := fun x : ℝ => zetaEulerPrimitive x*(x : ℂ)^(-s-1)
  have hFi : IntegrableOn F (Ioi 1) := centeredEuler_integrable hs
  have hs₀ : -1 < s.re := by linarith only [hs]
  have hGi : IntegrableOn G (Ioi 1) := by
    simpa only [G,mul_comm (zetaEulerPrimitive _)] using zetaSecondMellinRemainder_integrable hs₀
  have hDi : IntegrableOn D (Ioi 1) := hFi.sub (hGi.const_mul _)
  have htotal : (∫ x in Ioi 1, D x) = 0 := by
    dsimp only [D,F,G]
    rw [integral_sub hFi (hGi.const_mul (s+1)),integral_const_mul,centeredEuler_integral hs,
      zetaMellinRemainder_eq_second hs]
    have hg : (∫ x in Ioi (1 : ℝ), G x) = zetaSecondMellinRemainder s := by
      rw [zetaSecondMellinRemainder_eq_integral]
      apply setIntegral_congr_fun measurableSet_Ioi
      intro x hx
      exact mul_comm _ _
    change _-(s+1)*(∫ x in Ioi (1 : ℝ), G x) = _
    rw [hg]
    ring
  have hcont : ContinuousOn P (Icc 1 a) := by
    apply zetaEulerPrimitive_continuous.continuousOn.mul
    intro x hx
    exact (euler_power_hasDerivAt hs₀ (zero_lt_one.trans_le hx.1)).continuousAt.continuousWithinAt
  have hd (x : ℝ) (hx : x ∈ Ioo (1 : ℝ) a) :
      HasDerivWithinAt P (D x) (Ioi x) x := by
    have h := (zetaEulerPrimitive_hasDerivWithinAt_right x).mul
      ((euler_power_hasDerivAt hs₀ (zero_lt_one.trans hx.1)).hasDerivWithinAt)
    convert! h using 1
    dsimp [D,F,G,zetaCenteredFractionalPart]
    ring
  have hi : IntervalIntegrable D volume 1 a :=
    (intervalIntegrable_iff_integrableOn_Ioc_of_le ha).2 (hDi.mono_set (fun _ hx => hx.1))
  have hfinite := intervalIntegral.integral_eq_sub_of_hasDeriv_right_of_le ha hcont hd hi
  have hsplit := intervalIntegral.integral_interval_add_Ioi hDi (hDi.mono_set (Ioi_subset_Ioi ha))
  rw [htotal,hfinite,show P 1 = 0 by
    have he : zetaEulerPrimitive 1 = 0 := by
      simpa only [Int.cast_one] using zetaEulerPrimitive_int (1 : ℤ)
    simp [P,he],sub_zero] at hsplit
  have htail : (∫ x in Ioi a, D x) = -P a := by linear_combination hsplit
  change (∫ x in Ioi a, F x-(s+1)*G x) = -P a at htail
  rw [integral_sub (hFi.mono_set (Ioi_subset_Ioi ha))
    ((hGi.mono_set (Ioi_subset_Ioi ha)).const_mul (s+1)),integral_const_mul] at htail
  change (∫ x in Ioi a, F x) = _
  have heq : (∫ x in Ioi a, F x) = -P a+(s+1)*(∫ x in Ioi a, G x) := by
    rw [← htail]
    ring
  simpa only [P,G,neg_mul] using heq

/-- Past the height, the finite Euler error after removing the pole is
uniformly of the order of the last Dirichlet coefficient. -/
theorem norm_riemannZeta_sub_finite_euler_le_cutoff_power :
    ∃ C : ℝ, 0 < C ∧ ∀ (N : ℕ), 1 ≤ N → ∀ s : ℂ, 0 < s.re → s.re ≤ 1 →
      s ≠ 1 → |s.im| ≤ N →
      ‖riemannZeta s-(∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s))-
        (N : ℂ)^(1-s)/(s-1)‖ ≤ C*(N : ℝ)^(-s.re) := by
  let A := ∑' k : ℤ, ‖eulerBernoulliCoefficient k‖
  let C := 45*A+1
  have hA : 0 ≤ A := tsum_nonneg fun _ => norm_nonneg _
  refine ⟨C,by dsimp only [C]; positivity,?_⟩
  intro N hN s hs hs₁ hsne hst
  let a := (N : ℝ)
  let u := -s-2
  let J := (∫ x in Ioi a, zetaEulerPrimitive x*(x : ℂ)^u)+
    (1/12 : ℂ)*(∫ x in Ioi a, (x : ℂ)^u)
  let q := (a : ℂ)^(-s-1)
  have ha : 1 ≤ a := by dsimp [a]; exact_mod_cast hN
  have ha₀ : 0 < a := zero_lt_one.trans_le ha
  have hure : u.re = -s.re-2 := by simp [u]
  have hui : |u.im| ≤ a := by simpa [u,a] using hst
  have hn (j : ℝ) (hj : 0 ≤ j) (hj' : j ≤ 2) : ‖s+(j : ℂ)‖ ≤ (j+2)*a := by
    have he : s+(j : ℂ) = ((s.re+j : ℝ) : ℂ)+(s.im : ℂ)*I := by
      rw [ofReal_add,add_right_comm,Complex.re_add_im]
    rw [he]
    apply (norm_add_le _ _).trans
    have hpos : 0 ≤ s.re+j := by linarith only [hs,hj]
    rw [Complex.norm_real,norm_mul,norm_I,mul_one,Complex.norm_real,Real.norm_eq_abs,Real.norm_eq_abs,abs_of_nonneg hpos]
    have hm := mul_nonneg (show 0 ≤ j+1 by linarith only [hj]) (show 0 ≤ a-1 by linarith only [ha])
    dsimp only [a] at *
    nlinarith only [hm,hs₁,hst]
  have hn₀ : ‖s‖ ≤ 3*a := by
    have hh := (hn 0 (by norm_num) (by norm_num))
    simp only [ofReal_zero,add_zero,zero_add] at hh
    exact hh.trans (by nlinarith only [ha₀])
  have hn₁ : ‖s+1‖ ≤ 3*a := by
    simpa only [ofReal_one,show (1:ℝ)+2 = 3 by norm_num] using hn 1 (by norm_num) (by norm_num)
  have hn₂ : ‖u‖ ≤ 4*a := by
    have hh := hn 2 (by norm_num) (by norm_num)
    dsimp only [u]
    rw [show -s-2 = -(s+(2:ℂ)) by ring,norm_neg]
    simpa only [ofReal_ofNat,show (2:ℝ)+2 = 4 by norm_num] using hh
  have hJ : ‖J‖ ≤ 5*a^(-s.re-2)*A := by
    have h := norm_integral_eulerBernoulli_cpow_sub_constant_le ha
      (show u.re < -2 by rw [hure]; linarith only [hs]) hui hn₂
    rw [hure] at h
    exact h
  have hsa : s+1 ≠ 0 := by
    intro he
    have h := congrArg Complex.re he
    simp at h
    linarith only [hs,h]
  have hJint : (∫ x in Ioi a, (x : ℂ)^u) = q/(s+1) := by
    rw [integral_Ioi_cpow_of_lt (by rw [hure]; linarith only [hs]) ha₀]
    dsimp only [q]
    rw [show u+1 = -s-1 by dsimp [u]; ring, show -s-1 = -(s+1) by ring, div_neg, neg_div, neg_neg]
  have hcut : zetaEulerPrimitive a = 0 := by
    simpa only [a,Int.cast_natCast] using zetaEulerPrimitive_int (N : ℤ)
  have hTail : zetaEulerTail a s = (s+1)*J-(1/12 : ℂ)*q := by
    rw [zetaEulerTail_eq_eulerPrimitive ha hs,hcut,neg_zero,zero_mul,zero_add]
    dsimp only [J,u]
    change _ = (s+1)*((∫ x in Ioi a, zetaEulerPrimitive x*(x : ℂ)^(-s-2))+
      (1/12 : ℂ)*(∫ x in Ioi a, (x : ℂ)^u))-(1/12 : ℂ)*q
    rw [hJint]
    field_simp [hsa]
    ring
  have hp (d : ℝ) (hd : 0 ≤ d) :
      a^(-s.re-d) = a^(-s.re)/a^d := Real.rpow_sub ha₀ _ _
  have hJscaled : ‖s*(s+1)*J‖ ≤ 45*A*a^(-s.re) := by
    rw [norm_mul,norm_mul]
    have h := mul_le_mul (mul_le_mul hn₀ hn₁ (norm_nonneg _) (by positivity)) hJ
      (norm_nonneg _) (by positivity)
    apply h.trans_eq
    rw [hp 2 (by norm_num),Real.rpow_two]
    field_simp [ha₀.ne']
    ring
  have hterm : ‖s*((1/12 : ℂ)*q)‖ ≤ (1/4)*a^(-s.re) := by
    rw [norm_mul,norm_mul,show ‖(1/12 : ℂ)‖ = 1/12 by norm_num]
    dsimp only [q]
    rw [norm_cpow_eq_rpow_re_of_pos ha₀]
    simp only [sub_re,neg_re,one_re]
    have h := mul_le_mul_of_nonneg_right hn₀ (show 0 ≤ (1/12 : ℝ)*a^(-s.re-1) by positivity)
    apply h.trans_eq
    rw [hp 1 (by norm_num),Real.rpow_one]
    field_simp [ha₀.ne']
    ring
  have hNpow : ‖(1/2 : ℂ)*(N : ℂ)^(-s)‖ = (1/2)*a^(-s.re) := by
    have hN₀ : 0 < N := by omega
    rw [norm_mul,norm_natCast_cpow_of_pos hN₀,neg_re]
    norm_num [a]
  have hi := riemannZeta_eq_finite_euler hN hs hsne
  have he : riemannZeta s-(∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s))-(N : ℂ)^(1-s)/(s-1) =
      -((1/2 : ℂ)*(N : ℂ)^(-s))-s*(s+1)*J+s*((1/12 : ℂ)*q) := by
    rw [hi,show zetaEulerTail (N : ℝ) s = zetaEulerTail a s from rfl,hTail]
    ring
  rw [he]
  apply (norm_add_le _ _).trans
  have h := (norm_sub_le _ _).trans (add_le_add
    (show ‖-((1/2 : ℂ)*(N : ℂ)^(-s))‖ ≤ (1/2)*a^(-s.re) by rw [norm_neg,hNpow]) hJscaled)
  have hbound := add_le_add h hterm
  change _ ≤ C*a^(-s.re)
  dsimp only [C]
  linarith only [hbound,show 0 ≤ a^(-s.re) by positivity]

/-- On the critical line the explicit pole term costs at most the square
root of the cutoff divided by the positive height. -/
theorem norm_critical_euler_error_le :
    ∃ P : ℝ, 0 < P ∧ ∀ (N : ℕ) (t : ℝ), 1 ≤ N → 0 < t → t ≤ N →
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)-
        ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))‖ ≤
      P*(N : ℝ)^(-(1/2 : ℝ))+√(N : ℝ)/t := by
  obtain ⟨P,hP,hb⟩ := norm_riemannZeta_sub_finite_euler_le_cutoff_power
  refine ⟨P,hP,?_⟩
  intro N t hN ht htN
  let s := (1/2 : ℂ)+(t : ℂ)*I
  let q := (N : ℂ)^(1-s)/(s-1)
  let p := ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s)
  have hSr : s.re = 1/2 := by norm_num [s]
  have hSi : s.im = t := by norm_num [s]
  have hS : s ≠ 1 := by
    intro he
    have hh := congrArg Complex.re he
    rw [hSr,one_re] at hh
    norm_num at hh
  have hsN : |s.im| ≤ N := by rwa [hSi,abs_of_pos ht]
  have hE := hb N hN s (by rw [hSr]; norm_num) (by rw [hSr]; norm_num) hS hsN
  rw [hSr] at hE
  have htden : t ≤ ‖s-1‖ := by
    simpa [hSi,abs_of_pos ht] using abs_im_le_norm (s-1)
  have hq : ‖q‖ ≤ √(N : ℝ)/t := by
    dsimp only [q]
    rw [norm_div,norm_natCast_cpow_of_pos (show 0 < N from hN),sub_re,one_re,hSr,
      show (1 : ℝ)-1/2 = 1/2 by norm_num,← Real.sqrt_eq_rpow]
    exact div_le_div_of_nonneg_left (by positivity) ht htden
  change ‖riemannZeta s-p‖ ≤ _
  rw [show riemannZeta s-p = (riemannZeta s-p-q)+q by ring]
  exact (norm_add_le _ _).trans (add_le_add hE hq)

end Legendre.Zeta
