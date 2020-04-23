
resource "aci_filter" "PH-SSH_FLT" {
  tenant_dn   = var.tenant_dn
  description = "SSH filter"
  name        = "PH-SSH_FLT"
}
resource "aci_filter_entry" "SSH-STAT_ENT" {
  filter_dn   = aci_filter.PH-SSH_FLT.id
  description = "SSH entry"
  name        = "SSH-STAT_ENT"
  d_from_port = "22"
  d_to_port   = "22"
  ether_t     = "ipv4"
  prot        = "tcp"
  stateful    = "yes"
}

resource "aci_filter" "PH-IP_FLT" {
  tenant_dn   = var.tenant_dn
  description = "IP filter"
  name        = "PH-IP_FLT"
}
resource "aci_filter_entry" "PH-IP_ENT" {
  filter_dn   = aci_filter.PH-IP_FLT.id
  description = "IP entry"
  name        = "PH-IP_ENT"
  ether_t     = "ipv4"
}

resource "aci_filter" "PH-ICMP_FLT" {
  tenant_dn   = var.tenant_dn
  description = "IP filter"
  name        = "PH-ICMP_FLT"
}
resource "aci_filter_entry" "PH-ICMP_ENT" {
  filter_dn   = aci_filter.PH-ICMP_FLT.id
  description = "ICMP entry"
  name        = "PH-ICMP_ENT"
  ether_t     = "ipv4"
  prot        = "icmp"
}

locals {
  filter_id = {
    PH-IP_FLT  = aci_filter.PH-IP_FLT.id
    PH-SSH_FLT = aci_filter.PH-SSH_FLT.id
  }
}

