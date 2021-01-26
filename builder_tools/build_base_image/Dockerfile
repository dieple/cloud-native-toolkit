###############################################
# Base image for local Development environment
###############################################
#FROM ubuntu:18.04
FROM bitnami/minideb-extras:stretch-buildpack AS builder


#ENV SET_CONTAINER_TIMEZONE false
ENV CONTAINER_TIMEZONE Europe/London
ENV TERM=xterm-color
ENV ZSH_THEME agnoster
#ENV GOLANG_VERSION 1.13.5

ARG ref=master
WORKDIR /tmp/zsh-build
RUN install_packages autoconf \
                     libtool \
                     libcap-dev \
                     libtinfo5 \
                     libncursesw5-dev \
                     libpcre3-dev \
                     libgdbm-dev \
                     yodl \
                     groff \
                     man-db \
                     texinfo \
                     groff

RUN curl -L https://api.github.com/repos/zsh-users/zsh/tarball/$ref | tar xz --strip=1
RUN ./Util/preconfig
RUN ./configure --prefix /usr \
                --enable-pcre \
                --enable-cap \
                --enable-multibyte \
                --with-term-lib='ncursesw tinfo' \
                --with-tcsetpgrp
RUN make
RUN make -C Etc all FAQ FAQ.html
RUN if test $ref = "master" ; then install_packages cm-super-minimal texlive-fonts-recommended texlive-latex-base texlive-latex-recommended ghostscript bsdmainutils ; fi
RUN if test $ref = "master" ; then make -C Doc everything ; fi
RUN make install DESTDIR=/tmp/zsh-install
RUN make install.info DESTDIR=/tmp/zsh-install || true
RUN yes '' | adduser --shell /bin/sh --home /tmp/zsh-build --disabled-login --disabled-password zshtest
RUN chown -R zshtest /tmp/zsh-build
RUN su - zshtest -c 'make test' || true

#FROM bitnami/minideb:stretch
FROM ubuntu:18.04
WORKDIR /
COPY --from=builder /tmp/zsh-install /
COPY requirements*.txt /


RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/ppa && \
    apt-get install -y python3.7 && \
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
                       python3.7-venv \
                       vim \
                       git \
                       curl \
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
                       linuxbrew-wrapper \
                       locales \
                       mysql-client

RUN cd /usr/local/bin && \
    ln -s /usr/bin/python3.7 python3 && \
    ln -s /usr/bin/python3.7 python && \
    cd /usr/bin && \
    unlink /usr/bin/python3 && \
    unlink /usr/bin/python && \
    ln -s python3.7 python3 && \
    ln -s python3.7 python && \
    pip3 install --upgrade pip && \
    pip3 install mysql-connector && \
    cd / && pip3 install -r /requirements-dev.txt

# install kubectl
RUN apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

# wget -q https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm  && \
#curl -sSL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz | tar -C /usr/local/bin -xz && \
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh && bash nodesource_setup.sh && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs && \
    curl -SsL https://github.com/kvz/json2hcl/releases/download/v0.0.6/json2hcl_v0.0.6_linux_amd64 | tee /usr/local/bin/json2hcl > /dev/null && \
    chmod 755 /usr/local/bin/json2hcl && \
    curl -sL -o /usr/local/bin/yaml2json https://github.com/wakeful/yaml2json/releases/download/0.3.1/yaml2json-linux-amd64 && \
    chmod +x /usr/local/bin/yaml2json && \
    curl -sL -o /usr/local/bin/jq  https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
    chmod +x /usr/local/bin/jq && \
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
    wget -q https://github.com/junegunn/fzf-bin/releases/download/0.20.0/fzf-0.20.0-linux_amd64.tgz -O - | tar -xzO fzf > /usr/local/bin/fzf  && \
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
CMD ["/usr/bin/zsh","-l"]
