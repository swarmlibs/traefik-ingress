## TEST

You can use stack to deploy a set of services for testing.

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/swarmlibs/dockerstack-schema/main/schema/dockerstack-spec.json

services:
  jmalloc-echo-server:
    image: jmalloc/echo-server
    networks:
      public:
    deploy:
      labels:
        - traefik.enable=true
        - traefik.http.routers.jmalloc-echo-server.rule=Host(`jmalloc-echo-server.internal`)
        - traefik.http.services.jmalloc-echo-server-service.loadbalancer.server.port=8080

  ealen-echo-server:
    image: ealen/echo-server
    networks:
      public:
    deploy:
      labels:
        - traefik.enable=true
        - traefik.http.routers.ealen-echo-server.rule=Host(`ealen-echo-server.internal`)
        - traefik.http.services.ealen-echo-server-service.loadbalancer.server.port=80

networks:
  public:
```
