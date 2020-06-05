ARG DOCTL_VERSION=1.45.0
ARG HELM_VERSION=3.2.1

FROM digitalocean/doctl:$DOCTL_VERSION AS doctl
FROM alpine/helm:$HELM_VERSION AS helm

FROM jenkins/jnlp-slave:3.35-5-alpine AS jenkins
USER root
RUN apk update && apk add curl docker

USER jenkins
ENV DIGITALOCEAN_ACCESS_TOKEN='' \
    CHARTMUSEUM_URL='' \
    DOCKER_HOST='tcp://localhost:2375'

COPY --from=doctl /app/doctl /usr/local/bin/
COPY --from=helm /usr/bin/helm /usr/local/bin/
