variable "project" {
  type    = string
  default = "Roboshop"
}

variable "environment" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be either dev, staging, or prod."
  }
}

variable "ami_id" {
  type    = string
  default = "ami-0220d79f3f480ecf5"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium", "t3.large"], var.instance_type)
    error_message = "Instance type must be either t3.micro or t3.small."
  }
}

variable "sg_tags" {
  type = map(string)
  default = {
    Name        = "terraform-sg"
    Project     = "Roboshop"
    Environment = "Dev"
  }
}

variable "instance_names" {
  type   = list(string)
  default = ["mongo", "redis", "mysql", "rabbitmq", "postgres"]
}