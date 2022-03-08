import sys
import acitoolkit.acitoolkit as aci
from acitoolkit import Session, Node, ExternalSwitch
print('='*40)
'''
Dicover the Physical Topology
'''
APIC_URL = 'https://sandboxapicdc.cisco.com'
USERNAME = 'admin'
PASSWORD = '!v3G@!4@Y'

session = aci.Session(APIC_URL, USERNAME, PASSWORD)
RESP = session.login()

device_ = 0

node = Node
getPhy = node.get(session)
for getPhy in getPhy:
    print(device_,' : ',getPhy)
    device_ = device_ + 1
print('='*40)



'''
data "aci_tenant" "dev_ten" {
  name  = "dev_ten"
}


data "aci_vrf" "dev_ctx" {
  tenant_dn  = aci_tenant.dev_ten.id
  name       = "foo_ctx"
}


data "aci_bridge_domain" "dev_bd" {
  tenant_dn  = aci_tenant.dev_ten.id
  name       = "foo_bd"
}

'''
