variable "length" {
}

resource "random_password" "password" {
  length  = var.length < 8 ? 8 : var.length
  special = false
}
