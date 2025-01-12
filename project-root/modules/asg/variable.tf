variable "name_prefix" {
  description = "Prefix for ASG resources"
  type        = string
}

variable "image_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "security_groups" {
  description = "Security group IDs"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for ASG instances"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired capacity for the ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
}

variable "user_data" {
    default = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "Hello from Server $(hostname)" > /var/www/html/index.html
                EOF
}

variable "target_group_arn" {
  description = "Target group ARN"
  type        = string
}
