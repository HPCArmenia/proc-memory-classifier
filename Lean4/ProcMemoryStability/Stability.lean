import ProcMemoryStability.Definitions

/-!
# Stability theorems (pure mathematics)

Proved claims (no empirical floats):

1. `EquivalentUpToPerm` is an equivalence relation.
2. Equivalence up to permutation implies identical induced partitions
   (`SamePartition`): classification is stable *in the sense of partition identity*.
3. `ARI_eq_one` (defined as optimal label agreement via a bijection) is
   definitionally `EquivalentUpToPerm`.
4. If raw labels differ by a fixed bijection `π`, then aligning by `π` recovers
   identical label vectors (lemma used in the paper narrative).
-/

namespace ProcMemoryStability

/-! ## Equivalence relation -/

theorem EquivalentUpToPerm.refl {n k : Nat} (c : Labeling n k) :
    EquivalentUpToPerm c c := by
  refine ⟨id, ⟨fun _ _ h => h, fun y => ⟨y, rfl⟩⟩, ?_⟩
  intro s
  rfl

noncomputable def bijectiveInv {α β : Sort _} (f : α → β) (hf : Bijective f) : β → α :=
  fun y => Classical.choose (hf.surjective y)

theorem bijectiveInv_right {α β : Sort _} (f : α → β) (hf : Bijective f) (y : β) :
    f (bijectiveInv f hf y) = y :=
  Classical.choose_spec (hf.surjective y)

theorem bijectiveInv_left {α β : Sort _} (f : α → β) (hf : Bijective f) (x : α) :
    bijectiveInv f hf (f x) = x := by
  apply hf.injective
  exact bijectiveInv_right f hf (f x)

theorem EquivalentUpToPerm.symm {n k : Nat} {c c' : Labeling n k}
    (h : EquivalentUpToPerm c c') : EquivalentUpToPerm c' c := by
  obtain ⟨π, hπ, hc⟩ := h
  let ψ := bijectiveInv π hπ
  refine ⟨ψ, ⟨?inj, ?surj⟩, ?comp⟩
  case inj =>
    intro a b hab
    have hπeq : π (ψ a) = π (ψ b) := congrArg π hab
    have : a = π (ψ a) := (bijectiveInv_right π hπ a).symm
    have : b = π (ψ b) := (bijectiveInv_right π hπ b).symm
    -- a = π(ψ a) = π(ψ b) = b
    calc
      a = π (ψ a) := (bijectiveInv_right π hπ a).symm
      _ = π (ψ b) := hπeq
      _ = b := bijectiveInv_right π hπ b
  case surj =>
    intro y
    exact ⟨π y, bijectiveInv_left π hπ y⟩
  case comp =>
    intro s
    have hψπ : ψ (π (c s)) = c s := bijectiveInv_left π hπ (c s)
    have hc' : c' s = π (c s) := hc s
    calc
      c s = ψ (π (c s)) := hψπ.symm
      _ = ψ (c' s) := by rw [hc']

theorem EquivalentUpToPerm.trans {n k : Nat} {c₁ c₂ c₃ : Labeling n k}
    (h₁₂ : EquivalentUpToPerm c₁ c₂) (h₂₃ : EquivalentUpToPerm c₂ c₃) :
    EquivalentUpToPerm c₁ c₃ := by
  obtain ⟨π, hπ, hπc⟩ := h₁₂
  obtain ⟨σ, hσ, hσc⟩ := h₂₃
  refine ⟨σ ∘ π, Bijective.comp hσ hπ, ?_⟩
  intro s
  simp [hσc, hπc]

theorem EquivalentUpToPerm.equivalence {n k : Nat} :
    Equivalence (@EquivalentUpToPerm n k) :=
  ⟨EquivalentUpToPerm.refl, EquivalentUpToPerm.symm, EquivalentUpToPerm.trans⟩

/-! ## Partition identity -/

/--
**Main stability content.** If two labelings are equivalent up to permutation,
then they induce the *same* partition of samples: `s` and `t` co-cluster under
`c` iff they co-cluster under `c'`.
-/
theorem samePartition_of_equivalent {n k : Nat} {c c' : Labeling n k}
    (h : EquivalentUpToPerm c c') : SamePartition c c' := by
  obtain ⟨π, hπ, hc⟩ := h
  intro s t
  constructor
  · intro hst
    simp only [sameCluster] at hst ⊢
    rw [hc s, hc t, hst]
  · intro hst
    simp only [sameCluster] at hst ⊢
    have : π (c s) = π (c t) := by
      rw [← hc s, ← hc t, hst]
    exact hπ.injective this

/--
If a collection of runs is pairwise equivalent up to permutation, then every
pair of runs induces the same partition (after relabeling). Hence the
classification is stable across independent collections *in the sense of
partition identity*.
-/
theorem stable_implies_identical_partitions {n k m : Nat}
    (cs : Fin m → Labeling n k) (h : StableRuns cs) :
    ∀ i j : Fin m, SamePartition (cs i) (cs j) := by
  intro i j
  exact samePartition_of_equivalent (h i j)

/-! ## ARI = 1 ↔ equivalence (by definition) -/

theorem ARI_eq_one_iff_equivalent {n k : Nat} (c c' : Labeling n k) :
    ARI_eq_one c c' ↔ EquivalentUpToPerm c c' :=
  Iff.rfl

theorem ARI_eq_one_implies_equivalent {n k : Nat} {c c' : Labeling n k}
    (h : ARI_eq_one c c') : EquivalentUpToPerm c c' :=
  h

/-! ## Fixed-permutation alignment lemma -/

/--
If the raw labels of run `c'` are exactly `π ∘ c` for a fixed bijection `π`,
then aligning `c'` by any left inverse of `π` recovers `c`.
-/
theorem align_fixed_permutation {n k : Nat} (c : Labeling n k)
    (π ψ : Fin k → Fin k) (hψ : ∀ x, ψ (π x) = x) :
    mapLabels ψ (mapLabels π c) = c := by
  funext s
  simp [mapLabels, hψ]

/-- Aligned labels agree when `c'` is a pure relabeling of `c` by `π`. -/
theorem aligned_agree_of_fixed_perm {n k : Nat} {c c' : Labeling n k}
    (π : Fin k → Fin k) (hπ : Bijective π)
    (h : ∀ s, c' s = π (c s)) :
    EquivalentUpToPerm c c' ∧ SamePartition c c' := by
  have heq : EquivalentUpToPerm c c' := ⟨π, hπ, h⟩
  exact ⟨heq, samePartition_of_equivalent heq⟩

theorem SamePartition.refl {n k : Nat} (c : Labeling n k) : SamePartition c c := by
  intro s t; exact Iff.rfl

theorem SamePartition.symm {n k : Nat} {c c' : Labeling n k}
    (h : SamePartition c c') : SamePartition c' c := by
  intro s t; exact (h s t).symm

theorem SamePartition.trans {n k : Nat} {c₁ c₂ c₃ : Labeling n k}
    (h₁₂ : SamePartition c₁ c₂) (h₂₃ : SamePartition c₂ c₃) :
    SamePartition c₁ c₃ := by
  intro s t
  exact (h₁₂ s t).trans (h₂₃ s t)

end ProcMemoryStability
