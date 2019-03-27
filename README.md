### cloudcustodian-mfa

#This is Cloud Custodian with aws-azure-login. Sets up an environment for running Cloud Custodian against AWS using AD MFA.

- It's stupid huge but it works. aws-azure-login uses Chromium which is huge.
- Centos Root (trying to update - 22Feb19)
- aws cli
- git
- bash git prompt
- Cloud Custodian
- virtualenv, python2 and 3.6
- kubectl
- aws-iam-authenticator
- aws-azure-login

#USAGE (mac or linux, I don't know the syntax for windows usage but it should work):

```
cd ~
mkdir CloudCustodianHome
docker run -it -v ~/CloudCustodianHome:/home/cloudcustodian scoleri/cloudcustodian-mfa:latest /bin/bash

NOTE:  The first time you run it (new home dir - you can have as many as you want) it'll take a few seconds to set up the environment


aws-azure-login --configure
aws-azure-login --no-sandbox
aws configure

custodian -h
```

Should be good to go with first Custodian yaml.

-Scoleri
