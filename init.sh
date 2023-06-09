#!/bin/sh

# Declare a global variable
DOMAIN=""

function create_env_file() {
    printf "#############################################\n"
    printf "########### Provide ENV values ##############\n"
    printf "#############################################\n\n\n"
    printf "Enter USER_EMAIL_ID to be used for LetsEncrypt\n"
    printf "Enter USER_EMAIL_ID: "
    read USER_EMAIL_ID
    printf "Enter DOMAIN to be used for routing.\n Make sure it is a top level domain. example example.com\n"
    printf "Enter DOMAIN: "
    read DOMAIN
    printf "AUTH PAIRS provides an easy way of defining basic auth to make sure only authorized users can access the dashboard.\n"
    printf "Enter PAIRs in this way username password , make sure to provide the space \n\n"
    printf "Enter TRAEFIK_AUTH_PAIRS: "
    read TRAEFIK_AUTH_PAIRS
    TRAEFIK_AUTH_PAIRS=$(htpasswd -nbB $TRAEFIK_AUTH_PAIRS | sed -e s/\\$/\\$\\$/g)
    # Create .env file with the values
    cat > .env << EOF
USER_EMAIL_ID=${USER_EMAIL_ID}
DOMAIN=${DOMAIN}
TRAEFIK_AUTH_PAIRS=${TRAEFIK_AUTH_PAIRS}
EOF
}


# Ask for user input
printf "Checking if .env is there already...\n"
if [ -f .env ]; then
    # Print env file contents
    printf ".env file exists.\n"
    printf "#############################################\n"
    printf "########### .env file contents ##############\n"
    printf "#############################################\n\n"
    cat .env
    printf "\n\n"
    printf "Do you want to continue with the existing .env file? (y/n): "
    read CONTINUE
    domain=""
    if [ "$CONTINUE" = "y" ]; then
        printf "Continuing with existing .env file...\n"
        DOMAIN=$(grep DOMAIN .env | cut -d= -f2)
    else
        printf "Creating new env file\n"
        create_env_file
        printf ".env file created successfully\n"
    fi
else
    printf ".env file does not exist. Creating new .env file...\n"
    create_env_file
    printf ".env file created successfully\n"
fi

# Create acme.json file with correct permissions
touch acme.json
chmod 600 acme.json

printf "acme.json file created successfully\n"

printf "Starting docker-compose...\n"

docker-compose up -d --build

printf "Your Portainer should be accesible at https://console.${DOMAIN}\n"