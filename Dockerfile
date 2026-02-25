FROM php:8.3-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpq-dev nginx nodejs npm \
    && docker-php-ext-install pdo pdo_pgsql

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Copy project
COPY . .

# PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# 🔥 BUILD FRONTEND (REQUIRED)
RUN npm install
RUN npm run build

# Permissions
RUN chown -R www-data:www-data storage bootstrap/cache

# nginx config
COPY docker/nginx.conf /etc/nginx/sites-available/default

EXPOSE 80

# start app
CMD service nginx start && php artisan migrate --force && php artisan db:seed --force && php-fpm