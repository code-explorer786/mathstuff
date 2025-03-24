import Mathlib.Tactic
import Mathlib.Data.Real.Basic

namespace Utils
  section Interp
    variable (a b : ℝ)
    variable (x : ℝ)
    variable (hypx : 0 < x ∧ x < 1)

    def interp : ℝ := b + (a - b) * x
    def interp' : ℝ := a * x + b * (1 - x)

    theorem interp_eq_interp' : interp = interp' := by
      rw [funext_iff]
      intro a
      rw [funext_iff]
      intro b
      rw [funext_iff]
      intro x
      show b + (a - b) * x = a * x + b * (1 - x)
      ring_nf

    theorem interp_flip : interp a b x = interp b a (1 - x) := by
      rw [interp_eq_interp']
      show a * x + b * (1 - x) = b * (1 - x) + a * (1 - (1 - x))
      ring_nf

    theorem interp_linear (m c : ℝ) : interp (m * a + c) (m * b + c) x = m * (interp a b x) + c := by simp [interp]; ring_nf

    theorem interp_neg : interp (-a) (-b) x = -(interp a b x) := by simp [interp]; ring_nf

    theorem interp_lt_bound_max (aneqb : a ≠ b) (hypx : 0 < x ∧ x < 1) : interp a b x < max a b := by
      wlog wlog : a ≤ b
      · rw [Mathlib.Tactic.PushNeg.not_le_eq] at wlog
        rw [interp_flip, max_comm]
        apply this b a (1 - x) (aneqb ∘ eq_comm.mp) (by rw [sub_lt_comm, lt_sub_comm]; simp; tauto) (le_of_lt wlog)
      · rw [max_eq_right wlog]
        have wlog := lt_iff_le_and_ne.mpr (And.intro wlog aneqb)
        show b + (a - b) * x < b
        simp
        refine mul_neg_of_neg_of_pos ?_ ?_
        · simp; exact wlog
        · tauto

    -- duality bullshit
    theorem interp_lt_bound_min (aneqb : a ≠ b) (hypx : 0 < x ∧ x < 1) : min a b < interp a b x := by
      rw [← neg_neg a, ← neg_neg b]
      rw [min_neg_neg, interp_neg, neg_lt_neg_iff]
      apply interp_lt_bound_max (-a) (-b) x (aneqb ∘ neg_inj.mp) hypx

  end Interp
end Utils
