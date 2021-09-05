FROM php:8.0-fpm-buster
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

#######################################################
# Envs
#######################################################
ENV TZ=UTC \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8

#######################################################
# Basics
#######################################################
RUN apt-get update && \
  apt-get -y install git libicu-dev libonig-dev libzip-dev unzip locales && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  locale-gen en_US.UTF-8 && \
  localedef -f UTF-8 -i en_US en_US.UTF-8 && \
  mkdir /var/run/php-fpm && \
  docker-php-ext-install intl pdo_mysql zip bcmath
COPY ./docker/php/php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

#######################################################
# Dev tools
#######################################################
RUN apt-get update && apt-get install -y zip unzip cron vim wget

#######################################################
# Composer
#######################################################
RUN wget https://getcomposer.org/composer-stable.phar \
  && mv composer-stable.phar /usr/local/bin/composer \
  && chmod 755 /usr/local/bin/composer

#######################################################
# PGSQL
#######################################################
RUN apt-get update && apt-get install -y libpq-dev \
  && docker-php-ext-install pdo_pgsql

#######################################################
# User
#######################################################
RUN useradd -ms /bin/bash docker && adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#######################################################
# .bashrc
#######################################################
USER docker
RUN echo 'eval "$(symfony-autocomplete)"' > ~/.bash_profile
RUN { \
  echo "alias ls='ls --color=auto'"; \
  echo "alias ll='ls --color=auto -alF'"; \
  echo "alias la='ls --color=auto -A'"; \
  echo "alias l='ls --color=auto -CF'"; \
  } >> ~/.bashrc

USER root
WORKDIR /app