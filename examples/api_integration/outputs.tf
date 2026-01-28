output "integration_id" {
  description = "ID of the created API integration"
  value       = module.api_integration.id
}

output "integration_api_key" {
  description = "API key for the integration (sensitive)"
  value       = module.api_integration.api_key
  sensitive   = true
}
