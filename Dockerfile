FROM alpine:3.7
LABEL AUTHOR Chris Sim
LABEL EMAIL chris.sim@dailyvanity.sg

RUN apk add --no-cache mysql-client

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]