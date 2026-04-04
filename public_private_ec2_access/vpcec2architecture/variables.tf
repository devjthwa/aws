variable "vpc_cidr" {
  default = "11.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "11.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "11.0.2.0/24"
}

variable "key_name" {
  default = "key02"
}