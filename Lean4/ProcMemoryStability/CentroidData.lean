/-!
k-means (k=5) centroids on the four paper axes, scaled to ℤ⁴:
  fault = round(total_fault_rate × 100)
  wsStab = round(working_set_stability × 100000)
  rss    = round(rss_kb)
  swap   = round(vm_swap_kb)

Source: `results/clustering/method_comparison/kmeans/cluster_centroids.csv`.

**AUTO-GENERATED** by `formal/_gen_empirical.py` — do not edit by hand.
-/
namespace ProcMemoryStability.CentroidData

/-- Integer 4-vector (scaled centroid). -/
structure Centroid4 where
  fault : Int
  wsStab : Int
  rss : Int
  swap : Int
  deriving BEq, DecidableEq, Repr, Inhabited

/-- Five k-means centroids (cluster ids 0…4). -/
def kmeansCentroids : Array Centroid4 :=
#[
  { fault := 525798, wsStab := 98672, rss := 146934, swap := 0 },
  { fault := 1427710, wsStab := 98182, rss := 7457930, swap := 2125430 },
  { fault := 20344600, wsStab := 60756, rss := 413438, swap := 782 },
  { fault := 128083, wsStab := 10881, rss := 12706, swap := 0 },
  { fault := 947915, wsStab := 98247, rss := 5982960, swap := 285119 }
]

end ProcMemoryStability.CentroidData
