#builder for ts to js
FROM node:20 AS build
RUN mkdir -p tocomp
COPY ./stage1/ ./tocomp
WORKDIR /tocomp
RUN npm init -y
RUN npm install --save-dev typescript
RUN npx tsc
#move html to dist allow a single copy of dist 
RUN mv *.html ./dist

#nginx
FROM nginx:1.29.0
RUN apt update -y  && rm -rf /var/lib.apt/lists/*
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/ssl.key -out /etc/nginx/ssl/ssl.crt -subj "/CN=localhost"
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build ./tocomp/dist/ /usr/share/nginx/html
