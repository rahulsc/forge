# Dashboard UI — User Validation Checklist

Run these checks AFTER the build completes.

## Prerequisites

```bash
cd <worktree>/reference-projects/dashboard-ui
npm install  # if not already done
npm start &  # start dev server
```

## Checks

### 1. Dev server starts
```bash
curl -s http://localhost:3000 | head -5
```
**Expected:** HTML response (React app shell)

### 2. npm test passes
```bash
npm test -- --watchAll=false
```
**Expected:** All tests pass

### 3. Sidebar renders
Open http://localhost:3000 in browser or check test output for sidebar component tests.
**Expected:** Sidebar with navigation items visible

### 4. Card grid renders
**Expected:** Responsive grid with mock metric cards

### 5. Dark mode toggle works
**Expected:** Clicking toggle switches theme, visual change visible

### 6. Dark mode persists
**Expected:** Refresh page, dark mode setting retained from localStorage

### 7. Responsive layout
**Expected:** At mobile width (~375px), layout adapts (sidebar collapses or stacks)

## Pass/Fail Summary

| # | Check | Pass? |
|---|-------|-------|
| 1 | Dev server starts | |
| 2 | npm test passes | |
| 3 | Sidebar renders | |
| 4 | Card grid renders | |
| 5 | Dark mode toggle | |
| 6 | Dark mode persists | |
| 7 | Responsive layout | |
