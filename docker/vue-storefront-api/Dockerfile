FROM node:10-alpine

ENV VS_ENV dev

# RUN touch /var/run/nginx.pid
# RUN mkdir /sock

# RUN apk update && \
#     apk add --nocache curl libnss3-tools openssl

# RUN mkdir /etc/nginx/certs \
#   && echo -e "\n\n\n\n\n\n\n" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/nginx.key -out /etc/nginx/certs/nginx.crt

# RUN ( \
#   cd /usr/local/bin/ \
#   && curl -L https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64 -o mkcert \
#   && chmod +x mkcert \
#   )

# COPY ./conf/nginx.conf /etc/nginx/
# COPY ./conf/default.conf /etc/nginx/conf.d/

# RUN mkdir -p /etc/nginx/html /var/www/html \
#   && chown -R /etc/nginx /var/www /var/cache/nginx /var/run/nginx.pid /sock

# SSL Signing
# RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
# COPY ./mycert.crt /usr/local/share/ca-certificates/mycert.crt
# RUN chmod 644 /usr/local/share/ca-certificates/mycert.crt && update-ca-certificates

WORKDIR /var/www

RUN apk add --no-cache curl git bash

COPY  package.json  \
  yarn.lock         \
  babel.config.js   \
  ecosystem.json    \
  tsconfig.json     \
  nodemon.json      \
  ./

RUN apk add --no-cache --virtual .build-deps ca-certificates wget python make g++ && \
    yarn install --no-cache && \
    apk del .build-deps

COPY config/ /var/www/config/
COPY src/ /var/www/src/
COPY var/ /var/www/var/
COPY migrations /var/www/migrations/
COPY scripts/ /var/www/scripts/

COPY docker/vue-storefront-api/vue-storefront-api.sh /usr/local/bin/

CMD ["vue-storefront-api.sh"]
