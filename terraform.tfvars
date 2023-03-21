name          = "jenkins-spoke16"
cidr          = "10.16.1.0/24"
region       = "West Europe"
account      = "HActrldec13"
transit_gw   = "aztransit184-weu"
attached     = "true"
nat_attached = "false"
ha_gw        = "false"


tags = {
  ProjectName        = "Jenkins"
  BusinessOwnerEmail = "apatel@aviatrix.com"
}
