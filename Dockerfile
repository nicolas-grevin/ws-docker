FROM debian:stable-slim

ARG NODE_VERSION=15

RUN apt-get update \
    && apt-get install --assume-yes curl

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs \
    && npm install --global yarn

RUN node --version \
    && npm --version \
    && yarn --version

RUN useradd node \
    && mkdir -p /home/node \
    && chown -R node:node /home/node

RUN apt-get clean

WORKDIR /home/node

USER node

CMD ["bash"]
