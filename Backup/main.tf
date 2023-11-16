provider "aws" {
  profile = "techstarter"
  region  = "eu-central-1"
}

resource "aws_instance" "prometheus" {
  ami                  = "ami-06dd92ecc74fdfb36"
  instance_type        = "t2.micro"
  key_name             = "UE119"
  iam_instance_profile = "ue133_2"
  tags = {
    Name = "UE133 Prometheus"
  }
}

resource "aws_instance" "node_exporter" {
  ami           = "ami-06dd92ecc74fdfb36"
  instance_type = "t2.micro"
  key_name      = "UE119"
  tags = {
    Name = "UE133 - node exporter"
  }
}

data "template_file" "hosts_file" {
  template = file("${path.module}/hosts.tpl")

  vars = {
    prometheus_ip    = aws_instance.prometheus.public_ip
    node_exporter_ip = aws_instance.node_exporter.public_ip
  }
}

resource "local_file" "ansible_hosts" {
  filename = "${path.module}/hosts.ini"
  content  = data.template_file.hosts_file.rendered
}

resource "null_resource" "update_ip" {
  depends_on = [aws_instance.prometheus, aws_instance.node_exporter, local_file.ansible_hosts]

  provisioner "local-exec" {
    command = "./auto_ip.sh"
  }
}

resource "null_resource" "ansible_provisioning" {
  depends_on = [null_resource.update_ip]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
    command = "ansible-playbook -i Ansible/hosts.ini Ansible/setup.yml"
  }
}
