# Global Conventions

## Writing Style

Canonical base: `~/Decisiv/dev-tools/workflows/writing-style.md`. Layered per-context conventions in `~/Decisiv/dev-tools/workflows/conventions/`. Most-specific wins. Read the base before your first writing-heavy task in a session.

## Git Commits

- **Atomic.** One logical change per commit, always. If you can describe it with "and" (e.g., "add X AND fix Y"), it's multiple commits. Plan commit boundaries before implementing.
- **Focus on the why.** The commit message body explains why the change was made, not what changed — the diff shows the what. The subject line summarizes the intent in imperative mood.
- **Subject line format:** Follow the project's convention (check AGENTS.md). Keep under 72 characters.

## PR & Code Review Conventions

Authoring your own PRs (descriptions + replying to reviewers): `~/Decisiv/dev-tools/workflows/conventions/pr-as-author.md`. Reviewing teammates' PRs: `~/Decisiv/dev-tools/workflows/conventions/pr-as-reviewer.md`. Both layer on `workflows/writing-style.md`.

## Prefer patterns over enumeration

When detecting or categorizing values (environments, roles, statuses, etc.), use structural patterns (e.g. hostname segments, prefixes) rather than hard-coding known values. Hard-coded lists break silently when new entries are added.

## Resolve GitHub identity from the API

Use `gh api user --jq '.login'` to get the authenticated user's GitHub username. Don't guess from system username, git config, or other context.

## Re-evaluate assumptions after changes

When modifying code that was described elsewhere (PR descriptions, READMEs, comments), re-evaluate whether those descriptions are still accurate. Don't carry forward claims that the changes may have invalidated.

## code-review-graph maintenance

code-review-graph is installed as an MCP server across all Decisiv projects. After any package upgrade (`uv tool upgrade code-review-graph`), the graphs need rebuilding. At the start of each session, run `bash ~/Decisiv/dev-tools/scripts/check-crg-version.sh` — if it reports a version mismatch, tell the user and offer to run `bash ~/Decisiv/dev-tools/scripts/rebuild-crg.sh`.
