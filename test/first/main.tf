terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.token
}

resource "digitalocean_droplet" "api_instance" {
  image  = var.image_value
  name   = var.name_value
  region = var.region_value
  size   = var.size_value
}

