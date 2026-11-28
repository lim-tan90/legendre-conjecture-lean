/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.DivisorEnergy
public import Mathlib.Analysis.SumIntegralComparisons

@[expose] public section
namespace Legendre.Density.Moment
open MeasureTheory Set

private theorem sum_Icc_eq_first_add_sum_Ico_succ
    {E : Type*} [AddCommMonoid E] {N : ℕ} (hN : 1 ≤ N) (a : ℕ → E) :
    (∑ n ∈ Finset.Icc 1 N, a n) = a 1+∑ n ∈ Finset.Ico 1 N, a (n+1) := by
  have hI : Finset.Icc 1 N = insert 1 (Finset.Icc 2 N) := by
    ext n
    simp only [Finset.mem_Icc,Finset.mem_insert]
    omega
  rw [hI,Finset.sum_insert (by simp)]
  congr 1
  symm
  apply Finset.sum_bij (fun n _ => n+1)
  · intro n hn
    simp only [Finset.mem_Ico,Finset.mem_Icc] at hn ⊢
    omega
  · intro x _ y _ he
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    refine ⟨n-1, ?_, by omega⟩
    simp only [Finset.mem_Ico]
    omega
  · intros
    rfl

/-- Integral comparison for decreasing functions on a real cutoff interval.
A fractional final interval contributes at most the final discrete term. -/
theorem sum_Icc_floor_sub_integral_le {f : ℝ → ℝ} {x : ℝ} (hx : 1 ≤ x)
    (hf : AntitoneOn f (Icc 1 x)) (hn : ∀ y ∈ Icc 1 x, 0 ≤ f y) :
    0 ≤ (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, f n)-(∫ t in 1..x, f t) ∧
    (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, f n)-(∫ t in 1..x, f t) ≤ f 1 := by
  let N := ⌊x⌋₊
  have hx₀ : 0 ≤ x := zero_le_one.trans hx
  have hN : 1 ≤ N := (Nat.le_floor_iff hx₀).2 (by simpa using hx)
  have hNx : (N : ℝ) ≤ x := Nat.floor_le hx₀
  have h1N : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hI : IntegrableOn f (Icc 1 x) := hf.integrableOn_isCompact isCompact_Icc
  have hInt : IntervalIntegrable f volume 1 x :=
    (intervalIntegrable_iff_integrableOn_Icc_of_le hx).2 hI
  have hfN : AntitoneOn f (Icc 1 (N : ℝ)) := hf.mono (Icc_subset_Icc_right hNx)
  have hSub : IntervalIntegrable f volume 1 (N : ℝ) :=
    hInt.mono_set (by rw [uIcc_of_le h1N,uIcc_of_le hx]; exact Icc_subset_Icc_right hNx)
  constructor
  · rw [sub_nonneg]
    have hTail : IntervalIntegrable f volume (N : ℝ) x :=
      hInt.mono_set (by rw [uIcc_of_le hNx,uIcc_of_le hx]; exact Icc_subset_Icc_left h1N)
    rw [← intervalIntegral.integral_add_adjacent_intervals hSub hTail]
    have hUpper : (∫ y in (N : ℝ)..x, f y) ≤ f N := by
      have hh := intervalIntegral.integral_mono_on hNx hTail (intervalIntegrable_const (c := f N))
        (fun y hy => hf ⟨h1N,hNx⟩ ⟨h1N.trans hy.1,hy.2⟩ hy.1)
      rw [intervalIntegral.integral_const,smul_eq_mul] at hh
      have hnN : 0 ≤ f N := hn _ ⟨h1N,hNx⟩
      exact hh.trans (by
        have h : x-(N : ℝ) ≤ 1 := sub_le_iff_le_add.2 (by simpa only [add_comm] using (Nat.lt_floor_add_one x).le)
        simpa only [one_mul] using mul_le_mul_of_nonneg_right h hnN)
    have he : Finset.Icc 1 N = insert N (Finset.Ico 1 N) := by
      ext m
      simp only [Finset.mem_Icc,Finset.mem_Ico,Finset.mem_insert]
      omega
    rw [he,Finset.sum_insert (by simp)]
    have he' := AntitoneOn.integral_le_sum_Ico (f := f) hN (by simpa only [Nat.cast_one] using hfN)
    rw [Nat.cast_one] at he'
    simpa only [add_comm] using add_le_add he' hUpper
  · apply sub_le_iff_le_add.2
    rw [sum_Icc_eq_first_add_sum_Ico_succ hN]
    have he := AntitoneOn.sum_le_integral_Ico (f := f) hN (by simpa only [Nat.cast_one] using hfN)
    rw [Nat.cast_one] at he
    have hmono := intervalIntegral.integral_mono_interval le_rfl h1N hNx
      (ae_restrict_of_forall_mem measurableSet_Ioc (fun y hy => hn y (Ioc_subset_Icc_self hy))) hInt
    simpa only [Nat.cast_one] using add_le_add_right (he.trans hmono) (f 1)

