resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = var.name
  node_name = local.my_node_name
  pool_id   = data.proxmox_virtual_environment_pool.operations_pool.pool_id

  count = 1

  cpu {
    cores = var.vcpu_number
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = var.memory
  }

  network_device {
    bridge = local.my_bridge
  }


  initialization {
    datastore_id = local.ubuntu_vm_datastore_id
    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id


    user_account {
      username = var.user_account_username
      keys = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }


  disk {
    datastore_id = local.ubuntu_vm_datastore_id
    file_id      = local.disk_iso
    interface    = local.disk_interface
    iothread     = true
    discard      = "on"
    size         = var.size_disk
  }

  stop_on_destroy = true
}


resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = local.data_cloud_config_datastore_id
  node_name    = local.my_node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: test-ubuntu
    users:
      - default
      - name: ubuntu
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools
        - timedatectl set-timezone America/Toronto
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = local.data_cloud_config_filename
  }
}
