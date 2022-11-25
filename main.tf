
# AZURE spoke - dev 

# https://registry.terraform.io/modules/terraform-aviatrix-modules/mc-overlap-nat-spoke/aviatrix/latest
# https://registry.terraform.io/modules/terraform-aviatrix-modules/mc-spoke/aviatrix/latest

module "spoke_azure_1" {
  source         = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version        = "1.3.2"
  cloud          = "Azure" # added for new mod
  transit_gw     = var.transit_gw
  attached       = var.attached
  cidr           = var.cidr
  region         = var.region
  ha_gw          = var.ha_gw
  account        = var.account
  resource_group = "atulrg-spoke16"
  name = var.name
  subnet_pairs = "2"
  included_advertised_spoke_routes = "10.255.16.1/32,10.255.16.2/32,10.255.16.251/32,10.255.16.252/32"

  #tags = var.tags 
}

#   If NAT is needed ; note that the module varialbes.tf needs addressing when single spoke gw ; see bottom of this page.
module "spoke1_nat" {
  source          = "terraform-aviatrix-modules/mc-overlap-nat-spoke/aviatrix"
  version         = "1.0.4"
  count           = var.nat_attached ? 1 : 0
  #ha_gw           = var.ha_gw
  spoke_gw_object = module.spoke_azure_1.spoke_gateway
  spoke_cidrs     = var.spoke_cidrs
  transit_gw_name = var.transit_gw
  gw1_snat_addr   = var.gw1_snat
  gw2_snat_addr   = var.gw2_snat
  dnat_rules = {
    rule1 = {
      dst_cidr  = var.dstcidr,
      dst_port  = "80",
      protocol  = "tcp",
      dnat_ips  = var.dnatip,
      dnat_port = "80",
    },
    rule2 = {
      dst_cidr  = var.dstcidr,
      dst_port  = "8443",
      protocol  = "tcp",
      dnat_ips  = var.dnatip,
      dnat_port = "443",
    },
    rule3 = {
      dst_cidr  = var.dstcidr2,
      dst_port  = "80",
      protocol  = "tcp",
      dnat_ips  = var.dnatip2,
      dnat_port = "80",
    },
    rule4 = {
      dst_cidr  = var.dstcidr2,
      dst_port  = "2222",
      protocol  = "tcp",
      dnat_ips  = var.dnatip2,
      dnat_port = "22",
    },
   rule5 = {
      dst_cidr  = var.dstcidr2,
      dst_port  = "8888",
      protocol  = "tcp",
      dnat_ips  = var.dnatip2,
      dnat_port = "88",
    },
    rule6 = {
      dst_cidr  = var.dstcidr2,
      dst_port  = "7777",
      protocol  = "tcp",
      dnat_ips  = var.dnatip2,
      dnat_port = "77",
    },
  }
depends_on = [
    module.spoke_azure_1,
  ]
}



# Example of *tfvars

/*
controller_ip = "
name          = ""
cidr          = "10.16.1.0/24"
region       = "West Europe"
account      = ""
transit_gw   = "aztransit184-weu"
attached     = "true"
nat_attached = "false"
ha_gw        = "false"

tags = {
  ProjectName        = "AIB-MC"
  BusinessOwnerEmail = "apatel@aviatrix.com"
}
*/

/*
╷
│ Error: failed to configure policies for 'customized_snat' mode due to: rest API enable_snat Post failed: following parameter is required: gateway_name
│
│   with module.spoke1_nat[0].aviatrix_gateway_snat.gw_2[0],
│   on .terraform/modules/spoke1_nat/main.tf line 30, in resource "aviatrix_gateway_snat" "gw_2":
│   30: resource "aviatrix_gateway_snat" "gw_2" {
│



Needed to update here: .terraform/modules/spoke1_nat/variables.tf

From>
locals {
  is_ha = var.spoke_gw_object.ha_gw_size != NULL
}


To>
locals {
  is_ha = var.spoke_gw_object.ha_gw_size != ""
}
*/
