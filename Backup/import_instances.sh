#!/bin/bash

# Setzen Sie Ihre Instanz-IDs
PROMETHEUS_INSTANCE_ID="i-0d571aef293e56f75"
NODE_EXPORTER_INSTANCE_ID="i-0a27234c06652b7fe"

# Importieren der Prometheus-Instanz
echo "Importiere Prometheus-Instanz mit ID $PROMETHEUS_INSTANCE_ID"
terraform import aws_instance.prometheus $PROMETHEUS_INSTANCE_ID

# Importieren der Node Exporter-Instanz
echo "Importiere Node Exporter-Instanz mit ID $NODE_EXPORTER_INSTANCE_ID"
terraform import aws_instance.node_exporter $NODE_EXPORTER_INSTANCE_ID

echo "Import abgeschlossen."
