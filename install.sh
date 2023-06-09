#!/bin/bash
echo ""
echo "___                       _       ____                           "
echo "|_ _|_ __ ___   ___  _ __ ( )___  / ___|  ___ _ ____   _____ _ __ "
echo " | || '_ \` _ \ / _ \| '_ \|// __| \___ \ / _ \ '__\ \ / / _ \ '__|"
echo " | || | | | | | (_) | | | | \__ \  ___) |  __/ |   \ V /  __/ |   "
echo "|___|_| |_| |_|\___/|_| |_| |___/ |____/ \___|_|    \_/ \___|_|   "
echo ""
echo " ____             __ _       "
echo "/ ___|___  _ __  / _(_) __ _ "
echo "| |   / _ \| '_ \| |_| |/ _  |"
echo "| |__| (_) | | | |  _| | (_| |"
echo " \____\___/|_| |_|_| |_|\__, |"
echo "                        |___/ "
echo ""

echo "This script will install docker, docker-compose, git and apache2-utils"

echo "Traefik + Portainer for easy access DevOps"

# Check if docker is installed
if ! command -v docker &> /dev/null
then
    # Install docker
    if command -v apt-get &> /dev/null
    then
        # Debian/Ubuntu
        sudo apt-get install docker
    elif command -v yum &> /dev/null
    then
        # CentOS/Fedora
        sudo yum install docker
    elif command -v brew &> /dev/null
    then
        # macOS (using Homebrew)
        brew install docker
    else
        echo "Error: docker is not installed and package manager not found"
        exit 1
    fi
else
    echo "docker is already installed"
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null
then
    # Install docker-compose
    if command -v apt-get &> /dev/null
    then
        # Debian/Ubuntu
        sudo apt-get install docker-compose
    elif command -v yum &> /dev/null
    then
        # CentOS/Fedora
        sudo yum install docker-compose
    elif command -v brew &> /dev/null
    then
        # macOS (using Homebrew)
        brew install docker-compose
    else
        echo "Error: docker-compose is not installed and package manager not found"
        exit 1
    fi
else
    echo "docker-compose is already installed"
fi

# Check if git is installed
if ! command -v git &> /dev/null
then
    # Install git
    if command -v apt-get &> /dev/null
    then
        # Debian/Ubuntu
        sudo apt-get install git
    elif command -v yum &> /dev/null
    then
        # CentOS/Fedora
        sudo yum install git
    elif command -v brew &> /dev/null
    then
        # macOS (using Homebrew)
        brew install git
    else
        echo "Error: git is not installed and package manager not found"
        exit 1
    fi
else
    echo "git is already installed"
fi

# Check if htpasswd is installed
if ! command -v htpasswd &> /dev/null
then
    # Install htpasswd
    if command -v apt-get &> /dev/null
    then
        # Debian/Ubuntu
        sudo apt-get install apache2-utils
    elif command -v yum &> /dev/null
    then
        # CentOS/Fedora
        sudo yum install httpd-tools
    elif command -v brew &> /dev/null
    then
        # macOS (using Homebrew)
        brew install httpd-tools
    else
        echo "Error: htpasswd is not installed and package manager not found"
        exit 1
    fi
else
    echo "htpasswd is already installed"
fi



# Clone the repository
git clone https://github.com/unownone/server_config.git

# Change to the repository directory
cd server_config

# Initialize the .env file
# Get environment and execute init.sh script
bash init.sh
