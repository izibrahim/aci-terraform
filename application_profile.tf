
/*
# Creating application Profile
*/



resource "aci_application_profile" "application_profile" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = local.application_profile
  lifecycle {
  ignore_changes = all
      }
}
