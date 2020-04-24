# ACI Terraform Example

## Example how to deploy an ACI configuration using Terraform

This example doesn't deploy any useful configuration. It's purpose is to demonstrate how Cisco ACI configuration can be managed using Terraform.
If you don't have an ACI controller you can play with, you can use the Cisco ACI Sandbox (<https://sandboxapicdc.cisco.com/)> which is publicly available

The example creates:

* tenant

* vrf, application profile, EPG

* filters, contracts

* L3out (OSPF)

## How to use this example

* Download and install Terraform

<https://www.terraform.io/downloads.html>

* Clone the repository

* Edit configuration files

Change the ip_path attribute used in Example1/main.tf to a path string valid in your environment.
You can change the ACI tenant name in Example1/variables.tf

* Set the following environment variables

```txt
ACI_USERNAME = "username"
ACI_PASSWORD = "password"
or
ACI_USERNAME = "username"
ACI_CERT_NAME = "cert.crt" # CRT file name (as was paste to the user account in ACI)
ACI_PRIVATE_KEY = "\path_tocert\cert.key" # path to a private key

ACI_URL = "https://path_to_apic"
```

See <https://www.terraform.io/docs/providers/aci/index.html> for details

* Change directory to Example1

* Initialize Terraform

```txt
terraform init
```

* Create Terraform exacution plan

```txt
terraform plan
```

* Apply the configuration

```txt
terraform apply
```

When asked to enter a value, enter "yes"
A the end some variables are printed out to demonstrate this capability.

* Destroy the Terraform managed infrastructure

```txt
terraform destroy
```
