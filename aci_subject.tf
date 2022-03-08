resource "aci_contract_subject" "contract_subject" {
  contract_dn                  = aci_contract.contract.id
  description                  = "from terraform"
  name                         = local.subjects
  annotation                   = "tag_subject"
  cons_match_t                 = "AtleastOne"
  name_alias                   = "alias_subject"
  prio                         = "level1"
  prov_match_t                 = "AtleastOne"
  rev_flt_ports                = "yes"
  target_dscp                  = "CS0"
  relation_vz_rs_subj_filt_att = [aci_contract.contract.id]
}
