/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.ZetaWeylStrip
public import Legendre.GammaBounds.SharpGammaHorizontal

@[expose] public section
namespace Legendre.Zeta
open Complex Set Density.GammaBounds

private theorem gamma_norm_nonzero_of_nonnegative {z : ℂ} (hz : 0 ≤ z.re) (h₀ : z ≠ 0) :
    0 < ‖Complex.Gamma z‖ := by
  apply norm_pos_iff.mpr
  have h : Complex.Gamma (z+1) ≠ 0 :=
    Complex.Gamma_ne_zero_of_re_pos (by simp; linarith only [hz])
  rw [Complex.Gamma_add_one z h₀] at h
  exact (mul_ne_zero_iff.mp h).2

private theorem gamma_norm_ratio_on_strip (a b u : ℝ)
    (ha : 0 ≤ a) (hab : a ≤ b) (hb : b ≤ 1/2) (hu : u ≠ 0) :
    ‖Complex.Gamma ((b : ℂ)+(u : ℂ)*I)‖/‖Complex.Gamma ((a : ℂ)+(u : ℂ)*I)‖ ≤
    Real.exp ((59+|Real.eulerMascheroniConstant|)*(b-a))*(|u|+2)^(b-a) := by
  let x := (a : ℂ)+(u : ℂ)*I
  let y := (b : ℂ)+(u : ℂ)*I
  have hxi : x.im = u := by simp [x]
  have hyi : y.im = u := by simp [y]
  have hx₀ : x ≠ 0 := by intro he; rw [he,zero_im] at hxi; exact hu hxi.symm
  have hy₀ : y ≠ 0 := by intro he; rw [he,zero_im] at hyi; exact hu hyi.symm
  have hGx := gamma_norm_nonzero_of_nonnegative (z := x) (by simpa [x] using ha) hx₀
  have hGy := gamma_norm_nonzero_of_nonnegative (z := y)
    (by simpa [y] using ha.trans hab) hy₀
  have hxy : ‖x‖ ≤ ‖y‖ := by
    apply (sq_le_sq₀ (norm_nonneg _) (norm_nonneg _)).1
    rw [← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq]
    simpa [Complex.normSq_apply,x,y,← pow_two] using
      add_le_add_right (pow_le_pow_left₀ ha hab 2) (u^2)
  have h := sharp_gamma_horizontal_ordered (a+1) (b+1) u (by linarith only [ha])
    (by linarith only [hab]) (by linarith only [hb])
  have hx : (((a+1 : ℝ) : ℂ)+(u : ℂ)*I) = x+1 := by push_cast; dsimp [x]; ring
  have hy : (((b+1 : ℝ) : ℂ)+(u : ℂ)*I) = y+1 := by push_cast; dsimp [y]; ring
  rw [hx,hy,Complex.Gamma_add_one _ hx₀,Complex.Gamma_add_one _ hy₀,norm_mul,norm_mul,
    show b+1-(a+1) = b-a by ring] at h
  change ‖Complex.Gamma y‖/‖Complex.Gamma x‖ ≤ _
  apply le_trans _ h
  rw [mul_div_mul_comm]
  have hunit : 1 ≤ ‖y‖/‖x‖ := (one_le_div (norm_pos_iff.mpr hx₀)).2 hxy
  exact le_mul_of_one_le_left (by positivity) hunit

