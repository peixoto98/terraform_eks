variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name Tag)"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be add to AWS Resources"
}

variable "vpc" {
  type        = string
  description = "VPN for SG"
}

variable "public_subnet" {
  type        = string
  description = "Public subnet for Bastion host"
}

variable "private_subnet" {
  type        = string
  description = "Private subnet for Mongodb host"
}

variable "cluster_sg" {
  type = string
  description = "EKS Security group"
}