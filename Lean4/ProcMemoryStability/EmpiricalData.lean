/-!
Empirical multi-run k-means labels from
`results/analysis/per_run/results_{1..5}/cluster_labels.csv`.

Sample order is lexicographic on `(benchmark, process_name)` (n = 140).
Permutations map each run's raw cluster id to the `results_1` id system
(exhaustive search maximizing agreement; all pairs achieve 140/140).

Source summary: `results/analysis/MULTI_RUN_SUMMARY.md` (pairwise ARI = 1.0).
These definitions are *empirical input*, not theorems about the HPC machine.

**AUTO-GENERATED** by `formal/_gen_empirical.py` — do not edit by hand.
-/
namespace ProcMemoryStability.EmpiricalData

def nSamples : Nat := 140
def nClusters : Nat := 5
def nRuns : Nat := 5

/-- Raw cluster ids for results_1 (unaligned). -/
def rawLabels1 : Array Nat := #[1, 0, 1, 4, 4, 0, 0, 1, 3, 3, 1, 0, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 4, 1, 1, 0, 1, 3, 3, 3, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 2, 0, 1, 1, 1, 4, 4, 1, 1, 0, 4, 4, 4, 4, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0, 1, 1, 1, 3, 3, 3, 1, 1, 1, 4, 2, 4, 4, 2, 4, 0, 4, 2, 1, 3, 3, 1, 2, 1, 1, 1, 0, 1, 1]

/-- Raw cluster ids for results_2 (unaligned). -/
def rawLabels2 : Array Nat := #[0, 2, 0, 1, 1, 2, 2, 0, 3, 3, 0, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 2, 0, 3, 3, 3, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 4, 2, 0, 0, 0, 1, 1, 0, 0, 2, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 2, 2, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 0, 0, 0, 3, 3, 3, 0, 0, 0, 1, 4, 1, 1, 4, 1, 2, 1, 4, 0, 3, 3, 0, 4, 0, 0, 0, 2, 0, 0]

/-- Raw cluster ids for results_3 (unaligned). -/
def rawLabels3 : Array Nat := #[0, 2, 0, 1, 1, 2, 2, 0, 3, 3, 0, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 2, 0, 3, 3, 3, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 4, 2, 0, 0, 0, 1, 1, 0, 0, 2, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 2, 2, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 0, 0, 0, 3, 3, 3, 0, 0, 0, 1, 4, 1, 1, 4, 1, 2, 1, 4, 0, 3, 3, 0, 4, 0, 0, 0, 2, 0, 0]

/-- Raw cluster ids for results_4 (unaligned). -/
def rawLabels4 : Array Nat := #[0, 2, 0, 4, 4, 2, 2, 0, 3, 3, 0, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 2, 0, 3, 3, 3, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 4, 4, 0, 0, 2, 4, 4, 4, 4, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 2, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 0, 0, 0, 3, 3, 3, 0, 0, 0, 4, 1, 4, 4, 1, 4, 2, 4, 1, 0, 3, 3, 0, 1, 0, 0, 0, 2, 0, 0]

/-- Raw cluster ids for results_5 (unaligned). -/
def rawLabels5 : Array Nat := #[0, 2, 0, 4, 4, 2, 2, 0, 3, 3, 0, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 2, 0, 3, 3, 3, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 4, 4, 0, 0, 2, 4, 4, 4, 4, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 2, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 0, 0, 0, 3, 3, 3, 0, 0, 0, 4, 1, 4, 4, 1, 4, 2, 4, 1, 0, 3, 3, 0, 1, 0, 0, 0, 2, 0, 0]

/-- Permutation π: raw id of results_1 ↦ results_1 id (array indexed by raw id). -/
def permToRun1_1 : Array Nat := #[0, 1, 2, 3, 4]

/-- Permutation π: raw id of results_2 ↦ results_1 id (array indexed by raw id). -/
def permToRun1_2 : Array Nat := #[1, 4, 0, 3, 2]

