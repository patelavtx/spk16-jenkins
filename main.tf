
# AZURE spoke - dev 

# https://registry.terraform.io/modules/terraform-aviatrix-modules/mc-overlap-nat-spoke/aviatrix/latest
# https://registry.terraform.io/modules/terraform-aviatrix-modules/mc-spoke/aviatrix/latest

module "spoke_azure_1" {
  source         = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version        = "1.5.0"
  cloud          = "Azure" 
  transit_gw     = var.transit_gw
  attached       = var.attached
  cidr           = var.cidr
  region         = var.region
  ha_gw          = var.ha_gw
  account        = var.account
  insane_mode    = "false"
  enable_bgp     = "true"
  local_as_number = "65016"
  #  name of existing RG
  resource_group = "atulrg-spoke16"
  name = var.name
  subnet_pairs = "2"
  tags = var.tags
}