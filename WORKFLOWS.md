# Quick Reference: Daily Workflows

This is a quick reference for common workflows with your fork.

## Setup (Do Once)

```bash
# Run the setup script
./SETUP_BRANCHES.sh
```

This creates:
- `main` - Your enhanced menubar
- `upstream-sync` - Tracks original menubar

---

## Common Workflows

### 🔨 Workflow 1: Add a Feature to YOUR Fork

```bash
# Start from your main
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/my-new-feature

# Develop your feature
# ... edit files ...
npm test
npm run build

# Commit
git add .
git commit -m "feat: add my new feature"

# Merge to your main
git checkout main
git merge feature/my-new-feature
git push origin main

# Clean up
git branch -d feature/my-new-feature
```

**Use this for:** Custom features, breaking changes, experiments

---

### 🐛 Workflow 2: Fix a Bug & Contribute to Upstream

```bash
# Start from clean upstream
git checkout upstream-sync
git pull upstream main

# Create fix branch
git checkout -b fix/bug-description

# Fix the bug (ONLY the fix, no custom features)
# ... edit files ...
npm test
npm run build

# Commit with clear message
git add .
git commit -m "fix: description of bug fix

- Explain what was wrong
- Explain how this fixes it
- Reference issue # if applicable"

# Push to YOUR fork
git push origin fix/bug-description

# Go to GitHub and create PR:
# From: Rballesteros/menubar:fix/bug-description
# To:   maxogden/menubar:main
```

**Then apply the same fix to your fork:**
```bash
# After pushing fix
git checkout main
git cherry-pick fix/bug-description
git push origin main
```

**Use this for:** Bug fixes, security fixes, documentation improvements

---

### 🔄 Workflow 3: Sync Upstream Updates into Your Fork

```bash
# Update upstream-sync branch
git checkout upstream-sync
git pull upstream main
git push origin upstream-sync

# View what changed
git log main..upstream-sync --oneline

# Option A: Cherry-pick specific commits
git checkout main
git cherry-pick <commit-hash>
git push origin main

# Option B: Merge all upstream changes
git checkout main
git merge upstream-sync
# Fix any conflicts between upstream and your custom features
git push origin main
```

**Use this for:** Staying current with upstream improvements

---

### ✨ Workflow 4: Extract a Feature from Your Fork to Contribute

You built something in your fork that would help everyone:

```bash
# Start from clean upstream
git checkout upstream-sync
git pull upstream main
git checkout -b feat/useful-feature

# Manually implement ONLY the feature
# (Without fork-specific code)
# ... edit files ...

# Or cherry-pick and clean up
git cherry-pick <commit-from-main>
# Remove fork-specific code
# ... edit ...

git add .
git commit -m "feat: useful feature for everyone"

# Test thoroughly
npm test
npm run build

# Push and PR to upstream
git push origin feat/useful-feature
```

**Use this for:** Sharing your innovations with the community

---

### 🔍 Workflow 5: Check What's Different

```bash
# See all your custom commits
git log upstream-sync..main --oneline

# See file differences
git diff upstream-sync..main

# See what's in upstream that you don't have
git log main..upstream-sync --oneline
```

---

### 🚀 Workflow 6: Release Your Fork

```bash
git checkout main
git pull origin main

# Update version
npm version patch  # or minor, or major
# This updates package.json and creates a git tag

# Push with tags
git push origin main --tags

# If publishing to npm (with scoped name)
npm publish --access public
```

---

### 🆘 Workflow 7: Conflict Resolution

When merging upstream causes conflicts:

```bash
git checkout main
git merge upstream-sync

# Git shows conflicts
# Edit conflicting files, look for:
# <<<<<<< HEAD (your changes)
# =======
# >>>>>>> upstream-sync (their changes)

# Choose what to keep, then:
git add .
git commit -m "merge: resolve conflicts with upstream"
git push origin main
```

---

## Branch Status Commands

```bash
# Where am I?
git branch

# Show all branches
git branch -a

# Show what each branch tracks
git branch -vv

# Show commits unique to main
git log upstream-sync..main --oneline

# Show commits you don't have from upstream
git log main..upstream-sync --oneline

# See if upstream has new changes
git fetch upstream
git status
```

---

## Decision Tree

**Before making a change, ask:**

```
Does this fix a bug that affects everyone?
├─ YES → Use Workflow 2 (contribute to upstream)
└─ NO
   ├─ Is this a new feature anyone could use?
   │  ├─ YES → Consider Workflow 4 (extract & contribute)
   │  └─ NO → Use Workflow 1 (add to your fork)
   │
   └─ Is this specific to your use case?
      └─ YES → Use Workflow 1 (add to your fork)
```

---

## Quick Command Reference

| Task | Command |
|------|---------|
| Work on your version | `git checkout main` |
| Prepare upstream contribution | `git checkout upstream-sync` |
| Update from upstream | `git checkout upstream-sync && git pull upstream main` |
| See your custom changes | `git log upstream-sync..main` |
| See upstream changes | `git log main..upstream-sync` |
| Current branch | `git branch --show-current` |

---

## Example: Real Day's Work

Morning - Fix a bug you found:
```bash
git checkout upstream-sync
git pull upstream main
git checkout -b fix/positioning-bug
# Fix bug
git commit -am "fix: window positioning on Wayland"
git push origin fix/positioning-bug
# Create PR to upstream
git checkout main
git cherry-pick fix/positioning-bug
git push origin main
```

Afternoon - Add custom feature:
```bash
git checkout main
git checkout -b feature/custom-animations
# Add feature
git commit -am "feat: add custom window animations"
git checkout main
git merge feature/custom-animations
git push origin main
```

Evening - Sync upstream improvements:
```bash
git checkout upstream-sync
git pull upstream main
git checkout main
git merge upstream-sync
# No conflicts - easy merge
git push origin main
```

---

For detailed explanations, see:
- `FORK_STRATEGY.md` - Complete strategy guide
- `CONTRIBUTING_UPSTREAM.md` - Upstream contribution details
