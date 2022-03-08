import sys
import acitoolkit.acitoolkit as aci

print('='*40)
'''
APIC_URL = input("Enter APIC IP ADDRESS : ")
USERNAME =  input("Enter USERNAME : ")
PASSWORD = input("Enter PASSWORD : ")
'''
APIC_URL = 'https://10.10.20.14'
USERNAME = 'admin'
PASSWORD = 'C1sco12345'

# Login to APIC
SESSION = aci.Session(APIC_URL, USERNAME, PASSWORD)
RESP = SESSION.login()


tenants = aci.Tenant.get(SESSION)
for tenant in tenants:
    print(tenant.name)

''''

ENDPOINTS = aci.Endpoint.get(SESSION)
print('{0:19s}{1:14s}{2:10s}{3:8s}{4:17s}{5:10s}'.format("MAC ADDRESS","IP ADDRESS","ENCAP","TENANT","APP PROFILE","EPG"))
print('-'*80)

for EP in ENDPOINTS:
    epg = EP.get_parent()
    app_profile = epg.get_parent()
    tenant = app_profile.get_parent()
    print('{0:19s}{1:14s}{2:10s}{3:8s}{4:17s}{5:10s}'.format(EP.mac,EP.ip,EP.encap,tenant.name,app_profile.name,epg.name))
#aci.tenants = aci.Tenant.get(SESSION)

'''
