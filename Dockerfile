# syntax=docker/dockerfile:1.7

ARG GO_VERSION=1.26.4
ARG SENSIBLE_REF=efad618468fd1c40e760b7e7cbc08686a20deadd

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION} AS builder

ARG SENSIBLE_REF
ARG TARGETOS
ARG TARGETARCH

WORKDIR /src/sensible

RUN git init --initial-branch=sensible . \
    && git remote add origin https://github.com/TheTinkerDad/sensible.git \
    && git fetch --depth 1 origin "${SENSIBLE_REF}" \
    && git -c advice.detachedHead=false checkout --detach FETCH_HEAD

RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download

RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg/mod \
    CGO_ENABLED=0 GOOS="${TARGETOS:-linux}" GOARCH="${TARGETARCH}" \
    go build -trimpath -ldflags="-s -w" -o /out/sensible .

FROM ghcr.io/mpepping/podshell:4 AS runtime

LABEL org.opencontainers.image.source="https://github.com/mpepping/docker-sensible" \
      org.opencontainers.image.description="Container image for Sensible MQTT sensors for Home Assistant"

USER root

COPY --from=builder /out/sensible /usr/local/bin/sensible
COPY include/etc/sensible/scripts/ /etc/sensible/scripts/

RUN /usr/local/bin/sensible -r

ENTRYPOINT ["/usr/local/bin/sensible"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD /usr/local/bin/sensible -h >/dev/null 2>&1 || exit 1
