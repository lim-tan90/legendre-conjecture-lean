/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.ZetaWeyl
public import Mathlib.NumberTheory.Harmonic.Bounds
public import Mathlib.Analysis.Complex.Hadamard

@[expose] public section
namespace Legendre.Zeta
open Complex Set HadamardThreeLines

/-- The line of real part one has logarithmic growth at both signs of the height. -/
theorem riemannZeta_one_line_log_bound (t : ℝ) (ht : 2 ≤ |t|) :
    ‖riemannZeta (1+(t : ℂ)*I)‖ ≤ 4*(1+Real.log |t|) := by
  let s := (1 : ℂ)+(t : ℂ)*I
  let H := |t|
  let N := ⌈H⌉₊
  let P := ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-s)
  let Q := (N : ℂ)^(1-s)/(s-1)
  have hH : 0 < H := by linarith
  have hH₁ : 1 ≤ H := by linarith
  have hlogH : 0 ≤ Real.log H := Real.log_nonneg hH₁
  have hN₁ : 1 ≤ N := by
    have hh : (1 : ℝ) ≤ (N : ℝ) := hH₁.trans (Nat.le_ceil H)
    exact_mod_cast hh
  have hN₀ : 0 < N := by omega
  have hNr : (0 : ℝ) < N := by exact_mod_cast hN₀
  have hNlo : H ≤ N := Nat.le_ceil H
  have hNhi : (N : ℝ) ≤ 2*H := (Nat.ceil_lt_add_one hH.le).le.trans (by linarith)
  have hsre : s.re = 1 := by simp [s]
  have hsden : H ≤ ‖s-1‖ := by
    simpa only [H,s,sub_im,add_im,one_im,mul_im,ofReal_re,ofReal_im,I_re,I_im,
      mul_one,zero_mul,add_zero,zero_add,sub_zero] using Complex.abs_im_le_norm (s-1)
  have hs : s ≠ 1 := by
    intro he
    rw [he,sub_self,norm_zero] at hsden
    exact hH.not_ge hsden
  have hsNorm : ‖s‖ ≤ 1+H := by
    apply (norm_add_le _ _).trans_eq
    simp [H,Complex.norm_real,Real.norm_eq_abs]
  have hP : ‖P‖ ≤ 2+Real.log H := by
    have hh : Real.log (N : ℝ) ≤ Real.log 2 + Real.log H := by
      have hp := Real.log_le_log hNr hNhi
      rwa [Real.log_mul (by norm_num) hH.ne'] at hp
    have hr : (∑ n ∈ Finset.Icc 1 N, (n : ℝ)⁻¹) ≤ 1+Real.log N := by
      simpa only [harmonic_eq_sum_Icc,Rat.cast_sum,Rat.cast_inv,Rat.cast_natCast] using harmonic_le_one_add_log N
    apply (norm_sum_le _ _).trans
    calc
      _ = ∑ n ∈ Finset.Icc 1 N, (n : ℝ)⁻¹ := by
        apply Finset.sum_congr rfl
        intro n hn
        have hn₀ : 0 < n := (Finset.mem_Icc.mp hn).1
        rw [norm_natCast_cpow_of_pos hn₀,neg_re,hsre,Real.rpow_neg_one]
      _ ≤ 1+Real.log N := hr
      _ ≤ _ := by linarith only [hh,Real.log_le_sub_one_of_pos (by norm_num : 0 < (2 : ℝ))]
  have hQ : ‖Q‖ ≤ 1/2 := by
    dsimp only [Q]
    rw [norm_div,norm_natCast_cpow_of_pos hN₀,sub_re,one_re,hsre,sub_self,Real.rpow_zero]
    exact div_le_div_of_nonneg_left (by norm_num) (by norm_num) ((show (2 : ℝ) ≤ H from ht).trans hsden)
  have hE : ‖riemannZeta s-P-Q‖ ≤ 1 := by
    apply (norm_riemannZeta_sub_finite_euler_le hN₁ (show 0 < s.re by rw [hsre]; norm_num) hs).trans
    rw [hsre,mul_one,Real.rpow_neg_one, ← div_eq_mul_inv]
    apply (div_le_iff₀ hNr).2
    linarith only [hNlo,hsNorm,ht]
  change ‖riemannZeta s‖ ≤ _
  rw [show riemannZeta s = (riemannZeta s-P-Q)+(P+Q) by ring]
  apply (norm_add_le _ _).trans
  have hu := (norm_add_le P Q).trans (add_le_add hP hQ)
  have hh := add_le_add hE hu
  change H ≥ 2 at ht
  linarith only [hh,hlogH]

/-- Polynomial growth of the pole-removed zeta function on the closed strip. -/
private theorem norm_poleRemovedZeta_strip {s : ℂ} (hs : s.re ∈ Icc (1/2 : ℝ) 1) :
    ‖poleRemovedZeta s‖ ≤ 3*(1+|s.im|)^2 := by
  have hsp : 0 < s.re := by linarith only [hs.1]
  have hnorm : ‖s‖ ≤ 1+|s.im| := by
    rw [← Complex.re_add_im s]
    apply (norm_add_le _ _).trans
    rw [Complex.norm_real,norm_mul,Complex.norm_real,norm_I,mul_one,Real.norm_eq_abs,Real.norm_eq_abs,
      abs_of_nonneg hsp.le]
    rw [Complex.re_add_im]; simp
    linarith only [hs.2]
  have hdiff : ‖s-1‖ ≤ 1+|s.im| := by
    have he : s-1 = (((s.re-1 : ℝ)) : ℂ)+(s.im : ℂ)*I := by
      rw [Complex.ofReal_sub,Complex.ofReal_one]
      rw [sub_add_eq_add_sub,Complex.re_add_im]
    rw [he]
    apply (norm_add_le _ _).trans
    rw [Complex.norm_real,norm_mul,Complex.norm_real,norm_I,mul_one,Real.norm_eq_abs,Real.norm_eq_abs,
      abs_of_nonpos (by linarith only [hs.2])]
    linarith only [hs.1]
  have hR : ‖zetaMellinRemainder s‖ ≤ 2 :=
    (norm_zetaMellinRemainder_le hsp).trans ((div_le_iff₀ hsp).2 (by linarith only [hs.1]))
  rw [poleRemovedZeta_eq_euler_sum hsp]
  apply (norm_sub_le _ _).trans
  rw [norm_mul,norm_mul]
  have hp : ‖s‖*‖s-1‖ ≤ (1+|s.im|)^2 := by
    rw [pow_two]
    exact mul_le_mul hnorm hdiff (norm_nonneg _) (by positivity)
  have hprod := mul_le_mul hp hR (norm_nonneg _) (sq_nonneg _)
  nlinarith only [hnorm,hprod,abs_nonneg s.im,sq_nonneg |s.im|]

/-- Growth of the pole-removed zeta function on the two boundaries used in the
Weyl interpolation, with the height variable replaced by one plus its modulus. -/
theorem poleRemovedZeta_weyl_boundary :
    ∃ C : ℝ, 0 < C ∧
      (∀ s : ℂ, s.re = 1/2 → ‖poleRemovedZeta s‖ ≤
        C*(1+|s.im|)^(7/6 : ℝ)*(1+Real.log (1+|s.im|))) ∧
      (∀ s : ℂ, s.re = 1 → ‖poleRemovedZeta s‖ ≤
        C*(1+|s.im|)*(1+Real.log (1+|s.im|))) := by
  obtain ⟨P,hP,hp⟩ := riemannZeta_critical_weyl_bound
  let C := 27+P+4
  have hC : 0 < C := by dsimp [C]; positivity
  refine ⟨C,hC,?_,?_⟩
  all_goals intro s hs
  all_goals
    let R := 1+|s.im|
    let L := 1+Real.log R
    have hR : 1 ≤ R := by dsimp only [R]; linarith only [abs_nonneg s.im]
    have hL : 1 ≤ L := by dsimp only [L]; linarith only [Real.log_nonneg hR]
    have hRL : 1 ≤ R*L := one_le_mul_of_one_le_of_one_le hR hL
    have hstrip : s.re ∈ Icc (1/2 : ℝ) 1 := by rw [hs]; norm_num
    by_cases ht : 2 ≤ |s.im|
    swap
    · have hsmall : ‖poleRemovedZeta s‖ ≤ 27 := (norm_poleRemovedZeta_strip hstrip).trans (by
        apply (mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (by positivity) (show R ≤ 3 by
          dsimp only [R]; linarith only [lt_of_not_ge ht]) 2) (by norm_num : (0 : ℝ) ≤ 3)).trans_eq
        norm_num)
      apply hsmall.trans
      have hCR : 27 ≤ C := by dsimp [C]; linarith only [hP]
      apply hCR.trans
      rw [mul_assoc]
      apply le_mul_of_one_le_right hC.le
      first
      | exact one_le_mul_of_one_le_of_one_le (Real.one_le_rpow hR (by norm_num)) hL
      | exact hRL
  · rw [poleRemovedZeta_eq (by intro he; rw [he,one_re] at hs; norm_num at hs),norm_mul]
    have hd : ‖s-1‖ ≤ R := by
      have he : s-1 = (-1/2 : ℂ)+(s.im : ℂ)*I := by
        apply Complex.ext
        · norm_num [hs]
        · simp
      rw [he]
      exact (norm_add_le _ _).trans (by simp [Complex.norm_real,Real.norm_eq_abs,R]; linarith)
    have hz := hp s.im ht
    have he : s = (1/2 : ℂ)+(s.im : ℂ)*I := by
      apply Complex.ext <;> simp [hs]
    rw [← he] at hz
    have htlog : 1+Real.log |s.im| ≤ L := by
      apply add_le_add_right ?_ 1
      apply Real.log_le_log (by linarith only [ht])
      dsimp [R]
      linarith
    have hpow : |s.im|^(1/6 : ℝ) ≤ R^(1/6 : ℝ) := Real.rpow_le_rpow (abs_nonneg _)
      (by dsimp [R]; linarith) (by norm_num)
    change _ ≤ C*R^(7/6 : ℝ)*L
    calc
      _ ≤ R*(P*|s.im|^(1/6 : ℝ)*(1+Real.log |s.im|)) :=
        mul_le_mul hd hz (norm_nonneg _) (by positivity)
      _ ≤ R*(P*R^(1/6 : ℝ)*L) :=
        mul_le_mul_of_nonneg_left (mul_le_mul (mul_le_mul_of_nonneg_left hpow hP.le) htlog
          (by positivity [Real.log_nonneg (show 1 ≤ |s.im| by linarith only [ht])]) (by positivity))
          (by positivity)
      _ = P*R^(7/6 : ℝ)*L := by
        rw [show (7/6 : ℝ) = 1+1/6 by norm_num,Real.rpow_add (by positivity),Real.rpow_one]
        ring
      _ ≤ _ := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right
        (show P ≤ C by dsimp [C]; linarith) (by positivity)) (by linarith only [hL])
  · have hne : s ≠ 1 := by
      intro he
      rw [he,one_im,abs_zero] at ht
      norm_num at ht
    have he : s = 1+(s.im : ℂ)*I := Complex.ext (by simpa using hs) (by simp)
    have hz := riemannZeta_one_line_log_bound s.im ht
    rw [← he] at hz
    rw [poleRemovedZeta_eq hne,norm_mul]
    have hd : ‖s-1‖ = |s.im| := by rw [he]; simp [Complex.norm_real,Real.norm_eq_abs]
    rw [hd]
    have hl : 1+Real.log |s.im| ≤ L := add_le_add_right
      (Real.log_le_log (by linarith only [ht]) (by dsimp [R]; linarith)) 1
    have habs : |s.im| ≤ R := by dsimp [R]; linarith
    have hc : (4 : ℝ) ≤ C := by dsimp [C]; linarith only [hP]
    calc
      _ ≤ R*(4*(1+Real.log |s.im|)) := mul_le_mul habs hz (norm_nonneg _) (by positivity)
      _ ≤ R*(4*L) := mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hl (by norm_num)) (by positivity)
      _ = 4*R*L := by ring
      _ ≤ C*R*L := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hc (by positivity))
        (by linarith only [hL])

