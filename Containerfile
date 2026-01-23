# Custom Caddy build with homelab plugins
# Builder: hummingbird xcaddy (no git, use vendored plugins)
# Runtime: hummingbird caddy base (just replace binary)

FROM quay.io/hummingbird/xcaddy AS builder

# Copy vendored plugin source code into builder
COPY plugins/caddy-dns-cloudflare /caddy/plugins/caddy-dns-cloudflare
COPY plugins/caddy-dynamicdns /caddy/plugins/caddy-dynamicdns
COPY plugins/caddy-crowdsec-bouncer /caddy/plugins/caddy-crowdsec-bouncer
COPY plugins/caddy-maxmind-geolocation /caddy/plugins/caddy-maxmind-geolocation

# Build with xcaddy using local module paths
WORKDIR /caddy
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare=/caddy/plugins/caddy-dns-cloudflare \
    --with github.com/mholt/caddy-dynamicdns=/caddy/plugins/caddy-dynamicdns \
    --with github.com/hslatman/caddy-crowdsec-bouncer=/caddy/plugins/caddy-crowdsec-bouncer \
    --with github.com/porech/caddy-maxmind-geolocation=/caddy/plugins/caddy-maxmind-geolocation

FROM quay.io/hummingbird/caddy:2

COPY --from=builder /caddy/caddy /usr/bin/caddy
