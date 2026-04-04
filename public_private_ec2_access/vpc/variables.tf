variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "11.0.0.0/16"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  description = "Windows AMI ID"
  default     = "ami-01a15dfc48279bf55" 
}

variable "key_name" {
  default = "key02"
}
