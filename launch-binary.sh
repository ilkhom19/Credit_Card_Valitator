
#!/bin/bash

set -e
#REPO="ionet-official/io_launch_binaries"
REPO="ilkhom19/Credit_Card_Valitator"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="io-net-launcher"
BINARY_PATH="$INSTALL_DIR/$BINARY_NAME"

# Function to get the local binary version
get_local_version() {
  if [ -f "$BINARY_PATH" ]; then
    # Use the binary with the --version flag, parse its output to extract just the version number
    version_output="$($BINARY_PATH --version)"
    # Assuming the version string is always at the end, following a space
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
    "Darwin arm64") FILENAME="io-net-launcher-macOS-arm64" ;;
    "Linux x86_64") FILENAME="io-net-launcher-linux-amd64" ;;
    *) echo "Unsupported architecture: $(uname -sm)" >&2; exit 1 ;;
  esac

  URL="https://github.com/$REPO/releases/download/$1/$FILENAME"
  echo "Downloading $FILENAME version $1 from GitHub releases"
  if ! curl -sSLf "$URL" -o "$BINARY_PATH"; then
    echo "Failed to download or write to $INSTALL_DIR; try with sudo" >&2
    exit 1
  fi

  if ! chmod +x "$BINARY_PATH"; then
    echo "Failed to set executable permission on $BINARY_PATH" >&2
    exit 1
  fi

  echo "$BINARY_NAME version $1 is successfully installed"
}

local_version=$(get_local_version)
latest_version=$(get_latest_version)

if [ "$local_version" != "$latest_version" ]; then
  echo "Local version ($local_version) is different from the latest version ($latest_version). Updating..."
  download_binary "$latest_version"
else
  echo
fi

# Execute the binary with the provided flags and options
"$BINARY_PATH" "$@"
