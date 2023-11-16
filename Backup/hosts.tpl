[prometheus]
${prometheus_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/UE119.pem
[node_exporter]
${node_exporter_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/UE119.pem
[grafana]
${prometheus_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/UE119.pem

[all:vars]
node_exporter_ip=${node_exporter_ip}
