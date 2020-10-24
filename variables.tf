variable "name" {
  type        = string
  default     = "dummy"
  description = "Unique identifier used when creating resources."
}

variable "region" {
  type        = string
  description = "AWS Region to use."
}

variable "availability_zone" {
  type        = string
  default     = "a"
  description = "Availability Zone within AWS Region to create resources inside."
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Subnet CIDR to be used for AWS VPC."
}