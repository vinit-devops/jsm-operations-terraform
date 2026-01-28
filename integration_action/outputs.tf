output "id" {
  description = "ID of the integration action"
  value       = try(atlassian-operations_integration_action.this[0].id, null)
}

output "name" {
  description = "Name of the integration action"
  value       = try(atlassian-operations_integration_action.this[0].name, null)
}

output "integration_id" {
  description = "ID of the integration this action belongs to"
  value       = try(atlassian-operations_integration_action.this[0].integration_id, null)
}
