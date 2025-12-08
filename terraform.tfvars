
resource_group_name = "rg-aks-demo"
location            = "East US"
aks_name            = "demo-aks-cluster"
dns_prefix          = "demoprefix"
node_count          = 2
vm_size             = "Standard_DS2_v2"
# Backend storage (auto-created)
backend_rg         = "rg-aks-demo"
backend_sa         = "aksdemostorage004"
backend_container  = "aksdemotfstate"