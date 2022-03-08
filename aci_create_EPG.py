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
epg_group = input("Enter EPG : ")


tenant = aci.Tenant(newTenant)
context = aci.Context(newContext, tenant)
bd = aci.BridgeDomain(newBD, tenant)
app_profile = aci.AppProfile(app_pro, tenant)
epg = aci.EPG(epg_group, app_profile)
bd.add_context(context)
epg.add_bd(bd)


APIC_URL = 'https://10.10.20.14'
USERNAME = 'admin'
PASSWORD = 'C1sco12345'

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
