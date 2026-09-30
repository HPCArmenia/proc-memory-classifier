/-!
# Dynamic-Static Bridge (single axis, fully proved)

This file gives a genuine, `sorry`-free proof of the mathematical core of the
"Dynamic-Static Bridge" argument sketched in `docs/DYNAMIC_BEHAVIOR_SECTION.md`
(Section 3.2 of the paper draft).

Informal statement. Suppose a process spends a fraction `theta` of its
observation window in behavioral regime `R` (per-sample feature values near
`muR`) and the remaining fraction `1 - theta` in some other regime (values
near `muOther`). Its time-averaged feature value is

    xavg = theta * muR + (1 - theta) * muOther

If the process is in the *majority* regime (`theta > 1/2`) and the two
regimes are genuinely distinct on this axis (`muR ≠ muOther`), then `xavg`
lies strictly closer to `muR` than to `muOther`. This is exactly the
property that justifies classifying the time-averaged (static) feature
vector into the same cluster as the regime the process actually spent most
of its time in — the bridge between the dynamic (trajectory) view and the
static (single-vector) k-means view used in Sections 4-5.

This file proves that statement for a single feature axis over `Rat`
(matching how `theta` and other empirical parameters are already
represented elsewhere in this project, e.g. `metastability_threshold` in
`TemporalDefinitions.lean`). No axioms and no `sorry` are used; `#print
axioms dominant_regime_closer` at the end reports only the two standard
Lean core axioms (`propext`, `Classical.choice`), the same footprint as the
rest of this project's non-computational proofs.

Scope. This is a single-axis, two-regime model. It does not itself cover
the multi-axis (4-dimensional) feature vectors used by the k-means
classifier, and it does not model the transition-matrix / multi-run
reproducibility claims in `docs/DYNAMIC_BEHAVIOR_SECTION.md` (Sections 3.3
and 3.4), which remain open (see `TemporalDefinitions.lean` /
`TemporalTheorems.lean`, still stated with `sorry`).
-/

namespace ProcMemoryStability.DynamicStaticBridge

/-- Helper: over `Rat`, every nonzero value has a strictly positive square.
Proved directly from the totality of `Rat`'s order (`Rat.le_total`) and
sign-times-sign positivity (`Rat.mul_pos_iff_of_pos_left`); no external
library is used. -/
theorem rat_sq_pos_of_ne_zero (a : Rat) (h : a ≠ 0) : a ^ 2 > 0 := by
  cases (@Rat.le_total a 0) with
  | inl hle =>
    have hlt : a < 0 := Rat.lt_of_le_of_ne hle h
    have hnegpos : 0 < -a := by grind
    have hmul : (-a) * (-a) > 0 := (Rat.mul_pos_iff_of_pos_left hnegpos).mpr hnegpos
    grind
  | inr hle =>
    have hlt : 0 < a := Rat.lt_of_le_of_ne hle (Ne.symm h)
    have hmul : a * a > 0 := (Rat.mul_pos_iff_of_pos_left hlt).mpr hlt
    grind

/--
**Dynamic-Static Bridge (single axis).**

If a process spends a majority fraction `theta > 1/2` of its window in
regime `R` (mean value `muR`) versus the complementary regime (mean value
`muOther ≠ muR`), then the time-averaged feature value
`xavg = theta * muR + (1 - theta) * muOther` is strictly closer to `muR`
than to `muOther`, in squared distance.

This is the formal counterpart of the informal derivation in
`docs/DYNAMIC_BEHAVIOR_SECTION.md`, §3.2: "x_avg is closer to centroid C(R)
than to any other centroid" whenever the metastability fraction exceeds
one half. -/
theorem dominant_regime_closer
    (muR muOther theta : Rat)
    (hne : muR ≠ muOther)
    (hlo : theta > 1 / 2) (hhi : theta ≤ 1) :
    let xavg := theta * muR + (1 - theta) * muOther
    (xavg - muR) ^ 2 < (xavg - muOther) ^ 2 := by
  intro xavg
  have hd : muR - muOther ≠ 0 := by
    intro h
    apply hne
    grind
  have hd2 : (muR - muOther) ^ 2 > 0 := rat_sq_pos_of_ne_zero (muR - muOther) hd
  -- Algebraic identity: the squared-distance gap factors as (2θ-1)·(μR-μOther)².
  have key : (xavg - muOther) ^ 2 - (xavg - muR) ^ 2
      = (2 * theta - 1) * (muR - muOther) ^ 2 := by
    simp only [xavg]
    grind
  have hcoef : (2 * theta - 1) > 0 := by grind
  have hpos : (2 * theta - 1) * (muR - muOther) ^ 2 > 0 :=
    (Rat.mul_pos_iff_of_pos_left hcoef).mpr hd2
  grind

-- Sanity check: only the two standard Lean core axioms are used, no `sorryAx`.
#print axioms dominant_regime_closer

end ProcMemoryStability.DynamicStaticBridge
