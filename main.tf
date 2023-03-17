terraform {
  required_providers {
    virtualbox = {
      source  = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

provider "virtualbox" {
  delay      = 60
  mintimeout = 5
}

resource "virtualbox_vm" "vm1" {
  name = "ubuntu-vm1"
  #Default_image_link
  #image  = "https://app.vagrantup.com/shekeriev/boxes/debian-11/versions/0.2/providers/virtualbox.box"
  #Ubuntu_image_link
  #image  = "https://github.com/ccll/terraform-provider-virtualbox-images/releases"
  image  = "../images/ubuntu-15.04.tar.xz"
  cpus   = 1
  memory = "512 mib"

   network_adapter {
     type           = "hostonly"
     device         = "IntelPro1000MTDesktop"
     host_interface = "vboxnet0"
     # On Windows use this instead
     # host_interface = "VirtualBox Host-Only Ethernet Adapter"
   }
}

output "IPAddress" {
   value = element(virtualbox_vm.vm1.*.network_adapter.0.ipv4_address, 1)
}