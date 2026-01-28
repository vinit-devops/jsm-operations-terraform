output "id" {
  description = "ID of the email integration"
  value       = try(atlassian-operations_email_integration.this[0].id, null)
}

output "name" {
  description = "Name of the email integration"
  value       = try(atlassian-operations_email_integration.this[0].name, null)
}
