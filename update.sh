#!/bin/sh

set -e

# Clone source and patches
[ ! -d source ] && git clone git@github.com:mayswind/AriaNg.git source
[ ! -d patches ] && git clone git@github.com:aria2ng/patches.git patches

# Apply patches
cd source
for p in ../patches/*.patch; do
  git apply "$p"
done

# Build
if [ ! -d node_modules ]; then
  npm install
fi
./node_modules/gulp/bin/gulp.js process-assets-bundle

# Replace
cd ..
cp source/dist/index.html .

# Publish
git add index.html update.sh
git commit -m "update $(date)"
git push origin master

