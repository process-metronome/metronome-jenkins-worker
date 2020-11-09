FROM digitalocean/doctl:1.45.0 AS doctl
FROM hashicorp/terraform:0.13.0 AS terraform
FROM jenkins/inbound-agent:4.6-1-jdk11 AS jnlp

USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl gnupg2 software-properties-common \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" 

RUN apt-get update \
  && apt-get install -y --no-install-recommends docker-ce

RUN usermod -aG docker jenkins

COPY --from=doctl /app/doctl /usr/local/sbin/doctl
COPY --from=terraform /bin/terraform /usr/local/sbin/terraform
COPY entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod +x /usr/sbin/entrypoint.sh

USER jenkins

ENV TF_API_TOKEN="" \
  DIGITALOCEAN_ACCESS_TOKEN="" \
  DIGITALOCEAN_REGISTRY=""

ENTRYPOINT ["/usr/sbin/entrypoint.sh"]