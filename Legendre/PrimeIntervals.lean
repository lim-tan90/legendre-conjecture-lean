/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PrimeNumberTheorem
public import Legendre.ExplicitBounds

/-!
# Prime intervals from the classical PNT error

Original downstream deductions from the audited PNT. The interval length is
x exp(-c sqrt(log x)), with an existential positive c and threshold. It is
sublinear but larger than every fixed x^a with a<1. No polynomial
short-interval exponent is inferred.
-/

@[expose] public section

namespace Legendre.PNT

open Filter Topology Asymptotics Real

/-- The classical error scale is positive at every positive argument. -/
theorem classicalError_pos (c : ℝ) {x : ℝ} (hx : 0 < x) : 0 < classicalError c x :=
  mul_pos hx (exp_pos _)

/-- Across [x,2x], the error grows by at most a factor two when c≥0. -/
theorem classicalError_le_two_mul {c x y : ℝ} (hc : 0 ≤ c) (hx : 0 < x)
    (hxy : x ≤ y) (hy : y ≤ 2*x) : classicalError c y ≤ 2*classicalError c x := by
  have hs := Real.sqrt_le_sqrt (Real.log_le_log hx hxy)
  have he := Real.exp_le_exp.mpr (mul_le_mul_of_nonpos_left hs (neg_nonpos.2 hc))
  calc
    _ ≤ y*exp (-c*sqrt (log x)) := mul_le_mul_of_nonneg_left he (hx.le.trans hxy)
    _ ≤ (2*x)*exp (-c*sqrt (log x)) := mul_le_mul_of_nonneg_right hy (exp_pos _).le
    _ = _ := by unfold classicalError; ring

/-- Endpoint theta errors force a prime in a controlled classical-error interval. -/
theorem hasPrimeIn_of_classical_theta_error {c C x : ℝ} (hc : 0 ≤ c) (hC : 0 ≤ C)
    (hx : 0 < x) (hwidth : (3*C+1)*classicalError c x ≤ x)
    (hleft : |Chebyshev.theta x-x| ≤ C*classicalError c x)
    (hright : |Chebyshev.theta (x+(3*C+1)*classicalError c x)-
        (x+(3*C+1)*classicalError c x)| ≤
      C*classicalError c (x+(3*C+1)*classicalError c x)) :
    HasPrimeIn x ((3*C+1)*classicalError c x) := by
  have hE := classicalError_pos c hx
  have hK : 0 < 3*C+1 := by positivity
  have hlen : 0 ≤ (3*C+1)*classicalError c x := by positivity
  have he := classicalError_le_two_mul hc hx (by linarith : x ≤ x+(3*C+1)*classicalError c x)
    (by linarith : x+(3*C+1)*classicalError c x ≤ 2*x)
  apply hasPrimeIn_of_theta_gap hx.le hlen
  have hl := (abs_le.1 hleft).2
  have hr := (abs_le.1 hright).1
  have hb := mul_le_mul_of_nonneg_left he hC
  nlinarith

/-- A theta error at the classical rate yields eventual prime intervals at the same rate. -/
theorem eventually_hasPrimeIn_of_theta_classical_error {c : ℝ} (hc : 0 < c)
    (hθ : (fun x : ℝ => Chebyshev.theta x-x) =O[atTop] classicalError c) :
    ∃ K > 0, ∀ᶠ x : ℝ in atTop, HasPrimeIn x (K*classicalError c x) := by
  obtain ⟨C,hC,hbound⟩ := isBigO_iff'.1 hθ
  let K := 3*C+1
  have hK : 0 < K := by dsimp [K]; positivity
  obtain ⟨X,hX⟩ := eventually_atTop.1 hbound
  have hsmall := ((classicalError_isLittleO hc).const_mul_left K).def (by norm_num : (0 : ℝ) < 1)
  refine ⟨K,hK,?_⟩
  filter_upwards [eventually_ge_atTop X,eventually_gt_atTop (0 : ℝ),hsmall] with x hxX hx hsm
  have hE := classicalError_pos c hx
  have hlen : 0 ≤ K*classicalError c x := by positivity
  have hw : K*classicalError c x ≤ x := by
    simpa only [Real.norm_eq_abs,abs_of_nonneg hlen,abs_of_pos hx,one_mul] using hsm
  have hb (y : ℝ) (hy : X ≤ y) (hyp : 0 < y) :
      |Chebyshev.theta y-y| ≤ C*classicalError c y := by
    simpa only [Real.norm_eq_abs,abs_of_pos (classicalError_pos c hyp)] using hX y hy
  exact hasPrimeIn_of_classical_theta_error hc.le hC.le hx hw (hb x hxX hx)
    (hb (x+K*classicalError c x) (by linarith) (by linarith))

