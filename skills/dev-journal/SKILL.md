---
name: dev-journal
description: >-
  Keeps a personal learning journal across all projects: writes session
  entries focused on lessons, decisions, and mistakes; quizzes the user to
  reinforce what they learned; recaps past entries; turns entries into
  shareable posts; and publishes posts to the user's public GitHub repo while
  keeping entries private. Use when the user says "journal", "document this",
  "write this down", "what did I learn", "quiz me", "recap my week", "publish",
  or asks to turn their work into a blog post or guide, or when offering to
  document a meaningful task that just finished.
---

# Dev journal

Purpose: help the user learn from their work and share it. Capture the reasoning (decisions, dead ends, corrections), not an activity log; git history already records what changed.

## Location

```
~/Documents/dev-journal/           # Git repo, pushed to a PUBLIC GitHub repo
  README.md                        # public
  .gitignore                       # ignores entries and INDEX.md
  INDEX.md                         # private: one line per entry, newest first
  entries/YYYY-MM-DD-short-title.md  # private
  posts/short-title.md             # public once published
```

Create missing folders and `INDEX.md` on first use.

Entries and `INDEX.md` are private and must never be committed. Before any commit, confirm `.gitignore` still lists `entries` and `INDEX.md`, stage files by explicit path (never `git add .` or `git add -A`), and check `git status` shows nothing from `entries/` or `INDEX.md`.

## Pick the mode

- **Entry** (default): "journal this", "document this", or accepting the end-of-task offer
- **Quiz**: "quiz me", "test me on what I learned"
- **Recap**: "what did I learn this week", "what do I know about X"
- **Post**: "turn this into a post", "write a guide from my notes"
- **Publish**: "publish", "push the post", "put it on the repo"

## Entry

1. If the session was trivial or produced nothing new, say so and suggest skipping.
2. Draft the entry from the conversation. Be specific: file names, commands, error messages, versions. Only attribute a mistake or assumption to the user if they actually made it; facts the agent explained belong under "What I learned".

```markdown
---
date: YYYY-MM-DD
project: <project or folder name>
topics: [topic-a, topic-b]
---

# <Short title>

## What I worked on
<1–2 sentences>

## What I learned
<Specific, reusable insights. No generic advice.>

## Key decisions
| Decision | Why | Alternatives rejected |
|---|---|---|

## Mistakes and corrections
<What went wrong, what the agent got wrong, what was corrected and how. Often the most valuable section.>

## Explain it to a colleague
<The one or two insights worth telling someone else, in plain words.>

## Open questions
<Unresolved items, things to look up next>
```

3. Show the draft and ask the user to correct or add anything, especially the reasoning only they know. Write only after they confirm.
4. Save to `entries/YYYY-MM-DD-short-title.md` (lowercase, hyphens; append `-2` if the name exists).
5. Add a line at the top of `INDEX.md`: `- YYYY-MM-DD [Title](entries/file.md) (project) #topic-a #topic-b`
6. Offer a quick quiz on the entry.

Never include secrets, tokens, passwords, or customer data in entries.

## Quiz

1. Pick the 1–3 most important concepts from the current session or the requested entries.
2. Ask the user to explain the first one in their own words. Point out anything vague, wrong, or skipped.
3. Ask questions one at a time and wait for each answer: recall, "what happens if…", and one edge case or common misconception.
4. Re-explain only the gaps, using a different analogy than before.
5. Never reveal an answer before the user has tried.
6. Add misunderstood points to the entry's "Open questions" if the user agrees.

## Recap

Read `INDEX.md`, filter by date range, project, or topic, then open the matching entries. Summarize the main lessons, recurring mistakes, and open questions still unanswered, with links to entries. Suggest one topic worth a post and one worth a quiz.

## Post

1. Ask, if unclear: who the reader is, and which entries to draw from.
2. State the one idea in a single sentence. If it needs two, propose two posts.
3. Draft from the entries as the source of truth. Don't invent numbers, results, or details.

Structure:
- Title: specific and searchable, no clickbait
- TL;DR: 2–3 sentences
- The problem and what it cost
- The approach, with working code (run or verify every snippet)
- What went wrong and what I'd do differently
- Gotchas
- Takeaways
- Further reading (only links that were verified)

4. Remove secrets, internal hostnames, company or client names, and customer data. List what was removed.
5. Never link to or reference files in `entries/` or `INDEX.md`; they won't exist in the public repo.
6. Leave a marked placeholder for the user's own opinion on the trade-offs; don't write it for them.
7. Save to `posts/` with this frontmatter, then stop. Publishing happens only when the user explicitly says so.

```markdown
---
title: "<Title>"
date: YYYY-MM-DD
status: draft
tags: [tag-a, tag-b]
---
```

Writing style: direct, specific, no filler intros like "In this article we will…".

## Publish

Publishing means committing the post to the public repo and pushing it. Only do this on the user's explicit request.

1. Check the post for anything unfinished: the opinion placeholder, TODOs, unverified links. Ask whether to fill in, remove, or keep each one. The repo is public.
2. Set `status: published` in the post's frontmatter.
3. Run the private-file checks from "Location", then stage only the post: `git add posts/<file>.md`.
4. Commit with a message like `Publish: <title>` and push.
5. If `git push` fails with an authentication error, retry once with the GitHub CLI's login: `git -c credential.helper= -c credential.helper='!gh auth git-credential' push`. Don't change global Git settings.
6. Confirm with `git ls-files` that only public files are tracked, and give the user the post's GitHub link.
