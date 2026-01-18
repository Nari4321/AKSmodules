variable "env_name" {
  description = "Environment name (prod, npd, uat, etc.)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "rg_name" {
  description = "Resource group for AKS and related resources"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

# AKS config
variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
}

variable "system_vm_size" {
  type        = string
  default     = "Standard_DC4s_v3"
}

variable "system_min_count" {
  type    = number
  default = 1
}

variable "system_max_count" {
  type    = number
  default = 3
}

# user nodepool
variable "user_vm_size" {
  type        = string
  default     = "Standard_DC4s_v3"
}

variable "user_min_count" {
  type    = number
  default = 1
}

variable "user_max_count" {
  type    = number
  default = 3
}

# ACR
variable "acr_name" {
  description = "ACR name"
  type        = string
}

variable "acr_sku" {
  type    = string
  default = "Premium"
}

# Key Vault
variable "key_vault_name" {
  description = "Key vault name"
  type        = string
}

variable "key_vault_sku" {
  description = "Key vault SKU"
  type        = string
  default     = "standard"
}

# Key Vault access principals (object IDs in AAD)
variable "kva_object_id_terraform" {
  description = "Object ID of Terraform/service principal (for admin access)"
  type        = string
}

variable "kva_object_id1" {
  description = "Object ID 1 for KV access"
  type        = string
}

variable "kva_object_id2" {
  description = "Object ID 2 for KV access"
  type        = string
}

variable "kva_object_id3" {
  description = "Object ID 3 for KV access"
  type        = string
}