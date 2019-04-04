# https://citizen428.net/blog/multi-stage-docker-builds-for-crystal/

FROM alpine:latest
# py-pip && pip install docker-compose
RUN apk add -u crystal shards libc-dev yaml-dev docker
WORKDIR /src
COPY . .
RUN shards install
RUN crystal build --release  src/run.cr -o /src/up
ENTRYPOINT ["/src/up"]
