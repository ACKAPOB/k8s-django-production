variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Folder ID"
  type        = string
}

variable "public_key_path" {
  description = "Path to SSH public key"
  default     = "~/.ssh/id_ed25519.pub"
}

variable "vm_username" {
  description = "User for VM access"
  default     = "ubuntu"
}

variable "vm_image_id" {
  description = "ubuntu-24-04-lts-v20250630"
  default     = "fd81gsj7pb9oi8ks3cvo"
}
