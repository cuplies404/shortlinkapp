#!/bin/bash

# ===============================
# CONFIG
# ===============================
REPO_DIR="$HOME/shortlinkapp"      # folder repo GitHub
BRANCH="main"                       # branch default
DOMAIN="https://support.machestertechnologies.help"
CSV_FILE="${1:-$REPO_DIR/links.csv}" # CSV path, default di repo
SSH_REMOTE="git@github.com:cuplies404/shortlinkapp.git"

# ===============================
# VALIDASI CSV
# ===============================
if [ ! -f "$CSV_FILE" ]; then
  echo "❌ CSV file not found: $CSV_FILE"
  echo "Usage: ./deploy_shortlink.sh /path/to/links.csv"
  exit 1
fi

# ===============================
# CLONE REPO JIKA BELUM ADA
# ===============================
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "📂 Cloning repo..."
  git clone $SSH_REMOTE $REPO_DIR || exit
fi

cd $REPO_DIR || exit

# ===============================
# BERSIHKAN FILE HTML LAMA
# ===============================
rm -f *.html

# ===============================
# INDEX.HTML UNTUK ROOT
# ===============================
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="refresh" content="0;url=$DOMAIN">
<title>Shortlink App</title>
</head>
<body>
Redirecting to <a href="$DOMAIN">$DOMAIN</a>
</body>
</html>
EOL

# ===============================
# GENERATE HTML UNTUK ALIAS
# ===============================
while IFS=',' read -r alias path; do
    if [ -n "$alias" ] && [ -n "$path" ]; then
        cat <<EOL > "$alias.html"
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="refresh" content="0;url=$DOMAIN$path">
<title>$alias</title>
</head>
<body>
Redirecting to <a href="$DOMAIN$path">$DOMAIN$path</a>
</body>
</html>
EOL
    fi
done < "$CSV_FILE"

# ===============================
# COMMIT & PUSH
# ===============================
git add .
git commit -m "Update shortlinks $(date +'%Y-%m-%d %H:%M:%S')" || echo "Nothing to commit"
git push origin $BRANCH

echo "✅ Shortlink updated and pushed. Azure Static Web App will auto-deploy."

