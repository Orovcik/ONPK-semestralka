
module "network" {
  source = "./modules/network"
}

module "compute" {
  source = "./modules/compute"

  key_name = var.key_name

  bastion_userdata = var.bastion_userdata
  bastion_private_port = module.network.bastion_private_port
  minikube_private_port = module.network.minikube_private_port
  instance_settings = var.instance_settings
  bastion_floating_ip = module.network.bastion_floating_ip
}