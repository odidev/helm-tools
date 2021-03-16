FROM debian:buster

ENV HELM_VERSION=v3.5.2
ENV HELM_EXPERIMENTAL_OCI=1

RUN buildDeps="curl" \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    $buildDeps \
    ca-certificates \
    git \
    make \
  && cd /usr/local/bin \
  && if [ 'uname -m' = "aarch64" ] ; then curl https://get.helm.sh/helm-$HELM_VERSION-linux-arm64.tar.gz | tar xvz linux-arm64/helm --strip-components=1; \
     else \
     curl https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz | tar xvz linux-amd64/helm --strip-components=1; \
     fi \
  && apt-get purge -y --auto-remove $buildDeps \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
