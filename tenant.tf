/*
 Creating tenant
*/


# creating the Tenant in ACI
resource "aci_tenant" "terraform_tenant" {
  name        = local.aci_tenant
  description = "This tenant is created by the Terraform ACI provider"
  lifecycle {
  ignore_changes = all
      }

}

output "tenant_name" {
  value = aci_tenant.terraform_tenant.name
}
