FROM shanemcc/docker-apache-php-base:latest
MAINTAINER Shane Mc Cormack <dataforce@dataforce.org.uk>

RUN \
  apt-get update && apt-get install -y bind9utils sudo && \
  docker-php-source extract && \
  pecl install mongodb && \
  docker-php-ext-enable mongodb && \
  docker-php-ext-install pcntl && \
  docker-php-ext-install sockets && \
  apt-get install -y -f librabbitmq-dev libssh-dev && \
  docker-php-source extract && \
  mkdir /usr/src/php/ext/amqp && \
  curl -L https://github.com/php-amqp/php-amqp/archive/master.tar.gz | tar -xzC /usr/src/php/ext/amqp --strip-components=1 && \
  docker-php-ext-install amqp && \
  docker-php-ext-enable amqp && \
  docker-php-source delete && \
  echo "www-data  ALL=NOPASSWD: /usr/sbin/rndc" >> /etc/sudoers.d/99_rndc && \
  chmod 0440 /etc/sudoers.d/99_rndc
