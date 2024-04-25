#!/bin/bash

# GitHub user/repo
REPO="ilkhom19/Credit_Card_Valitator"

# Binary name - update this as needed
BINARY_NAME="your_binary_name"

# GitHub API URL to fetch the latest release
API_URL="https://api.github.com/repos/$REPO/releases/latest"

# Get the latest release data using curl and extract the tag_name
TAG_NAME=$(curl -s $API_URL | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Check if we got a tag name
if [ -z "$TAG_NAME" ]; then
  echo "Failed to fetch latest release tag."
  exit 1
fi

# Construct the download URL using the tag name and binary name
BINARY_URL="https://github.com/$REPO/releases/download/$TAG_NAME/$BINARY_NAME"

# Define where to save the binary
BINARY_LOCAL_PATH="/usr/local/bin/$BINARY_NAME"

# Use curl to download the binary
curl -L $BINARY_URL -o $BINARY_LOCAL_PATH

# Check if the download was successful
if [ ! -f "$BINARY_LOCAL_PATH" ]; then
  echo "Failed to download the binary."
  exit 1
fi

# Make the binary executable
chmod +x $BINARY_LOCAL_PATH

# Execute the binary with all passed arguments
$BINARY_LOCAL_PATH "$@"
