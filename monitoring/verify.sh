curl 127.0.0.1:8080 2> /dev/null | jq
curl 127.0.0.1:9101/metrics 2> /dev/null | grep "aptos_connections{.*\"Validator\".*}"
curl 127.0.0.1:9101/metrics 2> /dev/null | grep "aptos_network_peer_connected{.*remote_peer_id=\"83424ccb\".*}"       
curl 127.0.0.1:9101/metrics 2> /dev/null | grep "aptos_consensus_current_round"
curl 127.0.0.1:9101/metrics 2> /dev/null | grep "aptos_consensus_proposals_count"
curl 127.0.0.1:9101/metrics 2> /dev/null | grep "aptos_state_sync_version"
