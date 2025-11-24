# Use official PHP + Apache image
FROM php:8.2-apache

# Directory where your PHP application will live
ENV APP_DIR=/var/www/html/phpstatic

# Enable Apache modules
RUN a2enmod rewrite

# Create directory for your app
RUN mkdir -p $APP_DIR

# Copy your source code into the container
COPY . $APP_DIR/

# Copy custom Apache configuration
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Set recommended permissions
RUN chown -R www-data:www-data $APP_DIR && \
    find $APP_DIR -type d -exec chmod 755 {} \; && \
    find $APP_DIR -type f -exec chmod 644 {} \;

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
