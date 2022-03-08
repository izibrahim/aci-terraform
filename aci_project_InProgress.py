'''
Create TENANT/Context/BD in ACI using APIs
'''

import sys
from acitoolkit import Credentials, Session, Tenant, AppProfile, BridgeDomain, EPG
import acitoolkit.acitoolkit as aci

'''
Input from the USER, Tenant Name,Context,Bridge Domain,Application Profile, epg
it will create Tenant Name,Context,Bridge Domain,Application Profile, epg and add epg in bridge domain
'''
newTenant = input("Enter TENANT Name : ")
newContext = input("Enter Context Name : ")
newBD = input("Enter BD Name : ")
app_pro = input("Enter App Profile : ")
epg_group_1 = input("Enter EPG 1 : ")
epg_group_2 = input("Enter EPG 2 : ")
subnet_add  = input('Add Subnet to BD: ')

tenant = aci.Tenant(newTenant)
context = aci.Context(newContext, tenant)
bd = aci.BridgeDomain(newBD, tenant)
app_profile = aci.AppProfile(app_pro, tenant)
epg_1 = aci.EPG(epg_group_1, app_profile)
epg_2 = aci.EPG(epg_group_2, app_profile)
bd.add_context(context)
#bd.add_subnet('10.0.0.1')
#x = '10.1.1.1/24'
sub1 = aci.Subnet('sub1', bd)
sub1.set_addr('1.1.1.1/24)
bd.add_subnet(sub1)
bd.add_tag('Hello')
epg_1.add_bd(bd)
epg_2.add_bd(bd)
#epg.consume(contract)
contract = aci.Contract('mycontract', tenant)

#epg_1.consume(contract)

icmp_entry = aci.FilterEntry('icmpentry',
                         applyToFrag='no',
                         arpOpc='unspecified',
                         dFromPort='unspecified',
                         dToPort='unspecified',
                         etherT='ip',
                         prot='icmp',
                         sFromPort='unspecified',
                         sToPort='unspecified',
                         tcpRules='unspecified',
                         parent=contract)

epg_1.provide(contract)
epg_2.consume(contract)


# Create the physical interface objects representing the physical ethernet ports
first_intf = aci.Interface('eth', '1', '101', '1', '18')
second_intf = aci.Interface('eth', '1', '102', '1', '18')

# Create a VLAN interface and attach to each physical interface
first_vlan_intf = aci.L2Interface('vlan5-on-eth1-101-1-18', 'vlan', '6')
first_vlan_intf.attach(first_intf)
second_vlan_intf = aci.L2Interface('vlan5-on-eth1-102-1-18', 'vlan', '6')
second_vlan_intf.attach(second_intf)

# Attach the EPGs to the VLAN interfaces
epg_1.attach(first_vlan_intf)
epg_2.attach(second_vlan_intf)

# below APIC is for VPN
'''
APIC_URL = 'https://10.10.20.14'
USERNAME = 'admin'
PASSWORD = 'C1sco12345'
'''

APIC_URL = 'https://sandboxapicdc.cisco.com'
USERNAME = 'admin'
PASSWORD = '!v3G@!4@Y'


session = aci.Session(APIC_URL, USERNAME, PASSWORD)
resp = session.login()


resp = session.push_to_apic(tenant.get_url(), data=tenant.get_json()) # this call will push the new tenant to ACI
print(resp)

gettenants = aci.Tenant.get(session)
for gettenants in gettenants:
    print(gettenants.name) # checking the Tenant list

print('='*20,'Context ')


getContext = aci.Context.get(session)
for getContext in getContext:
    print(getContext.name) # checking the Tenant list
