# About

An ingress service using Traefik Edge Router for Docker Swarm. 

More information on Traefik and Docker can be found [here](https://docs.traefik.io/providers/docker/).

> [!IMPORTANT]
> This stack requires [swarmlibs/traefik-loadbalancer](https://github.com/swarmlibs/traefik-loadbalancer) stack.
> 
> As a note before you can use Traefik as an ingress, you must have the Traefik Load Balancer stack deployed.
> 
> ***The deployment of these stacks can be done in any order.***

## Deploying the stack

First, retrieve the stack YML manifest:

```sh
curl -L https://raw.githubusercontent.com/swarmlibs/traefik-ingress/main/docker-stack.yml -o traefik-ingress-stack.yml
```

Create the following networks (if they don't already exist):
```sh
docker network create --driver=overlay --attachable public
docker network create --driver=overlay --attachable traefik
```

Then use the downloaded YML manifest to deploy your stack:

```sh
docker stack deploy -c traefik-ingress-stack.yml traefik
```

## Overviews

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/fe5aed1d-a6ed-49f5-9e6a-25223ce326cc">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/user-attachments/assets/78894be1-585a-4e51-ad88-f8fc49668e6e">
  <img src="https://github.com/user-attachments/assets/78894be1-585a-4e51-ad88-f8fc49668e6e">
</picture>

## Accessing the Dashboard

The Traefik dashboard is available at `http://<traefik-ip>:8080`.

## Deploying / Exposing Services

While in Swarm Mode, Traefik uses labels found on services, not on individual containers. Therefore, if you use a compose file with Swarm Mode, labels should be defined in the deploy part of your service. This behavior is only enabled for docker-compose version 3+ ([Compose file reference](https://docs.docker.com/compose/compose-file/compose-file-v3/#deploy)).

```yaml
services:
  my-container:
    networks:
      # Attach the service to the public network
      public:
    deploy:
      labels:
        # Enable Traefik for this service
        - traefik.enable=true
        # Define the router/service
        - traefik.http.routers.my-container.rule=Host(`example.com`)
        # - traefik.http.routers.my-container.service=my-container-service # optional, if only one service is defined
        - traefik.http.services.my-container-service.loadbalancer.server.port=8080
        # Enable TLS (optional)
        - traefik.http.routers.my-container.tls=true
        - traefik.http.routers.my-container.tls.certresolver=letsencrypt # or letsencrypt-staging

# Define the "public" network
networks:
  public:
    name: public
    external: true
```

Read more about Traefik labels [here](https://doc.traefik.io/traefik/routing/providers/swarm/).
