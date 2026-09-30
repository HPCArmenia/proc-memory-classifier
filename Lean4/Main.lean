import ProcMemoryStability
import ProcMemoryStability.EmpiricalTransitions

open ProcMemoryStability
open ProcMemoryStability.EmpiricalData
open ProcMemoryStability.Silhouette
open ProcMemoryStability.SilhouetteData
open ProcMemoryStability.DistinctCentroids
open ProcMemoryStability.CentroidData

def main : IO Unit := do
  IO.println "ProcMemoryStability — Lean 4 formal certificate"
  IO.println s!"Empirical runs: {nRuns}, samples/run: {nSamples}, k: {nClusters}"
  IO.println ""

  -- Claim 1: multi-run partition identity
  let okAlign :=
    alignedLabels1 == alignedLabels2 &&
    alignedLabels1 == alignedLabels3 &&
    alignedLabels1 == alignedLabels4 &&
    alignedLabels1 == alignedLabels5
  IO.println s!"[1] Multi-run partition identity (aligned labels equal): {okAlign}"

  -- Claim 2: silhouette substantial increase k=2…5
  let okSil := substantialIncreaseB kmeansSilhouetteScores
  IO.println s!"[2] Silhouette substantial increase k=2..5 (mono + jump≥0.0515): {okSil}"
  IO.println s!"    scores ×10000: {kmeansSilhouetteScores}"

  -- Claim 3: five distinct centroids
  let okCent := pairwiseDistinctB kmeansCentroids
  IO.println s!"[3] Five k-means centroids pairwise distinct (ℤ⁴): {okCent}"
  IO.println s!"    n centroids: {kmeansCentroids.size}"

  IO.println ""
  IO.println "[4] Empirical transition matrix is stochastic: NOT IMPLEMENTED (stub in EmpiricalTransitions.lean)"
  IO.println "[5] Metastability fraction >=97% at theta=0.80: NOT IMPLEMENTED (TemporalTheorems.lean uses sorry)"

  IO.println ""
  IO.println "Optional structural lemma: DynamicStaticBridge.dominant_regime_closer (single-axis, proved; see DynamicStaticBridge.lean)"
  IO.println ""
  if okAlign && okSil && okCent then
    IO.println "Three computational certificates: OK (empirical input + native_decide / Prop)."
    IO.println "Dynamic claims 4-5: not certified in this build."
  else
    IO.println "ERROR: one or more static certificates failed."
    IO.Process.exit 1
