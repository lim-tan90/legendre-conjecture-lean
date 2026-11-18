/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GuthMaynard.SamplingMeanSquare
public import Legendre.Layer4.PolynomialBlockSampling

/-!
# Dyadic sampling with varying real parts

Abel summation reduces horizontal shifts on a dyadic block to prefixes of
a fixed-line polynomial. Montgomery's dyadic sampling estimate controls
all prefixes, with the same length and coefficient energy.
-/

@[expose] public section
namespace Legendre.Density.Moment

open Complex Set
open scoped BigOperators Classical

theorem sum_range_abel (a : ℕ → ℂ) (w : ℕ → ℝ) (m : ℕ) :
    ∑ k ∈ Finset.range m, (w k : ℂ)*a k =
      (w m : ℂ)*(∑ k ∈ Finset.range m, a k)+
      ∑ j ∈ Finset.range m, ((w j-w (j+1) : ℝ) : ℂ)*(∑ k ∈ Finset.range (j+1), a k) := by
  induction m with
  | zero => simp
  | succ m ih =>
    rw [Finset.sum_range_succ (f := fun k => (w k : ℂ)*a k), ih,
      Finset.sum_range_succ (f := fun j => ((w j-w (j+1) : ℝ) : ℂ)*
        (∑ k ∈ Finset.range (j+1), a k))]
    rw [Finset.sum_range_succ (f := a)]
    push_cast
    ring

noncomputable def dyadicHorizontalFactor (U : ℕ) (δ : ℝ) (j : ℕ) :=
  ((U : ℝ)/(U+j+1))^δ

theorem dyadicHorizontalFactor_mem (U j : ℕ) (hU : 0 < U) (δ : ℝ) (hδ : 0 ≤ δ) :
    dyadicHorizontalFactor U δ j ∈ Icc (0 : ℝ) 1 := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast hU
  have hA : (0 : ℝ) ≤ (U : ℝ)/(U+j+1) := by positivity
  have hB : (U : ℝ)/(U+j+1) ≤ 1 := (div_le_one (by positivity)).mpr (by linarith [Nat.cast_nonneg (α := ℝ) j])
  exact ⟨Real.rpow_nonneg hA _, Real.rpow_le_one hA hB hδ⟩

theorem dyadicHorizontalFactor_sub_mem (U j : ℕ) (hU : 0 < U) (δ : ℝ) (hδ : δ ∈ Icc (0 : ℝ) 1) :
    dyadicHorizontalFactor U δ j-dyadicHorizontalFactor U δ (j+1) ∈
      Icc (0 : ℝ) (1/(U : ℝ)) := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast hU
  let A := (U : ℝ)+j+1
  have hA : 0 < A := by dsimp [A]; positivity
  have hA₁ : 0 < A+1 := by positivity
  have hratio : A/(A+1) ≤ 1 := (div_le_one hA₁).mpr (le_add_of_nonneg_right zero_le_one)
  have hratio₀ : 0 ≤ A/(A+1) := by positivity
  have hfactor : dyadicHorizontalFactor U δ (j+1) =
      dyadicHorizontalFactor U δ j*(A/(A+1))^δ := by
    unfold dyadicHorizontalFactor
    change ((U : ℝ)/(U+((j+1 : ℕ) : ℝ)+1))^δ = ((U : ℝ)/A)^δ*(A/(A+1))^δ
    rw [← Real.mul_rpow (by positivity) hratio₀]
    congr 1
    push_cast
    dsimp [A]
    field_simp
    ring
  rw [hfactor, ← mul_one_sub]
  have hsub := sub_nonneg.mpr (Real.rpow_le_one hratio₀ hratio hδ.1)
  have hbound : A/(A+1) ≤ (A/(A+1))^δ := by
    have ht := Real.rpow_le_rpow_of_exponent_ge (by positivity : 0 < A/(A+1)) hratio hδ.2
    rwa [Real.rpow_one] at ht
  have hmem := dyadicHorizontalFactor_mem U j hU δ hδ.1
  refine ⟨mul_nonneg hmem.1 hsub, (mul_le_of_le_one_left hsub hmem.2).trans ?_⟩
  calc
    _ ≤ 1-A/(A+1) := sub_le_sub_left hbound _
    _ = 1/(A+1) := by field_simp; ring
    _ ≤ 1/(U : ℝ) := one_div_le_one_div_of_le hUp (by dsimp [A]; linarith [Nat.cast_nonneg (α := ℝ) j])

