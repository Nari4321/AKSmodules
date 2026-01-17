resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  kubernetes_version = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = var.system_nodepool_name
    node_count          = var.system_nodepool_min_count
    min_count           = var.system_nodepool_min_count
    max_count           = var.system_nodepool_max_count
    vm_size             = var.system_nodepool_vm_size
    vnet_subnet_id      = var.vnet_subnet_id
    orchestrator_version = var.kubernetes_version
    enable_auto_scaling = true
   # mode                = "System"
  }

  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  azure_policy_enabled = var.enable_azure_policy

  key_vault_secrets_provider {
    secret_rotation_enabled  = var.enable_key_vault_secrets_provider
    secret_rotation_interval = "2m"
  }

  role_based_access_control_enabled = true

  tags = var.tags
}
