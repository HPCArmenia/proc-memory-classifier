/-!
# Definitions for multi-run classification stability

A *labeling* assigns each of `n` process samples a cluster id in `{0,…,k-1}`.
Two labelings are *equivalent up to permutation* when a bijection on cluster ids
turns one into the other. That is exactly the paper's operational reading of
**ARI = 1 after Hungarian / centroid alignment**: the partitions coincide;
only the raw integer names of clusters may permute.

We do **not** formalize the floating-point Adjusted Rand Index formula here.
-/

namespace ProcMemoryStability

/-- Injectivity (stdlib-free). -/
def Injective {α β : Sort _} (f : α → β) : Prop :=
  ∀ ⦃a₁ a₂⦄, f a₁ = f a₂ → a₁ = a₂

/-- Surjectivity (stdlib-free). -/
def Surjective {α β : Sort _} (f : α → β) : Prop :=
  ∀ b, ∃ a, f a = b

/-- Bijectivity (stdlib-free). -/
def Bijective {α β : Sort _} (f : α → β) : Prop :=
  Injective f ∧ Surjective f

theorem Bijective.injective {α β : Sort _} {f : α → β} (h : Bijective f) : Injective f :=
  h.1

theorem Bijective.surjective {α β : Sort _} {f : α → β} (h : Bijective f) : Surjective f :=
  h.2

theorem Bijective.comp {α β γ : Sort _} {f : β → γ} {g : α → β}
    (hf : Bijective f) (hg : Bijective g) : Bijective (f ∘ g) := by
  refine ⟨?_, ?_⟩
  · intro a₁ a₂ h
    exact hg.injective (hf.injective h)
  · intro c
    obtain ⟨b, hb⟩ := hf.surjective c
    obtain ⟨a, ha⟩ := hg.surjective b
    exact ⟨a, by simp [ha, hb]⟩

/-- A labeling of `n` process samples into `k` clusters. -/
abbrev Labeling (n k : Nat) := Fin n → Fin k

/-- Samples `s` and `t` lie in the same cell of the partition induced by `c`. -/
def sameCluster {n k : Nat} (c : Labeling n k) (s t : Fin n) : Prop :=
  c s = c t

/--
Two labelings are equivalent up to permutation of cluster IDs:
there exists a bijection `π` on `{0,…,k-1}` with `c' = π ∘ c`.
-/
def EquivalentUpToPerm {n k : Nat} (c c' : Labeling n k) : Prop :=
  ∃ π : Fin k → Fin k, Bijective π ∧ ∀ s : Fin n, c' s = π (c s)

/--
Operational stand-in for **ARI = 1 after optimal alignment** (no floats):
the labelings differ only by a bijection on cluster ids.
This matches the paper's use of ARI after centroid / Hungarian matching.
-/
def ARI_eq_one {n k : Nat} (c c' : Labeling n k) : Prop :=
  EquivalentUpToPerm c c'

/-- Induced partitions coincide: pairwise co-clustering is identical. -/
def SamePartition {n k : Nat} (c c' : Labeling n k) : Prop :=
  ∀ s t : Fin n, sameCluster c s t ↔ sameCluster c' s t

/--
A finite collection of runs is *stable* when every pair of labelings is
equivalent up to permutation (pairwise ARI = 1 after alignment).
-/
def StableRuns {n k m : Nat} (cs : Fin m → Labeling n k) : Prop :=
  ∀ i j : Fin m, EquivalentUpToPerm (cs i) (cs j)

/-- Apply a cluster-id map pointwise to a labeling. -/
def mapLabels {n k k' : Nat} (π : Fin k → Fin k') (c : Labeling n k) : Labeling n k' :=
  fun s => π (c s)

/-- Array-level alignment used by the empirical certificate (`Empirical.lean`). -/
def alignArray (π labels : Array Nat) : Array Nat :=
  labels.map fun lab => π[lab]?.getD lab

end ProcMemoryStability
