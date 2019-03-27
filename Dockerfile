FROM centos:latest
RUN set -x \
        && groupadd -g 1000 cloudcustodian \
        && useradd -u 1000 -g 1000 -M cloudcustodian

RUN yum -y install epel-release
RUN yum -y install \
  sudo \
  git \
  jq \
  chromium \
  python2 \
  python36 \
  python36-pip \
  python-pip \
  python-virtualenv \
  python36-virtualenv 

RUN yum -y erase chromium
RUN pip install npm
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y yarn nodejs
RUN npm install -g aws-azure-login --unsafe-perm
RUN sed -i 's/wheel	ALL=(ALL)	ALL/wheel	ALL=(ALL)	NOPASSWD\: ALL/g' /etc/sudoers
RUN usermod -aG wheel cloudcustodian

WORKDIR /etc/skel
RUN git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1

USER cloudcustodian
WORKDIR /home/cloudcustodian

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
