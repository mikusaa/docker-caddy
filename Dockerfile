ARG CADDY_VERSION=latest

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddy-dns/alidns \
    --with github.com/caddy-dns/tencentcloud \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/caddyserver/replace-response \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/caddyserver/cache-handler

FROM caddy:${CADDY_VERSION}

RUN apk add --no-cache tzdata

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
