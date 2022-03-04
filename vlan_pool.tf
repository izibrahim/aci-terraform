resource "aci_vlan_pool" "vlan_pool" {
  name        = local.vlan_pool
  description = "From Terraform"
  alloc_mode  = local.vlan_pool_alloc_mode
  count       = local.vlan_pool_check == true ? 1 : 0
}


resource "aci_ranges" "range_1" {
  vlan_pool_dn = aci_vlan_pool.vlan_pool[0].id
  description  = "From Terraform"
  from         = local.vlan_pool_range_from
  to           = local.vlan_pool_range_to
  count        = local.vlan_pool_check == true ? 1 : 0
}
