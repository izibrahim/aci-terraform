resource "aci_attachable_access_entity_profile" "aaep" {
  name                    = local.aaep
  relation_infra_rs_dom_p = [aci_vlan_pool.vlan_pool[0].id] # Connect Domain with AAEP

}
