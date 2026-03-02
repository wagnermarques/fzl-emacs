#!/bin/bash

# Configuration
SOURCE_DIR="/home/wgn/WORKING/Progsativos/ides/emacs-30.2/emacs-30.2"
INSTALL_PREFIX="/usr/local" # Default location for compiled software

# -----------------------------------------------------------------------------
# Fedora Dependencies (Uncomment if needed):
# -----------------------------------------------------------------------------
# sudo dnf builddep emacs -y
# sudo dnf install -y \
#     gcc make autoconf automake libtool \
#     gnutls-devel ncurses-devel libxml2-devel jansson-devel \
#     libXpm-devel libjpeg-devel libtiff-devel giflib-devel libpng-devel \
#     libXaw-devel gtk3-devel libgccjit-devel tree-sitter-devel \
#     cairo-devel harfbuzz-devel imagemagick-devel
# -----------------------------------------------------------------------------

echo "==> Navigating to Emacs source: $SOURCE_DIR"
cd "$SOURCE_DIR" || { echo "Error: Source directory not found at $SOURCE_DIR"; exit 1; }

# Optional: Clean up previous builds if --clean is passed
if [ "$1" == "--clean" ]; then
    echo "==> Cleaning previous build artifacts..."
    if [ -f Makefile ]; then
        make distclean
    fi
fi

# Step 1: Autogen (Required for first-time build or after clean)
if [ ! -f configure ]; then
    echo "==> Running autogen.sh..."
    ./autogen.sh
fi

# Step 2: Configure
# Note: Optimized for X11 environment (as detected: x11)
echo "==> Configuring Emacs 30.2..."
./configure \
    --prefix="$INSTALL_PREFIX" \
    --with-native-compilation=aot \
    --with-tree-sitter \
    --with-json \
    --with-wide-int \
    --with-modules \
    --with-cairo \
    --with-harfbuzz \
    --with-imagemagick \
    --with-mailutils \
    --with-x-toolkit=gtk3 \
    --with-xwidgets

# Step 3: Build
echo "==> Starting build with $(nproc) processors..."
make -j$(nproc)

echo "==> Build complete!"
echo "To test it before installing: ./src/emacs"
echo "To install, run: sudo make install"
