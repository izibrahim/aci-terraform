terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "2.0.0"
    }
  }
}


provider "aci" { # defining the provide for login into the APIC
  # cisco-aci user name
  username = "admin"
  # cisco-aci password
  password = "C1sco12345"
  # cisco-aci url
  url      = "https://10.10.20.14"

}

 # creating the Tenant in ACI
resource "aci_tenant" "terraform_tenant" {
  name        = var.terraform_tenant
  description = "This tenant is created by the Terraform ACI provider"
}

# Creating Context / VRF in ACI
resource "aci_vrf" "foovrf" {
  tenant_dn              = "${aci_tenant.terraform_tenant.id}"
  name                   = "demo_vrf"
  description            = "from terraform"

}

# creating the Bridge Domain in ACI
resource "aci_bridge_domain" "bd_for_subnet" {
  tenant_dn   = "${aci_tenant.terraform_tenant.id}"
  name        = "bd_for_subnet"
  description = "This bridge domain is created by the Terraform ACI provider"
}

# Creating the in Interface policy for CDP enable
resource "aci_cdp_interface_policy" "cdp_policy" {
  name        = "cdp_policy"
  admin_st    = "enabled"
  annotation  = "tag_cdp"
  name_alias  = "alias_cdp"
  description = "From Terraform"
}

# Creating the in Interface policy for LLDP
resource "aci_lldp_interface_policy" "lldp_policy" {
  description = "example description"
  name        = "demo_lldp_pol"
  admin_rx_st = "enabled"
  admin_tx_st = "enabled"
  annotation  = "tag_lldp"
  name_alias  = "alias_lldp"
}

# # Creating the in Interface policy for MCP
resource "aci_mcp_instance_policy" "mcp_policy" {
  admin_st         = "disabled"
  annotation       = "orchestrator:terraform"
  name_alias       = "mcp_instance_alias"
  description      = "From Terraform"
  ctrl             = []
  init_delay_time  = "180"
  key              = "example"
  loop_detect_mult = "3"
  loop_protect_act = "port-disable"
  tx_freq          = "2"
  tx_freq_msec     = "0"
}

# Creating the in Interface policy for LACP Policy
resource "aci_lacp_policy" "lacp_policy" {
  name        = "demo_lacp_pol"
  description = "from terraform"
  annotation  = "tag_lacp"
  ctrl        = ["susp-individual", "load-defer", "graceful-conv"]
  max_links   = "16"
  min_links   = "1"
  mode        = "off"
  name_alias  = "alias_lacp"
}


# Creating the in VLAN Pool

resource "aci_vlan_pool" "vlan_pool_1" {
  name       = "VLANPool1"
  alloc_mode = "static"
}

resource "aci_ranges" "range_1" {
  vlan_pool_dn  = aci_vlan_pool.vlan_pool_1.id
  description   = "From Terraform"
  from          = "vlan-1"
  to            = "vlan-2"
  alloc_mode    = "inherit"
  annotation    = "example"
  name_alias    = "name_alias"
  role          = "external"
}

resource "aci_physical_domain" "aci_p23_physdom" {
    name            =       "aci_p23_physdom"
    relation_infra_rs_vlan_ns = aci_vlan_pool.vlan_pool_1.id
}

#Connecting AAEP connect IPG and domain togther. Create AAEP
resource "aci_attachable_access_entity_profile" "aci_p23_l2_aep" {
    name            =       "aci_p23_l2_aep"
    relation_infra_rs_dom_p =       [aci_physical_domain.aci_p23_physdom.id] # Connect Domain with AAEP
}
#Create the IPG and connected to AAEP
resource "aci_leaf_access_port_policy_group" "aci_p23_intpolg_access" { # IPG
    name                            = "aci_p23_intpolg_access"
    relation_infra_rs_cdp_if_pol    = aci_cdp_interface_policy.cdp_policy.id
    relation_infra_rs_lldp_if_pol   = aci_lldp_interface_policy.lldp_policy.id
    relation_infra_rs_att_ent_p     = aci_attachable_access_entity_profile.aci_p23_l2_aep.id #Create the IPG and connected to AAEP
}

