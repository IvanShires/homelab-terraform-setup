basename = "rvl"
subnet = "10.2"
unifi_networks = { ## subnet
  trusted = "100",
  untrusted  = "102",
  servers = "104",
  iot = "106",
}
vlan_networks = {
  lab = "108"
}
## this is useful for small businesses, etc..
##guest_networks = {
##  untrusted  = "102",
##}