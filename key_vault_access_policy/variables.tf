variable "key_vault_id" { type = string }
variable "tenant_id" { type = string }
variable "object_id" { type = string }

variable "key_permissions" {
  type    = list(string)
  default = []
}

variable "secret_permissions" {
  type    = list(string)
  default = []
}