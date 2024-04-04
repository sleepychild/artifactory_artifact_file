FROM alpine:latest

RUN apk update && apk upgrade 
RUN apk add python3 py3-pip

# The bash and jq / jf route
RUN apk add jq curl
RUN curl -fL https://install-cli.jfrog.io | sh
ENV CI=true

ADD opt .
