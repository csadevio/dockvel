FROM ubuntu:latest
ENV PATH_SRV /srv
ENV PATH_DATA /data
ENV GITHUB_TOKEN unknown
MAINTAINER "Christian Sakshaug" <christian@comunic.no>

# Create directories
RUN mkdir -p $PATH_SRV
RUN mkdir -p $PATH_DATA

WORKDIR $PATH_SRV

# Add files
ADD . $PATH_SRV
ADD .env.example $PATH_DATA/.env
RUN ln -s $PATH_DATA/.env $PATH_SRV/.env

# Install dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install php5-cli -y
RUN apt-get install curl -y
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Running composer
RUN composer config github-oauth.github.com $GITHUB_TOKEN
RUN composer clearcache
RUN composer install
RUN composer update
RUN composer dumpautoload

# Execute artisan commands
RUN php artisan cache:clear
RUN php artisan config:cache
#RUN php artisan route:cache

# Add volume
VOLUME $PATH_SRV

# Return true
CMD ["true"]
