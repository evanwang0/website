FROM nginx:stable-alpine

RUN rm -rf /etc/nginx/*
COPY nginx /etc/nginx

RUN mkdir /etc/nginx/sites-enabled
RUN ln -s /etc/nginx/sites-available/www.conf /etc/nginx/sites-enabled/www.conf
