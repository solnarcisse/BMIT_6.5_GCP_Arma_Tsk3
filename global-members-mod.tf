# members.tf (root)
module "member" {
  source   = "./members/member"    # <— folder name is arbitrary
  for_each = var.members           # map of members

  name                 = each.key
  region               = each.value.region
  subnetwork_self_link = each.value.subnetwork_self_link
  machine_type         = each.value.machine_type

  # Pass the rendered script (avoids brittle relative paths inside the module)
  startup_script = templatefile("${path.module}/templates/linux_startup.sh.tpl", {})

  full_name       = each.value.full_name
  annual_amount   = each.value.annual_amount
  thanks_person   = each.value.thanks_person
  peaceful_bg_url = each.value.peaceful_bg_url
  promo_img_url   = each.value.promo_img_url
}
