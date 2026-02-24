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

# Install PHP deps
RUN composer install --no-dev --optimize-autoloader

# BUILD FRONTEND
RUN npm install
RUN npm run build

# Permissions
RUN chmod -R 775 storage bootstrap/cache
RUN chown -R www-data:www-data storage bootstrap/cache

# nginx
COPY docker/nginx.conf /etc/nginx/sites-available/default

# clear cache
RUN php artisan config:clear
RUN php artisan cache:clear

EXPOSE 80

CMD service nginx start && php artisan migrate --force && php-fpm && php artisan db:seed --force