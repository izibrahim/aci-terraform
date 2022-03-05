resource "aci_attachable_access_entity_profile" "aaep" {
  name                    = local.aaep
  relation_infra_rs_dom_p = [aci_physical_domain.physical_domain[0].id] # Connect Domain with AAEP

}
