#!/bin/bash

# Check if make is installed
if ! command -v make &> /dev/null
then
    # Install make
    if command -v apt-get &> /dev/null
    then
        # Debian/Ubuntu
        sudo apt-get update
        sudo apt-get install make
    elif command -v yum &> /dev/null
    then
        # CentOS/Fedora
        sudo yum install make
    elif command -v brew &> /dev/null
    then
        # macOS (using Homebrew)
        brew install make
    else
        echo "Error: make is not installed and package manager not found"
        exit 1
    fi
else
    echo "make is already installed"
fi

# Clone the repository
git clone https://github.com/unownone/server_config.git

# Change to the repository directory
cd server_config

# Run make
make -i -s