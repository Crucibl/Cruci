variable "profile" {
  description = " AWS profile"
  default     = "prod"
}
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "public_access_1" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "public_access_2" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "private_access_1" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "private_access_2" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "health_check" {
  description = "Health check for the target group"
  default     = "/ping/"
}
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "healthverity-calibrate"
}
variable "ami_image" {
  description = "Which AMI to spawn."
  default = {
    us-east-1 = "ami_0667a9cc6a93f50fe"
  }
}
variable "instance_type" {
  default = "t3.nano"
}
variable "app_count" {
  description = "Number of Docker containers to run"
  default     = 2
}
variable "allowed_hosts" {
  description = "Domain name for allowed hosts"
  default     = "healthverity.com"
}
variable "log_retention_policy" {
  default = 30
}
variable "public_ssh_keyfile" {
  description = "Path to an SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}
variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  default     = "10"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  default     = "4"
}
variable "rds_db_name" {
  description = "RDS database name"
  default     = "calibrate"
}
variable "rds_username" {
  description = "RDS database username"
  default     = "calibrate_user"
}
variable "rds_password" {
  description = "RDS database password"
  default     = "Strong7@@11!!!"
}
variable "rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t3.nano"
}
variable "certificate_arn" {
  description = "AWS Certificate Manager ARN for validated domain"
  default     = "YOUR ARN"
}
