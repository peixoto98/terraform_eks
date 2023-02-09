variable "project_name" {
    type = string
    description = "Project name to be used to name the resources (Name Tag)"
}

variable "tags" {
    type = map
    description = "Tags to be add to AWS Resources"
}

variable "public_subnet_1a"{
    type = string
    description = "Subnet to create EKS cluster"
}

variable "public_subnet_1b"{
    type = string
    description = "Subnet to create EKS cluster"
}