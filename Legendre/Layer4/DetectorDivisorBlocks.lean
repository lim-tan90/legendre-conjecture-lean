/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local exact divisor expansion of actual compact-detector blocks.
Integer division retains the endpoints (U/d,V/d], including empty ranges.
-/
module
public import Legendre.Layer4.DetectorMonotoneWeight

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex Set
open scoped BigOperators

theorem sum_Ioc_divisible {M : Type*} [AddCommMonoid M] (d U V : ℕ) (hd : 0 < d)
    (f : ℕ → M) :
    (∑ n ∈ (Finset.Ioc U V).filter (fun n => d ∣ n), f n) =
      ∑ k ∈ Finset.Ioc (U/d) (V/d), f (d*k) := by
  classical
  symm
  apply Finset.sum_bij (fun k _ => d*k)
  · intro k hk
    have hh := Finset.mem_Ioc.mp hk
    have hlo := (Nat.div_lt_iff_lt_mul hd).mp hh.1
    have hhi := (Nat.le_div_iff_mul_le hd).mp hh.2
    exact Finset.mem_filter.mpr ⟨Finset.mem_Ioc.mpr
      ⟨by simpa only [Nat.mul_comm] using hlo,by simpa only [Nat.mul_comm] using hhi⟩,⟨k,rfl⟩⟩
  · intro k hk l hl he
    exact Nat.eq_of_mul_eq_mul_left hd he
  · intro n hn
    obtain ⟨hn,hdvd⟩ := Finset.mem_filter.mp hn
    have hh := Finset.mem_Ioc.mp hn
    refine ⟨n/d,Finset.mem_Ioc.mpr ⟨?_,?_⟩,Nat.mul_div_cancel' hdvd⟩
    · apply (Nat.div_lt_iff_lt_mul hd).mpr
      simpa only [Nat.div_mul_cancel hdvd] using hh.1
    · apply (Nat.le_div_iff_mul_le hd).mpr
      simpa only [Nat.div_mul_cancel hdvd] using hh.2
  · intros
    rfl

/-- Only positive divisors up to X occur in the actual coefficient. -/
theorem detectorCoefficient_divisibility_sum (X n : ℕ) (hn : 0 < n) :
    detectorCoefficient X n =
      ∑ d ∈ Finset.Icc 1 X, if d ∣ n then mobiusCutoff X d else 0 := by
  classical
  have hset : n.divisors.filter (fun d => d ≤ X) =
      (Finset.Icc 1 X).filter (fun d => d ∣ n) := by
    ext d
    simp only [Finset.mem_filter,Nat.mem_divisors,Finset.mem_Icc]
    constructor
    · rintro ⟨⟨hd,hn0⟩,hX⟩
      exact ⟨⟨Nat.pos_of_dvd_of_pos hd hn,hX⟩,hd⟩
    · rintro ⟨⟨hd,hX⟩,hdvd⟩
      exact ⟨⟨hdvd,hn.ne'⟩,hX⟩
  rw [←Finset.sum_filter,←hset]
  unfold detectorCoefficient
  symm
  apply Finset.sum_subset (Finset.filter_subset _ _)
  intro d hd hn'
  have hnot : ¬d ≤ X := fun hh => hn' (Finset.mem_filter.mpr ⟨hd,hh⟩)
  simp only [mobiusCutoff,ite_eq_right hnot]

/-- An exact finite expansion, with no smoothness or growth assumptions on f. -/
theorem detectorCoefficient_block_expansion (X U V : ℕ) (f : ℕ → ℂ) :
    (∑ n ∈ Finset.Ioc U V, detectorCoefficient X n*f n) =
      ∑ d ∈ Finset.Icc 1 X, mobiusCutoff X d*
        ∑ k ∈ Finset.Ioc (U/d) (V/d), f (d*k) := by
  classical
  calc
    _ = ∑ n ∈ Finset.Ioc U V, ∑ d ∈ Finset.Icc 1 X,
        if d ∣ n then mobiusCutoff X d*f n else 0 := by
      apply Finset.sum_congr rfl
      intro n hn
      rw [detectorCoefficient_divisibility_sum X n
        (lt_of_le_of_lt (Nat.zero_le U) (Finset.mem_Ioc.mp hn).1),Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro d hd
      by_cases hh : d ∣ n <;> simp only [hh,ite_true,ite_false,zero_mul]
    _ = ∑ d ∈ Finset.Icc 1 X, ∑ n ∈ Finset.Ioc U V,
        if d ∣ n then mobiusCutoff X d*f n else 0 := Finset.sum_comm
    _ = _ := by
      apply Finset.sum_congr rfl
      intro d hd
      rw [←Finset.sum_filter,sum_Ioc_divisible d U V (Finset.mem_Icc.mp hd).1
        (fun n => mobiusCutoff X d*f n),Finset.mul_sum]

/-- Actual smoothed polynomial blocks retain the common divisor coefficient sequence. -/
theorem polynomial_block_divisor_expansion (X U V : ℕ) (hXU : X ≤ U) (Y : ℝ) (s : ℂ) :
    (∑ n ∈ Finset.Ioc U V, polynomialCoefficient X Y n*(n : ℂ)^(-s)) =
      ∑ d ∈ Finset.Icc 1 X, mobiusCutoff X d*(d : ℂ)^(-s)*
        ∑ k ∈ Finset.Ioc (U/d) (V/d), detectorWeight (((d*k : ℕ) : ℝ)/Y)*(k : ℂ)^(-s) := by
  have he : (∑ n ∈ Finset.Ioc U V, polynomialCoefficient X Y n*(n : ℂ)^(-s)) =
      ∑ n ∈ Finset.Ioc U V, detectorCoefficient X n*
        (detectorWeight ((n : ℝ)/Y)*(n : ℂ)^(-s)) := by
    apply Finset.sum_congr rfl
    intro n hn
    have hXn : X < n := hXU.trans_lt (Finset.mem_Ioc.mp hn).1
    rw [polynomialCoefficient,ite_eq_left hXn]
    ring
  rw [he,detectorCoefficient_block_expansion]
  apply Finset.sum_congr rfl
  intro d hd
  rw [Finset.mul_sum,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro k hk
  have hc : ((d*k : ℕ) : ℂ)^(-s) = (d : ℂ)^(-s)*(k : ℂ)^(-s) := by
    simpa only [Nat.cast_mul] using Complex.natCast_mul_natCast_cpow d k (-s)
  rw [hc]
  ring

end Legendre.Density.Detector.Smooth
