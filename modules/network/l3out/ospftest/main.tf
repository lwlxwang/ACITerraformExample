resource "aci_l3_outside" "ospf_l3o" {
  tenant_dn              = var.tenant_id
  name                   = "${var.l3out_basename}_L3O"
  relation_l3ext_rs_ectx = var.vrf_name
}


resource "aci_rest" "ospfpar_l3o" {
  path       = "/api/mo/uni/tn-${var.tenant_name}/out-${aci_l3_outside.ospf_l3o.name}.json"
  class_name = "ospfExtP"
  content = {
    "areaType" = "regular"
    "areaCost" = "1"
    "areaId"   = var.ospf_area
    "areaCtrl" = "redistribute,summary"
  }
  depends_on = [
    aci_l3_outside.ospf_l3o
  ]
}

resource "aci_logical_node_profile" "ospf_lnp" {
  l3_outside_dn = aci_l3_outside.ospf_l3o.id
  description   = "LNP"
  name          = "${var.l3out_basename}_LNP"
}

resource "aci_logical_interface_profile" "ospf_inp" {
  logical_node_profile_dn = aci_logical_node_profile.ospf_lnp.id
  description             = "INP"
  name                    = "${var.l3out_basename}_INP"
  relation_l3ext_rs_path_l3_out_att = toset([var.if_path])
}

resource "aci_rest" "rest_l3out_att" {
  # path = "/api/mo/uni/tn-${aci_tenant.terraform_ten.name}/out-${aci_l3_outside.ospf_l3o.name}/lnodep-${aci_logical_node_profile.ospf_lnp.name}/lifp-${aci_logical_interface_profile.ospf_inp.name}/rspathL3OutAtt-[${local.l3path}].json"
  # chybi id
  path       = "/api/mo/uni/tn-${var.tenant_name}/out-${aci_l3_outside.ospf_l3o.name}/lnodep-${aci_logical_node_profile.ospf_lnp.name}/lifp-${aci_logical_interface_profile.ospf_inp.name}.json"
  class_name = "l3extRsPathL3OutAtt"
  content = {
    "encap"   = var.if_encap
    "addr"    = var.if_addr
    "ifInstT" = "ext-svi"
    "tDn"     = var.if_path
  }
  depends_on = [
    aci_logical_interface_profile.ospf_inp,
  ]
}

resource "aci_rest" "rest_l3out_ospf" {
  path       = "/api/mo/uni/tn-${var.tenant_name}/out-${aci_l3_outside.ospf_l3o.name}/lnodep-${aci_logical_node_profile.ospf_lnp.name}/lifp-${aci_logical_interface_profile.ospf_inp.name}.json"
  class_name = "ospfIfP"
  content = {
    "authKeyId" = "1"
    "authType"  = "none"
  }
  depends_on = [
    aci_rest.ospfpar_l3o, aci_rest.rest_l3out_att
  ]
}

/*
# !!!
# it looks like it is not possible to delete this resource
# !!!
resource "aci_rest" "rest_l3out_ospf_ifpol" {
  path       = "/api/mo/uni/tn-${var.tenant_name}/out-${aci_l3_outside.ospf_l3o.name}/lnodep-${aci_logical_node_profile.ospf_lnp.name}/lifp-${aci_logical_interface_profile.ospf_inp.name}/ospfIfP.json"
  class_name = "ospfRsIfPol"
  content = {
    "tnOspfIfPolName" = "default"
  }
  depends_on = [aci_rest.rest_l3out_ospf]
}
*/

#Ext. EPG
resource "aci_external_network_instance_profile" "ospf_ext_epg" {
  l3_outside_dn       = aci_l3_outside.ospf_l3o.id
  name                = "${var.l3out_basename}-OSPF_EPG"
  relation_fv_rs_prov = toset(var.con_prov)
  relation_fv_rs_cons = toset(var.con_cons)
}

resource "aci_l3_ext_subnet" "extsubnets" {
  for_each = toset(var.ext_subnets)

  external_network_instance_profile_dn = aci_external_network_instance_profile.ospf_ext_epg.id
  description                          = "Ext. subnet"
  ip                                   = each.value
  scope                                = "import-security"
}
