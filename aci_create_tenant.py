'''
Create TENANT in ACI using APIs
'''

import sys
import acitoolkit.acitoolkit as aci

newTenant = input("Enter TENANT Name : ")


tenant = aci.Tenant(newTenant)

APIC_URL = 'https://10.10.20.14'
USERNAME = 'admin'
PASSWORD = 'C1sco12345'

session = aci.Session(APIC_URL, USERNAME, PASSWORD)
resp = session.login()


resp = session.push_to_apic(tenant.get_url(), data=tenant.get_json()) # this call will push the new tenant to ACI
print(resp)

tenants = aci.Tenant.get(session)
for tenant in tenants:
    print(tenant.name) # checking the Tenant list
