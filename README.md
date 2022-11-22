# server_config
Server Config that is running on DigitalOcean
## ENV REQUIRED


Create a .env file and put these in.

# Set UP:
- clone repo
- set up env
  - USER_EMAIL_ID = user's email id for letsencrypt
  - DOMAIN = user's domain that is the main domain
  - TRAEFIK_AUTH_PAIRS = Traefik auth pairs to be taken care of.
  save this in .env file
  
- Set up a file called `acme.json`
- change access to 600 ie `chmod 600 acme.json`
- run server with `docker-compose up -d --build`
