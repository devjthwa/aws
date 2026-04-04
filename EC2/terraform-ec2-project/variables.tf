variable "ami_id" {
  description = "The AMI ID of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}

variable "instance_name" {
  description = "The name to assign to the EC2 instance"
  type        = string
}