private theorem gamma_real_factor_ratio_left (σ t : ℝ) (hσ : σ ∈ Icc (0 : ℝ) (1/2))
    (ht : 2 ≤ |t|) :
    let s := (σ : ℂ)+(t : ℂ)*I
    0 < ‖Gammaℝ s‖ ∧
    0 < ‖Gammaℝ (1-s)‖ ∧
    ‖Gammaℝ (1-s)‖/‖Gammaℝ s‖ ≤
      2*Real.exp (59+|Real.eulerMascheroniConstant|)*|t|^(1/2-σ) := by
  dsimp only
  let s := (σ : ℂ)+(t : ℂ)*I
  let a := σ/2
  let b := (1-σ)/2
  let u := t/2
  let x := (a : ℂ)+(u : ℂ)*I
  let y := (b : ℂ)+(u : ℂ)*I
  have ht₀ : t ≠ 0 := by intro he; rw [he,abs_zero] at ht; norm_num at ht
  have hu₀ : u ≠ 0 := div_ne_zero ht₀ (by norm_num)
  have ha : 0 ≤ a := by dsimp [a]; linarith only [hσ.1]
  have hab : a ≤ b := by dsimp [a,b]; linarith only [hσ.2]
  have hb : b ≤ 1/2 := by dsimp [b]; linarith only [hσ.1]
  have hπ : 0 < Real.pi := Real.pi_pos
  have h1π : 1 ≤ Real.pi := by linarith only [Real.pi_gt_three]
  have hx : s/2 = x := by dsimp [s,x,a,u]; push_cast; ring
  have hy : (1-s)/2 = (starRingEnd ℂ) y := by
    have hey : (b : ℂ)+((-u : ℝ) : ℂ)*I = star y := by simp [y]
    rw [Complex.star_def] at hey
    rw [← hey]
    dsimp [s,b,u]
    push_cast
    ring
  have hGx : 0 < ‖Complex.Gamma x‖ := gamma_norm_nonzero_of_nonnegative
    (by simp [x,ha]) (by intro he; have h := congrArg Complex.im he; simp [x] at h; exact hu₀ h)
  have hGy : 0 < ‖Complex.Gamma y‖ := gamma_norm_nonzero_of_nonnegative
    (by simpa [y] using ha.trans hab)
    (by intro he; have h := congrArg Complex.im he; simp [y] at h; exact hu₀ h)
  have hX : ‖Gammaℝ s‖ = Real.pi^(-a)*‖Complex.Gamma x‖ := by
    rw [Gammaℝ_def,norm_mul,show -s/2 = -(s/2) by ring,hx,norm_cpow_eq_rpow_re_of_pos hπ]
    simp [x]
  have hY : ‖Gammaℝ (1-s)‖ = Real.pi^(-b)*‖Complex.Gamma y‖ := by
    rw [Gammaℝ_def,norm_mul,show -(1-s)/2 = -((1-s)/2) by ring,hy,
      norm_cpow_eq_rpow_re_of_pos hπ,Gamma_conj,Complex.norm_conj]
    simp [y]
  change 0 < ‖Gammaℝ s‖ ∧ 0 < ‖Gammaℝ (1-s)‖ ∧ _
  rw [hX,hY]
  refine ⟨by positivity,by positivity,?_⟩
  rw [mul_div_mul_comm, ← Real.rpow_sub hπ]
  have he := gamma_norm_ratio_on_strip a b u ha hab hb hu₀
  change ‖Complex.Gamma y‖/‖Complex.Gamma x‖ ≤ _ at he
  have hp : Real.pi^(-b - -a) ≤ 1 := Real.rpow_le_one_of_one_le_of_nonpos h1π (by linarith only [hab])
  have hx' := mul_le_mul hp he (by positivity) (by positivity : (0 : ℝ) ≤ 1)
  rw [one_mul] at hx'
  apply hx'.trans
  have hbd : b-a ≤ 1 := by linarith only [ha,hb]
  have hC : Real.exp ((59+|Real.eulerMascheroniConstant|)*(b-a)) ≤
      Real.exp (59+|Real.eulerMascheroniConstant|) := Real.exp_le_exp.mpr (by
        have h := mul_le_mul_of_nonneg_left hbd
          (show 0 ≤ 59+|Real.eulerMascheroniConstant| by positivity)
        simpa only [mul_one] using h)
  have hu : |u|+2 ≤ 2*|t| := by
    dsimp only [u]
    rw [abs_div,abs_of_nonneg (by norm_num : (0 : ℝ) ≤ 2)]
    linarith only [ht]
  have hpower : (|u|+2)^(b-a) ≤ 2*|t|^(b-a) := by
    apply (Real.rpow_le_rpow (by positivity) hu (sub_nonneg.mpr hab)).trans
    rw [Real.mul_rpow (by norm_num) (abs_nonneg _)]
    apply mul_le_mul_of_nonneg_right _ (by positivity)
    simpa only [Real.rpow_one] using
      Real.rpow_le_rpow_of_exponent_le (show (1 : ℝ) ≤ 2 by norm_num) hbd
  have hv := mul_le_mul hC hpower (by positivity) (by positivity)
  have hd : b-a = 1/2-σ := by dsimp [a,b]; ring
  exact hv.trans_eq (by rw [hd]; ring)

