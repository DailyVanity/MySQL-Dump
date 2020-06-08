FROM alpine:3.7
LABEL AUTHOR Chris Sim
LABEL EMAIL chris.sim@dailyvanity.sg

RUN apk add --no-cache mysql-client

RUN mkdir -p /backup

COPY entrypoint.sh /backup 

WORKDIR /backup
RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]