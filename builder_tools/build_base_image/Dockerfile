###############################################
# Base image for local Development environment
###############################################
FROM ubuntu:18.04

# Set this environment variable to true to set timezone on container start.
ENV SET_CONTAINER_TIMEZONE false
# Default container timezone as found under the directory /usr/share/zoneinfo/.
ENV CONTAINER_TIMEZONE Europe/London

# Setup TERM and PS1
ENV TERM=xterm-color

# set the zsh theme
ENV ZSH_THEME agnoster

ENV GOLANG_VERSION 1.13.5


#bash-completion && \
RUN set -ex && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip \
                        python3-dev \
                        python3-venv \
                        python-dbus \
                        ntp \
                        libglib2.0-dev \
                        libgtk2.0-dev \
                        pkg-config \
                        python-gobject \
                        libgirepository1.0-dev \
                        vim \
                        git \
                        curl \
                        gcc \
                        g++ \
                        libffi-dev \
                        libssl-dev \
                        zip \
                        unzip \
                        tar \
                        postgresql-client \
                        dnsutils \
                        sudo \
                        tree \
                        gettext \
                        apt-utils \
                        groff \
                        ca-certificates \
                        zsh \
                        bash \
                        fonts-powerline \
                        dconf-cli \
                        openssh-client \
                        openssh-server \
                        rsync \
                        grsync \
                        git-core \
                        gnupg \
                        linuxbrew-wrapper \
                        locales && \
            apt-get autoremove -yqq --purge && \
            rm -rf /tmp/*.rpm && \
            apt-get clean && \
            rm -rf \
                /var/lib/apt/lists/* \
                /tmp/* \
                /var/tmp/* \
                /usr/share/man \
                /usr/share/doc \
                /usr/share/doc-base && \
            cd /usr/local/bin && \
            ln -s /usr/bin/python3 python && \
            pip3 install --upgrade pip

# install kubectl
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

# wget -q https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm  && \
RUN curl -SsL https://github.com/kvz/json2hcl/releases/download/v0.0.6/json2hcl_v0.0.6_linux_amd64 | tee /usr/local/bin/json2hcl > /dev/null && \
    chmod 755 /usr/local/bin/json2hcl && \
    curl -sL -o /usr/local/bin/yaml2json https://github.com/wakeful/yaml2json/releases/download/0.3.1/yaml2json-linux-amd64 && \
    chmod +x /usr/local/bin/yaml2json && \
    curl -sL -o /usr/local/bin/jq  https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
    chmod +x /usr/local/bin/jq && \
    curl -sSL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz | tar -C /usr/local/bin -xz && \
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/eksctl /usr/local/bin/ && \
    curl -sL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/eksctl && \
    curl -sL -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/local/bin/aws-iam-authenticator && \
    wget -q https://get.helm.sh/helm-v3.0.3-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm  && \
    chmod +x /usr/local/bin/helm && \
    wget -q https://github.com/derailed/k9s/releases/download/0.7.13/k9s_0.7.13_Linux_x86_64.tar.gz -O - | tar -xzO k9s > /usr/local/bin/k9s  && \
    chmod +x /usr/local/bin/k9s && \
    curl -sL -o /usr/local/bin/assume-role https://raw.githubusercontent.com/coinbase/assume-role/master/assume-role && \
    chmod +x /usr/local/bin/assume-role && \
    curl -sL -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/v0.8.0/op_linux_amd64_v0.8.0.zip && \
    unzip 1password.zip -d /usr/local/bin && \
    rm 1password.zip && \
    wget -q https://github.com/junegunn/fzf-bin/releases/download/0.20.0/fzf-0.20.0-linux_amd64.tgz -O - | tar -xzO fzf > /usr/local/bin/fzf  && \
    chmod +x /usr/local/bin/fzf && \
    rm -rf /root/.cache && \
    apt-get autoremove -yqq --purge && \
                rm -rf /tmp/*.rpm && \
                apt-get clean && \
                rm -rf \
                    /var/lib/apt/lists/* \
                    /tmp/* \
                    /var/tmp/* \
                    /usr/share/man \
                    /usr/share/doc \
                    /usr/share/doc-base

#RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
#CMD [ "zsh" ]