variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.small"
}

variable "ami" {
  default = "ami-07d7e3e669718ab45" # Update with the latest Amazon Linux 2 AMI
}

variable "key_name" {
  description = "task-4.pem"
}
