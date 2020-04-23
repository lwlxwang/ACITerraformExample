# ACI Terraform Example

## Example how to deploy an ACI configuration using Terraform

This example doesn't deploy any useful configuration. It's purpose is to demonstrate how to use Cisco ACI can be managed using Terraform.
If you don't have an ACI controller you can play with, you can use the Cisco ACI Sandbox (<https://sandboxapicdc.cisco.com/)> which is publicly available

## How to use it

- Download and install Terraform

<https://www.terraform.io/downloads.html>

- Clone the repository

- Edit configuration files
Change ip_path attribute used in Example1/main.tf with path string valid in your environment.
You can change ACI tenant name in Example1/variables.tf

- Set the following environment variables

ACI_USERNAME = "user"
ACI_PASSWORD = "pass"
or
ACI_USERNAME = "username" # without domain, username only
ACI_CERT_NAME = "cert.crt" # CRT file name (as was paste to user account in ACI)
ACI_PRIVATE_KEY = "\path_tocert\cert.key" # path to private key

ACI_URL = "https://path_to_apic"

See <https://www.terraform.io/docs/providers/aci/index.html> for details

- Change directory to Example1

- Initialize Terraform

```txt
terraform init
```

- Create Terraform exacution plan

```txt
terraform plan
```

- Apply configuration

```txt
terraform apply
```
