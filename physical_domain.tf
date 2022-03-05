
resource "aci_physical_domain" "physical_domain" {
  #  prod = local.vlan_pool_check == true ? " : "south"
  name                      = local.physical_domain
  relation_infra_rs_vlan_ns = aci_vlan_pool.vlan_pool[0].id
  count                     = local.physical_domain_condition && local.vlan_pool_check == true ? 1 : 0
  depends_on = [
    aci_vlan_pool.vlan_pool[0]
  ]
}
