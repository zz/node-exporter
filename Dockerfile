FROM       golang:1.12 AS builder

WORKDIR /go/src/github.com/prometheus/node_exporter
COPY . .
RUN go get && \
        CGO_ENABLED=0 go build -o node_exporter

FROM        quay.io/prometheus/busybox:glibc
MAINTAINER  The Prometheus Authors <prometheus-developers@googlegroups.com>

COPY --from=builder  /go/src/github.com/prometheus/node_exporter/node_exporter /bin/node_exporter

EXPOSE      9100
USER        nobody
ENTRYPOINT  [ "/bin/node_exporter" ]
