variable "filename" {
  type    = set(string)
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

variable "filename2" {
  type    = map(any)
  default = {
    test1 = ["test1", "test12", "test23"]
    test2 = ["test2", "test21", "test33"]
  }
}
