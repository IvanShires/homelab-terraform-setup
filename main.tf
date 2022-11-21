resource "unifi_network" "network" {
  for_each     = var.unifi_networks
  name         = "${var.basename}-${each.key}"
  purpose      = "corporate"
  subnet       = "${var.subnet}.${each.value}.1/23"
  # subnet       = "${var.subnet}.${each.value}.1/24  /24 network
  vlan_id      = "${each.value}"
  dhcp_start   = "${var.subnet}.${each.value}.6"
  dhcp_stop    = "${var.subnet}.${each.value + 1}.254"
  ## dhcp_stop    = "${var.subnet}.${each.value}.254"  /24 network
  dhcp_enabled = true
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
  rule_index             = 2002
  protocol               = "all"
  src_firewall_group_ids = [unifi_firewall_group.no_inter_vlan.id]
  dst_firewall_group_ids = [unifi_firewall_group.no_inter_vlan.id]
}

resource "unifi_dynamic_dns" "test" {
  service = "dyndns"

  host_name = "${var.basename}-home.ivanshires.info"

  server   = "updates.dnsomatic.com"
  login    = var.opendns_username
  password = var.opendns_password
}