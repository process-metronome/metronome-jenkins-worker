FROM digitalocean/doctl:1.45.0 AS doctl
FROM hashicorp/terraform:0.13.0 AS terraform

FROM jenkins/inbound-agent:alpine AS jnlp

USER root
RUN apk --no-cache add curl
COPY --from=doctl /app/doctl /usr/local/sbin/doctl
COPY --from=terraform /bin/terraform /usr/local/sbin/terraform
COPY entrypoint.sh /usr/sbin/entrypoint.sh

USER jenkins

ENV TF_API_TOKEN="" \
    DIGITALOCEAN_ACCESS_TOKEN="" \
    DIGITALOCEAN_REGISTRY=""

##ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
ENTRYPOINT ["/usr/sbin/entrypoint.sh"]