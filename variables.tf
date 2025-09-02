variable "project_id"       { type = string }
variable "public_region"    { type = string } 
variable "private_region"   { type = string }
variable "vpc_name"         { type = string }
variable "app_name"         { type = string  }

# Minimize IPv4: small /24 subnets for compute; proxy-only subnets need /23 (per GCP docs)
# https://cloud.google.com/load-balancing/docs/l7-internal/setting-up-l7-cross-reg-internal
variable "cidr_public"      { type = string }
variable "cidr_private"     { type = string }
variable "cidr_proxy_pub"   { type = string } # proxy-only (public region)
variable "cidr_proxy_prv"   { type = string } # proxy-only (private region)

# Member definitions (one Linux VM per member in their own region)
variable "members" {
  description = "Map of member objects keyed by a short name; each defines a region and custom text/images."
  type = map(object({
    region          : string
    full_name       : string
    annual_amount   : string
    thanks_person   : string
    peaceful_bg_url : string
    promo_img_url   : string
    machine_type    : string
  }))
}

# Windows VM machine type & image
variable "win_machine_type" { type = string }
