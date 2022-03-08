
/*
 Creating EPG
*/

# EPG

resource "aci_application_epg" "epg_one_provider" {
  application_profile_dn = aci_application_profile.application_profile.id
  name                   = local.first_epg
  relation_fv_rs_bd      = aci_bridge_domain.web_server_bd.id
  count                  = local.provider_epg == local.first_epg ? 1 : 0
  relation_fv_rs_prov    = [aci_contract.contract.id]
}

resource "aci_application_epg" "epg_two_consumer" {
  application_profile_dn = aci_application_profile.application_profile.id
  name                   = local.first_epg
  relation_fv_rs_bd      = aci_bridge_domain.web_server_bd.id
  count                  = local.provider_epg == local.first_epg ? 1 : 0
  relation_fv_rs_cons    = [aci_contract.contract.id]
}


resource "aci_application_epg" "epg_two_provider" {
  application_profile_dn = aci_application_profile.application_profile.id
  name                   = local.first_epg
  relation_fv_rs_bd      = aci_bridge_domain.web_server_bd.id
  count                  = local.provider_epg != local.first_epg ? 0 : 1
  relation_fv_rs_prov    = [aci_contract.contract.id]

}

resource "aci_application_epg" "epg_one_consumer" {
  application_profile_dn = aci_application_profile.application_profile.id
  name                   = local.first_epg
  relation_fv_rs_bd      = aci_bridge_domain.web_server_bd.id
  count                  = local.provider_epg != local.first_epg ? 0 : 1
  relation_fv_rs_cons    = [aci_contract.contract.id]

}

resource "aci_epg_to_static_path" "second_epg_vlan_path_pro" {
  application_epg_dn = aci_application_epg.epg_two_provider[0].id
  tdn                = local.second_path_name
  annotation         = "annotation"
  encap              = local.second_epg_vlan
  count              = local.provider_epg != local.first_epg ? 0 : 1
}

resource "aci_epg_to_static_path" "second_epg_vlan_path_cons" {
  application_epg_dn = aci_application_epg.epg_two_consumer[0].id
  tdn                = local.second_path_name
  annotation         = "annotation"
  encap              = local.second_epg_vlan
  count              = local.provider_epg == local.first_epg ? 1 : 0
}



resource "aci_epg_to_static_path" "first_epg_vlan_path_pro" {
  application_epg_dn = aci_application_epg.epg_one_provider[0].id
  tdn                = local.first_path_name
  #  tdn        = "${topology / pod-1 / paths-local.leaf_one / pathep-[eth1/18]"
  annotation = "annotation"
  encap      = local.first_epg_vlan
  count      = local.provider_epg == local.first_epg ? 1 : 0
}


resource "aci_epg_to_static_path" "first_epg_vlan_path_cons" {
  application_epg_dn = aci_application_epg.epg_one_consumer[0].id
  tdn                = local.first_path_name
  #  tdn        = "${topology / pod-1 / paths-local.leaf_one / pathep-[eth1/18]"
  annotation = "annotation"
  encap      = local.first_epg_vlan
  count      = local.provider_epg != local.first_epg ? 0 : 1
}
