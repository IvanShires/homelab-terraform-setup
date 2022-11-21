terraform {
  required_providers {
    unifi = {
      source  = "paultyng/unifi"
      version = "0.38.2"
    }
  }
}

provider "unifi" {
  username       = var.unifi_username
  password       = var.unifi_password
  api_url        = var.unifi_api_url
  allow_insecure = true
}