# Create Interface Profile to map with Switch porfile, leaf profile will have port selector and map to IPG

resource "aci_leaf_interface_profile" "aci_p23_acc_intf_p" {
    name                            = "aci_p23_acc_intf_p"
}

# Creating the leaf profile or Switch Profile and connected to Interface Profile
resource "aci_leaf_profile" "aci_p23_access_sp" {
    name                         = "aci_p23_access_sp"
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.aci_p23_acc_intf_p.id]
}
# creating the Port Selector and associate with IPG
resource "aci_access_port_selector" "pod23_acc_port_selector" {
    leaf_interface_profile_dn      = aci_leaf_interface_profile.aci_p23_acc_intf_p.id
    name                           = "pod23_acc_port_selector"
    access_port_selector_type      = "range"
    relation_infra_rs_acc_base_grp = aci_leaf_access_port_policy_group.aci_p23_intpolg_access.id # associate with IPG
}

# Mapping port with interface  profile
resource "aci_access_port_block" "pod23_acc_port_block" {
    access_port_selector_dn = aci_access_port_selector.pod23_acc_port_selector.id
    name                    = "pod23_acc_port_block"
    from_card               = "1"
    from_port               = var.access_port
    to_card                 = "1"
    to_port                 = var.access_port
}


# Creating application Profile

resource "aci_application_profile" "demo_application_profile" {
  tenant_dn  = aci_tenant.terraform_tenant.id
  name       = "demo_application_profile"
}


#creating EPG
resource "aci_application_epg" "demo_epg" {
    application_profile_dn  = aci_application_profile.demo_application_profile.id
    name                    = "demo_epg"
    relation_fv_rs_bd = aci_bridge_domain.bd_for_subnet.id
    #relation_fv_rs_prov = aci_epg_to_contract.demo_contract.id
    relation_fv_rs_prov  = [aci_contract.demo_contract.id]
}

resource "aci_application_epg" "demo_epg_two" {
    application_profile_dn  = aci_application_profile.demo_application_profile.id
    name                    = "demo_epg_two"
    relation_fv_rs_bd = aci_bridge_domain.bd_for_subnet.id
    relation_fv_rs_cons  = [aci_contract.demo_contract.id]
}



# bind the EPG to port
resource "aci_epg_to_static_path" "demo_epg" {
  application_epg_dn  = aci_application_epg.demo_epg.id
  tdn  = "topology/pod-1/paths-101/pathep-[eth1/23]"
  annotation = "annotation"
  encap  = "vlan-1201"
}

resource "aci_epg_to_static_path" "example_two" {
  application_epg_dn  = aci_application_epg.demo_epg_two.id
  tdn  = "topology/pod-1/paths-102/pathep-[eth1/23]"
  annotation = "annotation"
  encap  = "vlan-1201"
}

resource "aci_contract" "demo_contract" {
     tenant_dn   =  aci_tenant.terraform_tenant.id
  #   filer.name =
     description = "From Terraform"
     name        = "demo_contract"
     annotation  = "tag_contract"
     name_alias  = "alias_contract"
     prio        = "level1"
     scope       = "tenant"
     target_dscp = "unspecified"
     #filter.filter_name = aci_filter.foofilter.id
 }

 resource "aci_filter" "demo_filter" {
       tenant_dn   = aci_tenant.terraform_tenant.id
       description = "From Terraform"
       name        = "demo_filter"
       annotation  = "tag_filter"
       name_alias  = "alias_filter"
   }
resource "aci_filter_entry" "foofilter_entry" {
           filter_dn     = aci_filter.demo_filter.id
           description   = "From Terraform"
           name          = "demo_entry"
           annotation    = "tag_entry"
           apply_to_frag = "no"
           arp_opc       = "unspecified"
           d_from_port   = "unspecified"
           d_to_port     = "unspecified"
           ether_t       = "ipv4"
           icmpv4_t      = "unspecified"
           icmpv6_t      = "unspecified"
           match_dscp    = "CS0"
           name_alias    = "alias_entry"
           prot          = "tcp"
           s_from_port   = "0"
           s_to_port     = "0"
           stateful      = "no"
           tcp_rules     = ["ack","rst"]
       }
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
