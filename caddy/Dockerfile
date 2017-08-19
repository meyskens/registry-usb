FROM alpine

RUN apk add --no-cache tar curl bash

RUN curl https://getcaddy.com | bash -s tls.dns.cloudflare

EXPOSE 80 443

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/local/bin/caddy"]

CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]