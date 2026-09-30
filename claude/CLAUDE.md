# User rules

## Security

- Never commit passwords, API keys, tokens, or `.env` files
- Before any commit: verify no secrets are staged

### Use meaningful variable and function names

Use descriptive names that explain intent. Avoid abbreviations and single-letter names outside of well-established conventions (e.g. `i` in loops, `e` in rescue clauses).

## Testing

When fixing specs or tests, modify only the test files and the specific code under test; leave unrelated services, models, and controllers alone unless asked. If a test failure seems related to another component, ask before modifying it.

### Follow diamond testing approach

- **Unit tests** — critical business rules: pricing logic, fee calculations, state machine transitions. Write these when the rule has many branches or edge cases.
- **Integration tests** — how components work together: API endpoints, job execution, ActiveRecord callbacks, Kafka consumers, database interactions. This is the largest layer; lean on it for confidence.
- **End-to-end tests** — real user flows only (checkout, login). Only for user-facing features, not internal code. Keep to base cases.

### TDD

Use red/green TDD when building new features or operations. For bug fixes, writing the test after reproducing the bug is acceptable. Skip TDD for trivial config changes (adding an initializer, adjusting a constant).

### Clearly use the Arrange, Act, Assert when testing

- **Arrange**: set up preconditions and inputs
- **Act**: execute the code under test
- **Assert**: verify the outcome

## Committing

Before committing, always verify:

- You are on the correct branch (`git branch --show-current`)
- All changed files are staged (`git diff --cached --stat`)
- No unintended files are included
- Never commit directly to master/main

### Never commit everything

Never use `git add .` or `git add -A`. Always stage specific files with `git add <file>`.

### Commit message format

- Use the JIRA ticket prefix from the branch name if present, e.g. `[FT-1234] Add fee calculator`
- Imperative mood, subject line under 72 characters

### Keep commits small and focused

One logical change per commit. Separate file moves from code changes.

## Pull requests

- Use `gh pr create` to open PRs
- Follow `.github/PULL_REQUEST_TEMPLATE.md` if it exists in the repo
- Extract the JIRA ticket key from the branch name and link it in the description
- Keep scope tight — one ticket per PR
- Never open a PR targeting master/main without explicit user approval

## Tools

### GitHub

Use the `gh` CLI for GitHub operations (PRs, issues, API).

### RTK — token-saving CLI proxy

@RTK.md

## Misc

### Standalone script validation

When delivering a script that modifies external or shared state (Jira ticket mass-edits, GitHub PR operations, infra changes, cron jobs), the deliverable is the script alone. Do not propose dry-runs or "small-batch validation" runs as part of the task. The user will execute and validate manually.

**Why:** External-state mutations are user judgement calls — they want to eyeball the dry-run output, hand-pick a test ticket, and trigger the run themselves rather than have me chain "create script → run dry-run → run on 10 → run on all".

**How to apply:**
- Write the script with sensible defaults: dry-run on by default, `--apply` flag to opt in to writes, audit log per run.
- Stop after the script is written and syntax-checked. Mention the script path and a one-line usage hint; do not offer to run it.
- This is in addition to the global "actions visible to others or that affect shared state need confirmation" rule — it goes further: don't even propose the run.
- Does not apply to local-only scripts (rspec, rubocop, rake migrations on local DB) where running for verification is normal.
