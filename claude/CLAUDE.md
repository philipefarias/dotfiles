# Global Conventions

## Writing Style

Apply these conventions to all written output — code comments, commit messages, PR descriptions, review feedback, explanations, and general communication.

- **Casual-professional tone.** Write like a trusted colleague — warm and direct, not formal or robotic.
- **Collaborative, not adversarial.** Frame suggestions as working together, not as corrections from above.
- **Questions over directives.** When suggesting changes, prefer "Should we use X here?" or "Won't this cause Y?" over "Change this to X." Use direct statements only for clear-cut issues.
- **Brief.** 1-2 sentences for comments and feedback. Don't over-explain. Reserve longer explanations for architectural decisions that need supporting context.
- **English always.** All written output must be in English.
- **Minimal emoji.** Don't sprinkle emojis. Use words.

## Git Commits

- **Atomic.** One logical change per commit, always. If you can describe it with "and" (e.g., "add X AND fix Y"), it's multiple commits. Plan commit boundaries before implementing.
- **Focus on the why.** The commit message body explains why the change was made, not what changed — the diff shows the what. The subject line summarizes the intent in imperative mood.
- **Subject line format:** Follow the project's convention (check AGENTS.md). Keep under 72 characters.

## PR & Code Review Conventions

When writing PR comments, review feedback, PR descriptions, or any code-review communication on Decisiv repos, follow the conventions in `~/Decisiv/decisiv-claude-tools/references/pr-review-conventions.md`. Read that file before your first review action in a session.

## Prefer patterns over enumeration

When detecting or categorizing values (environments, roles, statuses, etc.), use structural patterns (e.g. hostname segments, prefixes) rather than hard-coding known values. Hard-coded lists break silently when new entries are added.

## Resolve GitHub identity from the API

Use `gh api user --jq '.login'` to get the authenticated user's GitHub username. Don't guess from system username, git config, or other context.

## Re-evaluate assumptions after changes

When modifying code that was described elsewhere (PR descriptions, READMEs, comments), re-evaluate whether those descriptions are still accurate. Don't carry forward claims that the changes may have invalidated.

## code-review-graph maintenance

code-review-graph is installed as an MCP server across all Decisiv projects. After any package upgrade (`uv tool upgrade code-review-graph`), the graphs need rebuilding. At the start of each session, run `bash ~/Decisiv/dev-tools/scripts/check-crg-version.sh` — if it reports a version mismatch, tell the user and offer to run `bash ~/Decisiv/dev-tools/scripts/rebuild-crg.sh`.
