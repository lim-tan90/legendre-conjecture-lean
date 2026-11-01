/-
Adapted from the PNT+ project, by Alex Kontorovich and contributors.
Source: https://github.com/AlexKontorovich/PrimeNumberTheoremAnd
Commit: 127b50e33f6033e2147921167a117af96d9ba4ea
Original file: PrimeNumberTheoremAnd/Mathlib/Algebra/Notation/Support.lean
Released under Apache 2.0; see licenses/PNTplus-Apache-2.0.txt.
Changes: local imports and module visibility; blueprint metadata removed.
Nonzero contradictions use tactics compatible with the downstream source audit.
-/
module

public import Mathlib.Algebra.Notation.Support

@[expose] public section

namespace Function

variable {α : Type*} [Zero α]

theorem support_id : support (id : α → α) = {0}ᶜ := by
  ext; simp

theorem support_id' {α : Type*} [Zero α] : support (fun x : α ↦ x) = {0}ᶜ :=
  support_id

end Function

