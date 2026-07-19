variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "name" {
  type    = string
  default = "demo"
}


# variable "ami" {
#   type    = string
#   default = data.aws_ssm_parameter.ubuntu_ami.value
# }
