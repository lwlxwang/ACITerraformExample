# VRFs
resource "aci_vrf" "vrf1" {
  tenant_dn = aci_tenant.example1_ten.id
  name      = "PH-TERRAFORM_VRF"
}

# BDs
resource "aci_bridge_domain" "bd1" {
  tenant_dn          = aci_tenant.example1_ten.id
  relation_fv_rs_ctx = aci_vrf.vrf1.name
  name               = "BD1_BDO"
}
resource "aci_subnet" "bd1_subnet" {
  bridge_domain_dn = aci_bridge_domain.bd1.id
  ip               = "10.1.47.1/29"
  preferred        = "no"
  scope            = "public"
  virtual          = "no"
}
resource "aci_bridge_domain" "bd2" {
  tenant_dn          = aci_tenant.example1_ten.id
  relation_fv_rs_ctx = aci_vrf.vrf1.name
  name               = "BD2_BDO"
}
resource "aci_subnet" "bd2_subnet" {
  bridge_domain_dn = aci_bridge_domain.bd2.id
  ip               = "10.1.47.9/29"
  preferred        = "no"
  scope            = "public"
  virtual          = "no"
}

resource "aci_bridge_domain" "svc1" {
  tenant_dn          = aci_tenant.example1_ten.id
  relation_fv_rs_ctx = aci_vrf.vrf1.name
  name               = "SVC1_BDO"
}
resource "aci_subnet" "svc1_subnet" {
  bridge_domain_dn = aci_bridge_domain.svc1.id
  ip               = "10.1.47.65/29"
  preferred        = "no"
  scope            = "public"
  virtual          = "no"
}

resource "aci_bridge_domain" "svc2" {
  tenant_dn          = aci_tenant.example1_ten.id
  relation_fv_rs_ctx = aci_vrf.vrf1.name
  name               = "SVC2_BDO"
}
resource "aci_subnet" "svc2_subnet" {
  bridge_domain_dn = aci_bridge_domain.svc2.id
  ip               = "10.1.47.73/29"
  preferred        = "no"
  scope            = "public"
  virtual          = "no"
}