variable "aks_cluster_id" { type = string }
variable "aks_cluster_name" { type = string }
variable "resource_group_name" { type = string }

variable "node_pool_name" { type = string }
variable "vm_size" { type = string }
variable "min_count" { type = number }
variable "max_count" { type = number }
variable "mode" {
  type    = string
  default = "User"
}
variable "vnet_subnet_id" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}