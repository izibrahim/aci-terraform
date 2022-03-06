resource "aci_leaf_access_port_policy_group" "ipg_policy" { # IPG
  name                          = local.igp_policy
  relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.cdp[0].id
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.lldp_policy[0].id
  relation_infra_rs_att_ent_p   = aci_attachable_access_entity_profile.aaep.id
  count                         = local.cdp_policy_condition == true && local.lldp_policy_condition == true ? 1 : 0 #|| local.cdp_policy_condition == false && local.lldp_policy_condition == true ? aci_leaf_access_port_policy_group.ipg_lldp_policy : 0 #|| local.lldp_policy_condition == false && local.cdp_policy_condition == true ? "relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.cdp[0].id" : 0 #Create the IPG and connected to AAEP
}



resource "aci_leaf_access_port_policy_group" "ipg_policy_lldp" { # IPG
  name                          = local.igp_policy
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.lldp_policy[0].id
  relation_infra_rs_att_ent_p   = aci_attachable_access_entity_profile.aaep.id
  count                         = local.cdp_policy_condition == false && local.lldp_policy_condition == true ? 1 : 0 #|| local.cdp_policy_condition == false && local.lldp_policy_condition == true ? aci_leaf_access_port_policy_group.ipg_lldp_policy : 0 #|| local.lldp_policy_condition == false && local.cdp_policy_condition == true ? "relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.cdp[0].id" : 0 #Create the IPG and connected to AAEP
}



resource "aci_leaf_access_port_policy_group" "ipg_policy_cdp" { # IPG
  name                         = local.igp_policy
  relation_infra_rs_cdp_if_pol = aci_cdp_interface_policy.cdp[0].id
  relation_infra_rs_att_ent_p  = aci_attachable_access_entity_profile.aaep.id
  count                        = local.cdp_policy_condition == true && local.lldp_policy_condition == false ? 1 : 0 #|| local.cdp_policy_condition == false && local.lldp_policy_condition == true ? aci_leaf_access_port_policy_group.ipg_lldp_policy : 0 #|| local.lldp_policy_condition == false && local.cdp_policy_condition == true ? "relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.cdp[0].id" : 0 #Create the IPG and connected to AAEP
}



output "ipg_policy" {
  value       = aci_leaf_access_port_policy_group.ipg_policy
  description = "The private IP address of the main server instance."

  depends_on = [
    # Security group rule must be created before this IP address could
    # actually be used, otherwise the services will be unreachable.
    aci_leaf_access_port_policy_group.ipg_policy
  ]
}

output "ipg_policy_cdp" {
  value       = aci_leaf_access_port_policy_group.ipg_policy_cdp
  description = "The private IP address of the main server instance."

  depends_on = [
    # Security group rule must be created before this IP address could
    # actually be used, otherwise the services will be unreachable.
    aci_leaf_access_port_policy_group.ipg_policy_cdp
  ]
}


output "ipg_policy_lldp" {
  value       = aci_leaf_access_port_policy_group.ipg_policy_lldp
  description = "The private IP address of the main server instance."

  depends_on = [
    # Security group rule must be created before this IP address could
    # actually be used, otherwise the services will be unreachable.
    aci_leaf_access_port_policy_group.ipg_policy_lldp
  ]
}

/*

resource "aci_leaf_access_port_policy_group" "ipg_lldp_policy" { # IPG
  name                          = local.igp_policy
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.lldp_policy[0].id
}


resource "aci_leaf_access_port_policy_group" "ipg_cdp_policy" { # IPG
  name                         = local.igp_policy
  relation_infra_rs_cdp_if_pol = aci_cdp_interface_policy.cdp[0].id
}
*/
