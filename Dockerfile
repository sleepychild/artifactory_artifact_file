FROM alpine:latest

RUN apk update && apk upgrade 
RUN apk add python3 py3-pip py3-requests

# The bash and jq / jf route
RUN apk add jq curl
RUN curl -fL https://install-cli.jfrog.io | sh
ENV CI=true

ADD opt/resource /opt/resource
