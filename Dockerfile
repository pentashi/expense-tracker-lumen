# Use official PHP image
FROM php:8.3-cli

# Install required extensions
RUN apt-get update && apt-get install -y \
    unzip \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy app files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose Render's port
EXPOSE 10000

# Run Lumen with PHP built-in server
CMD ["php", "-S", "0.0.0.0:10000", "-t", "public"]
