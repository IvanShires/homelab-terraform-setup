variable "basename" {
  type        = string
}
variable "subnet" {
  type        = string
}
variable "unifi_username" {
  description = "After the docs: 'Local user name for the Unifi controller API. Can be specified with the UNIFI_USERNAME environment variable.'"
  type        = string
}
variable "unifi_password" {
  type        = string
}

variable "opendns_username" {
  type        = string
}
variable "opendns_password" {
  type        = string
}

variable "unifi_api_url" {
  type = string
}

variable "unifi_networks" { ## This the value of each key is the VLAN or the subnet, as they are the same value
  description = "A map of networks and their VLAN ID / subnet"
  type = map(string)
}