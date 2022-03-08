/*
# Creating Bridge Domain
*/


resource "aci_bridge_domain" "web_server_bd" {
  tenant_dn          = aci_tenant.terraform_tenant.id
  name               = local.bridge_domain
  description        = "This bridge domain is created by the Terraform ACI provider"
  relation_fv_rs_ctx = aci_vrf.prod-vrf.id
}

output "tenant_name_bd" {
  value = aci_bridge_domain.web_server_bd.name # split expression
}
