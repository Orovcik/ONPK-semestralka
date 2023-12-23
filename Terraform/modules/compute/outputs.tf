

output "bastion_floating_ip_association" {
  value = openstack_compute_floatingip_associate_v2.bastion_floating_ip_association
}

output "bastion_private_IP" {
  value = openstack_compute_instance_v2.bastion.access_ip_v4
}

output "minikube_instance_IP" {
  value = openstack_compute_instance_v2.minikube.access_ip_v4
}
