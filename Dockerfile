# Use the official PHP image with Apache
FROM php:8.2-apache

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache mod_rewrite for Laravel routes
RUN a2enmod rewrite

# Set the working directory in the container
WORKDIR /var/www/html/

# Copy Laravel app files into the container
COPY ./DevOpsITB /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80
