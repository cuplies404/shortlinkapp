#!/bin/bash

# ================================
# Script deploy Shortlink App
# ================================

# Cek branch aktif
branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $branch"

# Tambahkan semua file
git add .

# Commit perubahan
git commit -m "Auto deploy Shortlink App $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null

# Push ke GitHub
echo "Pushing to GitHub..."
git push origin main

# Tunggu sebentar agar GitHub Actions trigger
echo "Waiting 5 seconds for workflow to start..."
sleep 5

# Tampilkan status deploy
echo "Login to Azure portal to verify deployment:"
echo "https://portal.azure.com/#resource/subscriptions/YOUR_SUBSCRIPTION_ID/resourceGroups/rg-shortlink/providers/Microsoft.Web/staticSites/shortlinkapp-eastasia"

echo "✅ Deployment script finished."

