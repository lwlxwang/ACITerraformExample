terraform {
  required_version = ">=0.12.0"
}

# Providers
#
# Cisco ACI provider is used
provider "aci" {
  version = ">=0.2.0"
  #username = ""	# $env:ACI_USERNAME = "user"
  #password = ""	# $env:ACI_PASSWORD = "pass"
  # or
  #username = "" # $env:ACI_USERNAME = "localuser" # without domain, username only
  #cert_name = "" # $env:ACI_CERT_NAME = "cert.crt" # CRT name as was paste to user account in ACI
  #private_key = "" # $env:ACI_PRIVATE_KEY = "C:\cert\cert.key" # path to private key
  #
  # url = "" # $env:ACI_URL = "https://path"
  insecure = true
}

# Resources
#
# resource syntax:
# resource "<PROVIDER>_<TYPE>" "NAME"
# NAME is used to refer this resource in Terraform code
resource "aci_tenant" "example1_ten" {
  name        = var.tenant_name # references variable tenant_name
  description = "Petr, Terraform test"
}


resource "aci_application_profile" "example1_app" {
  tenant_dn = aci_tenant.example1_ten.id
  name      = "EXAMPLE1_APP"
}

resource "aci_application_epg" "app1_epg" {
  application_profile_dn = aci_application_profile.example1_app.id
  name                   = "APP1_EPG"
  flood_on_encap         = "disabled"
  has_mcast_source       = "no"
  is_attr_based_e_pg     = "no"
  match_t                = "AtleastOne"
  pc_enf_pref            = "unenforced"
  pref_gr_memb           = "exclude"
  prio                   = "unspecified"
  shutdown               = "no"
  relation_fv_rs_bd      = aci_bridge_domain.bd1.name
  relation_fv_rs_prov    = toset(["PH-IP_CON", "PH-SSH_CON"])
  relation_fv_rs_cons    = toset(["PH-IP_CON"])
}


module "filters" {
  source    = "../modules/contracts/filters" # it must begin with ./ or ../
  tenant_dn = aci_tenant.example1_ten.id
}

module "std_contract" {
  source    = "../modules/contracts/standard"
  tenant_dn = aci_tenant.example1_ten.id
}


module "ospf_l3o" {
  source         = "../modules/network/l3out/ospftest"
  tenant_id      = aci_tenant.example1_ten.id
  tenant_name    = aci_tenant.example1_ten.name
  l3out_basename = "PH-TERRAFORM"
  vrf_name       = aci_vrf.vrf1.name
  ospf_area      = "0.0.0.0"
  if_path        = "topology/pod-1/paths-102/pathep-[eth1/5]"
  if_encap       = "vlan-3520"
  if_addr        = "10.1.47.17/29"
  con_prov       = ["PH-IP_CON"]
  con_cons       = ["PH-IP_CON", "PH-SSH_CON"]
  ext_subnets    = ["10.1.47.16/29", "10.1.47.24/29"]
}
