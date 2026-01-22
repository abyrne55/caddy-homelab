# Custom Caddy build with homelab plugins
# Builder: official caddy builder (has git)
# Runtime: hummingbird caddy base (just replace binary)

FROM caddy:2-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/porech/caddy-maxmind-geolocation

FROM quay.io/hummingbird/caddy:2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
