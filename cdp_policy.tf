/*
# Creating CDP policy
*/


resource "aci_cdp_interface_policy" "cdp" {
  name        = local.cdp_policy
  admin_st    = "enabled"
  annotation  = "tag_cdp"
  name_alias  = "alias_cdp"
  description = "From Terraform"
  count       = local.cdp_policy_condition == true ? 1 : 0

  lifecycle {
  ignore_changes = all
      }
}
