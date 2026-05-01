#!/bin/bash
set -e

echo "Installing dependencies..."

if [ "$(uname)" = "Darwin" ]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Install it from https://brew.sh and re-run."
        exit 1
    fi
    brew install gcc ncurses

elif [ -f /etc/debian_version ]; then
    sudo apt update && sudo apt install -y gcc make libncurses-dev

elif [ -f /etc/redhat-release ]; then
    sudo dnf install -y gcc make ncurses-devel

else
    echo "Unsupported distro. Install gcc, make, and libncurses-dev manually."
    exit 1
fi

echo "Done! Run 'make' to build your project."