private theorem riemannZeta_weyl_left :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (0 : ℝ) (1/2), ∀ t : ℝ, 2 ≤ |t| →
      ‖riemannZeta ((σ : ℂ)+(t : ℂ)*I)‖ ≤ C*|t|^(1/2-2*σ/3)*(1+Real.log |t|) := by
  obtain ⟨P,hP,hp⟩ := riemannZeta_weyl_strip
  let D := 2*Real.exp (59+|Real.eulerMascheroniConstant|)
  have hD : 0 < D := by dsimp [D]; positivity
  refine ⟨D*P,by positivity,?_⟩
  intro σ hσ t ht
  let s := (σ : ℂ)+(t : ℂ)*I
  let r := 1-s
  have hsim : s.im = t := by simp [s]
  have hrim : r.im = -t := by simp [r,hsim]
  have ht₀ : t ≠ 0 := by intro he; rw [he,abs_zero] at ht; norm_num at ht
  have hs₀ : s ≠ 0 := by intro he; rw [he,zero_im] at hsim; exact ht₀ hsim.symm
  have hr₀ : r ≠ 0 := by intro he; rw [he,zero_im] at hrim; exact ht₀ (neg_eq_zero.mp hrim.symm)
  obtain ⟨hgs,hgr,hg⟩ := gamma_real_factor_ratio_left σ t hσ ht
  change 0 < ‖Gammaℝ s‖ at hgs
  change 0 < ‖Gammaℝ r‖ at hgr
  change ‖Gammaℝ r‖/‖Gammaℝ s‖ ≤ D*|t|^(1/2-σ) at hg
  have he : riemannZeta s = Gammaℝ r/Gammaℝ s*riemannZeta r := by
    rw [riemannZeta_def_of_ne_zero hs₀,riemannZeta_def_of_ne_zero hr₀,
      ← completedRiemannZeta_one_sub s]
    change completedRiemannZeta r/Gammaℝ s =
      Gammaℝ r/Gammaℝ s*(completedRiemannZeta r/Gammaℝ r)
    field_simp [norm_pos_iff.mp hgs,norm_pos_iff.mp hgr]
  have hr : r = ((1-σ : ℝ) : ℂ)+((-t : ℝ) : ℂ)*I := by dsimp [r,s]; push_cast; ring
  have hbound := hp (1-σ) ⟨by linarith only [hσ.2],by linarith only [hσ.1]⟩ (-t)
    (by simpa only [abs_neg] using ht)
  rw [← hr,abs_neg,show (1-(1-σ))/3 = σ/3 by ring] at hbound
  calc
    _ = (‖Gammaℝ r‖/‖Gammaℝ s‖)*‖riemannZeta r‖ := by change ‖riemannZeta s‖ = _; rw [he,norm_mul,norm_div]
    _ ≤ (D*|t|^(1/2-σ))*(P*|t|^(σ/3)*(1+Real.log |t|)) := mul_le_mul hg hbound (norm_nonneg _)
      (by positivity)
    _ = _ := by
      have h : |t|^(1/2-σ)*|t|^(σ/3) = |t|^(1/2-2*σ/3) := by
        rw [← Real.rpow_add (by linarith only [ht] : 0 < |t|)]
        congr 1
        ring
      calc
        _ = (D*P)*(|t|^(1/2-σ)*|t|^(σ/3))*(1+Real.log |t|) := by ring
        _ = _ := by rw [h]

/-- The two Weyl exponents give one bound on the entire closed critical strip. -/
theorem riemannZeta_weyl_full_strip :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (0 : ℝ) 1, ∀ t : ℝ, 2 ≤ |t| →
      ‖riemannZeta ((σ : ℂ)+(t : ℂ)*I)‖ ≤
        C*|t|^(max ((1-σ)/3) (1/2-2*σ/3))*(1+Real.log |t|) := by
  obtain ⟨P,hP,hp⟩ := riemannZeta_weyl_left
  obtain ⟨Q,hQ,hq⟩ := riemannZeta_weyl_strip
  refine ⟨P+Q,by positivity,?_⟩
  intro σ hσ t ht
  have hlog : 0 ≤ 1+Real.log |t| := by linarith only [Real.log_nonneg (show 1 ≤ |t| by linarith only [ht])]
  have hpow (a b : ℝ) (h : a ≤ b) : |t|^a ≤ |t|^b :=
    Real.rpow_le_rpow_of_exponent_le (by linarith only [ht]) h
  by_cases hs : σ ≤ 1/2
  · exact (hp σ ⟨hσ.1,hs⟩ t ht).trans
      (mul_le_mul_of_nonneg_right (mul_le_mul (by linarith only [hQ])
        (hpow _ _ (le_max_right _ _)) (by positivity) (by positivity)) hlog)
  · exact (hq σ ⟨(le_of_not_ge hs),hσ.2⟩ t ht).trans
      (mul_le_mul_of_nonneg_right (mul_le_mul (by linarith only [hP])
        (hpow _ _ (le_max_left _ _)) (by positivity) (by positivity)) hlog)

end Legendre.Zeta
