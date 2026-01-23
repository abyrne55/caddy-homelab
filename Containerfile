# Custom Caddy build with homelab plugins
# Builder: hummingbird xcaddy (no git, use vendored plugins)
# Runtime: hummingbird caddy base (just replace binary)

FROM quay.io/hummingbird/xcaddy AS builder

# Copy vendored plugin source code into builder
COPY plugins/caddy-dns-cloudflare /build/plugins/caddy-dns-cloudflare
COPY plugins/caddy-dynamicdns /build/plugins/caddy-dynamicdns
COPY plugins/caddy-crowdsec-bouncer /build/plugins/caddy-crowdsec-bouncer
COPY plugins/caddy-maxmind-geolocation /build/plugins/caddy-maxmind-geolocation

# Build with xcaddy using local module paths
WORKDIR /build
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare=/build/plugins/caddy-dns-cloudflare \
    --with github.com/mholt/caddy-dynamicdns=/build/plugins/caddy-dynamicdns \
    --with github.com/hslatman/caddy-crowdsec-bouncer=/build/plugins/caddy-crowdsec-bouncer \
    --with github.com/porech/caddy-maxmind-geolocation=/build/plugins/caddy-maxmind-geolocation

FROM quay.io/hummingbird/caddy:2

COPY --from=builder /build/caddy /usr/bin/caddy
