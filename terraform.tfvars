env_name        = "prod"
location        = "eastus"
rg_name         = "rg-aks-prod"



kubernetes_version = "1.33.5"

acr_name = "prodacr1140"
acr_sku  = "Premium"

key_vault_name = "kv-aks-prod-1234"

# These are AAD object IDs for SPs or users
kva_object_id_terraform = "00000000-1111-2222-3333-444444444444"
kva_object_id1          = "11111111-2222-3333-4444-555555555555"
kva_object_id2          = "22222222-3333-4444-5555-666666666666"
kva_object_id3          = "33333333-4444-5555-6666-777777777777"

tags = {
  environment = "prod"
  owner       = "platform-team"
}