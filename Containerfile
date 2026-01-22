# Custom Caddy build with homelab plugins
# Built using project-hummingbird base images

FROM quay.io/hummingbird/xcaddy AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/porech/caddy-maxmind-geolocation

FROM quay.io/hummingbird/core-runtime:latest

COPY --from=builder /caddy/caddy /usr/bin/caddy

USER 65532
ENTRYPOINT ["/usr/bin/caddy"]
CMD ["run", "--config", "/etc/caddy/Caddyfile"]
