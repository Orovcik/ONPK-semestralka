
# WHOLE RESOURCES

output "minikube_private_port" {
  value = openstack_networking_port_v2.minikube_private_port
}

output "bastion_private_port" {
  value = openstack_networking_port_v2.bastion_private_port
}

output "bastion_floating_ip_adress" {
  value = openstack_networking_floatingip_v2.bastion_floating_ip.address
}

output "bastion_floating_ip" {
  value = openstack_networking_floatingip_v2.bastion_floating_ip
}

