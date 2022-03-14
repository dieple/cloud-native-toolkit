###############################################
# Base image for local Development environment
###############################################

FROM ubuntu:20.04
WORKDIR /
COPY requirements*.txt /


RUN apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/ppa && \
    apt-get install -y python3.9 && \
    apt-get autoremove -y && \
    apt-get clean

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential \
                       wget \
                        python3-setuptools \
                        checkinstall \
                       libreadline-gplv2-dev \
                       libncursesw5-dev \
                       libssl-dev \
                       libsqlite3-dev \
                       tk-dev \
                       libgdbm-dev \
                       libc6-dev \
                       libbz2-dev \
                       zlib1g-dev \
                       libffi-dev \
                       ntp \
                       libglib2.0-dev \
                       libgtk2.0-dev \
                       pkg-config \
                       python-gobject \
                       libgirepository1.0-dev \
                       python3-pip \
                       python3.9-venv \
                       vim \
                       git \
                       zsh \
                       gcc \
                       g++ \
                       libssl-dev \
                       asciinema \
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
                       fonts-powerline \
                       dconf-cli \
                       openssh-client \
                       openssh-server \
                       rsync \
                       grsync \
                       git-core \
                       gnupg \
                       locales \
                       mysql-client \
                       iproute2 \
                       net-tools \
                       netcat \
                       curl \
                       packer

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
  apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

RUN cd /usr/local/bin && \
    cd /usr/bin && \
    pip3 install --upgrade pip && \
    pip3 install mysql-connector && \
    cd / && pip3 install -r /requirements-dev.txt


RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN usermod -s $(which zsh) $(whoami)

# install kubectl
RUN apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

# wget -q https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm  && \
#curl -sSL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz | tar -C /usr/local/bin -xz && \
RUN curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash - && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs  && \
    curl -SsL https://github.com/kvz/json2hcl/releases/download/v0.0.6/json2hcl_v0.0.6_linux_amd64 | tee /usr/local/bin/json2hcl > /dev/null  && \
    chmod 755 /usr/local/bin/json2hcl && \
    curl -sL -o /usr/local/bin/yaml2json https://github.com/wakeful/yaml2json/releases/download/0.3.1/yaml2json-linux-amd64 && \
    chmod +x /usr/local/bin/yaml2json && \
    curl -sL -o /usr/local/bin/jq  https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
    chmod +x /usr/local/bin/jq  && \
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/eksctl /usr/local/bin/  && \
    curl -sL -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/eksctl && \
    curl -sL -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/local/bin/aws-iam-authenticator && \
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo -E bash - && \
    wget -q https://github.com/derailed/k9s/releases/download/v0.24.15/k9s_Linux_x86_64.tar.gz -O - | tar -xzO k9s > /usr/local/bin/k9s  && \
    chmod +x /usr/local/bin/k9s && \
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash &&  mv kustomize /usr/local/bin/ && \
    curl -sL -o /usr/local/bin/assume-role https://raw.githubusercontent.com/coinbase/assume-role/master/assume-role && \
    chmod +x /usr/local/bin/assume-role && \
    wget -q https://github.com/junegunn/fzf/releases/download/0.27.3/fzf-0.27.3-linux_amd64.tar.gz -O - | tar -xzO fzf > /usr/local/bin/fzf  && \
    chmod +x /usr/local/bin/fzf && \
    curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
    install skaffold /usr/local/bin/ && \
    npm install -g @mhlabs/iam-policies-cli && \
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


#RUN wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true
#RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN ln -s /usr/bin/python3 /usr/bin/python
CMD ["/usr/bin/zsh","-l"]
