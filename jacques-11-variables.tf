variable "vpc_name" {
  type    = string
  default = "cloud-row-vpc"
}

variable "app_name" {
  type    = string
  default = "welcome-to-cloud-row-app"
}

variable "region_a" {
  default = "us-south1" # Your Region
}

variable "zone_a" {
  default = "us-south1-a" # Your Zone
}

variable "region_b" {
  default = "southamerica-east1" # Your Region
}

variable "zone_b" {
  default = "southamerica-east1-a" # Your Zone
}

variable "project" {
  default = "jdp-class-6-labs" # Your Project ID
}

variable "instance_image" {
  default = "debian-cloud/debian-12" # Your Instance Image
}

variable "subnet_ip_cidr_range_public" {
  type        = string
  default     = "10.32.1.0/24"
  description = "CIDR range for the public subnet"
}

variable "subnet_ip_cidr_range_private" {
  type        = string
  default     = "10.32.11.0/24"
  description = "CIDR range for the private subnet"
}

variable "backend_port_name" {
  type        = string
  default     = "http"
  description = "Name of the backend port"
}

