########################################
# Client info
########################################

data "azurerm_client_config" "current" {}

########################################
# Resource Group
########################################

module "rg" {
  source   = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/resource_group?ref=main"
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}

########################################
# Virtual Network
########################################

module "vnet" {
  source = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/vnet?ref=main"
  name                = "vnet-aks-${var.env_name}"
  location            = module.rg.location
  resource_group_name = module.rg.name
  address_space       = ["10.10.0.0/16"]

  tags = var.tags
}

########################################
# Subnet (AKS)
########################################

module "subnet_aks" {
  source = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/subnet?ref=main"
  name                 = "snet-aks-${var.env_name}"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

########################################
# Log Analytics Workspace
########################################

module "law" {
  source = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/log_analytics_workspace?ref=main"
  name                = "law-aks-${var.env_name}"
  location            = module.rg.location
  resource_group_name = module.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

########################################
# Log Analytics Solution
########################################

module "las" {
  source = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/log_analytics_solution?ref=main"
  solution_name         = "Containers"
  location              = module.rg.location
  resource_group_name   = module.rg.name
  workspace_name        = module.law.name
  workspace_resource_id = module.law.id
  plan_publisher        = "Microsoft"
  plan_product          = "OMSGallery/Containers"
}

########################################
# Azure Container Registry
########################################

module "acr" {
  source = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/acr?ref=main"
  name                = var.acr_name
  location            = module.rg.location
  resource_group_name = module.rg.name
  sku                 = var.acr_sku
  admin_enabled       = false
  tags                = var.tags
}

########################################
# Key Vault
########################################

module "kv" {
  source = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/key_vault?ref=main"
  name                = var.key_vault_name
  location            = module.rg.location
  resource_group_name = module.rg.name
  sku_name            = var.key_vault_sku
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

########################################
# AKS Cluster
########################################

module "aks" {
  source = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/aks?ref=main"
  name                = "aks-${var.env_name}"
  location            = module.rg.location
  resource_group_name = module.rg.name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = "aks-${var.env_name}"

  system_nodepool_name      = "systemnp"
  system_nodepool_vm_size   = var.system_vm_size
  system_nodepool_min_count = var.system_min_count
  system_nodepool_max_count = var.system_max_count

  vnet_subnet_id             = module.subnet_aks.id
  log_analytics_workspace_id = module.law.id

  tags = var.tags
}

########################################
# AKS User Node Pool
########################################

module "aks_user_np" {
  source = "git::https://dev.azure.com/puranamratna2000/AKS_Project/_git/tf_az_modules//module/aks_nodepool?ref=main"
  aks_cluster_id      = module.aks.id
  aks_cluster_name    = module.aks.name
  resource_group_name = module.rg.name

  node_pool_name = "usernp1"
  vm_size        = var.user_vm_size
  min_count      = var.user_min_count
  max_count      = var.user_max_count
  vnet_subnet_id = module.subnet_aks.id

  tags = var.tags
}

########################################
# ACR Pull Role Assignment
########################################

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
}
