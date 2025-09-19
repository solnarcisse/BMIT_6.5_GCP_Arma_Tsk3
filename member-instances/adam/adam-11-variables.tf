variable "vpcregion" {
  type = string
  default = "africa-south1"    # Your Region
}

variable "vpcregion02" {
  type = string
  default = "us-central1"    # Your Region
}

variable "project-id" {
  type = string
  default = "project007part2"       # Your Project ID
}

variable "vpc-arm" {
  type = string
  default = "armageddon-vpc01"
}

variable "subnet01" {
  type = string
  default = "iowa-public"
  description = "public subnet"
}

variable "subnet02" {
  type = string
  default = "southafrica-private"
  description = "private subnet"
}

variable "cidr-public" {
  type = string
  default = "10.102.109.0/24"
  description = "cidr range of public subnet"
}

variable "cidr-private" {
  type = string
  default = "10.82.109.0/24"
  description = "cidr range of private subnet"
}

variable "rdp01" {
  type = string
  default = "allow-rdp"
}

variable "internal01" {
  type = string
  default = "allow-internal"
}

variable "healthcheck01" {
  type = string
  default = "allow-health-check"
}

variable "temp01" {
  type = string
  default = "southafrica-template"
  description = "South Africa Instance Template"
}

variable "app-mig01" {
  type = string
  default = "southafrica-mig"
  description = "South Africa Instance Group"
}

variable "apps-hc" {
  type = string
  default = "healthcheck-hc"
}

variable "apps-tsa-hc" {
  type = string
  default = "tsa-health-check"
  description = "TSA Health Check"
}

variable "autoscale01" {
  type = string
  default = "southafrica-autoscaler"
  description = "South Africa Autoscale"
}

variable "vm_machine_type" {
  type = string
  default = "e2-medium"
  description = "VM Machine"
}