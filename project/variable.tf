variable "default_user_1" {
  default = "admin"
}

variable "default_user_2" {
  default = "ubuntu"
}

variable "custom_user_1" {
  default = "jenkins"
}

variable "custom_user_2" {
 i default = "jenkins"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair" {
  default = "bdg"
}

variable "hostname_1" {
  default = "master"
}

variable "hostname_2" {
  default = "worker"
}

variable "jenkins_image" {
  default = "sargiskaloyan/jenkins"
}
variable "template_instance_name" {
  default = "ASG-instance"
}
variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "subnet_cidrs" {
  type = map(string)
  default = {
    jenkins        = "10.10.1.0/24"
    jenkins_worker = "10.10.2.0/24"
    asg_elb_1      = "10.10.11.0/24"
    asg_elb_2      = "10.10.12.0/24"
    asg_elb_3      = "10.10.13.0/24"
    public_eks_1   = "10.10.21.0/24"
    private_eks_1  = "10.10.22.0/24"
    public_eks_2   = "10.10.23.0/24"
    private_eks_2  = "10.10.24.0/24"
  }
}

variable "availability_zones" {
  type = map(string)
  default = {
    1 = "eu-central-1a"
    2 = "eu-central-1b"
  }
}

