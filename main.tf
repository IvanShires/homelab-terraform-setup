resource "unifi_network" "network" {
  for_each     = var.networks
  name         = each.key
  purpose      = "corporate"
  subnet       = "192.168.${2 + index(keys(var.networks), each.key)}.0/24"
  vlan_id      = (2 + index(keys(var.networks), each.key)) * 100
  dhcp_start   = "192.168.${2 + index(keys(var.networks), each.key)}.6"
  dhcp_stop    = "192.168.${2 + index(keys(var.networks), each.key)}.254"
  dhcp_enabled = true
}

resource "unifi_network" "guest_networks" {
  for_each     = var.guest_networks
  name         = "${var.basename}-${each.key}"
  purpose      = "guest"
  subnet       = "${var.subnet}.${each.value}.1/23"
  # subnet       = "${var.subnet}.${each.value}.1/24  /24 network
  vlan_id      = "${each.value}"
  dhcp_start   = "${var.subnet}.${each.value}.6"
  dhcp_stop    = "${var.subnet}.${each.value + 1}.254"
  ## dhcp_stop    = "${var.subnet}.${each.value}.254"  /24 network
  dhcp_enabled = true
}

resource "unifi_network" "vlan_networks" {
  for_each     = var.vlan_networks
  name         = "${var.basename}-${each.key}"
  purpose      = "vlan-only"
  subnet       = "${var.subnet}.${each.value}.1/23"
  # subnet       = "${var.subnet}.${each.value}.1/24  /24 network
  vlan_id      = "${each.value}"
  dhcp_enabled = false
}

# The below group was created to adopt "Option 2: Block all VLANs to one another" from the following Unifi's guide: https://help.ui.com/hc/en-us/articles/115010254227-UniFi-USG-Firewall-How-to-Disable-InterVLAN-Routing
resource "unifi_firewall_group" "no_inter_vlan" {
  name    = "RFC1918"
  type    = "address-group"
  members = ["10.0.0.0/8", "172.16.0.0/12"]
}

resource "unifi_firewall_rule" "drop_all" {
  name                   = "DenyInterVLANTraffic"
  action                 = "drop"
  ruleset                = "LAN_IN"
  rule_index             = 2001
  protocol               = "all"
  src_firewall_group_ids = [unifi_firewall_group.no_inter_vlan.id]
  dst_firewall_group_ids = [unifi_firewall_group.no_inter_vlan.id]
}
