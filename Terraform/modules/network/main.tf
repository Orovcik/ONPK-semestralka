terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_networking_network_v2" "public_network" {
  name           = "public_network"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "private_network" {
  name           = "private_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "public_subnet" {
  name       = "public_subnet"
  network_id = openstack_networking_network_v2.public_network.id
  cidr       = "192.168.4.0/24"
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name       = "private_subnet"
  network_id = openstack_networking_network_v2.private_network.id
  cidr       = "192.168.10.0/24"
  ip_version = 4
}

resource "openstack_networking_router_v2" "router" {
  name                = "router"
  admin_state_up      = true
  external_network_id = "3b3d6331-6050-497b-826f-4144382160bd"
  
}
  
resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.public_subnet.id
}

resource "openstack_networking_router_interface_v2" "router_interface_2" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.private_subnet.id
}

resource "openstack_networking_port_v2" "bastion_private_port" {
  name           = "bastion_private_port"
  network_id     = openstack_networking_network_v2.public_network.id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.public_subnet.id
  }
}

resource "openstack_networking_port_v2" "minikube_private_port" {
  name           = "minikube_private_port"
  network_id     = openstack_networking_network_v2.private_network.id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.private_subnet.id
  }
}

resource "openstack_networking_floatingip_v2" "bastion_floating_ip" {
  pool = "ext-net-154"
}
