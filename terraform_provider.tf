terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.0.0"
    }
  }
}


provider "aci" { # defining the provide for login into the APIC
  # cisco-aci user name
  username = local.username #"admin"
  # cisco-aci password
  password = local.pwd #"C1sco12345" #"!v3G@!4@Y" #
  # cisco-aci url
  url = local.url # "https://sandboxapicdc.cisco.com"#"https://10.10.20.14"

}
