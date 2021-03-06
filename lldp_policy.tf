/*
 Creating lldp policy
*/

resource "aci_lldp_interface_policy" "lldp_policy" {
  description = "example description"
  name        = local.lldp_interface_policy
  admin_rx_st = "enabled"
  admin_tx_st = "enabled"
  annotation  = "tag_lldp"
  name_alias  = "alias_lldp"
  count       = local.lldp_policy_condition == true ? 1 : 0
  lifecycle {
  ignore_changes = all
      }
    }
