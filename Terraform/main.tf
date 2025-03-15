module "app" {
  source                  = "./app"
  name                    = var.name_app
  size_disk               = var.size_disk_app
  memory                  = var.memory_app
  ipv4_address            = var.ipv4_app
  ipv4_gateway            = var.ipv4_gateway_app
  ssh_public_key_filename = var.ssh_public_key
  user_account_username   = var.user_account_username
  vcpu_number             = var.vcpu_app

  depends_on = [module.bdd]

  providers = {
    proxmox : proxmox
  }

}

module "bdd" {
  source                  = "./bdd"
  name                    = var.name_bdd
  size_disk               = var.size_disk_bdd
  memory                  = var.memory_bdd
  ipv4_address            = var.ipv4_bdd
  ipv4_gateway            = var.ipv4_gateway_bdd
  ssh_public_key_filename = var.ssh_public_key
  user_account_username   = var.user_account_username
  vcpu_number             = var.vcpu_bdd

  providers = {
    proxmox : proxmox
  }

}

resource "local_file" "ansible_inventory" {
  filename = "${path.root}/../Ansible/inventory/inventory.ini"
  content  = <<-EOT
[bdd]
host-bdd ansible_host=${split("/", var.ipv4_bdd)[0]} ansible_user=${var.user_account_username} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

[app]
host-app ansible_host=${split("/", var.ipv4_app)[0]} ansible_user=${var.user_account_username} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
EOT

  depends_on = [
    module.app,
    module.bdd
  ]
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "cd ${path.root}/../Ansible && ansible-playbook -i inventory/inventory.ini main.yml"
  }

  depends_on = [
    local_file.ansible_inventory
  ]
}