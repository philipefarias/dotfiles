# Global Conventions

## Writing Style

Run `crew conventions writing` before your first writing-heavy task in a session; `crew conventions --list` names the per-context conventions. Layers print broad to specific; the most specific wins. "no rule declared" means none exists: never infer one from recent artifacts.

## Git Commits

- **Atomic.** One logical change per commit, always. If you can describe it with "and" (e.g., "add X AND fix Y"), it's multiple commits. Plan commit boundaries before implementing.
- **Focus on the why.** The commit message body explains why the change was made, not what changed — the diff shows the what. The subject line summarizes the intent in imperative mood.
- **Subject line format:** Follow the project's convention (check AGENTS.md). Keep under 72 characters.

## PR & Code Review Conventions

Authoring your own PRs (descriptions + replying to reviewers): `crew conventions pr-author`. Reviewing teammates' PRs: `crew conventions pr-review`. Both layer on `crew conventions writing`.

## Prefer patterns over enumeration

When detecting or categorizing values (environments, roles, statuses, etc.), use structural patterns (e.g. hostname segments, prefixes) rather than hard-coding known values. Hard-coded lists break silently when new entries are added.

## Resolve GitHub identity from the API

Use `gh api user --jq '.login'` to get the authenticated user's GitHub username. Don't guess from system username, git config, or other context.

## Re-evaluate assumptions after changes

When modifying code that was described elsewhere (PR descriptions, READMEs, comments), re-evaluate whether those descriptions are still accurate. Don't carry forward claims that the changes may have invalidated.

## code-review-graph maintenance

code-review-graph is user-provisioned (MCP server + settings.json hooks); crew reads it optionally and does not own it. After a package upgrade (`uv tool upgrade code-review-graph`) the graphs need rebuilding. At the start of each session, compare the version from `code-review-graph --version` with `~/.code-review-graph-last-build-version`; on a mismatch, tell the user and offer to run `code-review-graph build` in each repo `code-review-graph repos` lists, then write the new version to that file.
