FROM golang:1.26 AS builder

WORKDIR /app
RUN git clone https://github.com/TheTinkerDad/sensible.git .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /sensible

FROM ghcr.io/mpepping/podshell:4 AS runtime

USER root
COPY --from=builder /sensible /usr/local/bin/sensible
COPY ./include /
RUN /usr/local/bin/sensible -r

ENTRYPOINT [ "/usr/local/bin/sensible" ]
