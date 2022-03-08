resource "aci_contract_subject" "contract_subject" {
  contract_dn                  = aci_contract.contract.id
  description                  = "from terraform"
  name                         = local.subjects
  relation_vz_rs_subj_filt_att = [aci_contract.contract.id]
}
