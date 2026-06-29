# Full Debug Loop

The heavy-artillery version of [`@SKILL.md`](./SKILL.md), for bugs that fight back: non-deterministic flakes, performance regressions, and bugs where a simple failing test won't reach the cause. Reach for this only when the lean loop stalls.

## Use Cases

```md
Human: This test fails 1 in 20 runs in CI but never locally -- I've tried 4 fixes already.
Human: The CLI got 3x slower after the last release and I can't see why. Full debug.
Human: This only corrupts state after a few thousand operations -- need the heavy loop.
Human: Intermittent deadlock under concurrency, vanishes the moment I add logging.
Human: A regression slipped in somewhere across 200 commits -- bisect it down.
```

## Phase 1 -- Build a feedback loop that goes red

**This is the skill.** A tight pass/fail signal that goes red on *this* bug is what finds the cause. Hypotheses, instrumentation, and bisection all just consume it. Spend most of your effort here. Be aggressive; refuse to give up.

Ways to build one, roughly in order:

1. **Failing test** at whatever seam reaches the bug -- `pytest`, `cargo test`, `bun test`.
2. **CLI invocation** with a fixture input, diffing stdout / exit code against known-good.
3. **Direct call** from a REPL or throwaway script -- call the function or tool with the bad input in isolation.
4. **Replay a captured input.** Save the real payload / args / event that triggers it, replay it through the code path.
5. **Property / fuzz loop** for "sometimes wrong" bugs -- `hypothesis`, `proptest`, `fast-check`: run many random inputs until it fails.
6. **Bisection** if it appeared between two known-good states -- automate the check and `git bisect run` it.
7. **Differential** -- run the same input through old vs new (or two configs) and diff outputs.

Then **tighten** the loop: faster (skip unrelated setup), sharper (assert the exact symptom, not "didn't crash"), more deterministic (pin time, seed RNG, isolate the filesystem). A 2-second deterministic loop is a debugging superpower; a 30-second flaky one is barely a loop.

### Non-deterministic bugs

The goal is not a clean repro but a **higher reproduction rate**. Loop the trigger 100x, parallelise, add stress, narrow timing windows, inject sleeps. A 50%-flake bug is debuggable; 1% is not -- keep raising the rate until it is.

### When you genuinely cannot build a loop

Stop and say so. List what you tried. Ask the user for: (a) access to the environment that reproduces it, (b) a captured artifact (log dump, core dump, trace), or (c) permission to add temporary instrumentation. Do **not** proceed to hypothesise without a loop.

### Completion criterion

Done when you can name **one command** -- already run at least once (paste the invocation and its output) -- that drives the real bug code path, asserts the user's exact symptom, is deterministic, fast, and runnable unattended. No red-capable command, no Phase 2.

## Phase 2 -- Reproduce + minimise

Run the loop, watch it go red. Confirm it's the **user's** failure, not a nearby one -- wrong bug, wrong fix. Capture the exact symptom (error, wrong output, timing) so later phases can verify the fix addresses it.

Then shrink to the **smallest scenario that still goes red**: cut inputs, callers, config, data, and steps one at a time, re-running after each cut. Done when every remaining element is load-bearing -- removing any one makes it go green. The minimal repro shrinks the hypothesis space and becomes the regression test.

## Phase 3 -- Hypothesise

Generate **3-5 ranked, falsifiable hypotheses** before testing any. Single-hypothesis debugging anchors on the first plausible idea.

> Format: "If X is the cause, then changing Y makes the bug disappear / changing Z makes it worse."

If you can't state the prediction, it's a vibe -- sharpen or discard it. Show the ranked list to the user before testing; they often re-rank it instantly ("we just changed #3"). Don't block on it if they're AFK.

## Phase 4 -- Instrument

Each probe maps to one prediction. **Change one variable at a time.**

- **Debugger / REPL** first if the env supports it -- one breakpoint beats ten logs (`pdb`, `rust-lldb`, node inspector).
- **Targeted logs** at the boundaries that distinguish hypotheses. Never "log everything and grep".
- **Tag every debug log** with a unique prefix (`[DEBUG-a4f2]`) so cleanup is one grep. Untagged logs survive; tagged logs die.
- **Performance regressions:** logs are usually wrong. Establish a baseline measurement first (timing harness, profiler, `cargo flamegraph`, `py-spy`), then bisect. Measure first, fix second.

## Phase 5 -- Fix + regression test

Write the regression test **before the fix** -- but only if there's a **correct seam** where the test exercises the real bug pattern as it occurs at the call site. A too-shallow seam (single-caller test for a multi-caller bug) gives false confidence. **If no correct seam exists, that itself is the finding** -- note it; the architecture is preventing the bug from being locked down.

If a correct seam exists:

1. Turn the minimal repro into a failing test at that seam.
2. Watch it fail.
3. Apply the fix.
4. Watch it pass.
5. Re-run the loop against the original (un-minimised) scenario.

## Phase 6 -- Cleanup + post-mortem

- [ ] Original repro no longer reproduces (re-run the loop)
- [ ] Regression test passes (or absence of seam is documented)
- [ ] All `[DEBUG-...]` instrumentation removed (`grep` the prefix)
- [ ] Throwaway scripts / prototypes deleted
- [ ] The hypothesis that turned out correct is stated in the commit / PR message, so the next debugger learns

Then ask: **what would have prevented this bug?** If the answer is architectural (no good seam, tangled callers, hidden coupling), make that recommendation **after** the fix is in -- you know the most then, not at the start.