theorem sum_dyadic_prefix_range {E : Type*} [AddCommMonoid E]
    (f : ℕ → E) (U k : ℕ) :
    ∑ n ∈ Finset.Ioc U (U+k), f n =
      ∑ j ∈ Finset.range k, f (U+j+1) := by
  rw [show Finset.Ioc U (U+k) = Finset.Ico (U+1) (U+1+k) by
    ext n; simp only [Finset.mem_Ioc, Finset.mem_Ico]; omega,
    Finset.sum_Ico_eq_sum_range, Nat.add_sub_cancel_left]
  apply Finset.sum_congr rfl
  intro j _
  congr 1
  omega

theorem dyadic_prefix_sample_bound :
    ∃ C : ℝ, 0 < C ∧ ∀ {ι : Type*} (S : Finset ι) (t : ι → ℝ)
      (U k : ℕ) (a : ℕ → ℂ) (T : ℝ), 0 < U → k ≤ U → 1 ≤ T →
      (∀ i ∈ S, |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, ‖∑ j ∈ Finset.range k,
        a (U+j+1) * (↑(U+j+1) : ℂ)^(-(t i : ℂ)*I)‖^2) ≤
        C*(T+(U : ℝ))*coefficientEnergy (Finset.Ioc U (2*U)) a := by
  obtain ⟨C,hC,hb⟩ := GuthMaynard.montgomery_mean_value_native
  refine ⟨2*C,by positivity,?_⟩
  intro ι S t U k a T hU hk hT ht hs
  let f := fun i => t i+T
  let W := S.image f
  let b := fun n : ℕ => if n ≤ U+k then a n*(n : ℂ)^((T : ℂ)*I) else 0
  have hW : GuthMaynard.IsSeparated 1 W := by
    intro u hu v hv hne
    obtain ⟨i,hi,rfl⟩ := Finset.mem_image.mp hu
    obtain ⟨j,hj,rfl⟩ := Finset.mem_image.mp hv
    have h := hs i hi j hj (fun e => hne (congrArg f e))
    simpa only [f, Real.dist_eq, add_sub_add_right_eq_sub] using h
  have hBase : GuthMaynard.InBaseInterval (2*T) W := by
    intro u hu
    obtain ⟨i,hi,rfl⟩ := Finset.mem_image.mp hu
    have h := abs_le.mp (ht i hi)
    exact ⟨by dsimp [f]; linarith [h.1],by dsimp [f]; linarith [h.2]⟩
  have hEq (i : ι) :
      (∑ n ∈ Finset.Ioc U (2*U), b n*(n : ℂ)^(-(f i : ℂ)*I)) =
        ∑ j ∈ Finset.range k, a (U+j+1)*(↑(U+j+1) : ℂ)^(-(t i : ℂ)*I) := by
    rw [← sum_dyadic_prefix_range (fun n => a n*(n : ℂ)^(-(t i : ℂ)*I)) U k]
    have hSub : Finset.Ioc U (U+k) ⊆ Finset.Ioc U (2*U) :=
      fun n hn => Finset.mem_Ioc.mpr ⟨(Finset.mem_Ioc.mp hn).1,by
        have := (Finset.mem_Ioc.mp hn).2
        omega⟩
    rw [← Finset.sum_subset hSub (fun n hn hn' => by
      have h := Finset.mem_Ioc.mp hn
      have klt : U+k < n := Nat.lt_of_not_ge
        (fun hh => hn' (Finset.mem_Ioc.mpr ⟨h.1,hh⟩))
      simp [b, not_le.mpr klt])]
    apply Finset.sum_congr rfl
    intro n hn
    have hm := Finset.mem_Ioc.mp hn
    have hN₀ : (n : ℂ) ≠ 0 := by exact_mod_cast (show n ≠ 0 by omega)
    rw [show b n = a n*(n : ℂ)^((T : ℂ)*I) by simp [b, hm.2],
      mul_assoc, ← Complex.cpow_add _ _ hN₀]
    congr 2
    dsimp [f]
    push_cast
    ring
  have hE : (∑ n ∈ Finset.Ioc U (2*U), ‖b n‖^2) ≤
      coefficientEnergy (Finset.Ioc U (2*U)) a := by
    apply Finset.sum_le_sum
    intro n hn
    by_cases h : n ≤ U+k
    · have hn₀ : 0 < n := by have := (Finset.mem_Ioc.mp hn).1; omega
      rw [show b n = a n*(n : ℂ)^((T : ℂ)*I) by simp [b,h], norm_mul,
        norm_natCast_cpow_of_pos hn₀]
      simp
    · simp only [b,h,ite_false,norm_zero,zero_pow (by decide : 2 ≠ 0)]
      exact sq_nonneg _
  have hinj : Set.InjOn f ↑S := by
    intro i hi j hj hEq
    by_contra hne
    have h := hs i (Finset.mem_coe.mp hi) j (Finset.mem_coe.mp hj) hne
    have h' : t i = t j := add_right_cancel hEq
    norm_num [h'] at h
  calc
    _ = ∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U), b n*(n : ℂ)^(-(f i : ℂ)*I)‖^2 := by
      simp_rw [hEq]
    _ = ∑ v ∈ W, ‖∑ n ∈ Finset.Ioc U (2*U), b n*(n : ℂ)^(-(v : ℂ)*I)‖^2 :=
      (Finset.sum_image (f := fun (v : ℝ) => ‖∑ n ∈ Finset.Ioc U (2*U),
        b n*(n : ℂ)^(-(v : ℂ)*I)‖^2) hinj).symm
    _ ≤ C*(2*T+(U : ℝ))*(∑ n ∈ Finset.Ioc U (2*U), ‖b n‖^2) :=
      hb U (2*T) W b hU (by linarith) hW hBase
    _ ≤ C*(2*T+(U : ℝ))*coefficientEnergy (Finset.Ioc U (2*U)) a :=
      mul_le_mul_of_nonneg_left hE (by positivity)
    _ ≤ _ := by
      have hU₀ : (0 : ℝ) ≤ U := Nat.cast_nonneg _
      have hE₀ : 0 ≤ coefficientEnergy (Finset.Ioc U (2*U)) a := Finset.sum_nonneg (fun _ _ => sq_nonneg _)
      apply mul_le_mul_of_nonneg_right _ hE₀
      have hscale : 2*T+(U : ℝ) ≤ 2*(T+(U : ℝ)) := by linarith
      nlinarith [mul_le_mul_of_nonneg_left hscale hC.le]

theorem norm_abel_dyadic_le (U : ℕ) (hU : 0 < U) (δ : ℝ) (hδ : δ ∈ Icc (0 : ℝ) 1)
    (a : ℕ → ℂ) :
    ‖∑ j ∈ Finset.range U, (dyadicHorizontalFactor U δ j : ℂ)*a j‖^2 ≤
      2*‖∑ j ∈ Finset.range U, a j‖^2+
        (2/(U : ℝ))*∑ j ∈ Finset.range U, ‖∑ k ∈ Finset.range (j+1), a k‖^2 := by
  let w := dyadicHorizontalFactor U δ
  let P := fun j => ∑ k ∈ Finset.range j, a k
  let Q := fun j => ((w j-w (j+1) : ℝ) : ℂ)*P (j+1)
  have hU₀ : (0 : ℝ) < U := by exact_mod_cast hU
  have hA : ‖(w U : ℂ)*P U‖^2 ≤ ‖P U‖^2 := by
    rw [norm_mul, norm_real, Real.norm_eq_abs,
      abs_of_nonneg (dyadicHorizontalFactor_mem U U hU δ hδ.1).1]
    exact pow_le_pow_left₀ (mul_nonneg (dyadicHorizontalFactor_mem U U hU δ hδ.1).1 (norm_nonneg _))
      (mul_le_of_le_one_left (norm_nonneg _) (dyadicHorizontalFactor_mem U U hU δ hδ.1).2) 2
  have hB : ‖∑ j ∈ Finset.range U, Q j‖^2 ≤
      (1/(U : ℝ))*∑ j ∈ Finset.range U, ‖P (j+1)‖^2 := by
    calc
      _ ≤ (U : ℝ)*∑ j ∈ Finset.range U, ‖Q j‖^2 := by
        simpa only [Finset.card_range] using
          GuthMaynard.complex_sum_sq_le_card_mul_sum_sq (Finset.range U) Q
      _ ≤ (U : ℝ)*∑ j ∈ Finset.range U, (1/(U : ℝ))^2*‖P (j+1)‖^2 := by
        apply mul_le_mul_of_nonneg_left _ hU₀.le
        apply Finset.sum_le_sum
        intro j _
        have hj := dyadicHorizontalFactor_sub_mem U j hU δ hδ
        dsimp only [Q]
        rw [norm_mul, norm_real, Real.norm_eq_abs, abs_of_nonneg hj.1, mul_pow]
        exact mul_le_mul_of_nonneg_right (pow_le_pow_left₀ hj.1 hj.2 2) (sq_nonneg _)
      _ = _ := by rw [← Finset.mul_sum]; field_simp
  rw [sum_range_abel]
  change ‖(w U : ℂ)*P U+∑ j ∈ Finset.range U, Q j‖^2 ≤ _
  have htri := pow_le_pow_left₀ (norm_nonneg _)
    (norm_add_le ((w U : ℂ)*P U) (∑ j ∈ Finset.range U, Q j)) 2
  have hs := sq_nonneg (‖(w U : ℂ)*P U‖-‖∑ j ∈ Finset.range U, Q j‖)
  change _ ≤ 2*‖P U‖^2+(2/(U : ℝ))*∑ j ∈ Finset.range U, ‖P (j+1)‖^2
  have hB' := mul_le_mul_of_nonneg_left hB (by norm_num : (0 : ℝ) ≤ 2)
  rw [show 2*(1/(U : ℝ)*∑ j ∈ Finset.range U, ‖P (j+1)‖^2) =
    (2/(U : ℝ))*∑ j ∈ Finset.range U, ‖P (j+1)‖^2 by ring] at hB'
  nlinarith

theorem dyadic_horizontal_twist (U j : ℕ) (hU : 0 < U) (a : ℕ → ℂ) (σ β t : ℝ) :
    let n := U+j+1
    a n*(n : ℂ)^(-((β : ℂ)+(t : ℂ)*I)) =
      ((((U : ℝ)^(-(β-σ))) : ℝ) : ℂ) *
        ((dyadicHorizontalFactor U (β-σ) j : ℂ)*
          (verticalCoefficients a σ n*(n : ℂ)^(-(t : ℂ)*I))) := by
  dsimp only
  have hUp : (0 : ℝ) < U := by exact_mod_cast hU
  have hn : (0 : ℝ) < ((U+j+1 : ℕ) : ℝ) := by positivity
  have hnC : ((U+j+1 : ℕ) : ℂ) ≠ 0 := by exact_mod_cast (by omega : U+j+1 ≠ 0)
  have he : (U : ℝ)^(-(β-σ))*dyadicHorizontalFactor U (β-σ) j =
      ((U+j+1 : ℕ) : ℝ)^(-(β-σ)) := by
    unfold dyadicHorizontalFactor
    rw [Real.div_rpow hUp.le (by positivity), Real.rpow_neg hUp.le, Real.rpow_neg hn.le]
    push_cast
    have h := Real.rpow_pos_of_pos hUp (β-σ)
    field_simp
  have hC : (((U : ℝ)^(-(β-σ)) : ℝ) : ℂ)*(dyadicHorizontalFactor U (β-σ) j : ℂ) =
      ((U+j+1 : ℕ) : ℂ)^(-((β : ℂ)-σ)) := by
    rw [← ofReal_mul, he, ofReal_cpow hn.le]
    push_cast
    rfl
  rw [← mul_assoc, hC, verticalCoefficients]
  calc
    _ = a (U+j+1)*((U+j+1 : ℕ) : ℂ)^(-((β : ℂ)+(t : ℂ)*I)) := rfl
    _ = _ := by
      rw [show -((β : ℂ)+(t : ℂ)*I) =
        -((β : ℂ)-σ)+(-(σ : ℂ))+(-(t : ℂ)*I) by ring, Complex.cpow_add _ _ hnC,
        Complex.cpow_add _ _ hnC]
      ring

/-- Bounded horizontal variation on a dyadic block costs only an absolute constant. -/
theorem dyadic_variable_line_samples :
    ∃ C : ℝ, 0 < C ∧ ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
      (U : ℕ) (a : ℕ → ℂ) (T σ : ℝ), 0 < U → 1 ≤ T → 0 ≤ σ →
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, ‖∑ n ∈ Finset.Ioc U (2*U),
        a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2) ≤
        C*(T+(U : ℝ))*coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) := by
  obtain ⟨C,hC,hb⟩ := dyadic_prefix_sample_bound
  refine ⟨4*C,by positivity,?_⟩
  intro ι S t β U a T σ hU hT hσ ht hβ hs
  let b := verticalCoefficients a σ
  let P := fun (i : ι) (k : ℕ) => ∑ j ∈ Finset.range k, b (U+j+1)*(↑(U+j+1) : ℂ)^(-(t i : ℂ)*I)
  let D := C*(T+(U : ℝ))*coefficientEnergy (Finset.Ioc U (2*U)) b
  have hUp : (0 : ℝ) < U := by exact_mod_cast hU
  have hU₁ : (1 : ℝ) ≤ U := by exact_mod_cast hU
  have hdiv : 0 ≤ 2/(U : ℝ) := by positivity
  have hpref (k : ℕ) (hk : k ≤ U) : (∑ i ∈ S, ‖P i k‖^2) ≤ D :=
    hb S t U k b T hU hk hT ht hs
  have hpoint (i : ι) (hi : i ∈ S) :
      ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2 ≤
        2*‖P i U‖^2+(2/(U : ℝ))*∑ j ∈ Finset.range U, ‖P i (j+1)‖^2 := by
    have hd : β i-σ ∈ Icc (0 : ℝ) 1 := ⟨sub_nonneg.mpr (hβ i hi).1,by linarith [(hβ i hi).2]⟩
    have hUδ : (U : ℝ)^(-(β i-σ)) ≤ 1 :=
      Real.rpow_le_one_of_one_le_of_nonpos hU₁ (neg_nonpos.mpr hd.1)
    rw [show 2*U = U+U by omega,
      sum_dyadic_prefix_range (fun n => a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))) U U]
    simp_rw [dyadic_horizontal_twist U _ hU a σ (β i) (t i)]
    rw [← Finset.mul_sum, norm_mul, norm_real, Real.norm_eq_abs,
      abs_of_nonneg (Real.rpow_nonneg hUp.le _)]
    apply (pow_le_pow_left₀ (by positivity) (mul_le_of_le_one_left (norm_nonneg _) hUδ) 2).trans
    exact norm_abel_dyadic_le U hU (β i-σ) hd
      (fun j => b (U+j+1)*(↑(U+j+1) : ℂ)^(-(t i : ℂ)*I))
  calc
    _ ≤ ∑ i ∈ S, (2*‖P i U‖^2+(2/(U : ℝ))*∑ j ∈ Finset.range U, ‖P i (j+1)‖^2) :=
      Finset.sum_le_sum hpoint
    _ = 2*(∑ i ∈ S, ‖P i U‖^2)+(2/(U : ℝ))*∑ j ∈ Finset.range U, ∑ i ∈ S, ‖P i (j+1)‖^2 := by
      rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum, Finset.sum_comm (s := S)]
    _ ≤ 2*D+(2/(U : ℝ))*∑ _j ∈ Finset.range U, D := by
      apply add_le_add (mul_le_mul_of_nonneg_left (hpref U le_rfl) (by norm_num))
      exact mul_le_mul_of_nonneg_left (Finset.sum_le_sum
        (fun j hj => hpref (j+1) (Nat.succ_le_of_lt (Finset.mem_range.mp hj)))) hdiv
    _ = _ := by simp only [Finset.sum_const,Finset.card_range,nsmul_eq_mul]; dsimp [D,b]; field_simp; ring

end Legendre.Density.Moment
