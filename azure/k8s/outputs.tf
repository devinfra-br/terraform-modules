output "kubernetes_cluster_name" {
  description = "Nome do cluster AKS"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "kubernetes_cluster_id" {
  description = "ID do cluster AKS"
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}

output "kube_config" {
  description = "Arquivo de configuração kubectl do AKS"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}

output "log_analytics_workspace_id" {
  description = "ID do Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.insights.id
}