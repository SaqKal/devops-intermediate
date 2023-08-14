terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "local_file" "test" {
  filename = var.filename[count.index]
  content  = var.content[count.index]
  count    = 3
}
