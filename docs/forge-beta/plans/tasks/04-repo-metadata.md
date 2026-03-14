# Task 4: Repo Metadata and Trust Surface

**Specialist:** implementer
**Depends on:** Task 3 (restructure — canonical identity must be established)
**Produces:** GitHub repo metadata, issue template, PR template

## Goal

Add the missing trust signals that tell a user this is a canonical project, not a private branch.

## Acceptance Criteria

- [ ] GitHub repo has description set via `gh repo edit`
- [ ] GitHub repo has topics set (e.g., ai-development, workflow, tdd, multi-agent, claude-code)
- [ ] `.github/ISSUE_TEMPLATE/bug_report.md` exists with structured bug report fields
- [ ] `.github/ISSUE_TEMPLATE/feature_request.md` exists with structured feature request fields
- [ ] `.github/PULL_REQUEST_TEMPLATE.md` exists with PR checklist

## Test Expectations

- **Test:** `.github/ISSUE_TEMPLATE/bug_report.md` exists and contains required fields
- **Expected red failure:** file doesn't exist
- **Expected green:** file exists with title, description, steps-to-reproduce, expected-behavior sections

- **Test:** `.github/PULL_REQUEST_TEMPLATE.md` exists
- **Expected red failure:** file doesn't exist
- **Expected green:** file exists with checklist

## Files

- Create: `.github/ISSUE_TEMPLATE/bug_report.md`
- Create: `.github/ISSUE_TEMPLATE/feature_request.md`
- Create: `.github/PULL_REQUEST_TEMPLATE.md`

## Implementation Notes

- Use `gh repo edit --description "Structured operating mode for AI-assisted software development" --add-topic ai-development --add-topic workflow --add-topic tdd --add-topic multi-agent --add-topic claude-code --add-topic cursor --add-topic coding-agent` to set repo metadata
- Issue templates should use GitHub's YAML front matter format for structured fields
- PR template should include: summary, test plan, checklist (tests pass, docs updated, no stale refs)
- Keep templates concise — they're for external contributors who don't exist yet, but having them signals a real project

## Commit

`chore: add GitHub repo metadata, issue templates, and PR template`
