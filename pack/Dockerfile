FROM node:18-alpine AS build

RUN npm install -g @ovotech/avro-ts-cli

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT [ "/bin/entrypoint.sh"]