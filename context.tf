# Creating Context / VRF in ACI
resource "aci_vrf" "prod-vrf" {
  tenant_dn   = aci_tenant.terraform_tenant.id
  name        = local.prod_vrf
  description = "from terraform"
}


output "tenant_vrf_name" {
  value = aci_vrf.prod-vrf.name
}
