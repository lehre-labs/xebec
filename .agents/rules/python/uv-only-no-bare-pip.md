---
name: uv-only-no-bare-pip
description: Run and install through uv; block bare pip/python/global installs so the only path the agent takes is the one your hooks verify.
globs: "**/*.py"
---

- Install with `uv add` / `uv sync`; run with `uv run`. Never bare `pip install`, `python ...`, or global installs.
- One toolchain path keeps the environment reproducible and the one your gate actually verifies.
- Off-path installs leak state the lockfile and hooks never see.

## Audit Instruction

Re-read the diff and any commands run for bare `pip`, `python`, or global `pip install`. Route every install through `uv add`/`uv sync` and every run through `uv run`.

Reference: [uv documentation](https://docs.astral.sh/uv/). Hynek Schlawack calls uv "Python's finest workflow tool" -- [hynek.me/articles](https://hynek.me/articles/).
