# EPG

resource "aci_application_epg" "epg_one" {
  application_profile_dn = aci_application_profile.application_profile.id
  name                   = local.first_epg
  relation_fv_rs_bd      = aci_bridge_domain.web_server_bd.id
  #relation_fv_rs_prov = aci_epg_to_contract.demo_contract.id
  #  relation_fv_rs_prov  = [aci_contract.demo_contract.id]
}

resource "aci_application_epg" "epg_two" {
  application_profile_dn = aci_application_profile.application_profile.id
  name                   = local.second_epg
  relation_fv_rs_bd      = aci_bridge_domain.web_server_bd.id
  #    relation_fv_rs_cons  = [aci_contract.demo_contract.id]
}


resource "aci_epg_to_static_path" "first_epg_vlan_path" {
  application_epg_dn = aci_application_epg.epg_one.id
  tdn                = local.first_path_name
  #  tdn        = "${topology / pod-1 / paths-local.leaf_one / pathep-[eth1/18]"
  annotation = "annotation"
  encap      = local.first_epg_vlan
}


resource "aci_epg_to_static_path" "second_epg_vlan_path" {
  application_epg_dn = aci_application_epg.epg_two.id
  tdn                = local.second_path_name
  annotation         = "annotation"
  encap              = local.second_epg_vlan
}
