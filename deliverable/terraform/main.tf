terraform {
  required_providers {
    kamatera = {
      source = "Kamatera/kamatera"
    }
  }
}

provider "kamatera" {
    api_client_id = ""
    api_secret = ""
}

data "kamatera_datacenter" "frankfurt" {
  country = "Germany"
  name = "Frankfurt"
}

data "kamatera_image" "ubuntu_2204" {
  datacenter_id = data.kamatera_datacenter.frankfurt.id
  os = "Ubuntu"
  code = "22.04 64bit"
}

resource "kamatera_server" "servera" {
  name = "servera"
  datacenter_id = data.kamatera_datacenter.frankfurt.id
  cpu_type = "B"
  cpu_cores = 4
  ram_mb = 8192
  disk_sizes_gb = [15, 20]
  billing_cycle = "monthly"
  image_id = data.kamatera_image.ubuntu_2204.id
  password = "Aa123456789!"
  ssh_pubkey = ""
  
  network {
    name = "wan"
  }
  
}

output "instance_ip_addr" {
  value = kamatera_server.servera.public_ips
}


