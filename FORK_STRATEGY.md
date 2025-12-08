 # Fork Strategy: Independent Development + Upstream Contributions

This document explains how to maintain your own enhanced version of menubar while still contributing fixes and features back to the original project.

## Strategy Overview

You can have **two parallel development tracks**:

1. **Your Fork's Main Branch** (`origin/main`) - Your enhanced version with custom features
2. **Upstream Sync Branch** (`upstream/main`) - Clean upstream for creating PRs

This is completely possible and common in open source!

## Branch Structure

```
upstream/main          ← Original menubar (read-only for you)
    ↓
origin/main            ← YOUR enhanced menubar (with custom features)
    ↓
feature branches       ← Your development work
```

## Current State

Looking at your current setup:
- You have `master` branch (should rename to `main` for consistency)
- You're on `feature/electron-update`
- Your fork already has custom changes (Electron 39 support)

## Recommended Setup

### Option 1: Fork Main Diverges (Recommended for Significant Changes)

Your `main` branch becomes your own version with enhancements, and you still contribute back selectively.

```bash
# Your main branch - your enhanced version
origin/main (your custom features + improvements)

# For upstream contributions - branch from upstream, not your main
git checkout -b fix/some-bug upstream/main  # ← Notice: from upstream, not your main
```

**Pros:**
- Complete freedom to build your version
- Your main branch can have breaking changes
- Can evolve independently
- Still contribute fixes back

**Cons:**
- Your main won't automatically get upstream updates
- Need to manually cherry-pick upstream improvements

### Option 2: Fork Main Tracks Upstream (Recommended for Minor Enhancements)

Keep your `main` in sync with upstream, put your custom features in separate branches.

```bash
# Your main stays synced with upstream
main ← synced with upstream/main

# Your enhancements in feature branches
fork/electron-39-support
fork/custom-positioning
fork/extra-features
```

**Pros:**
- Easy to sync with upstream
- Easy to contribute back
- Clear separation of custom vs upstream code

**Cons:**
- Your custom features aren't in main
- Need to maintain multiple branches

## Recommended Workflow: Hybrid Approach

**Best of both worlds** - I recommend this:

1. **`main` branch** = Your enhanced version (diverges from upstream)
2. **`upstream-sync` branch** = Tracks upstream/main (for easy PR creation)
3. **Feature branches** = Built from whichever makes sense

### Setup:

```bash
# Rename master to main if needed
git branch -m master main
git push origin -u main
git push origin --delete master

# Create upstream tracking branch
git checkout -b upstream-sync upstream/main
git push origin upstream-sync

# Go back to your main
git checkout main
```

### Daily Workflows:

#### 1. Build Your Enhanced Version
```bash
# Work on YOUR version in main or feature branches
git checkout main
git checkout -b feature/my-custom-feature

# Make your changes
git add .
git commit -m "feat: my custom enhancement"

# Merge to YOUR main
git checkout main
git merge feature/my-custom-feature
git push origin main
```

#### 2. Contribute a Bug Fix to Upstream
```bash
# Start from clean upstream
git checkout upstream-sync
git pull upstream main

# Create fix branch from upstream
git checkout -b fix/bug-description

# Make ONLY the fix (no custom features)
# ... edit files ...
git add .
git commit -m "fix: description"

# Push to your fork
git push origin fix/bug-description

# Create PR: Rballesteros/menubar:fix/bug-description → maxogden/menubar:main
```

#### 3. Pull Upstream Improvements Into Your Fork
```bash
# Update upstream-sync
git checkout upstream-sync
git pull upstream main
git push origin upstream-sync

# Cherry-pick specific commits into your main
git checkout main
git cherry-pick <commit-hash-from-upstream>

# Or merge all upstream changes (if compatible)
git merge upstream-sync

# Resolve any conflicts with your custom features
git push origin main
```

#### 4. Extract a Feature from Your Fork to Contribute
```bash
# Your main has a feature that would benefit upstream
# Create a clean branch from upstream with ONLY that feature

git checkout upstream-sync
git pull upstream main
git checkout -b feat/extracted-feature

# Manually apply ONLY the feature code (no fork-specific stuff)
# ... edit files ...
git add .
git commit -m "feat: feature that helps everyone"

# Push and PR to upstream
git push origin feat/extracted-feature
```

## Real-World Example

Let's say you want to:
- Add custom window animations (fork-specific)
- Fix a positioning bug (contribute to upstream)

