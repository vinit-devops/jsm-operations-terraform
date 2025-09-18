output "id" {
  description = "Integration action ID."
  value       = atlassian-operations_integration_action.this.id
}

output "name" {
  description = "Integration action name."
  value       = atlassian-operations_integration_action.this.name
}

output "integration_id" {
  description = "Integration ID this action belongs to."
  value       = atlassian-operations_integration_action.this.integration_id
}
