# Terraform

## Requirements

* Docker

## Utilisation

Create file `terraform.tfvars` with this model :

``` hcl
scw_organisation = "<scw token>"
scw_token = "<scw token>"
scw_region = "<scw region>"

cf_email = "<cf email>""
cf_token = "<cf token>""
```

Apply your modifications : `make ARG="apply"` or `make ARG="<your command>"`