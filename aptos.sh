#!/bin/bash
#
#
# Installation node aptos ait2
#
source environment

mkdir -p $WORKSPACE
cd $WORKSPACE

if ! [ -f docker-compose.yaml ]
then	
# Original File Download
# wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/docker-compose.yaml
# We Only Modified container_name
cp ../docker-compose.yaml .
fi

if ! [ -f validator.yaml ]
then
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/validator.yaml
fi

if ! [ -f /usr/bin/aptos ]
then
 wget -qO aptos-cli.zip https://github.com/aptos-labs/aptos-core/releases/download/aptos-cli-0.2.0/aptos-cli-0.2.0-Ubuntu-x86_64.zip
 sudo unzip -o aptos-cli.zip -d /usr/bin
 sudo chmod +x /usr/bin/aptos
 rm aptos-cli.zip
fi

if ! [ -f "${WORKSPACE}/private-keys.yaml" ] && ! [ -f "${WORKSPACE}/validator-identity.yaml" ] && ! [ -f "${WORKSPACE}/validator-full-node-identity.yaml" ]
then
  aptos genesis generate-keys --output-dir $WORKSPACE
fi

if ! [ -f "${WORKSPACE}/${NODENAME}.yaml" ]
then	
  aptos genesis set-validator-configuration \
    --keys-dir ${WORKSPACE} --local-repository-dir ${WORKSPACE} \
    --username ${NODENAME} \
    --validator-host ${DNSNAME}:6180
fi

#if ! [ -d "${WORKSPACE}/keys" ]
#then
#  mkdir -p keys
#  aptos key generate --assume-yes --output-file ${WORKSPACE}/keys/root
#  ROOT_KEY_PUBLIC=`cat ${WORKSPACE}/keys/root.pub`
#  KEY="0x${ROOT_KEY_PUBLIC}"
#fi

if ! [ -f "${WORKSPACE}/layout.yaml" ]
then
cat > ${WORKSPACE}/layout.yaml <<EOF
---
root_key: "F22409A93D1CD12D2FC92B5F8EB84CDCD24C348E32B3E7A720F3D2E288E63394"
users:
  - "${NODENAME}"
chain_id: 40
min_stake: 0
max_stake: 100000
min_lockup_duration_secs: 0
max_lockup_duration_secs: 2592000
epoch_duration_secs: 86400
initial_lockup_timestamp: 1656615600
min_price_per_gas_unit: 1
allow_new_validators: true
EOF
fi

if ! [ -d ${WORKSPACE}/framework ]
then
  wget -qO framework.zip https://github.com/aptos-labs/aptos-core/releases/download/aptos-framework-v0.2.0/framework.zip
  unzip -o framework.zip
  rm framework.zip
fi

if ! [ -f "${WORKSPACE}/genesis.blob" ] && ! [ -f "${WORKSPACE}/waypoint.txt" ]
then
  aptos genesis generate-genesis --local-repository-dir ${WORKSPACE} --output-dir ${WORKSPACE}
fi

docker compose up -d
