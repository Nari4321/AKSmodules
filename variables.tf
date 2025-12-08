
variable "resource_group_name" {}
variable "location" {}
variable "aks_name" {}
variable "dns_prefix" {}
variable "node_count" { type = number }
variable "vm_size" {}
# Backend variables
variable "backend_rg" {}
variable "backend_sa" {}
variable "backend_container" {}