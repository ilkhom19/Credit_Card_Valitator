#!/bin/bash

# GitHub user/repo
REPO="ilkhom19/Credit_Card_Valitator"

# Binary name - update this as needed
BINARY_NAME="io-ne"

# GitHub API URL to fetch the latest release
API_URL="https://api.github.com/repos/$REPO/releases/latest"

# Install jq if not present (uncomment the next line if needed)
# sudo apt-get install jq # on Debian/Ubuntu systems

# Get the latest release data using curl and jq to extract the tag_name
TAG_NAME=$(curl -s $API_URL | jq -r '.tag_name')

# Check if we got a tag name
if [ -z "$TAG_NAME" ] || [ "$TAG_NAME" == "null" ]; then
  echo "Failed to fetch latest release tag."
  exit 1
fi

# Construct the download URL using the tag name and binary name
BINARY_URL="https://github.com/$REPO/releases/download/$TAG_NAME/$BINARY_NAME"

# Define where to save the binary
BINARY_LOCAL_PATH="/usr/local/bin/$BINARY_NAME"

# Check if the binary already exists and delete it if it does
if [ -f "$BINARY_LOCAL_PATH" ]; then
  echo "Existing binary found. Deleting..."
  rm "$BINARY_LOCAL_PATH"
fi

# Use curl to download the binary
curl -L $BINARY_URL -o $BINARY_LOCAL_PATH

# Check if the download was successful by inspecting the first few bytes of the file
echo "File type and content check:"
file $BINARY_LOCAL_PATH
head $BINARY_LOCAL_PATH

# Validate if the downloaded file is what we expect
file $BINARY_LOCAL_PATH | grep -q 'executable' || {
    echo "The downloaded file is not a valid executable or could not be found."
    exit 1
}

# Make the binary executable
chmod +x $BINARY_LOCAL_PATH

# Execute the binary with all passed arguments
$BINARY_LOCAL_PATH "$@"