private theorem cubic_gaussian_le (r : ℝ) (hr : 0 ≤ r) :
    (1+r)^3*Real.exp (-r^2) ≤ 8 := by
  have h := Real.add_one_le_exp (r^2/4)
  have hlin : 1+r ≤ 2*Real.exp (r^2/4) := by
    nlinarith only [h,sq_nonneg (r-2),sq_nonneg r]
  have hpow := pow_le_pow_left₀ (show 0 ≤ 1+r by linarith) hlin 3
  apply (mul_le_mul_of_nonneg_right hpow (Real.exp_pos _).le).trans
  rw [mul_pow, ← Real.exp_nat_mul, mul_assoc, ← Real.exp_add]
  have he : (3 : ℝ)*(r^2/4)+(-r^2) ≤ 0 := by nlinarith only [sq_nonneg r]
  have hrp := mul_le_mul_of_nonneg_left (Real.exp_le_one_iff.mpr he) (show 0 ≤ (2 : ℝ)^3 by norm_num)
  exact hrp.trans_eq (by norm_num)

private theorem gaussian_localize_weyl_weight (y t p : ℝ) (hp : 0 ≤ p) (hp₂ : p ≤ 2) :
    (1+|y|)^p*(1+Real.log (1+|y|))*Real.exp (-(y-t)^2) ≤
      8*(1+|t|)^p*(1+Real.log (1+|t|)) := by
  let A := 1+|t|
  let R := 1+|y-t|
  let L := 1+Real.log A
  have hA : 1 ≤ A := by dsimp [A]; linarith only [abs_nonneg t]
  have hR : 1 ≤ R := by dsimp [R]; linarith only [abs_nonneg (y-t)]
  have hL : 1 ≤ L := by dsimp [L]; linarith only [Real.log_nonneg hA]
  have hY : 1+|y| ≤ A*R := by
    have h := abs_add_le (y-t) t
    rw [sub_add_cancel] at h
    dsimp [A,R]
    nlinarith only [h,mul_nonneg (abs_nonneg t) (abs_nonneg (y-t))]
  have hpow : (1+|y|)^p ≤ A^p*R^2 := by
    apply (Real.rpow_le_rpow (by positivity) hY hp).trans
    rw [Real.mul_rpow (by linarith) (by linarith)]
    apply mul_le_mul_of_nonneg_left _ (by positivity)
    rw [← Real.rpow_two]
    exact Real.rpow_le_rpow_of_exponent_le hR hp₂
  have hlog : 1+Real.log (1+|y|) ≤ L*R := by
    have hh := Real.log_le_log (show 0 < 1+|y| by positivity) hY
    rw [Real.log_mul (by linarith) (by linarith)] at hh
    have hu := Real.log_le_sub_one_of_pos (show 0 < R by linarith)
    dsimp only [L]
    nlinarith only [hh,hu,mul_nonneg (Real.log_nonneg hA) (show 0 ≤ R-1 by linarith)]
  have hE : R^3*Real.exp (-(y-t)^2) ≤ 8 := by
    have h := cubic_gaussian_le |y-t| (abs_nonneg _)
    rw [sq_abs] at h
    exact h
  calc
    _ ≤ (A^p*R^2)*(L*R)*Real.exp (-(y-t)^2) :=
      (mul_le_mul_of_nonneg_right (mul_le_mul hpow hlog
        (by linarith only [Real.log_nonneg (show 1 ≤ 1+|y| from le_add_of_nonneg_right (abs_nonneg _))]) (by positivity)) (by positivity))
    _ = (A^p*L)*(R^3*Real.exp (-(y-t)^2)) := by ring
    _ ≤ _ := (mul_le_mul_of_nonneg_left hE (by positivity)).trans_eq (by ring)

