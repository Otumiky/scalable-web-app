provider "aws" {
  region = "us-east-1"
}
module "vpc" {
  source         = "C://Users//madus//Desktop//30 Days of Terraform//30-Day-Terraform-challenge-//Day26//project-root//modules//vpc"
  vpc_cidr       = "10.0.0.0/16"
  vpc_name       = "my-vpc"
  web_subnet_1_cidr   = "10.0.1.0/24"
  web_subnet_2_cidr = "10.0.2.0/24"
  subnet_1_az     = "us-east-1a"
  subnet_2_az     = "us-east-1b"
}
module "ec2" {
  source        = "C://Users//madus//Desktop//30 Days of Terraform//30-Day-Terraform-challenge-//Day26//project-root//modules//ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.subnet_1

  user_data     = base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "Hello from Server $(hostname)" > /var/www/html/index.html
              EOF
  )

}
module "elb" {
  source             = "C://Users//madus//Desktop//30 Days of Terraform//30-Day-Terraform-challenge-//Day26//project-root//modules//elb"
  subnet_ids         = [module.vpc.subnet_1, module.vpc.subnet_2]
  vpc_id             = module.vpc.vpc_id
  elb_security_group = module.vpc.elb_sg
}

module "asg" {
  source           = "C://Users//madus//Desktop//30 Days of Terraform//30-Day-Terraform-challenge-//Day26//project-root//modules//asg"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  subnet_id        = module.vpc.subnet_1
  #user_data        =  <<-EOF
              

  desired_capacity = 2
  max_size         = 3
  min_size         = 1
  target_group_arn = module.elb.target_group_arn
}