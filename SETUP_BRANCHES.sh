#!/bin/bash
# Setup script for dual-track fork development

echo "Setting up branch structure for fork + upstream workflow..."

# 1. Rename master to main (modern convention)
echo "Step 1: Renaming master to main..."
git branch -m master main

# 2. Merge feature/electron-update into main (this is YOUR version)
echo "Step 2: Merging feature/electron-update into main..."
git checkout main
git merge feature/electron-update --no-ff -m "merge: integrate Electron 39 updates into main"

# 3. Create upstream-sync branch tracking upstream
echo "Step 3: Creating upstream-sync branch..."
git checkout -b upstream-sync upstream/main

# 4. Push everything to your fork
echo "Step 4: Pushing branches to origin..."
git push origin main
git push origin upstream-sync

# 5. Set upstream tracking
git checkout main
git branch -u origin/main

git checkout upstream-sync
git branch -u origin/upstream-sync

# 6. Clean up old branches
echo "Step 5: Cleaning up..."
git checkout main
git branch -D feature/electron-update
git push origin --delete feature/electron-update 2>/dev/null || echo "Remote branch already deleted or doesn't exist"

# 7. Delete old master from remote (if it exists)
git push origin --delete master 2>/dev/null || echo "Remote master already deleted or doesn't exist"

echo ""
echo "✅ Setup complete!"
echo ""
echo "Branch structure:"
echo "  main            - Your enhanced menubar version"
echo "  upstream-sync   - Tracks original menubar project"
echo ""
echo "Quick reference:"
echo "  Work on your fork:        git checkout main"
echo "  Contribute to upstream:   git checkout upstream-sync && git checkout -b fix/something"
echo "  Sync from upstream:       git checkout upstream-sync && git pull upstream main"
echo ""
