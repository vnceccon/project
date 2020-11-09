FROM debian:latest
MAINTAINER vinicius ceccon<vnceccon@gmail.com>
LABEL Description="My App Container" Vendor="N/A"

ENV APP_DIR="/var/www/site" \
NGINX_CONF_DIR="/etc/nginx/" \
APP_PORT="80"

RUN apt-get update \
&& apt-get install -y \
ca-certificates apt-transport-https \
curl wget gnupg2 \
ca-certificates \
lsb-release \
apt-transport-https \
&& wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
&& echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list \
&& apt-get update \
&& apt-get install -y \
nginx \
php7.4-zip \
php7.4-fpm \
php7.4-common \
php7.4-mbstring \
php7.4-xmlrpc \
php7.4-soap \
php7.4-gd \
php7.4-xml \
php7.4-intl \
php7.4-mysql \
php7.4-cli \
php7.4-zip \
php7.4-curl \
supervisor \
&& mkdir /run/php \
&& mkdir -p /var/log/supervisor \
&& mkdir -p /etc/supervisor/conf.d/ \
&& mkdir /var/www/site \
&& chown -R www-data:www-data /var/www/site \
&& rm ${NGINX_CONF_DIR}/sites-enabled/* \
&& rm ${NGINX_CONF_DIR}/sites-available/* \
&& rm -rf /var/www/html/* \
&& rmdir /var/www/html \
&& rm -rf /etc/supervisor/supervisord.conf \
&& ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

COPY . $APP_DIR
COPY devops/app.conf /etc/nginx/sites-enabled/app.conf
COPY devops/app.conf /etc/nginx/sites-available/app.conf
COPY devops/supervisord.conf /etc/supervisor/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
