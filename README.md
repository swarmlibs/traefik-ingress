# traefik-ingress
An ingress service using Traefik Edge Router

## Usage

> WIP

### Deploying / Exposing Services

While in Swarm Mode, Traefik uses labels found on services, not on individual containers. Therefore, if you use a compose file with Swarm Mode, labels should be defined in the deploy part of your service. This behavior is only enabled for docker-compose version 3+ ([Compose file reference](https://docs.docker.com/compose/compose-file/compose-file-v3/#deploy)).

```yaml
version: "3"
services:
  my-container:
    deploy:
      labels:
        - traefik.http.routers.my-container.rule=Host(`example.com`)
        - traefik.http.services.my-container-service.loadbalancer.server.port=8080
```
