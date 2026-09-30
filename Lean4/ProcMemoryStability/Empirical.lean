import ProcMemoryStability.Definitions
import ProcMemoryStability.EmpiricalData
import ProcMemoryStability.Stability

/-!
# Empirical certificate for multi-run partition identity

Loads the five k-means label vectors from `results_1`…`results_5`
(`EmpiricalData.lean`, generated from `results/analysis/per_run/`).

**What is proved computationally**

* After applying the recorded cluster-id permutations (exhaustive agreement-
  maximizing maps), all five aligned label arrays are *definitionally equal*.
* Raw (unaligned) label arrays are *not* all equal — only the partitions match.

**What is *not* proved**

* That the CSV files were produced correctly on the HPC host.
* Floating-point ARI arithmetic (we use the paper's operational reading:
  ARI = 1 ⇔ identical partitions after alignment).
* Future reproducibility under kernel / hardware changes.
-/

namespace ProcMemoryStability.Empirical

open EmpiricalData

/-- Align a raw label vector by a cluster-id permutation array. -/
def align (π labels : Array Nat) : Array Nat :=
  alignArray π labels

/-- Recompute aligned labels from raw data + recorded permutations. -/
def alignedFromRaw (i : Nat) : Array Nat :=
  align (allPerms[i]!) (allRawLabels[i]!)

/-- Sanity: each run has 140 samples. -/
theorem raw_sizes : (allRawLabels[0]!).size = nSamples ∧
    (allRawLabels[1]!).size = nSamples ∧
    (allRawLabels[2]!).size = nSamples ∧
    (allRawLabels[3]!).size = nSamples ∧
    (allRawLabels[4]!).size = nSamples := by
  native_decide

theorem perm_sizes : (allPerms[0]!).size = nClusters ∧
    (allPerms[1]!).size = nClusters ∧
    (allPerms[2]!).size = nClusters ∧
    (allPerms[3]!).size = nClusters ∧
    (allPerms[4]!).size = nClusters := by
  native_decide

/-- Recorded `alignedLabels*` agree with `align perm raw`. -/
theorem aligned_matches_raw_run1 : align permToRun1_1 rawLabels1 = alignedLabels1 := by
  native_decide

theorem aligned_matches_raw_run2 : align permToRun1_2 rawLabels2 = alignedLabels2 := by
  native_decide

theorem aligned_matches_raw_run3 : align permToRun1_3 rawLabels3 = alignedLabels3 := by
  native_decide

theorem aligned_matches_raw_run4 : align permToRun1_4 rawLabels4 = alignedLabels4 := by
  native_decide

theorem aligned_matches_raw_run5 : align permToRun1_5 rawLabels5 = alignedLabels5 := by
  native_decide

/--
**Empirical multi-run certificate.** After alignment to `results_1`, all five
label vectors are identical (140/140). This is the Lean form of
"pairwise ARI = 1.0 / partition identity" from `MULTI_RUN_SUMMARY.md`.
-/
theorem aligned_labels_identical :
    alignedLabels1 = alignedLabels2 ∧
    alignedLabels1 = alignedLabels3 ∧
    alignedLabels1 = alignedLabels4 ∧
    alignedLabels1 = alignedLabels5 := by
  native_decide

/-- Same fact via the recomputed `align` pipeline. -/
theorem aligned_from_raw_identical :
    alignedFromRaw 0 = alignedFromRaw 1 ∧
    alignedFromRaw 0 = alignedFromRaw 2 ∧
    alignedFromRaw 0 = alignedFromRaw 3 ∧
    alignedFromRaw 0 = alignedFromRaw 4 := by
  native_decide

/-- Raw cluster IDs permute between runs (not literally equal). -/
theorem raw_labels_not_all_equal :
    ¬ (rawLabels1 = rawLabels2 ∧
       rawLabels1 = rawLabels3 ∧
       rawLabels1 = rawLabels4 ∧
       rawLabels1 = rawLabels5) := by
  native_decide

/--
Package the computational facts as partition identity:
every aligned vector equals the `results_1` reference.
-/
theorem multi_run_partition_identity :
    (allAlignedLabels[0]!) = alignedLabels1 ∧
    (allAlignedLabels[1]!) = alignedLabels1 ∧
    (allAlignedLabels[2]!) = alignedLabels1 ∧
    (allAlignedLabels[3]!) = alignedLabels1 ∧
    (allAlignedLabels[4]!) = alignedLabels1 := by
  native_decide

#eval IO.println s!"Empirical certificate: aligned run sizes = \
  {alignedLabels1.size}, identical across 5 runs = \
  {decide (alignedLabels1 = alignedLabels2 && alignedLabels1 = alignedLabels3 &&
    alignedLabels1 = alignedLabels4 && alignedLabels1 = alignedLabels5)}"

end ProcMemoryStability.Empirical
