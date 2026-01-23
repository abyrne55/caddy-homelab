# caddy-homelab

Custom Caddy container image with plugins for homelab reverse proxy.

## Plugins

| Plugin | Purpose |
|--------|---------|
| [caddy-dns/cloudflare](https://github.com/caddy-dns/cloudflare) | DNS-01 ACME challenge via Cloudflare |
| [mholt/caddy-dynamicdns](https://github.com/mholt/caddy-dynamicdns) | Dynamic DNS updates |
| [hslatman/caddy-crowdsec-bouncer](https://github.com/hslatman/caddy-crowdsec-bouncer) | Crowdsec threat detection integration |
| [porech/caddy-maxmind-geolocation](https://github.com/porech/caddy-maxmind-geolocation) | Geofencing via MaxMind GeoIP |

## Usage

Pull the image:

```bash
podman pull ghcr.io/abyrne55/caddy-homelab:main
```

Run with a Caddyfile:

```bash
podman run -d \
  -p 80:80 -p 443:443 \
  -v /path/to/Caddyfile:/etc/caddy/Caddyfile:ro \
  -v caddy_data:/data \
  -v caddy_config:/config \
  ghcr.io/abyrne55/caddy-homelab:main
```

## Base Images

Built using [project-hummingbird](https://quay.io/organization/hummingbird) distroless base images:

- **Builder**: `quay.io/hummingbird/xcaddy` - xcaddy build environment (uses vendored plugins)
- **Runtime**: `quay.io/hummingbird/core-runtime` - minimal distroless runtime

Container runs as non-root user (UID 65532).

## Building Locally

```bash
# Clone with submodules
git clone --recursive https://github.com/abyrne55/caddy-homelab.git

# Or if already cloned, initialize submodules
git submodule update --init --recursive

# Build
podman build -t caddy-homelab:latest -f Containerfile .
```

## CI/CD

On push to `main`, GitHub Actions builds arm64 images and pushes to GHCR.
