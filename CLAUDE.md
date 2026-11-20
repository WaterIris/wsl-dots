# Iris Bible

Standing instructions for every project. Follow them unless a project's own
CLAUDE.md says otherwise.

## Communication

- **Talk to me in Polish.** Every reply, question, summary and explanation.
- **Write everything else in English:** code, comments, identifiers, commit
  messages, PR descriptions, documentation and other files, including this one.
- **Ambiguous requirement: ask ONE specific question** instead of guessing,
  when the answer changes what gets built.
- **Assumptions are stated:** when proceeding on an assumption, name it in one
  sentence.
- **Say what you don't know or didn't check.** Never invent APIs, function
  names or results.

## Development Philosophy

- **Simplicity:** write simple, straightforward code.
- **Readability:** make code easy to understand at first read.
- **Performance:** consider it, but never at the cost of readability.
- **Maintainability:** write code that is easy to change later.
- **Testability:** structure code so it can be tested.
- **Reuse before writing:** use what the codebase already has. Extract a shared
  helper or component when a second real use appears, not in advance.
- **Less code = less debt:** keep the footprint small; no speculative features
  or abstractions.

## Workflow

- **A commit to return to before every new feature or larger change:** check
  `git status` first. If there are uncommitted changes, stop and propose
  committing them (tests passing) before starting, so the new work can be
  undone cleanly by going back to that commit.
- **Check the current database before changing its structure** (schemas,
  field names, allowed keys or values, validation, indexes): look at the data
  as it is right now, not as remembered, and in the cheapest way (counts,
  `distinct`, aggregations over key names / types, a few samples, rather than
  dumping documents). Find the documents the change would break, and report
  them before changing anything.
- **Check `git status` before every commit.**
- **Keep changes minimal:** touch only what the task needs.
- **Follow existing patterns** (structure, naming, style) as closely as you
  can. Small deviations are fine when they make the code clearly better, but
  always say what you changed and why.
- **Format, then type-check.** Run the formatter on the code you changed, not on
  unrelated lines, so diffs stay minimal.
- **Document public APIs** (endpoints, exported functions, CLI options) briefly.
- **Test thoroughly:** run the relevant tests and check the change works. If
  there are no tests or something could not be verified, say so explicitly.

## Language-Specific Rules

Apply the subsection matching the language of the code being worked on; the
rest of this file applies to every language.

### Python

Use the Astral stack: **uv** (packages, environments, running), **ruff**
(formatting, linting), **ty** (type checking).

- **ONLY uv, NEVER pip.**
  - Install: `uv add <package>` (`uv add --dev <package>` for dev tools)
  - Upgrade: `uv add <package> --upgrade-package <package>` (with `--dev` for
    dev tools)
  - Run tools and scripts: `uv run <tool>`, `uv run python <script>.py`
- **FORBIDDEN:** `pip install`, `uv pip install`, the `@latest` syntax (e.g.
  `uvx ruff@latest`), activating a venv by hand.
- **Checks, in this order:** `uv run ruff format`, `uv run ruff check`,
  `uv run ty check`.
- **Line length 120** (`line-length = 120` in the ruff config).

#### Code Quality

- **Docstrings on public APIs:** modules, classes and functions without a
  leading `_`. Keep them short: what it does and anything non-obvious.
- **Small, focused functions:** one job each. Split when a function does
  several things, not just to make it shorter.

#### FastAPI Projects

- **File size** (line count of a file; `tests/` is exempt):
  - over 300 lines: propose a split;
  - over 500 lines: split before adding anything to it.
- **One file, one responsibility.** Top level by layer (`routers/`,
  `services/`, `schemas/`, `models/`), inside each layer one file per
  resource or domain. No grab-bag `utils.py` / `helpers.py`.
- **Routers handle HTTP only:** validate input, call a service, shape the
  response. Business logic lives in `services/`.
- **Pydantic schemas in `schemas/`, ORM/ODM models in `models/`** (if the
  project uses one), one file per resource.

### TypeScript / React

Required tools: **Prettier** (formatting), **oxlint** (linting), **tsc**
(type checking), as dev dependencies of the project, run through `npx` or
npm scripts.

- **Node from nvm inside WSL, never the Windows npm.** Install packages with
  `npm install` (lockfile respected); no new dependency without asking.
- **Checks, in this order:** `prettier --write`, `oxlint`, `tsc -b` (e.g. as
  an `npm run check` script).
- **Strict TypeScript, no `any`:** type external data as `unknown` and narrow
  it.
- **Function components and hooks.** Components render; state, validation and
  data loading live in hooks or plain functions.
- **Backend calls only through the API module** (e.g. `api.ts`), never `fetch`
  directly in a component.
- **Styles in CSS using the theme variables** (`--panel`, `--accent`, ...): no
  inline styles, no hard-coded colours; every change must work in both light
  and dark themes.
- **Check UI changes in a browser.** If that is not possible, say so
  explicitly.
- **Basic accessibility:** `<button>` for actions, `<a>` for navigation, a label
  for every form field.

## Commits and Pull Requests

- **Never push; only I push.** Prepare commits locally and leave them for me.
  This covers every git operation that changes a remote (push, force-push,
  deleting or creating remote branches or tags).
- **Tests before the commit:** if the change can affect how the code behaves
  and tests exist for it, run them first and commit only when they pass. If
  they fail, don't commit; report what failed.
- **Never mention the tool or any co-author:** no `Co-Authored-By` lines, no
  "Generated with ..." footers, in commits or PRs.
- **PR description:** explain the problem it solves and how it is solved, at a
  high level. Go into code details only where they add clarity.
- **Commit message:** a short subject; a body only when the *why* is not
  obvious from the diff.
