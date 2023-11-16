output "prometheus_ip" {
  value = aws_instance.prometheus.public_ip
}

output "node_exporter_ip" {
  value = aws_instance.node_exporter.public_ip
}
