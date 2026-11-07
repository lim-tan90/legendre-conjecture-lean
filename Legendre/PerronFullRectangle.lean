/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronOriginResidue

/-!
# A fixed negative Perron rectangle enclosing the full critical strip

The finite candidate set includes 0 and 1 and every nontrivial zero through
absolute height T. A removable origin is allowed; the residue sum remains
valid because a meromorphic non-pole has zero residue.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology Set MeasureTheory

/-- Candidate poles of the full fixed-left contour. -/
def fullPerronCandidates (T : ℝ) : Set ℂ := insert 0 (insert 1 (symmetricZeros T))

/-- The candidate set is finite, without requiring a nonzero origin residue. -/
theorem fullPerronCandidates_finite (T : ℝ) : (fullPerronCandidates T).Finite :=
  ((symmetricZeros_finite T).insert 1).insert 0

/-- A zero in the full rectangle is in the open critical strip. -/
theorem fullPerron_zero_nontrivial {σ T : ℝ} (hσ : 1 < σ) (hT : 0 ≤ T) {s : ℂ}
    (hs : s ∈ perronRectangle (-(1/8)) σ T) (hz : riemannZeta s = 0) : NontrivialZero s := by
  have hc := (mem_perronRectangle (by linarith : -(1/8 : ℝ) ≤ σ) hT s).1 hs
  refine ⟨hz,?_,?_⟩
  · by_contra hh
    exact riemannZeta_ne_zero_negative_strip (by linarith [hc.1]) (le_of_not_gt hh) hz
  · by_contra hh
    exact riemannZeta_ne_zero_of_one_le_re (le_of_not_gt hh) hz

/-- Every candidate lies in the rectangle. -/
theorem fullPerronCandidates_subset_rectangle {σ T : ℝ} (hσ : 1 < σ) (hT : 0 < T) :
    fullPerronCandidates T ⊆ perronRectangle (-(1/8)) σ T := by
  intro s hs
  rcases hs with rfl|hs
  · rw [mem_perronRectangle (by linarith) hT.le]
    simp only [zero_re,zero_im]
    exact ⟨by norm_num,by linarith,by linarith,hT.le⟩
  · rcases hs with rfl|hs
    · exact one_mem_perronRectangle (by norm_num) hσ hT
    · rw [mem_perronRectangle (by linarith) hT.le]
      exact ⟨by linarith [hs.1.2.1],by linarith [hs.1.2.2],abs_le.1 hs.2⟩

/-- Every actual pole in the full rectangle belongs to the finite candidate set. -/
theorem fullPerron_poles_subset {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ) (hT : 0 < T) :
    perronRectangle (-(1/8)) σ T ∩ {s | meromorphicOrderAt (perronIntegrand x) s < 0} ⊆
      fullPerronCandidates T := by
  rintro s ⟨hs,hpole⟩
  by_cases hs0 : s = 0
  · exact mem_insert_iff.2 (.inl hs0)
  · rcases (perronIntegrand_pole_iff hx hs0).1 hpole with hs1|hz
    · exact mem_insert_iff.2 (.inr (mem_insert_iff.2 (.inl hs1)))
    · have hN := fullPerron_zero_nontrivial hσ hT.le hs hz
      have hc := (mem_perronRectangle (by linarith : -(1/8 : ℝ) ≤ σ) hT.le s).1 hs
      exact mem_insert_iff.2 (.inr (mem_insert_iff.2 (.inr ⟨hN,abs_le.2 hc.2.2⟩)))

/-- The candidate-pole representation may include the removable origin. -/
theorem fullPerron_poles_inter_eq {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ) (hT : 0 < T) :
    perronRectangle (-(1/8)) σ T ∩ {s | meromorphicOrderAt (perronIntegrand x) s < 0} =
      fullPerronCandidates T ∩ {s | meromorphicOrderAt (perronIntegrand x) s < 0} := by
  apply Set.Subset.antisymm
  · intro s hs
    exact ⟨fullPerron_poles_subset hx hσ hT hs,hs.2⟩
  · intro s hs
    exact ⟨fullPerronCandidates_subset_rectangle hσ hT hs.1,hs.2⟩

