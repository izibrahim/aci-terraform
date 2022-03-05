resource "aci_leaf_access_port_policy_group" "ipg_policy" { # IPG
  name                          = local.igp_policy
  relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.cdp[0].id
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.lldp_policy[0].id
  count                         = local.cdp_policy_condition == true && local.lldp_policy_condition == true ? 1 : 0 || local.cdp_policy_condition == false && local.lldp_policy_condition == true ? "relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.lldp_policy[0].id" : 0 || local.lldp_policy_condition == false && local.cdp_policy_condition == true ? "relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.cdp[0].id" : 0 #Create the IPG and connected to AAEP
}

/*
resource "aci_leaf_access_port_policy_group" "ipg_policy" { # IPG
  name                          = local.igp_policy
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.lldp_policy[0].id
}


resource "aci_leaf_access_port_policy_group" "ipg_policy" { # IPG
  name                         = local.igp_policy
  relation_infra_rs_cdp_if_pol = aci_cdp_interface_policy.cdp[0].id
}
*/
