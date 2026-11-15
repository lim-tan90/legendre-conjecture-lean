/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local Abel transfers for actual complex blocks, with general Weyl and
second-derivative inputs. No arithmetic coefficient estimate is assumed.
-/
module
public import Legendre.Layer4.Exponential.GeneralLogWeyl
public import Legendre.Layer4.Exponential.LogKernel

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

/-- Block prefixes retain their exact endpoints under decreasing real weights. -/
theorem norm_sum_Ioc_smul_antitone (U V : ℕ) (hUV : U ≤ V) (w : ℕ → ℝ)
    (a : ℕ → ℂ) (B : ℝ) (hB : 0 ≤ B) (hw : ∀ n, 0 ≤ w n)
    (hanti : AntitoneOn w (Ici (U+1)))
    (hb : ∀ W : ℕ, U ≤ W → W ≤ V → ‖∑ n ∈ Finset.Ioc U W, a n‖ ≤ B) :
    ‖∑ n ∈ Finset.Ioc U V, w n • a n‖ ≤ B*w (U+1) := by
  let w' : ℕ → ℝ := fun i => w (U+1+i)
  let z : ℕ → ℂ := fun i => a (U+1+i)
  have ha : Antitone w' := by
    intro i j hij
    exact hanti (by change U+1 ≤ U+1+i; omega) (by change U+1 ≤ U+1+j; omega)
      (by omega)
  have hp (m : ℕ) (hm : m ≤ V-U) : ‖∑ n ∈ Finset.range m, z n‖ ≤ B := by
    dsimp [z]
    rw [sum_range_offset_eq_Ioc U m a]
    exact hb (U+m) (by omega) (by omega)
  have hh := norm_sum_range_smul_antitone w' z (V-U) B hB (fun n => hw _) ha hp
  have he : (∑ n ∈ Finset.range (V-U), w' n • z n) = ∑ n ∈ Finset.Ioc U V, w n • a n := by
    simpa only [w',z,Nat.add_sub_of_le hUV] using
      sum_range_offset_eq_Ioc U (V-U) (fun n => w n • a n)
  rw [he] at hh
  simpa only [w',Nat.add_zero] using hh

/-- Nonnegative real parts cost at most U^(-beta), independently of beta. -/
theorem norm_complex_block_of_prefix (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V)
    (β t B : ℝ) (hβ : 0 ≤ β) (hB : 0 ≤ B)
    (hb : ∀ W : ℕ, U ≤ W → W ≤ V →
      ‖∑ n ∈ Finset.Ioc U W, (n : ℂ)^(-(t : ℂ)*I)‖ ≤ B) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤ B*(U : ℝ)^(-β) := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hanti : AntitoneOn (fun n : ℕ => (n : ℝ)^(-β)) (Ici (U+1)) := by
    intro i hi j hj hij
    exact Real.rpow_le_rpow_of_nonpos (by exact_mod_cast (show 0 < i by change U+1 ≤ i at hi; omega))
      (by exact_mod_cast hij) (by linarith)
  have hh := norm_sum_Ioc_smul_antitone U V hUV (fun n => (n : ℝ)^(-β))
    (fun n => (n : ℂ)^(-(t : ℂ)*I)) B hB (fun n => by positivity) hanti hb
  have he : (∑ n ∈ Finset.Ioc U V, (n : ℝ)^(-β) • (n : ℂ)^(-(t : ℂ)*I)) =
      ∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I)) := by
    exact Finset.sum_congr rfl (fun n hn => real_weight_cpow n
      (lt_of_le_of_lt (Nat.zero_le U) (Finset.mem_Ioc.mp hn).1) β t)
  rw [he] at hh
  exact hh.trans (mul_le_mul_of_nonneg_left
    (Real.rpow_le_rpow_of_nonpos hUp (by norm_cast; omega) (by linarith)) hB)

/-- General-length Weyl with an independently chosen nonnegative real part. -/
theorem logarithmic_block_general_weighted (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V)
    (hV : V ≤ 2*U) (β t : ℝ) (hβ : 0 ≤ β) (ht : 1 ≤ |t|) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤
      (logarithmicWeylConstant*(Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)+
        (U : ℝ)*((U : ℝ)/|t|)^(1/4 : ℝ)+(U : ℝ)/|t|^(1/3 : ℝ)))*(U : ℝ)^(-β) := by
  have hC := logarithmicWeylConstant_pos
  exact norm_complex_block_of_prefix U V hU hUV β t _ hβ (by positivity)
    (fun W hUW hWV => logarithmic_block_general_weyl U W hU hUW (hWV.trans hV) t ht)

/-- The second-derivative input also transfers uniformly in the real part. -/
theorem logarithmic_block_second_weighted (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V)
    (hV : V ≤ 2*U) (β t : ℝ) (hβ : 0 ≤ β) (ht : t ≠ 0) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-((β : ℂ)+(t : ℂ)*I))‖ ≤
      (logarithmicSecondConstant*(Real.sqrt |t|+(U : ℝ)/Real.sqrt |t|))*(U : ℝ)^(-β) := by
  have hC := logarithmicSecondConstant_pos
  exact norm_complex_block_of_prefix U V hU hUV β t _ hβ (by positivity)
    (fun W hUW hWV => logarithmic_block_sqrt U W hU hUW (hWV.trans hV) t ht)

end Legendre.Density.Oscillation
