#!/bin/bash

# GlowUp Beauty - PWA Build Script
# Usage: chmod +x build.sh && ./build.sh

set -e

echo "🌸 GlowUp Beauty PWA Builder"
echo "=============================="

# Check dependencies
if ! command -v python3 &> /dev/null; then
    echo "❌ python3 tidak ditemukan. Install dulu ya!"
    exit 1
fi

# Create dist folder
echo "📦 Membuat folder dist..."
mkdir -p dist
mkdir -p dist/css
mkdir -p dist/js

# Copy files
echo "📁 Copy file..."
cp index.html dist/
cp manifest.json dist/
cp sw.js dist/
cp css/style.css dist/css/
cp js/app.js dist/js/

# Minify CSS (simple)
echo "🎨 Minify CSS..."
if command -v npx &> /dev/null; then
    npx clean-css-cli dist/css/style.css -o dist/css/style.min.css 2>/dev/null || true
fi

# Minify JS (simple)
echo "⚡ Minify JS..."
if command -v npx &> /dev/null; then
    npx terser dist/js/app.js -o dist/js/app.min.js 2>/dev/null || true
fi

# Update references if minified
if [ -f "dist/css/style.min.css" ]; then
    sed -i 's/style.css/style.min.css/g' dist/index.html
fi
if [ -f "dist/js/app.min.js" ]; then
    sed -i 's/app.js/app.min.js/g' dist/index.html
fi

echo ""
echo "✅ Build selesai!"
echo "📂 Folder: ./dist/"
echo ""
echo "🚀 Jalankan server lokal:"
echo "   python3 -m http.server 8080 --directory dist"
echo ""
echo "📱 Buka di browser: http://localhost:8080"
echo ""