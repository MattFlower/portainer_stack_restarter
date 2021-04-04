FROM alpine
RUN apk add httpie
RUN apk add jq

COPY ./restart.sh /restart.sh
ENTRYPOINT /restart.sh