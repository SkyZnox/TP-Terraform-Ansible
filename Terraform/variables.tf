/** Variables of the application **/

variable "name_app" {
  type    = string
  default = "cytech-4-app"
}

variable "size_disk_app" {
  type    = number
  default = 20
}

variable "memory_app" {
  type    = number
  default = 1024
}

variable "vcpu_app" {
  type    = number
  default = 1
}

variable "ipv4_app" {
  type    = string
  default = "192.168.100.126/24"
}

variable "ipv4_gateway_app" {
  type    = string
  default = "192.168.100.1"
}



/** Variables of the database **/

variable "name_bdd" {
  type    = string
  default = "cytech-4-bdd"
}

variable "size_disk_bdd" {
  type    = number
  default = 20
}

variable "memory_bdd" {
  type    = number
  default = 2048
}

variable "vcpu_bdd" {
  type    = number
  default = 1
}

variable "ipv4_bdd" {
  type    = string
  default = "192.168.100.127/24"
}

variable "ipv4_gateway_bdd" {
  type    = string
  default = "192.168.100.1"
}

/** Variables for both modules **/

variable "ssh_public_key" {
  type    = string
  default = "/home/cytech/.ssh/id_ed25519.pub"
}

variable "user_account_username" {
  type    = string
  default = "ubuntu"
}


