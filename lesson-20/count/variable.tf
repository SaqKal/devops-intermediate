variable "filename" {
  default = [
    "/home/sargis/Terraform/lesson-4/count/test1.txt",
    "/home/sargis/Terraform/lesson-4/count/test2.txt",
    "/home/sargis/Terraform/lesson-4/count/test3.txt"
  ]
}

variable "content" {
  default = [
    "file 1",
    "file 2",
    "file 3"
  ]
}
