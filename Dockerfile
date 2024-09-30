FROM ubuntu:20.04

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      ca-certificates \
      openssh-server \
      wget \
      curl \
      gnupg2 \
      apt-transport-https \
      vim \
      nano \
      apt-utils \
      lsb-release \
      software-properties-common \
      && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && rm get-docker.sh

RUN curl -fsSL https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash \
    && apt-get update && apt-get install -yq --no-install-recommends gitlab-ce \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd

# Désactiver l'utilisation de DNS pour améliorer la vitesse de connexion SSH
RUN echo "UseDNS no" >> /etc/ssh/sshd_config

RUN echo "" >> /etc/gitlab/gitlab.rb \
    && echo "# Docker-specific configuration" >> /etc/gitlab/gitlab.rb \
    && echo "postgresql['shared_buffers'] = '1MB'" >> /etc/gitlab/gitlab.rb

EXPOSE 443 80 22

VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]

CMD (/opt/gitlab/embedded/bin/runsvdir-start &) && gitlab-ctl reconfigure && tail -f /dev/null