/-- The fixed negative contour boundary excludes the origin. -/
theorem zero_not_mem_fullPerron_border {σ T : ℝ} (hσ : 1 < σ) (hT : 0 < T) :
    (0 : ℂ) ∉ RectangleBorder ((-(1/8) : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) := by
  have hσ0 : σ ≠ 0 := by linarith
  simp [RectangleBorder,mem_reProdIm,hσ0.symm,hT.ne',hT.ne]

/-- A quantitatively good height is also admissible for the full negative-left rectangle. -/
theorem fullPerron_border_nonvanishing {σ T : ℝ} (hσ : 1 < σ) (hT : 0 < T)
    (hgood : ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T) :
    ∀ s ∈ RectangleBorder ((-(1/8) : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I),
      riemannZeta s ≠ 0 := by
  intro s hs hz
  have hR : s ∈ perronRectangle (-(1/8)) σ T := by
    simpa only [perronRectangle,ofReal_neg,ofReal_div,ofReal_one,ofReal_ofNat] using! rectangleBorder_subset_rectangle _ _ hs
  have hN := fullPerron_zero_nontrivial hσ hT.le hR hz
  have hleft : s.re ≠ -(1/8) := by linarith [hN.2.1]
  have hright : s.re ≠ σ := by linarith [hN.2.2]
  have htop : s.im ≠ T := by intro he; exact hgood s hN (by rw [he,abs_of_pos hT])
  have hbottom : s.im ≠ -T := by intro he; exact hgood s hN (by rw [he,abs_neg,abs_of_pos hT])
  simp only [RectangleBorder,mem_union,mem_reProdIm,mem_singleton_iff,
    sub_re,mul_re,ofReal_re,ofReal_im,I_re,I_im,mul_zero,mul_one,sub_self,
    sub_zero,add_re,add_zero,sub_im,mul_im,zero_add,add_im,neg_re,div_re,
    one_re,re_ofNat,one_im,im_ofNat] at hs
  norm_num at hs
  rcases hs with ((h|h)|h)|h
  · exact hbottom h.2
  · exact hleft h.1
  · exact htop h.2
  · exact hright h.1

/-- The full fixed-left contour integral includes the origin correction exactly. -/
theorem fullPerronRectangle_integral_eq {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ) (hT : 0 < T)
    (hgood : ∀ s : ℂ, NontrivialZero s → |s.im| ≠ T) :
    RectangleIntegral' (perronIntegrand x) ((-(1/8) : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) =
      (x : ℂ)-truncatedZeroSum x T-logDeriv riemannZeta 0 := by
  classical
  have hpol := fullPerron_poles_inter_eq hx hσ hT
  have hfinite := (fullPerronCandidates_finite T).subset (fullPerron_poles_subset hx hσ hT)
  have hm : MeromorphicOn (perronIntegrand x) (perronRectangle (-(1/8)) σ T) :=
    fun s _hs => perronIntegrand_meromorphicAt_all hx s
  have hnoborder : Disjoint
      (RectangleBorder ((-(1/8) : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I))
      {s | meromorphicOrderAt (perronIntegrand x) s < 0} := by
    apply Set.disjoint_left.2
    intro s hs hpole
    have hs0 : s ≠ 0 := by intro he; subst s; exact zero_not_mem_fullPerron_border hσ hT hs
    have hs1 : s ≠ 1 := by
      intro he
      subst s
      exact one_not_mem_perronRectangleBorder (a := -(1/8)) (by norm_num) hσ hT (by
        simpa only [ofReal_neg,ofReal_div,ofReal_one,ofReal_ofNat] using! hs)
    have hz := fullPerron_border_nonvanishing hσ hT hgood s hs
    exact not_lt_of_ge (perronIntegrand_analyticAt hx hs0 hs1 hz).meromorphicOrderAt_nonneg hpole
  have hbound := RectangleIntegral'_eq_sumResiduesIn (f := perronIntegrand x)
    (z := (-(1/8) : ℂ)-(T : ℂ)*I) (w := (σ : ℂ)+(T : ℂ)*I)
    (by norm_num; linarith) (by simp; linarith)
    (by simpa only [perronRectangle,ofReal_neg,ofReal_div,ofReal_one,ofReal_ofNat] using hm)
    hnoborder (by simpa only [perronRectangle,ofReal_neg,ofReal_div,ofReal_one,ofReal_ofNat] using hfinite)
    (perronIntegrand_hasSimplePolesOn_all hx _)
  rw [hbound]
  have hsum := sumResiduesIn_inter_eq_of_set_eq (F := perronIntegrand x) hpol
    (fun s _hs hnot => residue_eq_zero_of_not_pole_of_meromorphicAt
      (perronIntegrand_meromorphicAt_all hx s) (le_of_not_gt hnot))
  rw [show Rectangle ((-(1/8) : ℂ)-(T : ℂ)*I) ((σ : ℂ)+(T : ℂ)*I) =
      perronRectangle (-(1/8)) σ T by simp only [perronRectangle,ofReal_neg,ofReal_div,ofReal_one,ofReal_ofNat],
    hsum,sumResiduesIn_eq_sum (fullPerronCandidates_finite T)]
  have h0 : (0 : ℂ) ∉ ((symmetricZeros_finite T).insert 1).toFinset := by
    simp [symmetricZeros,NontrivialZero]
  have h1 : (1 : ℂ) ∉ (symmetricZeros_finite T).toFinset := by
    simp [symmetricZeros,NontrivialZero]
  change (∑ s ∈ ((symmetricZeros_finite T).insert 1 |>.insert 0).toFinset,
    residue (perronIntegrand x) s) = _
  rw [Set.Finite.toFinset_insert,Finset.sum_insert h0,Set.Finite.toFinset_insert,
    Finset.sum_insert h1,residue_perronIntegrand_origin hx,residue_perronIntegrand_one hx]
  have hz : (∑ s ∈ (symmetricZeros_finite T).toFinset,residue (perronIntegrand x) s) =
      -truncatedZeroSum x T := by
    rw [truncatedZeroSum,← Finset.sum_neg_distrib]
    apply Finset.sum_congr rfl
    intro s hs
    have hN := ((symmetricZeros_finite T).mem_toFinset.1 hs).1
    have hs0 : s ≠ 0 := by intro he; have hh := hN.2.1; simp [he] at hh
    have hs1 : s ≠ 1 := by intro he; have hh := hN.2.2; simp [he] at hh
    rw [residue_perronIntegrand_at_zero hx hs0 hs1]
    ring
  rw [hz]
  ring

end Legendre.Zeta