/-- A decrease in the decay constant absorbs any fixed multiplicative coefficient. -/
theorem eventually_mul_classicalError_le {c d : ℝ} (hdc : d < c) (K : ℝ) :
    ∀ᶠ x : ℝ in atTop, K*classicalError c x ≤ classicalError d x := by
  have ht : Tendsto (fun x : ℝ => exp ((c-d)*sqrt (log x))) atTop atTop :=
    tendsto_exp_atTop.comp ((tendsto_sqrt_atTop.comp tendsto_log_atTop).const_mul_atTop
      (sub_pos.2 hdc))
  filter_upwards [ht.eventually_ge_atTop K,eventually_ge_atTop (0 : ℝ)] with x hx hx0
  calc
    _ ≤ exp ((c-d)*sqrt (log x))*classicalError c x :=
      mul_le_mul_of_nonneg_right hx (mul_nonneg hx0 (exp_pos _).le)
    _ = _ := by
      unfold classicalError
      rw [mul_left_comm,← exp_add]
      congr 2
      ring

/-- Unconditional classical PNT with a coefficient-explicit eventual prime interval. -/
theorem pnt_classical_error_with_prime_intervals : ∃ c > 0, ∃ K > 0,
    ((fun x : ℝ => Chebyshev.psi x-x) =O[atTop] classicalError c) ∧
    ((fun x : ℝ => Chebyshev.theta x-x) =O[atTop] classicalError c) ∧
    ((fun x : ℝ => primeCount x-logarithmicIntegral x) =O[atTop] classicalError c) ∧
    classicalError c =o[atTop] (fun x : ℝ => x) ∧
    (∀ᶠ x : ℝ in atTop, HasPrimeIn x (K*classicalError c x)) := by
  obtain ⟨c,hc,hψ,hθ,hπ⟩ := pnt_classical_error
  obtain ⟨K,hK,hinterval⟩ := eventually_hasPrimeIn_of_theta_classical_error hc hθ
  exact ⟨c,hc,K,hK,hψ,hθ,hπ,classicalError_isLittleO hc,hinterval⟩

/-- Eventually every interval (x,x+x exp(-c sqrt(log x))] contains a prime.
The decay constant and threshold are existential; the coefficient is one. -/
theorem pnt_hasPrimeIn_classical_interval : ∃ c > 0, ∃ X ≥ (1 : ℝ),
    ∀ x : ℝ, X ≤ x → HasPrimeIn x (classicalError c x) := by
  obtain ⟨c,hc,K,_hK,_hψ,_hθ,_hπ,_hsub,hinterval⟩ := pnt_classical_error_with_prime_intervals
  have hcmp := eventually_mul_classicalError_le (show c/2 < c by linarith) K
  obtain ⟨X,hX⟩ := eventually_atTop.1 (hinterval.and hcmp)
  refine ⟨c/2,by positivity,max X 1,le_max_right _ _,fun x hx => ?_⟩
  have hd := hX x ((le_max_left _ _).trans hx)
  exact hd.1.mono hd.2

