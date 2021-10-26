FROM registry.shanemcc.net/public/docker-apache-php-base:latest
MAINTAINER Shane Mc Cormack <dataforce@dataforce.org.uk>

RUN \
  apt-get update && apt-get -y install apt-transport-https lsb-release ca-certificates curl && \
  wget -O /etc/apt/trusted.gpg.d/bind.gpg https://packages.sury.org/bind/apt.gpg && \
  sh -c 'echo "deb https://packages.sury.org/bind/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/bind.list' && \
  apt-get update && apt-get install -y bind9utils sudo && \
  docker-php-source extract && \
  pecl install mongodb && \
  docker-php-ext-enable mongodb && \
  docker-php-ext-install pcntl && \
  docker-php-ext-install sockets && \
  docker-php-source delete && \
  echo "www-data  ALL=NOPASSWD: /usr/sbin/rndc" >> /etc/sudoers.d/99_rndc && \
  chmod 0440 /etc/sudoers.d/99_rndc
