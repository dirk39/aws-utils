FROM node:10.16-jessie

# install java for dynamodb
RUN apt-get update && apt-get install -y default-jre

#installing go
RUN wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz && \
    tar -xvf go1.12.6.linux-amd64.tar.gz && \
    mv go /usr/local && rm go1.12.6.linux-amd64.tar.gz

ENV GOROOT /usr/local/go

ENV GOPATH $HOME/go/prj

ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

RUN go get -u github.com/aws/aws-lambda-go/lambda


#install ruby
RUN apt-get install -y ruby-full

#change npm global configuration
RUN mkdir ~/.npm-global && \
    npm config set prefix '~/.npm-global' && \
    export PATH=~/.npm-global/bin:$PATH

ENV NPM_CONFIG_PREFIX ~/.npm-global 

RUN chmod 777 -R /home/node 

USER node

#install global dependecies
RUN npm install -g go-npm

RUN npm install -g aws-sam-local --ignore-scripts

RUN npm install -g yarn

WORKDIR /home/node