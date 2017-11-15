#!/bin/sh

set -e

if [ ! -z ${EXECUTE_DEV_INSTALL+x} ]; then
    composer install --no-interaction
    composer clear-cache
fi
if [ -z ${EXECUTE_LARAVEL_OPTIMIZATION+x} ]; then
    php artisan config:cache
    php artisan route:cache
    php artisan vendor:publish --tag=public
fi

if [ ! -z ${EXECUTE_REFRESH_MIGRATIONS+x} ]; then
    php artisan migrate:refresh --seed
else
    php artisan migrate --force
fi

exec "$@"
