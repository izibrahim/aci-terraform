
resource "aci_mcp_instance_policy" "mcp_policy" {
  admin_st         = "disabled"
  annotation       = "orchestrator:terraform"
  name_alias       = local.mcp_policy
  description      = "From Terraform"
  ctrl             = []
  init_delay_time  = "180"
  key              = "example"
  loop_detect_mult = "3"
  loop_protect_act = "port-disable"
  tx_freq          = "2"
  tx_freq_msec     = "0"
  count            = local.mcp_policy_condition == true ? 1 : 0
}

output "mcp_policy_enable" {
  value = aci_mcp_instance_policy.mcp_policy[0].name_alias
}
