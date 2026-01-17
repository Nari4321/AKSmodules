variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "sku_name" { type = string }
variable "tenant_id" { type = string }
variable "enabled_for_deployment" {
  type    = bool
  default = true
}
variable "tags" {
  type    = map(string)
  default = {}
}