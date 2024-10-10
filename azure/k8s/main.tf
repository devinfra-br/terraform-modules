# Generates a random name for resources
resource "random_pet" "aksrandom_pet" {}

resource "random_id" "aksrandom_id" {
  byte_length = 8
}

# Get the latest available version of AKS
data "azurerm_kubernetes_service_versions" "current" {
  location        = var.default_location
  include_preview = false
}

data "azurerm_client_config" "current" {}

# Create the Log Analytics Workspace for monitoring AKS
resource "azurerm_log_analytics_workspace" "insights" {
  name                                    = "logs-${random_pet.aksrandom_pet.id}-${var.project}-${var.environment}"
  location                                = var.default_location
  resource_group_name                     = var.resource_group_name
  #sku                                     = "free"
  retention_in_days                       = var.logs_retention_days
  immediate_data_purge_on_30_days_enabled = true
  tags                                    = var.tags
}

# Create the Administrators group in Azure AD
resource "azuread_group" "aks_administrators" {
  display_name     = "${var.project}-admin"
  security_enabled = true
}

# Role Assignment for the AKS administrators group
resource "azurerm_role_assignment" "aks_admin_assignment" {
  principal_id         = azuread_group.aks_administrators.object_id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  scope                = azurerm_kubernetes_cluster.aks_cluster.id
}

# AKS cluster creation
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${var.project}-${var.environment}-cluster-1"
  location            = var.default_location
  resource_group_name = var.resource_group_name
  #open_service_mesh_enabled = true
  #cost_analysis_enabled     = true
  dns_prefix          = "${var.project}-${var.environment}-cluster"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.project}-${var.environment}-nrg"


  default_node_pool {
    name                  = "system"
    vm_size               = var.vm_size
    orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
    vnet_subnet_id        = var.subnet_id
    enable_auto_scaling   = true
    max_count             = var.max_node_count
    min_count             = var.min_node_count
    os_disk_size_gb       = var.os_disk_size_gb
    enable_node_public_ip = false
    type                  = "VirtualMachineScaleSets"
    node_labels           = var.node_labels
    tags                  = var.tags
  }

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  # Managed Identity (SystemAssigned)
  identity {
    type = "SystemAssigned"
  }

  # Monitoring with Log Analytics
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id

  }

  # Network profile with standard load balancer
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
  tags = var.tags
}

# Create the AKS node pools
resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
  for_each              = var.node_pools
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  max_count             = each.value.max_count
  min_count             = each.value.min_count
  enable_auto_scaling   = each.value.enable_auto_scaling
  node_count            = each.value.node_count
  vnet_subnet_id        = var.subnet_id
  mode                  = "User"
  name                  = each.key
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_type               = "Linux"
  vm_size               = each.value.vm_size
  node_labels           = each.value.node_labels
  tags                  = each.value.tags
}

# Create the Network Security Group for the AKS
resource "azurerm_network_security_group" "this" {
  location            = var.default_location
  name                = "${var.project}-${random_id.aksrandom_id.hex}-nsg"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Create the Network Security Group Rule for the AKS
resource "azurerm_route_table" "rt1" {
  location            = var.default_location
  name                = "${var.project}-${random_id.aksrandom_id.hex}-rt"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Create the Network Security Group Rule for the AKS
resource "azurerm_network_security_group" "aks" {
  name                = "securityGroupAksDefault"
  location            = var.default_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Create the Network Security Group Rule for the AKS
resource "azurerm_network_security_rule" "aks-outbound" {
  name                        = "aksOutbound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks.name
}

# Create the Network Security Group Rule for the AKS
resource "azurerm_network_security_rule" "aks-inbound" {
  name                        = "aksInbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks.name
}
