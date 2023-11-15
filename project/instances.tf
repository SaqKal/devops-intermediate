resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.debian.image_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  subnet_id              = aws_subnet.jenkins.id
  root_block_device {
    volume_type = "gp3"
    volume_size = 29
  }
  user_data = templatefile("${path.module}/userdata/jenkins.tpl", {
    custom_user_1  = var.custom_user_1,
    default_user_1 = var.default_user_1,
    jenkins_image  = var.jenkins_image,
    hostname_1     = var.hostname_1
  })
  provisioner "remote-exec" {
    inline     = ["mkdir /home/${var.custom_user_1}/.docker/"]
    on_failure = fail
    when       = create
    connection {
      type        = "ssh"
      user        = var.custom_user_1
      private_key = tls_private_key.rsa.private_key_pem
      host        = self.public_ip
    }
  }
  provisioner "file" {
    source      = "~/.docker/config.json"
    destination = "/home/${var.custom_user_1}/.docker/config.json"
    on_failure  = fail
    when        = create
    connection {
      type        = "ssh"
      user        = var.custom_user_1
      private_key = tls_private_key.rsa.private_key_pem
      host        = self.public_ip
    }
  }
  provisioner "file" {
    source      = local_file.public_ssh_key.filename
    destination = "/home/${var.custom_user_1}/.ssh/${var.key_pair}.pub"
    on_failure  = fail
    when        = create
    connection {
      type        = "ssh"
      user        = var.custom_user_1
      private_key = tls_private_key.rsa.private_key_pem
      host        = self.public_ip
    }
  }
  provisioner "file" {
    source      = local_file.private_ssh_key.filename
    destination = "/home/${var.custom_user_1}/.ssh/${var.key_pair}.pem"
    on_failure  = fail
    when        = create
    connection {
      type        = "ssh"
      user        = var.custom_user_1
      private_key = tls_private_key.rsa.private_key_pem
      host        = self.public_ip
    }
  }
  provisioner "file" {
    source      = "${path.module}/userdata/container_to_image.sh"
    destination = "/home/${var.custom_user_2}/container_to_image.sh"
    on_failure  = fail
    when        = create
    connection {
      type        = "ssh"
      user        = var.custom_user_2
      private_key = tls_private_key.rsa.private_key_pem
      host        = self.public_ip
    }
  }
  depends_on = [
    aws_security_group.jenkins,
    aws_key_pair.project_key
  ]
  tags = local.instances.jenkins.master
}
resource "aws_instance" "jenkins_worker" {
  ami                    = data.aws_ami.ubuntu.image_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.jenkins_worker.id]
  subnet_id              = aws_subnet.jenkins_worker.id
  root_block_device {
    volume_type = "gp3"
    volume_size = 29
  }
  user_data = templatefile("${path.module}/userdata/jenkins_worker.tpl", {
    custom_user_2  = var.custom_user_2,
    default_user_2 = var.default_user_2,
    hostname_2     = var.hostname_2
  })
  provisioner "file" {
    source      = local_file.public_ssh_key.filename
    destination = "/home/${var.custom_user_2}/.ssh/${var.key_pair}.pub"
    on_failure  = fail
    when        = create
    connection {
      type        = "ssh"
      user        = var.custom_user_2
      private_key = tls_private_key.rsa.private_key_pem
      host        = self.public_ip
    }
  }
  provisioner "file" {
    source      = local_file.private_ssh_key.filename
    destination = "/home/${var.custom_user_2}/.ssh/${var.key_pair}.pem"
    on_failure  = fail
    when        = create
    connection {
      type        = "ssh"
      user        = var.custom_user_2
      private_key = tls_private_key.rsa.private_key_pem
      host        = self.public_ip
    }
  }
  depends_on = [
    aws_key_pair.project_key,
    aws_security_group.jenkins_worker
  ]
  tags = local.instances.jenkins.worker
}
