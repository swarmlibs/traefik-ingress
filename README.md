# traefik-ingress
An ingress service using Traefik Edge Router

## Traefik & Docker 

More information on Traefik and Docker can be found [here](https://docs.traefik.io/providers/docker/).

## Deploying Traefik

> WIP

### Deploying / Exposing Services

While in Swarm Mode, Traefik uses labels found on services, not on individual containers. Therefore, if you use a compose file with Swarm Mode, labels should be defined in the deploy part of your service. This behavior is only enabled for docker-compose version 3+ ([Compose file reference](https://docs.docker.com/compose/compose-file/compose-file-v3/#deploy)).

```yaml
services:
  my-container:
    networks:
      # Attach the service to the traefik_ingress network
      traefik_ingress:
    deploy:
      labels:
        # Enable Traefik for this service
        - traefik.enable=true
        - traefik.http.routers.my-container.rule=Host(`example.com`)
        - traefik.http.services.my-container-service.loadbalancer.server.port=8080

# Define the traefik_ingress network
networks:
  traefik_ingress:
    name: traefik_ingress
    external: true
```
