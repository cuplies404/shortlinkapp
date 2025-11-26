#!/bin/bash

# ========================================
# Deploy Shortlink App ke GitHub & Azure
# ========================================

# Cek branch aktif
branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $branch"

# Tambahkan semua file
git add .

# Commit perubahan (jika ada)
git commit -m "Auto deploy Shortlink App $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null

# Push ke GitHub
echo "Pushing to GitHub..."
git push origin main

# Tunggu sebentar agar Azure workflow trigger
echo "Waiting 5 seconds for workflow to start..."
sleep 5

# Info URL Azure Static Web App
echo "✅ Deployment finished. Azure Static Web App URL:"
echo "https://shortlinkapp-eastasia.azurestaticapps.net"
echo "Pengunjung akan otomatis diarahkan ke https://support.machestertechnologies.help/"

