resource "aci_contract" "contract" {
  tenant_dn = aci_tenant.terraform_tenant.id
  #   filer.name =
  description = "From Terraform"
  name        = local.contract
  annotation  = "tag_contract"
  name_alias  = "alias_contract"
  prio        = "level1"
  #     scope       = "tenant"
  #filter.filter_name = aci_filter.foofilter.id
}
resource "aci_filter" "filter" {
  tenant_dn   = aci_tenant.terraform_tenant.id
  description = "From Terraform"
  name        = local.filter
}


resource "aci_filter_entry" "filter_entry" {
  filter_dn     = aci_filter.filter.id
  description   = "From Terraform"
  for_each      = var.contract_filters
  name          = each.key
  #apply_to_frag = each.value.arp_flag
  #arp_opc       = each.value.arp_flag
  d_from_port   = each.value.destination_port_from
  d_to_port     = each.value.destination_port_to
  ether_t       = each.value.ethernet_type
  icmpv4_t      = each.value.icmp4
  icmpv6_t      = each.value.icmp4
  match_dscp    = each.value.dscp
  prot          = each.value.ip_protocol
  s_from_port   = each.value.source_port_from
  s_to_port     = each.value.source_port_to
  stateful      = each.value.stateful
  tcp_rules     = ["ack", "rst"]
}


/*

resource "aci_filter_entry" "foofilter_entry" {
  filter_dn     = aci_filter.filter.id
  description   = "From Terraform"
  name          = local.filtername
  annotation    = "tag_entry"
  apply_to_frag = "no"
  arp_opc       = local.arp_flag
  d_from_port   = local.destination_port_from
  d_to_port     = local.destination_port_to
  ether_t       = local.ethernet_type
  icmpv4_t      = local.icmp4
  icmpv6_t      = local.icmp4
  match_dscp    = local.dscp
  prot          = local.ip_protocol
  s_from_port   = local.source_port_from
  s_to_port     = local.source_port_to
  stateful      = local.stateful
  tcp_rules     = ["ack", "rst"]
}
/*

/*
resource "aci_contract_subject" "foocontract_subject" {
              contract_dn   = aci_contract.demo_contract.id
              description   = "from terraform"
              name          = "demo_subject"
              annotation    = "tag_subject"
              cons_match_t  = "AtleastOne"
              name_alias    = "alias_subject"
              prio          = "level1"
              prov_match_t  = "AtleastOne"
              rev_flt_ports = "yes"
              target_dscp   = "CS0"
              relation_vz_rs_subj_filt_att = [aci_filter.demo_filter.id]
          }

          resource "aci_filter_entry" "foofilter_entry" {
            filter_dn     = aci_filter.filter.id
            description   = "From Terraform"
            name          = "demo_entry"
            annotation    = "tag_entry"
            apply_to_frag = "yes"
            arp_opc       = "unspecified"
            d_from_port   = "22"
            d_to_port     = "22"
            ether_t       = "ipv4"
            icmpv4_t      = "unspecified"
            icmpv6_t      = "unspecified"
            match_dscp    = "CS0"
            name_alias    = "alias_entry"
            prot          = "tcp"
            s_from_port   = "22"
            s_to_port     = "22"
            stateful      = "no"
            tcp_rules     = ["ack", "rst"]
          }


    */
