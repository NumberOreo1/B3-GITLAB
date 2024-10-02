
FROM ubuntu:20.04


ENV DEBIAN_FRONTEND=noninteractive
ENV GITLAB_VERSION=15.0.0-ce.0
ENV GITLAB_HOME=/var/opt/gitlab
ENV GITLAB_LOG_DIR=/var/log/gitlab
ENV GITLAB_CONFIG_DIR=/etc/gitlab


RUN apt-get update && \
    apt-get install -y \
    curl \
    ca-certificates \
    tzdata \
    openssh-server \
    apt-transport-https \
    gnupg2 \
    postfix \
    && apt-get clean


RUN curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash


RUN apt-get install -y gitlab-ce=$GITLAB_VERSION


RUN echo "external_url 'http://localhost'" >> $GITLAB_CONFIG_DIR/gitlab.rb && \
    echo "registry_external_url 'http://localhost:5000'" >> $GITLAB_CONFIG_DIR/gitlab.rb && \
    echo "gitlab_rails['registry_enabled'] = true" >> $GITLAB_CONFIG_DIR/gitlab.rb && \
    echo "gitlab_rails['registry_host'] = 'localhost'" >> $GITLAB_CONFIG_DIR/gitlab.rb && \
    echo "gitlab_rails['registry_port'] = '5000'" >> $GITLAB_CONFIG_DIR/gitlab.rb && \
    echo "gitlab_rails['gitlab_shell_ssh_port'] = 22" >> $GITLAB_CONFIG_DIR/gitlab.rb


EXPOSE 80 443 22 5000


CMD (/opt/gitlab/embedded/bin/runsvdir-start &) && gitlab-ctl reconfigure && tail -f /dev/null
