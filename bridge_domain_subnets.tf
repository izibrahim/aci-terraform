/*
# Creating Bridge Domain subnets
*/
resource "aci_subnet" "web_server_subnets" {
  parent_dn   = aci_bridge_domain.web_server_bd.id
  description = "subnet"
  for_each    = toset(local.bridge_domain_subnets)
  ip          = each.value
  #ip          = local.bridge_domain_subnets[count.index]
  annotation = "tag_subnet"
  name_alias = "alias_subnet"
  scope      = ["private", "shared"]
  #  count      = local.subnet_condition == true ? 1 : 0

}


/*
output "bd_subnets" {
  value = aci_subnet.web_server_subnets[*].ip
}
*/
