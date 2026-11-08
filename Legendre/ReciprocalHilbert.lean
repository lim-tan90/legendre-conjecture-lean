/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Generalizes the finite kernel/eigenvalue and spectral arguments adapted from
openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae:
Ostmann/Preliminaries/CosecantHilbertBound.lean and CircleSeparatedPoints.lean.
The original license is retained in licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.LargeSieve.KernelEigenvalueBound
public import Legendre.LargeSieve.HermitianNormBound
public import Legendre.LargeSieve.SeparatedSetSquares

@[expose] public section

namespace Legendre.LargeSieve

open Matrix
open scoped Matrix.Norms.L2Operator

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

def LineSeparated (x : ι → ℝ) (δ : ℝ) : Prop :=
  ∀ i j, i ≠ j → δ ≤ |x i-x j|

noncomputable def reciprocalKernel (x y : ℝ) : ℝ := (x-y)⁻¹

@[simp] theorem reciprocalKernel_self (x : ℝ) : reciprocalKernel x x = 0 := by
  simp [reciprocalKernel]

theorem reciprocalKernel_skew (x y : ℝ) : reciprocalKernel x y = -reciprocalKernel y x := by
  unfold reciprocalKernel
  rw [show x-y = -(y-x) by ring, inv_neg]

theorem reciprocalKernel_triple {x y z : ℝ} (hxy : x ≠ y) (hxz : x ≠ z) (hyz : y ≠ z) :
    reciprocalKernel x y*reciprocalKernel x z =
      reciprocalKernel y z*(reciprocalKernel x y-reciprocalKernel x z) := by
  unfold reciprocalKernel
  field_simp [sub_ne_zero.2 hxy,sub_ne_zero.2 hxz,sub_ne_zero.2 hyz]
  ring

omit [Fintype ι] in
theorem lineSeparated_injective (x : ι → ℝ) {δ : ℝ} (hδ : 0 < δ) (hx : LineSeparated x δ) :
    Function.Injective x := by
  intro i j he
  by_contra hij
  have hh := hx i j hij
  rw [he,sub_self,abs_zero] at hh
  linarith

theorem line_inverse_square_row (x : ι → ℝ) {δ : ℝ} (hδ : 0 < δ)
    (hx : LineSeparated x δ) (center : ι) :
    (∑ s, reciprocalKernel (x s) (x center)^2) ≤ Real.pi^2/(3*δ^2) := by
  let F := Finset.univ.erase center
  let r := fun s => x s-x center
  let S := F.image r
  have hfirst (s : ι) (hs : s ∈ F) : δ ≤ |r s| := hx s center (Finset.mem_erase.1 hs).1
  have hinj : Set.InjOn r F := by
    intro s hs t ht he
    apply lineSeparated_injective x hδ hx
    dsimp [r] at he
    linarith
  have hset := separated_set_inverse_squares S δ hδ (by
    intro y hy
    obtain ⟨s,hs,rfl⟩ := Finset.mem_image.1 hy
    exact hfirst s hs) (by
    intro y hy z hz hyz
    obtain ⟨s,hs,rfl⟩ := Finset.mem_image.1 hy
    obtain ⟨t,ht,rfl⟩ := Finset.mem_image.1 hz
    have hst : s ≠ t := by intro he; exact hyz (congrArg r he)
    have hh := hx s t hst
    convert! hh using 1
    congr 1
    dsimp [r]
    ring)
  have he : (∑ y ∈ S, 1/y^2) = ∑ s ∈ F, 1/(r s)^2 := Finset.sum_image hinj
  rw [he] at hset
  have hfull : (∑ s, reciprocalKernel (x s) (x center)^2) = ∑ s ∈ F, 1/(r s)^2 := by
    rw [← Finset.sum_erase_add _ _ (Finset.mem_univ center)]
    simp only [reciprocalKernel_self,zero_pow (by norm_num : (2 : ℕ) ≠ 0),add_zero]
    apply Finset.sum_congr rfl
    intro s hs
    simp only [reciprocalKernel,r,one_div,inv_pow]
  rw [hfull]
  exact hset

