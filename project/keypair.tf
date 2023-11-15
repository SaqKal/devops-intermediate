resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_ssh_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_pair}.pem"
  provisioner "local-exec" {
    when    = create
    command = "chmod 400 ${var.key_pair}.pem"
  }
}

resource "local_file" "public_ssh_key" {
  content  = tls_private_key.rsa.public_key_openssh
  filename = "${var.key_pair}.pub"
  provisioner "local-exec" {
    when    = create
    command = "chmod 400 ${var.key_pair}.pub"
  }
}
resource "aws_key_pair" "project_key" {
  key_name   = var.key_pair
  public_key = tls_private_key.rsa.public_key_openssh
}

