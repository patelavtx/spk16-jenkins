controller_ip = "20.126.212.235"
ctrl_password = "Aviatrix123#"

name          = "dev-azweu-spoke16"
cidr          = "10.16.1.0/24"
region       = "West Europe"
account      = "avtxAzure"
transit_gw   = "aztransit184-weu"
attached     = "true"
nat_attached = "true"
ha_gw        = "true"


tags = {
  ProjectName        = "AIB-MC"
  BusinessOwnerEmail = "apatel@aviatrix.com"
}


spoke_cidrs = ["10.16.1.0/24",]
gw1_snat    = "10.255.16.1"
gw2_snat    = "10.255.16.2"
dnatip      = "10.16.1.52"
dnatip2     = "10.16.1.53"
dstcidr     = "10.255.16.251/32"
dstcidr2    = "10.255.16.252/32"
