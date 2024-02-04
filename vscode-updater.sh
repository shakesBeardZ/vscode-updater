#!/bin/bash
# Script to update Visual Studio Code on Linux
# This script requires wget and dpkg to be installed on the system.
# It also requires root privileges to install Visual Studio Code.
# Written by: ShakesBeardz

# Function to display a spinner
show_spinner() {
    local -r msg="$1"
    local -r pid=$!
    local spin='-\|/'

    echo -n $msg

    # Display spinner while the process is running
    while kill -0 $pid 2>/dev/null; do
        for i in ${spin}; do
            echo -ne "\b$i"
            sleep 0.1
        done
    done

    echo -ne "\b"
}

echo "Starting Visual Studio Code update..."

# Downloading Visual Studio Code
wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O /tmp/code_latest_amd64.deb & show_spinner "Downloading Visual Studio Code... "

# Check if wget was successful
if [ $? -ne 0 ]; then
    echo "Error: Download failed."
    exit 1
fi

echo "Download complete."

# Installing Visual Studio Code
sudo dpkg -i /tmp/code_latest_amd64.deb & show_spinner "Installing Visual Studio Code... "

# Check if dpkg was successful
if [ $? -ne 0 ]; then
    echo "Error: Installation failed."
    exit 1
fi

echo "Installation complete."
echo "Visual Studio Code has been updated successfully."
