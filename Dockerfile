FROM registry.shanemcc.net/public/docker-apache-php-base:latest
MAINTAINER Shane Mc Cormack <dataforce@dataforce.org.uk>

RUN \
  apt-get -y update && apt-get -y install apt-utils software-properties-common dctrl-tools && \
  add-apt-repository -y ppa:isc/bind && \
  apt-get update && apt-get install -y bind9utils sudo && \
  docker-php-source extract && \
  pecl install mongodb && \
  docker-php-ext-enable mongodb && \
  docker-php-ext-install pcntl && \
  docker-php-ext-install sockets && \
  docker-php-source delete && \
  echo "www-data  ALL=NOPASSWD: /usr/sbin/rndc" >> /etc/sudoers.d/99_rndc && \
  chmod 0440 /etc/sudoers.d/99_rndc
