#!/bin/bash
set -e

if [ ! -f "/home/cloudcustodian/.bashrc" ]; then 
  echo "Setting up NEW environment"
  cp -R /etc/skel/.[a-z]* /home/cloudcustodian
  echo -e "GIT_PROMPT_ONLY_IN_REPO=1\nsource ~/.bash-git-prompt/gitprompt.sh" >> .bashrc
  echo -e "alias aws-azure-login=\"aws-azure-login --no-sandbox\"" >> .bashrc
  echo -e "source custodian/bin/activate" >> .bashrc
fi

if [ ! -d "/home/cloudcustodian/custodian" ]; then
	virtualenv --python=python3.6 custodian
	source custodian/bin/activate
	pip3 install awscli --upgrade
	pip install --upgrade pip
	pip install c7n c7n-org
	curl -o custodian/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator
	chmod +x custodian/bin/aws-iam-authenticator
	curl -o custodian/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl
	chmod +x custodian/bin/kubectl
	deactivate
fi
echo -e "\033[1;32m\nThis is Cloud Custodian\n Has git, git-bash-prompt, aws-azure-login (MFA)\033[0m\n\n"

exec "$@"