/-- Permutation π: raw id of results_3 ↦ results_1 id (array indexed by raw id). -/
def permToRun1_3 : Array Nat := #[1, 4, 0, 3, 2]

/-- Permutation π: raw id of results_4 ↦ results_1 id (array indexed by raw id). -/
def permToRun1_4 : Array Nat := #[1, 2, 0, 3, 4]

/-- Permutation π: raw id of results_5 ↦ results_1 id (array indexed by raw id). -/
def permToRun1_5 : Array Nat := #[1, 2, 0, 3, 4]

/-- Labels of results_1 after applying `permToRun1_1`. -/
def alignedLabels1 : Array Nat := #[1, 0, 1, 4, 4, 0, 0, 1, 3, 3, 1, 0, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 4, 1, 1, 0, 1, 3, 3, 3, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 2, 0, 1, 1, 1, 4, 4, 1, 1, 0, 4, 4, 4, 4, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0, 1, 1, 1, 3, 3, 3, 1, 1, 1, 4, 2, 4, 4, 2, 4, 0, 4, 2, 1, 3, 3, 1, 2, 1, 1, 1, 0, 1, 1]

/-- Labels of results_2 after applying `permToRun1_2`. -/
def alignedLabels2 : Array Nat := #[1, 0, 1, 4, 4, 0, 0, 1, 3, 3, 1, 0, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 4, 1, 1, 0, 1, 3, 3, 3, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 2, 0, 1, 1, 1, 4, 4, 1, 1, 0, 4, 4, 4, 4, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0, 1, 1, 1, 3, 3, 3, 1, 1, 1, 4, 2, 4, 4, 2, 4, 0, 4, 2, 1, 3, 3, 1, 2, 1, 1, 1, 0, 1, 1]

/-- Labels of results_3 after applying `permToRun1_3`. -/
def alignedLabels3 : Array Nat := #[1, 0, 1, 4, 4, 0, 0, 1, 3, 3, 1, 0, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 4, 1, 1, 0, 1, 3, 3, 3, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 2, 0, 1, 1, 1, 4, 4, 1, 1, 0, 4, 4, 4, 4, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0, 1, 1, 1, 3, 3, 3, 1, 1, 1, 4, 2, 4, 4, 2, 4, 0, 4, 2, 1, 3, 3, 1, 2, 1, 1, 1, 0, 1, 1]

/-- Labels of results_4 after applying `permToRun1_4`. -/
def alignedLabels4 : Array Nat := #[1, 0, 1, 4, 4, 0, 0, 1, 3, 3, 1, 0, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 4, 1, 1, 0, 1, 3, 3, 3, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 2, 0, 1, 1, 1, 4, 4, 1, 1, 0, 4, 4, 4, 4, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0, 1, 1, 1, 3, 3, 3, 1, 1, 1, 4, 2, 4, 4, 2, 4, 0, 4, 2, 1, 3, 3, 1, 2, 1, 1, 1, 0, 1, 1]

/-- Labels of results_5 after applying `permToRun1_5`. -/
def alignedLabels5 : Array Nat := #[1, 0, 1, 4, 4, 0, 0, 1, 3, 3, 1, 0, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 4, 1, 1, 0, 1, 3, 3, 3, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 2, 0, 1, 1, 1, 4, 4, 1, 1, 0, 4, 4, 4, 4, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0, 1, 1, 1, 3, 3, 3, 1, 1, 1, 4, 2, 4, 4, 2, 4, 0, 4, 2, 1, 3, 3, 1, 2, 1, 1, 1, 0, 1, 1]

def allRawLabels : Array (Array Nat) :=
  #[rawLabels1, rawLabels2, rawLabels3, rawLabels4, rawLabels5]

def allPerms : Array (Array Nat) :=
  #[permToRun1_1, permToRun1_2, permToRun1_3, permToRun1_4, permToRun1_5]

def allAlignedLabels : Array (Array Nat) :=
  #[alignedLabels1, alignedLabels2, alignedLabels3, alignedLabels4, alignedLabels5]

end ProcMemoryStability.EmpiricalData
