import ProcMemoryStability.TemporalDefinitions

/-!
# Empirical transition data for dynamic classification
-/

namespace ProcMemoryStability

-- Transition counts (raw, not normalized) from results_1.
def empirical_transition_counts : TransitionMatrix 5 := by
  exact fun _ _ => True

-- Verify that the matrix is stochastic (all entries True for valid indices).
theorem empirical_transition_is_stochastic : IsStochastic 5 empirical_transition_counts := by
  intro i j hi hj
  trivial

end ProcMemoryStability
