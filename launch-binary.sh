#!/bin/bash

set -e

# Repository details
REPO="ilkhom19/Credit_Card_Valitator"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="your_binary_name"
BINARY_PATH="$INSTALL_DIR/$BINARY_NAME"

# Function to get the local binary version
get_local_version() {
  if [ -f "$BINARY_PATH" ]; then
    version_output="$($BINARY_PATH --version)"
    echo "$version_output" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+$'
  else
    echo "none"
  fi
}

# Function to get the latest GitHub release version
get_latest_version() {
  curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

# Function to download the latest binary
download_binary() {
  case "$(uname -sm)" in
    "Darwin arm64") FILENAME="$BINARY_NAME-macOS-arm64" ;;
    "Linux x86_64") FILENAME="$BINARY_NAME-linux-amd64" ;;
    *) echo "Unsupported architecture: $(uname -sm)" >&2; exit 1 ;;
  esac

  URL="https://github.com/$REPO/releases/download/$1/$FILENAME"
  echo "Downloading $FILENAME version $1 from GitHub releases"
  curl -sSLf "$URL" -o "$BINARY_PATH" || {
    echo "Failed to download or write to $INSTALL_DIR; try with sudo" >&2
    exit 1
  }

  chmod +x "$BINARY_PATH" || {
    echo "Failed to set executable permission on $BINARY_PATH" >&2
    exit 1
  }

  echo "$BINARY_NAME version $1 is successfully installed"
}

# Check existing version and update if not the latest
local_version=$(get_local_version)
latest_version=$(get_latest_version)

if [ "$local_version" != "$latest_version" ]; then
  echo "Local version ($local_version) is different from the latest version ($latest_version). Updating..."
  if [ -f "$BINARY_PATH" ]; then
    echo "Existing binary found. Deleting..."
    rm "$BINARY_PATH" || {
      echo "Failed to remove existing binary; please check your permissions or try manually" >&2
      exit 1
    }
  fi
  download_binary "$latest_version"
else
  echo "No update needed. Local version ($local_version) is up-to-date."
fi
