/*
 User input 
*/

locals {
  username                  = "admin"                                          # admin username
  pwd                       = "C1sco12345"                                     #"C1sco12345"                                     # admin password
  url                       = "https://10.10.20.14"                            # "https://10.10.20.14"                            # ACI URL
  aci_tenant                = "Prod_webserver_Tenant"                          # This will create Tenant
  bridge_domain             = "Prod_webserver_domain"                          # This will create Bridge Domain
  bridge_domain_subnets     = ["10.0.3.28/27", "10.0.5.28/27", "10.0.6.28/27"] # add subnet to bridge domain use [] empty if you dont want to add the subnets inside bridge domain
  prod_vrf                  = "Prod_webserver_vrf"                             # This will create VRF or Context
  cdp_policy                = "Prod_cdp_policy"                                # cdp policy name
  cdp_policy_condition      = true                                             # or false  if this is true it will create CDP policy
  lldp_interface_policy     = "Prod_lldp_policy"                               # lldp policy name
  lldp_policy_condition     = true                                             # or false  if this is true it will create lldp policy
  mcp_policy                = "Prod_mcp_polciy"                                # mcp policy name
  mcp_policy_condition      = true                                             # or false  if this is true it will create mcp policy
  vlan_pool                 = "Prod_vlan_pool"                                 # vlan pool name
  vlan_pool_alloc_mode      = "static"                                         # dynamic
  vlan_pool_range_from      = "vlan-10"                                        # vlan range
  vlan_pool_range_to        = "vlan-20"                                        # vlan range
  vlan_pool_check           = true                                             # or false if this is true it will create vlan pool
  physical_domain           = "Prod_phy_domain"                                # Add create physical domain
  physical_domain_condition = true                                             # if vlan_pool_check is true and physical_domain_condition then phyical domain will be created
  aaep                      = "Prod_AAEP"                                      # create AAEP
  igp_policy                = "Prod_igp"                                       # create IGP interface group pr
  switch_profile            = "Prod_switch_profile"
  leaf_profile              = "Prod_leaf_profile"
  leaf_one                  = "101"
  leaf_two                  = "102"
  port_selector_leaf_1      = "1"   #examples 1/108
  interface_id_leaf_1       = "108" #examples 1/108
  port_selector_leaf_2      = "2"   #examples 2/108
  interface_id_leaf_2       = "108" #2/108
  application_profile       = "Prod_app_profile"
  first_epg                 = "Prod_epg_1"
  second_epg                = "Prod_epg_2"
  first_epg_vlan            = "vlan-1201"
  second_epg_vlan           = "vlan-1201"
  provider_epg = "Prod_epg_1"
  first_path_name  = "topology/pod-1/paths-${local.leaf_one}/pathep-[eth${local.port_selector_leaf_1}/${local.interface_id_leaf_1}]"
  second_path_name = "topology/pod-1/paths-${local.leaf_two}/pathep-[etheth${local.port_selector_leaf_2}/${local.interface_id_leaf_2}]"
  contract         = "Prod_contract"
  filter           = "Prod_filter"
  subjects         = "Prod_subject"
}


/*
 Create Filter policies
*/

variable "contract_filters" {
  type = map(any)
  default = {
    allow_http = {
      apply_to_frag = "no"
      #  arp_flag              = "no"
      destination_port_from = "unspecified"
      destination_port_to   = "unspecified"
      ethernet_type         = "ipv4"
      icmp4                 = "unspecified"
      icmp4                 = "unspecified"
      dscp                  = "CS0"
      ip_protocol           = "tcp"
      source_port_from      = "0"
      source_port_to        = "0"
      stateful              = "yes"
      tcp_rules             = ["ack", "rst"]

    }
    allow_https = {
      apply_to_frag = "no"
      #  arp_flag              = "no"
      destination_port_from = "unspecified"
      destination_port_to   = "unspecified"
      ethernet_type         = "ipv4"
      icmp4                 = "unspecified"
      icmp4                 = "unspecified"
      dscp                  = "CS0"
      ip_protocol           = "tcp"
      source_port_from      = "0"
      source_port_to        = "0"
      stateful              = "yes"
      tcp_rules             = ["ack", "rst"]

    }
    # Add more filter here if you want
    allow_ssh = {
      apply_to_frag = "no"
      #  arp_flag              = "no"
      destination_port_from = "23"
      destination_port_to   = "23"
      ethernet_type         = "ipv4"
      icmp4                 = "unspecified"
      icmp4                 = "unspecified"
      dscp                  = "CS0"
      ip_protocol           = "tcp"
      source_port_from      = "22"
      source_port_to        = "22"
      stateful              = "yes"
      tcp_rules             = ["ack", "rst"]

    }
  }

}
