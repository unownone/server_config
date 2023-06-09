.DEFAULT_GOAL := build_run

.PHONY: check_docker check_docker_compose install_docker install_docker_compose build_run

check_docker:
	@echo "Checking if Docker is installed and running..."
	@docker --version || install_docker

install_docker:
	@echo "Installing Docker..."
	@sh -c "$$(curl -fsSL https://get.docker.com)"

check_docker_compose:
	@echo "Checking if Docker Compose is installed and running..."
	@docker-compose --version || install_docker_compose

install_docker_compose:
	@echo "Installing Docker Compose..."
	@sh -c "$$(curl -fsSL https://get.daocloud.io/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose) && chmod +x /usr/local/bin/docker-compose"

init:
	sudo bash init.sh

build_run:
	@echo ""
	@echo "___                       _       ____                           "
	@echo "|_ _|_ __ ___   ___  _ __ ( )___  / ___|  ___ _ ____   _____ _ __ "
	@echo " | || '_ \` _ \ / _ \| '_ \|// __| \___ \ / _ \ '__\ \ / / _ \ '__|"
	@echo " | || | | | | | (_) | | | | \__ \  ___) |  __/ |   \ V /  __/ |   "
	@echo "|___|_| |_| |_|\___/|_| |_| |___/ |____/ \___|_|    \_/ \___|_|   "
	@echo ""
	@echo " ____             __ _       "
	@echo "/ ___|___  _ __  / _(_) __ _ "
	@echo "| |   / _ \| '_ \| |_| |/ _  |"
	@echo "| |__| (_) | | | |  _| | (_| |"
	@echo " \____\___/|_| |_|_| |_|\__, |"
	@echo "                        |___/ "
	@echo ""
	make check_docker 
	make check_docker_compose
	@echo "######################################"
	@echo "##All Build Steps Passed. Please configure now.##"
	make init
	docker-compose up -d --build