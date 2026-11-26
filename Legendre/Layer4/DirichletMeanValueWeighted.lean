/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.GaussianMean
public import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set
open scoped ComplexConjugate

private theorem log_succ_gap_bounds {m : ℕ} (hm : 0 < m) :
    1/((m : ℝ)+1) ≤ Real.log ((m : ℝ)+1)-Real.log m ∧
      Real.log ((m : ℝ)+1)-Real.log m ≤ 1/(m : ℝ) := by
  have hmr : (0 : ℝ) < m := by exact_mod_cast hm
  constructor
  · have h := log_gap_lower hmr (show (0 : ℝ) < (m : ℝ)+1 by positivity)
    convert h using 1; ring
  · have h := Real.log_le_sub_one_of_pos
      (show (0 : ℝ) < ((m : ℝ)+1)/m by positivity)
    rw [Real.log_div (by positivity : (m : ℝ)+1 ≠ 0) hmr.ne'] at h
    convert h using 1
    field_simp
    ring

/-- A uniform logarithmic Gaussian row above the time scale. Each reciprocal
integer weight is controlled by its corresponding interval on the log axis. -/
theorem sum_log_gaussian_high_row_le (T u : ℝ) (hT : 1 ≤ T) (S : Finset ℕ)
    (hS : ∀ m ∈ S, T ≤ (m : ℝ)) :
    (∑ m ∈ S, T/(m : ℝ)*Real.exp (-(T*(Real.log m-u))^2)) ≤
      2*Real.exp 1*Real.sqrt (2*Real.pi) := by
  let g := fun x : ℝ => Real.exp (-(T*(x-u))^2/2)
  let I := fun m : ℕ => Ioc (Real.log m) (Real.log ((m : ℝ)+1))
  have hT₀ : 0 < T := by linarith
  have hg : Integrable g := by
    have hu := (integrable_exp_neg_mul_sq (b := T^2/2) (by positivity)).comp_add_right (-u)
    convert hu using 1
    funext x
    dsimp [g]
    congr 1
    ring
  have hg0 (x : ℝ) : 0 ≤ g x := (Real.exp_pos _).le
  have hgi : (∫ x : ℝ, g x) = Real.sqrt (2*Real.pi)/T := by
    have he (x : ℝ) : g x = Real.exp (-(T^2/2)*(x+(-u))^2) := by
      dsimp only [g]; congr 1; ring
    simp_rw [he]
    rw [integral_add_right_eq_self (fun x : ℝ => Real.exp (-(T^2/2)*x^2)),
      integral_gaussian (T^2/2)]
    rw [show Real.pi/(T^2/2) = (2*Real.pi)/(T^2) by ring,
      Real.sqrt_div (by positivity), Real.sqrt_sq_eq_abs, abs_of_pos hT₀]
  have hpoint (m : ℕ) (hm : m ∈ S) :
      T/(m : ℝ)*Real.exp (-(T*(Real.log m-u))^2) ≤
        2*Real.exp 1*T*(∫ x in I m, g x) := by
    have hm₁ : (1 : ℝ) ≤ m := hT.trans (hS m hm)
    have hm₀ : (0 : ℝ) < m := zero_lt_one.trans_le hm₁
    have hmN : 0 < m := by exact_mod_cast hm₀
    let a := Real.log m
    let b := Real.log ((m : ℝ)+1)
    let v := Real.exp (-(T*(a-u))^2)
    have hgap := log_succ_gap_bounds hmN
    have hab : a ≤ b := by dsimp [a,b]; linarith [hgap.1, show 0 ≤ 1/((m : ℝ)+1) by positivity]
    have hgl (x : ℝ) (hx : x ∈ I m) : v ≤ Real.exp 1*g x := by
      have hxa : 0 ≤ T*(x-a) := mul_nonneg hT₀.le (sub_nonneg.mpr hx.1.le)
      have hxb : T*(x-a) ≤ 1 := by
        have hl := mul_le_mul_of_nonneg_left (sub_le_sub_right hx.2 a) hT₀.le
        have hu := mul_le_mul_of_nonneg_left hgap.2 hT₀.le
        have hunit : T*(1/(m : ℝ)) ≤ 1 := by
          rw [mul_one_div]
          exact (div_le_one hm₀).2 (hS m hm)
        exact hl.trans (hu.trans hunit)
      have hsq := pow_le_pow_left₀ hxa hxb 2
      dsimp only [v, g]
      rw [← Real.exp_add, Real.exp_le_exp]
      nlinarith [sq_nonneg (T*(x-a)-T*(a-u))]
    have hVi : v*(b-a) ≤ Real.exp 1*(∫ x in I m, g x) := by
      have h := setIntegral_mono_on (integrable_const v)
        (hg.integrableOn.const_mul (Real.exp 1)) measurableSet_Ioc hgl
      rw [setIntegral_const, measureReal_def, Real.volume_Ioc, ENNReal.toReal_ofReal
        (sub_nonneg.mpr hab), smul_eq_mul, integral_const_mul] at h
      convert h using 1; ring
    have hlen : 1/(m : ℝ) ≤ 2*(b-a) := by
      have he : 1/(m : ℝ) ≤ 2/((m : ℝ)+1) := by
        apply (div_le_div_iff₀ hm₀ (by positivity)).2
        linarith
      calc
        _ ≤ 2*(1/((m : ℝ)+1)) := by simpa only [mul_one_div] using he
        _ ≤ _ := mul_le_mul_of_nonneg_left hgap.1 (by norm_num)
    have hv : 0 ≤ v := Real.exp_nonneg _
    change T/(m : ℝ)*v ≤ _
    calc
      _ = (1/(m : ℝ))*(T*v) := by ring
      _ ≤ (2*(b-a))*(T*v) := mul_le_mul_of_nonneg_right hlen (mul_nonneg hT₀.le hv)
      _ = (2*T)*(v*(b-a)) := by ring
      _ ≤ (2*T)*(Real.exp 1*(∫ x in I m, g x)) :=
        mul_le_mul_of_nonneg_left hVi (by positivity)
      _ = _ := by ring
  have hdis : (↑S : Set ℕ).PairwiseDisjoint I := by
    intro m hm n hn hmn
    rcases lt_or_gt_of_ne hmn with hlt | hlt
    · have hm₀ : (0 : ℝ) < (m : ℝ)+1 := by positivity
      have hl : Real.log ((m : ℝ)+1) ≤ Real.log n := by
        apply Real.log_le_log hm₀
        exact_mod_cast (Nat.succ_le_of_lt hlt)
      exact Ioc_disjoint_Ioc_of_le hl
    · have hn₀ : (0 : ℝ) < (n : ℝ)+1 := by positivity
      have hl : Real.log ((n : ℝ)+1) ≤ Real.log m := by
        apply Real.log_le_log hn₀
        exact_mod_cast (Nat.succ_le_of_lt hlt)
      exact (Ioc_disjoint_Ioc_of_le hl).symm
  calc
    _ ≤ ∑ m ∈ S, 2*Real.exp 1*T*(∫ x in I m, g x) := Finset.sum_le_sum hpoint
    _ = 2*Real.exp 1*T*(∫ x in ⋃ m ∈ S, I m, g x) := by
      rw [← Finset.mul_sum, integral_biUnion_finset S (fun _ _ => measurableSet_Ioc)
        hdis (fun _ _ => hg.integrableOn)]
    _ ≤ 2*Real.exp 1*T*(∫ x : ℝ, g x) :=
      mul_le_mul_of_nonneg_left (setIntegral_le_integral hg (Filter.Eventually.of_forall hg0))
        (by positivity)
    _ = _ := by rw [hgi]; field_simp

private noncomputable def gaussianTime (T t : ℝ) : ℝ :=
  Real.exp (-(t^2)/(4*T^2))

private theorem integrable_gaussianTime {T : ℝ} (hT : 0 < T) : Integrable (gaussianTime T) := by
  have h := integrable_exp_neg_mul_sq (b := 1/(4*T^2)) (by positivity)
  convert h using 1
  funext t
  unfold gaussianTime
  congr 1
  ring

private theorem integral_gaussianTime_phase {T : ℝ} (hT : 0 < T) (u : ℝ) :
    (∫ t : ℝ, (gaussianTime T t : ℂ)*realPhase u t) =
      ((2*Real.sqrt Real.pi*T*Real.exp (-(T*u)^2) : ℝ) : ℂ) := by
  let b : ℝ := 1/(4*T^2)
  have hb : 0 < b := by dsimp [b]; positivity
  have ht : ∀ t : ℝ, (gaussianTime T t : ℂ)*realPhase u t =
      exp ((-(b : ℂ))*(t : ℂ)^2+((u : ℂ)*I)*(t : ℂ)+0) := by
    intro t
    rw [realPhase, gaussianTime, Complex.ofReal_exp, ← Complex.exp_add]
    congr 1
    push_cast
    dsimp [b]
    push_cast
    ring
  simp_rw [ht]
  rw [integral_cexp_quadratic (by simpa : (-(b : ℂ)).re < 0) ((u : ℂ)*I) 0, neg_neg, zero_sub]
  have hq : -(((u : ℂ)*I)^2/(4*-(b : ℂ))) = ((-(T*u)^2 : ℝ) : ℂ) := by
    rw [mul_pow, I_sq]
    dsimp [b]
    push_cast
    field_simp
  rw [hq, ← Complex.ofReal_exp, ← Complex.ofReal_div,
    show (1/2 : ℂ) = ((1/2 : ℝ) : ℂ) by norm_num, ← Complex.ofReal_cpow (by positivity)]
  norm_cast
  have hpi : Real.pi/b = (4*T^2)*Real.pi := by dsimp [b]; field_simp
  rw [hpi, ← Real.sqrt_eq_rpow, Real.sqrt_mul (by positivity), Real.sqrt_mul (by norm_num),
    Real.sqrt_sq_eq_abs, abs_of_pos hT, show Real.sqrt (4 : ℝ) = 2 by norm_num]
  ring

private theorem integral_gaussianTime_subsetPolynomial_le_kernel {T : ℝ} (hT : 0 < T)
    (S : Finset ℕ) (a : ℕ → ℂ) :
    (∫ t : ℝ, gaussianTime T t*‖subsetPolynomial S a t‖^2) ≤
      2*Real.sqrt Real.pi*
        ∑ m ∈ S, ∑ n ∈ S, ‖a m‖*‖a n‖*(T*Real.exp (-(T*(Real.log m-Real.log n))^2)) := by
  let f := fun (m n : ℕ) (t : ℝ) => (gaussianTime T t : ℂ)*realPhase (-Real.log m-(-Real.log n)) t
  have hfi (m n : ℕ) : Integrable (f m n) := by
    apply ((integrable_gaussianTime hT).mono' (μ := volume) ?_ ?_)
    · have hw : Continuous (gaussianTime T) := by unfold gaussianTime; fun_prop
      exact ((Complex.continuous_ofReal.comp hw).mul (continuous_realPhase _)).aestronglyMeasurable
    · exact Filter.Eventually.of_forall fun t => by
        dsimp [f]
        rw [norm_mul, norm_realPhase, mul_one, Complex.norm_real, Real.norm_eq_abs,
          abs_of_pos (show 0 < gaussianTime T t from Real.exp_pos _)]
  let G := fun t : ℝ => gaussianTime T t*‖subsetPolynomial S a t‖^2
  have hdecomp : Complex.ofReal (∫ t : ℝ, G t) =
      ∑ m ∈ S, ∑ n ∈ S, a m*star (a n)*(∫ t : ℝ, f m n t) := by
    rw [← integral_complex_ofReal]
    have hp (t : ℝ) : (G t : ℂ) =
        ∑ m ∈ S, ∑ n ∈ S, a m*star (a n)*f m n t := by
      dsimp only [G]
      rw [Complex.ofReal_mul]
      change ↑(gaussianTime T t)*Complex.ofReal (‖exponentialSum S a (fun n => -Real.log n) t‖^2) = _
      rw [exponentialSum_norm_sq, Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro m hm
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro n hn
      dsimp [f]
      ring
    simp_rw [hp]
    rw [integral_finsetSum S (fun m _ => integrable_finsetSum S (fun n _ => (hfi m n).const_mul _))]
    apply Finset.sum_congr rfl
    intro m hm
    rw [integral_finsetSum S (fun n _ => (hfi m n).const_mul _)]
    apply Finset.sum_congr rfl
    intro n hn
    exact integral_const_mul _ _
  have hnorm :
      ∀ m n : ℕ, ‖∫ t : ℝ, f m n t‖ =
        2*Real.sqrt Real.pi*(T*Real.exp (-(T*(Real.log m-Real.log n))^2)) := by
    intro m n
    dsimp [f]
    rw [integral_gaussianTime_phase hT, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (by positivity),
      show -Real.log m-(-Real.log n) = -(Real.log m-Real.log n) by ring, mul_neg, neg_sq]
    ring
  calc
    _ ≤ |∫ t : ℝ, G t| := le_abs_self _
    _ = ‖Complex.ofReal (∫ t : ℝ, G t)‖ := by rw [Complex.norm_real, Real.norm_eq_abs]
    _ ≤ ∑ m ∈ S, ∑ n ∈ S, ‖a m*star (a n)*(∫ t : ℝ, f m n t)‖ := by
      rw [hdecomp]
      exact (norm_sum_le _ _).trans (Finset.sum_le_sum fun _ _ => norm_sum_le _ _)
    _ = _ := by
      simp only [norm_mul, norm_star, hnorm]
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro m hm
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro n hn
      ring

/-- Local length in the Dirichlet mean square above the time scale. The
coefficient at each frequency pays its own integer index. -/
theorem integral_subsetPolynomial_norm_sq_high_weighted {T : ℝ} (hT : 1 ≤ T)
    (S : Finset ℕ) (a : ℕ → ℂ) (hS : ∀ n ∈ S, T ≤ (n : ℝ)) :
    (∫ t in Icc (-T) T, ‖subsetPolynomial S a t‖^2) ≤
      (4*Real.exp (5/4)*Real.sqrt Real.pi*Real.sqrt (2*Real.pi))*
        ∑ n ∈ S, (n : ℝ)*‖a n‖^2 := by
  let G := fun t : ℝ => gaussianTime T t*‖subsetPolynomial S a t‖^2
  let k := fun m n : ℕ => T*Real.exp (-(T*(Real.log m-Real.log n))^2)
  have hT₀ : 0 < T := by linarith
  have hk (m n : ℕ) : 0 ≤ k m n := by dsimp [k]; positivity
  have hks (m n : ℕ) : k m n = k n m := by
    dsimp only [k]
    rw [show T*(Real.log m-Real.log n) = -(T*(Real.log n-Real.log m)) by ring, neg_sq]
  have hm (m : ℕ) (hmS : m ∈ S) : (0 : ℝ) < m := hT₀.trans_le (hS m hmS)
  have hmajor :
      (∑ m ∈ S, ∑ n ∈ S, ‖a m‖*‖a n‖*k m n) ≤
        ∑ m ∈ S, ∑ n ∈ S, ((m : ℝ)/(n : ℝ))*‖a m‖^2*k m n := by
    calc
      _ ≤ ∑ m ∈ S, ∑ n ∈ S, (1/2 : ℝ)*
          ((((m : ℝ)/(n : ℝ))*‖a m‖^2*k m n)+(((n : ℝ)/(m : ℝ))*‖a n‖^2*k n m)) := by
        apply Finset.sum_le_sum
        intro m hmS
        apply Finset.sum_le_sum
        intro n hnS
        rw [← hks m n, ← add_mul]
        have hm₀ := hm m hmS
        have hn₀ := hm n hnS
        have hAM : ‖a m‖*‖a n‖ ≤ (1/2 : ℝ)*
            (((m : ℝ)/(n : ℝ))*‖a m‖^2+((n : ℝ)/(m : ℝ))*‖a n‖^2) := by
          calc
            _ ≤ (((m : ℝ)*‖a m‖)^2+((n : ℝ)*‖a n‖)^2)/(2*(m : ℝ)*(n : ℝ)) := by
              apply (le_div_iff₀ (by positivity : 0 < 2*(m : ℝ)*(n : ℝ))).2
              nlinarith [sq_nonneg ((m : ℝ)*‖a m‖-(n : ℝ)*‖a n‖)]
            _ = _ := by field_simp [hm₀.ne', hn₀.ne']
        exact (mul_le_mul_of_nonneg_right hAM (hk m n)).trans_eq (by ring)
      _ = _ := by
        calc
          _ = (1/2 : ℝ)*(∑ m ∈ S, ∑ n ∈ S, (((m : ℝ)/(n : ℝ))*‖a m‖^2*k m n)) +
              (1/2 : ℝ)*(∑ m ∈ S, ∑ n ∈ S, (((n : ℝ)/(m : ℝ))*‖a n‖^2*k n m)) := by
            symm
            simp_rw [Finset.mul_sum, ← Finset.sum_add_distrib, ← mul_add]
          _ = _ := by rw [Finset.sum_comm (f := fun (m n : ℕ) => ((n : ℝ)/(m : ℝ))*‖a n‖^2*k n m)]; ring
  have hrow :
      (∑ m ∈ S, ∑ n ∈ S, ((m : ℝ)/(n : ℝ))*‖a m‖^2*k m n) ≤
        (2*Real.exp 1*Real.sqrt (2*Real.pi))*∑ m ∈ S, (m : ℝ)*‖a m‖^2 := by
    rw [Finset.mul_sum]
    apply Finset.sum_le_sum
    intro m hmS
    have haux (n : ℕ) :
        ((m : ℝ)/(n : ℝ))*‖a m‖^2*k m n =
          ((m : ℝ)*‖a m‖^2)*(T/(n : ℝ)*Real.exp (-(T*(Real.log n-Real.log m))^2)) := by
      rw [hks]
      dsimp only [k]
      ring
    simp_rw [haux, ← Finset.mul_sum]
    rw [mul_comm (2*Real.exp 1*Real.sqrt (2*Real.pi))]
    exact mul_le_mul_of_nonneg_left (sum_log_gaussian_high_row_le T (Real.log m) hT S hS) (by positivity)
  have hg : Integrable G := by
    have hw : Continuous (gaussianTime T) := by unfold gaussianTime; fun_prop
    have hc : Continuous G := hw.mul ((subsetPolynomial_continuous S a).norm.pow 2)
    apply ((integrable_gaussianTime hT₀).mul_const ((∑ n ∈ S, ‖a n‖)^2)).mono' hc.aestronglyMeasurable
    filter_upwards with t
    have hpos : 0 ≤ gaussianTime T t := (Real.exp_pos _).le
    have h := pow_le_pow_left₀ (norm_nonneg _) (subsetPolynomial_norm S a t) 2
    simpa only [G, Pi.mul_apply, Real.norm_eq_abs, abs_of_nonneg (mul_nonneg hpos (sq_nonneg _))]
      using mul_le_mul_of_nonneg_left h hpos
  have hcut : (∫ t in Icc (-T) T, ‖subsetPolynomial S a t‖^2) ≤ Real.exp (1/4)*(∫ t, G t) := by
    have hg₀ : 0 ≤ᵐ[volume] G := Filter.Eventually.of_forall fun x => by dsimp [G, gaussianTime]; positivity
    have hp (t : ℝ) (ht : t ∈ Icc (-T) T) : ‖subsetPolynomial S a t‖^2 ≤ Real.exp (1/4)*G t := by
      have ht' : |t| ≤ T := abs_le.mpr ht
      have hsq := pow_le_pow_left₀ (abs_nonneg _) ht' 2
      rw [sq_abs] at hsq
      have hw : 1 ≤ Real.exp (1/4)*gaussianTime T t := by
        calc
          _ = Real.exp 0 := Real.exp_zero.symm
          _ ≤ _ := by
            rw [gaussianTime, ← Real.exp_add, Real.exp_le_exp]
            have h := (div_le_iff₀ (show 0 < 4*T^2 by positivity)).2
              (show t^2 ≤ (1/4 : ℝ)*(4*T^2) by nlinarith)
            rw [neg_div]
            exact sub_nonneg.mpr h
      simpa only [G, mul_assoc, one_mul] using (mul_le_mul_of_nonneg_right hw (sq_nonneg ‖subsetPolynomial S a t‖))
    have h := setIntegral_mono_on ((subsetPolynomial_continuous S a).norm.pow 2).continuousOn.integrableOn_Icc
      ((hg.const_mul _).integrableOn) measurableSet_Icc hp
    rw [integral_const_mul] at h
    exact h.trans (mul_le_mul_of_nonneg_left (setIntegral_le_integral hg hg₀) (by positivity))
  calc
    _ ≤ Real.exp (1/4)*(∫ t, G t) := hcut
    _ ≤ Real.exp (1/4)*(2*Real.sqrt Real.pi*(∑ m ∈ S, ∑ n ∈ S, ‖a m‖*‖a n‖*k m n)) :=
      mul_le_mul_of_nonneg_left (integral_gaussianTime_subsetPolynomial_le_kernel hT₀ S a) (by positivity)
    _ ≤ Real.exp (1/4)*(2*Real.sqrt Real.pi*((2*Real.exp 1*Real.sqrt (2*Real.pi))*
          ∑ n ∈ S, (n : ℝ)*‖a n‖^2)) := by
      exact mul_le_mul_of_nonneg_left
        (mul_le_mul_of_nonneg_left (hmajor.trans hrow) (by positivity)) (by positivity)
    _ = _ := by rw [show (5/4 : ℝ) = 1/4+1 by norm_num, Real.exp_add]; ring

/-- Uniform weighted mean square with one local-length contribution per coefficient. -/
theorem integral_subsetPolynomial_norm_sq_weighted :
    ∃ C : ℝ, 0 < C ∧ ∀ T u : ℝ, 1 ≤ T → ∀ (S : Finset ℕ) (a : ℕ → ℂ),
      (∀ n ∈ S, 1 ≤ n) →
      (∫ t in Icc (u-T) (u+T), ‖subsetPolynomial S a t‖^2) ≤
        C*∑ n ∈ S, (T+(n : ℝ))*‖a n‖^2 := by
  let D := 2+2*Real.pi
  let E := 4*Real.exp (5/4)*Real.sqrt Real.pi*Real.sqrt (2*Real.pi)
  have hD : 0 < D := by dsimp [D]; positivity
  have hE : 0 < E := by dsimp [E]; positivity
  refine ⟨2*(D+E), by positivity, ?_⟩
  intro T u hT S a hS
  let b := fun n : ℕ => a n*realPhase (-Real.log n) u
  have hab : (-T : ℝ) ≤ T := by linarith
  have hshift : (∫ t in Icc (u-T) (u+T), ‖subsetPolynomial S a t‖^2) =
      ∫ t in Icc (-T) T, ‖subsetPolynomial S b t‖^2 := by
    have h := intervalIntegral.integral_comp_add_right (fun t => ‖subsetPolynomial S a t‖^2)
      (a := -T) (b := T) u
    simp_rw [subsetPolynomial_add S a] at h
    rw [intervalIntegral.integral_of_le hab,
      intervalIntegral.integral_of_le (add_le_add_left hab u),
      ← integral_Icc_eq_integral_Ioc, ← integral_Icc_eq_integral_Ioc] at h
    rw [show -T+u = u-T by ring, add_comm T u] at h
    exact h.symm
  rw [hshift]
  classical
  let lo := S.filter (fun n : ℕ => (n : ℝ) ≤ T)
  let hi := S.filter (fun n : ℕ => ¬ (n : ℝ) ≤ T)
  let f := fun t => ‖subsetPolynomial lo b t‖^2
  let g := fun t => ‖subsetPolynomial hi b t‖^2
  have hsplit (t : ℝ) : subsetPolynomial S b t = subsetPolynomial lo b t+subsetPolynomial hi b t := by
    unfold subsetPolynomial exponentialSum
    exact (Finset.sum_filter_add_sum_filter_not S (fun n : ℕ => (n : ℝ) ≤ T) _).symm
  have hpoint (t : ℝ) : ‖subsetPolynomial S b t‖^2 ≤ 2*f t+2*g t := by
    rw [hsplit]
    have hh := pow_le_pow_left₀ (norm_nonneg _) (norm_add_le (subsetPolynomial lo b t)
      (subsetPolynomial hi b t)) 2
    dsimp only [f, g]
    nlinarith [sq_nonneg (‖subsetPolynomial lo b t‖-‖subsetPolynomial hi b t‖)]
  have hf : IntegrableOn f (Icc (-T) T) :=
    ((subsetPolynomial_continuous lo b).norm.pow 2).continuousOn.integrableOn_Icc
  have hg : IntegrableOn g (Icc (-T) T) :=
    ((subsetPolynomial_continuous hi b).norm.pow 2).continuousOn.integrableOn_Icc
  have hint : (∫ t in Icc (-T) T, ‖subsetPolynomial S b t‖^2) ≤
      ∫ t in Icc (-T) T, 2*f t+2*g t :=
    integral_mono ((subsetPolynomial_continuous S b).norm.pow 2).continuousOn.integrableOn_Icc
      ((hf.const_mul 2).add (hg.const_mul 2)) hpoint
  rw [integral_add (hf.const_mul 2) (hg.const_mul 2), integral_const_mul, integral_const_mul] at hint
  have hlo : lo ⊆ Finset.Icc 1 ⌊T⌋₊ := by
    intro n hn
    have hh := Finset.mem_filter.mp hn
    exact Finset.mem_Icc.mpr ⟨hS n hh.1, (Nat.le_floor_iff (by linarith : 0 ≤ T)).2 hh.2⟩
  have hlow : (∫ t in Icc (-T) T, f t) ≤ D*∑ n ∈ lo, T*‖b n‖^2 := by
    have hh := subsetPolynomial_shifted_mean lo b ⌊T⌋₊ hlo T 0 (by linarith)
    simp only [add_zero] at hh
    have hcoef : 2*T+2*Real.pi*(⌊T⌋₊ : ℝ) ≤ D*T := by
      have h := mul_le_mul_of_nonneg_left (Nat.floor_le (by linarith : 0 ≤ T))
        (by positivity : 0 ≤ 2*Real.pi)
      dsimp only [D]
      nlinarith
    apply hh.trans
    unfold coefficientEnergy
    rw [← Finset.mul_sum, ← mul_assoc]
    exact mul_le_mul_of_nonneg_right hcoef (Finset.sum_nonneg fun _ _ => sq_nonneg _)
  have hhigh : (∫ t in Icc (-T) T, g t) ≤ E*∑ n ∈ hi, (n : ℝ)*‖b n‖^2 :=
    integral_subsetPolynomial_norm_sq_high_weighted hT hi b
      (fun n hn => (lt_of_not_ge (Finset.mem_filter.mp hn).2).le)
  have hcoeff (n : ℕ) : ‖b n‖ = ‖a n‖ := by dsimp [b]; rw [norm_mul, norm_realPhase, mul_one]
  have hlow' : (∫ t in Icc (-T) T, f t) ≤ (D+E)*∑ n ∈ lo, (T+(n : ℝ))*‖a n‖^2 := by
    apply hlow.trans
    simp_rw [hcoeff]
    exact mul_le_mul (by linarith) (Finset.sum_le_sum fun _ _ =>
      mul_le_mul_of_nonneg_right (le_add_of_nonneg_right (by positivity)) (sq_nonneg _))
      (Finset.sum_nonneg fun _ _ => by positivity) (by positivity)
  have hhigh' : (∫ t in Icc (-T) T, g t) ≤ (D+E)*∑ n ∈ hi, (T+(n : ℝ))*‖a n‖^2 := by
    apply hhigh.trans
    simp_rw [hcoeff]
    exact mul_le_mul (by linarith) (Finset.sum_le_sum fun _ _ =>
      mul_le_mul_of_nonneg_right (by linarith) (sq_nonneg _))
      (Finset.sum_nonneg fun _ _ => by positivity) (by positivity)
  have hsum := Finset.sum_filter_add_sum_filter_not S (fun n : ℕ => (n : ℝ) ≤ T)
    (fun n => (T+(n : ℝ))*‖a n‖^2)
  calc
    _ ≤ 2*(∫ t in Icc (-T) T, f t)+2*(∫ t in Icc (-T) T, g t) := hint
    _ ≤ 2*((D+E)*(∑ n ∈ lo, (T+(n : ℝ))*‖a n‖^2))+
        2*((D+E)*(∑ n ∈ hi, (T+(n : ℝ))*‖a n‖^2)) :=
      add_le_add (mul_le_mul_of_nonneg_left hlow' (by norm_num))
        (mul_le_mul_of_nonneg_left hhigh' (by norm_num))
    _ = _ := by rw [← hsum]; dsimp only [lo, hi]; ring

end Legendre.Density.Moment
