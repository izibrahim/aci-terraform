/*
 Creating leaf profile
*/

resource "aci_leaf_interface_profile" "leaf_profile" {
  name = local.leaf_profile
}


resource "aci_leaf_profile" "switch_profile" {
  name                         = local.switch_profile
  description                  = "From Terraform"
  relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.leaf_profile.id]
  leaf_selector {
    name                    = "one"
    switch_association_type = "range"
    node_block {
      name  = "blk1"
      from_ = local.leaf_one
      to_   = local.leaf_two
    }
  }
}



resource "aci_access_port_selector" "ports" {
  leaf_interface_profile_dn      = aci_leaf_interface_profile.leaf_profile.id
  name                           = "ports"
  access_port_selector_type      = "range"
  relation_infra_rs_acc_base_grp = aci_leaf_access_port_policy_group.ipg_policy[0].id # associate with IPG # here need to mapping this is port selector with IGP
}

# Mapping port with interface  profile
resource "aci_access_port_block" "pod23_acc_port_block" {
  access_port_selector_dn = aci_access_port_selector.ports.id
  name                    = "pod23_acc_port_block"
  from_card               = local.port_selector_leaf_1 #"1"
  from_port               = local.interface_id_leaf_1  #"108"
  to_card                 = local.port_selector_leaf_2 # "2"
  to_port                 = local.interface_id_leaf_2
}
