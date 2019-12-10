# vim: set ft=dockerfile :

#
# Build Container
#

FROM alpine AS build
LABEL maintainer "Takumi Takahashi <takumiiinn@gmail.com>"

RUN echo "Build Config Starting" \
 && apk --update add \
    wget \
    ca-certificates \
    php7 \
    php7-fpm \
    php7-apcu \
    php7-opcache \
    php7-ldap \
    php7-xml \
    php7-zip \
    php7-curl \
    php7-gd \
    php7-json \
    php7-session \
    php7-gettext \
    php7-openssl \
 && echo "Build Config Complete!"

# Install Dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Copy Source Code
COPY ./upstream/lam /usr/local/lam

# Copy Config File
RUN mkdir -p /usr/local/etc
COPY ./injection/php-fpm.conf.tmpl /usr/local/etc/php-fpm.conf.tmpl
COPY ./injection/nginx.conf.tmpl /usr/local/etc/nginx.conf.tmpl
COPY ./injection/config.cfg.tmpl /usr/local/etc/config.cfg.tmpl

# Copy Entrypoint Script
COPY ./injection/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh

#
# Deploy Container
#

FROM alpine AS prod
LABEL maintainer "Takumi Takahashi <takumiiinn@gmail.com>"

COPY --from=build /usr/local /usr/local

RUN echo "Deploy Config Starting" \
 && apk --no-cache --update add \
    runit \
    nginx \
    php7 \
    php7-fpm \
    php7-apcu \
    php7-opcache \
    php7-ldap \
    php7-xml \
    php7-xmlreader \
    php7-xmlwriter \
    php7-zip \
    php7-curl \
    php7-gd \
    php7-json \
    php7-session \
    php7-gettext \
    php7-openssl \
 && echo "Deploy Config Complete!"

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["ldap-account-manager"]
EXPOSE 80 443
