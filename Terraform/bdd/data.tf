data "proxmox_virtual_environment_pool" "operations_pool" {
  pool_id = local.my_pool_id
}

data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key_filename
}