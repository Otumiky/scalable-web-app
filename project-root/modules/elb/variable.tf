variable "name" {
  description = "Name of the ALB"
  type        = string
}

variable "security_groups" {
  description = "Security groups for the ALB"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
