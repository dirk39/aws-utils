FROM node:10.16-jessie

RUN apt-get update && apt-get install -y golang

RUN mkdir ~/.npm-global && \
    npm config set prefix '~/.npm-global' && \
    export PATH=~/.npm-global/bin:$PATH && \
    NPM_CONFIG_PREFIX=~/.npm-global 

RUN npm install -g go-npm

RUN npm install -g aws-sam-local --ignore-scripts