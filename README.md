# ai-engineering-workflow

My personal Cursor setup for AI-assisted software engineering: always-on User Rules plus skills that load only when relevant. The goal is to keep the agent planning before it codes, making small changes, and proving its work with evidence.

## What's inside

- [`user-rules.md`](user-rules.md): the always-on rules, pasted into Cursor Settings > Rules > User Rules
- [`skills/`](skills/): personal skills, installed into `~/.cursor/skills`

| Skill | Use it for |
|---|---|
| `fix-bugs-root-cause` | Reproduce with a failing test, find the root cause, make the smallest fix |
| `write-meaningful-tests` | Behavior list first, mock only external dependencies, prove each test can fail |
| `review-code-independently` | Structured review with file:line findings, severity, fixes, and one verdict |
| `map-codebase` | One-page, evidence-backed map of an unfamiliar repo |
| `record-architecture-decisions` | Draft decision records and check changes against them |
| `dev-journal` | Record what I learned, quiz me on it, and turn it into posts |

## Install on a new machine

```bash
git clone https://github.com/luiscaro1/ai-engineering-workflow.git ~/Projects/ai-engineering-workflow
~/Projects/ai-engineering-workflow/install.sh
```

The script symlinks each skill into `~/.cursor/skills`, so editing a skill in either place updates the repo. Existing skills with the same name are moved to `~/.cursor/skills-backup/` first. If Cursor doesn't pick up symlinked skills, run `install.sh --copy` instead.

Then paste `user-rules.md` into Cursor Settings > Rules > User Rules, and start a new chat.

## Updating

Edit skills in `~/.cursor/skills` or in this repo (they're the same files when symlinked), then commit and push. After changing `user-rules.md`, paste it into Cursor Settings again.
