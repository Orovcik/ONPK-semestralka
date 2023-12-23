terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}
resource "openstack_compute_instance_v2" "minikube" {
  name            = "minikube"
  image_name      = "ubuntu-22.04-kis"
  flavor_name     = "1c05r8d"
  key_pair        = var.key_name
  security_groups = ["default"]

  network {
    port = var.minikube_private_port.id
  }
}

resource "openstack_compute_instance_v2" "bastion" {
  depends_on = [data.template_file.bastion_data]
  name            = "bastion"
  image_name      = "ubuntu-22.04-kis"
  flavor_name     = "2c2r20d"
  key_pair        = var.key_name
  security_groups = ["default"]
  user_data       = data.template_file.bastion_data.rendered

  network {
    port = var.bastion_private_port.id
    
  }
}


resource "openstack_compute_floatingip_associate_v2" "bastion_floating_ip_association" {
  floating_ip = var.bastion_floating_ip.address
  instance_id = openstack_compute_instance_v2.bastion.id
}

data "template_file" "bastion_data" {
  template   = file(var.bastion_userdata)
  vars = {
    IP_addr = openstack_compute_instance_v2.minikube.access_ip_v4
  }
}


