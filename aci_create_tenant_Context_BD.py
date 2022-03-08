'''
Create TENANT/Context/BD in ACI using APIs
'''

import sys
import acitoolkit.acitoolkit as aci

newTenant = input("Enter TENANT Name : ")
newContext = input("Enter Context Name : ")
newBD = input("Enter BD Name : ")


tenant = aci.Tenant(newTenant)
context = aci.Context(newContext, tenant)
bd = aci.BridgeDomain(newBD, tenant)
bd.add_context(context)


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
