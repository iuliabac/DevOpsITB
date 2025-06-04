FROM php:8.2-apache

# Install system dependencies required for Laravel and Composer
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip dom

# Enable Apache mod_rewrite for Laravel routes
RUN a2enmod rewrite

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html/

# Copy Laravel app files
COPY . /var/www/html/

# Change Apache document root to Laravel's public folder
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Set permissions for www-data user
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Run composer install to install dependencies and generate vendor/
RUN composer install --no-dev --optimize-autoloader

# Suppress ServerName warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Expose port 80
EXPOSE 80
