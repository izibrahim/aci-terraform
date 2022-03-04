# Creating Context / VRF in ACI
resource "aci_subnet" "web_server_subnets" {
  parent_dn   = aci_bridge_domain.web_server_bd.id
  description = "subnet"
  ip          = local.bridge_domain_subnets[count.index]
  annotation  = "tag_subnet"
  name_alias  = "alias_subnet"
  scope       = ["private", "shared"]
  count       = local.bd_subnet

}

output "bd_subnets" {
  value = aci_subnet.web_server_subnets[*].ip
}
