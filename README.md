# aptos-validator

## Requierment
```
Ubuntu 22^
VPS 8vcpu 16GB 250GB
Used DNS 
```

## Install Environment
```
git clone git@github.com:luneareth/aptos-validator.git
mv aptos-validator APTOS
cd APTOS/bin
```

Turn into root
```
su -
```

Install environment
if  we want change user account name, edit file setup-env.sh, change variable
```
USER="gneareth"
```

Execution
```
bash -x setup-env.sh
```

ctrl+d -> fill password

check docker service

```
systemctl status docker
```

change variable in file environment
```
#!/usr/bin/env
export BUILD="testnet"
export WORKSPACE="${HOME}/APTOS/${BUILD}"
export DNSNAME=""
export NODENAME=""
```



## Deploy AIT2

```
bash -x aptos.sh deploy ait2
```

## Deploy Devnet

```
bash -x aptos.sh deploy devnet
```

## Deploy Testnet (For AIT3)
```
bash -x aptos.sh deploy testnet
```

## Update Aptos CLI
```
bash aptosh.sh update client
```
