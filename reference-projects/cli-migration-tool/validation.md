# CLI Migration Tool — User Validation Checklist

Run these checks AFTER the build completes.

## Prerequisites

```bash
cd <worktree>/reference-projects/cli-migration-tool
npm install  # if not already done
```

## Checks

### 1. npm test passes
```bash
npm test
```
**Expected:** All tests pass

### 2. Up — apply migrations
```bash
node bin/migrate up
```
**Expected:** Migrations applied in order, output shows which were applied

### 3. Status — show applied
```bash
node bin/migrate status
```
**Expected:** Lists applied migrations with timestamps

### 4. Down — rollback last
```bash
node bin/migrate down
```
**Expected:** Last migration rolled back, output confirms which

### 5. Down again — no-op (bug fix)
```bash
node bin/migrate down
```
**Expected:** No error, no crash. Either "nothing to roll back" message or silent success.

### 6. Up again — re-apply
```bash
node bin/migrate up
```
**Expected:** Previously rolled-back migration re-applied

### 7. Seed — populate test data
```bash
node bin/migrate seed
```
**Expected:** Test data loaded from YAML fixture, output confirms

### 8. Database consistency after rollback
```bash
node bin/migrate up
node bin/migrate down
node bin/migrate status
```
**Expected:** Status is consistent — shows the rolled-back migration as pending, not applied

## Pass/Fail Summary

| # | Check | Pass? |
|---|-------|-------|
| 1 | npm test passes | |
| 2 | Up applies migrations | |
| 3 | Status shows applied | |
| 4 | Down rolls back last | |
| 5 | Down again is no-op (bug fix) | |
| 6 | Up re-applies | |
| 7 | Seed loads fixture data | |
| 8 | DB consistent after rollback | |
