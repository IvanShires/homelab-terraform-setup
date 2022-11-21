basename = "rvl"
subnet = "10.2"
unifi_networks = { ## subnet
  trusted = "100",
  servers = "104",
  iot = "106",
}
vlan_networks = {
  lab = "108"
}
guest_networks = {
  untrusted  = "102",
}