resource "azurerm_kubernetes_cluster_node_pool" "this" {
  name                  = var.node_pool_name
  kubernetes_cluster_id = var.aks_cluster_id
  vm_size               = var.vm_size
  node_count            = var.min_count
  min_count             = var.min_count
  max_count             = var.max_count
  enable_auto_scaling   = true
  vnet_subnet_id        = var.vnet_subnet_id
  mode                  = var.mode

  orchestrator_version = null # use cluster version

  tags = var.tags
}