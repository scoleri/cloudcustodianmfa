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
	virtualenv --python=python2 custodian
	source custodian/bin/activate
	pip install --upgrade pip
	pip install c7n
	deactivate
fi
echo -e "\033[1;32m\nThis is Cloud Custodian\n Has git, git-bash-prompt, aws-azure-login (MFA)\033[0m\n\n"

exec "$@"
