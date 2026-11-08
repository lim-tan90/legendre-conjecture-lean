/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDyadicPartition.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiFiniteMellin

@[expose] public section
namespace Legendre.Density.Moment

open scoped BigOperators Classical

 theorem moment_dyadic_partition (N J : ℕ) (hN : 1 ≤ N) (a : ℕ → ℂ) :
    (∑ n ∈ Finset.Icc 1 (2 ^ J * N), a n) =
      (∑ n ∈ Finset.Icc 1 N, a n) +
        ∑ j ∈ Finset.range J, ∑ n ∈ Finset.Ioc (2 ^ j * N) (2 ^ (j + 1) * N), a n := by
  induction J with
  | zero => simp
  | succ J ih =>
    have hM : 1 ≤ 2 ^ J * N := one_le_mul (one_le_pow₀ (by norm_num)) hN
    have hE : 2 ^ J * N ≤ 2 ^ (J + 1) * N := by rw [pow_succ]; nlinarith
    have he : Finset.Icc 1 (2 ^ (J + 1) * N) =
        Finset.Icc 1 (2 ^ J * N) ∪ Finset.Ioc (2 ^ J * N) (2 ^ (J + 1) * N) := by
      ext n
      simp only [Finset.mem_Icc, Finset.mem_union, Finset.mem_Ioc]
      omega
    have hd : Disjoint (Finset.Icc 1 (2 ^ J * N))
        (Finset.Ioc (2 ^ J * N) (2 ^ (J + 1) * N)) := by
      apply Finset.disjoint_left.mpr
      intro n hn hm
      have hn' := (Finset.mem_Icc.mp hn).2
      have hm' := (Finset.mem_Ioc.mp hm).1
      omega
    rw [he, Finset.sum_union hd, ih, Finset.sum_range_succ]
    ring

end Legendre.Density.Moment
