FROM node:18-alpine AS build

RUN apk update

COPY .npmrc .
COPY entrypoint.sh .
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
