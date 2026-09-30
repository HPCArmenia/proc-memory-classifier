import ProcMemoryStability.SilhouetteData

/-!
# Silhouette increases substantially from k = 2 to k = 5

Paper values (`results/clustering/method_comparison/silhouette_k_sweep.csv`,
k-means on `results_7`):

| k | silhouette | ×10000 |
|---|------------|--------|
| 2 | 0.6348     | 6348   |
| 3 | 0.6543     | 6543   |
| 4 | 0.7390     | 7390   |
| 5 | 0.7905     | 7905   |

Encoded as ×10000 naturals so inequalities are decidable without Mathlib.
Empirical constants live in `SilhouetteData.lean` (generated).
-/

namespace ProcMemoryStability.Silhouette

open SilhouetteData

/-- Strictly increasing consecutive scores (decidable Bool). -/
def strictlyIncreasingB : List Nat → Bool
  | [] => true
  | [_] => true
  | a :: b :: rest => (decide (a < b)) && strictlyIncreasingB (b :: rest)

/-- Some consecutive jump ≥ `threshold` (decidable Bool). -/
def hasLargeJumpB (scores : List Nat) (threshold : Nat) : Bool :=
  Id.run do
    let mut i := 0
    while h : i + 1 < scores.length do
      if scores[i + 1] ≥ scores[i] + threshold then
        return true
      i := i + 1
    return false

/--
Paper reading of “substantial increase” on the k=2…5 table:
strictly increasing scores **and** at least one consecutive jump
≥ `largeJumpThreshold` (515 = +0.0515 at k=4→5).
-/
def substantialIncreaseB (scores : List Nat) : Bool :=
  strictlyIncreasingB scores && hasLargeJumpB scores largeJumpThreshold

/-- Prop: consecutive Nat list is strictly increasing. -/
def StrictlyIncreasing : List Nat → Prop
  | [] => True
  | [_] => True
  | a :: b :: rest => a < b ∧ StrictlyIncreasing (b :: rest)

/-- Prop: some consecutive jump ≥ threshold. -/
def HasLargeJump (scores : List Nat) (threshold : Nat) : Prop :=
  ∃ i : Nat, i + 1 < scores.length ∧ scores[i + 1]! ≥ scores[i]! + threshold

/-- Prop: substantial increase (monotonic + paper-sized jump). -/
def SubstantialIncrease (scores : List Nat) : Prop :=
  StrictlyIncreasing scores ∧ HasLargeJump scores largeJumpThreshold

/-- Named step inequalities for the discrete sequence s₂…s₅. -/
theorem s2_lt_s3 : s2 < s3 := by native_decide
theorem s3_lt_s4 : s3 < s4 := by native_decide
theorem s4_lt_s5 : s4 < s5 := by native_decide

/-- Explicit paper jump: s₅ − s₄ ≥ 515 (+0.0515). -/
theorem jump_4_to_5 : s5 ≥ s4 + largeJumpThreshold := by
  native_decide

/-- Explicit total rise: s₅ − s₂ ≥ 1557 (0.1557). -/
theorem rise_2_to_5 : s5 ≥ s2 + 1557 := by
  native_decide

/-- Concrete: scores for k=2…5 are strictly increasing (Bool). -/
theorem kmeans_scores_strictly_increasing_b :
    strictlyIncreasingB kmeansSilhouetteScores = true := by
  native_decide

/--
Concrete Prop: unfold `[s2,s3,s4,s5]` and chain the three step inequalities.
-/
theorem kmeans_scores_strictly_increasing :
    StrictlyIncreasing kmeansSilhouetteScores :=
  show s2 < s3 ∧ s3 < s4 ∧ s4 < s5 ∧ True from
    And.intro s2_lt_s3 <|
      And.intro s3_lt_s4 <|
        And.intro s4_lt_s5 True.intro

/-- Concrete: consecutive jump ≥ 515 exists (Bool). -/
theorem kmeans_has_large_jump_b :
    hasLargeJumpB kmeansSilhouetteScores largeJumpThreshold = true := by
  native_decide

/-- Prop large-jump witness from the k=4→5 step (index 2 in `[s2,s3,s4,s5]`). -/
theorem kmeans_has_large_jump :
    HasLargeJump kmeansSilhouetteScores largeJumpThreshold :=
  ⟨2, by native_decide, by
    change s5 ≥ s4 + largeJumpThreshold
    exact jump_4_to_5⟩

theorem kmeans_substantial_increase_b :
    substantialIncreaseB kmeansSilhouetteScores = true := by
  native_decide

/--
**Paper claim (formal).** On the recorded k-means silhouette table for
k = 2…5, the ×10000 sequence is strictly increasing and contains a jump
of at least +0.0515 (the published k=4→5 step).
-/
theorem kmeans_substantial_increase_2_to_5 :
    SubstantialIncrease kmeansSilhouetteScores :=
  ⟨kmeans_scores_strictly_increasing, kmeans_has_large_jump⟩

end ProcMemoryStability.Silhouette
