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
  filename = each.key
  content  = each.value[0]
  for_each = var.filename2	
}
