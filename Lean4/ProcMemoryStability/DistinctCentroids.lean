import ProcMemoryStability.CentroidData

/-!
# Five clusters = distinct behavior combinations

Canonical axes: `total_fault_rate`, `working_set_stability`, `rss_kb`, `vm_swap_kb`.

Source: `results/clustering/method_comparison/kmeans/cluster_centroids.csv`,
scaled to ℤ⁴ in `CentroidData.lean` (generated).
-/

namespace ProcMemoryStability.DistinctCentroids

open CentroidData

/-- Boolean pairwise distinctness. -/
def pairwiseDistinctB (xs : Array Centroid4) : Bool :=
  Id.run do
    for i in [:xs.size] do
      for j in [:xs.size] do
        if i ≠ j then
          match xs[i]?, xs[j]? with
          | some a, some b =>
            if a == b then return false
          | _, _ => pure ()
    return true

/-- Prop: all pairs of entries are unequal. -/
def PairwiseDistinct (xs : Array Centroid4) : Prop :=
  ∀ i j : Nat, i < xs.size → j < xs.size → i ≠ j → xs[i]! ≠ xs[j]!

/-- Differ on at least one axis (left-nested `∨` to match `||` associativity). -/
def DiffersOnAxis (a b : Centroid4) : Prop :=
  ((a.fault ≠ b.fault ∨ a.wsStab ≠ b.wsStab) ∨ a.rss ≠ b.rss) ∨ a.swap ≠ b.swap

def differsOnAxisB (a b : Centroid4) : Bool :=
  ((decide (a.fault ≠ b.fault) || decide (a.wsStab ≠ b.wsStab)) ||
      decide (a.rss ≠ b.rss)) ||
    decide (a.swap ≠ b.swap)

theorem five_centroids : kmeansCentroids.size = 5 := by
  native_decide

theorem centroids_pairwise_distinct_b :
    pairwiseDistinctB kmeansCentroids = true := by
  native_decide

/-- Pairwise inequality on `Fin 5` indices (computational). -/
theorem centroids_ne_fin :
    ∀ i j : Fin 5, i ≠ j →
      kmeansCentroids[i.val]! ≠ kmeansCentroids[j.val]! := by
  native_decide

/--
**Paper claim (formal).** The five recorded k-means centroids (scaled ℤ⁴)
are pairwise distinct — five distinct behavior combinations on the four axes.
-/
theorem centroids_pairwise_distinct :
    PairwiseDistinct kmeansCentroids := by
  intro i j hi hj hij
  have hsize : kmeansCentroids.size = 5 := five_centroids
  rw [hsize] at hi hj
  exact centroids_ne_fin ⟨i, hi⟩ ⟨j, hj⟩ (fun hfin => hij (Fin.val_eq_of_eq hfin))

/-- Every `Fin 5` pair differs on ≥1 axis (Bool certificate). -/
theorem centroids_differ_on_axis_b :
    ∀ i j : Fin 5, i ≠ j →
      differsOnAxisB (kmeansCentroids[i.val]!) (kmeansCentroids[j.val]!) = true := by
  native_decide

/-- Prop: every pair differs on at least one axis. -/
theorem centroids_differ_on_axis :
    ∀ i j : Nat, i < kmeansCentroids.size → j < kmeansCentroids.size → i ≠ j →
      DiffersOnAxis (kmeansCentroids[i]!) (kmeansCentroids[j]!) := by
  intro i j hi hj hij
  have hsize : kmeansCentroids.size = 5 := five_centroids
  rw [hsize] at hi hj
  have hb := centroids_differ_on_axis_b ⟨i, hi⟩ ⟨j, hj⟩
    (fun hfin => hij (Fin.val_eq_of_eq hfin))
  -- Bool certificate ⇒ Prop disjunction (same nesting)
  simpa [differsOnAxisB, DiffersOnAxis, Bool.or_eq_true, decide_eq_true_iff] using hb

end ProcMemoryStability.DistinctCentroids
