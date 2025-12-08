# Contributing Back to Upstream

This document describes the workflow for maintaining this fork while contributing changes back to the original menubar project.

## Remote Setup

This repository has two remotes configured:
- **origin**: Your fork at `https://github.com/Rballesteros/menubar.git`
- **upstream**: Original project at `https://github.com/maxogden/menubar.git`

## Workflow Overview

### 1. Keep Your Fork Synced with Upstream

Regularly sync your fork with the upstream repository to stay up-to-date:

```bash
# Fetch latest changes from upstream
git fetch upstream

# Switch to your main branch
git checkout main

# Merge upstream changes into your fork
git merge upstream/main

# Push updates to your fork
git push origin main
```

### 2. Making Changes for Your Fork Only

For changes specific to your fork (like Electron version updates):

```bash
# Create a feature branch from main
git checkout -b feature/my-fork-feature

# Make your changes
# ... edit files ...

# Commit changes
git add .
git commit -m "feat: description of fork-specific change"

# Push to your fork
git push origin feature/my-fork-feature

# Merge to main (or create PR on your fork)
git checkout main
git merge feature/my-fork-feature
git push origin main
```

### 3. Contributing Changes Back to Upstream

For bug fixes or features that would benefit the original project:

```bash
# Start from latest upstream
git fetch upstream
git checkout -b fix/bug-description upstream/main

# Make your changes (follow upstream's coding standards)
# ... edit files ...

# Commit with clear, descriptive messages
git add .
git commit -m "fix: clear description of what this fixes"

# Push to YOUR fork (not upstream directly)
git push origin fix/bug-description
```

Then:
1. Go to GitHub: https://github.com/Rballesteros/menubar
2. Create a Pull Request from your branch to `maxogden/menubar:main`
3. Describe your changes and why they're beneficial
4. Wait for upstream maintainer review

### 4. After Upstream Accepts Your PR

Once your PR is merged upstream:

```bash
# Sync with upstream to get your merged changes
git fetch upstream
git checkout main
git merge upstream/main

# Delete your local feature branch
git branch -d fix/bug-description

# Delete remote branch on your fork
git push origin --delete fix/bug-description

# Push updated main to your fork
git push origin main
```

## Branch Strategy

### Recommended Branch Naming:
- **Fork-specific features**: `fork/feature-name` (e.g., `fork/electron-39-support`)
- **Upstream contributions**: `fix/issue-name` or `feat/feature-name`
- **Keep `main`** in sync with upstream when possible

## When to Contribute Upstream vs Keep in Fork

### Contribute to Upstream:
✅ Bug fixes that affect everyone
✅ New features with broad appeal
✅ Documentation improvements
✅ Performance optimizations
✅ Security fixes

### Keep in Your Fork:
🔧 Experimental features
🔧 Breaking changes not ready for upstream
🔧 Fork-specific configurations
🔧 Features specific to your use case

## Handling Merge Conflicts

If upstream has conflicting changes:

```bash
# While on your feature branch
git fetch upstream
git merge upstream/main

# Resolve conflicts in your editor
# ... fix conflicts ...

git add .
git commit -m "merge: resolve conflicts with upstream"
git push origin your-branch-name
```

## Best Practices

1. **Always test before contributing upstream** - Run tests, build, and verify
2. **Follow upstream's style guide** - Match their coding conventions
3. **Write clear commit messages** - Use conventional commits format
4. **Keep PRs focused** - One feature/fix per PR
5. **Reference issues** - Link to related issues in PR description
6. **Be patient** - Maintainers may take time to review
7. **Respond to feedback** - Engage constructively with review comments

## Checking Current Branch Status

```bash
# See which remote your branch tracks
git branch -vv

# See all branches (local and remote)
git branch -a

# Check if you're ahead/behind upstream
git fetch upstream
git status
```

## Example: Contributing a Bug Fix

```bash
# 1. Start fresh from upstream
git fetch upstream
git checkout -b fix/window-positioning upstream/main

# 2. Fix the bug
# ... edit files ...

# 3. Test thoroughly
npm test
npm run build

# 4. Commit with clear message
git add .
git commit -m "fix: correct window positioning on multi-monitor setups

- Fixes issue where window appears on wrong monitor
- Uses electron-positioner bounds calculation
- Tested on macOS with 2 and 3 monitor setups"

# 5. Push to your fork
git push origin fix/window-positioning

# 6. Create PR on GitHub to upstream
# 7. After merge, sync your fork
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

## Keeping Fork-Specific Changes

If you have fork-specific changes that shouldn't go upstream, consider:

1. **Separate branches**: Keep them in branches like `fork/custom-feature`
2. **Regular rebasing**: Rebase on upstream/main to stay current
3. **Cherry-pick**: Selectively apply upstream changes if needed
4. **Document differences**: Keep this NOTICE file updated

## Questions?

- Upstream issues: https://github.com/maxogden/menubar/issues
- Fork issues: https://github.com/Rballesteros/menubar/issues
