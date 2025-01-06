variable "ami_id" {}
variable "instance_type" {}
variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}
variable "subnet_id" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
#variable "user_data" {}
variable "target_group_arn" {}
