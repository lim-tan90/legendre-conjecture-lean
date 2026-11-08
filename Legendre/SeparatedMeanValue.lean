/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The twisted-kernel norm argument generalizes the attributed openai/math
SievePhaseGram.lean argument at commit 4eaee87548250b2682affda7d05d947c05554bae.
See licenses/openai-math-Apache-2.0.txt and docs/openai-math-provenance.md.
-/
module

public import Legendre.ReciprocalHilbert
public import Legendre.ExponentialMeanValue

/-!
# Mean-square cancellation with a reciprocal-separation error

The real-line Hilbert bound gives an error 2π/δ times coefficient energy,
uniformly in the endpoints, whenever distinct frequencies are δ-separated.
-/

@[expose] public section

namespace Legendre.Density

open Complex MeasureTheory

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Endpoint Hilbert form after twisting coefficients by unit phases. -/
noncomputable def hilbertPhaseSum (ν : ι → ℝ) (a : ι → ℂ) (t : ℝ) : ℂ :=
  ∑ m, ∑ n, a m*star (a n)*realPhase (ν m-ν n) t*
    (LargeSieve.reciprocalKernel (ν m) (ν n) : ℂ)

/-- The endpoint form has a uniform bound, without an absolute-value row-sum loss. -/
theorem norm_hilbertPhaseSum_le (ν : ι → ℝ) (a : ι → ℂ) {δ : ℝ} (hδ : 0 < δ)
    (hν : LargeSieve.LineSeparated ν δ) (t : ℝ) :
    ‖hilbertPhaseSum ν a t‖ ≤ (Real.pi/δ)*(∑ n, ‖a n‖^2) := by
  let u := fun n => star (a n*realPhase (ν n) t)
  have he : hilbertPhaseSum ν a t =
      ∑ m, ∑ n, star (u m)*(LargeSieve.reciprocalKernel (ν m) (ν n) : ℂ)*u n := by
    unfold hilbertPhaseSum
    apply Finset.sum_congr rfl
    intro m hm
    apply Finset.sum_congr rfl
    intro n hn
    simp only [u,star_star,star_mul]
    rw [← realPhase_mul_conj]
    ring
  rw [he]
  simpa only [u,norm_star,norm_mul,norm_realPhase,mul_one] using
    LargeSieve.reciprocal_hilbert_bound ν hδ hν u

/-- Exact diagonal plus the difference of the two endpoint Hilbert forms. -/
theorem integral_exponentialSum_hilbert_decomposition (ν : ι → ℝ) (a : ι → ℂ)
    {δ : ℝ} (hδ : 0 < δ) (hν : LargeSieve.LineSeparated ν δ) (A B : ℝ) :
    Complex.ofReal (∫ t : ℝ in A..B, ‖exponentialSum Finset.univ a ν t‖^2) =
      Complex.ofReal ((B-A)*coefficientEnergy Finset.univ a)+
        I⁻¹*(hilbertPhaseSum ν a B-hilbertPhaseSum ν a A) := by
  have hinj := LargeSieve.lineSeparated_injective ν hδ hν
  have hterm (m n : ι) : a m*star (a n)*oscillatoryKernel (ν m-ν n) A B =
      (if m = n then Complex.ofReal ((B-A)*‖a m‖^2) else 0)+
        I⁻¹*a m*star (a n)*(realPhase (ν m-ν n) B-realPhase (ν m-ν n) A)*
          (LargeSieve.reciprocalKernel (ν m) (ν n) : ℂ) := by
    by_cases he : m = n
    · subst n
      simp only [sub_self,oscillatoryKernel_zero,LargeSieve.reciprocalKernel_self,
        ofReal_zero,mul_zero,add_zero,ite_true]
      rw [show a m*star (a m) = (‖a m‖^2 : ℂ) from mul_conj' _]
      push_cast
      ring
    · have hdiff : ν m-ν n ≠ 0 := fun hz => he (hinj (sub_eq_zero.1 hz))
      rw [ite_eq_right he,zero_add,oscillatoryKernel_eq hdiff]
      simp only [LargeSieve.reciprocalKernel,ofReal_inv,ofReal_sub,div_eq_mul_inv,mul_inv_rev]
      ring
  rw [integral_exponentialSum_norm_sq]
  simp_rw [hterm,Finset.sum_add_distrib]
  have hdiag : (∑ m, ∑ n, if m = n then Complex.ofReal ((B-A)*‖a m‖^2) else 0) =
      Complex.ofReal ((B-A)*coefficientEnergy Finset.univ a) := by
    simp only [Finset.sum_ite_eq,Finset.mem_univ,ite_true,coefficientEnergy,
      ofReal_mul,ofReal_sum,Finset.mul_sum]
  rw [hdiag]
  congr 1
  calc
    _ = ∑ m, ∑ n, I⁻¹*(
        a m*star (a n)*realPhase (ν m-ν n) B*(LargeSieve.reciprocalKernel (ν m) (ν n) : ℂ)-
        a m*star (a n)*realPhase (ν m-ν n) A*(LargeSieve.reciprocalKernel (ν m) (ν n) : ℂ)) := by
      apply Finset.sum_congr rfl
      intro m hm
      apply Finset.sum_congr rfl
      intro n hn
      ring
    _ = _ := by simp only [mul_sub,Finset.sum_sub_distrib,← Finset.mul_sum,hilbertPhaseSum]

/-- Uniform endpoint-independent mean-square error for separated real frequencies. -/
theorem abs_integral_exponentialSum_sub_diagonal_le_separation (ν : ι → ℝ) (a : ι → ℂ)
    {δ : ℝ} (hδ : 0 < δ) (hν : LargeSieve.LineSeparated ν δ) (A B : ℝ) :
    |(∫ t : ℝ in A..B, ‖exponentialSum Finset.univ a ν t‖^2)-
      (B-A)*coefficientEnergy Finset.univ a| ≤ (2*Real.pi/δ)*coefficientEnergy Finset.univ a := by
  have he := integral_exponentialSum_hilbert_decomposition ν a hδ hν A B
  have ht := norm_hilbertPhaseSum_le ν a hδ hν B
  have hb := norm_hilbertPhaseSum_le ν a hδ hν A
  have hc : Complex.ofReal ((∫ t : ℝ in A..B, ‖exponentialSum Finset.univ a ν t‖^2)-
      (B-A)*coefficientEnergy Finset.univ a) = I⁻¹*(hilbertPhaseSum ν a B-hilbertPhaseSum ν a A) := by
    rw [ofReal_sub,he]
    ring
  have hn := norm_sub_le (hilbertPhaseSum ν a B) (hilbertPhaseSum ν a A)
  have hnorm : ‖I⁻¹*(hilbertPhaseSum ν a B-hilbertPhaseSum ν a A)‖ ≤
      (2*Real.pi/δ)*coefficientEnergy Finset.univ a := by
    rw [norm_mul,norm_inv,norm_I,inv_one,one_mul]
    dsimp [coefficientEnergy]
    calc
      _ ≤ (Real.pi/δ)*(∑ n, ‖a n‖^2)+(Real.pi/δ)*(∑ n, ‖a n‖^2) :=
        hn.trans (add_le_add ht hb)
      _ = _ := by ring
  rw [← hc,norm_real,Real.norm_eq_abs] at hnorm
  exact hnorm

end Legendre.Density
