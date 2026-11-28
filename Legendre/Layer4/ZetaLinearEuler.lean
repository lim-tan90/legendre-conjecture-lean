/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.ZetaWeyl

@[expose] public section
namespace Legendre.Zeta
open Complex Density.Moment Density.Oscillation

private theorem exists_dyadic_euler_cutoff {T : ℝ} (hT : 0 < T)
    {N : ℕ} (hN : 0 < N) (hNT : (N : ℝ) ≤ 2*T) :
    ∃ J : ℕ, T ≤ (2 ^ J * N : ℕ) ∧ ((2 ^ J * N : ℕ) : ℝ) ≤ 2*T := by
  have hNr : (0 : ℝ) < N := by exact_mod_cast hN
  by_cases hsmall : T ≤ N
  · exact ⟨0,by simpa using hsmall,by simpa using hNT⟩
  by_cases hmid : T ≤ 2*N
  · refine ⟨1,by simpa using hmid,?_⟩
    push_cast
    linarith only [lt_of_not_ge hsmall]
  · obtain ⟨J,hJlo,hJhi,_⟩ := real_height_dyadic_cover (T/N)
      ((le_div_iff₀ hNr).2 (by linarith only [lt_of_not_ge hmid]))
    refine ⟨J,?_,?_⟩
    · push_cast
      exact (div_le_iff₀ hNr).1 hJlo
    · push_cast
      have h := mul_le_mul_of_nonneg_right hJhi hNr.le
      exact h.trans_eq (by field_simp)

private theorem sum_sqrt_dyadic_cutoffs (N J : ℕ) :
    (∑ j ∈ Finset.range J, √((2 ^ j * N : ℕ) : ℝ)) ≤
      3*√((2 ^ J * N : ℕ) : ℝ) := by
  induction J with
  | zero => simp
  | succ J ih =>
    rw [Finset.sum_range_succ]
    have hnorm : √((2 ^ (J+1) * N : ℕ) : ℝ) = √2*√((2 ^ J * N : ℕ) : ℝ) := by
      push_cast
      rw [pow_succ,show (2 : ℝ)^J*2*(N : ℝ) = 2*(2^J*N) by ring,Real.sqrt_mul (by norm_num)]
    have hsqrt : (4/3 : ℝ) ≤ √2 := (Real.le_sqrt (by norm_num) (by norm_num)).2 (by norm_num)
    have hc := mul_le_mul_of_nonneg_right hsqrt (Real.sqrt_nonneg ((2 ^ J * N : ℕ) : ℝ))
    rw [hnorm]
    linarith only [ih,hc]

/-- On the critical line the finite zeta sum at any cutoff between the
height and twice its square has an absolute pointwise error. -/
theorem zeta_critical_finite_euler_linear_error (N : ℕ) (t : ℝ) (ht : 2 ≤ t)
    (htN : t ≤ N) (hNt : (N : ℝ) ≤ 2*t^2) :
    ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)-
      ∑ n ∈ Finset.Icc 1 N, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))‖ ≤ 4+72*Real.pi := by
  have htp : 0 < t := by linarith only [ht]
  have hN : 1 ≤ N := by exact_mod_cast (show (1 : ℝ) ≤ (N : ℝ) by linarith only [ht,htN])
  obtain ⟨J,hJlo,hJhi⟩ := exists_dyadic_euler_cutoff (sq_pos_of_pos htp)
    (show 0 < N by omega) hNt
  let M := 2^J*N
  let U := fun j : ℕ => 2^j*N
  let s := (1/2 : ℂ)+(t : ℂ)*I
  let f := fun n : ℕ => (n : ℂ)^(-s)
  let P := fun n : ℕ => ∑ k ∈ Finset.Icc 1 n, f k
  have hU (j : ℕ) : 1 ≤ U j := one_le_mul (one_le_pow₀ (by norm_num)) hN
  have hPN : P M-P N =
      ∑ j ∈ Finset.range J, ∑ n ∈ Finset.Ioc (U j) (U (j+1)), f n := by
    have hh := moment_dyadic_partition N J hN f
    change P M = P N+_ at hh
    rw [hh, add_sub_cancel_left]
  have hbound (j : ℕ) (hj : j ∈ Finset.range J) :
      ‖∑ n ∈ Finset.Ioc (U j) (U (j+1)), f n‖ ≤ 12*Real.pi*√(U j : ℝ)/t := by
    have h₂ : U (j+1) = 2*U j := by dsimp only [U]; rw [pow_succ]; ring
    have hn : N ≤ U j := le_mul_of_one_le_left (Nat.zero_le _) (one_le_pow₀ (by norm_num))
    rw [h₂]
    exact critical_block_first_derivative _ _ (hU j) (by omega) le_rfl t htp
      (htN.trans (by exact_mod_cast hn))
  have hsqrtM : √(M : ℝ) ≤ 2*t := by
    have hs := Real.sqrt_le_sqrt (show (M : ℝ) ≤ (2*t)^2 by
      change (M : ℝ) ≤ 2*t^2 at hJhi
      nlinarith only [hJhi,sq_nonneg t])
    rwa [Real.sqrt_sq (by positivity : 0 ≤ 2*t)] at hs
  have hPM : ‖P M-P N‖ ≤ 72*Real.pi := by
    rw [hPN]
    apply (norm_sum_le _ _).trans
    apply (Finset.sum_le_sum hbound).trans
    have hsum : (∑ j ∈ Finset.range J, 12*Real.pi*√(U j : ℝ)/t) =
        (12*Real.pi/t)*(∑ j ∈ Finset.range J, √(U j : ℝ)) := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl (fun j _ => by ring)
    rw [hsum]
    have hb := (sum_sqrt_dyadic_cutoffs N J).trans
      (mul_le_mul_of_nonneg_left hsqrtM (by norm_num : (0 : ℝ) ≤ 3))
    have h := mul_le_mul_of_nonneg_left hb (show 0 ≤ 12*Real.pi/t by positivity)
    exact h.trans_eq (by field_simp; ring)
  have hE : ‖riemannZeta s-P M‖ ≤ 4 :=
    zeta_critical_finite_euler_square_error (hU J) t (by linarith only [ht]) hJlo hJhi
  change ‖riemannZeta s-P N‖ ≤ _
  rw [show riemannZeta s-P N = (riemannZeta s-P M)+(P M-P N) by ring]
  exact (norm_add_le _ _).trans (add_le_add hE hPM)

end Legendre.Zeta
