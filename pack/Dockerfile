FROM node:18-alpine AS build

RUN apk update
RUN apk add --no-cache gettext

RUN npm install -g @ovotech/avro-ts-cli

COPY package.json.tpl package.json.tpl
COPY tsconfig.json tsconfig.json
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT [ "/bin/entrypoint.sh"]