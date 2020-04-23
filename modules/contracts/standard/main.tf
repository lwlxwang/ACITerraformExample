
resource "aci_contract" "PH-SSH_CON" {
  tenant_dn   = var.tenant_dn
  description = "SSH contract"
  name        = "PH-SSH_CON"
  scope       = "tenant"
}

resource "aci_contract_subject" "PH-SSH_COS" {
  contract_dn   = aci_contract.PH-SSH_CON.id
  description   = "ssh contract subject"
  name          = "PH-SSH_COS"
  cons_match_t  = "AtleastOne"
  prov_match_t  = "AtleastOne"
  rev_flt_ports = "yes"
  relation_vz_rs_subj_filt_att = toset(["PH-SSH_FLT"])
}

resource "aci_contract" "PH-IP_CON" {
  tenant_dn   = var.tenant_dn
  description = "IP contract"
  name        = "PH-IP_CON"
  scope       = "tenant"
}

resource "aci_contract_subject" "PH-IP_COS" {
  contract_dn   = aci_contract.PH-IP_CON.id
  description   = "ssh contract subject"
  name          = "PH-IP_COS"
  cons_match_t  = "AtleastOne"
  prov_match_t  = "AtleastOne"
  rev_flt_ports = "yes"
  relation_vz_rs_subj_filt_att = toset(["PH-IP_FLT"])
}
