/*

*/
locals {
  username                  = "admin"                                          # admin username
  pwd                       = "C1sco12345"                                     # admin password
  url                       = "https://10.10.20.14"                            # ACI URL
  aci_tenant                = "Prod_webserver_Tenant"                          # This will create Tenant
  bridge_domain             = "Prod_webserver_domain"                          # This will create Bridge Domain
  bridge_domain_subnets      = ["10.0.3.28/27", "10.0.5.28/27", "10.0.6.28/27"] # add subnet to bridge domain use [] empty if you dont want to add the subnets inside bridge domain
  prod_vrf                  = "Prod_webserver_vrf"                             # This will create VRF or Context
  cdp_policy                = "Prod_cdp_policy"                                # cdp policy name
  cdp_policy_condition      = true                                       # or false  if this is true it will create CDP policy
  lldp_interface_policy     = "Prod_lldp_policy"                               # lldp policy name
  lldp_policy_condition     = true                                             # or false  if this is true it will create lldp policy
  mcp_policy                = "Prod_mcp_polciy"                                # mcp policy name
  mcp_policy_condition      = true                                             # or false  if this is true it will create mcp policy
  vlan_pool                 = "Prod_vlan_pool"                                 # vlan pool name
  vlan_pool_alloc_mode      = "static"                                         # dynamic
  vlan_pool_range_from      = "vlan-10"                                        # vlan range
  vlan_pool_range_to        = "vlan-20"                                        # vlan range
  vlan_pool_check           = true                                          # or false if this is true it will create vlan pool
  physical_domain           = "Prod_phy_domain"                                # Add create physical domain
  physical_domain_condition = true                                            # if vlan_pool_check is true and physical_domain_condition then phyical domain will be created
}

/*
variable "bridge_domain_subnets" {
  type    = list(any)
  default = ["10.0.3.28/27", "10.0.5.28/27", "10.0.6.28/27"]
}
*/
