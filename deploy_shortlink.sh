#!/bin/bash

# Set variables
REPO="https://github.com/cuplies404/shortlinkapp-empty.git"
BRANCH="main"

echo "🔹 Deploy Shortlink App ke GitHub dan Azure Static Web App..."

# Init git if not already
if [ ! -d ".git" ]; then
    git init
    git checkout -b $BRANCH
    git remote add origin $REPO
fi

# Add all files
git add .
git commit -m "Deploy update $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null

# Pull latest to avoid conflict
git pull origin $BRANCH --rebase

# Push changes
git push -u origin $BRANCH

echo "✅ Semua file di-push ke GitHub. Azure Static Web App akan auto-deploy."

