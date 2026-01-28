output "id" {
  description = "ID of the API integration"
  value       = try(atlassian-operations_api_integration.this[0].id, null)
}

# API key is only available at creation time (sensitive)
output "api_key" {
  description = "API key for the integration (only after first create)"
  value       = try(atlassian-operations_api_integration.this[0].api_key, null)
  sensitive   = true
}

# Convenience pass-throughs
output "name" {
  description = "Name of the API integration"
  value       = try(atlassian-operations_api_integration.this[0].name, null)
}

output "type" {
  description = "Type of the API integration"
  value       = try(atlassian-operations_api_integration.this[0].type, null)
}
