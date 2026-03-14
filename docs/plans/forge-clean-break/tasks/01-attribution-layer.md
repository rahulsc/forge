# Task 1: Attribution Layer

**Depends on:** None
**Produces:** LICENSE, NOTICE.md, ORIGINS.md; deleted FUNDING.yml

## Goal

Establish the legal and attribution foundation for Forge as an independent project derived from obra/superpowers.

## Acceptance Criteria

- [ ] LICENSE contains two separate MIT license blocks — Forge (Rahul Singh Chauhan, 2026) on top, preserved upstream (Jesse Vincent, 2025) below, separated by attribution line
- [ ] NOTICE.md exists with formal attribution: project name, original source, original author, independence statement
- [ ] ORIGINS.md exists with narrative: what Superpowers was, why Forge diverged, frozen fork link, upstream link
- [ ] `.github/FUNDING.yml` is deleted

## Test Expectations

- **Test:** LICENSE contains exactly two MIT License headers
- **Verification:** `grep -c "MIT License" LICENSE` returns `2`
- **Test:** Attribution files exist and are non-empty
- **Verification:** `test -s NOTICE.md && test -s ORIGINS.md`
- **Test:** FUNDING.yml is gone
- **Verification:** `test ! -f .github/FUNDING.yml`

## Files

- Rewrite: `LICENSE`
- Create: `NOTICE.md`
- Create: `ORIGINS.md`
- Delete: `.github/FUNDING.yml`

## Implementation Notes

**LICENSE** — Dual MIT, exact structure in design.md. Top block: Copyright (c) 2026 Rahul Singh Chauhan. Separator: "Portions of this software are derived from Superpowers (https://github.com/obra/superpowers), originally created by Jesse Vincent." Bottom block: Copyright (c) 2025 Jesse Vincent.

**NOTICE.md** — Short, conventional: derived from Superpowers by Jesse Vincent, independent project not affiliated with upstream, original MIT license preserved.

**ORIGINS.md** — ~200 word narrative: what Superpowers was, what we built (multi-agent teams, verification, evidence gates, risk-scaled ceremony, .forge/ infrastructure, pack protocol), why we diverged, frozen fork at https://github.com/rahulsc/superpowers, original at https://github.com/obra/superpowers.

## Commit

`docs: add dual MIT license, NOTICE.md, and ORIGINS.md for Forge attribution`