/-- Fixed positive relative interval lengths follow from the same sublinear bound. -/
theorem eventually_hasPrimeIn_relative {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ x : ℝ in atTop, HasPrimeIn x (ε*x) := by
  obtain ⟨c,hc,X,_hX1,hX⟩ := pnt_hasPrimeIn_classical_interval
  filter_upwards [eventually_ge_atTop X,eventually_gt_atTop (0 : ℝ),
    (classicalError_isLittleO hc).def hε] with x hx hx0 hb
  have hcmp : classicalError c x ≤ ε*x := by
    simpa only [Real.norm_eq_abs,abs_of_pos (classicalError_pos c hx0),abs_of_pos hx0] using hb
  exact (hX x hx).mono hcmp

/-- A power x^a, a<1, is eventually bounded above by the classical error scale. -/
theorem eventually_rpow_le_classicalError (c : ℝ) {a : ℝ} (ha : a < 1) :
    ∀ᶠ x : ℝ in atTop, x^a ≤ classicalError c x := by
  have hs : Tendsto (fun x : ℝ => sqrt (log x)) atTop atTop :=
    tendsto_sqrt_atTop.comp tendsto_log_atTop
  filter_upwards [hs.eventually_ge_atTop (c/(1-a)),eventually_gt_atTop (1 : ℝ)] with x hx hx1
  have hl : 0 ≤ log x := (log_pos hx1).le
  have hden : 0 < 1-a := by linarith
  have hc : c ≤ (1-a)*sqrt (log x) := by
    have h := (div_le_iff₀ hden).1 hx
    nlinarith
  have hm := mul_le_mul_of_nonneg_right hc (sqrt_nonneg (log x))
  rw [mul_assoc,mul_self_sqrt hl] at hm
  rw [classicalError,← exp_log (by linarith : 0 < x),← exp_add]
  rw [rpow_def_of_pos (exp_pos _),log_exp]
  apply exp_le_exp.mpr
  nlinarith

/-- The classical PNT error scale dominates every fixed sublinear power asymptotically. -/
theorem rpow_isLittleO_classicalError (c : ℝ) {a : ℝ} (ha : a < 1) :
    (fun x : ℝ => x^a) =o[atTop] classicalError c := by
  let b := (a+1)/2
  have hab : a < b := by dsimp [b]; linarith
  have hb : b < 1 := by dsimp [b]; linarith
  have hpower : (fun x : ℝ => x^a) =o[atTop] (fun x : ℝ => x^b) := by
    apply (isLittleO_iff_tendsto' (by
      filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx hz
      simp [(rpow_pos_of_pos hx b).ne'] at hz)).2
    have ht := tendsto_rpow_neg_atTop (sub_pos.2 hab)
    apply ht.congr'
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
    rw [← rpow_sub hx]
    congr 1
    ring
  apply hpower.trans_isBigO
  apply IsBigO.of_bound 1
  filter_upwards [eventually_rpow_le_classicalError c hb,eventually_gt_atTop (0 : ℝ)] with x hx hx0
  simpa only [Real.norm_eq_abs,abs_of_pos (rpow_pos_of_pos hx0 b),
    abs_of_pos (classicalError_pos c hx0),one_mul] using hx

/-- The classical error cannot itself serve as a fixed sublinear power bound. -/
theorem classicalError_not_isBigO_rpow (c : ℝ) {a : ℝ} (ha : a < 1) :
    ¬classicalError c =O[atTop] (fun x : ℝ => x^a) := by
  apply (rpow_isLittleO_classicalError c ha).not_isBigO
  apply Filter.Eventually.frequently
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
  exact (rpow_pos_of_pos hx a).ne'

/-- The prime-interval theorem also gives a natural-number prime-gap interface. -/
theorem pnt_prime_gap_classical : ∃ c > 0, ∃ P : ℕ, ∀ p : ℕ, P ≤ p → p.Prime →
    ∃ q : ℕ, q.Prime ∧ p < q ∧ (q : ℝ)-(p : ℝ) ≤ classicalError c p := by
  obtain ⟨c,hc,X,_hX1,hX⟩ := pnt_hasPrimeIn_classical_interval
  obtain ⟨P,hP⟩ := exists_nat_ge X
  refine ⟨c,hc,P,fun p hp _hprime => ?_⟩
  have hpX : X ≤ (p : ℝ) := hP.trans (by exact_mod_cast hp)
  obtain ⟨q,hq,hpq,hupper⟩ := hX p hpX
  refine ⟨q,hq,by exact_mod_cast hpq,?_⟩
  linarith

end Legendre.PNT
