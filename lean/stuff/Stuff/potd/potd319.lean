import Mathlib
import Stuff.Util

namespace POTD319
  inductive S where
    | base : S
    | ind1 (inner : S) : S
    | ind2 (inner : S) : S

  def ev (a : S) (x : ℝ) : ℝ :=
    match a with
    | S.base => x
    | S.ind1 inner => x * (ev inner x)
    | S.ind2 inner => x + (1 - x) * (ev inner x)

  theorem bound (f : S) (x : ℝ) (hypx : 0 < x ∧ x < 1) : 0 < ev f x ∧ ev f x < 1 := by
    induction f with
    | base => exact hypx
    | ind1 inner hyp_inner =>
      simp [ev]
      constructor
      · exact Left.mul_pos hypx.left hyp_inner.left
      · refine mul_lt_one_of_nonneg_of_lt_one_left (le_of_lt hypx.left) (hypx.right) (le_of_lt hyp_inner.right)
    | ind2 inner hyp_inner =>
      simp [ev]
      constructor
      · refine Right.add_pos_of_pos_of_nonneg (hypx.left) ?_
        refine mul_nonneg (by simp; exact le_of_lt hypx.right) (le_of_lt hyp_inner.left)
      · nth_rewrite 1 [← mul_one x, mul_comm, mul_comm (1 - x)]
        show Utils.interp' 1 (ev inner x) x < 1
        rw [← Utils.interp_eq_interp']
        apply lt_of_lt_of_le
        · refine Utils.interp_lt_bound_max 1 (ev inner x) x (ne_of_lt hyp_inner.right ∘ eq_comm.mp) hypx
        · rw [max_eq_left $ le_of_lt hyp_inner.right]

  -- well this was a complete waste of time :')
  theorem main (f g : S) (hyp : ev f ≠ ev g) (x : ℝ) (hypx : 0 < x ∧ x < 1) : ev f x ≠ ev g x := by
    induction f generalizing g x with
    | base => cases g with
      | base => rw [ev]; tauto
      | ind1 ginner => rw [ev, ev]
                       by_contra contra
                       nth_rewrite 1 [← mul_one x] at contra
                       apply mul_left_cancel₀ (ne_of_gt hypx.left) at contra
                       exact ne_of_lt (bound ginner x hypx).right $ eq_comm.mp contra
      | ind2 ginner => rw [ev, ev]
                       by_contra contra
                       nth_rewrite 1 [← add_zero x, add_left_cancel_iff, eq_comm, mul_eq_zero_iff_left $ sub_ne_zero_of_ne $ ne_of_gt hypx.right] at contra
                       exact (ne_of_gt $ (bound ginner x hypx).left) contra
    | ind1 finner hyp_finner => cases g with
      | base => rw [ev, ev]
                by_contra contra
                nth_rewrite 1 [eq_comm, ← mul_one x] at contra
                apply mul_left_cancel₀ (ne_of_gt hypx.left) at contra
                exact ne_of_lt (bound finner x hypx).right $ eq_comm.mp contra
      | ind1 ginner => rw [ev, ev]
                       by_contra contra
                       apply mul_left_cancel₀ (ne_of_gt hypx.left) at contra
                       have hyp' : ev finner ≠ ev ginner := by
                         clear hyp_finner hypx contra
                         by_contra contra
                         apply hyp
                         ext x
                         rw [ev, ev]
                         rw [contra]
                       exact hyp_finner ginner hyp' x hypx contra
      | ind2 ginner => rw [ev, ev]
                       by_contra contra
                       have hyp' : (1-x)/x > 0 := by calc
                         (1-x)/x = 1/x - x/x := by exact sub_div 1 x x
                         _ = 1/x - 1 := by rw [div_self $ ne_of_gt hypx.left]
                         _ > 1 - 1 := (sub_lt_sub_iff_right 1).mpr (one_lt_one_div hypx.left hypx.right)
                         _ = 0 := by simp
                       have fingt1 : ev finner x > 1 := by
                         apply sub_pos.mp
                         rw [add_comm, ← sub_eq_iff_eq_add, ← mul_sub_one, mul_comm, ← eq_div_iff_mul_eq (ne_of_gt hypx.left), mul_div_right_comm] at contra
                         rw [contra]
                         refine mul_pos hyp' (bound ginner x hypx).left
                       refine lt_asymm fingt1 (bound finner x hypx).right
    | ind2 finner hyp_finner => cases g with
      | base => rw [ev, ev]
                by_contra contra
                nth_rewrite 1 [eq_comm, ← add_zero x, add_left_cancel_iff, eq_comm, mul_eq_zero_iff_left $ sub_ne_zero_of_ne $ ne_of_gt hypx.right] at contra
                exact (ne_of_gt $ (bound finner x hypx).left) contra
      | ind1 ginner => rw [ev, ev]
                       by_contra contra
                       have hyp' : (1-x)/x > 0 := by calc
                         (1-x)/x = 1/x - x/x := by exact sub_div 1 x x
                         _ = 1/x - 1 := by rw [div_self $ ne_of_gt hypx.left]
                         _ > 1 - 1 := (sub_lt_sub_iff_right 1).mpr (one_lt_one_div hypx.left hypx.right)
                         _ = 0 := by simp
                       have gingt1 : ev ginner x > 1 := by
                         apply sub_pos.mp
                         rw [eq_comm] at contra
                         rw [add_comm, ← sub_eq_iff_eq_add, ← mul_sub_one, mul_comm, ← eq_div_iff_mul_eq (ne_of_gt hypx.left), mul_div_right_comm] at contra
                         rw [contra]
                         refine mul_pos hyp' (bound finner x hypx).left
                       refine lt_asymm gingt1 (bound ginner x hypx).right
      | ind2 ginner => rw [ev, ev]
                       by_contra contra
                       apply add_left_cancel at contra
                       apply mul_left_cancel₀ (ne_of_gt $ sub_pos.mpr hypx.right) at contra
                       have hyp' : ev finner ≠ ev ginner := by
                         clear hyp_finner hypx contra
                         by_contra contra
                         apply hyp
                         ext x
                         rw [ev, ev]
                         rw [contra]
                       exact hyp_finner ginner hyp' x hypx contra
end POTD319
