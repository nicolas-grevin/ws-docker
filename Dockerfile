ARG NODE_VERSION=15

FROM node:${NODE_VERSION}-alpine as dev

VOLUME /app
WORKDIR app
EXPOSE 3333
USER node

CMD ["node"]

FROM dev as prod

ADD . .

RUN yarn install

CMD ["yarn", "start"]
