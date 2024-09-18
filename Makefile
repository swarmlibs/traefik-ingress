detach := true

DOCKER_STACK := docker stack
DOCKER_STACK_NAMESPACE := traefik-ingress
DOCKER_STACK_CONFIG := docker stack config
DOCKER_STACK_CONFIG_ARGS := --skip-interpolation
DOCKER_STACK_DEPLOY_ARGS := --detach=$(detach) --with-registry-auth

# The stack files to include
# if docker-stack.override.yml file exists, include it
DOCKER_STACK_FILES := -c docker-stack.yml
ifneq ("$(wildcard docker-stack.override.yml)","")
	DOCKER_STACK_FILES += -c docker-stack.override.yml
endif

deploy: stack-networks stack-deploy
upgrade: stack-upgrade
remove: stack-remove

stack-networks:
	docker network create --scope=swarm --driver=overlay --attachable public || true
	docker network create --scope=swarm --driver=overlay --attachable traefik || true
stack-deploy:
	@echo '  ______                _____ __          '
	@echo ' /_  __/________ ____  / __(_) /__        '
	@echo '  / / / ___/ __ `/ _ \/ /_/ / //_/        '
	@echo ' / / / /  / /_/ /  __/ __/ / ,<           '
	@echo '/_/ /_/  _\__,_/\___/_/ /_/_/|_|          '
	@echo '        (_)___  ____ _________  __________'
	@echo '       / / __ \/ __ `/ ___/ _ \/ ___/ ___/'
	@echo '      / / / / / /_/ / /  /  __(__  |__  ) '
	@echo '     /_/_/ /_/\__, /_/   \___/____/____/  '
	@echo '             /____/                       '
	@echo '                                          '
	@echo "==> Deploying Traefik ingress stack:"
	@$(DOCKER_STACK) deploy $(DOCKER_STACK_DEPLOY_ARGS) --prune $(DOCKER_STACK_FILES) $(DOCKER_STACK_NAMESPACE)
stack-upgrade:
	@$(DOCKER_STACK) deploy $(DOCKER_STACK_DEPLOY_ARGS) --prune --resolve-image always $(DOCKER_STACK_FILES) $(DOCKER_STACK_NAMESPACE)
stack-remove:
	@$(DOCKER_STACK) rm $(DOCKER_STACK_NAMESPACE)
