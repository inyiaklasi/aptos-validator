#!/bin/bash


CONFYAML="roomit-aptos-checker"


mkdir -p conf
docker run -v $(pwd)/conf:/nhc -t aptoslabs/node-checker:nightly /usr/local/bin/aptos-node-checker configuration create --configuration-name ${CONFYAML} --configuration-name-pretty "RoomIT Aptos Nodes" --url http://cikuray.roomit.xyz/ --evaluators consensus_proposals consensus_round consensus_timeouts api_latency network_peers_within_tolerance | tee conf/${CONFYAML}.yaml
docker stop ${CONFYAML}
docker rm ${CONFYAML}
docker run -d --name=${CONFYAML} -p 20121:20121 -v $(pwd)/conf:/nhc -t aptoslabs/node-checker:nightly /usr/local/bin/aptos-node-checker server run --baseline-node-config-paths /nhc/${CONFYAML}.yaml