private theorem integral_inverse_mul_log_div_pow {x : ℝ} (hx : 1 ≤ x) (k : ℕ) :
    (∫ t in (1 : ℝ)..x, (Real.log (x/t))^k/t) = (Real.log x)^(k+1)/(k+1 : ℕ) := by
  have hx₀ : 0 < x := zero_lt_one.trans_le hx
  let F := fun t : ℝ => -((Real.log (x/t))^(k+1)/(k+1 : ℕ))
  have hFD (t : ℝ) (ht : t ∈ uIcc 1 x) :
      HasDerivAt F ((Real.log (x/t))^k/t) t := by
    have ht₀ : 0 < t := zero_lt_one.trans_le
      (show 1 ≤ t from (show t ∈ Icc 1 x by simpa only [uIcc_of_le hx] using ht).1)
    have he (u : ℝ) (hu : u ≠ 0) : Real.log (x/u) = Real.log x-Real.log u :=
      Real.log_div hx₀.ne' hu
    have hlog : HasDerivAt (fun u => Real.log (x/u)) (-(t⁻¹)) t := by
      have hd := (hasDerivAt_const t (Real.log x)).sub (Real.hasDerivAt_log ht₀.ne')
      simp only [zero_sub] at hd
      apply hd.congr_of_eventuallyEq
      filter_upwards [isOpen_ne.mem_nhds ht₀.ne'] with u hu
      exact he u hu
    have h := ((hlog.pow (k+1)).div_const ((k+1 : ℕ) : ℝ)).neg
    convert h using 1
    push_cast
    have hn : (k : ℝ)+1 ≠ 0 := by positivity
    field_simp [ht₀.ne',hn]
  have hc : ContinuousOn (fun t => (Real.log (x/t))^k/t) (uIcc 1 x) := by
    rw [uIcc_of_le hx]
    have hne : ∀ t ∈ Icc (1 : ℝ) x, t ≠ 0 := fun t ht => (zero_lt_one.trans_le ht.1).ne'
    apply ContinuousOn.div _ continuousOn_id hne
    apply ContinuousOn.pow
    exact (continuousOn_const.div continuousOn_id hne).log
      (fun t ht => div_ne_zero hx₀.ne' (hne t ht))
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hFD
    (hc.intervalIntegrable)]
  simp [F,hx₀.ne']

/-- A reciprocal-weighted logarithm power has the integral main term
and at most one endpoint term of error. -/
theorem abs_inverse_log_sum_sub_main_le {x : ℝ} (hx : 1 ≤ x) (k : ℕ) :
    |(∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (Real.log (x/n))^k/n)-(Real.log x)^(k+1)/(k+1 : ℕ)| ≤
      (Real.log x)^k := by
  let f := fun t : ℝ => (Real.log (x/t))^k/t
  have hlogn (y : ℝ) (hy : y ∈ Icc 1 x) : 0 ≤ Real.log (x/y) :=
    Real.log_nonneg ((one_le_div (zero_lt_one.trans_le hy.1)).2 hy.2)
  have h0 (y : ℝ) (hy : y ∈ Icc 1 x) : 0 ≤ f y :=
    div_nonneg (pow_nonneg (hlogn y hy) _) (zero_le_one.trans hy.1)
  have hf : AntitoneOn f (Icc 1 x) := by
    intro y hy z hz hyz
    have hy₀ : 0 < y := zero_lt_one.trans_le hy.1
    have hz₀ : 0 < z := zero_lt_one.trans_le hz.1
    have hx₀ : 0 < x := zero_lt_one.trans_le hx
    have hh := Real.log_le_log (div_pos hx₀ hz₀)
      (div_le_div_of_nonneg_left hx₀.le hy₀ hyz)
    exact div_le_div₀ (pow_nonneg (hlogn y hy) _) (pow_le_pow_left₀ (hlogn z hz) hh _)
      hy₀ hyz
  obtain ⟨hn,he⟩ := sum_Icc_floor_sub_integral_le hx hf h0
  rw [integral_inverse_mul_log_div_pow hx k] at hn he
  rw [abs_of_nonneg hn]
  simpa [f] using he

end Legendre.Density.Moment
