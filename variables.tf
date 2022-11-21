variable "basename" {
  description = "The basename/prefix with which all WiFi networks names start."
  type        = string
}

variable "subnet" {
  description = "The basename/prefix with which all WiFi networks names start."
  type        = string
}

variable "unifi_username" {
  description = "After the docs: 'Local user name for the Unifi controller API. Can be specified with the UNIFI_USERNAME environment variable.'"
  type        = string
  default     = null
}
variable "unifi_password" {
  description = "After the docs: 'Password for the user accessing the API. Can be specified with the UNIFI_PASSWORD environment variable.'"
  type        = string
  default     = null
}

variable "unifi_api_url" {
  description = "After the docs: 'URL of the controller API. Can be specified with the UNIFI_API environment variable. You should NOT supply the path (/api), the SDK will discover the appropriate paths. This is to support UDM Pro style API paths as well as more standard controller paths.'"
  type        = string
  default     = "https://10.0.0.1/network/"
}

variable "unifi_networks" { ## This the value of each key is the VLAN or the subnet, as they are the same value
  description = "A map of networks and their VLAN ID / subnet"
  type = map(string)
}

variable "vlan_networks" { ## This the value of each key is the VLAN or the subnet, as they are the same value
  description = "A map of networks and their VLAN ID / subnet"
  type = map(string)
}

variable "guest_networks" { ## This the value of each key is the VLAN or the subnet, as they are the same value
  description = "A map of networks and their VLAN ID / subnet"
  type = map(string)
}