FROM php:8.3-cli

# |--------------------------------------------------------------------------
# | Basic tools setup
# |--------------------------------------------------------------------------
# |
RUN apt update && apt install -y git unzip make
RUN apt autoremove

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_MEMORY_LIMIT=-1

# |--------------------------------------------------------------------------
# | Composer
# |--------------------------------------------------------------------------
# |
RUN cd ~ \
    && curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php \
    && HASH=`curl -sS https://composer.github.io/installer.sig` \
    && echo $HASH \
    && php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && composer

ENV PATH="~/.composer/vendor/bin:${PATH}"

RUN mkdir -p /app
RUN mkdir -p /codebase
COPY ./src /app

RUN composer global config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true
RUN composer global config repositories.justcoded/php-code-analysis-tool path /app
RUN composer global require -W \
    justcoded/php-code-analysis-tool:* \
    symplify/coding-standard:^12.2 \
    symplify/easy-coding-standard:^12.5 \
    friendsofphp/php-cs-fixer:^3.68 \
    kubawerlos/php-cs-fixer-custom-fixers:^3.22 \
    squizlabs/php_codesniffer:^3.11 \
    slevomat/coding-standard:^8.15

WORKDIR /codebase

CMD ["/root/.composer/vendor/bin/ecs", "--config", "/app/ecs.php"]
