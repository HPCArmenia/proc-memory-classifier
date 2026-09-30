/-!
k-means silhouette scores ×10000 for k = 2…5 from
`results/clustering/method_comparison/silhouette_k_sweep.csv`.

Paper Figure 1: last substantial jump k=4→5 is +0.0515 (encoded as 515).

**AUTO-GENERATED** by `formal/_gen_empirical.py` — do not edit by hand.
-/
namespace ProcMemoryStability.SilhouetteData

/-- Silhouette(k=2) × 10000. -/
def s2 : Nat := 6348
/-- Silhouette(k=3) × 10000. -/
def s3 : Nat := 6543
/-- Silhouette(k=4) × 10000. -/
def s4 : Nat := 7390
/-- Silhouette(k=5) × 10000. -/
def s5 : Nat := 7905

/-- Discrete sequence [s₂, s₃, s₄, s₅]. -/
def kmeansSilhouetteScores : List Nat := [s2, s3, s4, s5]

/-- Paper: +0.0515 at k=4→5, as ×10000 natural. -/
def largeJumpThreshold : Nat := 515

end ProcMemoryStability.SilhouetteData
