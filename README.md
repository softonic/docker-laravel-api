# docker-laravel-api
Base docker image for Laravel's API based.

This docker image is NOT intended to use as a standalone docker image. It will only work in combination with Laravel with specific folder structures

## Environmental variables to configure container start up

* `EXECUTE_DEV_INSTALL`: Executes composer install in dev mode
* `DO_NOT_EXECUTE_LARAVEL_OPTIMIZATION`: when informed, do not execute `php artisan optimize` and other artisan commands to optimize the code
* `EXECUTE_REFRESH_MIGRATIONS`: When informed executes refresh migrations (`php artisan migrate:refresh --seed`). When it's not informed executes `php artisan migrate --force`