private theorem norm_poleRemovedZeta_localized (t : ℝ) (z : ℂ) :
    ‖poleRemovedZeta z*Complex.exp ((z-(t : ℂ)*I)^2)‖ =
      ‖poleRemovedZeta z‖*Real.exp (z.re^2)*Real.exp (-(z.im-t)^2) := by
  rw [norm_mul,Complex.norm_exp, mul_assoc, ← Real.exp_add]
  congr 2
  simp [pow_two, mul_re, sub_im, sub_re]
  ring

/-- A uniform Weyl bound in the full right half of the critical strip. -/
theorem riemannZeta_weyl_strip :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (1/2 : ℝ) 1, ∀ t : ℝ, 2 ≤ |t| →
      ‖riemannZeta ((σ : ℂ)+(t : ℂ)*I)‖ ≤ C*|t|^((1-σ)/3)*(1+Real.log |t|) := by
  obtain ⟨P,hP,hleft,hright⟩ := poleRemovedZeta_weyl_boundary
  refine ⟨64*Real.exp 1*P,by positivity,?_⟩
  intro σ hσ t ht
  let S := |t|
  let R := 1+S
  let L := 1+Real.log R
  let A := 8*Real.exp 1*P*L
  let z := (σ : ℂ)+(t : ℂ)*I
  let F := fun w : ℂ => poleRemovedZeta w*Complex.exp ((w-(t : ℂ)*I)^2)
  have hS : 0 < S := by dsimp only [S]; linarith only [ht]
  have hS₁ : 1 ≤ S := by dsimp only [S]; linarith only [ht]
  have hR : 1 ≤ R := by dsimp only [R]; linarith only [hS]
  have hL : 1 ≤ L := by dsimp only [L]; linarith only [Real.log_nonneg hR]
  have hA : 0 < A := by dsimp only [A]; positivity
  have hzre : z.re = σ := by simp [z]
  have hzim : z.im = t := by simp [z]
  have hz : z ∈ verticalClosedStrip (1/2) 1 := by
    change z.re ∈ Icc (1/2 : ℝ) 1
    rwa [hzre]
  have hd : Differentiable ℂ F := poleRemovedZeta_differentiable.mul
    (differentiable_exp.comp ((differentiable_id.sub_const ((t : ℂ)*I)).pow 2))
  have hdc : DiffContOnCl ℂ F (verticalStrip (1/2) 1) :=
    ⟨hd.differentiableOn,hd.continuous.continuousOn⟩
  have hloc (w : ℂ) (hw : w.re ∈ Icc (1/2 : ℝ) 1) (b p : ℝ)
      (hb : 0 ≤ b) (hp₀ : 0 ≤ p) (hp₂ : p ≤ 2)
      (hg : ‖poleRemovedZeta w‖ ≤ b*(1+|w.im|)^p*(1+Real.log (1+|w.im|))) :
      ‖F w‖ ≤ 8*Real.exp 1*b*R^p*L := by
    have hexp : Real.exp (w.re^2) ≤ Real.exp 1 :=
      Real.exp_le_exp.mpr (by
        simpa only [one_pow] using pow_le_pow_left₀
          (show 0 ≤ w.re by linarith only [hw.1]) hw.2 2)
    dsimp only [F]
    rw [norm_poleRemovedZeta_localized t w]
    have hlog : 0 ≤ 1+Real.log (1+|w.im|) := by
      linarith only [Real.log_nonneg (le_add_of_nonneg_right (abs_nonneg w.im))]
    have hprod : 0 ≤ b*(1+|w.im|)^p*(1+Real.log (1+|w.im|)) := by positivity
    apply (mul_le_mul_of_nonneg_right (mul_le_mul hg hexp (by positivity) hprod) (by positivity)).trans
    have h := gaussian_localize_weyl_weight w.im t p hp₀ hp₂
    have h' := mul_le_mul_of_nonneg_left h (show 0 ≤ Real.exp 1*b by positivity)
    change Real.exp 1*b*((1+|w.im|)^p*(1+Real.log (1+|w.im|))*Real.exp (-(w.im-t)^2)) ≤
      Real.exp 1*b*(8*R^p*L) at h'
    convert h' using 1 <;> ring
  have hbd : BddAbove ((norm ∘ F) '' verticalClosedStrip (1/2) 1) := by
    refine ⟨24*Real.exp 1*R^2*L,?_⟩
    rintro _ ⟨w,hw,rfl⟩
    change w.re ∈ Icc (1/2 : ℝ) 1 at hw
    change ‖F w‖ ≤ _
    have hh : ‖poleRemovedZeta w‖ ≤ 3*(1+|w.im|)^(2 : ℝ)*(1+Real.log (1+|w.im|)) := by
      rw [Real.rpow_two]
      exact (norm_poleRemovedZeta_strip hw).trans (le_mul_of_one_le_right (by positivity)
        (by linarith only [Real.log_nonneg (show 1 ≤ 1+|w.im| from le_add_of_nonneg_right (abs_nonneg _))]))
    exact (hloc w hw 3 2 (by norm_num) (by norm_num) le_rfl hh).trans_eq (by rw [Real.rpow_two]; ring)
  have ha (w : ℂ) (hw : w ∈ re ⁻¹' {(1/2 : ℝ)}) :
      ‖F w‖ ≤ A*R^(7/6 : ℝ) := by
    have hr : w.re = 1/2 := hw
    have hs : w.re ∈ Icc (1/2 : ℝ) 1 := by rw [hr]; norm_num
    exact (hloc w hs P (7/6) hP.le (by norm_num) (by norm_num) (hleft w hr)).trans_eq
      (by dsimp [A]; ring)
  have hb (w : ℂ) (hw : w ∈ re ⁻¹' {(1 : ℝ)}) :
      ‖F w‖ ≤ A*R := by
    have hr : w.re = 1 := hw
    have hs : w.re ∈ Icc (1/2 : ℝ) 1 := by rw [hr]; norm_num
    have h : ‖poleRemovedZeta w‖ ≤ P*(1+|w.im|)^(1 : ℝ)*(1+Real.log (1+|w.im|)) := by
      simpa only [Real.rpow_one] using hright w hr
    exact (hloc w hs P 1 hP.le (by norm_num) (by norm_num) h).trans_eq
      (by rw [Real.rpow_one]; dsimp [A]; ring)
  have h := norm_le_interp_of_mem_verticalClosedStrip' (by norm_num) hz hdc hbd ha hb
  let p := (σ-1/2)/(1-(1/2 : ℝ))
  let e := (1-σ)/3
  rw [hzre] at h
  change ‖F z‖ ≤ (A*R^(7/6 : ℝ))^(1-p)*(A*R)^p at h
  have he : (7/6 : ℝ)*(1-p)+p = 1+e := by dsimp [p,e]; ring
  have hrp : 0 < R := by linarith
  have hpow : (A*R^(7/6 : ℝ))^(1-p)*(A*R)^p = A*R^(1+e) := by
    rw [Real.mul_rpow hA.le (by positivity),Real.mul_rpow hA.le hrp.le, ← Real.rpow_mul hrp.le]
    calc
      _ = (A^(1-p)*A^p)*(R^((7/6 : ℝ)*(1-p))*R^p) := by ring
      _ = _ := by
        rw [← Real.rpow_add hA, ← Real.rpow_add hrp, he, sub_add_cancel, Real.rpow_one]
  rw [hpow] at h
  have hden : S ≤ ‖z-1‖ := by simpa [S,hzim] using abs_im_le_norm (z-1)
  have hne : z ≠ 1 := by
    intro heq
    rw [heq,sub_self,norm_zero] at hden
    exact hS.not_ge hden
  have hpre : S*‖riemannZeta z‖ ≤ ‖F z‖ := by
    dsimp only [F]
    rw [norm_poleRemovedZeta_localized t z, hzim, sub_self, zero_pow (by norm_num : (2 : ℕ) ≠ 0), neg_zero,
      Real.exp_zero,mul_one,poleRemovedZeta_eq hne,norm_mul]
    have hu : 1 ≤ Real.exp (z.re^2) := Real.one_le_exp (sq_nonneg _)
    exact (mul_le_mul_of_nonneg_right hden (norm_nonneg _)).trans
      (le_mul_of_one_le_right (by positivity) hu)
  have hR₂ : R ≤ 2*S := by dsimp [R]; linarith only [hS₁]
  have he₀ : 0 ≤ e := by dsimp [e]; linarith only [hσ.2]
  have he₂ : 1+e ≤ 2 := by dsimp [e]; linarith only [hσ.1]
  have hRpow : R^(1+e) ≤ 4*(S*S^e) := by
    apply (Real.rpow_le_rpow hrp.le hR₂ (by positivity)).trans
    rw [Real.mul_rpow (by norm_num) hS.le,Real.rpow_add hS,Real.rpow_one]
    apply mul_le_mul_of_nonneg_right _ (by positivity)
    have hh := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ (2 : ℝ) by norm_num) he₂
    simpa only [Real.rpow_two,show (2 : ℝ)^2 = 4 by norm_num] using hh
  have hL₂ : L ≤ 2*(1+Real.log S) := by
    have hh := Real.log_le_log hrp hR₂
    rw [Real.log_mul (by norm_num) hS.ne'] at hh
    dsimp [L]
    linarith only [hh,Real.log_nonneg hS₁,Real.log_le_sub_one_of_pos (by norm_num : 0 < (2 : ℝ))]
  change ‖riemannZeta z‖ ≤ 64*Real.exp 1*P*S^e*(1+Real.log S)
  apply le_of_mul_le_mul_left _ hS
  apply (hpre.trans h).trans
  have hu := mul_le_mul (mul_le_mul_of_nonneg_left hL₂ (show 0 ≤ 8*Real.exp 1*P by positivity)) hRpow
    (by positivity) (mul_nonneg (by positivity) (zero_le_one.trans (hL.trans hL₂)))
  exact hu.trans_eq (by ring)

end Legendre.Zeta
