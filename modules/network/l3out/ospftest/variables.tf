variable "tenant_name" {
  type    = string
}

variable "tenant_id" {
  type    = string
}

variable "l3out_basename" {
  type    = string
}

variable "vrf_name" {
  type    = string
}

variable "ospf_area" {
  type    = string
}

variable "if_path" {
  type    = string
}

variable "if_addr" {
  type    = string
}

variable "if_encap" {
  type    = string
}

variable "con_prov" {
  type    = list(string)
}

variable "con_cons" {
  type    = list(string)
}

variable "ext_subnets" {
  type    = list(string)
}