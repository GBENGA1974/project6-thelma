# REFERENCE FILE
# REGION

variable "region" {
    description = "name of region"
    default = "eu-west-2"
}

# VPC CIDR cidr_block

variable "vpc-cidr" {
    description = "name of vpc cidr block"
    default = "10.0.0.0/16"
}

# PUBLIC SUBNET1 variable

variable "subnet1-cidr"{
    description = "name of subnet1 cidr block"
    default = "10.0.35.0/24"
}

# PUBLIC SUBNET2 variable

variable "subnet2-cidr"{
    description = "name of subnet2 cidr block"
    default = "10.0.37.0/24"
}

# PRIVATE SUBNET3 variable

variable "subnet3-cidr"{
    description = "name of subnet3 cidr block"
    default = "10.0.36.0/24"
}

# PRIVATE SUBNET4 variable

variable "subnet4-cidr" {
    description = "name of subnet4 cidr block"
    default = "10.0.38.0/24"
    
}