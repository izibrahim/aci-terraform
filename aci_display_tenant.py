'''
Create TENANT in ACI using APIs
'''

import sys
import acitoolkit.acitoolkit as aci

'''
provider "aci" { # defining the provide for login into the APIC
  # cisco-aci user name
  username = "admin"
  # cisco-aci password
  password = "!v3G@!4@Y"
  # cisco-aci url
  url      = "https://sandboxapicdc.cisco.com"

}
APIC_URL = 'https://10.10.20.14'
USERNAME = 'admin'
PASSWORD = 'C1sco12345'




APIC_URL = 'https://sandboxapicdc.cisco.com'
USERNAME = 'admin'
PASSWORD = '!v3G@!4@Y'
'''
APIC_URL = 'https://10.10.20.14'
USERNAME = 'admin'
PASSWORD = 'C1sco12345'





session = aci.Session(APIC_URL, USERNAME, PASSWORD)
resp = session.login()
getContext = aci.Context.get(session)
tenants = aci.Tenant.get(session)
for tenant in tenants:
    #print(tenant.name)  # checking the Tenant list
    bdname = aci.BridgeDomain.get(session,tenant)
    print('===>',bdname[0])
    c = bdname[0]
    print(c.get_context())
    #print(type(bdname))
    for f in bdname:
        print('Tenant > : ',tenant.name,'|| Bridge-Domain > : ',f)
        #d = bdname.get_table(f,title="TST")
        print(f.get_tags())


for getContext in getContext:
    print(getContext.info())



'''
getContext = aci.Context.get(session)
for getContext in getContext:
    print(getContext)
    print('>',getContext.get_children())

'''

#print(getContext.get_table(contexts, title=''))
