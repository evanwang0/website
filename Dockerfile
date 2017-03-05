FROM node:boron

RUN mkdir -p /var/www/evanwang0
WORKDIR /var/www/evanwang0
COPY . .

RUN yarn
