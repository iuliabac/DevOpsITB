FROM php:8.2-apache

# Install dependencies needed for composer and Laravel
RUN apt-get update && apt-get install -y unzip curl libxml2-dev libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip dom

RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY . /var/www/html

# Run composer install to generate vendor folder
RUN composer install --no-dev --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Change Apache document root to Laravel's public folder
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80
