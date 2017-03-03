FROM node:boron

RUN mkdir -p /var/www/evanwang0
ADD . /var/www/evanwang0
WORKDIR /var/www/evanwang0

RUN yarn