theorem reciprocal_row_budget (x : ι → ℝ) {δ : ℝ} (hδ : 0 < δ)
    (hx : LineSeparated x δ) (center : ι) :
    (∑ s, reciprocalKernel (x s) (x center)^2)+
      2*(∑ s, |reciprocalKernel (x center) (x s)*reciprocalKernel (x center) (x s)|) ≤
        Real.pi^2/δ^2 := by
  have he (s : ι) : |reciprocalKernel (x center) (x s)*reciprocalKernel (x center) (x s)| =
      reciprocalKernel (x s) (x center)^2 := by
    rw [← pow_two,abs_of_nonneg (sq_nonneg _),reciprocalKernel_skew (x center) (x s),neg_sq]
  simp_rw [he]
  have hb := line_inverse_square_row x hδ hx center
  have hn : 3*(Real.pi^2/(3*δ^2)) = Real.pi^2/δ^2 := by ring
  nlinarith

noncomputable def reciprocalMatrix (x : ι → ℝ) : Matrix ι ι ℂ :=
  imaginaryKernelMatrix (fun s t => reciprocalKernel (x s) (x t))

omit [Fintype ι] [DecidableEq ι] in
theorem reciprocalMatrix_hermitian (x : ι → ℝ) : (reciprocalMatrix x).IsHermitian :=
  imaginaryKernelMatrix_hermitian _ (fun _ _ => reciprocalKernel_skew _ _)

theorem reciprocal_eigenvalue_bound (x : ι → ℝ) {δ : ℝ} (hδ : 0 < δ)
    (hx : LineSeparated x δ) (μ : ℝ) (u : ι → ℂ) (hu : 0 < ∑ s, ‖u s‖^2)
    (heig : reciprocalMatrix x *ᵥ u = (μ : ℂ) • u) : μ^2 ≤ Real.pi^2/δ^2 := by
  have hinj := lineSeparated_injective x hδ hx
  exact kernel_eigenvalue_bound
    (fun s t => reciprocalKernel (x s) (x t)) (fun s t => reciprocalKernel (x s) (x t))
    (fun _ => reciprocalKernel_self _) (fun _ => reciprocalKernel_self _)
    (fun _ _ => reciprocalKernel_skew _ _) (fun _ _ => reciprocalKernel_skew _ _)
    (fun r s t hrs hrt hst => reciprocalKernel_triple
      (fun he => hrs (hinj he)) (fun he => hrt (hinj he)) (fun he => hst (hinj he)))
    (Real.pi^2/δ^2) μ (reciprocal_row_budget x hδ hx) u hu heig

theorem reciprocalMatrix_norm_bound (x : ι → ℝ) {δ : ℝ} (hδ : 0 < δ)
    (hx : LineSeparated x δ) : ‖reciprocalMatrix x‖ ≤ Real.pi/δ := by
  apply hermitian_norm_bound (reciprocalMatrix_hermitian x) (Real.pi/δ) (by positivity)
  intro i
  let hA := reciprocalMatrix_hermitian x
  have hnorm : ‖hA.eigenvectorBasis i‖ = 1 := hA.eigenvectorBasis.orthonormal.1 i
  have hu : 0 < ∑ s, ‖(hA.eigenvectorBasis i) s‖^2 := by
    rw [← EuclideanSpace.norm_sq_eq,hnorm]
    norm_num
  have hb := reciprocal_eigenvalue_bound x hδ hx (hA.eigenvalues i)
    (hA.eigenvectorBasis i) hu (hA.mulVec_eigenvectorBasis i)
  have he : Real.pi^2/δ^2 = (Real.pi/δ)^2 := by ring
  rw [he] at hb
  have hB : 0 ≤ Real.pi/δ := by positivity
  nlinarith [sq_abs (hA.eigenvalues i),abs_nonneg (hA.eigenvalues i)]

theorem reciprocal_hilbert_bound (x : ι → ℝ) {δ : ℝ} (hδ : 0 < δ)
    (hx : LineSeparated x δ) (u : ι → ℂ) :
    ‖∑ s, ∑ t, star (u s)*(reciprocalKernel (x s) (x t) : ℂ)*u t‖ ≤
      (Real.pi/δ)*(∑ s, ‖u s‖^2) := by
  have hb := matrix_quadratic_norm_bound (reciprocalMatrix x) (Real.pi/δ)
    (reciprocalMatrix_norm_bound x hδ hx) u
  have he : star u ⬝ᵥ (reciprocalMatrix x *ᵥ u) =
      Complex.I*(∑ s, ∑ t, star (u s)*(reciprocalKernel (x s) (x t) : ℂ)*u t) := by
    simp only [dotProduct,mulVec,Pi.star_apply,reciprocalMatrix,imaginaryKernelMatrix,
      Matrix.of_apply,Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro s hs
    apply Finset.sum_congr rfl
    intro t ht
    ring
  rw [he,norm_mul,Complex.norm_I,one_mul] at hb
  exact hb

end Legendre.LargeSieve
