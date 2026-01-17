output "id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kube_admin_config_raw" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive = true
}

output "kube_config_raw" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "private_fqdn" {
  value = azurerm_kubernetes_cluster.aks.private_fqdn
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}