#!/usr/bin/env bash
# PreToolUse(Bash): route shell commands through rtk for token-optimized output.
# Delegates to rtk's own hook so the rewrite rules stay in one place.
exec rtk hook claude
