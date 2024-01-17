docker_stack_name := dockerswarm_ingress

.EXPORT_ALL_VARIABLES:
-include .env

deploy:
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

teardown:
	docker stack rm $(docker_stack_name)

.PHONY: example
example:
	@$(MAKE) -C example
example/teardown:
	@$(MAKE) -C example teardown
