output "kubernetes_cluster_name" {
  description = "Cluster AKS name"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "kubernetes_cluster_id" {
  description = "ID cluster AKS"
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}

output "kube_config" {
  description = "Configuration file kubectl do AKS"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}

output "log_analytics_workspace_id" {
  description = "ID Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.insights.id
}