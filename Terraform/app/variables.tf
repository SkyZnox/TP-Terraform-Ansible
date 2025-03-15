variable "name" {
  type    = string
}

variable "ipv4_address" {
  type = string
}

variable "ipv4_gateway" {
  type = string
}

variable "memory" {
  type = number
}

variable "size_disk" {
  type = number
}

variable "vcpu_number" {
  type = number
}

variable "ssh_public_key_filename" {
  type = string
}

variable "user_account_username" {
  type = string
}
