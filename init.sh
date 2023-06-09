#!/bin/sh

function create_env_file() {
    printf "Enter USER_EMAIL_ID to be used for LetsEncrypt"
    printf "Enter USER_EMAIL_ID: \n"
    read USER_EMAIL_ID
    printf "Enter DOMAIN to be used for routing. Make sure it is a top level domain. example example.com"
    printf "Enter DOMAIN: "
    read DOMAIN
    printf "Enter TRAEFIK_AUTH_PAIRS (Optional): "
    read TRAEFIK_AUTH_PAIRS
    # Create .env file with the values
    cat > .env << EOF
USER_EMAIL_ID=${USER_EMAIL_ID}
DOMAIN=${DOMAIN}
TRAEFIK_AUTH_PAIRS=${TRAEFIK_AUTH_PAIRS}
EOF
    echo "$DOMAIN"
}


# Ask for user input
printf "Checking if .env is there already..."
if [ -f .env ]; then
    # Print env file contents
    printf ".env file exists. Printing contents...\n"
    cat .env
    printf "\n"
    printf "Do you want to continue with the existing .env file? (y/n): "
    read CONTINUE
    domain=""
    if [ "$CONTINUE" = "y" ]; then
        printf "Continuing with existing .env file...\n"
        domain=$(grep DOMAIN .env | cut -d= -f2)
    else
        printf "Creating new env file\n"
        domain=$(create_env_file)
        printf ".env file created successfully\n"
    fi
else
    printf ".env file does not exist. Creating new .env file...\n"
    domain=$(create_env_file)
    printf ".env file created successfully\n"
fi

# Create acme.json file with correct permissions
touch acme.json
chmod 600 acme.json

printf "acme.json file created successfully\n"

printf "Starting docker-compose...\n"

docker-compose up -d --build

printf "Your Portainer should be accesible at https://console.${domain}\n"