```bash
# 1. Fix the bug for upstream
git checkout upstream-sync
git pull upstream main
git checkout -b fix/positioning-bug

# Fix ONLY the bug, test it
git add .
git commit -m "fix: window positioning on multi-monitor"
git push origin fix/positioning-bug
# → Create PR to upstream

# 2. Add custom animations to YOUR version
git checkout main
git checkout -b feature/window-animations

# Add your custom feature
git add .
git commit -m "feat: add custom window animations for fork"
git checkout main
git merge feature/window-animations
git push origin main

# 3. When upstream merges your fix, pull it into your fork
git checkout upstream-sync
git pull upstream main  # Gets your merged fix

git checkout main
git cherry-pick <fix-commit-hash>  # Or merge upstream-sync
git push origin main
```

## Managing Divergence

As your fork diverges from upstream, you have choices:

### Strategy A: Selective Sync
Only pull upstream changes you want:
```bash
git checkout upstream-sync
git pull upstream main

# Cherry-pick only what you want
git checkout main
git cherry-pick <specific-commit>
```

### Strategy B: Periodic Merge
Merge upstream periodically, resolve conflicts:
```bash
git checkout main
git merge upstream-sync
# Fix conflicts - keep your enhancements, integrate upstream improvements
git push origin main
```

### Strategy C: Full Divergence
Let your fork become completely independent:
```bash
# Just develop on main, ignore upstream updates
# Only contribute back specific fixes via upstream-sync branch
```

## File Organization Tips

To make contribution easier, keep fork-specific code separate:

```javascript
// Good: Feature flag for fork-specific features
const FORK_FEATURES = {
  customAnimations: true,
  extendedLogging: true
};

if (FORK_FEATURES.customAnimations) {
  // Your custom code
}

// Core functionality - matches upstream
// This is easy to contribute back
```

## Version Numbering

Consider different version numbering for your fork:

```json
// Upstream: 9.5.2
// Your fork: 9.5.2-fork.1

{
  "name": "menubar",
  "version": "9.5.2-fork.1"
}
```

Or use a different package name if publishing:

```json
{
  "name": "@rballesteros/menubar",
  "version": "10.0.0"
}
```

## Communication

In your README, be clear about:
1. What custom features your fork has
2. That you're open to contributing fixes upstream
3. The relationship to the original project

## Decision Matrix: Where Should This Go?

| Change Type | Where to Develop | Contribute Upstream? |
|-------------|------------------|----------------------|
| Bug fix | `upstream-sync` branch | ✅ YES - PR immediately |
| Security fix | `upstream-sync` branch | ✅ YES - PR immediately |
| Performance improvement | `upstream-sync` branch | ✅ YES - Discuss first |
| New feature (general use) | `upstream-sync` branch | ✅ MAYBE - Propose to maintainers |
| New feature (specific to you) | `main` branch | ❌ NO - Keep in fork |
| Breaking API change | `main` branch | ⚠️ DISCUSS - Probably not |
| Experimental feature | `main` branch | ⏳ LATER - Mature it first |
| Documentation improvement | `upstream-sync` branch | ✅ YES - Always helpful |

## Summary Commands

```bash
# Setup (one time)
git branch -m master main
git checkout -b upstream-sync upstream/main
git push origin upstream-sync

# Work on YOUR version
git checkout main
# ... develop your features ...

# Contribute to upstream
git checkout upstream-sync
git pull upstream main
git checkout -b fix/something
# ... make fix ...
git push origin fix/something
# → PR to upstream

# Pull upstream improvements
git checkout upstream-sync
git pull upstream main
git checkout main
git merge upstream-sync  # or cherry-pick
```

## Questions to Ask Yourself

Before making a change, ask:

1. **Would this help other menubar users?** → Contribute to upstream
2. **Is this specific to my use case?** → Keep in fork
3. **Is this experimental?** → Develop in fork, maybe contribute later
4. **Does this break existing APIs?** → Probably keep in fork
5. **Is this a bug fix?** → Always contribute to upstream

## The Bottom Line

**You can absolutely have your cake and eat it too!**

- Build your own enhanced version in `main`
- Keep `upstream-sync` branch tracking original
- Contribute fixes/features via clean branches from `upstream-sync`
- Pull upstream improvements selectively into your `main`

This is how many successful forks work (like Node.js → io.js → Node.js, or Gitea from Gogs, etc.)
