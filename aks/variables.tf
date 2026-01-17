variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }

variable "kubernetes_version" { type = string }

variable "dns_prefix" { type = string }

variable "system_nodepool_name" { type = string }
variable "system_nodepool_vm_size" { type = string }
variable "system_nodepool_min_count" { type = number }
variable "system_nodepool_max_count" { type = number }

variable "vnet_subnet_id" { type = string }

variable "log_analytics_workspace_id" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}

variable "network_plugin" {
  type    = string
  default = "azure"
}

variable "network_policy" {
  type    = string
  default = "azure"
}

variable "enable_azure_policy" {
  type    = bool
  default = true
}

variable "enable_key_vault_secrets_provider" {
  type    = bool
  default = true
}
