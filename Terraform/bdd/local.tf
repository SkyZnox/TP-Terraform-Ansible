locals {
  my_bridge                      = "vmbr0"
  my_pool_id                     = "cytech"
  my_node_name                   = "mgmt"
  disk_iso                       = "isos:iso/jammy-server-cloudimg-amd64.img"
  disk_interface                 = "virtio0"
  ubuntu_vm_datastore_id         = "raid-ssd"
  data_cloud_config_filename     = "user-data-cloud-config-cytech-4-bdd.yaml"
  data_cloud_config_datastore_id = "local"

}