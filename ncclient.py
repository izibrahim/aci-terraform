
q = '''
<interfaces xmlns="http://openconfig.net/yang/interfaces">
   <interface>
        <name>Loopback100020</name>
            <config>
                <name>Loopback100020</name>
        <type xmlns:idx="urn:ietf:params:xml:ns:yang:iana-if-type">idx:softwareLoopback</type>
     <enabled>true</enabled>
    </config>
   </interface>
   '''
from ncclient import manager
from ncclient import manager
import xmltodict
from pprint import pprint


import re


netconf_template = open("interface_config.xml").read()

conn = manager.connect(
    host="sbx-iosxr-mgmt.cisco.com",
    username="admin",
    password='C1sco12345',
    hostkey_verify=False,
    allow_agent=False,
    look_for_keys=False,
    port=10000,
    timeout=60,
)

netconf_payload = netconf_template.format(int_name="Loopback20020")

netconf_reply = conn.edit_config(netconf_payload, target="running")
# Print the NETCONF Reply
print(netconf_reply)
