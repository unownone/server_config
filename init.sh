#!/bin/sh

# Ask for user input
printf "Enter `USER_EMAIL_ID` to be used for LetsEncrypt \n"
printf "Enter USER_EMAIL_ID: \n "
read USER_EMAIL_ID
printf "Enter DOMAIN to be used for routing. Make sure it is a top level domain. example `example.com` \n"
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

printf ".env file created successfully\n"

# Create acme.json file with correct permissions
touch acme.json
chmod 600 acme.json

printf "acme.json file created successfully\n"

printf "Starting docker-compose...\n"

docker-compose up -d --build

printf "Your Portainer should be accesible at https://console.${DOMAIN}\n"