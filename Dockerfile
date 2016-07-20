FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 4.4.7
ENV SHASUMS256 f28beed1b553696c14af078e484439e7c0eb6510b5608235f60873ba238e3907

RUN wget --no-check-certificate "https://nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && sha256sum "node-v$NODE_VERSION-linux-x64.tar.xz" > SHASUMS256.txt \
  && cat SHASUMS256.txt | grep "$SHASUMS256  node-v$NODE_VERSION-linux-x64.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt

CMD [ "node" ]

# Create app directory
RUN mkdir -p /usr/src/app

# Install app dependencies
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules /usr/src/app/

WORKDIR /usr/src/app

# Bundle app source
COPY src /usr/src/app

EXPOSE 8080
CMD [ "npm", "start" ]