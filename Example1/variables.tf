# variables are more like inputs and not "classical" variables as known from programming languages
variable "tenant_name" {
  type    = string
  default = "PH-TERRAFORM_TEN"  # if not specified, the var is asked during runtime
}
